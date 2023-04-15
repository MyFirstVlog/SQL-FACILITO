VISTAS

SELECT
    usuarios.usuario_id,
    usuarios.nombre,
    usuarios.email,
    usuarios.username,
    COUNT(usuarios.usuario_id) AS total_prestamos
FROM  usuarios
INNER JOIN libros_usuarios ON libros_usuarios.usuario_id = usuarios.usuario_id
    AND libros_usuarios.fecha_creacion >= CURDATE() - INTERVAL 5 DAY
GROUP BY usuarios.usuario_id;

Para generar una vista a traves del query anterior 

CREATE VIEW prestamos_usuarios_vw AS 
SELECT
    usuarios.usuario_id,
    usuarios.nombre,
    usuarios.email,
    usuarios.username,
    COUNT(usuarios.usuario_id) AS total_prestamos
FROM  usuarios
INNER JOIN libros_usuarios ON libros_usuarios.usuario_id = usuarios.usuario_id
    AND libros_usuarios.fecha_creacion >= CURDATE() - INTERVAL 5 DAY
GROUP BY usuarios.usuario_id;

Se renocimienda utilizar un estandar en el nombre para la identificacion
Para visualizar las VISTAS

SHOW TABLES;

SELECT * FROM prestamos_usuarios_vw -> Se pueden usar todas las clausulas sql

Eliminar vista

DROP VIEW prestamos_usuarios_vw;

Para modificar una vista ya creada

CREATE OR REPLACE VIEW prestamos_usuarios_vw AS 
SELECT
    usuarios.usuario_id,
    usuarios.nombre,
    usuarios.email,
    usuarios.username,
    COUNT(usuarios.usuario_id) AS total_prestamos
FROM  usuarios
INNER JOIN libros_usuarios ON libros_usuarios.usuario_id = usuarios.usuario_id
    AND libros_usuarios.fecha_creacion >= CURDATE() - INTERVAL 5 DAY
GROUP BY usuarios.usuario_id;