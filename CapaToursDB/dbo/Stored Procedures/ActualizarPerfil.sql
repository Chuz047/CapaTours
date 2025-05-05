-- =============================================
-- Object:  StoredProcedure [dbo].[ActivarUsuario]
-- Script Date: 25-Apr-25 23:52:49
-- =============================================

CREATE PROCEDURE [dbo].[ActualizarPerfil]
    @UsuarioID BIGINT,
    @Correo VARCHAR(100)
AS
BEGIN
    UPDATE Usuarios
    SET Correo = @Correo
    WHERE UsuarioID = @UsuarioID AND Estado = 1;
END;