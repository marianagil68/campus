from flask import Blueprint, render_template
from src.services.cursoservice import CursoService


home_controller = Blueprint("home_controller", __name__)

curso_service = CursoService()


@home_controller.route("/")
def inicio():
    cursos = curso_service.obtener_cursos_disponibles()
    return render_template("index.html", cursos=cursos)