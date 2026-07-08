import os
from dotenv import load_dotenv

load_dotenv()

class Config:

    DB_DRIVER = os.getenv("DB_DRIVER")
    DB_HOST = os.getenv("DB_HOST")
    DB_PORT = int(os.getenv("DB_PORT", "5432"))
    DB_NAME = os.getenv("DB_NAME")
    DB_USER = os.getenv("DB_USER")
    DB_PASSWORD = os.getenv("DB_PASSWORD")

    @classmethod
    def validar(cls):

        variables = [
            "DB_DRIVER",
            "DB_HOST",
            "DB_PORT",
            "DB_NAME",
            "DB_USER",
            "DB_PASSWORD"
        ]

        faltantes = []

        for variable in variables:
            if getattr(cls, variable) in (None, ""):
                faltantes.append(variable)

        if faltantes:
            raise ValueError(
                "Faltan las siguientes variables de entorno: "
                + ", ".join(faltantes)
            )