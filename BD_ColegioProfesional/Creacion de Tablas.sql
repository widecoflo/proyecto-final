USE master;
GO

DROP DATABASE if EXISTS DBColegioProfesional;
GO

CREATE DATABASE DBColegioProfesional;
GO

USE DBColegioProfesional;
GO

-- Tabla Miembros
CREATE TABLE Miembros (
    id_miembro INT IDENTITY(1,1) PRIMARY KEY,
    dni VARCHAR(8) NOT NULL,
    nombres VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    direccion VARCHAR(255),
    email VARCHAR(100),
    telefono VARCHAR(15),
    universidad VARCHAR(100),
    titulo VARCHAR(100),
    fecha_graduacion DATE,
    foto_url VARCHAR(255),
    estado VARCHAR(20) NOT NULL,
    fecha_registro DATE
);
GO

-- Tabla Documentos
CREATE TABLE Documentos (
    id_documento INT IDENTITY(1,1) PRIMARY KEY,
    id_miembro INT NOT NULL,
    tipo_documento VARCHAR(50) NOT NULL,
    documento_url VARCHAR(255) NOT NULL,
    fecha_carga DATE,
    estado VARCHAR(20) NOT NULL,
    FOREIGN KEY (id_miembro) REFERENCES Miembros(id_miembro)
);
GO

-- Tabla Certificaciones
CREATE TABLE Certificaciones (
    id_certificacion INT IDENTITY(1,1) PRIMARY KEY,
    id_documento INT NOT NULL,
    tipo_certificacion VARCHAR(50) NOT NULL,
    fecha_emision DATE NOT NULL,
    fecha_expiracion DATE,
    certificado_url VARCHAR(255),
    estado VARCHAR(20) NOT NULL,
    FOREIGN KEY (id_documento) REFERENCES Documentos(id_documento)
);
GO

-- Tabla Pagos
CREATE TABLE Pagos (
    id_pago INT IDENTITY(1,1) PRIMARY KEY,
    id_miembro INT NOT NULL,
    monto DECIMAL(10, 2) NOT NULL,
    fecha_pago DATE NOT NULL,
    tipo_pago VARCHAR(50) NOT NULL,
    comprobante_url VARCHAR(255),
    estado VARCHAR(20) NOT NULL,
    FOREIGN KEY (id_miembro) REFERENCES Miembros(id_miembro)
);
GO

-- Tabla Renovaciones
CREATE TABLE Renovaciones (
    id_renovacion INT IDENTITY(1,1) PRIMARY KEY,
    id_miembro INT NOT NULL,
    id_pago INT NOT NULL,
    id_documento INT NOT NULL,
    fecha_solicitud DATE NOT NULL,
    fecha_aprobacion DATE,
    estado VARCHAR(20) NOT NULL,
    FOREIGN KEY (id_miembro) REFERENCES Miembros(id_miembro),
    FOREIGN KEY (id_pago) REFERENCES Pagos(id_pago),
    FOREIGN KEY (id_documento) REFERENCES Documentos(id_documento)
);
GO

-- Tabla Usuarios
CREATE TABLE Usuarios (
    id_usuario INT IDENTITY(1,1) PRIMARY KEY,
    id_miembro INT,
    username VARCHAR(50) NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    rol VARCHAR(20) NOT NULL,
    fecha_creacion DATE,
    ultimo_acceso DATE,
    FOREIGN KEY (id_miembro) REFERENCES Miembros(id_miembro)
);
GO

