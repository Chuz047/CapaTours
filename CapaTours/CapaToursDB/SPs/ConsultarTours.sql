-- =============================================
-- CONSULTA DE TOURS
-- =============================================

CREATE PROCEDURE [dbo].[ConsultarTours]
	@TourID BIGINT
AS
BEGIN
	IF (@TourID = 0) 
		SET @TourID = NULL

    SELECT
		TourID,
        Nombre,
        Destino,
        Precio,
        Capacidad,
        FechaInicio,
        FechaFin,
        Estado,
        Descuento
    FROM dbo.Tours
	WHERE TourID = ISNULL(@TourID, TourID)
END
GO