FROM python:2.7.15-alpine3.6

ENV HOST 0.0.0.0
WORKDIR /app
COPY . /app
COPY sshd_config /etc/ssh/

EXPOSE 5000 2222

RUN apk --update add g++ \
    libffi-dev \
    openssl-dev \
    openssh \
    openrc \
    bash \
    && chmod 755 /app/init_container.sh

RUN pip install -r requirements.txt
CMD ["python", "runserver.py"] 