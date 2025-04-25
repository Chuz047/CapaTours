CREATE OR ALTER PROCEDURE AnularReserva
    @ReservaID BIGINT
AS
BEGIN
    UPDATE Reservas
    SET Estado = 'Cancelado'
    WHERE ReservaID = @ReservaID;
END
GO
