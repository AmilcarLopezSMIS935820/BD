USE Biblioteca;

SELECT
	s.name,
	u.name
FROM
	sys.schemas s
INNER JOIN sys.sysusers u ON u.uid = s.principal_id;

--Creando Login
CREATE LOGIN Encargado_Biblioteca WITH PASSWORD='UGB2021';

--Creando Usuario y asignandolo a Login
CREATE USER EncargadoAmilcar FOR LOGIN Encargado_Biblioteca WITH DEFAULT_SCHEMA=prestamosBiblioteca;

--Otorgando permisos al Usuario creado
GRANT SELECT, INSERT, UPDATE, DELETE
ON SCHEMA::prestamosBiblioteca To EncargadoAmilcar WITH GRANT OPTION;

--Revocando permisos al usuario
REVOKE SELECT, INSERT, UPDATE, DELETE ON SCHEMA::prestamosBiblioteca To EncargadoAmilcar CASCADE;
