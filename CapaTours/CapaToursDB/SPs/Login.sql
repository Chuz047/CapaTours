-- =============================================
-- INICIO DE SESIÓN
-- =============================================

CREATE PROCEDURE [dbo].[Login]
    @correo VARCHAR(100),
    @Contrasenna VARCHAR(255)
AS
BEGIN
    -- Seleccionar los datos del usuario si la identificación y la contraseña coinciden, y si el usuario está activo
    SELECT  U.UsuarioID,
            U.Identificacion,
            U.Nombre 'NombreUsuario',
            U.Correo,
            U.Estado,
            U.RolID,
            R.NombreRol 'NombreRol'
    FROM    dbo.Usuarios U
    INNER JOIN dbo.Roles R ON U.RolID = R.RolID
    WHERE   U.Correo = @Correo
            AND U.Contrasenna = @Contrasenna
            AND U.Estado = 1 -- Solo usuarios activos
END
GO