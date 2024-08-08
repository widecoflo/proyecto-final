
--PROCEDIMIENTOS ALMACENADOS MIEMBROS
-- Procedimiento para listar todos los miembros
CREATE PROCEDURE ListarMiembros
AS
BEGIN
    SELECT * FROM Miembros;
END;
GO

-- Procedimiento para obtener un miembro por su ID
CREATE PROCEDURE ObtenerMiembro_id
    @id_miembro INT
AS
BEGIN
    SELECT * FROM Miembros WHERE id_miembro = @id_miembro;
END;
GO

-- Procedimiento para insertar un nuevo miembro
CREATE PROCEDURE InsertarMiembro
    @dni VARCHAR(8),
    @nombres VARCHAR(100),
    @apellidos VARCHAR(100),
    @fecha_nacimiento DATE,
    @direccion VARCHAR(255),
    @email VARCHAR(100),
    @telefono VARCHAR(15),
    @universidad VARCHAR(100),
    @titulo VARCHAR(100),
    @fecha_graduacion DATE,
    @foto_url VARCHAR(255),
    @estado VARCHAR(20),
    @fecha_registro DATE
AS
BEGIN
    INSERT INTO Miembros (dni, nombres, apellidos, fecha_nacimiento, direccion, email, telefono, universidad, titulo, fecha_graduacion, foto_url, estado, fecha_registro)
    VALUES (@dni, @nombres, @apellidos, @fecha_nacimiento, @direccion, @email, @telefono, @universidad, @titulo, @fecha_graduacion, @foto_url, @estado, @fecha_registro);
END;
GO

-- Procedimiento para actualizar un miembro existente
CREATE PROCEDURE ActualizarMiembro
    @id_miembro INT,
    @dni VARCHAR(8),
    @nombres VARCHAR(100),
    @apellidos VARCHAR(100),
    @fecha_nacimiento DATE,
    @direccion VARCHAR(255),
    @email VARCHAR(100),
    @telefono VARCHAR(15),
    @universidad VARCHAR(100),
    @titulo VARCHAR(100),
    @fecha_graduacion DATE,
    @foto_url VARCHAR(255),
    @estado VARCHAR(20),
    @fecha_registro DATE
AS
BEGIN
    UPDATE Miembros
    SET dni = @dni,
        nombres = @nombres,
        apellidos = @apellidos,
        fecha_nacimiento = @fecha_nacimiento,
        direccion = @direccion,
        email = @email,
        telefono = @telefono,
        universidad = @universidad,
        titulo = @titulo,
        fecha_graduacion = @fecha_graduacion,
        foto_url = @foto_url,
        estado = @estado,
        fecha_registro = @fecha_registro
    WHERE id_miembro = @id_miembro;
END;
GO

-- Procedimiento para borrar un miembro por su ID
CREATE PROCEDURE BorrarMiembro
    @id_miembro INT
AS
BEGIN
    DELETE FROM Miembros WHERE id_miembro = @id_miembro;
END;
GO

EXEC InsertarMiembro
    @dni = '12345678',
    @nombres = 'Juan',
    @apellidos = 'PErez',
    @fecha_nacimiento = '1990-05-15',
    @direccion = 'Av. Principal 123',
    @email = 'juan.perez@example.com',
    @telefono = '987654321',
    @universidad = 'Universidad Nacional',
    @titulo = 'Ingeniero de Sistemas',
    @fecha_graduacion = '2015-12-20',
    @foto_url = 'https://example.com/juan.jpg',
    @estado = 'Activo',
    @fecha_registro = '2024-07-02';

EXEC ListarMiembros