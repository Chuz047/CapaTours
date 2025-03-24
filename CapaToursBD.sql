﻿USE [master]
GO

-- Crear la base de datos
CREATE DATABASE [CapaToursBD]
GO

-- Usar la base de datos
USE [CapaToursBD]
GO

-------- Creación de tablas --------

-- Tabla de roles
CREATE TABLE [dbo].[Roles] (
	[RolID] [bigint] IDENTITY(1,1) PRIMARY KEY,
	[NombreRol] [varchar](50) NOT NULL
)
GO

SELECT * FROM dbo.Roles;

SELECT * FROM dbo.Roles WHERE RolID = 1;

SELECT DB_NAME();

SELECT * FROM dbo.Usuarios;
-- Tabla de usuarios
CREATE TABLE [dbo].[Usuarios] (
    [UsuarioID] [bigint] IDENTITY(1,1) PRIMARY KEY,
    [Identificacion] [varchar](15) UNIQUE NOT NULL,
    [Nombre] [varchar](50) NOT NULL,
    [ApellidoPaterno] [varchar](50) NOT NULL,
    [ApellidoMaterno] [varchar](50) NOT NULL,
    [Correo] [varchar](100) UNIQUE NOT NULL,
    [Contrasenna] [varchar](255) NOT NULL,
    [TieneContrasennaTemp] [bit] NULL,
    [FechaVencimientoTemp] [datetime] NULL,
    [Estado] [bit] NOT NULL DEFAULT(1),
	[RolID] [bigint] NOT NULL,
    CONSTRAINT FK_Usuarios_Roles FOREIGN KEY ([RolID]) REFERENCES [dbo].[Roles] ([RolID])
)
GO

INSERT INTO Usuarios (Identificacion, Nombre, ApellidoPaterno, ApellidoMaterno, Correo, Contrasenna, TieneContrasennaTemp, FechaVencimientoTemp, Estado, RolID)
VALUES ('402660567', 'Brenda', 'Rojas', 'Cortés', 'brenkaco29@gmail.com', 'brojas291002004', 0, NULL, 1, 1);


-- Tabla de tours
CREATE TABLE [dbo].[Tours] (
    [TourID] [bigint] IDENTITY(1,1) PRIMARY KEY,
    [Nombre] [varchar](50) NOT NULL,
    [Destino] [varchar](255) NOT NULL,
    [Descripcion] [varchar](1000) NOT NULL,
    [Itinerario] [varchar](1000) NOT NULL,
    [Precio] [decimal](10,2) NOT NULL,
    [Capacidad] [int] NOT NULL,
    [FechaInicio] [datetime] NOT NULL,
    [FechaFin] [datetime] NOT NULL,
    [Estado] [bit] NOT NULL DEFAULT(1),
    [Descuento] [decimal](3,1) NULL
)
GO

-- Tabla de reservas
CREATE TABLE [dbo].[Reservas] (
    [ReservaID] [bigint] IDENTITY(1,1) PRIMARY KEY,
    [UsuarioID] [bigint] NOT NULL,
    [TourID] [bigint] NOT NULL,
    [CantidadPersonas] [int] NOT NULL,
    [Estado] [varchar](50) NOT NULL DEFAULT('En Espera'),
	CONSTRAINT CHK_Reservas_Estado CHECK ([Estado] IN ('En Espera', 'Confirmado', 'Cancelado', 'Completado')),
    CONSTRAINT FK_Reservas_Usuarios FOREIGN KEY ([UsuarioID]) REFERENCES [dbo].[Usuarios]([UsuarioID]),
    CONSTRAINT FK_Reservas_Tours FOREIGN KEY ([TourID]) REFERENCES [dbo].[Tours]([TourID])
)
GO

-- Tabla de pagos
CREATE TABLE [dbo].[Pagos] (
    [PagoID] [bigint] IDENTITY(1,1) PRIMARY KEY,
    [ReservaID] [bigint] NOT NULL,
    [Fecha] [datetime] NOT NULL,
    [Comprobante] [varchar](1000) NOT NULL,
    [Monto] [decimal](10,2) NOT NULL,
    CONSTRAINT FK_Pagos_Reservas FOREIGN KEY ([ReservaID]) REFERENCES [dbo].[Reservas]([ReservaID])
)
GO

-- Tabla de reseñas
CREATE TABLE [dbo].[Resennas] (
    [ResennaID] [bigint] IDENTITY(1,1) PRIMARY KEY,
    [UsuarioID] [bigint] NOT NULL,
    [TourID] [bigint] NOT NULL,
    [ReservaID] [bigint] NOT NULL,
    [Calificacion] [int] NOT NULL,
    [Titulo] [varchar](50) NOT NULL,
    [Contenido] [varchar](1000) NOT NULL,
	CONSTRAINT CHK_Resennas_Calificacion CHECK ([Calificacion] BETWEEN 1 AND 5),
    CONSTRAINT FK_Resennas_Usuarios FOREIGN KEY ([UsuarioID]) REFERENCES [dbo].[Usuarios]([UsuarioID]),
    CONSTRAINT FK_Resennas_Tours FOREIGN KEY ([TourID]) REFERENCES [dbo].[Tours]([TourID]),
    CONSTRAINT FK_Resennas_Reservas FOREIGN KEY ([ReservaID]) REFERENCES [dbo].[Reservas]([ReservaID])
)
GO

-- Tabla de imágenes para tours
CREATE TABLE [dbo].[ToursImagenes] (
    [ImagenID] [bigint] IDENTITY(1,1) PRIMARY KEY,
    [TourID] [bigint] NOT NULL,
    [Imagen] [varchar](1000) NOT NULL,
    CONSTRAINT FK_ToursImagenes_Tours FOREIGN KEY ([TourID]) REFERENCES [dbo].[Tours]([TourID])
)
GO

-- Tabla de errores
CREATE TABLE [dbo].[AuditoriaErrores] (
	[ErrorID] [bigint] IDENTITY(1,1) PRIMARY KEY,
	[Mensaje] [varchar](4000) NOT NULL,
	[Fecha] [datetime] NOT NULL DEFAULT(GETDATE())
)
GO


CREATE PROCEDURE [dbo].[Login]
    @correo VARCHAR(15),
    @Contrasenna VARCHAR(50)
AS
BEGIN
   
    SELECT  U.UsuarioID,
            U.Identificacion,
            U.Nombre 'NombreUsuario',
            U.Correo,
            U.Estado,
            U.RolID,
            R.NombreRol 'NombreRol'
    FROM    dbo.Usuarios U
    INNER JOIN dbo.Roles R ON U.RolID = R.RolID
    WHERE   U.Correo = @Correo
            AND U.Contrasenna = @Contrasenna
            AND U.Estado = 1 s
END
GO


CREATE PROCEDURE [dbo].[Registro]
    @Identificacion VARCHAR(15),
    @Nombre VARCHAR(50),
    @ApellidoPaterno VARCHAR(250),
    @ApellidoMaterno VARCHAR(100),
    @Correo VARCHAR(100),
    @Contrasenna VARCHAR(100),
    @RolID BIGINT 
AS
BEGIN
   
    IF NOT EXISTS(SELECT 1 FROM dbo.Usuarios WHERE Identificacion = @Identificacion OR Correo = @Correo)
    BEGIN
        
        INSERT INTO dbo.Usuarios (Identificacion, Contrasenna, Nombre, ApellidoPaterno, ApellidoMaterno, Correo, Estado, RolID)
        VALUES (@Identificacion, @Contrasenna, @Nombre, @ApellidoPaterno, @ApellidoMaterno, @Correo, 1, @RolID);
        
        PRINT 
    END
    ELSE
    BEGIN
        PRINT 
    END
END
GO

DROP PROCEDURE IF EXISTS [dbo].[Registro];
GO
