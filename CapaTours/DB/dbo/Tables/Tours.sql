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