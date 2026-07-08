from flask import Flask

from src.controllers.homecontroller import home_controller

app = Flask(__name__)

app.register_blueprint(home_controller)

if __name__ == "__main__":
    app.run(debug=True)