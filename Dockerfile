FROM python:2.7.15-alpine3.6

COPY requirements.txt /app/requirements.txt
WORKDIR /app
RUN pip install -r requirements.txt

COPY sshd_config /etc/ssh/

RUN apk --update add g++ \
    libffi-dev \
    openssl-dev \
    openssh \
    openrc \
    bash 

COPY . /app

RUN chmod 755 /app/init_container.sh

EXPOSE 5000 2222

CMD ["python", "runserver.py"] 