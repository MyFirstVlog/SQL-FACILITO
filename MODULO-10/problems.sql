Las tablas que se usaran son:

1. usuarios
2. libros_usuarios
3. libros
4. autores

Obtener a todos los usuarios que han realizado un préstamo en los últimos diez días.

SELECT DISTINCT CONCAT(usuarios.nombre, ' ', usuarios.apellidos) AS "Nombre Completo" FROM usuarios
INNER JOIN libros_usuarios ON usuarios.usuario_id = libros_usuarios.usuario_id AND libros_usuarios.fecha_creacion >= CURDATE() - INTERVAL 10 DAY;

Obtener a todos los usuarios que no ha realizado ningún préstamo.

SELECT DISTINCT CONCAT(usuarios.nombre, ' ', usuarios.apellidos) AS "Nombre Completo" FROM usuarios
LEFT JOIN libros_usuarios ON usuarios.usuario_id = libros_usuarios.usuario_id
WHERE libros_usuarios.usuario_id IS NULL;

Listar de forma descendente a los cinco usuarios con más préstamos.

SET @nombre_completo = CONCAT(usuarios.nombre, ' ', usuarios.apellidos);

SELECT CONCAT(usuarios.nombre, ' ', usuarios.apellidos) AS 'Nombre Completo', COUNT(*) AS 'Numero de prestamos' FROM usuarios
LEFT JOIN libros_usuarios ON usuarios.usuario_id = libros_usuarios.usuario_id
WHERE libros_usuarios.usuario_id IS NOT NULL
GROUP BY libros_usuarios.usuario_id
ORDER BY CONCAT(usuarios.nombre, ' ', usuarios.apellidos) DESC;


Listar 5 títulos con más préstamos en los últimos 30 días.

SELECT libros.titulo, COUNT(*) AS 'Cantidad de prestamos' FROM usuarios
INNER JOIN libros_usuarios ON usuarios.usuario_id = libros_usuarios.usuario_id
INNER JOIN libros ON libros_usuarios.libro_id = libros.libro_id
GROUP BY libros_usuarios.libro_id
ORDER BY COUNT(*) DESC
LIMIT 5;

Obtener el título de todos los libros que no han sido prestados.

SELECT libro_id, titulo FROM libros WHERE libro_id NOT IN (SELECT DISTINCT libros_usuarios.libro_id FROM usuarios
INNER JOIN libros_usuarios ON usuarios.usuario_id = libros_usuarios.usuario_id AND libros_usuarios.fecha_creacion);

Obtener la cantidad de libros prestados el día de hoy.

SELECT libros.titulo, COUNT(libros_usuarios.libro_id) AS "Veces prestadas" FROM usuarios
INNER JOIN libros_usuarios ON usuarios.usuario_id = libros_usuarios.usuario_id AND DATE(libros_usuarios.fecha_creacion) =  DATE(NOW()) - INTERVAL 2 DAY
INNER JOIN libros ON libros_usuarios.libro_id = libros.libro_id
GROUP BY libros_usuarios.libro_id;

Obtener la cantidad de libros prestados por el autor con id 1.

SELECT DISTINCT CONCAT(usuarios.nombre, ' ', usuarios.apellidos) AS 'Nombre Completo' FROM usuarios
INNER JOIN libros_usuarios ON usuarios.usuario_id = libros_usuarios.usuario_id AND usuarios.usuario_id = 1;

Obtener el nombre completo de los cinco autores con más préstamos.

SELECT CONCAT(usuarios.nombre, ' ', usuarios.apellidos) AS 'Nombre Completo', COUNT(*) AS 'Numero de prestamos' FROM usuarios
INNER JOIN libros_usuarios ON usuarios.usuario_id = libros_usuarios.usuario_id
GROUP BY libros_usuarios.usuario_id
ORDER BY CONCAT(usuarios.nombre, ' ', usuarios.apellidos) DESC
LIMIT 5;

Obtener el título del libro con más préstamos esta semana.

SELECT libros.titulo, COUNT(libros_usuarios.libro_id) AS "Veces prestadas" FROM usuarios
INNER JOIN libros_usuarios ON usuarios.usuario_id = libros_usuarios.usuario_id AND DATE(libros_usuarios.fecha_creacion) =  DATE(NOW()) - INTERVAL 2 DAY
INNER JOIN libros ON libros_usuarios.libro_id = libros.libro_id
GROUP BY libros_usuarios.libro_id
ORDER BY COUNT(libros_usuarios.libro_id) DESC
LIMIT 1;