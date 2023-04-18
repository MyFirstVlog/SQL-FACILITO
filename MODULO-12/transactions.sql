Transacciones 

START TRANSACTION;

SET @libro_id = 20, @usuario_id = 3;

UPDATE libros SET stock = stock - 1 WHERE libro_id = @libro_id;
SELECT stock FROM libros WHERE libro_id = @libro_id;

INSERT INTO libros_usuarios(libro_id, usuario_id) VALUES (@libro_id, @usuario_id);
SELECT * FROM libros_usuarios;

COMMIT; --> Finalizamos la transaccion

Si no ejecuto commit puedo revertir los cambios

Ahora ejecutando un caso invalido

START TRANSACTION;

SET @libro_id = 20, @usuario_id = 100; El usuario no existe

UPDATE libros SET stock = stock - 1 WHERE libro_id = @libro_id;
SELECT stock FROM libros WHERE libro_id = @libro_id;

INSERT INTO libros_usuarios(libro_id, usuario_id) VALUES (@libro_id, @usuario_id);
SELECT * FROM libros_usuarios;

ROLLBACK;

La mayoria de veces utilizaremos las Transacciones en los stored procedures

Stored procedure + transaction

DELIMITER %

CREATE PROCEDURE prestamo(usuario_id INT, libro_id INT)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;
        INSERT INTO libros_usuarios(libro_id, usuario_id) VALUES(libro_id, usuario_id);
        UPDATE libros SET stock = stock - 1 WHERE libros.libro_id = libro_id;
    COMMIT;

END%

DELIMITER ;