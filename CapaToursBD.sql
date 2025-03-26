USE [CapaToursBD]
GO
/****** Object:  Table [dbo].[AuditoriaErrores]    Script Date: 3/23/2025 9:57:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AuditoriaErrores](
	[ErrorID] [bigint] IDENTITY(1,1) NOT NULL,
	[Mensaje] [varchar](4000) NOT NULL,
	[Fecha] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ErrorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pagos]    Script Date: 3/23/2025 9:57:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pagos](
	[PagoID] [bigint] IDENTITY(1,1) NOT NULL,
	[ReservaID] [bigint] NOT NULL,
	[Fecha] [datetime] NOT NULL,
	[Comprobante] [varchar](1000) NOT NULL,
	[Monto] [decimal](10, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PagoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Resennas]    Script Date: 3/23/2025 9:57:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Resennas](
	[ResennaID] [bigint] IDENTITY(1,1) NOT NULL,
	[UsuarioID] [bigint] NOT NULL,
	[TourID] [bigint] NOT NULL,
	[ReservaID] [bigint] NOT NULL,
	[Calificacion] [int] NOT NULL,
	[Titulo] [varchar](50) NOT NULL,
	[Contenido] [varchar](1000) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ResennaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Reservas]    Script Date: 3/23/2025 9:57:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reservas](
	[ReservaID] [bigint] IDENTITY(1,1) NOT NULL,
	[UsuarioID] [bigint] NOT NULL,
	[TourID] [bigint] NOT NULL,
	[CantidadPersonas] [int] NOT NULL,
	[Estado] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ReservaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 3/23/2025 9:57:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[RolID] [bigint] IDENTITY(1,1) NOT NULL,
	[NombreRol] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RolID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tours]    Script Date: 3/23/2025 9:57:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tours](
	[TourID] [bigint] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[Destino] [varchar](255) NOT NULL,
	[Descripcion] [varchar](1000) NOT NULL,
	[Itinerario] [varchar](1000) NOT NULL,
	[Precio] [decimal](10, 2) NOT NULL,
	[Capacidad] [int] NOT NULL,
	[FechaInicio] [datetime] NOT NULL,
	[FechaFin] [datetime] NOT NULL,
	[Estado] [bit] NOT NULL,
	[Descuento] [decimal](3, 1) NULL,
PRIMARY KEY CLUSTERED 
(
	[TourID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ToursImagenes]    Script Date: 3/23/2025 9:57:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ToursImagenes](
	[ImagenID] [bigint] IDENTITY(1,1) NOT NULL,
	[TourID] [bigint] NOT NULL,
	[Imagen] [varchar](1000) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ImagenID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuarios]    Script Date: 3/23/2025 9:57:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuarios](
	[UsuarioID] [bigint] IDENTITY(1,1) NOT NULL,
	[Identificacion] [varchar](15) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[ApellidoPaterno] [varchar](50) NOT NULL,
	[ApellidoMaterno] [varchar](50) NOT NULL,
	[Correo] [varchar](100) NOT NULL,
	[Contrasenna] [varchar](255) NOT NULL,
	[TieneContrasennaTemp] [bit] NULL,
	[FechaVencimientoTemp] [datetime] NULL,
	[Estado] [bit] NOT NULL,
	[RolID] [bigint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UsuarioID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Roles] ON 

INSERT [dbo].[Roles] ([RolID], [NombreRol]) VALUES (1, N'Administrador')
INSERT [dbo].[Roles] ([RolID], [NombreRol]) VALUES (2, N'Usuario')
SET IDENTITY_INSERT [dbo].[Roles] OFF
GO
SET IDENTITY_INSERT [dbo].[Usuarios] ON 

INSERT [dbo].[Usuarios] ([UsuarioID], [Identificacion], [Nombre], [ApellidoPaterno], [ApellidoMaterno], [Correo], [Contrasenna], [TieneContrasennaTemp], [FechaVencimientoTemp], [Estado], [RolID]) VALUES (2, N'402660567', N'Brenda', N'Rojas', N'Cortés', N'brenkaco29@gmail.com', N'brojas291002004', 0, NULL, 1, 1)
INSERT [dbo].[Usuarios] ([UsuarioID], [Identificacion], [Nombre], [ApellidoPaterno], [ApellidoMaterno], [Correo], [Contrasenna], [TieneContrasennaTemp], [FechaVencimientoTemp], [Estado], [RolID]) VALUES (7, N'117310079', N'Daniel', N'Vega', N'Marvez', N'dvegamarvez@correo.com', N'123', NULL, NULL, 1, 1)
SET IDENTITY_INSERT [dbo].[Usuarios] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Usuarios__60695A19341AEF26]    Script Date: 3/23/2025 9:57:15 PM ******/
ALTER TABLE [dbo].[Usuarios] ADD UNIQUE NONCLUSTERED 
(
	[Correo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Usuarios__D6F931E5193F88C2]    Script Date: 3/23/2025 9:57:15 PM ******/
ALTER TABLE [dbo].[Usuarios] ADD UNIQUE NONCLUSTERED 
(
	[Identificacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AuditoriaErrores] ADD  DEFAULT (getdate()) FOR [Fecha]
GO
ALTER TABLE [dbo].[Reservas] ADD  DEFAULT ('En Espera') FOR [Estado]
GO
ALTER TABLE [dbo].[Tours] ADD  DEFAULT ((1)) FOR [Estado]
GO
ALTER TABLE [dbo].[Usuarios] ADD  DEFAULT ((1)) FOR [Estado]
GO
ALTER TABLE [dbo].[Pagos]  WITH CHECK ADD  CONSTRAINT [FK_Pagos_Reservas] FOREIGN KEY([ReservaID])
REFERENCES [dbo].[Reservas] ([ReservaID])
GO
ALTER TABLE [dbo].[Pagos] CHECK CONSTRAINT [FK_Pagos_Reservas]
GO
ALTER TABLE [dbo].[Resennas]  WITH CHECK ADD  CONSTRAINT [FK_Resennas_Reservas] FOREIGN KEY([ReservaID])
REFERENCES [dbo].[Reservas] ([ReservaID])
GO
ALTER TABLE [dbo].[Resennas] CHECK CONSTRAINT [FK_Resennas_Reservas]
GO
ALTER TABLE [dbo].[Resennas]  WITH CHECK ADD  CONSTRAINT [FK_Resennas_Tours] FOREIGN KEY([TourID])
REFERENCES [dbo].[Tours] ([TourID])
GO
ALTER TABLE [dbo].[Resennas] CHECK CONSTRAINT [FK_Resennas_Tours]
GO
ALTER TABLE [dbo].[Resennas]  WITH CHECK ADD  CONSTRAINT [FK_Resennas_Usuarios] FOREIGN KEY([UsuarioID])
REFERENCES [dbo].[Usuarios] ([UsuarioID])
GO
ALTER TABLE [dbo].[Resennas] CHECK CONSTRAINT [FK_Resennas_Usuarios]
GO
ALTER TABLE [dbo].[Reservas]  WITH CHECK ADD  CONSTRAINT [FK_Reservas_Tours] FOREIGN KEY([TourID])
REFERENCES [dbo].[Tours] ([TourID])
GO
ALTER TABLE [dbo].[Reservas] CHECK CONSTRAINT [FK_Reservas_Tours]
GO
ALTER TABLE [dbo].[Reservas]  WITH CHECK ADD  CONSTRAINT [FK_Reservas_Usuarios] FOREIGN KEY([UsuarioID])
REFERENCES [dbo].[Usuarios] ([UsuarioID])
GO
ALTER TABLE [dbo].[Reservas] CHECK CONSTRAINT [FK_Reservas_Usuarios]
GO
ALTER TABLE [dbo].[ToursImagenes]  WITH CHECK ADD  CONSTRAINT [FK_ToursImagenes_Tours] FOREIGN KEY([TourID])
REFERENCES [dbo].[Tours] ([TourID])
GO
ALTER TABLE [dbo].[ToursImagenes] CHECK CONSTRAINT [FK_ToursImagenes_Tours]
GO
ALTER TABLE [dbo].[Usuarios]  WITH CHECK ADD  CONSTRAINT [FK_Usuarios_Roles] FOREIGN KEY([RolID])
REFERENCES [dbo].[Roles] ([RolID])
GO
ALTER TABLE [dbo].[Usuarios] CHECK CONSTRAINT [FK_Usuarios_Roles]
GO
ALTER TABLE [dbo].[Resennas]  WITH CHECK ADD  CONSTRAINT [CHK_Resennas_Calificacion] CHECK  (([Calificacion]>=(1) AND [Calificacion]<=(5)))
GO
ALTER TABLE [dbo].[Resennas] CHECK CONSTRAINT [CHK_Resennas_Calificacion]
GO
ALTER TABLE [dbo].[Reservas]  WITH CHECK ADD  CONSTRAINT [CHK_Reservas_Estado] CHECK  (([Estado]='Completado' OR [Estado]='Cancelado' OR [Estado]='Confirmado' OR [Estado]='En Espera'))
GO
ALTER TABLE [dbo].[Reservas] CHECK CONSTRAINT [CHK_Reservas_Estado]
GO
/****** Object:  StoredProcedure [dbo].[Login]    Script Date: 3/23/2025 9:57:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Procedimiento para Iniciar Sesión
CREATE PROCEDURE [dbo].[Login]
    @correo VARCHAR(15),
    @Contrasenna VARCHAR(50)
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
/****** Object:  StoredProcedure [dbo].[Registro]    Script Date: 3/23/2025 9:57:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Procedimiento para Registrar Cuenta
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
