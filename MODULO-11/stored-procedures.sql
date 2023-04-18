DELIMITER %

CREATE PROCEDURE prestamo(usuario_id INT, libro_id INT)
BEGIN
    INSERT INTO libros_usuarios(libro_id, usuario_id) VALUES (libro_id, usuario_id);
    UPDATE libros SET stock = stock - 1 WHERE libros.libro_id = libro_id;
END%

DELIMITER ;

Listar los procedimientos

SHOW PROCEDURE STATUS WHERE db = database() AND type = 'PROCEDURE';

Ejecutar stored procedures

CALL prestamo(20,2);

Eliminar procedures

DROP PROCEDURE prestamo;

Obtener valores despues de haber ejeuctado el stored-procedure

DELIMITER %

CREATE PROCEDURE prestamo(usuario_id INT, libro_id INT, OUT cantidad INT)
BEGIN
    INSERT INTO libros_usuarios(libro_id, usuario_id) VALUES (libro_id, usuario_id);
    UPDATE libros SET stock = stock - 1 WHERE libros.libro_id = libro_id;

    SET cantidad = (SELECT stock FROM libros WHERE libros.libro_id = libro_id);
END%

DELIMITER ;

* Ponemos OUT si queremos p=obtener el valor una vez se haya ejecutado el procedure

Condiciones en stored procedure

DELIMITER %

CREATE PROCEDURE prestamo(usuario_id INT, libro_id INT, OUT cantidad INT)
BEGIN
    SET cantidad = (SELECT stock FROM libros WHERE libros.libro_id = libro_id);

    IF cantidad > 0 THEN 

        INSERT INTO libros_usuarios(libro_id, usuario_id) VALUES (libro_id, usuario_id);
        UPDATE libros SET stock = stock - 1 WHERE libros.libro_id = libro_id;

        SET cantidad = cantidad - 1;
    ELSE IF condicion 2
    ELSE IF condicion 3
    ELSE IF condicion 4
    .
    .
    .
    ELSE 

        SELECT "No es posible realizar el prestamo" AS mensaje_error;
    
    END IF;

END%

DELIMITER ;

Stored procedures con cases semejante a switch

DELIMITER %
CREATE PROCEDURE tipo_lector(usuario_id INT)
BEGIN
    SET @cantidad = (SELECT COUNT(*) FROM libros_usuarios WHERE libros_usuarios.usuario_id = usuario_id);
    SELECT @cantidad;
    CASE 
        WHEN @cantidad >= 20 THEN
            SELECT "Fanatico" AS mensaje;
        WHEN @cantidad >= 10 AND @cantidad < 20 THEN
            SELECT "Fanatico" AS mensaje;
        WHEN @cantidad >= 5 AND @cantidad < 10 THEN
            SELECT "Fanatico" AS mensaje;
        ELSE
            SELECT "Nuevo" AS mensaje;
    END CASE;
END%
DELIMITER ;

Stored procedures con ciclos

Usando WHILE

DELIMITER %
CREATE PROCEDURE libros_azar()
BEGIN

    SET @iteracion = 0;

    WHILE @iteracion < 5 DO 

        SELECT libro_id FROM libros ORDER BY RAND() LIMIT 1;

        SET @iteracion = @iteracion  + 1;

    END WHILE;

END%
DELIMITER ;

Usando REPEAT

DELIMITER %
CREATE PROCEDURE libros_azar()
BEGIN

    SET @iteracion = 5;

    REPEAT

        SELECT libro_id FROM libros ORDER BY RAND() LIMIT 1;

        SET @iteracion = @iteracion  + 1;

        UNTIL @iteracion >= 5
    END REPEAT;

END%
DELIMITER ;

Por lo menos el ciclo se realizara una vez
