Sin Alias

SELECT 
    libros.titulo,
    CONCAT(autores.nombre, ' ', autores.apellido) AS nombre_autor,
    libros.fecha_creacion
FROM libros
INNER JOIN autores ON libros.autor_id = autores.autor_id;

Alias

SELECT 
    bks.titulo,
    CONCAT(ats.nombre, ' ', ats.apellido) AS nombre_autor,
    bks.fecha_creacion
FROM libros AS bks
INNER JOIN autores AS ats ON bks.autor_id = ats.autor_id;


Usando condicional 

SELECT 
    libros.titulo,
    CONCAT(autores.nombre, ' ', autores.apellido) AS nombre_autor,
    libros.fecha_creacion
FROM libros
INNER JOIN autores ON libros.autor_id = autores.autor_id 
    AND autores.seudonimo IS NOT NULL;

-- Left Join

Nombre completo de los usuarios y el id de los libros prestados 

SELECT 
    CONCAT(nombre, " ", apellidos),
    libros_usuarios.libro_id
FROM usuarios
LEFT JOIN libros_usuarios ON usuarios.usuario_id = libros_usuarios.usuario_id;

Ahora filtrando sin usuarios

SELECT 
    CONCAT(nombre, " ", apellidos),
    libros_usuarios.libro_id
FROM usuarios
LEFT JOIN libros_usuarios ON usuarios.usuario_id = libros_usuarios.usuario_id
WHERE libros_usuarios.libro_id IS NOT NULL;

--Left outer join

SELECT 
    CONCAT(nombre, " ", apellidos),
    libros_usuarios.libro_id
FROM usuarios
LEFT JOIN libros_usuarios ON usuarios.usuario_id = libros_usuarios.usuario_id
WHERE libros_usuarios.libro_id IS NULL;

-- Rigth

Siguiendo el mismo ejemplo debe hacer cambios

libros_usuarios = a
usuarios = b

SELECT 
    CONCAT(usuarios.nombre, " ", usuarios.apellidos),
    libro_id
FROM libros_usuarios
RIGHT JOIN usuarios ON usuarios.usuario_id = libros_usuarios.usuario_id;

SELECT 
    CONCAT(usuarios.nombre, " ", usuarios.apellidos),
    libro_id
FROM libros_usuarios
RIGHT JOIN usuarios ON usuarios.usuario_id = libros_usuarios.usuario_id
WHERE libros_usuarios.libro_id IS NOT NULL;

-- Rigth outer join

SELECT 
    CONCAT(usuarios.nombre, " ", usuarios.apellidos),
    libro_id
FROM libros_usuarios
RIGHT JOIN usuarios ON usuarios.usuario_id = libros_usuarios.usuario_id
WHERE libros_usuarios.libro_id IS NULL;

-- Multilple joins

Las tablas que se usaran son:

1. usuarios
2. libros_usuarios
3. libros
4. autores


SELECT DISTINCT
    CONCAT(usuarios.nombre, ' ', usuarios.apellidos) as "Nombre Completo reservador",
    libros.titulo
FROM usuarios
INNER JOIN libros_usuarios ON libros_usuarios.usuario_id = usuarios.usuario_id AND  CURDATE() = DATE(libros_usuarios.fecha_creacion)
INNER JOIN libros ON libros_usuarios.libro_id = libros.libro_id
INNER JOIN autores ON libros.autor_id = autores.autor_id AND autores.seudonimo IS NOT NULL;


Cross origin o union de tablas sin relacion aparente

SELECT usuarios.username, libros.titulo FROM usuarios CROSS JOIN libros ORDER BY username DESC;