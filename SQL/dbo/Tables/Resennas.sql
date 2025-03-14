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
