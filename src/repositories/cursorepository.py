from sqlalchemy import text

from src.database import Database
from src.models.curso import Curso

class CursoRepository:
    def __init__(self):
        self.database = Database()

    def obtener_todos(self):

        sql = text("""
            SELECT
                cursoid,
                titulo,
                descripcion
            FROM campus.cursos
            WHERE activo = true
            ORDER BY titulo;
        """)

        with self.database.engine.connect() as conexion:

            resultado = conexion.execute(sql)

            cursos = []

            for fila in resultado:

                curso = Curso(
                    cursoid=fila.cursoid,
                    titulo=fila.titulo,
                    descripcion=fila.descripcion,
                )

                cursos.append(curso)

        return cursos