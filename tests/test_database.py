from src.database import Database

db = Database()

resultado = db.probar_conexion()

print("Resultado:", resultado)