-- =============================================
-- REGISTRO DE CUENTAS
-- =============================================

CREATE PROCEDURE [dbo].[Registro]
    @Identificacion VARCHAR(15),
    @Nombre VARCHAR(50),
    @ApellidoPaterno VARCHAR(50),
    @ApellidoMaterno VARCHAR(50),
    @Correo VARCHAR(100),
    @Contrasenna VARCHAR(255)
AS
BEGIN
    -- Verificar si la identificación o el correo ya existen en la base de datos
    IF NOT EXISTS(SELECT 1 FROM dbo.Usuarios WHERE Identificacion = @Identificacion OR Correo = @Correo)
    BEGIN
        -- Si no existe, insertar el nuevo usuario con el estado activo (1) y el RolID de usuario (2)
        INSERT INTO dbo.Usuarios (Identificacion, Contrasenna, Nombre, ApellidoPaterno, ApellidoMaterno, Correo, Estado, RolID)
        VALUES (@Identificacion, @Contrasenna, @Nombre, @ApellidoPaterno, @ApellidoMaterno, @Correo, 1, 2);
        
        PRINT 'Cuenta registrada correctamente.'
    END
    ELSE
    BEGIN
        PRINT 'La identificación o el correo ya están registrados.'
    END
END
GO