DROP DATABASE IF EXISTS library_aem;

CREATE DATABASE IF NOT EXISTS library_aem;

USE library_aem;

CREATE TABLE IF NOT EXISTS authors(
    author_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(25) NOT NULL,
    apellido VARCHAR(25) NOT NULL,
    seudonimo VARCHAR(50) UNIQUE,
    genero ENUM('M', 'F') NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    pais_origen VARCHAR(40) NOT NULL,
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT unique_combinacion UNIQUE (nombre, apellido, genero)
);

CREATE TABLE books(
    libro_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    author_id INT UNSIGNED NOT NULL,
    titulo VARCHAR(50) NOT NULL,
    descripcion VARCHAR(250),
    paginas INT UNSIGNED,
    fecha_publicacion DATE NOT NULL,
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP
);
 
INSERT INTO authors (
    nombre, 
    apellido, 
    genero, 
    fecha_nacimiento,
    pais_origen
)
VALUES ('Alejandro', 'Estrada', 'M', '1997-09-30', 'Colombia'),
       ('Carolina', 'Ramirez', 'F', '1997-09-30', 'Colombia'),
       ('Isabel', 'Jurado', 'F', '1997-09-30', 'Colombia'),
       ('Meliza', 'Sanchez', 'F', '1997-09-30', 'Colombia'),
       ('Milena', 'Cruz', 'F', '1997-09-30', 'Colombia');

INSERT INTO books(
    author_id,
    titulo,
    fecha_publicacion
)
VALUES (1, 'El psicoanalista', '2012-09-30'),
    (1, 'El psicoanalista 2', '2012-09-30'),
    (1, 'El psicoanalista 3', '2012-10-30'),
    (1, 'El psicoanalista 4', '2012-11-30');

SELECT nombre,
       apellido,
       IF(genero='M', 'Mero macho', 'Mera Nena') AS status_migratorio
FROM authors;
SELECT * FROM books;
