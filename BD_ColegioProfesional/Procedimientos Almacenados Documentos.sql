USE DBColegioProfesional;
GO

-- Procedimiento para listar todos los documentos
CREATE PROCEDURE ListarDocumentos
AS
BEGIN
    SELECT * FROM Documentos;
END;
GO

-- Procedimiento para obtener un documento por su ID
CREATE PROCEDURE ObtenerDocumento_id
    @id_documento INT
AS
BEGIN
    SELECT * FROM Documentos
    WHERE id_documento = @id_documento;
END;
GO

-- Procedimiento para insertar un nuevo documento
USE DBColegioProfesional;
GO

-- Procedimiento para insertar un nuevo documento con fecha de carga manual
CREATE PROCEDURE InsertarDocumento
    @id_miembro INT,
    @tipo_documento VARCHAR(50),
    @documento_url VARCHAR(255),
    @fecha_carga DATE,
    @estado VARCHAR(20)
AS
BEGIN
    INSERT INTO Documentos (id_miembro, tipo_documento, documento_url, fecha_carga, estado)
    VALUES (@id_miembro, @tipo_documento, @documento_url, @fecha_carga, @estado);
END;
GO

-- Procedimiento para actualizar un documento existente con fecha de carga manual
CREATE PROCEDURE ActualizarDocumento
    @id_documento INT,
    @id_miembro INT,
    @tipo_documento VARCHAR(50),
    @documento_url VARCHAR(255),
    @fecha_carga DATE,
    @estado VARCHAR(20)
AS
BEGIN
    UPDATE Documentos
    SET id_miembro = @id_miembro,
        tipo_documento = @tipo_documento,
        documento_url = @documento_url,
        fecha_carga = @fecha_carga,
        estado = @estado
    WHERE id_documento = @id_documento;
END;
GO


-- Procedimiento para borrar un documento por su ID
CREATE PROCEDURE BorrarDocumento
    @id_documento INT
AS
BEGIN
    DELETE FROM Documentos
    WHERE id_documento = @id_documento;
END;
GO


-- Llamar al procedimiento para insertar un nuevo documento
EXEC InsertarDocumento
    @id_miembro = 1,
    @tipo_documento = 'Licencia',
    @documento_url = 'http://example.com/documento1.pdf',
    @fecha_carga = '2024-07-04', -- Fecha en formato YYYY-MM-DD
    @estado = 'Activo';
GO

-- Llamar al procedimiento para insertar otro documento
EXEC InsertarDocumento
    @id_miembro = 1,
    @tipo_documento = 'Diploma',
    @documento_url = 'http://example.com/documento2.pdf',
    @fecha_carga = '2024-07-05', -- Fecha en formato YYYY-MM-DD
    @estado = 'Pendiente';
GO

EXEC ListarDocumentos