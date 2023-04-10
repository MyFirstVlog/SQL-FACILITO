DROP DATABASE IF EXISTS libreria_cf;
CREATE DATABASE IF NOT EXISTS libreria_cf;

USE libreria_cf;

CREATE TABLE IF NOT EXISTS autores(
  autor_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(25) NOT NULL,
  apellido VARCHAR(25) NOT NULL,
  seudonimo VARCHAR(50) UNIQUE,
  genero ENUM('M', 'F'),
  fecha_nacimiento DATE NOT NULL,
  pais_origen VARCHAR(40) NOT NULL,
  fecha_creacion DATETIME DEFAULT current_timestamp
);

CREATE TABLE libros(
  libro_id INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  autor_id INT UNSIGNED NOT NULL,
  titulo varchar(50) NOT NULL,
  descripcion varchar(250) NOT NULL DEFAULT '',
  paginas INTEGER UNSIGNED NOT NULL DEFAULT 0,
  fecha_publicacion Date NOT NUll,
  fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (autor_id) REFERENCES autores(autor_id) ON DELETE CASCADE
);

ALTER TABLE libros ADD ventas INT UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE libros ADD stock INT UNSIGNED DEFAULT 10;

INSERT INTO autores (nombre, apellido, seudonimo, fecha_nacimiento, genero, pais_origen )
  VALUES ('Stephen Edwin', 'King', 'Richard Bachman', '1947-09-27', 'M', 'USA'),
         ('Joanne', 'Rowling', 'J.K Rowling', '1947-09-27', 'F', 'Reino unido'),
         ('Daniel', 'Brown',  NULL, '1964-06-22', 'M', 'USA'),
         ('John', 'Katzenbach ', NULL,'1950-06-23', 'M', 'USA'),
         ('John Ronald', 'Reuel Tolkien', NULL, '1892-01-03', 'M', 'Reino unido'),
         ('Miguel', 'de Unamuno', NULL, '1892-01-03', 'M', 'USA'),
         ('Arturo', 'Pérez Reverte', NULL, '1951-11-25', 'M', 'España'),
         ('George Raymond', 'Richard Martin', NULL, '1948-09-20', 'M', 'USA');

INSERT INTO libros(autor_id, titulo, fecha_publicacion)
VALUES (1, 'Carrie','1974-01-01'),
      (1, 'El misterio de Salmes Lot','1975-01-01'),
      (1, 'El resplando','1977-01-01'),
      (1, 'Rabia','1977-01-01'),
      (1, 'El umbral de la noche','1978-01-01'),
      (1, 'La danza de la muerte','1978-01-01'),
      (1, 'La larga marcha','1979-01-01'),
      (1, 'La zona muerta','1979-01-01'),
      (1, 'Ojos de fuego','1980-01-01'),
      (1, 'Cujo','1981-01-01'),
      (1, 'La torre oscura 1 El pistolero','1982-01-01'),
      (1, 'La torre oscura 2 La invocación','1987-01-01'),
      (1, 'Apocalipsis','1990-01-01'),
      (1, 'La torre oscura 3 Las tierras baldías','1991-01-01'),
      (1, 'La torre oscura 4 Bola de cristal','1997-01-01'),
      (1, 'La torre oscura 5 Los de Calla','2003-01-01'),
      (1, 'La torre oscura 6 La torre oscura','2004-01-01'),
      (1, 'La torre oscura 7 Canción de Susannah','2004-01-01'),
      (1, 'La niebla','1981-01-01'),

      (2, 'Harry Potter y la Piedra Filosofal', '1997-06-30'),
      (2, 'Harry Potter y la Cámara Secreta', '1998-07-2'),
      (2, 'Harry Potter y el Prisionero de Azkaban','1999-07-8'),
      (2, 'Harry Potter y el Cáliz de Fuego','2000-03-20'),
      (2, 'Harry Potter y la Orden del Fénix','2003-06-21'),
      (2, 'Harry Potter y el Misterio del Príncipe','2005-06-16'),
      (2, 'Harry Potter y las Reliquias de la Muerte','2007-07-21'),

      (3, 'Origen', '2017-01-01'),
      (3, 'Inferno', '2013-01-01'),
      (3, 'El simbolo perdido', '2009-01-01'),
      (3, 'El código Da Vinci', '2006-01-01'),
      (3, 'La consipiración', '2003-01-01'),

      (4, 'Al calor del verano', '1982-01-01'),
      (4, 'Un asunto pendiente', '1987-01-01'),
      (4, 'Juicio Final', '1992-01-01'),
      (4, 'La sombra', '1995-01-01'),
      (4, 'Juego de ingenios', '1997-01-01'),
      (4, 'El psicoanalista', '2002-01-01'),
      (4, 'La historia del loco', '2004-01-01'),
      (4, 'El hombre equivocado', '2006-01-01'),
      (4, 'El estudiante', '2014-01-01'),

      (5, 'El hobbit','1937-01-01'),
      (5, 'Las dos torres','1954-01-01'),
      (5, 'El señor de los anillos','1954-01-01'),
      (5, 'La comunidad del anillo','1954-01-01'),
      (5, 'El retorno del rey','1955-01-01'),

      (6, 'La niebla','1914-01-01'),

      (7, 'Eva','2017-01-01'),
      (7, 'Falcó','2016-01-01'),
      (7, 'Hombre buenos','2015-01-01'),
      (7, 'Los barcos se pierden en tierra','2011-01-01'),

      (8, 'Juego de tronos','1996-08-01'),
      (8, 'Choque de reyes','1998-11-16'),
      (8, 'Tormenta de espadas','2005-10-17'),
      (8, 'Festin de cuervos','2011-07-12'),
      (8, 'Danza de dragones','2011-07-12');

'''
SELECT CONCAT(nombre,' ',apellido) AS 'Nombre_Completo' FROM autores;
CONCAT(nombre,' ',apellido) Se utiliza para concatenar una cantidad n de caracteres. 

SELECT CONCAT(nombre,' ',apellido) AS 'Nombre_Completo' FROM autores;

SELECT LENGTH(“Hola Mundo”);

SELECT * FROM autores WHERE LENGTH(nombre) > 7;

SELECT UPPER(nombre) as 'NAME', UPPER(apellido) as 'LAST_NAME', TRIM(CONCAT(UPPER(nombre), ' ', LOWER(apellido), ' ', 'siuu')) AS 'union' FROM autores;

SELECT LEFT("hoLA COMOE SASTDA", 4) AS left_substring, RIGHT("HOAL BABY HACE RATO",5
SELECT * FROM libros WHERE LEFT(titulo, LENGTH("Harry Potter")) = "Harry Potter";

SELECT ROUND(RAND() * 100);


ROUND(2.345, 1) = 2.3 (aproximado por debajo)
ROUND(2.345, 2) = 2.35 (aproximado por encima)
ROUND(2.345, 3) = 2.345 (sin redondeo)

SELECT TRUNCATE(1.23456,2); => 1.23

SELECT POW(2,16);

SET @now = NOW(); 

SELECT SECOND(@now),
MINUTE(@now),
HOUR(@now ),
MONTH(@now),
YEAR(@now)

SELECT DAYOFWEEK(@now ), DAYOFMONTH(@now ), DAYOFYEAR(@now );

SELECT DATE(NOW()); (permite cambiar el timestamp a date “2032-02-22”

SELECT * FROM libros WHERE DATE(fecha_creacion) > "2023-04-11" ;

SELECT * FROM libros WHERE DATE(fecha_creacion) = CURDATE() ;

SELECT @now + INTERVAL 30 DAY;

→ SELECT IF(10 > 90, “El número es mayor a 10”, “El número es mayor a 10”);

El if tambien se puede asociar a columnas

→ SELECT IF(columna_b = 0, "No posee paginas", "Posee paginas");

IFNULL()

→ SELECT IFNULL(seudonimo, "El autor no cuenta con seudonimos") FROM autores;

En casi que si tenga seudonimos devuelve el nombre del autor


-- Para crear una funcion

SET GLOBAL log_bin_trust_function_creators = 1;

DELIMITER %

CREATE FUNCTION add_days(fecha DATE, dias INT)
RETURNS DATE 
BEGIN
  RETURN fecha + INTERVAL dias DAY;
END%

DELIMITER ;

SELECT add_days(NOW(), 60);

-- listar funciones

--> SHOW FUNCTION STATUS WHERE db = database();


'''

-- Ejecutar secuencias dentro de las funciones

DELIMITER %

CREATE FUNCTION get_pages()
RETURNS INT
BEGIN
  SET @paginas = (SELECT (ROUND(RAND() * 100) * 4 ));
  RETURN @paginas;
END%

DELIMITER ;

UPDATE libros SET paginas = get_pages();