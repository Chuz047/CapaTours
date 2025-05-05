-- =============================================
-- Object:  StoredProcedure [dbo].[ConsultarReserva]
-- Script Date: 25-Apr-25 23:52:49
-- =============================================

CREATE PROCEDURE [dbo].[ConsultarReserva]
    @ReservaID BIGINT
AS
BEGIN
    SELECT
        R.ReservaID,
        R.UsuarioID,
        R.TourID,
        R.CantidadPersonas,
        R.Estado,
        T.Nombre AS NombreTour,
        T.Precio,
        T.FechaInicio,
        T.FechaFin,
        U.Nombre,
        U.Correo
    FROM dbo.Reservas R
    INNER JOIN dbo.Tours T ON R.TourID = T.TourID
    INNER JOIN dbo.Usuarios U ON R.UsuarioID = U.UsuarioID 
    WHERE R.ReservaID = @ReservaID;
END;