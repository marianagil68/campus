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

# Fase 3 - Desarrollo del Backend

## Paso 3.1 - Creación del entorno virtual

### Objetivo

Crear un entorno virtual independiente para administrar las dependencias del proyecto.

### Comandos ejecutados

Crear el entorno virtual:

```powershell
python -m venv venv
```

### Configuración de Visual Studio Code

Al detectar la creación del entorno virtual, Visual Studio Code preguntó si debía utilizar dicho entorno como intérprete de Python para el proyecto.

Se seleccionó la opción:

```
Sí
```

De esta manera, todas las ejecuciones, depuración e instalación de dependencias se realizarán utilizando el entorno virtual del proyecto.

Activarlo en PowerShell:

```powershell
.\venv\Scripts\Activate.ps1
```

### Resultado esperado

La terminal muestra el prefijo:

```text
(venv)
```

indicando que todas las dependencias que se instalen a partir de ese momento pertenecerán exclusivamente al proyecto.