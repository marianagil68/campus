# Paso a paso del desarrollo

## 1. Creación de la estructura del proyecto

Se creó la carpeta principal del proyecto:

campus

Se crearon las carpetas:

- docs
- sql
- src
- static
- templates
- tests

Se crearon los archivos iniciales:

- README.md
- requirements.txt
- .gitignore

## 2. Base de datos PostgreSQL en Docker

Se definió el nombre de la base:

campus

Se definió el contenedor:

campus_postgres

Se definió el volumen persistente:

campus_data

Comandos:

```powershell
docker volume create campus_data

## 3. Conexión desde pgAdmin

Se agregó una conexión en pgAdmin al PostgreSQL ejecutado en Docker.

Datos de conexión:

- Name: campus_postgres
- Host name/address: localhost
- Port: 5432
- Maintenance database: campus
- Username: campus
- Password: campus123

Una vez creada la conexión, se selecciona la base `campus` y se usa el Query Tool para ejecutar scripts SQL.

## 4. Creación del esquema y las tablas

Se creó el esquema:

campus

Todas las tablas de la aplicación se almacenarán en dicho esquema.

Se ejecutó el script:

sql\01-creacion.sql

Tablas creadas:

- roles
- usuarios
- cursos
- clases
- inscripciones
- pagos
- avanceclases


## 5. Carga de datos iniciales

Se creó el script:

sql\02-datosiniciales.sql

El script carga:

- Roles iniciales.
- Tipos de materiales.
- Configuraciones básicas del sistema.
