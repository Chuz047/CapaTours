-- =============================================
-- CONSULTA DE CLIENTES
-- =============================================

CREATE PROCEDURE [dbo].[ConsultarClientes]
	@UsuarioID BIGINT
AS
BEGIN
	IF (@UsuarioID = 0)
		SET @UsuarioID = NULL

	SELECT 
		UsuarioID, 
		Identificacion, 
		Nombre, 
		Correo, 
		Estado
	FROM dbo.Usuarios
	WHERE UsuarioID = ISNULL(@UsuarioID, UsuarioID)
END
GO