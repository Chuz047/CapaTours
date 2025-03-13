CREATE TABLE [dbo].[Pagos] (
    [PagoID] [bigint] IDENTITY(1,1) PRIMARY KEY,
    [ReservaID] [bigint] NOT NULL,
    [Fecha] [datetime] NOT NULL,
    [Comprobante] [varchar](1000) NOT NULL,
    [Monto] [decimal](10,2) NOT NULL,
    CONSTRAINT FK_Pagos_Reservas FOREIGN KEY ([ReservaID]) REFERENCES [dbo].[Reservas]([ReservaID])
)
GO