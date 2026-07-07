# Arquitectura

## Tecnologías

- Python
- PostgreSQL
- Docker
- HTML5
- CSS3

## Arquitectura

Cliente
↓

Aplicación Python

↓

PostgreSQL

# Arquitectura del proyecto

## Estructura de directorios

```text
campus
│
├── docs
│   ├── 00-paso-a-paso.md
│   ├── 01-vision.md
│   ├── 02-arquitectura.md
│   ├── 03-basededatos.md
│   ├── 04-backend.md
│   ├── 05-frontend.md
│   ├── 06-despliegue.md
│   └── decisiones.md
│
├── sql
│   ├── 01-creacion.sql
│   └── 02-datosiniciales.sql
│
├── src
│   ├── main.py
│   ├── config.py
│   ├── database.py
│   │
│   ├── repositories
│   │   └── __init__.py
│   │
│   ├── controllers
│   │   └── __init__.py
│   │
│   ├── services
│   │   └── __init__.py
│   │
│   └── utils
│       └── __init__.py
│
├── static
│   ├── css
│   ├── js
│   └── img
│
├── templates
│   └── layouts
│
├── tests
│
├── README.md
├── requirements.txt
└── .gitignore
```

---

# Descripción de la estructura

## docs

Contiene toda la documentación del proyecto.

### 00-paso-a-paso.md

Registro cronológico de todas las tareas realizadas durante el desarrollo del sistema.

### 01-vision.md

Objetivos del proyecto, alcance y funcionalidades previstas.

### 02-arquitectura.md

Arquitectura de la aplicación, organización de carpetas y decisiones estructurales.

### 03-basededatos.md

Documentación del modelo de datos, convenciones y estructura de la base.

### 04-backend.md

Documentación del backend desarrollado en Python.

### 05-frontend.md

Documentación de la interfaz de usuario.

### 06-despliegue.md

Procedimiento de publicación y despliegue de la aplicación.

### decisiones.md

Registro de todas las decisiones de arquitectura tomadas durante el proyecto.

---

## sql

Contiene todos los scripts SQL utilizados para crear y mantener la base de datos.

Los scripts se ejecutan desde pgAdmin y forman parte del control de versiones del proyecto.

---

## src

Contiene todo el código fuente de la aplicación.

---

## main.py

Punto de entrada de la aplicación.

Inicializa la aplicación, carga la configuración y pone en marcha el servidor web.

---

## config.py

Centraliza toda la configuración del proyecto.

Por ejemplo:

- conexión a PostgreSQL
- parámetros generales
- configuración de la aplicación
- variables de entorno

---

## database.py

Responsable de administrar la conexión con PostgreSQL.

Toda la aplicación utilizará este módulo para acceder a la base de datos.

---

## repositories

Contiene el acceso a los datos.

Cada repositorio será responsable de realizar las consultas SQL correspondientes a una entidad.

Ejemplos:

- usuarios
- cursos
- pagos
- cuestionarios

---

## controllers

Reciben las solicitudes HTTP, invocan la lógica de negocio y devuelven la respuesta correspondiente.

No contienen reglas de negocio ni consultas SQL.

---

## services

Implementan la lógica de negocio de la aplicación.

Aquí se desarrollarán procesos como:

- autenticación
- inscripción a cursos
- emisión de certificados
- cálculo de resultados de cuestionarios
- procesamiento de pagos

---

## utils

Funciones auxiliares reutilizables por toda la aplicación.

Ejemplos:

- validaciones
- manejo de fechas
- generación de códigos
- utilidades varias

---

## static

Contiene todos los recursos estáticos utilizados por la aplicación.

### css

Hojas de estilo.

### js

Código JavaScript.

### img

Imágenes del sistema.

---

## templates

Plantillas HTML de la aplicación.

### layouts

Plantillas base reutilizables por las distintas páginas.

---

## tests

Pruebas automáticas del sistema.

Aquí se almacenarán las pruebas unitarias y de integración.

---

## README.md

Descripción general del proyecto.

Incluye información para instalar y ejecutar la aplicación.

---

## requirements.txt

Listado de dependencias de Python necesarias para ejecutar el proyecto.

---

## .gitignore

Define los archivos y carpetas que Git no debe versionar.