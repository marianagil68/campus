class CursoRepository:

    def obtener_todos(self):
        return [
            {
                "cursoid": 1,
                "titulo": "Auxiliar de la Justicia",
                "descripcion": "Curso introductorio para quienes se desempeñan como auxiliares en el ámbito judicial."
            },
            {
                "cursoid": 2,
                "titulo": "Segundo curso",
                "descripcion": "Espacio reservado para una segunda capacitación."
            }
        ]