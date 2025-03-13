CREATE TABLE [dbo].[Usuarios] (
    [UsuarioID] [bigint] IDENTITY(1,1) PRIMARY KEY,
    [Identificacion] [varchar](15) UNIQUE NOT NULL,
    [Nombre] [varchar](50) NOT NULL,
    [ApellidoPaterno] [varchar](50) NOT NULL,
    [ApellidoMaterno] [varchar](50) NOT NULL,
    [Correo] [varchar](100) UNIQUE NOT NULL,
    [Contrasenna] [varchar](255) NOT NULL,
    [TieneContrasennaTemp] [bit] NULL,
    [FechaVencimientoTemp] [datetime] NULL,
    [Estado] [bit] NOT NULL DEFAULT(1),
	[RolID] [bigint] NOT NULL,
    CONSTRAINT FK_Usuarios_Roles FOREIGN KEY ([RolID]) REFERENCES [dbo].[Roles] ([RolID])
)
GO