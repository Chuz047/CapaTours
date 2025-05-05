-- =============================================
-- Object:  StoredProcedure [dbo].[PagarReserva]
-- Script Date: 25-Apr-25 23:52:49
-- =============================================

CREATE PROCEDURE [dbo].[PagarReserva]
    @ReservaID INT,
    @Comprobante NVARCHAR(MAX),
    @Monto DECIMAL(10, 2),
    @CantidadPersonas INT
AS
BEGIN
    INSERT INTO Pagos (ReservaID, Comprobante, Monto, Fecha)
    VALUES (@ReservaID, @Comprobante, @Monto, GETDATE());

    UPDATE Reservas
    SET Estado = 'Confirmado',
        CantidadPersonas = @CantidadPersonas
    WHERE ReservaID = @ReservaID;
END;