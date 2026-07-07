# Decisiones del proyecto

## 2026-07-07

Se utilizará PostgreSQL 16.

La base de datos se llamará:

campus

## Decisión: uso de esquema

Se decidió crear un esquema llamado `campus` para guardar las tablas propias del sistema.

No se utilizará el esquema `public` para las tablas de la aplicación.

Las tablas se nombrarán en plural.

Los campos se nombrarán en singular.

Las claves primarias seguirán la convención:

usuarioid

cursoid

rolid

Las claves foráneas tendrán el mismo nombre que la clave primaria referenciada.

Se utilizará Docker para ejecutar PostgreSQL.

Visual Studio Code será el entorno de desarrollo.