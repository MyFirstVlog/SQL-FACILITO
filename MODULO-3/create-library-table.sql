DROP DATABASE IF EXISTS library_aem;

CREATE DATABASE IF NOT EXISTS library_aem;

USE library_aem;

CREATE TABLE IF NOT EXISTS authors (
    author_id INT,
    nombre  VARCHAR(25) NOT NULL,
    apellido  VARCHAR(25),
    genero CHAR(1),
    fecha_nacimiento  DATE,
    pais_origen  VARCHAR(40)
);

INSERT INTO authors (
    author_id, 
    nombre, 
    apellido, 
    genero, 
    fecha_nacimiento,
    pais_origen
)
VALUES (3, 'Alejandro', 'Estrada', 'M', '1997-09-30', 'Colombia'),
       (4, 'Carolina', 'Ramirez', 'F', '1997-09-30', 'Colombia'),
       (5, 'Isabel', 'Jurado', 'F', '1997-09-30', 'Colombia'),
       (6, 'Meliza', 'Sanchez', 'F', '1997-09-30', 'Colombia'),
       (7, 'Milena', 'Cruz', 'F', '1997-09-30', 'Colombia');

SELECT * FROM authors;
