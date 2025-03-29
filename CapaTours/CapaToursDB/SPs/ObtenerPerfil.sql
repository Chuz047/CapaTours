EXEC [dbo].[Login] 
    @correo = 'dvegamarvez@correo.com', 
    @Contrasenna = '123';


	SELECT UsuarioID, Nombre, ApellidoPaterno, ApellidoMaterno, Correo 
FROM dbo.Usuarios
WHERE Correo = 'dvegamarvez@correo.com';

-- Elimina el procedimiento si ya existe
IF OBJECT_ID('dbo.ObtenerUsuarioCompleto', 'P') IS NOT NULL
    DROP PROCEDURE dbo.ObtenerUsuarioCompleto;
GO

-- Crea el procedimiento que devuelve todos los datos del usuario, incluyendo apellidos
CREATE PROCEDURE [dbo].[ObtenerUsuarioCompleto]
    @correo VARCHAR(100)
AS
BEGIN
    SELECT  
        U.UsuarioID,
        U.Identificacion,
        U.Nombre,
        U.ApellidoPaterno,
        U.ApellidoMaterno,
        U.Correo,
        U.Estado,
        U.RolID,
        R.NombreRol AS NombreRol
    FROM dbo.Usuarios U
    INNER JOIN dbo.Roles R ON U.RolID = R.RolID
    WHERE U.Correo = @Correo
END;
GO

EXEC ObtenerUsuarioCompleto @correo = 'dvegamarvez@correo.com';

