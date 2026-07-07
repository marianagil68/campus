SET search_path TO campus;

INSERT INTO roles (nombre, descripcion)
VALUES
('Administrador', 'Administra el sistema'),
('Estudiante', 'Accede a los cursos, clases, materiales y cuestionarios');

INSERT INTO tiposmateriales (nombre, icono)
VALUES
('Video', 'video'),
('PDF', 'picture_as_pdf'),
('PowerPoint', 'slideshow'),
('Word', 'description'),
('ZIP', 'folder_zip'),
('Código fuente', 'code'),
('GitHub', 'terminal'),
('Sitio web', 'language'),
('Bibliografía', 'menu_book');

INSERT INTO configuraciones (clave, valortexto, descripcion)
VALUES
('nombreSitio', 'Campus', 'Nombre público de la plataforma'),
('emailSoporte', '', 'Correo de soporte para estudiantes'),
('permitirRegistro', 'true', 'Indica si los usuarios pueden registrarse por su cuenta'),
('porcentajeAprobacion', '70', 'Porcentaje mínimo para aprobar un cuestionario');