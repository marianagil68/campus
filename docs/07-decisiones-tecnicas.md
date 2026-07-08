# Decisiones Técnicas del Proyecto

## Objetivo

Este documento registra las decisiones técnicas y arquitectónicas adoptadas durante el desarrollo del proyecto **Campus**.

Cada decisión posee un identificador único (DT-XXX) para facilitar su referencia desde la documentación técnica, la bitácora de desarrollo y el código fuente.

Cada decisión registra:

- Estado
- Fecha
- Decisión
- Justificación
- Alternativas consideradas (cuando corresponda)

---

# DT-001 - Motor de Base de Datos

| Campo | Valor |
|-------|-------|
| Estado | Vigente |
| Fecha | 2026-07-08 |

## Decisión

Se utilizará PostgreSQL como motor de base de datos.

## Justificación

- Base de datos relacional robusta.
- Excelente implementación del estándar SQL.
- Gratuita y de código abierto.
- Muy utilizada en entornos profesionales.
- Excelente integración con Docker.

---

# DT-002 - Contenerización

| Campo | Valor |
|-------|-------|
| Estado | Vigente |
| Fecha | 2026-07-08 |

## Decisión

PostgreSQL se ejecutará dentro de un contenedor Docker.

## Justificación

- Entorno reproducible.
- Instalación sencilla.
- Independencia del sistema operativo.
- Persistencia mediante volúmenes Docker.

---

# DT-003 - Framework Web

| Campo | Valor |
|-------|-------|
| Estado | Vigente |
| Fecha | 2026-07-08 |

## Decisión

Se utilizará Flask como framework para el desarrollo de la aplicación web.

## Justificación

- Framework liviano.
- Curva de aprendizaje reducida.
- No impone una arquitectura determinada.
- Permite comprender el funcionamiento interno de una aplicación web.

---

# DT-004 - Arquitectura de la Aplicación

| Campo | Valor |
|-------|-------|
| Estado | Vigente |
| Fecha | 2026-07-08 |

## Decisión

La aplicación seguirá una arquitectura por capas.

```
Cliente Web
      │
      ▼
Controllers
      │
      ▼
Services
      │
      ▼
Repositories
      │
      ▼
PostgreSQL
```

## Justificación

- Separación de responsabilidades.
- Bajo acoplamiento.
- Alta cohesión.
- Facilita el mantenimiento.
- Facilita las pruebas.
- Permite reemplazar la fuente de datos sin modificar el resto de la aplicación.

---

# DT-005 - Acceso a Datos

| Campo | Valor |
|-------|-------|
| Estado | Vigente |
| Fecha | 2026-07-08 |

## Decisión

Se utilizará **SQLAlchemy Core** junto con el driver **psycopg**.

Durante la primera versión del proyecto no se utilizará el ORM de SQLAlchemy.

## Justificación

- Mantiene visibles las consultas SQL.
- Aprovecha el conocimiento previo de SQL.
- Proporciona un manejo moderno de conexiones y transacciones.
- Permite incorporar el ORM en el futuro sin modificar la arquitectura.

## Alternativas consideradas

- psycopg2
- SQLAlchemy ORM
- Flask-SQLAlchemy

---

# DT-006 - Modelo de Dominio

| Campo | Valor |
|-------|-------|
| Estado | Vigente |
| Fecha | 2026-07-08 |

## Decisión

Las entidades del dominio se implementarán utilizando `@dataclass`.

## Justificación

- Reduce código repetitivo.
- Mejora la legibilidad.
- Genera automáticamente métodos como `__init__`, `__repr__` y `__eq__`.
- Facilita la evolución futura del modelo.

---

# DT-007 - Responsabilidades del Modelo

| Campo | Valor |
|-------|-------|
| Estado | Vigente |
| Fecha | 2026-07-08 |

## Decisión

Las clases del dominio representan exclusivamente entidades del negocio.

No contendrán lógica de acceso a datos.

## Justificación

El acceso a la base de datos corresponde únicamente a los Repositories.

Ejemplo:

```
Curso
```

representa un curso.

```
CursoRepository
```

es responsable de consultar, insertar, actualizar o eliminar cursos de la base de datos.

---

# DT-008 - Convenciones de Nombres

| Campo | Valor |
|-------|-------|
| Estado | Vigente |
| Fecha | 2026-07-08 |

## Decisión

### Base de datos

- Tablas en plural.
- Columnas en singular.

Ejemplo:

```
cursos
usuarios
inscripciones
pagos
```

### Modelo orientado a objetos

- Clases en singular.

Ejemplo:

```
Curso
Usuario
Inscripcion
Pago
```

## Justificación

Mantener una correspondencia clara entre el modelo relacional y el modelo orientado a objetos.

---

# DT-009 - Organización del Proyecto

| Campo | Valor |
|-------|-------|
| Estado | Vigente |
| Fecha | 2026-07-08 |

## Decisión

El proyecto se organizará con la siguiente estructura principal:

```
app.py
src/
templates/
static/
docs/
sql/
```

## Justificación

Separar claramente:

- punto de entrada de la aplicación;
- lógica de negocio;
- presentación;
- recursos estáticos;
- documentación;
- scripts SQL.

---

# DT-010 - Frontend

| Campo | Valor |
|-------|-------|
| Estado | Vigente |
| Fecha | 2026-07-08 |

## Decisión

Se utilizará Bootstrap 5 como framework CSS.

Durante el desarrollo se cargará mediante CDN.

Antes de la puesta en producción se evaluará incorporarlo localmente dentro del directorio `static/`.

## Justificación

- Reduce el tiempo de desarrollo.
- Diseño responsive.
- Componentes reutilizables.
- Amplia documentación.

---

# DT-011 - Control de Versiones

| Campo | Valor |
|-------|-------|
| Estado | Vigente |
| Fecha | 2026-07-08 |

## Decisión

El proyecto utilizará Git y GitHub.

Cada commit representará una funcionalidad completa y verificable.

## Justificación

- Historial claro.
- Mayor trazabilidad.
- Facilita volver a versiones anteriores.

---

# DT-012 - Desarrollo Incremental

| Campo | Valor |
|-------|-------|
| Estado | Vigente |
| Fecha | 2026-07-08 |

## Decisión

Cada etapa del desarrollo deberá dejar la aplicación funcionando.

## Justificación

- Reduce el riesgo de introducir errores.
- Facilita el aprendizaje.
- Simplifica las pruebas.
- Mantiene el proyecto siempre en un estado ejecutable.

---

# DT-013 - Datos Simulados

| Campo | Valor |
|-------|-------|
| Estado | Vigente |
| Fecha | 2026-07-08 |

## Decisión

Mientras una funcionalidad no esté conectada a PostgreSQL, los Repositories devolverán datos simulados utilizando objetos del dominio.

## Justificación

Permite desarrollar de forma independiente:

- la interfaz de usuario;
- la lógica de negocio;
- el acceso a datos.

Cuando la funcionalidad esté lista, únicamente será necesario reemplazar la implementación del Repository correspondiente.

---

# DT-014 - Ejecución de Módulos Python

| Campo | Valor |
|-------|-------|
| Estado | Vigente |
| Fecha | 2026-07-08 |

## Decisión

Los módulos auxiliares del proyecto, como pruebas, scripts y utilidades, se ejecutarán utilizando la opción `-m` de Python.

Ejemplo:

```powershell
python -m tests.test_database
```
No se ejecutarán directamente cuando dependan de paquetes del proyecto.

# DT-015 - Gestión de la Configuración

| Campo | Valor |
|-------|-------|
| Estado | Vigente |
| Fecha | 2026-07-08 |

## Decisión

La configuración de la aplicación se almacenará en un archivo `.env`.

Las variables se organizarán por componentes mediante prefijos (`DB_`, `APP_`, etc.).

La URL de conexión a PostgreSQL se construirá en el código utilizando `sqlalchemy.engine.URL.create()`.

## Justificación

- Evita almacenar credenciales en el código fuente.
- Mejora la legibilidad de la configuración.
- Facilita cambios de entorno (desarrollo, pruebas, producción).
- Maneja correctamente caracteres especiales en usuarios y contraseñas.
- Centraliza toda la configuración en una única clase (`Config`).

---

# Historial de Decisiones

| Código | Decisión | Estado |
|---------|----------|--------|
| DT-001 | Motor de Base de Datos | Vigente |
| DT-002 | Contenerización | Vigente |
| DT-003 | Framework Web | Vigente |
| DT-004 | Arquitectura por capas | Vigente |
| DT-005 | Acceso a datos (SQLAlchemy Core + psycopg) | Vigente |
| DT-006 | Modelo de dominio con `@dataclass` | Vigente |
| DT-007 | Responsabilidades del modelo | Vigente |
| DT-008 | Convenciones de nombres | Vigente |
| DT-009 | Organización del proyecto | Vigente |
| DT-010 | Frontend con Bootstrap | Vigente |
| DT-011 | Control de versiones | Vigente |
| DT-012 | Desarrollo incremental | Vigente |
| DT-013 | Uso de datos simulados durante el desarrollo | Vigente |
| DT-014 | Ejecución de módulos Python | Vigente |
| DT-015 | Gestión de la configuración | Vigente |