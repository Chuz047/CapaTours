-- =============================================
-- ACTIVACIÓN DE USUARIO
-- =============================================

CREATE PROCEDURE [dbo].[ActivarUsuario]
    @UsuarioID bigint
AS
BEGIN
    UPDATE Usuarios
    SET Estado = 1
    WHERE UsuarioID = @UsuarioID
END
GO