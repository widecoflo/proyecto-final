USE DBColegioProfesional;
GO

-- Procedimiento almacenado ListarUsuarios
CREATE PROCEDURE ListarUsuarios
AS
BEGIN
    SELECT id_usuario, id_miembro, username, password_hash, rol, fecha_creacion, ultimo_acceso
    FROM Usuarios;
END;
GO

-- Procedimiento almacenado ObtenerUsuario_id
CREATE PROCEDURE ObtenerUsuario_id
    @id_usuario INT
AS
BEGIN
    SELECT id_usuario, id_miembro, username, password_hash, rol, fecha_creacion, ultimo_acceso
    FROM Usuarios
    WHERE id_usuario = @id_usuario;
END;
GO

-- Procedimiento almacenado InsertarUsuario
CREATE PROCEDURE InsertarUsuario
    @id_miembro INT,
    @username VARCHAR(50),
    @password_hash VARCHAR(255),
    @rol VARCHAR(20),
    @fecha_creacion DATE,
    @ultimo_acceso DATE
AS
BEGIN
    INSERT INTO Usuarios (id_miembro, username, password_hash, rol, fecha_creacion, ultimo_acceso)
    VALUES (@id_miembro, @username, @password_hash, @rol, @fecha_creacion, @ultimo_acceso);
END;
GO

-- Procedimiento almacenado ActualizarUsuario
CREATE PROCEDURE ActualizarUsuario
    @id_usuario INT,
    @id_miembro INT,
    @username VARCHAR(50),
    @password_hash VARCHAR(255),
    @rol VARCHAR(20),
    @fecha_creacion DATE,
    @ultimo_acceso DATE
AS
BEGIN
    UPDATE Usuarios
    SET id_miembro = @id_miembro,
        username = @username,
        password_hash = @password_hash,
        rol = @rol,
        fecha_creacion = @fecha_creacion,
        ultimo_acceso = @ultimo_acceso
    WHERE id_usuario = @id_usuario;
END;
GO

-- Procedimiento almacenado BorrarUsuario
CREATE PROCEDURE BorrarUsuario
    @id_usuario INT
AS
BEGIN
    DELETE FROM Usuarios
    WHERE id_usuario = @id_usuario;
END;
GO

-- Ejemplo de Inserción 1
EXEC InsertarUsuario
    @id_miembro = 1,
    @username = 'user1',
    @password_hash = 'hashed_password_1',
    @rol = 'Admin',
    @fecha_creacion = '2024-07-04',
    @ultimo_acceso = '2024-07-04';
GO

-- Ejemplo de Inserción 2
EXEC InsertarUsuario
    @id_miembro = 1,
    @username = 'user2',
    @password_hash = 'hashed_password_2',
    @rol = 'User',
    @fecha_creacion = '2024-07-04',
    @ultimo_acceso = '2024-07-04';
GO

-- Ejecutar el procedimiento ListarUsuarios
EXEC ListarUsuarios;
GO
