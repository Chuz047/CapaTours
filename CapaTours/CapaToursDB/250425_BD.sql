USE [CapaToursBD]
GO
/****** Object:  Table [dbo].[AuditoriaErrores]    Script Date: 25-Apr-25 23:52:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AuditoriaErrores](
	[ErrorID] [bigint] IDENTITY(1,1) NOT NULL,
	[UsuarioID] [bigint] NOT NULL,
	[FechaHora] [datetime] NOT NULL,
	[Mensaje] [varchar](max) NOT NULL,
	[Origen] [varchar](250) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pagos]    Script Date: 25-Apr-25 23:52:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pagos](
	[PagoID] [bigint] IDENTITY(1,1) NOT NULL,
	[ReservaID] [bigint] NOT NULL,
	[Fecha] [datetime] NOT NULL,
	[Comprobante] [nvarchar](max) NULL,
	[Monto] [decimal](10, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PagoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Resennas]    Script Date: 25-Apr-25 23:52:49 ******/
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
/****** Object:  Table [dbo].[Reservas]    Script Date: 25-Apr-25 23:52:49 ******/
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
/****** Object:  Table [dbo].[Roles]    Script Date: 25-Apr-25 23:52:49 ******/
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
/****** Object:  Table [dbo].[Tours]    Script Date: 25-Apr-25 23:52:49 ******/
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
	[FechaInicio] [datetime] NULL,
	[FechaFin] [datetime] NULL,
	[Estado] [bit] NOT NULL,
	[Descuento] [decimal](3, 1) NULL,
	[Imagen] [varchar](1000) NULL,
PRIMARY KEY CLUSTERED 
(
	[TourID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuarios]    Script Date: 25-Apr-25 23:52:49 ******/
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
SET IDENTITY_INSERT [dbo].[AuditoriaErrores] ON 

INSERT [dbo].[AuditoriaErrores] ([ErrorID], [UsuarioID], [FechaHora], [Mensaje], [Origen]) VALUES (1, 1, CAST(N'2025-04-25T11:19:36.210' AS DateTime), N'Error generado intencionalmente para prueba.', N'PruebaErrorController')
SET IDENTITY_INSERT [dbo].[AuditoriaErrores] OFF
GO
SET IDENTITY_INSERT [dbo].[Roles] ON 

INSERT [dbo].[Roles] ([RolID], [NombreRol]) VALUES (1, N'Administrador')
INSERT [dbo].[Roles] ([RolID], [NombreRol]) VALUES (2, N'Usuario')
SET IDENTITY_INSERT [dbo].[Roles] OFF
GO
SET IDENTITY_INSERT [dbo].[Tours] ON 

INSERT [dbo].[Tours] ([TourID], [Nombre], [Destino], [Descripcion], [Itinerario], [Precio], [Capacidad], [FechaInicio], [FechaFin], [Estado], [Descuento], [Imagen]) VALUES (1, N'Aventura en Volcán Arenal', N'La Fortuna, Alajuela', N'Explora el imponente Volcán Arenal y disfruta de aguas termales naturales.', N'Día 1: llegada y senderismo, Día 2: aguas termales, Día 3: tour de canopy.', CAST(62400.00 AS Decimal(10, 2)), 25, CAST(N'2025-05-15T00:00:00.000' AS DateTime), CAST(N'2025-05-17T00:00:00.000' AS DateTime), 1, CAST(10.0 AS Decimal(3, 1)), N'/img/tours/7e875af4-564d-4a42-9bf2-beae0b98f8cc.jpg')
INSERT [dbo].[Tours] ([TourID], [Nombre], [Destino], [Descripcion], [Itinerario], [Precio], [Capacidad], [FechaInicio], [FechaFin], [Estado], [Descuento], [Imagen]) VALUES (2, N'Tour Catarata La Paz', N'Vara Blanca, Heredia', N'Visita a una de las cataratas más impresionantes rodeadas de jardines tropicales.', N'Día 1: jardines y mariposario, Día 2: visita a la catarata, Día 3: tour de colibríes.', CAST(44460.00 AS Decimal(10, 2)), 20, CAST(N'2025-05-18T00:00:00.000' AS DateTime), CAST(N'2025-05-20T00:00:00.000' AS DateTime), 1, CAST(5.0 AS Decimal(3, 1)), N'/img/tours/c417bcdf-e8e6-4466-9c1a-05fc5442665c.jpg')
INSERT [dbo].[Tours] ([TourID], [Nombre], [Destino], [Descripcion], [Itinerario], [Precio], [Capacidad], [FechaInicio], [FechaFin], [Estado], [Descuento], [Imagen]) VALUES (3, N'Expedición Corcovado', N'Parque Nacional Corcovado, Osa', N'Descubre la biodiversidad única del Parque Nacional Corcovado en una expedición guiada.', N'Día 1: traslado a Drake Bay, Día 2: caminata parque nacional, Día 3: visita a playa escondida.', CAST(182000.00 AS Decimal(10, 2)), 15, CAST(N'2025-06-10T00:00:00.000' AS DateTime), CAST(N'2025-06-12T00:00:00.000' AS DateTime), 1, CAST(0.0 AS Decimal(3, 1)), N'/img/tours/298a6c89-d7e7-4707-a633-acf8716c578c.jpg')
INSERT [dbo].[Tours] ([TourID], [Nombre], [Destino], [Descripcion], [Itinerario], [Precio], [Capacidad], [FechaInicio], [FechaFin], [Estado], [Descuento], [Imagen]) VALUES (4, N'Aventura Canopy Monteverde', N'Monteverde, Puntarenas', N'Vive la emoción de deslizarte en canopy por el bosque nuboso de Monteverde.', N'Día 1: llegada y tour de puentes colgantes, Día 2: canopy extremo, Día 3: tour de café.', CAST(49400.00 AS Decimal(10, 2)), 30, CAST(N'2025-05-22T00:00:00.000' AS DateTime), CAST(N'2025-05-24T00:00:00.000' AS DateTime), 1, CAST(7.5 AS Decimal(3, 1)), N'/img/tours/0f4dce6e-c3c7-46c0-9dca-7904bfd126e3.jpg')
INSERT [dbo].[Tours] ([TourID], [Nombre], [Destino], [Descripcion], [Itinerario], [Precio], [Capacidad], [FechaInicio], [FechaFin], [Estado], [Descuento], [Imagen]) VALUES (5, N'Rafting Río Pacuare', N'Turrialba, Cartago', N'Experimenta la adrenalina de uno de los mejores ríos de rafting del mundo.', N'Día 1: introducción y preparación, Día 2: rafting y campamento, Día 3: rafting final.', CAST(67600.00 AS Decimal(10, 2)), 12, CAST(N'2025-05-25T00:00:00.000' AS DateTime), CAST(N'2025-05-27T00:00:00.000' AS DateTime), 1, CAST(8.0 AS Decimal(3, 1)), N'/img/tours/90c0a0f7-7fa5-4e9c-81e1-1e7a9bda9257.jpg')
INSERT [dbo].[Tours] ([TourID], [Nombre], [Destino], [Descripcion], [Itinerario], [Precio], [Capacidad], [FechaInicio], [FechaFin], [Estado], [Descuento], [Imagen]) VALUES (6, N'Tour de Café Doka Estate', N'Sabanilla, Alajuela', N'Conoce todo sobre la producción del café costarricense en una auténtica finca.', N'Día 1: visita a cafetal, Día 2: proceso de beneficio y tostado, Día 3: degustación premium.', CAST(23400.00 AS Decimal(10, 2)), 40, CAST(N'2025-05-30T00:00:00.000' AS DateTime), CAST(N'2025-06-01T00:00:00.000' AS DateTime), 1, CAST(0.0 AS Decimal(3, 1)), N'/img/tours/4b03008c-dd96-4eb4-9026-60e3eff10d87.jpg')
INSERT [dbo].[Tours] ([TourID], [Nombre], [Destino], [Descripcion], [Itinerario], [Precio], [Capacidad], [FechaInicio], [FechaFin], [Estado], [Descuento], [Imagen]) VALUES (7, N'Safari Flotante Río Peñas Blancas', N'La Fortuna, Alajuela', N'Relájate en un safari flotante por el río, observando fauna silvestre.', N'Día 1: traslado y preparación, Día 2: safari de día completo, Día 3: safari temprano matutino.', CAST(39000.00 AS Decimal(10, 2)), 18, CAST(N'2025-06-05T00:00:00.000' AS DateTime), CAST(N'2025-06-07T00:00:00.000' AS DateTime), 1, CAST(5.0 AS Decimal(3, 1)), N'/img/tours/a5688c4c-7a4c-42fb-8a60-70fb9428b54b.jpg')
INSERT [dbo].[Tours] ([TourID], [Nombre], [Destino], [Descripcion], [Itinerario], [Precio], [Capacidad], [FechaInicio], [FechaFin], [Estado], [Descuento], [Imagen]) VALUES (8, N'Isla Tortuga Tour', N'Golfo de Nicoya, Puntarenas', N'Disfruta un día en una isla paradisíaca con arena blanca y aguas cristalinas.', N'Día 1: navegación y snorkel, Día 2: paseo en kayak y relax, Día 3: tour de pesca.', CAST(72800.00 AS Decimal(10, 2)), 50, CAST(N'2025-06-08T00:00:00.000' AS DateTime), CAST(N'2025-06-10T00:00:00.000' AS DateTime), 1, CAST(10.0 AS Decimal(3, 1)), N'/img/tours/cc1cb402-cb8a-4337-9cca-680f3e76bab4.jpg')
SET IDENTITY_INSERT [dbo].[Tours] OFF
GO
SET IDENTITY_INSERT [dbo].[Usuarios] ON 

INSERT [dbo].[Usuarios] ([UsuarioID], [Identificacion], [Nombre], [ApellidoPaterno], [ApellidoMaterno], [Correo], [Contrasenna], [TieneContrasennaTemp], [FechaVencimientoTemp], [Estado], [RolID]) VALUES (1, N'117310079', N'Daniel', N'Vega', N'Marvez', N'dvegamarvez@gmail.com', N'rxrQf+L/MQCLiFKGuOqH4A==', NULL, NULL, 1, 1)
INSERT [dbo].[Usuarios] ([UsuarioID], [Identificacion], [Nombre], [ApellidoPaterno], [ApellidoMaterno], [Correo], [Contrasenna], [TieneContrasennaTemp], [FechaVencimientoTemp], [Estado], [RolID]) VALUES (2, N'117310078', N'Cliente', N'Apellido #1', N'Apellido #2', N'jvega10079@ufide.ac.cr', N'rxrQf+L/MQCLiFKGuOqH4A==', NULL, NULL, 1, 2)
SET IDENTITY_INSERT [dbo].[Usuarios] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Usuarios__60695A193A8A238A]    Script Date: 25-Apr-25 23:52:49 ******/
ALTER TABLE [dbo].[Usuarios] ADD UNIQUE NONCLUSTERED 
(
	[Correo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Usuarios__60695A1956F3A3A6]    Script Date: 25-Apr-25 23:52:49 ******/
ALTER TABLE [dbo].[Usuarios] ADD UNIQUE NONCLUSTERED 
(
	[Correo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Usuarios__60695A1973302061]    Script Date: 25-Apr-25 23:52:49 ******/
ALTER TABLE [dbo].[Usuarios] ADD UNIQUE NONCLUSTERED 
(
	[Correo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Usuarios__60695A1982A6155B]    Script Date: 25-Apr-25 23:52:49 ******/
ALTER TABLE [dbo].[Usuarios] ADD UNIQUE NONCLUSTERED 
(
	[Correo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Usuarios__D6F931E52CCC01F4]    Script Date: 25-Apr-25 23:52:49 ******/
ALTER TABLE [dbo].[Usuarios] ADD UNIQUE NONCLUSTERED 
(
	[Identificacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Usuarios__D6F931E56894E45E]    Script Date: 25-Apr-25 23:52:49 ******/
ALTER TABLE [dbo].[Usuarios] ADD UNIQUE NONCLUSTERED 
(
	[Identificacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Usuarios__D6F931E56E210B05]    Script Date: 25-Apr-25 23:52:49 ******/
ALTER TABLE [dbo].[Usuarios] ADD UNIQUE NONCLUSTERED 
(
	[Identificacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Usuarios__D6F931E5C1E2A08E]    Script Date: 25-Apr-25 23:52:49 ******/
ALTER TABLE [dbo].[Usuarios] ADD UNIQUE NONCLUSTERED 
(
	[Identificacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Reservas] ADD  DEFAULT ('En Espera') FOR [Estado]
GO
ALTER TABLE [dbo].[Tours] ADD  DEFAULT ((1)) FOR [Estado]
GO
ALTER TABLE [dbo].[Usuarios] ADD  DEFAULT ((1)) FOR [Estado]
GO
ALTER TABLE [dbo].[AuditoriaErrores]  WITH CHECK ADD  CONSTRAINT [FK_AuditoriaErrores_Usuarios] FOREIGN KEY([UsuarioID])
REFERENCES [dbo].[Usuarios] ([UsuarioID])
GO
ALTER TABLE [dbo].[AuditoriaErrores] CHECK CONSTRAINT [FK_AuditoriaErrores_Usuarios]
GO
ALTER TABLE [dbo].[Pagos]  WITH NOCHECK ADD  CONSTRAINT [FK_Pagos_Reservas] FOREIGN KEY([ReservaID])
REFERENCES [dbo].[Reservas] ([ReservaID])
GO
ALTER TABLE [dbo].[Pagos] CHECK CONSTRAINT [FK_Pagos_Reservas]
GO
ALTER TABLE [dbo].[Resennas]  WITH NOCHECK ADD  CONSTRAINT [FK_Resennas_Reservas] FOREIGN KEY([ReservaID])
REFERENCES [dbo].[Reservas] ([ReservaID])
GO
ALTER TABLE [dbo].[Resennas] CHECK CONSTRAINT [FK_Resennas_Reservas]
GO
ALTER TABLE [dbo].[Resennas]  WITH NOCHECK ADD  CONSTRAINT [FK_Resennas_Tours] FOREIGN KEY([TourID])
REFERENCES [dbo].[Tours] ([TourID])
GO
ALTER TABLE [dbo].[Resennas] CHECK CONSTRAINT [FK_Resennas_Tours]
GO
ALTER TABLE [dbo].[Resennas]  WITH NOCHECK ADD  CONSTRAINT [FK_Resennas_Usuarios] FOREIGN KEY([UsuarioID])
REFERENCES [dbo].[Usuarios] ([UsuarioID])
GO
ALTER TABLE [dbo].[Resennas] CHECK CONSTRAINT [FK_Resennas_Usuarios]
GO
ALTER TABLE [dbo].[Reservas]  WITH NOCHECK ADD  CONSTRAINT [FK_Reservas_Tours] FOREIGN KEY([TourID])
REFERENCES [dbo].[Tours] ([TourID])
GO
ALTER TABLE [dbo].[Reservas] CHECK CONSTRAINT [FK_Reservas_Tours]
GO
ALTER TABLE [dbo].[Reservas]  WITH NOCHECK ADD  CONSTRAINT [FK_Reservas_Usuarios] FOREIGN KEY([UsuarioID])
REFERENCES [dbo].[Usuarios] ([UsuarioID])
GO
ALTER TABLE [dbo].[Reservas] CHECK CONSTRAINT [FK_Reservas_Usuarios]
GO
ALTER TABLE [dbo].[Usuarios]  WITH NOCHECK ADD  CONSTRAINT [FK_Usuarios_Roles] FOREIGN KEY([RolID])
REFERENCES [dbo].[Roles] ([RolID])
GO
ALTER TABLE [dbo].[Usuarios] CHECK CONSTRAINT [FK_Usuarios_Roles]
GO
ALTER TABLE [dbo].[Resennas]  WITH NOCHECK ADD  CONSTRAINT [CHK_Resennas_Calificacion] CHECK  (([Calificacion]>=(1) AND [Calificacion]<=(5)))
GO
ALTER TABLE [dbo].[Resennas] CHECK CONSTRAINT [CHK_Resennas_Calificacion]
GO
ALTER TABLE [dbo].[Reservas]  WITH NOCHECK ADD  CONSTRAINT [CHK_Reservas_Estado] CHECK  (([Estado]='Completado' OR [Estado]='Cancelado' OR [Estado]='Confirmado' OR [Estado]='En Espera'))
GO
ALTER TABLE [dbo].[Reservas] CHECK CONSTRAINT [CHK_Reservas_Estado]
GO
/****** Object:  StoredProcedure [dbo].[ActivarTour]    Script Date: 25-Apr-25 23:52:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ActivarTour]
    @TourID bigint
AS
BEGIN
    UPDATE Tours
    SET Estado = 1
    WHERE TourID = @TourID
END
GO
/****** Object:  StoredProcedure [dbo].[ActivarUsuario]    Script Date: 25-Apr-25 23:52:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ActivarUsuario]
    @UsuarioID bigint
AS
BEGIN
    UPDATE Usuarios
    SET Estado = 1
    WHERE UsuarioID = @UsuarioID
END
GO
/****** Object:  StoredProcedure [dbo].[ActualizarPerfil]    Script Date: 25-Apr-25 23:52:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ActualizarPerfil]
    @UsuarioID BIGINT,
    @Correo VARCHAR(100)
AS
BEGIN
    UPDATE Usuarios
    SET Correo = @Correo
    WHERE UsuarioID = @UsuarioID AND Estado = 1;
END;
GO
/****** Object:  StoredProcedure [dbo].[AnularReserva]    Script Date: 25-Apr-25 23:52:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[AnularReserva]
    @ReservaID BIGINT
AS
BEGIN
    UPDATE Reservas
    SET Estado = 'Cancelado'
    WHERE ReservaID = @ReservaID;
END
GO
/****** Object:  StoredProcedure [dbo].[ConsultarClientes]    Script Date: 25-Apr-25 23:52:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
		ApellidoPaterno,
		ApellidoMaterno,
		Correo, 
		Estado,
		RolID
	FROM dbo.Usuarios
	WHERE UsuarioID = ISNULL(@UsuarioID, UsuarioID)
	  AND RolID = 2
	ORDER BY 
		CASE WHEN Estado = 1 THEN 0 ELSE 1 END
END
GO
/****** Object:  StoredProcedure [dbo].[ConsultarReserva]    Script Date: 25-Apr-25 23:52:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ConsultarReserva]
    @ReservaID BIGINT
AS
BEGIN
    SELECT
        R.ReservaID,
        R.UsuarioID,
        R.TourID,
        R.CantidadPersonas,
        R.Estado,
        T.Nombre AS NombreTour,
        T.Precio,
        T.FechaInicio,
        T.FechaFin,
        U.Nombre,
        U.Correo
    FROM dbo.Reservas R
    INNER JOIN dbo.Tours T ON R.TourID = T.TourID
    INNER JOIN dbo.Usuarios U ON R.UsuarioID = U.UsuarioID 
    WHERE R.ReservaID = @ReservaID;
END
GO
/****** Object:  StoredProcedure [dbo].[ConsultarTours]    Script Date: 25-Apr-25 23:52:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ConsultarTours]
	@TourID BIGINT
AS
BEGIN
	SET NOCOUNT ON;

	IF (@TourID = 0) SET @TourID = NULL;

	SELECT
		TourID,
		Nombre,
		Destino,
		Precio,
		Capacidad,
		FechaInicio,
		FechaFin,
		Estado,
		Descuento,
		Descripcion,
		Itinerario,
		Imagen
	FROM dbo.Tours
	WHERE TourID = ISNULL(@TourID, TourID)
	ORDER BY 
		CASE WHEN Estado = 1 THEN 0 ELSE 1 END,
		CASE WHEN FechaInicio IS NOT NULL THEN 0 ELSE 1 END,
		FechaInicio,
		CASE WHEN FechaFin IS NOT NULL THEN 0 ELSE 1 END,
		FechaFin;

	IF @TourID IS NOT NULL
	BEGIN
		SELECT
			R.UsuarioID,
			U.Nombre + ' ' + U.ApellidoPaterno + ' ' + U.ApellidoMaterno AS NombreUsuario,
			R.Calificacion,
			R.Titulo,
			R.Contenido
		FROM dbo.Resennas R
		INNER JOIN dbo.Usuarios U ON R.UsuarioID = U.UsuarioID
		WHERE R.TourID = @TourID;
	END
END;
GO
/****** Object:  StoredProcedure [dbo].[ConsultarToursActivos]    Script Date: 25-Apr-25 23:52:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ConsultarToursActivos]
AS
BEGIN
    SELECT * FROM Tours WHERE Estado = 1;
END
GO
/****** Object:  StoredProcedure [dbo].[CrearResenna]    Script Date: 25-Apr-25 23:52:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CrearResenna]
    @UsuarioID     BIGINT,
    @TourID        BIGINT,
    @ReservaID     BIGINT,
    @Calificacion  INT,
    @Titulo        VARCHAR(50),
    @Contenido     VARCHAR(1000)
AS
BEGIN
    INSERT INTO dbo.Resennas (UsuarioID, TourID, ReservaID, Calificacion, Titulo, Contenido)
    VALUES (@UsuarioID, @TourID, @ReservaID, @Calificacion, @Titulo, @Contenido);
END
GO
/****** Object:  StoredProcedure [dbo].[CrearReservaTour]    Script Date: 25-Apr-25 23:52:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CrearReservaTour]
    @UsuarioID BIGINT,
    @TourID BIGINT,
    @CantidadPersonas INT
AS
BEGIN
    DECLARE @CapacidadDisponible INT

    SELECT @CapacidadDisponible = (T.Capacidad - ISNULL(SUM(R.CantidadPersonas), 0))
    FROM Tours T
    LEFT JOIN Reservas R ON T.TourID = R.TourID AND R.Estado IN ('En Espera', 'Confirmado')
    WHERE T.TourID = @TourID
    GROUP BY T.Capacidad

    IF @CapacidadDisponible >= @CantidadPersonas
    BEGIN
        INSERT INTO Reservas (UsuarioID, TourID, CantidadPersonas)
        VALUES (@UsuarioID, @TourID, @CantidadPersonas)
    END
    ELSE
    BEGIN
        RAISERROR('No hay suficiente capacidad disponible.', 16, 1)
    END
END
GO
/****** Object:  StoredProcedure [dbo].[CrearTour]    Script Date: 25-Apr-25 23:52:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CrearTour]
    @Nombre VARCHAR(50),
    @Destino VARCHAR(255),
    @Precio DECIMAL(10, 2),
    @Capacidad INT,
    @FechaInicio DATETIME,
    @FechaFin DATETIME,
    @Descripcion VARCHAR(1000),
    @Itinerario VARCHAR(1000),
	@Imagen VARCHAR(1000)
AS
BEGIN
    INSERT INTO [dbo].[Tours]
           ([Nombre],
            [Destino],
            [Precio],
            [Capacidad],
            [FechaInicio],
            [FechaFin],
            [Descripcion],
            [Itinerario],
			[Estado],
			[Descuento],
			[Imagen])
    VALUES
           (@Nombre, 
            @Destino,
            @Precio,
            @Capacidad,
            @FechaInicio,
            @FechaFin,
            @Descripcion,
            @Itinerario,
			1,
			0,
			@Imagen)
END
GO
/****** Object:  StoredProcedure [dbo].[DesactivarTour]    Script Date: 25-Apr-25 23:52:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DesactivarTour]
    @TourID bigint
AS
BEGIN
    UPDATE Tours
    SET Estado = 0
    WHERE TourID = @TourID
END
GO
/****** Object:  StoredProcedure [dbo].[DesactivarUsuario]    Script Date: 25-Apr-25 23:52:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DesactivarUsuario]
    @UsuarioID bigint
AS
BEGIN
    UPDATE Usuarios
    SET Estado = 0
    WHERE UsuarioID = @UsuarioID
END
GO
/****** Object:  StoredProcedure [dbo].[EditarTour]    Script Date: 25-Apr-25 23:52:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EditarTour]
    @TourID bigint,
    @Nombre varchar(50),
    @Destino varchar(255),
    @Precio decimal(10, 2),
    @Capacidad int,
    @FechaInicio datetime,
    @FechaFin datetime,
    @Descripcion varchar(1000),
    @Itinerario varchar(1000),
	@Imagen varchar(1000)
AS
BEGIN
    UPDATE [dbo].[Tours]
    SET 
        [Nombre] = @Nombre,
        [Destino] = @Destino,
        [Precio] = @Precio,
        [Capacidad] = @Capacidad,
        [FechaInicio] = @FechaInicio,
        [FechaFin] = @FechaFin,
        [Descripcion] = @Descripcion,
        [Itinerario] = @Itinerario,
		[Imagen] = CASE 
                      WHEN @Imagen IS NOT NULL AND LTRIM(RTRIM(@Imagen)) <> '' 
                      THEN @Imagen 
                      ELSE [Imagen] 
                   END
    WHERE [TourID] = @TourID;
END
GO
/****** Object:  StoredProcedure [dbo].[ListarResennasPorTour]    Script Date: 25-Apr-25 23:52:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ListarResennasPorTour]
    @TourID BIGINT
AS
BEGIN
    SELECT R.Titulo, R.Contenido, R.Calificacion, U.Nombre AS Usuario
    FROM Resennas R
    INNER JOIN Usuarios U ON R.UsuarioID = U.UsuarioID
    WHERE R.TourID = @TourID;
END
GO
/****** Object:  StoredProcedure [dbo].[Login]    Script Date: 25-Apr-25 23:52:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Login]
    @correo VARCHAR(100),
    @Contrasenna VARCHAR(255)
AS
BEGIN
    SELECT  U.UsuarioID,
            U.Identificacion,
            U.Nombre,
            U.Correo,
            U.Estado,
            U.RolID,
            R.NombreRol
    FROM    dbo.Usuarios U
    INNER JOIN dbo.Roles R ON U.RolID = R.RolID
    WHERE   U.Correo = @Correo
            AND U.Contrasenna = @Contrasenna
            AND U.Estado = 1 -- Solo usuarios activos
END
GO
/****** Object:  StoredProcedure [dbo].[ObtenerReservasAdmin]    Script Date: 25-Apr-25 23:52:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ObtenerReservasAdmin]
AS
BEGIN
    SELECT 
        R.ReservaID,
        T.Nombre AS NombreTour,
        U.Nombre AS Cliente,
        U.Identificacion,
        R.CantidadPersonas,
        R.Estado,
        T.Precio,
        T.FechaInicio,
        T.FechaFin,
        P.Fecha AS FechaComprobante,
        P.Monto AS MontoComprobante,
		P.Comprobante
    FROM Reservas R
    INNER JOIN Tours T ON R.TourID = T.TourID
    INNER JOIN Usuarios U ON R.UsuarioID = U.UsuarioID
    LEFT JOIN Pagos P ON R.ReservaID = P.ReservaID
    ORDER BY 
        CASE R.Estado
            WHEN 'Confirmado' THEN 0
            WHEN 'Completado' THEN 1
            WHEN 'En Espera' THEN 2
            WHEN 'Cancelado' THEN 3
            ELSE 4
        END
END
GO
/****** Object:  StoredProcedure [dbo].[ObtenerReservasPorUsuario]    Script Date: 25-Apr-25 23:52:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ObtenerReservasPorUsuario]
    @UsuarioID BIGINT
AS
BEGIN
    SELECT 
        R.ReservaID,
		R.TourID,
        R.UsuarioID, 
        T.Nombre AS NombreTour,
        T.Precio,                      
        T.FechaInicio,
        T.FechaFin,
        R.CantidadPersonas,
        R.Estado
    FROM Reservas R
    INNER JOIN Tours T ON R.TourID = T.TourID
    WHERE R.UsuarioID = @UsuarioID
    ORDER BY 
        CASE R.Estado
            WHEN 'Confirmado' THEN 0
            WHEN 'Completado' THEN 1
            WHEN 'En Espera' THEN 2
            WHEN 'Cancelado' THEN 3
            ELSE 4
        END
END
GO
/****** Object:  StoredProcedure [dbo].[ObtenerUsuarioCompleto]    Script Date: 25-Apr-25 23:52:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
END
GO
/****** Object:  StoredProcedure [dbo].[ObtenerUsuarioPorCorreo]    Script Date: 25-Apr-25 23:52:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ObtenerUsuarioPorCorreo]
    @Correo VARCHAR(100)
AS
BEGIN
    SELECT UsuarioID, Identificacion, Nombre, ApellidoPaterno, ApellidoMaterno,
           Correo, Estado, RolID
    FROM Usuarios
    WHERE LTRIM(RTRIM(Correo)) = LTRIM(RTRIM(@Correo)) AND Estado = 1;
END
GO
/****** Object:  StoredProcedure [dbo].[ObtenerUsuarioPorReserva]    Script Date: 25-Apr-25 23:52:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[ObtenerUsuarioPorReserva]
    @ReservaID BIGINT
AS
BEGIN
    SELECT UsuarioID
    FROM Reservas
    WHERE ReservaID = @ReservaID;
END
GO
/****** Object:  StoredProcedure [dbo].[PagarReserva]    Script Date: 25-Apr-25 23:52:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PagarReserva]
    @ReservaID INT,
    @Comprobante NVARCHAR(MAX),
    @Monto DECIMAL(10, 2),
    @CantidadPersonas INT
AS
BEGIN
    INSERT INTO Pagos (ReservaID, Comprobante, Monto, Fecha)
    VALUES (@ReservaID, @Comprobante, @Monto, GETDATE());

    UPDATE Reservas
    SET Estado = 'Confirmado',
        CantidadPersonas = @CantidadPersonas
    WHERE ReservaID = @ReservaID;
END
GO
/****** Object:  StoredProcedure [dbo].[RegistrarError]    Script Date: 25-Apr-25 23:52:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[RegistrarError]
	@UsuarioID bigint,
	@Mensaje varchar(MAX),
	@Origen varchar(250)
AS
BEGIN
	
	INSERT INTO dbo.AuditoriaErrores(UsuarioID, FechaHora, Mensaje, Origen)
     VALUES (@UsuarioID, GETDATE(), @Mensaje, @Origen)

END;
GO
/****** Object:  StoredProcedure [dbo].[Registro]    Script Date: 25-Apr-25 23:52:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Registro]
    @Identificacion VARCHAR(15),
    @Nombre VARCHAR(50),
    @ApellidoPaterno VARCHAR(50),
    @ApellidoMaterno VARCHAR(50),
    @Correo VARCHAR(100),
    @Contrasenna VARCHAR(255)
AS
BEGIN
    IF NOT EXISTS(SELECT 1 FROM dbo.Usuarios WHERE Identificacion = @Identificacion OR Correo = @Correo)
    BEGIN
        INSERT INTO dbo.Usuarios 
        (Identificacion, Contrasenna, Nombre, ApellidoPaterno, ApellidoMaterno, Correo, Estado, RolID)
        VALUES 
        (@Identificacion, @Contrasenna, @Nombre, @ApellidoPaterno, @ApellidoMaterno, @Correo, 1, 2);

        PRINT 'Cuenta registrada correctamente.'
    END
    ELSE
    BEGIN
        PRINT 'La identificación o el correo ya están registrados.'
    END
END
GO
/****** Object:  StoredProcedure [dbo].[RestablecerContrasenna]    Script Date: 25-Apr-25 23:52:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[RestablecerContrasenna]
    @Correo VARCHAR(100),
    @Contrasenna VARCHAR(255)
AS
BEGIN
    UPDATE Usuarios
    SET Contrasenna = @Contrasenna,
        TieneContrasennaTemp = 0,
        FechaVencimientoTemp = NULL
    WHERE Correo = @Correo AND Estado = 1;
END
GO
