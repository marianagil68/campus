from sqlalchemy import create_engine, text
from sqlalchemy.engine import URL

from src.config import Config

class Database:
    _engine = None

class Database:

    _engine = None

    def __init__(self):
        Config.validar()
        
        if Database._engine is None:
            database_url = URL.create(
                drivername=Config.DB_DRIVER,
                username=Config.DB_USER,
                password=Config.DB_PASSWORD,
                host=Config.DB_HOST,
                port=Config.DB_PORT,
                database=Config.DB_NAME
            )

            Database._engine = create_engine(database_url)
    @property
    def engine(self):
        return Database._engine

    def probar_conexion(self):
        with self.engine.connect() as conexion:
            resultado = conexion.execute(text("SELECT 1"))
            return resultado.scalar()