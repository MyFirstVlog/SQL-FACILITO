-- Obtener todos los libros escritos por autores que cuenten con un seudónimo.

SELECT autor_id, titulo FROM libros WHERE autor_id IN (
    (SELECT autor_id FROM autores WHERE seudonimo IS NOT NULL)
) ORDER BY autor_id;

-- Obtener el título de todos los libros publicados en el año 2010 cuyos autores poseen un pseudónimo.

SELECT titulo, fecha_publicacion FROM (SELECT autor_id, titulo, fecha_publicacion FROM libros WHERE autor_id IN (
    (SELECT autor_id FROM autores WHERE seudonimo IS NOT NULL)
) ORDER BY autor_id) AS autores_filtered WHERE fecha_publicacion >= '2000-01-01'; 

-- Obtener todos los libros escritos por autores que cuenten con un seudónimo y que hayan nacido ante de 1965.

SELECT autor_id, titulo FROM libros WHERE autor_id IN (
    (SELECT autor_id FROM autores WHERE seudonimo IS NOT NULL AND fecha_nacimiento < '1965-01-01')
) ORDER BY autor_id;

-- Colocar el mensaje no disponible a la columna descripción, en todos los libros publicados antes del año 2000.

UPDATE libros SET descripcion = 'No disponible';

--Obtener la llave primaria de todos los libros cuya descripción sea diferente de no disponible.

UPDATE libros SET descripcion = IF(getSells() > 300, 'Disponible', 'No disponible' );
SELECT libro_id, descripcion FROM libros WHERE descripcion != 'No disponible';

-- Obtener el título de los últimos 3 libros escritos por el autor con id 2.

SELECT * FROM libros WHERE autor_id = 2 ORDER BY fecha_publicacion DESC ;

-- Obtener en un mismo resultado la cantidad de libros escritos por autores con seudónimo y sin seudónimo.

SELECT * FROM 
(SELECT SUM(con_seudonimo) AS con_seudonimo FROM (SELECT COUNT(*) AS con_seudonimo FROM libros WHERE autor_id IN (
    (SELECT autor_id FROM autores WHERE seudonimo IS NOT NULL)
) GROUP BY autor_id) AS seudonimo_tabla) AS seudonimo_tabla_2 , 
(SELECT SUM(sin_seudonimo) AS sin_seudonimo FROM (SELECT COUNT(*) AS sin_seudonimo FROM libros WHERE autor_id IN (
    (SELECT autor_id FROM autores WHERE seudonimo IS NULL)
) GROUP BY autor_id) AS sin_seudonimo_tabla) AS sin_seudonimo_tabla_2;

-- Obtener la cantidad de libros publicados entre enero del año 2000 y enero del año 2005.

SELECT titUlo, fecha_publicacion FROM Libros WHERE fecha_publicacion BETWEEN '2000-01-01' AND '2005-01-01';

-- Obtener el título y el número de ventas de los cinco libros más vendidos.

SELECT titulo, ventas FROM libros ORDER BY ventas DESC LIMIT 5;

-- Obtener el título y el número de ventas de los cinco libros más vendidos de la última década.

SELECT * FROM libros WHERE fecha_publicacion >= CURDATE() - INTERVAL 10 YEAR LIMIT 5;

-- Obtener la cantidad de libros vendidos por los autores con id 1, 2 y 3.

SELECT autor_id, SUM(ventas) FROM libros GROUP BY autor_id LIMIT 3;

-- Obtener el título del libro con más páginas.

SELECT titulo, paginas FROM libros ORDER BY paginas DESC LIMIT 1;

-- Obtener todos los libros cuyo título comience con la palabra “La”.

SELECT * FROM libros WHERE titulo LIKE 'La%';

-- Obtener todos los libros cuyo título comience con la palabra “La” y termine con la letra “a”.

SELECT * FROM libros WHERE titulo LIKE 'La%' AND titulo LIKE '%a';

-- Establecer el stock en cero a todos los libros publicados antes del año de 1995

UPDATE libros SET stock = IF(YEAR(libros.fecha_publicacion) < 1995,0);

UPDATE libros SET stock = IF(YEAR(fecha_publicacion) < 1995,0);

-- Mostrar el mensaje Disponible si el libro con id 1 posee más de 250 ejemplares en stock, 
-- en caso contrario mostrar el mensaje No disponible.

UPDATE libros SET descripcion = IF(stock > 250, 'Disponible', 'No disponible');

-- Obtener el título los libros ordenador por fecha de publicación del más reciente al más viejo.

SELECT titulo FROM libros WHERE fecha_publicacion ORDER BY decha

-- Autores

-- Obtener el nombre de los autores cuya fecha de nacimiento sea posterior a 1950

SELECT nombre FROM autores WHERE YEAR(fecha_nacimiento) > 1950;

-- Obtener la el nombre completo y la edad de todos los autores.

SELECT CONCAT(nombre, ' ', apellido) AS nombre_completo, ROUND(DATEDIFF(CURDATE(), fecha_nacimiento)/365) AS edad
FROM autores;

-- Obtener el nombre completo de todos los autores cuyo último libro publicado sea posterior al 2005

SELECT CONCAT(nombre, ' ', apellido) as Nombre_Completo FROM autores WHERE autor_id IN (SELECT autor_id FROM libros GROUP BY autor_id HAVING(YEAR(MAX(fecha_publicacion)) > 2005));

Obtener el id de todos los escritores cuyas ventas en sus libros superen el promedio.   

SELECT autor_id FROM libros GROUP BY autor_id HAVING(SUM(ventas) > (SELECT AVG(ventas) FROM libros));

Obtener el id de todos los escritores cuyas ventas en sus libros sean mayores a cien mil ejemplares.

SELECT autor_id FROM libros GROUP BY autor_id HAVING(SUM(ventas) > 100);



-- FUNCIONES

-- Crear una función la cual nos permita saber si un libro es candidato a préstamo o no. Retornar “Disponible” si el libro posee por lo menos un ejemplar en stock, 
-- en caso contrario retornar “No disponible.”

DELIMITER //
CREATE FUNCTION candidatoPrestamo(libroid INT)
RETURNS VARCHAR (20)
BEGIN
    RETURN IF((SELECT stock FROM libros WHERE libro_id = libroid)>0,"Disponible","No disponible");
END//
DELIMITER ;