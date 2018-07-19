from flask import Flask
import os
app = Flask(__name__)

@app.route("/")
def hello():
    output = ""
    for param in os.environ.keys():
        output+="%20s %s <br/>" % (param,os.environ[param])
    return output

if __name__ == "__main__":
    app.run(port=5000)