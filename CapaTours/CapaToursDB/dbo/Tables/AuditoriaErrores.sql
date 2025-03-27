-- =============================================
-- ERRORES DE AUDITORÍA
-- =============================================

CREATE TABLE [dbo].[AuditoriaErrores] (
	[ErrorID] [bigint] IDENTITY(1,1) PRIMARY KEY,
	[UsuarioID] [bigint] NOT NULL,
	[Mensaje] [varchar](MAX) NOT NULL,
	[Fecha] [datetime] NOT NULL DEFAULT(GETDATE()),
	[Origen] [varchar] (500) NOT NULL,
	CONSTRAINT FK_AuditoriaErrores_Usuarios FOREIGN KEY ([UsuarioID]) REFERENCES [dbo].[Usuarios]([UsuarioID])
)
GO