USE DBColegioProfesional;
GO

-- Procedimiento almacenado para listar pagos
CREATE PROCEDURE ListarPagos
AS
BEGIN
    SELECT * FROM Pagos;
END;
GO

-- Procedimiento almacenado para obtener un pago por ID
CREATE PROCEDURE ObtenerPago_id
    @id_pago INT
AS
BEGIN
    SELECT * FROM Pagos WHERE id_pago = @id_pago;
END;
GO

-- Procedimiento almacenado para insertar un nuevo pago
CREATE PROCEDURE InsertarPago
    @id_miembro INT,
    @monto DECIMAL(10, 2),
    @fecha_pago DATE,
    @tipo_pago VARCHAR(50),
    @comprobante_url VARCHAR(255),
    @estado VARCHAR(20)
AS
BEGIN
    INSERT INTO Pagos (id_miembro, monto, fecha_pago, tipo_pago, comprobante_url, estado)
    VALUES (@id_miembro, @monto, @fecha_pago, @tipo_pago, @comprobante_url, @estado);
END;
GO

-- Procedimiento almacenado para actualizar un pago
CREATE PROCEDURE ActualizarPago
    @id_pago INT,
    @id_miembro INT,
    @monto DECIMAL(10, 2),
    @fecha_pago DATE,
    @tipo_pago VARCHAR(50),
    @comprobante_url VARCHAR(255),
    @estado VARCHAR(20)
AS
BEGIN
    UPDATE Pagos
    SET id_miembro = @id_miembro,
        monto = @monto,
        fecha_pago = @fecha_pago,
        tipo_pago = @tipo_pago,
        comprobante_url = @comprobante_url,
        estado = @estado
    WHERE id_pago = @id_pago;
END;
GO

-- Procedimiento almacenado para borrar un pago
CREATE PROCEDURE BorrarPago
    @id_pago INT
AS
BEGIN
    DELETE FROM Pagos WHERE id_pago = @id_pago;
END;
GO

-- Ejemplos de inserción

-- Insertar pago 1
EXEC InsertarPago 
    @id_miembro = 1,
    @monto = 100.00,
    @fecha_pago = '2023-01-15',
    @tipo_pago = 'Transferencia',
    @comprobante_url = 'http://example.com/comprobante1',
    @estado = 'Pendiente';
GO

-- Insertar pago 2
EXEC InsertarPago 
    @id_miembro = 1,
    @monto = 150.00,
    @fecha_pago = '2023-02-20',
    @tipo_pago = 'Efectivo',
    @comprobante_url = 'http://example.com/comprobante2',
    @estado = 'Aprobado';
GO

-- Listar todos los pagos
EXEC ListarPagos;
GO
