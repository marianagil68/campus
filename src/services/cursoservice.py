from src.repositories.cursorepository import CursoRepository


class CursoService:

    def __init__(self):
        self.curso_repository = CursoRepository()

    def obtener_cursos_disponibles(self):
        return self.curso_repository.obtener_todos()