# Bitácora de desarrollo

---

# Fase 1 - Diseño del proyecto

## Paso 1.1 - Creación de la estructura del proyecto

### Objetivo

Crear la estructura inicial del proyecto y organizar la documentación, los scripts SQL y el código fuente.

### Comandos ejecutados

```powershell
mkdir campus
cd campus

mkdir docs
mkdir sql
mkdir src
mkdir static
mkdir templates
mkdir tests

New-Item docs\00-paso-a-paso.md -ItemType File
New-Item docs\01-vision.md -ItemType File
New-Item docs\02-arquitectura.md -ItemType File
New-Item docs\03-basededatos.md -ItemType File
New-Item docs\04-backend.md -ItemType File
New-Item docs\05-frontend.md -ItemType File
New-Item docs\06-despliegue.md -ItemType File
New-Item docs\decisiones.md -ItemType File

New-Item sql\01-creacion.sql -ItemType File
New-Item sql\02-datosiniciales.sql -ItemType File

New-Item README.md -ItemType File
New-Item requirements.txt -ItemType File
New-Item .gitignore -ItemType File
```

### Resultado

Se creó la estructura inicial del proyecto.

---

## Paso 1.2 - Creación de PostgreSQL en Docker

### Objetivo

Crear un contenedor PostgreSQL con almacenamiento persistente.

### Comandos ejecutados

Crear el volumen:

```powershell
docker volume create campus_data
```

Crear el contenedor:

```powershell
docker run --name campus_postgres `
  -e POSTGRES_USER=campus `
  -e POSTGRES_PASSWORD=campus123 `
  -e POSTGRES_DB=campus `
  -v campus_data:/var/lib/postgresql/data `
  -p 5432:5432 `
  -d postgres:16
```

### Resultado

Se creó:

- volumen `campus_data`
- contenedor `campus_postgres`
- base de datos `campus`

---

## Paso 1.3 - Conexión desde pgAdmin

### Objetivo

Administrar PostgreSQL mediante pgAdmin.

### Datos de conexión

```
Name: campus_postgres
Host: localhost
Port: 5432
Database: campus
User: campus
Password: campus123
```

---

## Paso 1.4 - Creación del esquema y las tablas

### Objetivo

Crear el esquema `campus` y todas las tablas de la aplicación.

### Archivo

```
sql\01-creacion.sql
```

### Resultado

Se creó el esquema:

```
campus
```

Y las tablas:

- roles
- usuarios
- cursos
- clases
- tiposmateriales
- materiales
- inscripciones
- pagos
- avanceclases
- cuestionarios
- preguntas
- opcionesrespuestas
- intentoscuestionarios
- respuestascuestionarios
- certificados
- configuraciones

---

## Paso 1.5 - Datos iniciales

### Objetivo

Cargar la información básica necesaria para comenzar el desarrollo.

### Archivo

```
sql\02-datosiniciales.sql
```

### Resultado

Se cargaron:

- Roles
- Tipos de materiales
- Configuraciones iniciales

---

# Fase 2 - Control de versiones

## Paso 2.1 - Creación del repositorio GitHub

Repositorio creado:

```
https://github.com/marianagil68/campus
```

Tipo:

```
Privado
```

---

## Paso 2.2 - Inicialización de Git

### Comandos

```powershell
git init
```

Verificación:

```powershell
git status
```

Cambio de rama:

```powershell
git branch -M main
```

Verificación:

```powershell
git status
```

Resultado esperado:

```
On branch main
```

---

## Paso 2.3 - Configuración de .gitignore

Se creó el archivo:

```
.gitignore
```

para excluir del repositorio:

- entorno virtual
- archivos temporales
- caché de Python
- archivos del sistema operativo

---

## Paso 2.4 - Primer commit

Agregar archivos:

```powershell
git add .
```

Verificación:

```powershell
git status
```

Configuración de usuario (solo la primera vez):

```powershell
git config --global user.name "Mariana Gil"
git config --global user.email "TU_EMAIL"
```

Commit:

```powershell
git commit -m "Inicialización del proyecto Campus"
```

---

## Paso 2.5 - Vinculación con GitHub

Agregar remoto:

```powershell
git remote add origin https://github.com/marianagil68/campus.git
```

Verificación:

```powershell
git remote -v
```

---

## Paso 2.6 - Publicación del proyecto

Primer push:

```powershell
git push -u origin main
```

Resultado esperado:

```
[new branch] main -> main
branch 'main' set up to track 'origin/main'
```

A partir de este momento, para publicar cambios solo será necesario ejecutar:

```powershell
git add .
git commit -m "Descripción del cambio"
git push
```

---

# Fase 3 - Desarrollo del Backend

## Paso 3.1 - Creación del entorno virtual

### Objetivo

Crear un entorno virtual independiente para el proyecto.

### Comandos

Crear el entorno:

```powershell
python -m venv venv
```

Activarlo:

```powershell
.\venv\Scripts\Activate.ps1
```

### Configuración de VS Code

Al detectar el entorno virtual, Visual Studio Code preguntó si debía utilizarlo como intérprete del proyecto.

Se respondió:

```
Sí
```

Resultado esperado:

```
(venv)
```

---

## Paso 3.2 - Instalación de Flask

### Objetivo

Instalar el framework Flask.

### Comandos

Instalación:

```powershell
pip install flask
```

Verificación:

```powershell
pip show flask
```

Registrar dependencias:

```powershell
pip freeze > requirements.txt
```

### Resultado

Flask quedó instalado correctamente y todas las dependencias fueron registradas en `requirements.txt`.

---

## Paso 3.3 - Primera aplicación Flask

### Objetivo

Crear la primera aplicación web.

### Archivo

```
src/main.py
```

### Funcionalidad

Crear un servidor web local que responda en la URL raíz (`/`) mostrando el mensaje:

```
Bienvenido a Campus
```

### Observación

Durante el desarrollo se utilizará:

```python
app.run(debug=True)
```

para reiniciar automáticamente la aplicación y mostrar información detallada en caso de error.

## Paso 3.4 - Primera versión de la arquitectura del backend

### Objetivo

Organizar el proyecto utilizando una arquitectura por capas y separar las responsabilidades de la aplicación.

### Cambios realizados

- Se creó `app.py` como punto de entrada de la aplicación.
- Se implementó la primera versión de la arquitectura:
  - Controllers
  - Services
  - Repositories
- Se creó el primer controlador (`HomeController`).
- Se creó el primer servicio (`CursoService`).
- Se creó el primer repositorio (`CursoRepository`).
- El repositorio devuelve datos simulados para desacoplar el frontend de la base de datos.
- Se incorporó Jinja2 para generar dinámicamente las tarjetas de cursos.
- Se reorganizaron las carpetas `templates` y `static` en la raíz del proyecto.
- Se creó un layout base reutilizable con Bootstrap.

### Commit realizado

```text
Fase 3 - Implementación de la arquitectura inicial del backend
```

## Paso 4.1 - Preparación de la capa de acceso a datos

### Objetivo

Preparar la infraestructura para conectar la aplicación con PostgreSQL utilizando SQLAlchemy.

### Actividades realizadas

- Se evaluaron distintas alternativas para el acceso a datos.
- Se descartó el uso directo de `psycopg2`.
- Se decidió utilizar SQLAlchemy Core junto con el driver `psycopg`.
- Se instaló SQLAlchemy.
- Se instaló el driver `psycopg` con soporte binario.
- Se creó la clase `Database`.
- Se implementó el primer método de prueba de conexión (`SELECT 1`).

### Comandos ejecutados

```powershell
pip uninstall psycopg2-binary
```

```powershell
pip install sqlalchemy
```

```powershell
pip install "psycopg[binary]"
```

```powershell
pip freeze > requirements.txt
```

### Verificación

Se creó el módulo:

```
tests/test_database.py
```

y se ejecutó mediante:

```powershell
python -m tests.test_database
```

Obteniendo como resultado:

```
Resultado: 1
```

confirmando la conexión correcta con PostgreSQL.

## Paso 4.2 - Configuración del acceso a PostgreSQL

### Objetivo

Configurar el proyecto para conectarse a PostgreSQL de forma segura y desacoplada del código fuente.

### Actividades realizadas

- Se decidió no almacenar la cadena de conexión completa en el código.
- Se creó un archivo `.env` para almacenar la configuración de la base de datos.
- Se instalaron las bibliotecas necesarias para administrar la configuración y la conexión a PostgreSQL.
- Se creó la clase `Config` para centralizar la lectura de variables de entorno.
- Se modificó la clase `Database` para construir la URL de conexión utilizando `sqlalchemy.engine.URL.create()`.
- Se verificó correctamente la conexión ejecutando `SELECT 1`.

### Archivo `.env`

```env
DB_DRIVER=postgresql+psycopg
DB_HOST=localhost
DB_PORT=5432
DB_NAME=campus
DB_USER=campus
DB_PASSWORD=********
```

> **Nota:** En la documentación no se almacenan credenciales reales. Cada desarrollador deberá completar los valores correspondientes en su entorno.

### Comandos ejecutados

```powershell
pip install python-dotenv
```

```powershell
pip install sqlalchemy
```

```powershell
pip install "psycopg[binary]"
```

```powershell
pip freeze > requirements.txt
```

### Prueba realizada

Se ejecutó el módulo:

```powershell
python -m tests.test_database
```

Resultado esperado:

```text
Resultado: 1
```

confirmando la conectividad con PostgreSQL.