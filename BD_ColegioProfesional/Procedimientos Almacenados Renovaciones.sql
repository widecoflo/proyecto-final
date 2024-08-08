USE DBColegioProfesional;
GO

-- Procedimiento almacenado para listar renovaciones
CREATE PROCEDURE ListarRenovaciones
AS
BEGIN
    SELECT * FROM Renovaciones;
END;
GO

-- Procedimiento almacenado para obtener una renovación por ID
CREATE PROCEDURE ObtenerRenovacion_id
    @id_renovacion INT
AS
BEGIN
    SELECT * FROM Renovaciones WHERE id_renovacion = @id_renovacion;
END;
GO

-- Procedimiento almacenado para insertar una nueva renovación
CREATE PROCEDURE InsertarRenovacion
    @id_miembro INT,
    @id_pago INT,
    @id_documento INT,
    @fecha_solicitud DATE,
    @estado VARCHAR(20)
AS
BEGIN
    INSERT INTO Renovaciones (id_miembro, id_pago, id_documento, fecha_solicitud, estado)
    VALUES (@id_miembro, @id_pago, @id_documento, @fecha_solicitud, @estado);
END;
GO

-- Procedimiento almacenado para actualizar una renovación
CREATE PROCEDURE ActualizarRenovacion
    @id_renovacion INT,
    @id_miembro INT,
    @id_pago INT,
    @id_documento INT,
    @fecha_solicitud DATE,
    @fecha_aprobacion DATE,
    @estado VARCHAR(20)
AS
BEGIN
    UPDATE Renovaciones
    SET id_miembro = @id_miembro,
        id_pago = @id_pago,
        id_documento = @id_documento,
        fecha_solicitud = @fecha_solicitud,
        fecha_aprobacion = @fecha_aprobacion,
        estado = @estado
    WHERE id_renovacion = @id_renovacion;
END;
GO

-- Procedimiento almacenado para borrar una renovación
CREATE PROCEDURE BorrarRenovacion
    @id_renovacion INT
AS
BEGIN
    DELETE FROM Renovaciones WHERE id_renovacion = @id_renovacion;
END;
GO

-- Ejemplos de inserción

-- Insertar renovación 1
EXEC InsertarRenovacion 
    @id_miembro = 1,
    @id_pago = 1,
    @id_documento = 1,
    @fecha_solicitud = '2023-01-10',
    @estado = 'Pendiente';
GO

-- Listar todas las renovaciones
EXEC ListarRenovaciones;
GO
