-- =============================================
-- Object:  StoredProcedure [dbo].[PagarReserva]
-- Script Date: 25-Apr-25 23:52:49
-- =============================================

CREATE PROCEDURE [dbo].[RegistrarError]
	@UsuarioID bigint,
	@Mensaje varchar(MAX),
	@Origen varchar(250)
AS
BEGIN
	
	INSERT INTO dbo.AuditoriaErrores(UsuarioID, FechaHora, Mensaje, Origen)
     VALUES (@UsuarioID, GETDATE(), @Mensaje, @Origen)

END;