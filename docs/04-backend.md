# Backend

# Acceso a datos

La aplicación utiliza SQLAlchemy Core para administrar las conexiones a PostgreSQL.

El acceso físico a la base se centraliza en la clase:

```
src/database.py
```

Esta clase encapsula la creación del `Engine` de SQLAlchemy y será utilizada por los distintos Repositories.

La primera prueba de funcionamiento consiste en ejecutar:

```sql
SELECT 1
```

para verificar la conectividad con el servidor PostgreSQL.

# Configuración

La configuración de la aplicación se centraliza en la clase:

```
src/config.py
```

Esta clase obtiene los valores desde un archivo `.env` utilizando la biblioteca `python-dotenv`.

La clase `Database` utiliza dichos valores para construir la URL de conexión mediante:

```python
sqlalchemy.engine.URL.create()
```

De esta forma:

- las credenciales no quedan escritas en el código;
- la configuración puede cambiar sin modificar la aplicación;
- se evita almacenar la cadena de conexión completa en el archivo `.env`.