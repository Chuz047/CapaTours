-- =============================================
-- Object:  StoredProcedure [dbo].[CrearResenna]
-- Script Date: 25-Apr-25 23:52:49
-- =============================================

CREATE PROCEDURE [dbo].[CrearResenna]
    @UsuarioID     BIGINT,
    @TourID        BIGINT,
    @ReservaID     BIGINT,
    @Calificacion  INT,
    @Titulo        VARCHAR(50),
    @Contenido     VARCHAR(1000)
AS
BEGIN
    INSERT INTO dbo.Resennas (UsuarioID, TourID, ReservaID, Calificacion, Titulo, Contenido)
    VALUES (@UsuarioID, @TourID, @ReservaID, @Calificacion, @Titulo, @Contenido);
END