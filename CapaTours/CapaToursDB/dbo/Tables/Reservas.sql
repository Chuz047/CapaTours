-- =============================================
-- RESERVAS
-- =============================================

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