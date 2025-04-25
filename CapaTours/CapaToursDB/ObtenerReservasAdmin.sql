CREATE OR ALTER PROCEDURE ObtenerReservasAdmin
AS
BEGIN
    SELECT 
        R.ReservaID,
        T.Nombre AS NombreTour,
        U.Nombre AS Cliente,
        U.Identificacion,
        R.CantidadPersonas,
        R.Estado,
        P.Fecha AS FechaComprobante,
        P.Monto AS MontoComprobante
    FROM Reservas R
    INNER JOIN Tours T ON R.TourID = T.TourID
    INNER JOIN Usuarios U ON R.UsuarioID = U.UsuarioID
    LEFT JOIN Pagos P ON R.ReservaID = P.ReservaID
END