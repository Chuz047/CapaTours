ALTER PROCEDURE ActualizarPerfil
    @UsuarioID BIGINT,
    @Correo VARCHAR(100)
AS
BEGIN
    UPDATE Usuarios
    SET Correo = @Correo
    WHERE UsuarioID = @UsuarioID AND Estado = 1;
END;
GO