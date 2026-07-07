DROP SCHEMA IF EXISTS campus CASCADE;

CREATE SCHEMA campus;

SET search_path TO campus;

CREATE TABLE roles (
    rolid BIGSERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE,
    descripcion VARCHAR(200),
    activo BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE usuarios (
    usuarioid BIGSERIAL PRIMARY KEY,
    rolid BIGINT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    passwordhash VARCHAR(255) NOT NULL,
    fotourl TEXT,
    activo BOOLEAN NOT NULL DEFAULT TRUE,
    fechacreacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ultimoacceso TIMESTAMP,

    CONSTRAINT fk_usuarios_roles
        FOREIGN KEY (rolid)
        REFERENCES roles (rolid)
);

CREATE TABLE cursos (
    cursoid BIGSERIAL PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL,
    descripcion TEXT,
    precio NUMERIC(12, 2) NOT NULL DEFAULT 0,
    imagenurl TEXT,
    duracionhoras NUMERIC(6, 2),
    activo BOOLEAN NOT NULL DEFAULT TRUE,
    fechacreacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE clases (
    claseid BIGSERIAL PRIMARY KEY,
    cursoid BIGINT NOT NULL,
    titulo VARCHAR(150) NOT NULL,
    descripcion TEXT,
    orden INTEGER NOT NULL,
    publicada BOOLEAN NOT NULL DEFAULT FALSE,
    fechapublicacion TIMESTAMP,
    activo BOOLEAN NOT NULL DEFAULT TRUE,

    CONSTRAINT fk_clases_cursos
        FOREIGN KEY (cursoid)
        REFERENCES cursos (cursoid),

    CONSTRAINT uq_clases_curso_orden
        UNIQUE (cursoid, orden)
);

CREATE TABLE tiposmateriales (
    tipomaterialid BIGSERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE,
    icono VARCHAR(50),
    activo BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE materiales (
    materialid BIGSERIAL PRIMARY KEY,
    claseid BIGINT NOT NULL,
    tipomaterialid BIGINT NOT NULL,
    titulo VARCHAR(150) NOT NULL,
    descripcion TEXT,
    ubicacion TEXT NOT NULL,
    orden INTEGER NOT NULL,
    activo BOOLEAN NOT NULL DEFAULT TRUE,

    CONSTRAINT fk_materiales_clases
        FOREIGN KEY (claseid)
        REFERENCES clases (claseid),

    CONSTRAINT fk_materiales_tiposmateriales
        FOREIGN KEY (tipomaterialid)
        REFERENCES tiposmateriales (tipomaterialid),

    CONSTRAINT uq_materiales_clase_orden
        UNIQUE (claseid, orden)
);

CREATE TABLE inscripciones (
    inscripcionid BIGSERIAL PRIMARY KEY,
    usuarioid BIGINT NOT NULL,
    cursoid BIGINT NOT NULL,
    fechainscripcion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    estado VARCHAR(30) NOT NULL DEFAULT 'pendiente',

    CONSTRAINT fk_inscripciones_usuarios
        FOREIGN KEY (usuarioid)
        REFERENCES usuarios (usuarioid),

    CONSTRAINT fk_inscripciones_cursos
        FOREIGN KEY (cursoid)
        REFERENCES cursos (cursoid),

    CONSTRAINT uq_inscripciones_usuario_curso
        UNIQUE (usuarioid, cursoid)
);

CREATE TABLE pagos (
    pagoid BIGSERIAL PRIMARY KEY,
    inscripcionid BIGINT NOT NULL,
    importe NUMERIC(12, 2) NOT NULL,
    mediopago VARCHAR(50),
    estado VARCHAR(30) NOT NULL DEFAULT 'pendiente',
    referenciaexterna VARCHAR(150),
    fechacreacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fechapago TIMESTAMP,
    fechaaprobacion TIMESTAMP,
    observaciones TEXT,

    CONSTRAINT fk_pagos_inscripciones
        FOREIGN KEY (inscripcionid)
        REFERENCES inscripciones (inscripcionid)
);

CREATE TABLE avanceclases (
    avanceclaseid BIGSERIAL PRIMARY KEY,
    inscripcionid BIGINT NOT NULL,
    claseid BIGINT NOT NULL,
    completada BOOLEAN NOT NULL DEFAULT FALSE,
    fechacompletada TIMESTAMP,

    CONSTRAINT fk_avanceclases_inscripciones
        FOREIGN KEY (inscripcionid)
        REFERENCES inscripciones (inscripcionid),

    CONSTRAINT fk_avanceclases_clases
        FOREIGN KEY (claseid)
        REFERENCES clases (claseid),

    CONSTRAINT uq_avanceclases_inscripcion_clase
        UNIQUE (inscripcionid, claseid)
);

CREATE TABLE cuestionarios (
    cuestionarioid BIGSERIAL PRIMARY KEY,
    claseid BIGINT NOT NULL,
    titulo VARCHAR(150) NOT NULL,
    descripcion TEXT,
    orden INTEGER NOT NULL,
    activo BOOLEAN NOT NULL DEFAULT TRUE,

    CONSTRAINT fk_cuestionarios_clases
        FOREIGN KEY (claseid)
        REFERENCES clases (claseid),

    CONSTRAINT uq_cuestionarios_clase_orden
        UNIQUE (claseid, orden)
);

CREATE TABLE preguntas (
    preguntaid BIGSERIAL PRIMARY KEY,
    cuestionarioid BIGINT NOT NULL,
    enunciado TEXT NOT NULL,
    orden INTEGER NOT NULL,
    activo BOOLEAN NOT NULL DEFAULT TRUE,

    CONSTRAINT fk_preguntas_cuestionarios
        FOREIGN KEY (cuestionarioid)
        REFERENCES cuestionarios (cuestionarioid),

    CONSTRAINT uq_preguntas_cuestionario_orden
        UNIQUE (cuestionarioid, orden)
);

CREATE TABLE opcionesrespuestas (
    opcionrespuestaid BIGSERIAL PRIMARY KEY,
    preguntaid BIGINT NOT NULL,
    texto TEXT NOT NULL,
    escorrecta BOOLEAN NOT NULL DEFAULT FALSE,
    orden INTEGER NOT NULL,
    activo BOOLEAN NOT NULL DEFAULT TRUE,

    CONSTRAINT fk_opcionesrespuestas_preguntas
        FOREIGN KEY (preguntaid)
        REFERENCES preguntas (preguntaid),

    CONSTRAINT uq_opcionesrespuestas_pregunta_orden
        UNIQUE (preguntaid, orden)
);

CREATE TABLE intentoscuestionarios (
    intentocuestionarioid BIGSERIAL PRIMARY KEY,
    inscripcionid BIGINT NOT NULL,
    cuestionarioid BIGINT NOT NULL,
    numero INTEGER NOT NULL,
    fechainicio TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fechafin TIMESTAMP,
    puntaje NUMERIC(5, 2),
    aprobado BOOLEAN,

    CONSTRAINT fk_intentoscuestionarios_inscripciones
        FOREIGN KEY (inscripcionid)
        REFERENCES inscripciones (inscripcionid),

    CONSTRAINT fk_intentoscuestionarios_cuestionarios
        FOREIGN KEY (cuestionarioid)
        REFERENCES cuestionarios (cuestionarioid),

    CONSTRAINT uq_intentoscuestionarios_inscripcion_cuestionario_numero
        UNIQUE (inscripcionid, cuestionarioid, numero)
);

CREATE TABLE respuestascuestionarios (
    respuestacuestionarioid BIGSERIAL PRIMARY KEY,
    intentocuestionarioid BIGINT NOT NULL,
    preguntaid BIGINT NOT NULL,
    opcionrespuestaid BIGINT NOT NULL,
    fecharespuesta TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_respuestascuestionarios_intentoscuestionarios
        FOREIGN KEY (intentocuestionarioid)
        REFERENCES intentoscuestionarios (intentocuestionarioid),

    CONSTRAINT fk_respuestascuestionarios_preguntas
        FOREIGN KEY (preguntaid)
        REFERENCES preguntas (preguntaid),

    CONSTRAINT fk_respuestascuestionarios_opcionesrespuestas
        FOREIGN KEY (opcionrespuestaid)
        REFERENCES opcionesrespuestas (opcionrespuestaid),

    CONSTRAINT uq_respuestascuestionarios_intento_pregunta
        UNIQUE (intentocuestionarioid, preguntaid)
);

CREATE TABLE certificados (
    certificadoid BIGSERIAL PRIMARY KEY,
    inscripcionid BIGINT NOT NULL UNIQUE,
    codigo VARCHAR(100) NOT NULL UNIQUE,
    fechaemision TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    url TEXT,
    activo BOOLEAN NOT NULL DEFAULT TRUE,

    CONSTRAINT fk_certificados_inscripciones
        FOREIGN KEY (inscripcionid)
        REFERENCES inscripciones (inscripcionid)
);

CREATE TABLE configuraciones (
    configuracionid BIGSERIAL PRIMARY KEY,
    clave VARCHAR(100) NOT NULL UNIQUE,
    valortexto TEXT,
    descripcion TEXT,
    activo BOOLEAN NOT NULL DEFAULT TRUE
);