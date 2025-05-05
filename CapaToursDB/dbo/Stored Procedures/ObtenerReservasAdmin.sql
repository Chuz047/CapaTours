-- =============================================
-- Object:  StoredProcedure [dbo].[ObtenerReservasAdmin]
-- Script Date: 25-Apr-25 23:52:49
-- =============================================

CREATE PROCEDURE [dbo].[ObtenerReservasAdmin]
AS
BEGIN
    SELECT 
        R.ReservaID,
        T.Nombre AS NombreTour,
        U.Nombre AS Cliente,
        U.Identificacion,
        R.CantidadPersonas,
        R.Estado,
        T.Precio,
        T.FechaInicio,
        T.FechaFin,
        P.Fecha AS FechaComprobante,
        P.Monto AS MontoComprobante,
		P.Comprobante
    FROM Reservas R
    INNER JOIN Tours T ON R.TourID = T.TourID
    INNER JOIN Usuarios U ON R.UsuarioID = U.UsuarioID
    LEFT JOIN Pagos P ON R.ReservaID = P.ReservaID
    ORDER BY 
        CASE R.Estado
            WHEN 'Confirmado' THEN 0
            WHEN 'Completado' THEN 1
            WHEN 'En Espera' THEN 2
            WHEN 'Cancelado' THEN 3
            ELSE 4
        END
END;