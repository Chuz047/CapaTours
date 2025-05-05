-- =============================================
-- Object:  StoredProcedure [dbo].[ListarResennasPorTour]
-- Script Date: 25-Apr-25 23:52:49
-- =============================================

CREATE PROCEDURE [dbo].[ListarResennasPorTour]
    @TourID BIGINT
AS
BEGIN
    SELECT R.Titulo, R.Contenido, R.Calificacion, U.Nombre AS Usuario
    FROM Resennas R
    INNER JOIN Usuarios U ON R.UsuarioID = U.UsuarioID
    WHERE R.TourID = @TourID;
END;