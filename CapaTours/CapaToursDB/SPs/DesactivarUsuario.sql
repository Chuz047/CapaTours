-- =============================================
-- DESACTIVACIÓN DE USUARIO
-- =============================================

CREATE PROCEDURE [dbo].[DesactivarUsuario]
    @UsuarioID bigint
AS
BEGIN
    UPDATE Usuarios
    SET Estado = 0
    WHERE UsuarioID = @UsuarioID
END
GO