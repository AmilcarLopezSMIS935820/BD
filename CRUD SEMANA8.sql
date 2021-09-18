USE BIBLIOTECA;

--CRUD para tabla Libros

--Revisando tabla Libros
SELECT *FROM prestamosBiblioteca.libros;

--Insertando multiples registros en tabla Libros
INSERT INTO prestamosBiblioteca.libros(
	id_libro, nombre_libro, idioma
) OUTPUT inserted.nombre_libro, inserted.idioma --Muestra salida luego de realizar inserción

VALUES
(5, 'Mil años de soledad', 'Español'),
(6, 'Murder on the orient express', 'Ingles');

--Actualizando registros de la tabla Libros
UPDATE prestamosBiblioteca.libros SET nombre_libro='Gato negro' WHERE id_libro=6;
UPDATE prestamosBiblioteca.libros SET idioma='Español' WHERE id_libro=6;

--Verificando actualización en la tabla Libros
SELECT *FROM prestamosBiblioteca.libros;

--Eliminando registros de la tabla libros
DELETE FROM prestamosBiblioteca.libros WHERE id_libro=6;

--Verificando que se elimino el registro
SELECT * FROM prestamosBiblioteca.libros;