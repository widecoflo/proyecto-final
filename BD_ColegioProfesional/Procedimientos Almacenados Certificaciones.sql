
USE DBColegioProfesional;
GO

-- Procedimiento almacenado para listar certificaciones
CREATE PROCEDURE ListarCertificaciones
AS
BEGIN
    SELECT * FROM Certificaciones;
END;
GO

-- Procedimiento almacenado para obtener una certificación por ID
CREATE PROCEDURE ObtenerCertificacion_id
    @id_certificacion INT
AS
BEGIN
    SELECT * FROM Certificaciones WHERE id_certificacion = @id_certificacion;
END;
GO

-- Procedimiento almacenado para insertar una nueva certificación
CREATE PROCEDURE InsertarCertificacion
    @id_documento INT,
    @tipo_certificacion VARCHAR(50),
    @fecha_emision DATE,
    @fecha_expiracion DATE,
    @certificado_url VARCHAR(255),
    @estado VARCHAR(20)
AS
BEGIN
    INSERT INTO Certificaciones (id_documento, tipo_certificacion, fecha_emision, fecha_expiracion, certificado_url, estado)
    VALUES (@id_documento, @tipo_certificacion, @fecha_emision, @fecha_expiracion, @certificado_url, @estado);
END;
GO

-- Procedimiento almacenado para actualizar una certificación
CREATE PROCEDURE ActualizarCertificacion
    @id_certificacion INT,
    @id_documento INT,
    @tipo_certificacion VARCHAR(50),
    @fecha_emision DATE,
    @fecha_expiracion DATE,
    @certificado_url VARCHAR(255),
    @estado VARCHAR(20)
AS
BEGIN
    UPDATE Certificaciones
    SET id_documento = @id_documento,
        tipo_certificacion = @tipo_certificacion,
        fecha_emision = @fecha_emision,
        fecha_expiracion = @fecha_expiracion,
        certificado_url = @certificado_url,
        estado = @estado
    WHERE id_certificacion = @id_certificacion;
END;
GO

-- Procedimiento almacenado para borrar una certificación
CREATE PROCEDURE BorrarCertificacion
    @id_certificacion INT
AS
BEGIN
    DELETE FROM Certificaciones WHERE id_certificacion = @id_certificacion;
END;
GO

-- Ejemplos de inserción
-- Insertar certificación 1
EXEC InsertarCertificacion 
    @id_documento = 1,
    @tipo_certificacion = 'Certificación A',
    @fecha_emision = '2023-01-01',
    @fecha_expiracion = '2024-01-01',
    @certificado_url = 'http://example.com/cert1',
    @estado = 'Activo';
GO

-- Insertar certificación 2
EXEC InsertarCertificacion 
    @id_documento = 2,
    @tipo_certificacion = 'Certificación B',
    @fecha_emision = '2023-02-01',
    @fecha_expiracion = '2024-02-01',
    @certificado_url = 'http://example.com/cert2',
    @estado = 'Activo';
GO

-- Listar todas las certificaciones
EXEC ListarCertificaciones;
GO
