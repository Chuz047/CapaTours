CREATE TABLE [dbo].[AuditoriaErrores] (
	[ErrorID] [bigint] IDENTITY(1,1) PRIMARY KEY,
	[Mensaje] [varchar](4000) NOT NULL,
	[Fecha] [datetime] NOT NULL DEFAULT(GETDATE())
)
GO