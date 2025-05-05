-- =============================================
-- Object:  StoredProcedure [dbo].[AnularReserva]
-- Script Date: 25-Apr-25 23:52:49
-- =============================================

CREATE   PROCEDURE [dbo].[AnularReserva]
    @ReservaID BIGINT
AS
BEGIN
    UPDATE Reservas
    SET Estado = 'Cancelado'
    WHERE ReservaID = @ReservaID;
END