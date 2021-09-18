--Creando Base de datos Biblioteca
CREATE DATABASE Biblioteca;

--Abriendo conexion a Base de datos creada
USE Biblioteca; 

--Creando esquemas (Solución a posible error)
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'prestamosBiblioteca')
  BEGIN
    EXEC ('CREATE SCHEMA prestamosBiblioteca;');
  END;

IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'funciones_empleados')
  BEGIN
    EXEC ('CREATE SCHEMA funciones_empleados;');
  END;

IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'opciones_usuarios')
  BEGIN
    EXEC ('CREATE SCHEMA opciones_usuarios;');
  END;

IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'devolucionesBiblioteca')
  BEGIN
    EXEC ('CREATE SCHEMA devolucionesBiblioteca;');
  END;

--Creando los objetos en el esquema con los datos del modelo logico

--Tabla para los datos del usuario
CREATE TABLE opciones_usuarios.usuario(
	idusuario INTEGER PRIMARY KEY NOT NULL,
	nombres VARCHAR(25) NOT NULL,
	apellidos VARCHAR(25) NOT NULL,
	telefono VARCHAR(15) NOT NULL
);

--Tabla para la dirección del usuario
CREATE TABLE opciones_usuarios.direccion_usuario(
	cod_direccion_usuario INTEGER PRIMARY KEY NOT NULL,
	calle VARCHAR(30) NOT NULL,
	puerta INTEGER NOT NULL,
	municipio VARCHAR(30) NOT NULL,
	departamento VARCHAR(30) NOT NULL,
	idusuario INTEGER NOT NULL
);

--Definir clave foranea desde usuario a direccion del usuario
ALTER TABLE opciones_usuarios.direccion_usuario
ADD CONSTRAINT fkIdusuario FOREIGN KEY(idusuario) REFERENCES opciones_usuarios.usuario(idusuario);


--Tabla para los datos del encargado
CREATE TABLE funciones_empleados.encargado(
	idencargado INTEGER PRIMARY KEY NOT NULL,
	nombres VARCHAR(25) NOT NULL,
	apellidos VARCHAR(25) NOT NULL,
	telefono VARCHAR(15) NOT NULL,
	salarios FLOAT NOT NULL
);

--Tabla para la dirección del encargado
CREATE TABLE funciones_empleados.direccion_encargado(
	cod_direccion_encargado INTEGER PRIMARY KEY NOT NULL,
	calle VARCHAR(30) NOT NULL,
	puerta INTEGER NOT NULL,
	municipio VARCHAR(30) NOT NULL,
	departamento VARCHAR(30) NOT NULL,
	idencargado INTEGER NOT NULL
);

--Definir clave foranea desde encargado a direccion del encargado
ALTER TABLE funciones_empleados.direccion_encargado
ADD CONSTRAINT fkIdencargado FOREIGN KEY(idencargado) REFERENCES funciones_empleados.encargado(idencargado);


--Tabla para los datos de las devoluciones
CREATE TABLE devolucionesBiblioteca.devoluciones(
	id_devolucion INTEGER PRIMARY KEY NOT NULL,
	fecha_devolucion DATE NOT NULL,
	idusuario INTEGER NOT NULL,
	idencargado INTEGER NOT NULL
);

--Definir claves foraneas para devoluciones
ALTER TABLE devolucionesBiblioteca.devoluciones
ADD CONSTRAINT fkId_us FOREIGN KEY(idusuario) REFERENCES opciones_usuarios.usuario(idusuario);

ALTER TABLE devolucionesBiblioteca.devoluciones
ADD CONSTRAINT fkId_enc FOREIGN KEY(idencargado) REFERENCES funciones_empleados.encargado(idencargado);


--Tabla para el registro de sanciones
CREATE TABLE devolucionesBiblioteca.sanciones(
	cod_sanciones INTEGER PRIMARY KEY NOT NULL,
	detalle VARCHAR(60) NOT NULL,
	pago FLOAT NOT NULL,
	id_devolucion INTEGER NOT NULL
);

--Definir clave foranea desde devoluciones a sanciones
ALTER TABLE devolucionesBiblioteca.sanciones
ADD CONSTRAINT fkIddevolucion FOREIGN KEY(id_devolucion) REFERENCES devolucionesBiblioteca.devoluciones(id_devolucion);


--Tabla para los datos de los prestamos
CREATE TABLE prestamosBiblioteca.prestamos(
	id_prestamo INTEGER PRIMARY KEY NOT NULL,
	fecha_prestamo DATE NOT NULL,
	idusuario INTEGER NOT NULL,
	idencargado INTEGER NOT NULL
);

--Definir claves foraneas para prestamos
ALTER TABLE prestamosBiblioteca.prestamos
ADD CONSTRAINT fkId_usuario FOREIGN KEY(idusuario) REFERENCES opciones_usuarios.usuario(idusuario);

ALTER TABLE prestamosBiblioteca.prestamos
ADD CONSTRAINT fkId_encargado FOREIGN KEY(idencargado) REFERENCES funciones_empleados.encargado(idencargado);


--Tabla para datos de los detalles de prestamos
CREATE TABLE prestamosBiblioteca.ficha_prestamos(
	id_reserva INTEGER PRIMARY KEY NOT NULL,
	id_libro INTEGER NOT NULL,
	cantidad INTEGER NOT NULL,
	id_prestamo INTEGER NOT NULL
);

--Tabla para los datos de los Libros
CREATE TABLE prestamosBiblioteca.libros(
	id_libro INTEGER PRIMARY KEY NOT NULL,
	nombre_libro VARCHAR(30) NOT NULL,
	idioma VARCHAR(10) NOT NULL
);

--Definir claves foraneas para detalles de prestamos
ALTER TABLE prestamosBiblioteca.ficha_prestamos
ADD CONSTRAINT fkIdprestamo FOREIGN KEY(id_prestamo) REFERENCES prestamosBiblioteca.prestamos(id_prestamo);

ALTER TABLE prestamosBiblioteca.ficha_prestamos
ADD CONSTRAINT fkIdlibro FOREIGN KEY(id_libro) REFERENCES prestamosBiblioteca.libros(id_libro);


--Tabla para los datos de las categorias
CREATE TABLE prestamosBiblioteca.categorias(
	id_categoria INTEGER PRIMARY KEY NOT NULL,
	nombre_categoria VARCHAR(25) NOT NULL,
	id_libro INTEGER NOT NULL
);

--Definir clave foranea desde libros a categorias
ALTER TABLE prestamosBiblioteca.categorias
ADD CONSTRAINT fkId_categorialibro FOREIGN KEY(id_libro) REFERENCES prestamosBiblioteca.libros(id_libro);


--Tabla para los datos de los autores
CREATE TABLE prestamosBiblioteca.autores(
	id_autor INTEGER PRIMARY KEY NOT NULL,
	nombre_autor VARCHAR(25) NOT NULL,
	apellido_autor VARCHAR(25) NOT NULL,
	nacionalidad_autor VARCHAR(30) NOT NULL,
	id_libro INTEGER NOT NULL
);

--Definir clave foranea desde libros a autores
ALTER TABLE prestamosBiblioteca.autores
ADD CONSTRAINT fkId_autoreslibro FOREIGN KEY(id_libro) REFERENCES prestamosBiblioteca.libros(id_libro);


--Tabla para los datos de las editoriales
CREATE TABLE prestamosBiblioteca.editoriales(
	id_editorial INTEGER PRIMARY KEY NOT NULL,
	nombre_editorial VARCHAR(25) NOT NULL,
	id_libro INTEGER NOT NULL
);

--Definir clave foranea desde libros a editoriales
ALTER TABLE prestamosBiblioteca.editoriales
ADD CONSTRAINT fkId_editoriallibro FOREIGN KEY(id_libro) REFERENCES prestamosBiblioteca.libros(id_libro);
