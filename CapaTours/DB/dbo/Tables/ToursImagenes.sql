CREATE TABLE [dbo].[ToursImagenes] (
    [ImagenID] [bigint] IDENTITY(1,1) PRIMARY KEY,
    [TourID] [bigint] NOT NULL,
    [Imagen] [varchar](1000) NOT NULL,
    CONSTRAINT FK_ToursImagenes_Tours FOREIGN KEY ([TourID]) REFERENCES [dbo].[Tours]([TourID])
)
GO