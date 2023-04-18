DELIMITER %
CREATE TRIGGER after_insert_update_quantity_books
AFTER INSERT ON libros
FOR EACH ROW
BEGIN
    UPDATE autores SET cantidad_libros = cantidad_libros + 1 WHERE autor_id = NEW.autor_id;
END;
%
DELIMITER ;


NEW hace referencia la nuevo registro insertado en la tabla de libros y que adicionalmente tiene el atributo de autor_id

Luego agregamos un nuevo libro para poder evidenciar el trigger impactando la tabla de autores
INSERT INTO libros(autor_id, titulo, fecha_publicacion) VALUES(1, 'Area 81', '2011-07-01');

Ahora ejecutando el evento DELETE

DELIMITER %
CREATE TRIGGER after_delete_update_quantity_books
AFTER DELETE ON libros
FOR EACH ROW
BEGIN
    UPDATE autores SET cantidad_libros = cantidad_libros - 1 WHERE autor_id = OLD.autor_id;
END;
%
DELIMITER ;

Evento UPDATE

DELIMITER %
CREATE TRIGGER after_update_actualizar_libros
AFTER UPDATE ON libros
FOR EACH ROW
BEGIN
    IF(NEW.autor_id != OLD.autor_id) THEN
        UPDATE autores SET cantidad_libros = cantidad_libros + 1 WHERE autor_id = NEW.autor_id;
        UPDATE autores SET cantidad_libros = cantidad_libros - 1 WHERE autor_id = OLD.autor_id;
    END IF;
END;
%
DELIMITER ;

Para listar los triggers

SHOW TRIGGERS\G ;

Para eliminar los triggers asociados a la vbase de datos

DROP TRIGGER IF EXISTS <database>.<trigger>

DROP TRIGGER IF EXISTS libreria_cf.after_insert_update_quantity_books;