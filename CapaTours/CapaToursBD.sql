USE [master]
GO

-- Crear la base de datos
CREATE DATABASE [CapaToursBD]
GO

-- Usar la base de datos
/*USE [CapaToursBD]
GO*/

-------- Creación de tablas --------

-- Tabla de usuarios
CREATE TABLE [dbo].[Usuarios] (
    [UsuarioID] [bigint] IDENTITY(1,1) PRIMARY KEY,
    [Identificacion] [varchar](15) UNIQUE NOT NULL,
    [Nombre] [varchar](250) NOT NULL,
    [ApellidoPaterno] [varchar](250) NOT NULL,
    [ApellidoMaterno] [varchar](250) NOT NULL,
    [Correo] [varchar](100) UNIQUE NOT NULL,
    [Contrasenna] [varchar](255) NOT NULL,
    [TieneContrasennaTemp] [bit] NOT NULL,
    [FechaVencimientoTemp] [datetime] NOT NULL,
    [EsAdmin] [bit] NOT NULL,
    [Estado] [bit] NOT NULL
)
GO

-- Tabla de tours
CREATE TABLE [dbo].[Tours] (
    [TourID] [bigint] IDENTITY(1,1) PRIMARY KEY,
    [Nombre] [varchar](250) NOT NULL,
    [Destino] [varchar](100) NOT NULL,
    [Descripcion] [varchar](MAX) NOT NULL,
    [Itinerario] [varchar](MAX) NOT NULL,
    [Precio] [decimal](10,2) NOT NULL,
    [Capacidad] [int] NOT NULL,
    [FechaInicio] [date] NOT NULL,
    [FechaFin] [date] NOT NULL,
    [Estado] [bit] NOT NULL,
    [Descuento] [decimal](5,2) NOT NULL
)
GO

-- Tabla de reservas
CREATE TABLE [dbo].[Reservas] (
    [ReservaID] [bigint] IDENTITY(1,1) PRIMARY KEY,
    [UsuarioID] [bigint] NOT NULL,
    [TourID] [bigint] NOT NULL,
    [CantidadPersonas] [int] NOT NULL,
    [Estado] [varchar](50) NOT NULL,
    CONSTRAINT FK_Reservas_Usuarios FOREIGN KEY ([UsuarioID]) REFERENCES [dbo].[Usuarios]([UsuarioID]) ON DELETE CASCADE,
    CONSTRAINT FK_Reservas_Tours FOREIGN KEY ([TourID]) REFERENCES [dbo].[Tours]([TourID]) ON DELETE CASCADE
)
GO

-- Tabla de pagos
CREATE TABLE [dbo].[Pagos] (
    [PagoID] [bigint] IDENTITY(1,1) PRIMARY KEY,
    [ReservaID] [bigint] NOT NULL,
    [Fecha] [datetime] NOT NULL,
    [Comprobante] [varchar](255) NOT NULL,
    [Monto] [decimal](10,2) NOT NULL,
    CONSTRAINT FK_Pagos_Reservas FOREIGN KEY ([ReservaID]) REFERENCES [dbo].[Reservas]([ReservaID]) ON DELETE CASCADE
)
GO

-- Tabla de reseñas
CREATE TABLE [dbo].[Resennas] (
    [ResennaID] [bigint] IDENTITY(1,1) PRIMARY KEY,
    [UsuarioID] [bigint] NOT NULL,
    [TourID] [bigint] NOT NULL,
    [ReservaID] [bigint] NOT NULL,
    [Calificacion] [int] NOT NULL CHECK ([Calificacion] BETWEEN 1 AND 5),
    [Titulo] [varchar](255) NOT NULL,
    [Contenido] [varchar](MAX) NOT NULL,
    CONSTRAINT FK_Resennas_Usuarios FOREIGN KEY ([UsuarioID]) REFERENCES [dbo].[Usuarios]([UsuarioID]) ON DELETE CASCADE,
    CONSTRAINT FK_Resennas_Tours FOREIGN KEY ([TourID]) REFERENCES [dbo].[Tours]([TourID]) ON DELETE CASCADE,
    CONSTRAINT FK_Resennas_Reservas FOREIGN KEY ([ReservaID]) REFERENCES [dbo].[Reservas]([ReservaID]) ON DELETE CASCADE
)
GO

-- Tabla de imágenes para tours
CREATE TABLE [dbo].[ToursImagenes] (
    [ImagenID] [bigint] IDENTITY(1,1) PRIMARY KEY,
    [TourID] [bigint] NOT NULL,
    [Imagen] [varbinary](MAX) NOT NULL,
    CONSTRAINT FK_ToursImagenes_Tours FOREIGN KEY ([TourID]) REFERENCES [dbo].[Tours]([TourID]) ON DELETE CASCADE
)
GO
