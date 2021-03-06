USE [SOLGAS_REGISTRO_DE_ACTIVIDADES]
GO
/****** Object:  UserDefinedTableType [dbo].[LstControlDina]    Script Date: 3/03/2019 02:45:04 ******/
CREATE TYPE [dbo].[LstControlDina] AS TABLE(
	[id] [bigint] NULL,
	[valor] [varchar](4000) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[LstEtapaDetalle]    Script Date: 3/03/2019 02:45:04 ******/
CREATE TYPE [dbo].[LstEtapaDetalle] AS TABLE(
	[IdEtapa] [bigint] NULL,
	[IdEtapaDetalle] [bigint] NULL,
	[Id] [int] NULL,
	[Etiqueta] [varchar](60) NULL,
	[TipoControl] [bigint] NULL,
	[MaxCaracter] [varchar](10) NULL,
	[Grupo] [varchar](15) NULL,
	[Obligatorio] [char](1) NULL,
	[Modificable] [char](1) NULL,
	[FlgHabilitado] [char](1) NULL,
	[Perfiles] [varchar](100) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[LstSubTipoActividadDetalle]    Script Date: 3/03/2019 02:45:04 ******/
CREATE TYPE [dbo].[LstSubTipoActividadDetalle] AS TABLE(
	[Fila] [bigint] NULL,
	[IDSubTipoActividad] [bigint] NULL,
	[IdSubTipoActividadDetalle] [bigint] NULL,
	[Etiqueta] [varchar](100) NULL,
	[IdTipoControl] [varchar](15) NULL,
	[CodigoGeneral] [varchar](20) NULL,
	[Modificable] [char](1) NULL,
	[Obligatorio] [char](1) NULL,
	[MaxCaracter] [varchar](5) NULL,
	[FlgHabilitado] [char](1) NULL,
	[FlgPadre] [char](1) NULL,
	[IdSubTipoActividadDetPadre] [varchar](100) NULL,
	[Perfiles] [varchar](100) NULL
)
GO
/****** Object:  UserDefinedFunction [dbo].[FORMATEAR_ERROR]    Script Date: 3/03/2019 02:45:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[FORMATEAR_ERROR] 
(
	@CAMPO  VARCHAR(200),
	@ERROR VARCHAR(200)
)
RETURNS VARCHAR(200) AS  
BEGIN
DECLARE @RETORNO AS VARCHAR(200)

IF (@ERROR IS NULL)
	SET @RETORNO = ''
ELSE 
BEGIN
	SET @RETORNO = ISNULL(@ERROR,'') + '_' + isnull(@CAMPO,'')
END

RETURN @RETORNO
END










GO
/****** Object:  UserDefinedFunction [dbo].[FX_FormatearError]    Script Date: 3/03/2019 02:45:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[FX_FormatearError] 
(
	@CAMPO  VARCHAR(200),
	@ERROR VARCHAR(200)
)
RETURNS VARCHAR(200) AS  
BEGIN
DECLARE @RETORNO AS VARCHAR(200)

IF (@ERROR IS NULL)
	SET @RETORNO = ''
ELSE 
BEGIN
	SET @RETORNO = ISNULL(@ERROR,'') + '_' + REPLACE(@CAMPO,' ', '_')
END

RETURN @RETORNO
END





GO
/****** Object:  UserDefinedFunction [dbo].[FX_IsReservedChar]    Script Date: 3/03/2019 02:45:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[FX_IsReservedChar] ( @CADENA VARCHAR(1000))
RETURNS VARCHAR(500) 
AS
BEGIN

DECLARE @RETORNO VARCHAR(50)
DECLARE @LISTA VARCHAR(15), @CARACTER VARCHAR(1)

SET @LISTA= '"|;&$#()[]{}'''

SET @RETORNO = NULL

while len(@CADENA) > 0
begin
	SET @CARACTER = SUBSTRING(@CADENA,1, len(@CADENA))
	SET @CADENA = SUBSTRING(@CADENA,2, len(@CADENA))

	IF(CHARINDEX(@CARACTER,@LISTA ) > 0)
	BEGIN
		SET @RETORNO = 'Error de formato' 
		SET @CADENA = ''
	END
end

RETURN @RETORNO;

END












GO
/****** Object:  UserDefinedFunction [dbo].[FX_ValidaStringCarga]    Script Date: 3/03/2019 02:45:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[FX_ValidaStringCarga] 
(
	@CADENA VARCHAR(500),
    @FLAG_VACIO char(1),
    @LONGITUD SMALLINT
)
RETURNS VARCHAR(50) AS  
BEGIN 

DECLARE @RETORNO VARCHAR(50)

DECLARE @ERROR_VACIO VARCHAR(50)
DECLARE @ERROR_FORMATO VARCHAR(50)

SET @ERROR_VACIO = null
SET @ERROR_FORMATO = null

SET @ERROR_FORMATO = dbo.FX_IsReservedChar(@CADENA)

IF(@FLAG_VACIO='T')
	SET @ERROR_VACIO = dbo.[FX_ValidaVacio](@CADENA)

IF(LEN(@CADENA)>@LONGITUD AND @ERROR_FORMATO IS NULL)
	SET @ERROR_FORMATO = 'Error de formato'

IF(@ERROR_VACIO IS NOT NULL OR @ERROR_FORMATO IS NOT NULL) 
	SET @RETORNO = ISNULL(@ERROR_VACIO,'') + ISNULL(@ERROR_FORMATO,'') 
ELSE
	SET @RETORNO = NULL

RETURN @RETORNO

END










GO
/****** Object:  UserDefinedFunction [dbo].[FX_ValidaVacio]    Script Date: 3/03/2019 02:45:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[FX_ValidaVacio] 
(
	@CADENA VARCHAR(100)
)
RETURNS VARCHAR(50) AS  
BEGIN 

DECLARE @RETORNO VARCHAR(50)

IF (@CADENA IS NULL OR @CADENA = '') 
	SET @RETORNO = 'No debe tener vacios'
ELSE 
	SET @RETORNO = NULL

RETURN @RETORNO

END












GO
/****** Object:  UserDefinedFunction [dbo].[NUMEROVALIDO]    Script Date: 3/03/2019 02:45:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  FUNCTION [dbo].[NUMEROVALIDO] 
(
	@CADENA VARCHAR(200),
    @REMPLAZO VARCHAR(20)
)
RETURNS VARCHAR(50) AS  
BEGIN 

DECLARE @RETORNO VARCHAR(50)

SET @RETORNO = @CADENA;

IF (isnumeric(@CADENA)=0) 
BEGIN
	SET @RETORNO = @REMPLAZO
END

RETURN @RETORNO

END










GO
/****** Object:  UserDefinedFunction [dbo].[SPLIT]    Script Date: 3/03/2019 02:45:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[SPLIT]   
(   
        @STRING VARCHAR(MAX),   
        @DELIMITER VARCHAR(5)   
)   
RETURNS @SPLITTEDVALUES TABLE   
(   
  OCCURENCEID SMALLINT IDENTITY(1,1),   
  SPLITVALUE VARCHAR(500)   
)   
AS   
BEGIN   
DECLARE @SPLITLENGTH INT   
WHILE DATALENGTH(@STRING) > 0   
BEGIN   
        SELECT @SPLITLENGTH = (CASE CHARINDEX(@DELIMITER,@STRING) WHEN 0 THEN   
LEN(@STRING) ELSE CHARINDEX(@DELIMITER,@STRING) -1  END)   
        INSERT INTO @SPLITTEDVALUES   
        SELECT SUBSTRING(@STRING,1,@SPLITLENGTH)   
       SELECT @STRING = (CASE (LEN(@STRING) - @SPLITLENGTH) WHEN 0 THEN ''   
ELSE SUBSTRING(@STRING,@SPLITLENGTH + len(@DELIMITER) +1,LEN(@STRING) - @SPLITLENGTH - len(@DELIMITER)) END)   
END   
RETURN   
END










GO
/****** Object:  UserDefinedFunction [dbo].[VALIDA_VACIO]    Script Date: 3/03/2019 02:45:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[VALIDA_VACIO]
(
	@CADENA VARCHAR(200)
)
RETURNS VARCHAR(50) AS  
BEGIN 
	DECLARE @RETORNO VARCHAR(50)
	IF (@CADENA IS NULL OR @CADENA = '') 
		SET @RETORNO = 'ERR_VACIO'
	ELSE 
		SET @RETORNO = NULL

	RETURN @RETORNO
END










GO
/****** Object:  Table [dbo].[CFEstado]    Script Date: 3/03/2019 02:45:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CFEstado](
	[IdEstado] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](100) NOT NULL,
	[FlgHabilitado] [char](1) NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CFEtiqueta]    Script Date: 3/03/2019 02:45:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CFEtiqueta](
	[IdEtiqueta] [int] IDENTITY(1,1) NOT NULL,
	[CodEtiqueta] [varchar](45) NOT NULL,
	[Descripcion] [varchar](250) NULL,
	[FchRegistro] [datetime] NOT NULL CONSTRAINT [DF_CFEtiqueta_FchRegistro]  DEFAULT (getdate()),
	[FlgSincronizar] [char](1) NOT NULL CONSTRAINT [DF_CFEtiqueta_FlgSincronizar]  DEFAULT ('F'),
 CONSTRAINT [PK_CFEtiqueta] PRIMARY KEY CLUSTERED 
(
	[IdEtiqueta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CFMenu]    Script Date: 3/03/2019 02:45:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CFMenu](
	[IdMenu] [int] IDENTITY(1,1) NOT NULL,
	[IdMenuPadre] [int] NULL,
	[IdEtiqueta] [int] NOT NULL,
	[Descripcion] [nvarchar](50) NULL,
	[IdEtiquetaDetalle] [int] NULL,
	[Url] [varchar](200) NULL,
	[UrlImagen] [varchar](45) NULL,
	[Posicion] [int] NULL,
	[FchRegistro] [datetime] NOT NULL CONSTRAINT [DF_CFMenu_FchRegistro]  DEFAULT (getdate()),
	[CodMenu] [char](3) NULL,
	[flg] [char](1) NOT NULL DEFAULT ('T'),
 CONSTRAINT [PK_CFMenu] PRIMARY KEY CLUSTERED 
(
	[IdMenu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CFMes]    Script Date: 3/03/2019 02:45:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CFMes](
	[IdMES] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](30) NOT NULL,
	[FlgHabilitado] [char](1) NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CFModulo]    Script Date: 3/03/2019 02:45:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CFModulo](
	[IdModulo] [int] IDENTITY(1,1) NOT NULL,
	[CodModulo] [char](4) NOT NULL,
	[Descripcion] [nvarchar](50) NULL,
	[FlgHabilitado] [char](1) NOT NULL,
	[FchRegistro] [datetime] NOT NULL,
 CONSTRAINT [PK_CFModulo] PRIMARY KEY CLUSTERED 
(
	[IdModulo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CFNivel]    Script Date: 3/03/2019 02:45:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CFNivel](
	[IdNivel] [int] IDENTITY(1,1) NOT NULL,
	[DescripcionNivel] [varchar](30) NOT NULL,
	[FlgHabilitado] [char](1) NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CFPais]    Script Date: 3/03/2019 02:45:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CFPais](
	[IdPais] [int] IDENTITY(1,1) NOT NULL,
	[CodPais] [varchar](2) NOT NULL,
	[Descripcion] [varchar](50) NULL,
	[FchRegistro] [datetime] NOT NULL CONSTRAINT [DF_CFPais_FchRegistro]  DEFAULT (getdate()),
 CONSTRAINT [PK_CFPais] PRIMARY KEY CLUSTERED 
(
	[IdPais] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CFTipoControl]    Script Date: 3/03/2019 02:45:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CFTipoControl](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Codigo] [varchar](15) NOT NULL,
	[Nombre] [varchar](40) NOT NULL,
	[FlgHabilitado] [char](1) NOT NULL,
 CONSTRAINT [PK__CFTipoCo__3214EC07155F5DAD] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CFValorEtiqueta]    Script Date: 3/03/2019 02:45:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CFValorEtiqueta](
	[IdPais] [int] NOT NULL,
	[IdEtiqueta] [int] NOT NULL,
	[Descripcion] [nvarchar](100) NULL,
	[FchRegistro] [datetime] NOT NULL,
 CONSTRAINT [PK_CFIdioma] PRIMARY KEY CLUSTERED 
(
	[IdPais] ASC,
	[IdEtiqueta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ERR_Cliente]    Script Date: 3/03/2019 02:45:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ERR_Cliente](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Razon_Social] [varchar](255) NULL,
	[RUC] [varchar](255) NULL,
	[CodZona] [varchar](255) NULL,
	[CodCanal] [varchar](255) NULL,
	[ERR_Razon_Social] [varchar](255) NULL,
	[ERR_RUC] [varchar](255) NULL,
	[ERR_CodZona] [varchar](255) NULL,
	[ERR_CodCanal] [varchar](255) NULL,
	[ERR_AUX] [varchar](4000) NULL,
	[Referencia] [varchar](255) NULL,
	[ERR_Referencia] [varchar](255) NULL,
	[ERR_Direccion] [varchar](255) NULL,
	[Direccion] [varchar](255) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ERR_Contacto]    Script Date: 3/03/2019 02:45:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ERR_Contacto](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Nombres] [varchar](255) NULL,
	[Telefono] [varchar](255) NULL,
	[Email] [varchar](255) NULL,
	[Cargo] [varchar](255) NULL,
	[Ruc_Cliente] [varchar](255) NULL,
	[CodZona] [varchar](255) NULL,
	[ERR_Nombres] [varchar](255) NULL,
	[ERR_Telefono] [varchar](255) NULL,
	[ERR_Email] [varchar](255) NULL,
	[ERR_Cargo] [varchar](255) NULL,
	[ERR_Ruc_Cliente] [varchar](255) NULL,
	[ERR_CodZona] [varchar](255) NULL,
	[ERR_AUX] [varchar](4000) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ERR_Usuario]    Script Date: 3/03/2019 02:45:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ERR_Usuario](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Codigo] [varchar](255) NULL,
	[Nombres] [varchar](255) NULL,
	[LoginUsuario] [varchar](255) NULL,
	[Clave] [varchar](255) NULL,
	[CodPerfil] [varchar](255) NULL,
	[Email] [varchar](255) NULL,
	[ERR_Codigo] [varchar](255) NULL,
	[ERR_Nombres] [varchar](255) NULL,
	[ERR_LoginUsuario] [varchar](255) NULL,
	[ERR_Clave] [varchar](255) NULL,
	[ERR_CodPerfil] [varchar](255) NULL,
	[ERR_Email] [varchar](255) NULL,
	[ERR_AUX] [varchar](4000) NULL,
	[ZONA] [varchar](50) NULL,
	[CANAL] [varchar](50) NULL,
	[ERR_CANAL] [varchar](50) NULL,
	[ERR_ZONA] [varchar](50) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ERR_ZONA]    Script Date: 3/03/2019 02:45:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ERR_ZONA](
	[ID] [bigint] NULL,
	[Codigo] [varchar](255) NULL,
	[Nombre] [varchar](255) NULL,
	[ERR_Codigo] [varchar](255) NULL,
	[ERR_Nombre] [varchar](255) NULL,
	[ERR_AUX] [varchar](4000) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GRActividad]    Script Date: 3/03/2019 02:45:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GRActividad](
	[IdActividad] [bigint] IDENTITY(1,1) NOT NULL,
	[IdConfiguracionActividad] [bigint] NULL,
	[IdCanal] [int] NOT NULL,
	[IdUsuarioResponsable] [bigint] NOT NULL,
	[FechaCreacion] [datetime] NULL,
	[idCliente] [bigint] NULL,
	[FlgHabilitado] [char](1) NULL,
	[idContacto] [bigint] NOT NULL DEFAULT ((0)),
	[observaciones] [varchar](max) NULL,
	[Fecha] [datetime] NULL,
	[Latitud] [float] NULL,
	[Longitud] [float] NULL,
	[IdTipoActividad] [bigint] NULL,
 CONSTRAINT [PKOportunidad] PRIMARY KEY CLUSTERED 
(
	[IdActividad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GRCanal]    Script Date: 3/03/2019 02:45:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GRCanal](
	[IdCanal] [bigint] IDENTITY(1,1) NOT NULL,
	[Codigo] [varchar](50) NULL,
	[Nombre] [varchar](150) NULL,
 CONSTRAINT [PK_GRCanal] PRIMARY KEY CLUSTERED 
(
	[IdCanal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GRCliente]    Script Date: 3/03/2019 02:45:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GRCliente](
	[CLI_PK] [bigint] IDENTITY(1,1) NOT NULL,
	[Razon_Social] [varchar](50) NULL,
	[RUC] [varchar](11) NULL,
	[FlgHabilitado] [char](1) NULL,
	[Direccion] [varchar](200) NULL,
	[Referencia] [varchar](200) NULL,
	[IdCanal] [bigint] NOT NULL DEFAULT ((1)),
 CONSTRAINT [PK_GRCliente] PRIMARY KEY CLUSTERED 
(
	[CLI_PK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GRClienteZona]    Script Date: 3/03/2019 02:45:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GRClienteZona](
	[IdClienteZona] [bigint] IDENTITY(1,1) NOT NULL,
	[idCliente] [bigint] NULL,
	[idZona] [bigint] NULL,
 CONSTRAINT [PK_GRClienteZona] PRIMARY KEY CLUSTERED 
(
	[IdClienteZona] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[GRContacto]    Script Date: 3/03/2019 02:45:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GRContacto](
	[IdContacto] [bigint] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](150) NULL,
	[Telefono] [varchar](50) NULL,
	[Email] [varchar](50) NULL,
	[Cargo] [varchar](50) NULL,
	[IdCliente] [bigint] NULL,
	[IdZona] [bigint] NULL,
	[Flag] [char](1) NULL,
 CONSTRAINT [PK_GRContacto] PRIMARY KEY CLUSTERED 
(
	[IdContacto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GREtapa]    Script Date: 3/03/2019 02:45:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GREtapa](
	[IdEtapa] [bigint] IDENTITY(1,1) NOT NULL,
	[CodEtapa] [varchar](15) NOT NULL,
	[Descripcion] [varchar](100) NOT NULL,
	[EtapaPredecesora] [bigint] NULL,
	[TiempoEtapa] [int] NOT NULL,
	[FechaRegistro] [datetime] NOT NULL,
	[FlgHabilitado] [char](1) NOT NULL,
 CONSTRAINT [PK__GREtapa__E4B65D8EFC4FB7D7] PRIMARY KEY CLUSTERED 
(
	[IdEtapa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GREtapaDetalle]    Script Date: 3/03/2019 02:45:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GREtapaDetalle](
	[IdEtapa] [bigint] NOT NULL,
	[IdEtapaDetalle] [bigint] IDENTITY(1,1) NOT NULL,
	[Orden] [int] NOT NULL,
	[Etiqueta] [varchar](60) NOT NULL,
	[IdTipoControl] [bigint] NOT NULL,
	[MaxCaracter] [varchar](10) NOT NULL,
	[CodigoGeneral] [varchar](15) NULL,
	[Obligatorio] [char](1) NULL,
	[Modificable] [char](1) NULL,
	[FlgHabilitado] [char](1) NOT NULL,
 CONSTRAINT [PK_GREtapaDetalle] PRIMARY KEY CLUSTERED 
(
	[IdEtapa] ASC,
	[IdEtapaDetalle] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GREtapaDetallePerfilModifica]    Script Date: 3/03/2019 02:45:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GREtapaDetallePerfilModifica](
	[IdEtapa] [bigint] NOT NULL,
	[IdEtapaDetalle] [bigint] NOT NULL,
	[IdPerfilModifica] [bigint] NOT NULL,
	[FlgHabilitado] [char](1) NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GRGrupo]    Script Date: 3/03/2019 02:45:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GRGrupo](
	[IDGrupo] [bigint] IDENTITY(1,1) NOT NULL,
	[Codigo] [varchar](15) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[IdNivel] [int] NOT NULL,
	[CodigoPadreGrupo] [varchar](20) NULL,
	[FlgHabilitado] [char](1) NULL,
	[tipo] [char](1) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GRGrupoDetalle]    Script Date: 3/03/2019 02:45:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GRGrupoDetalle](
	[IdGrupoDetalle] [bigint] IDENTITY(1,1) NOT NULL,
	[IdGrupo] [bigint] NOT NULL,
	[Codigo] [varchar](15) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[IdCodigoDetallePadre] [varchar](10) NULL,
	[FlgHabilitado] [varchar](10) NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GRGrupoUsuario]    Script Date: 3/03/2019 02:45:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GRGrupoUsuario](
	[IdGrupoUsuario] [bigint] IDENTITY(1,1) NOT NULL,
	[IdUsuarioCoordinador] [bigint] NOT NULL,
	[IdUsuarioVendedor] [bigint] NOT NULL,
	[FlgHabilitado] [char](1) NOT NULL,
 CONSTRAINT [PK_GRGrupoUsuario] PRIMARY KEY CLUSTERED 
(
	[IdGrupoUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GRPerfil]    Script Date: 3/03/2019 02:45:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GRPerfil](
	[IdPerfil] [bigint] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](100) NULL,
	[FlgHabilitado] [varchar](10) NOT NULL CONSTRAINT [DF_GRPerfil_FlgHabilitado]  DEFAULT ('T'),
 CONSTRAINT [PK_GRPERFIL] PRIMARY KEY CLUSTERED 
(
	[IdPerfil] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GRPerfilMenu]    Script Date: 3/03/2019 02:45:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GRPerfilMenu](
	[IdPerfil] [int] NOT NULL,
	[IdMenu] [int] NOT NULL,
	[flagHome] [char](1) NULL,
	[FlgHome] [char](1) NULL,
 CONSTRAINT [PK_GRPerfilMenu] PRIMARY KEY CLUSTERED 
(
	[IdPerfil] ASC,
	[IdMenu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GRSubTipoActividad]    Script Date: 3/03/2019 02:45:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GRSubTipoActividad](
	[IDSubTipoActividad] [bigint] IDENTITY(1,1) NOT NULL,
	[Codigo] [varchar](15) NOT NULL,
	[Descripcion] [varchar](100) NOT NULL,
	[FlgHabilitado] [char](1) NOT NULL,
	[IDTipoActividad] [int] NULL,
 CONSTRAINT [PKGRConfiguracionOportunidad] PRIMARY KEY CLUSTERED 
(
	[IDSubTipoActividad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GRSubTipoActividad_Detalle]    Script Date: 3/03/2019 02:45:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GRSubTipoActividad_Detalle](
	[IDSubTipoActividad] [bigint] NOT NULL,
	[IdSubTipoActividadDetalle] [bigint] IDENTITY(1,1) NOT NULL,
	[Etiqueta] [varchar](100) NOT NULL,
	[IdTipoControl] [varchar](15) NULL,
	[CodigoGeneral] [varchar](20) NULL,
	[Modificable] [char](1) NOT NULL,
	[Obligatorio] [char](1) NOT NULL,
	[MaxCaracter] [varchar](5) NOT NULL,
	[FlgHabilitado] [char](1) NOT NULL,
	[FlgPadre] [char](1) NULL,
	[IdSubTipoActividadDetPadre] [bigint] NULL,
 CONSTRAINT [PKGRConfiguracionOportunidad_Detalle] PRIMARY KEY CLUSTERED 
(
	[IDSubTipoActividad] ASC,
	[IdSubTipoActividadDetalle] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GRSubTipoActividad_Detalle_PerfilModifica]    Script Date: 3/03/2019 02:45:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GRSubTipoActividad_Detalle_PerfilModifica](
	[IDSubTipoActividad] [bigint] NOT NULL,
	[IdSubTipoActividadDetalle] [bigint] NOT NULL,
	[IdPerfil] [bigint] NOT NULL,
	[FlgHabilitado] [char](1) NOT NULL,
 CONSTRAINT [PKConfiguracionOportunidad_Detalle_PerfilModifica] PRIMARY KEY CLUSTERED 
(
	[IDSubTipoActividad] ASC,
	[IdSubTipoActividadDetalle] ASC,
	[IdPerfil] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GRTipoActividad]    Script Date: 3/03/2019 02:45:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GRTipoActividad](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[codigo] [varchar](100) NULL,
	[nombre] [varchar](150) NOT NULL,
	[FlagTA] [char](1) NOT NULL,
	[IdCanal] [bigint] NULL,
	[meta] [varchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GRUsuario]    Script Date: 3/03/2019 02:45:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GRUsuario](
	[IdUsuario] [bigint] IDENTITY(1,1) NOT NULL,
	[Codigo] [varchar](50) NULL,
	[Nombres] [varchar](80) NOT NULL,
	[Apellidos] [varchar](80) NOT NULL,
	[LoginUsuario] [varchar](10) NOT NULL,
	[Clave] [varchar](100) NOT NULL,
	[Email] [varchar](100) NULL,
	[FlgHabilitado] [varchar](10) NOT NULL CONSTRAINT [DF_GRUsuario_FlgHabilitado]  DEFAULT ('T'),
	[IdCanal] [bigint] NULL DEFAULT ((1)),
	[IdZona] [bigint] NULL,
	[IdPerfil] [bigint] NOT NULL DEFAULT ((2)),
	[FlagAutenticacionAD] [char](1) NOT NULL DEFAULT ('F'),
 CONSTRAINT [PK_GRUsuario] PRIMARY KEY CLUSTERED 
(
	[IdUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GRZona]    Script Date: 3/03/2019 02:45:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GRZona](
	[IdZona] [bigint] IDENTITY(1,1) NOT NULL,
	[Codigo] [varchar](50) NOT NULL,
	[Nombre] [varchar](150) NULL,
	[Flag] [char](1) NOT NULL DEFAULT ('T'),
 CONSTRAINT [PK_GRZona] PRIMARY KEY CLUSTERED 
(
	[IdZona] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TMP_Cliente]    Script Date: 3/03/2019 02:45:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TMP_Cliente](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Razon_Social] [varchar](255) NULL,
	[RUC] [varchar](255) NULL,
	[CodZona] [varchar](255) NULL,
	[CodCanal] [varchar](255) NULL,
	[ERR_Razon_Social] [varchar](255) NULL,
	[ERR_RUC] [varchar](255) NULL,
	[ERR_CodZona] [varchar](255) NULL,
	[ERR_CodCanal] [varchar](255) NULL,
	[ERR_AUX] [varchar](4000) NULL,
	[Referencia] [varchar](255) NULL,
	[ERR_Referencia] [varchar](255) NULL,
	[ERR_Direccion] [varchar](255) NULL,
	[Direccion] [varchar](255) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TMP_Contacto]    Script Date: 3/03/2019 02:45:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TMP_Contacto](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Nombres] [varchar](255) NULL,
	[Telefono] [varchar](255) NULL,
	[Email] [varchar](255) NULL,
	[Cargo] [varchar](255) NULL,
	[Ruc_Cliente] [varchar](255) NULL,
	[CodZona] [varchar](255) NULL,
	[ERR_Nombres] [varchar](255) NULL,
	[ERR_Telefono] [varchar](255) NULL,
	[ERR_Email] [varchar](255) NULL,
	[ERR_Cargo] [varchar](255) NULL,
	[ERR_Ruc_Cliente] [varchar](255) NULL,
	[ERR_CodZona] [varchar](255) NULL,
	[ERR_AUX] [varchar](4000) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TMP_Usuario]    Script Date: 3/03/2019 02:45:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TMP_Usuario](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Codigo] [varchar](255) NULL,
	[Nombres] [varchar](255) NULL,
	[LoginUsuario] [varchar](255) NULL,
	[Clave] [varchar](255) NULL,
	[CodPerfil] [varchar](255) NULL,
	[Email] [varchar](255) NULL,
	[ERR_Codigo] [varchar](255) NULL,
	[ERR_Nombres] [varchar](255) NULL,
	[ERR_LoginUsuario] [varchar](255) NULL,
	[ERR_Clave] [varchar](255) NULL,
	[ERR_CodPerfil] [varchar](255) NULL,
	[ERR_Email] [varchar](255) NULL,
	[ERR_AUX] [varchar](4000) NULL,
	[ZONA] [varchar](50) NULL,
	[CANAL] [varchar](50) NULL,
	[ERR_CANAL] [varchar](50) NULL,
	[ERR_ZONA] [varchar](50) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TMP_ZONA]    Script Date: 3/03/2019 02:45:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TMP_ZONA](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Codigo] [varchar](255) NULL,
	[Nombre] [varchar](255) NULL,
	[ERR_Codigo] [varchar](255) NULL,
	[ERR_Nombre] [varchar](255) NULL,
	[ERR_AUX] [varchar](4000) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TRActividadDetalleControl]    Script Date: 3/03/2019 02:45:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TRActividadDetalleControl](
	[IdActividadDetalleControl] [bigint] IDENTITY(1,1) NOT NULL,
	[IdActividad] [bigint] NOT NULL,
	[IdConfiguracionActividadDetalle] [bigint] NOT NULL,
	[ValorControl] [varchar](4000) NULL,
	[IdGeneral] [varchar](50) NULL,
 CONSTRAINT [PK__TRActiv__F35CCCAEA4160440] PRIMARY KEY CLUSTERED 
(
	[IdActividadDetalleControl] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TREtapaDetalleControl]    Script Date: 3/03/2019 02:45:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TREtapaDetalleControl](
	[IdEtapaDetalleControl] [bigint] IDENTITY(1,1) NOT NULL,
	[IdOportunidad] [bigint] NOT NULL,
	[IdEtapa] [bigint] NOT NULL,
	[ValorControl] [varchar](4000) NULL,
	[IdFoto] [bigint] NULL,
	[IdEtapaDetalle] [bigint] NOT NULL,
 CONSTRAINT [PK__TREtapaD__CFB05F3C04390AF7] PRIMARY KEY CLUSTERED 
(
	[IdEtapaDetalleControl] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TRFoto]    Script Date: 3/03/2019 02:45:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TRFoto](
	[IdActividad] [bigint] NOT NULL,
	[IdFoto] [bigint] IDENTITY(1,1) NOT NULL,
	[Fecha] [datetime] NULL,
	[Foto] [image] NOT NULL,
	[NombreFoto] [varchar](1000) NULL,
	[FlgHabilitado] [char](1) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TROportunidadEtapa]    Script Date: 3/03/2019 02:45:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TROportunidadEtapa](
	[IdOportunidadEtapa] [bigint] IDENTITY(1,1) NOT NULL,
	[IdOportunidad] [bigint] NOT NULL,
	[IdEtapa] [bigint] NOT NULL,
	[IdEstado] [int] NOT NULL,
	[IdUsuario] [int] NOT NULL,
	[FechaCambioEtapa] [datetime] NULL,
	[FechaFinCambioEtapa] [datetime] NULL,
 CONSTRAINT [PK_TROportunidadEtapa] PRIMARY KEY CLUSTERED 
(
	[IdOportunidadEtapa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  UserDefinedFunction [dbo].[Split_2]    Script Date: 3/03/2019 02:45:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create FUNCTION [dbo].[Split_2]
        (@pString VARCHAR(8000), @pDelimiter CHAR(1))
RETURNS TABLE WITH SCHEMABINDING AS
 RETURN
--===== "Inline" CTE Driven "Tally Table" produces values from 0 up to 10,000...
     -- enough to cover NVARCHAR(4000)
  WITH E1(N) AS (
                 SELECT 1 UNION ALL SELECT 1 UNION ALL SELECT 1 UNION ALL 
                 SELECT 1 UNION ALL SELECT 1 UNION ALL SELECT 1 UNION ALL 
                 SELECT 1 UNION ALL SELECT 1 UNION ALL SELECT 1 UNION ALL SELECT 1
                ),                          --10E+1 or 10 rows
       E2(N) AS (SELECT 1 FROM E1 a, E1 b), --10E+2 or 100 rows
       E4(N) AS (SELECT 1 FROM E2 a, E2 b), --10E+4 or 10,000 rows max
 cteTally(N) AS (--==== This provides the "base" CTE and limits the number of rows right up front
                     -- for both a performance gain and prevention of accidental "overruns"
                 SELECT TOP (ISNULL(DATALENGTH(@pString),0)) ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) FROM E4
                ),
cteStart(N1) AS (--==== This returns N+1 (starting position of each "element" just once for each delimiter)
                 SELECT 1 UNION ALL
                 SELECT t.N+1 FROM cteTally t WHERE SUBSTRING(@pString,t.N,1) = @pDelimiter
                ),
cteLen(N1,L1) AS(--==== Return start and length (for use in substring)
                 SELECT s.N1,
                        ISNULL(NULLIF(CHARINDEX(@pDelimiter,@pString,s.N1),0)-s.N1,8000)
                   FROM cteStart s
                )
--===== Do the actual split. The ISNULL/NULLIF combo handles the length for the final element when no delimiter is found.
 SELECT OccurenceId/*ItemNumber*/ = ROW_NUMBER() OVER(ORDER BY l.N1),
        SplitValue/*Item*/       = SUBSTRING(@pString, l.N1, l.L1)
   FROM cteLen l
;









GO
SET IDENTITY_INSERT [dbo].[CFEstado] ON 

INSERT [dbo].[CFEstado] ([IdEstado], [Descripcion], [FlgHabilitado]) VALUES (1, N'Abierto', N'T')
INSERT [dbo].[CFEstado] ([IdEstado], [Descripcion], [FlgHabilitado]) VALUES (2, N'Ganado', N'T')
INSERT [dbo].[CFEstado] ([IdEstado], [Descripcion], [FlgHabilitado]) VALUES (3, N'Rechazado', N'T')
SET IDENTITY_INSERT [dbo].[CFEstado] OFF
SET IDENTITY_INSERT [dbo].[CFEtiqueta] ON 

INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (1, N'ETI_MNT_SNG', N'mantenimiento', CAST(N'2014-07-30 17:25:07.950' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (2, N'ETI_ACC_PLU', N'accion', CAST(N'2014-07-30 17:25:35.537' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (3, N'ETI_REP_PLU', N'reporte', CAST(N'2014-07-30 17:25:53.960' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (4, N'ETI_USU_SNG', N'usuario', CAST(N'2014-07-30 17:27:56.160' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (5, N'ETI_USU_PLU', N'usuarios', CAST(N'2014-07-30 17:28:06.500' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (7, N'ETI_GRP_SNG', N'grupo de usuarios', CAST(N'2014-07-30 17:28:35.040' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (8, N'ETI_GRP_PLU', N'grupos de usuarios', CAST(N'2014-07-30 17:28:38.503' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (10, N'ETI_EST_SNG', N'estado', CAST(N'2014-07-30 17:29:49.697' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (11, N'ETI_EST_PLU', N'estados', CAST(N'2014-07-30 17:29:51.990' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (13, N'ETI_PNT_SNG', N'punto de interes', CAST(N'2014-07-30 17:30:16.443' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (14, N'ETI_PNT_PLU', N'puntos de interes', CAST(N'2014-07-30 17:30:18.677' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (16, N'ETI_SRV_SNG', N'supervisor', CAST(N'2014-07-30 17:31:31.363' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (17, N'ETI_SRV_PLU', N'supervisores', CAST(N'2014-07-30 17:31:33.917' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (19, N'ETI_GEO_SNG', N'geocerca', CAST(N'2014-07-30 17:31:56.260' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (20, N'ETI_GEO_PLU', N'geocercas', CAST(N'2014-07-30 17:31:58.190' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (22, N'ETI_CAP_SNG', N'capa de puntos de interés', CAST(N'2014-07-30 17:32:22.247' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (23, N'ETI_CAP_PLU', N'capas de puntos de interés', CAST(N'2014-07-30 17:32:24.197' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (24, N'ETI_PLA_SNG', N'formulario', CAST(N'2014-07-30 17:33:01.097' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (25, N'ETI_PLA_PLU', N'formularios', CAST(N'2014-07-30 17:33:06.560' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (27, N'ETI_MAP_SNG', N'mapa', CAST(N'2014-07-30 17:33:37.930' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (28, N'ETI_MAP_PLU', N'mapas', CAST(N'2014-07-30 17:33:42.107' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (29, N'ETI_SUP_SNG', N'servicio activo', CAST(N'2014-07-30 17:34:14.667' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (30, N'ETI_SUP_PLU', N'servicios activos', CAST(N'2014-07-30 17:34:19.077' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (32, N'ETI_MSJ_SNG', N'mensaje', CAST(N'2014-07-30 17:34:56.960' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (33, N'ETI_MSJ_PLU', N'mensajes', CAST(N'2014-07-30 17:35:03.460' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (35, N'ETI_ACC_MSJ_SNG', N'enviar mensaje', CAST(N'2014-07-30 18:25:23.243' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (36, N'ETI_REP_MAP', N'localización', CAST(N'2014-07-31 09:54:31.660' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (37, N'ETI_MNT_CNF', N'configuración', CAST(N'2014-08-11 16:04:49.073' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (39, N'WEB_ESLOGAN_01', N'eslogan parte 1', CAST(N'2014-09-04 11:37:13.347' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (40, N'WEB_ESLOGAN_02', N'eslogan parte 2', CAST(N'2014-09-04 11:37:24.150' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (46, N'WEB_OPERADOR0', N'operador tema 0', CAST(N'2014-09-04 11:39:01.447' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (47, N'WEB_OPERADOR1', N'operador tema 1', CAST(N'2014-09-04 11:39:07.847' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (48, N'WEB_PIE_P', N'copyright', CAST(N'2014-09-04 11:39:22.447' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (49, N'WEB_APP_NAME', N'nombre del aplicativo', CAST(N'2014-09-04 11:55:07.610' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (50, N'WEB_AREA_NAME', N'nombre del area', CAST(N'2014-09-04 12:08:46.817' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (51, N'WEB_PIE_BR', N'pie de pagina', CAST(N'2014-09-04 12:36:21.880' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (52, N'WEB_PIE2_BR', N'pie de pagina opcional', CAST(N'2014-09-04 12:36:37.720' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (53, N'WEB_CORREO_SOPORTE1', N'correo de soporte', CAST(N'2014-09-18 15:53:01.150' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (54, N'WEB_CORREO_SOPORTE0', N'correo de soporte', CAST(N'2014-10-13 11:45:54.470' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (55, N'ETI_PRF_SNG', N'perfil de supervisor', CAST(N'2015-02-05 18:50:07.100' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (56, N'ETI_PRF_PLU', N'perfiles de supervisor', CAST(N'2015-02-05 18:50:27.863' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (57, N'ETI_CAR_SNG', N'carga', CAST(N'2015-02-13 15:45:50.323' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (59, N'ETI_REP_RVI', N'resumen de visitas', CAST(N'2017-07-17 00:00:00.000' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (60, N'ETI_REP_DVI', N'detalle de visitas', CAST(N'2017-07-17 00:00:00.000' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (61, N'ETI_REP_DAS', N'dashboard', CAST(N'2017-07-17 00:00:00.000' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (62, N'ETI_BAN', N'bandeja', CAST(N'2017-07-17 00:00:00.000' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (63, N'ETI_MON_UNI', N'monitor unidades', CAST(N'2017-07-17 00:00:00.000' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (64, N'ETI_RU_DT', N'rutas dt', CAST(N'2017-07-17 00:00:00.000' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (65, N'ETI_MON_ZN', N'monitoreo zonas', CAST(N'2017-07-17 00:00:00.000' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (66, N'ETI_ZN_CARGA', N'zona carga', CAST(N'2017-07-17 00:00:00.000' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (67, N'ETI_EQ_MOV', N'equipos moviles', CAST(N'2017-07-17 00:00:00.000' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (68, N'ETI_GRUA', N'gruas', CAST(N'2017-07-17 00:00:00.000' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (69, N'ETI_NOTIFICACION', N'notificaciones', CAST(N'2017-07-17 00:00:00.000' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (70, N'MAN_WEB_USUARIO', N'Mantenimiento de Usuario', CAST(N'2018-04-23 10:20:41.883' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (71, N'WEB_USUARIO', N'Usuario', CAST(N'2018-04-23 10:20:41.903' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (72, N'OPC_Usuario', N'Usuarios', CAST(N'2018-04-23 10:20:41.917' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (73, N'WEB_TOTAL_PAGE', N'10', CAST(N'2018-04-23 10:20:41.940' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (74, N'MAN_WEB_CLIENTE', N'Mantenimiento de Cliente', CAST(N'2018-04-23 10:20:41.950' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (75, N'WEB_CLIENTE', N'Cliente', CAST(N'2018-04-23 10:20:41.960' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (76, N'OPC_CLIENTE', N'Clientes', CAST(N'2018-04-23 10:20:41.967' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (77, N'MAN_WEB_ETAPA', N'Mantenimiento de Etapas', CAST(N'2018-04-23 10:20:41.987' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (78, N'WEB_ETAPA', N'Etapa', CAST(N'2018-04-23 10:20:41.997' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (79, N'OPC_ETAPA', N'Etapas', CAST(N'2018-04-23 10:20:42.010' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (80, N'MAN_WEB_BAND_OPORTUNIDAD', N'Bandeja de Oportunidades', CAST(N'2018-04-23 10:20:42.030' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (81, N'WEB_BAND_OPORTUNIDAD', N'Bandeja de Oportunidades', CAST(N'2018-04-23 10:20:42.043' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (82, N'OPC_BAND_OPORTUNIDAD', N'Bandeja de Oportunidades', CAST(N'2018-04-23 10:20:42.053' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (83, N'MAN_WEB_OPORTUNIDADES_ETAPA', N'Oportunidades por Etapa', CAST(N'2018-04-23 10:20:42.073' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (84, N'WEB_OPORTUNIDADES_ETAPA', N'Oportunidades por Etapa', CAST(N'2018-04-23 10:20:42.087' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (85, N'OPC_OPORTUNIDADES_ETAPA', N'Oportunidades por Etapa', CAST(N'2018-04-23 10:20:42.100' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (86, N'MAN_WEB_ETAPA_ESTADO', N'Etapas por Estado', CAST(N'2018-04-23 10:20:42.117' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (87, N'WEB_ETAPA_ESTADO', N'Etapas por Estado', CAST(N'2018-04-23 10:20:42.127' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (88, N'OPC_ETAPA_ESTADO', N'Etapas por Estado', CAST(N'2018-04-23 10:20:42.140' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (89, N'MAN_WEB_TIPO_ACTIVIDAD', N'Mantenimiento de Tipo de Actividad', CAST(N'2018-05-02 12:17:37.617' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (90, N'WEB_GRUPO', N'Grupo', CAST(N'2018-05-02 12:17:53.730' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (91, N'OPC_TIPO', N'Tipos', CAST(N'2018-05-02 12:18:04.250' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (93, N'REP_WEB_BAND_OPORTUNIDAD', N'Reporte de Actividades', CAST(N'2018-05-18 16:23:54.740' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (94, N'REP_BAND_OPORTUNIDAD', N'Reporte de Actividades', CAST(N'2018-05-18 16:23:54.740' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (95, N'OPC_REP_OPORTUNIDAD', N'Reporte de Actividades', CAST(N'2018-05-18 16:23:54.743' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (96, N'MAN_WEB_CONFOPORTUNIDADES', N'Mantenimiento Detalle de Tipo de Actividad', CAST(N'2018-05-21 11:55:20.893' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (97, N'WEB_CONFOPORTUNIDADES', N'Detalle de Tipo de Actividad', CAST(N'2018-05-21 11:55:20.897' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (98, N'OPC_CONFOPORTUNIDADES', N'Detalle de Tipo de Actividad', CAST(N'2018-05-21 11:55:20.897' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (99, N'MAN_WEB_GENERAL', N'Mantenimiento Detalle de Grupo', CAST(N'2018-05-21 00:00:00.000' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (100, N'WEB_GENERAL', N'General', CAST(N'2018-05-21 00:00:00.000' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (101, N'OPC_GENERAL', N'General', CAST(N'2018-05-21 00:00:00.000' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (102, N'MAN_WEB_EXCESO_TIEMPO', N'Exceso de Tiempo', CAST(N'2018-05-21 00:00:00.000' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (103, N'WEB_EXCESO_TIEMPO', N'Exceso de Tiempo', CAST(N'2018-05-21 15:52:11.590' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (104, N'OPC_EXCESO_TIEMPO', N'Exceso de Tiempo', CAST(N'2018-05-21 00:00:00.000' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (105, N'WEB_DASH_EXCESO_TIEMPO', N'DashBoardExceso de Tiempo', CAST(N'2018-05-29 13:38:01.773' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (106, N'WEB_FILA', N'Fila', CAST(N'2018-06-19 20:02:00.907' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (107, N'WEB_RAZONSOCIAL', N'Razon Social', CAST(N'2018-06-19 20:02:00.910' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (108, N'WEB_RUC', N'RUC', CAST(N'2018-06-19 20:02:00.913' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (109, N'WEB_RUBRO', N'RUBRO', CAST(N'2018-06-19 20:02:00.913' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (110, N'WEB_REGION', N'REGION', CAST(N'2018-06-19 20:02:00.917' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (111, N'WEB_CANAL', N'CANAL', CAST(N'2018-06-19 20:02:00.920' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (112, N'WEB_ERROR2', N'ERROR', CAST(N'2018-06-19 20:02:00.920' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (113, N'WEB_CODIGO', N'CODIGO', CAST(N'2018-06-19 20:02:00.920' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (114, N'WEB_NOMBRE', N'NOMBRE', CAST(N'2018-06-19 20:02:00.923' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (115, N'WEB_CODIGO_PADRE', N'CODIGO PADRE', CAST(N'2018-06-19 20:02:00.927' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (116, N'WEB_CODIGO_HIJO', N'CODIGO DETALLE PADRE', CAST(N'2018-06-19 20:02:00.930' AS DateTime), N'F')
GO
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (117, N'WEB_LOGIN', N'LOGIN', CAST(N'2018-06-19 20:02:00.930' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (118, N'WEB_COORVENDEDOR', N'COORDINADOR', CAST(N'2018-06-19 20:02:00.933' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (119, N'MAN_WEB_ZONA', N'Mantenimiento de Zonas', CAST(N'2018-06-19 20:02:00.933' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (120, N'MAN_WEB_CONTACTOS', N'Mantenimiento de Contactos', CAST(N'2018-06-19 20:02:00.933' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (121, N'MAN_WEB_DETALLE_ACTIVIDAD', N'Detalle Mantenimiento Tipo de Actividad', CAST(N'2018-06-19 20:02:00.933' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (122, N'WEB_ZONA', N'Zona', CAST(N'2018-06-19 20:02:00.933' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (123, N'WEB_CONTACTO', N'Contacto', CAST(N'2018-06-19 20:02:00.933' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (124, N'MAN_WEB_GRUPO', N'Mantenimiento de Grupo', CAST(N'2018-05-02 12:17:37.617' AS DateTime), N'F')
INSERT [dbo].[CFEtiqueta] ([IdEtiqueta], [CodEtiqueta], [Descripcion], [FchRegistro], [FlgSincronizar]) VALUES (126, N'ETI_DASH', NULL, CAST(N'2018-02-05 12:17:37.617' AS DateTime), N'F')
SET IDENTITY_INSERT [dbo].[CFEtiqueta] OFF
SET IDENTITY_INSERT [dbo].[CFMenu] ON 

INSERT [dbo].[CFMenu] ([IdMenu], [IdMenuPadre], [IdEtiqueta], [Descripcion], [IdEtiquetaDetalle], [Url], [UrlImagen], [Posicion], [FchRegistro], [CodMenu], [flg]) VALUES (1, NULL, 61, N'Dashboard', NULL, NULL, N'chart-area', 3, CAST(N'2014-07-30 18:17:44.400' AS DateTime), N'BAN', N'T')
INSERT [dbo].[CFMenu] ([IdMenu], [IdMenuPadre], [IdEtiqueta], [Descripcion], [IdEtiquetaDetalle], [Url], [UrlImagen], [Posicion], [FchRegistro], [CodMenu], [flg]) VALUES (2, NULL, 1, N'Mantenimiento', NULL, NULL, N'wrench', 1, CAST(N'2014-07-30 18:18:20.330' AS DateTime), N'MAN', N'T')
INSERT [dbo].[CFMenu] ([IdMenu], [IdMenuPadre], [IdEtiqueta], [Descripcion], [IdEtiquetaDetalle], [Url], [UrlImagen], [Posicion], [FchRegistro], [CodMenu], [flg]) VALUES (3, 2, 72, N'Mantenimiento de usuarios', NULL, N'Mantenimiento/Usuarios/Usuarios.aspx', NULL, 2, CAST(N'2018-04-23 10:20:41.937' AS DateTime), N'USU', N'T')
INSERT [dbo].[CFMenu] ([IdMenu], [IdMenuPadre], [IdEtiqueta], [Descripcion], [IdEtiquetaDetalle], [Url], [UrlImagen], [Posicion], [FchRegistro], [CodMenu], [flg]) VALUES (4, 2, 76, N'Mantenimiento de Cliente', NULL, N'Mantenimiento/Cliente/Cliente.aspx', NULL, 3, CAST(N'2018-04-23 10:20:41.983' AS DateTime), N'CLI', N'T')
INSERT [dbo].[CFMenu] ([IdMenu], [IdMenuPadre], [IdEtiqueta], [Descripcion], [IdEtiquetaDetalle], [Url], [UrlImagen], [Posicion], [FchRegistro], [CodMenu], [flg]) VALUES (5, 2, 79, N'Mantenimiento de Etapa', NULL, N'Mantenimiento/Etapas/Etapas.aspx', NULL, 3, CAST(N'2018-04-23 10:20:42.030' AS DateTime), N'ETP', N'F')
INSERT [dbo].[CFMenu] ([IdMenu], [IdMenuPadre], [IdEtiqueta], [Descripcion], [IdEtiquetaDetalle], [Url], [UrlImagen], [Posicion], [FchRegistro], [CodMenu], [flg]) VALUES (6, 2, 82, N'Bandeja de Oportunidades', NULL, N'Mantenimiento/BanOportunidad/BanOportunidad.aspx', NULL, 3, CAST(N'2018-04-23 10:20:42.073' AS DateTime), N'BOP', N'F')
INSERT [dbo].[CFMenu] ([IdMenu], [IdMenuPadre], [IdEtiqueta], [Descripcion], [IdEtiquetaDetalle], [Url], [UrlImagen], [Posicion], [FchRegistro], [CodMenu], [flg]) VALUES (7, 1, 85, N'Actividades', NULL, N'Dashboard/Dashboard.aspx', NULL, 3, CAST(N'2018-04-23 10:20:42.113' AS DateTime), N'OET', N'T')
INSERT [dbo].[CFMenu] ([IdMenu], [IdMenuPadre], [IdEtiqueta], [Descripcion], [IdEtiquetaDetalle], [Url], [UrlImagen], [Posicion], [FchRegistro], [CodMenu], [flg]) VALUES (8, 1, 88, N'Etapas por Estado', NULL, N'Dashboard/EtapaEstado/EtapaEstado.aspx', NULL, 3, CAST(N'2018-04-23 10:20:42.153' AS DateTime), N'EES', N'F')
INSERT [dbo].[CFMenu] ([IdMenu], [IdMenuPadre], [IdEtiqueta], [Descripcion], [IdEtiquetaDetalle], [Url], [UrlImagen], [Posicion], [FchRegistro], [CodMenu], [flg]) VALUES (9, 2, 91, N'Mantenimiento de Tipo de Actividad', NULL, N'Mantenimiento/TipoActividad/TipoActividad.aspx', NULL, 5, CAST(N'2018-05-02 12:13:20.877' AS DateTime), N'TIA', N'T')
INSERT [dbo].[CFMenu] ([IdMenu], [IdMenuPadre], [IdEtiqueta], [Descripcion], [IdEtiquetaDetalle], [Url], [UrlImagen], [Posicion], [FchRegistro], [CodMenu], [flg]) VALUES (11, NULL, 3, N'Reporte', NULL, NULL, N'chart-line', 2, CAST(N'2014-07-30 18:18:20.330' AS DateTime), N'REP', N'T')
INSERT [dbo].[CFMenu] ([IdMenu], [IdMenuPadre], [IdEtiqueta], [Descripcion], [IdEtiquetaDetalle], [Url], [UrlImagen], [Posicion], [FchRegistro], [CodMenu], [flg]) VALUES (12, 11, 95, N'Reporte de Actividades', NULL, N'Reporte/Actividad/Resumido.aspx', NULL, 3, CAST(N'2018-05-18 16:23:54.743' AS DateTime), N'ROP', N'T')
INSERT [dbo].[CFMenu] ([IdMenu], [IdMenuPadre], [IdEtiqueta], [Descripcion], [IdEtiquetaDetalle], [Url], [UrlImagen], [Posicion], [FchRegistro], [CodMenu], [flg]) VALUES (13, 2, 98, N'Mantenimiento Oportunidades', NULL, N'Mantenimiento/SubTipoActividad/SubTipoActividad.aspx', NULL, 6, CAST(N'2018-05-21 11:55:20.900' AS DateTime), N'MCO', N'T')
INSERT [dbo].[CFMenu] ([IdMenu], [IdMenuPadre], [IdEtiqueta], [Descripcion], [IdEtiquetaDetalle], [Url], [UrlImagen], [Posicion], [FchRegistro], [CodMenu], [flg]) VALUES (14, 2, 99, N'Mantenimiento Detalle de Grupo', NULL, N'Mantenimiento/GrupoDetalle/GrupoDetalle.aspx', NULL, 8, CAST(N'2018-05-21 12:38:22.007' AS DateTime), N'GEN', N'T')
INSERT [dbo].[CFMenu] ([IdMenu], [IdMenuPadre], [IdEtiqueta], [Descripcion], [IdEtiquetaDetalle], [Url], [UrlImagen], [Posicion], [FchRegistro], [CodMenu], [flg]) VALUES (19, 1, 102, N'Exceso de Tiempo', NULL, N'Dashboard/ExcesoTiempo/ExcesoTiempo.aspx', NULL, 3, CAST(N'2018-05-21 15:38:33.477' AS DateTime), N'EXT', N'F')
INSERT [dbo].[CFMenu] ([IdMenu], [IdMenuPadre], [IdEtiqueta], [Descripcion], [IdEtiquetaDetalle], [Url], [UrlImagen], [Posicion], [FchRegistro], [CodMenu], [flg]) VALUES (20, NULL, 57, N'Cargas', NULL, NULL, N'upload', 1, CAST(N'2018-06-13 02:54:22.193' AS DateTime), N'CAR', N'T')
INSERT [dbo].[CFMenu] ([IdMenu], [IdMenuPadre], [IdEtiqueta], [Descripcion], [IdEtiquetaDetalle], [Url], [UrlImagen], [Posicion], [FchRegistro], [CodMenu], [flg]) VALUES (21, 20, 57, N'Cargas', NULL, N'Acciones/Carga/Carga.aspx', N'upload', 1, CAST(N'2018-05-21 15:38:33.477' AS DateTime), N'CR2', N'T')
INSERT [dbo].[CFMenu] ([IdMenu], [IdMenuPadre], [IdEtiqueta], [Descripcion], [IdEtiquetaDetalle], [Url], [UrlImagen], [Posicion], [FchRegistro], [CodMenu], [flg]) VALUES (22, 2, 119, N'Zonas', NULL, N'Mantenimiento/Zonas/Zonas.aspx', NULL, 1, CAST(N'2018-05-21 12:38:22.007' AS DateTime), N'ZON', N'T')
INSERT [dbo].[CFMenu] ([IdMenu], [IdMenuPadre], [IdEtiqueta], [Descripcion], [IdEtiquetaDetalle], [Url], [UrlImagen], [Posicion], [FchRegistro], [CodMenu], [flg]) VALUES (23, 2, 120, N'Contactos', NULL, N'Mantenimiento/Contactos/Contactos.aspx', NULL, 4, CAST(N'2018-05-21 12:38:22.007' AS DateTime), N'CON', N'T')
INSERT [dbo].[CFMenu] ([IdMenu], [IdMenuPadre], [IdEtiqueta], [Descripcion], [IdEtiquetaDetalle], [Url], [UrlImagen], [Posicion], [FchRegistro], [CodMenu], [flg]) VALUES (24, 2, 121, N'Detalle Tipo de Actividad', NULL, N'Mantenimiento/DetalleTipoActividad/DetalleTipoActividad.aspx', NULL, 8, CAST(N'2018-05-21 12:38:22.007' AS DateTime), N'DAC', N'F')
INSERT [dbo].[CFMenu] ([IdMenu], [IdMenuPadre], [IdEtiqueta], [Descripcion], [IdEtiquetaDetalle], [Url], [UrlImagen], [Posicion], [FchRegistro], [CodMenu], [flg]) VALUES (25, 2, 124, N'Mantenimiento de Grupo', NULL, N'Mantenimiento/Grupo/Grupo.aspx', NULL, 7, CAST(N'2018-05-02 12:13:20.877' AS DateTime), N'TIP', N'T')
INSERT [dbo].[CFMenu] ([IdMenu], [IdMenuPadre], [IdEtiqueta], [Descripcion], [IdEtiquetaDetalle], [Url], [UrlImagen], [Posicion], [FchRegistro], [CodMenu], [flg]) VALUES (26, 27, 126, N'Dashboard_Movil', NULL, N'Movil/Dashboard/Dashboard.aspx', NULL, 2, CAST(N'2018-02-05 12:13:20.877' AS DateTime), N'DSM', N'T')
INSERT [dbo].[CFMenu] ([IdMenu], [IdMenuPadre], [IdEtiqueta], [Descripcion], [IdEtiquetaDetalle], [Url], [UrlImagen], [Posicion], [FchRegistro], [CodMenu], [flg]) VALUES (27, NULL, 126, N'Dashboard', NULL, NULL, N'chart-area', 1, CAST(N'2019-02-06 11:18:29.107' AS DateTime), N'DAS', N'T')
SET IDENTITY_INSERT [dbo].[CFMenu] OFF
SET IDENTITY_INSERT [dbo].[CFMes] ON 

INSERT [dbo].[CFMes] ([IdMES], [Descripcion], [FlgHabilitado]) VALUES (1, N'Enero', N'1')
INSERT [dbo].[CFMes] ([IdMES], [Descripcion], [FlgHabilitado]) VALUES (2, N'Febrero', N'1')
INSERT [dbo].[CFMes] ([IdMES], [Descripcion], [FlgHabilitado]) VALUES (3, N'Marzo', N'1')
INSERT [dbo].[CFMes] ([IdMES], [Descripcion], [FlgHabilitado]) VALUES (4, N'Abril', N'1')
INSERT [dbo].[CFMes] ([IdMES], [Descripcion], [FlgHabilitado]) VALUES (5, N'Mayo', N'1')
INSERT [dbo].[CFMes] ([IdMES], [Descripcion], [FlgHabilitado]) VALUES (6, N'Junio', N'1')
INSERT [dbo].[CFMes] ([IdMES], [Descripcion], [FlgHabilitado]) VALUES (7, N'Julio', N'1')
INSERT [dbo].[CFMes] ([IdMES], [Descripcion], [FlgHabilitado]) VALUES (8, N'Agosto', N'1')
INSERT [dbo].[CFMes] ([IdMES], [Descripcion], [FlgHabilitado]) VALUES (9, N'Septiembre', N'1')
INSERT [dbo].[CFMes] ([IdMES], [Descripcion], [FlgHabilitado]) VALUES (10, N'Octubre', N'1')
INSERT [dbo].[CFMes] ([IdMES], [Descripcion], [FlgHabilitado]) VALUES (11, N'Noviembre', N'1')
INSERT [dbo].[CFMes] ([IdMES], [Descripcion], [FlgHabilitado]) VALUES (12, N'Diciembre', N'1')
SET IDENTITY_INSERT [dbo].[CFMes] OFF
SET IDENTITY_INSERT [dbo].[CFPais] ON 

INSERT [dbo].[CFPais] ([IdPais], [CodPais], [Descripcion], [FchRegistro]) VALUES (1, N'PE', N'Peru', CAST(N'2014-07-25 16:48:47.997' AS DateTime))
SET IDENTITY_INSERT [dbo].[CFPais] OFF
SET IDENTITY_INSERT [dbo].[CFTipoControl] ON 

INSERT [dbo].[CFTipoControl] ([Id], [Codigo], [Nombre], [FlgHabilitado]) VALUES (2, N'1', N'ALFANUMÉRICO', N'T')
INSERT [dbo].[CFTipoControl] ([Id], [Codigo], [Nombre], [FlgHabilitado]) VALUES (3, N'2', N'CHECKBOX', N'F')
INSERT [dbo].[CFTipoControl] ([Id], [Codigo], [Nombre], [FlgHabilitado]) VALUES (4, N'3', N'COMBOBOX', N'T')
INSERT [dbo].[CFTipoControl] ([Id], [Codigo], [Nombre], [FlgHabilitado]) VALUES (5, N'4', N'NUMÉRICO', N'T')
INSERT [dbo].[CFTipoControl] ([Id], [Codigo], [Nombre], [FlgHabilitado]) VALUES (6, N'5', N'FECHA', N'T')
INSERT [dbo].[CFTipoControl] ([Id], [Codigo], [Nombre], [FlgHabilitado]) VALUES (7, N'6', N'DECIMAL', N'T')
INSERT [dbo].[CFTipoControl] ([Id], [Codigo], [Nombre], [FlgHabilitado]) VALUES (8, N'7', N'HORA', N'F')
INSERT [dbo].[CFTipoControl] ([Id], [Codigo], [Nombre], [FlgHabilitado]) VALUES (9, N'8', N'RADIOBUTTON', N'F')
INSERT [dbo].[CFTipoControl] ([Id], [Codigo], [Nombre], [FlgHabilitado]) VALUES (10, N'9', N'FOTO', N'T')
INSERT [dbo].[CFTipoControl] ([Id], [Codigo], [Nombre], [FlgHabilitado]) VALUES (19, N'10', N'TEXTAREA', N'T')
SET IDENTITY_INSERT [dbo].[CFTipoControl] OFF
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 1, N'mantenimiento', CAST(N'2014-07-30 17:39:45.117' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 2, N'acción', CAST(N'2014-07-30 17:39:49.913' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 3, N'reporte', CAST(N'2014-07-30 17:39:52.487' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 4, N'Usuarios', CAST(N'2014-07-30 17:39:55.607' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 5, N'usuarios', CAST(N'2014-07-30 17:39:58.693' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 7, N'grupo de usuarios', CAST(N'2014-07-30 17:40:08.987' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 8, N'grupos de usuarios', CAST(N'2014-07-30 17:40:12.830' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 10, N'estado', CAST(N'2014-07-30 17:40:26.043' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 11, N'estados', CAST(N'2014-07-30 17:40:31.520' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 13, N'punto de interés', CAST(N'2014-07-30 17:40:44.750' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 14, N'puntos de interés', CAST(N'2014-07-30 17:40:48.247' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 16, N'supervisor', CAST(N'2014-07-30 17:41:01.383' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 17, N'supervisores', CAST(N'2014-07-30 17:41:04.430' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 19, N'geocerca', CAST(N'2014-07-30 17:41:15.420' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 20, N'geocercas', CAST(N'2014-07-30 17:41:16.760' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 22, N'capa de puntos de interés', CAST(N'2014-07-30 17:41:31.317' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 23, N'capas de puntos de interés', CAST(N'2014-07-30 17:41:35.340' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 24, N'formulario', CAST(N'2014-07-30 17:41:38.470' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 25, N'formularios', CAST(N'2014-07-30 17:41:41.073' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 27, N'mapa', CAST(N'2014-07-30 17:42:06.653' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 28, N'mapas', CAST(N'2014-07-30 17:42:09.913' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 29, N'servicio activo', CAST(N'2014-07-30 17:42:15.560' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 30, N'servicios activos', CAST(N'2014-07-30 17:42:22.883' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 32, N'mensaje', CAST(N'2014-07-30 17:42:38.913' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 33, N'mensajes enviados', CAST(N'2014-07-30 17:42:41.867' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 35, N'enviar mensaje', CAST(N'2014-07-31 09:55:35.087' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 36, N'localización', CAST(N'2014-07-31 09:55:40.657' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 37, N'configuración', CAST(N'2014-08-11 16:05:23.203' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 39, N'Bienvenido a {0}.', CAST(N'2014-09-04 11:45:43.387' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 40, N'La señal que esperabas.', CAST(N'2014-09-04 11:45:47.723' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 46, N'Entel', CAST(N'2014-09-04 11:46:53.193' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 47, N'Nextel', CAST(N'2014-09-04 11:47:05.773' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 48, N'© {0} Perú. Derechos Reservados.', CAST(N'2014-09-04 11:47:10.073' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 49, N'Sistema CRM', CAST(N'2014-09-04 12:37:23.210' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 50, N'Producto', CAST(N'2014-09-04 12:37:38.750' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 51, N'Por favor, sirvase leer nuestro convenio para el uso y privacidad del sitio.', CAST(N'2014-09-04 12:37:48.690' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 52, N'', CAST(N'2014-09-04 12:37:52.720' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 53, N'data.soporte@nextel.com.pe', CAST(N'2014-09-18 15:53:25.163' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 54, N'data.soporte@entel.pe', CAST(N'2014-10-13 11:46:17.920' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 55, N'Perfiles', CAST(N'2015-02-06 15:01:23.813' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 57, N'Cargas', CAST(N'2015-02-06 15:01:23.813' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 61, N'Dashboard', CAST(N'2018-05-21 00:00:00.000' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 62, N'Bandeja', CAST(N'2015-02-06 15:01:23.813' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 63, N'Monitor Unidades', CAST(N'2015-02-06 15:01:23.813' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 64, N'Rutas DT', CAST(N'2015-02-06 15:01:23.813' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 65, N'Monitoreo Zonas', CAST(N'2015-02-06 15:01:23.813' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 66, N'Zona Carga', CAST(N'2015-02-06 15:01:23.813' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 67, N'Equipos Moviles', CAST(N'2015-02-06 15:01:23.813' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 68, N'Gruas', CAST(N'2015-02-06 15:01:23.813' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 69, N'Notificaciones', CAST(N'2015-02-06 15:01:23.813' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 70, N'Mantenimiento de Usuario', CAST(N'2018-04-23 10:20:41.900' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 71, N'Usuario', CAST(N'2018-04-23 10:20:41.913' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 72, N'Usuarios', CAST(N'2018-04-23 10:20:41.927' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 73, N'10', CAST(N'2018-04-23 10:20:41.947' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 74, N'Mantenimiento de Cliente', CAST(N'2018-04-23 10:20:41.960' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 75, N'Cliente', CAST(N'2018-04-23 10:20:41.963' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 76, N'Clientes', CAST(N'2018-04-23 10:20:41.977' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 77, N'Mantenimiento de Etapa', CAST(N'2018-04-23 10:20:41.993' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 78, N'Etapa', CAST(N'2018-04-23 10:20:42.010' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 79, N'Etapas', CAST(N'2018-04-23 10:20:42.020' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 80, N'Bandeja de Oportunidades', CAST(N'2018-04-23 10:20:42.040' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 81, N'Bandeja de Oportunidades', CAST(N'2018-04-23 10:20:42.053' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 82, N'Bandeja de Oportunidades', CAST(N'2018-04-23 10:20:42.067' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 83, N'DashBoard de Actividades', CAST(N'2018-04-23 10:20:42.083' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 84, N'Actividades', CAST(N'2018-04-23 10:20:42.097' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 85, N'Actividades', CAST(N'2018-04-23 10:20:42.107' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 86, N'DashBoard Etapas por Estado', CAST(N'2018-04-23 10:20:42.127' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 87, N'Etapas por Estado', CAST(N'2018-04-23 10:20:42.137' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 88, N'Etapas por Estado', CAST(N'2018-04-23 10:20:42.147' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 89, N'Mantenimiento de Tipo', CAST(N'2018-05-02 00:00:00.000' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 90, N'Grupo', CAST(N'2018-05-02 00:00:00.000' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 91, N'Tipo Actividad', CAST(N'2018-05-02 00:00:00.000' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 93, N'Reporte de Actividades', CAST(N'2018-05-18 16:23:54.740' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 94, N'Reporte de Actividades', CAST(N'2018-05-18 16:23:54.740' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 95, N'Reporte de Actividades', CAST(N'2018-05-18 16:23:54.743' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 96, N'Mantenimiento Detalle Tipo de Actividad', CAST(N'2018-05-21 11:55:20.893' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 97, N'Detalle de Tipo de Actividad', CAST(N'2018-05-21 11:55:20.897' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 98, N'Sub Tipo de Actividad', CAST(N'2018-05-21 11:55:20.897' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 99, N'Detalle de Grupo', CAST(N'2018-05-21 00:00:00.000' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 100, N'General', CAST(N'2018-05-21 00:00:00.000' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 101, N'General', CAST(N'2018-05-21 00:00:00.000' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 102, N'Exceso de Tiempo', CAST(N'2018-05-21 00:00:00.000' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 103, N'DashBoard Exceso de Tiempo', CAST(N'2018-05-21 00:00:00.000' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 104, N'Exceso de Tiempo', CAST(N'2018-05-21 00:00:00.000' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 105, N'DashBoardExceso de Tiempo', CAST(N'2018-05-29 13:38:01.777' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 106, N'Fila', CAST(N'2018-06-19 20:02:00.910' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 107, N'Razón Social', CAST(N'2018-06-19 20:02:00.910' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 108, N'RUC', CAST(N'2018-06-19 20:02:00.913' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 109, N'RUBRO', CAST(N'2018-06-19 20:02:00.917' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 110, N'REGIÓN', CAST(N'2018-06-19 20:02:00.917' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 111, N'CANAL', CAST(N'2018-06-19 20:02:00.920' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 112, N'ERROR', CAST(N'2018-06-19 20:02:00.920' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 113, N'CODIGO', CAST(N'2018-06-19 20:02:00.923' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 114, N'NOMBRE', CAST(N'2018-06-19 20:02:00.923' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 115, N'CODIGO PADRE', CAST(N'2018-06-19 20:02:00.927' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 116, N'CODIGO DETALLE PADRE', CAST(N'2018-06-19 20:02:00.930' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 117, N'LOGIN', CAST(N'2018-06-19 20:02:00.930' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 118, N'COORDINADOR', CAST(N'2018-06-19 20:02:00.933' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 119, N'Zonas', CAST(N'2018-06-19 20:02:00.933' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 120, N'Contactos', CAST(N'2018-06-19 20:02:00.933' AS DateTime))
GO
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 121, N'Detalle Tipo de Actividad', CAST(N'2018-06-19 20:02:00.933' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 124, N'Grupo', CAST(N'2018-06-19 20:02:00.933' AS DateTime))
INSERT [dbo].[CFValorEtiqueta] ([IdPais], [IdEtiqueta], [Descripcion], [FchRegistro]) VALUES (1, 126, N'Dashboard', CAST(N'2019-02-06 00:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[ERR_Cliente] ON 

INSERT [dbo].[ERR_Cliente] ([ID], [Razon_Social], [RUC], [CodZona], [CodCanal], [ERR_Razon_Social], [ERR_RUC], [ERR_CodZona], [ERR_CodCanal], [ERR_AUX], [Referencia], [ERR_Referencia], [ERR_Direccion], [Direccion]) VALUES (1, N'CLIENTES SAC', N'23456786542', N'ZON02', N'B2B', NULL, NULL, NULL, NULL, NULL, N'LIMA', NULL, NULL, N'LIMA PERU')
INSERT [dbo].[ERR_Cliente] ([ID], [Razon_Social], [RUC], [CodZona], [CodCanal], [ERR_Razon_Social], [ERR_RUC], [ERR_CodZona], [ERR_CodCanal], [ERR_AUX], [Referencia], [ERR_Referencia], [ERR_Direccion], [Direccion]) VALUES (2, N'CLIENTES2 SAC', N'10236786542', N'ZON02', N'B2C', NULL, NULL, NULL, NULL, NULL, N'LIMA', NULL, NULL, N'MIRAFLORES PERU')
SET IDENTITY_INSERT [dbo].[ERR_Cliente] OFF
SET IDENTITY_INSERT [dbo].[ERR_Contacto] ON 

INSERT [dbo].[ERR_Contacto] ([ID], [Nombres], [Telefono], [Email], [Cargo], [Ruc_Cliente], [CodZona], [ERR_Nombres], [ERR_Telefono], [ERR_Email], [ERR_Cargo], [ERR_Ruc_Cliente], [ERR_CodZona], [ERR_AUX]) VALUES (1, N'CONTACTO', N'987654321', N'CONTACTO@CORREO.PE', N'JEFE', N'23456786542', N'ZON02', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[ERR_Contacto] OFF
SET IDENTITY_INSERT [dbo].[ERR_Usuario] ON 

INSERT [dbo].[ERR_Usuario] ([ID], [Codigo], [Nombres], [LoginUsuario], [Clave], [CodPerfil], [Email], [ERR_Codigo], [ERR_Nombres], [ERR_LoginUsuario], [ERR_Clave], [ERR_CodPerfil], [ERR_Email], [ERR_AUX], [ZONA], [CANAL], [ERR_CANAL], [ERR_ZONA]) VALUES (1, N'USU3', N'USUARIO 3', N'USU3', N'F7C3BC1D808E04732ADF679965CCC34CA7AE3441', N'USUARIO', N'CORREO@CORREO.PE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'ZON03', N'ZON01', N' CODIGO CANAL INVÁLIDO', N' CÓDIGO DE ZONA INVÁLIDO')
INSERT [dbo].[ERR_Usuario] ([ID], [Codigo], [Nombres], [LoginUsuario], [Clave], [CodPerfil], [Email], [ERR_Codigo], [ERR_Nombres], [ERR_LoginUsuario], [ERR_Clave], [ERR_CodPerfil], [ERR_Email], [ERR_AUX], [ZONA], [CANAL], [ERR_CANAL], [ERR_ZONA]) VALUES (2, N'USU4', N'USUARIO 4', N'USU4', N'BFE54CAA6D483CC3887DCE9D1B8EB91408F1EA7A', N'USUARIO', N'CORREO2@CORREO.PE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'ZON03', N'ZON02', N' CODIGO CANAL INVÁLIDO', N' CÓDIGO DE ZONA INVÁLIDO')
SET IDENTITY_INSERT [dbo].[ERR_Usuario] OFF
INSERT [dbo].[ERR_ZONA] ([ID], [Codigo], [Nombre], [ERR_Codigo], [ERR_Nombre], [ERR_AUX]) VALUES (1, N'1324567809', N'Lima Oeste', NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[GRActividad] ON 

INSERT [dbo].[GRActividad] ([IdActividad], [IdConfiguracionActividad], [IdCanal], [IdUsuarioResponsable], [FechaCreacion], [idCliente], [FlgHabilitado], [idContacto], [observaciones], [Fecha], [Latitud], [Longitud], [IdTipoActividad]) VALUES (1, 1, 1, 2, CAST(N'2019-02-04 11:50:50.010' AS DateTime), 1, N'T', 1, N'2', CAST(N'2019-02-03 00:00:00.000' AS DateTime), -12.062045, -76.9521108, 1)
INSERT [dbo].[GRActividad] ([IdActividad], [IdConfiguracionActividad], [IdCanal], [IdUsuarioResponsable], [FechaCreacion], [idCliente], [FlgHabilitado], [idContacto], [observaciones], [Fecha], [Latitud], [Longitud], [IdTipoActividad]) VALUES (2, 1, 1, 2, CAST(N'2019-02-04 11:55:39.350' AS DateTime), 1, N'T', 1, N'2', CAST(N'2019-02-04 00:00:00.000' AS DateTime), -12.0620359, -76.9521175, 1)
INSERT [dbo].[GRActividad] ([IdActividad], [IdConfiguracionActividad], [IdCanal], [IdUsuarioResponsable], [FechaCreacion], [idCliente], [FlgHabilitado], [idContacto], [observaciones], [Fecha], [Latitud], [Longitud], [IdTipoActividad]) VALUES (3, 2, 2, 3, CAST(N'2019-02-04 13:28:32.820' AS DateTime), 2, N'T', 2, N'3', CAST(N'2019-02-03 00:00:00.000' AS DateTime), -12.099584, -77.02609919999999, 2)
INSERT [dbo].[GRActividad] ([IdActividad], [IdConfiguracionActividad], [IdCanal], [IdUsuarioResponsable], [FechaCreacion], [idCliente], [FlgHabilitado], [idContacto], [observaciones], [Fecha], [Latitud], [Longitud], [IdTipoActividad]) VALUES (4, 1, 1, 2, CAST(N'2019-02-04 13:29:19.817' AS DateTime), 1, N'T', 1, N'2', CAST(N'2019-02-04 00:00:00.000' AS DateTime), -12.099584, -77.02609919999999, 1)
INSERT [dbo].[GRActividad] ([IdActividad], [IdConfiguracionActividad], [IdCanal], [IdUsuarioResponsable], [FechaCreacion], [idCliente], [FlgHabilitado], [idContacto], [observaciones], [Fecha], [Latitud], [Longitud], [IdTipoActividad]) VALUES (5, 1, 1, 2, CAST(N'2019-02-04 14:18:24.147' AS DateTime), 1, N'T', 1, N'2', CAST(N'2019-02-04 00:00:00.000' AS DateTime), 0, 0, 1)
INSERT [dbo].[GRActividad] ([IdActividad], [IdConfiguracionActividad], [IdCanal], [IdUsuarioResponsable], [FechaCreacion], [idCliente], [FlgHabilitado], [idContacto], [observaciones], [Fecha], [Latitud], [Longitud], [IdTipoActividad]) VALUES (6, 1, 1, 2, CAST(N'2019-02-04 15:37:02.393' AS DateTime), 3, N'T', 8, N'2', CAST(N'2019-02-03 00:00:00.000' AS DateTime), 0, 0, 1)
INSERT [dbo].[GRActividad] ([IdActividad], [IdConfiguracionActividad], [IdCanal], [IdUsuarioResponsable], [FechaCreacion], [idCliente], [FlgHabilitado], [idContacto], [observaciones], [Fecha], [Latitud], [Longitud], [IdTipoActividad]) VALUES (7, 1, 1, 2, CAST(N'2019-02-04 17:12:52.877' AS DateTime), 1, N'T', 1, N'2', CAST(N'2019-02-04 00:00:00.000' AS DateTime), 0, 0, 1)
INSERT [dbo].[GRActividad] ([IdActividad], [IdConfiguracionActividad], [IdCanal], [IdUsuarioResponsable], [FechaCreacion], [idCliente], [FlgHabilitado], [idContacto], [observaciones], [Fecha], [Latitud], [Longitud], [IdTipoActividad]) VALUES (8, 3, 1, 2, CAST(N'2019-02-04 17:15:37.393' AS DateTime), 3, N'T', 9, N'2', CAST(N'2019-02-04 00:00:00.000' AS DateTime), 0, 0, 3)
INSERT [dbo].[GRActividad] ([IdActividad], [IdConfiguracionActividad], [IdCanal], [IdUsuarioResponsable], [FechaCreacion], [idCliente], [FlgHabilitado], [idContacto], [observaciones], [Fecha], [Latitud], [Longitud], [IdTipoActividad]) VALUES (9, 3, 1, 2, CAST(N'2019-02-04 17:16:23.383' AS DateTime), 3, N'T', 9, N'2', CAST(N'2019-02-04 00:00:00.000' AS DateTime), 0, 0, 3)
INSERT [dbo].[GRActividad] ([IdActividad], [IdConfiguracionActividad], [IdCanal], [IdUsuarioResponsable], [FechaCreacion], [idCliente], [FlgHabilitado], [idContacto], [observaciones], [Fecha], [Latitud], [Longitud], [IdTipoActividad]) VALUES (10, 1, 1, 2, CAST(N'2019-02-04 18:05:39.353' AS DateTime), 1, N'T', 1, N'2', CAST(N'2019-02-04 00:00:00.000' AS DateTime), 0, 0, 1)
INSERT [dbo].[GRActividad] ([IdActividad], [IdConfiguracionActividad], [IdCanal], [IdUsuarioResponsable], [FechaCreacion], [idCliente], [FlgHabilitado], [idContacto], [observaciones], [Fecha], [Latitud], [Longitud], [IdTipoActividad]) VALUES (11, 1, 1, 2, CAST(N'2019-02-04 18:13:03.360' AS DateTime), 1, N'T', 1, N'2', CAST(N'2019-02-04 00:00:00.000' AS DateTime), 0, 0, 1)
INSERT [dbo].[GRActividad] ([IdActividad], [IdConfiguracionActividad], [IdCanal], [IdUsuarioResponsable], [FechaCreacion], [idCliente], [FlgHabilitado], [idContacto], [observaciones], [Fecha], [Latitud], [Longitud], [IdTipoActividad]) VALUES (12, 2, 2, 3, CAST(N'2019-02-04 18:24:43.590' AS DateTime), 2, N'T', 2, N'3', CAST(N'2019-02-04 00:00:00.000' AS DateTime), 0, 0, 2)
INSERT [dbo].[GRActividad] ([IdActividad], [IdConfiguracionActividad], [IdCanal], [IdUsuarioResponsable], [FechaCreacion], [idCliente], [FlgHabilitado], [idContacto], [observaciones], [Fecha], [Latitud], [Longitud], [IdTipoActividad]) VALUES (13, 2, 2, 3, CAST(N'2019-02-04 18:26:06.600' AS DateTime), 2, N'T', 2, N'3', CAST(N'2019-02-04 00:00:00.000' AS DateTime), 0, 0, 2)
INSERT [dbo].[GRActividad] ([IdActividad], [IdConfiguracionActividad], [IdCanal], [IdUsuarioResponsable], [FechaCreacion], [idCliente], [FlgHabilitado], [idContacto], [observaciones], [Fecha], [Latitud], [Longitud], [IdTipoActividad]) VALUES (14, 4, 1, 2, CAST(N'2019-02-05 15:03:29.293' AS DateTime), 1, N'T', 1, N'2', CAST(N'2019-02-05 00:00:00.000' AS DateTime), 0, 0, NULL)
INSERT [dbo].[GRActividad] ([IdActividad], [IdConfiguracionActividad], [IdCanal], [IdUsuarioResponsable], [FechaCreacion], [idCliente], [FlgHabilitado], [idContacto], [observaciones], [Fecha], [Latitud], [Longitud], [IdTipoActividad]) VALUES (15, 5, 1, 2, CAST(N'2019-02-05 15:07:08.007' AS DateTime), 3, N'T', 9, N'2', CAST(N'2019-02-05 00:00:00.000' AS DateTime), 0, 0, NULL)
INSERT [dbo].[GRActividad] ([IdActividad], [IdConfiguracionActividad], [IdCanal], [IdUsuarioResponsable], [FechaCreacion], [idCliente], [FlgHabilitado], [idContacto], [observaciones], [Fecha], [Latitud], [Longitud], [IdTipoActividad]) VALUES (16, 2, 2, 3, CAST(N'2019-02-06 08:45:32.553' AS DateTime), 4, N'T', 10, N'3', CAST(N'2019-02-06 00:00:00.000' AS DateTime), -12.092346, -77.00594199999999, 2)
INSERT [dbo].[GRActividad] ([IdActividad], [IdConfiguracionActividad], [IdCanal], [IdUsuarioResponsable], [FechaCreacion], [idCliente], [FlgHabilitado], [idContacto], [observaciones], [Fecha], [Latitud], [Longitud], [IdTipoActividad]) VALUES (17, 2, 2, 3, CAST(N'2019-02-06 08:46:25.297' AS DateTime), 4, N'T', 10, N'3', CAST(N'2019-02-06 00:00:00.000' AS DateTime), -12.092346, -77.00594199999999, 2)
INSERT [dbo].[GRActividad] ([IdActividad], [IdConfiguracionActividad], [IdCanal], [IdUsuarioResponsable], [FechaCreacion], [idCliente], [FlgHabilitado], [idContacto], [observaciones], [Fecha], [Latitud], [Longitud], [IdTipoActividad]) VALUES (18, 1, 1, 2, CAST(N'2019-02-06 09:04:35.300' AS DateTime), 1, N'T', 1, N'2', CAST(N'2019-02-06 00:00:00.000' AS DateTime), -12.0992848, -77.01491759999999, 1)
INSERT [dbo].[GRActividad] ([IdActividad], [IdConfiguracionActividad], [IdCanal], [IdUsuarioResponsable], [FechaCreacion], [idCliente], [FlgHabilitado], [idContacto], [observaciones], [Fecha], [Latitud], [Longitud], [IdTipoActividad]) VALUES (19, 2, 2, 3, CAST(N'2019-02-06 09:05:36.997' AS DateTime), 2, N'T', 2, N'3', CAST(N'2019-02-05 00:00:00.000' AS DateTime), -12.0992848, -77.01491759999999, 2)
INSERT [dbo].[GRActividad] ([IdActividad], [IdConfiguracionActividad], [IdCanal], [IdUsuarioResponsable], [FechaCreacion], [idCliente], [FlgHabilitado], [idContacto], [observaciones], [Fecha], [Latitud], [Longitud], [IdTipoActividad]) VALUES (21, NULL, 1, 2, CAST(N'2019-02-06 13:11:11.057' AS DateTime), 1, N'T', 1, N'2', CAST(N'2019-02-05 00:00:00.000' AS DateTime), -12.10368, -77.0162688, NULL)
INSERT [dbo].[GRActividad] ([IdActividad], [IdConfiguracionActividad], [IdCanal], [IdUsuarioResponsable], [FechaCreacion], [idCliente], [FlgHabilitado], [idContacto], [observaciones], [Fecha], [Latitud], [Longitud], [IdTipoActividad]) VALUES (22, NULL, 1, 2, CAST(N'2019-02-06 13:25:00.423' AS DateTime), 1, N'T', 1, N'2', CAST(N'2019-02-06 00:00:00.000' AS DateTime), -12.10368, -77.0162688, 8)
INSERT [dbo].[GRActividad] ([IdActividad], [IdConfiguracionActividad], [IdCanal], [IdUsuarioResponsable], [FechaCreacion], [idCliente], [FlgHabilitado], [idContacto], [observaciones], [Fecha], [Latitud], [Longitud], [IdTipoActividad]) VALUES (23, NULL, 1, 2, CAST(N'2019-02-06 13:27:32.833' AS DateTime), 1, N'T', 1, N'2', CAST(N'2019-02-05 00:00:00.000' AS DateTime), -12.0995215, -77.0153, 8)
INSERT [dbo].[GRActividad] ([IdActividad], [IdConfiguracionActividad], [IdCanal], [IdUsuarioResponsable], [FechaCreacion], [idCliente], [FlgHabilitado], [idContacto], [observaciones], [Fecha], [Latitud], [Longitud], [IdTipoActividad]) VALUES (24, 2, 2, 3, CAST(N'2019-02-06 13:28:01.950' AS DateTime), 2, N'T', 2, N'3', CAST(N'2019-02-06 00:00:00.000' AS DateTime), -12.0995215, -77.0153, 2)
INSERT [dbo].[GRActividad] ([IdActividad], [IdConfiguracionActividad], [IdCanal], [IdUsuarioResponsable], [FechaCreacion], [idCliente], [FlgHabilitado], [idContacto], [observaciones], [Fecha], [Latitud], [Longitud], [IdTipoActividad]) VALUES (25, 1, 1, 2, CAST(N'2019-02-07 10:18:34.507' AS DateTime), 1, N'T', 1, N'2', CAST(N'2019-02-07 00:00:00.000' AS DateTime), 0, 0, 1)
INSERT [dbo].[GRActividad] ([IdActividad], [IdConfiguracionActividad], [IdCanal], [IdUsuarioResponsable], [FechaCreacion], [idCliente], [FlgHabilitado], [idContacto], [observaciones], [Fecha], [Latitud], [Longitud], [IdTipoActividad]) VALUES (26, 11, 1, 2, CAST(N'2019-02-13 17:57:16.107' AS DateTime), 1, N'T', 1, N'2', CAST(N'2019-02-12 00:00:00.000' AS DateTime), 0, 0, NULL)
INSERT [dbo].[GRActividad] ([IdActividad], [IdConfiguracionActividad], [IdCanal], [IdUsuarioResponsable], [FechaCreacion], [idCliente], [FlgHabilitado], [idContacto], [observaciones], [Fecha], [Latitud], [Longitud], [IdTipoActividad]) VALUES (27, 2, 2, 3, CAST(N'2019-02-14 11:18:48.177' AS DateTime), 2, N'T', 2, N'3', CAST(N'2019-02-13 00:00:00.000' AS DateTime), 0, 0, NULL)
INSERT [dbo].[GRActividad] ([IdActividad], [IdConfiguracionActividad], [IdCanal], [IdUsuarioResponsable], [FechaCreacion], [idCliente], [FlgHabilitado], [idContacto], [observaciones], [Fecha], [Latitud], [Longitud], [IdTipoActividad]) VALUES (28, 1, 1, 2, CAST(N'2019-02-18 10:16:15.853' AS DateTime), 1, N'T', 1, N'2', CAST(N'2019-02-17 00:00:00.000' AS DateTime), 0, 0, NULL)
INSERT [dbo].[GRActividad] ([IdActividad], [IdConfiguracionActividad], [IdCanal], [IdUsuarioResponsable], [FechaCreacion], [idCliente], [FlgHabilitado], [idContacto], [observaciones], [Fecha], [Latitud], [Longitud], [IdTipoActividad]) VALUES (29, 1, 1, 2, CAST(N'2019-03-03 14:14:34.573' AS DateTime), 1, N'T', 1, N'2', CAST(N'2019-03-02 00:00:00.000' AS DateTime), -12.0446976, -76.927795199999991, NULL)
INSERT [dbo].[GRActividad] ([IdActividad], [IdConfiguracionActividad], [IdCanal], [IdUsuarioResponsable], [FechaCreacion], [idCliente], [FlgHabilitado], [idContacto], [observaciones], [Fecha], [Latitud], [Longitud], [IdTipoActividad]) VALUES (30, 1, 1, 2, CAST(N'2019-03-03 14:14:41.813' AS DateTime), 1, N'T', 1, N'2', CAST(N'2019-03-02 00:00:00.000' AS DateTime), -12.0446976, -76.927795199999991, NULL)
INSERT [dbo].[GRActividad] ([IdActividad], [IdConfiguracionActividad], [IdCanal], [IdUsuarioResponsable], [FechaCreacion], [idCliente], [FlgHabilitado], [idContacto], [observaciones], [Fecha], [Latitud], [Longitud], [IdTipoActividad]) VALUES (31, 1, 1, 2, CAST(N'2019-03-03 14:20:27.003' AS DateTime), 1, N'T', 1, N'2', CAST(N'2019-03-02 00:00:00.000' AS DateTime), -12.0446976, -76.927795199999991, NULL)
INSERT [dbo].[GRActividad] ([IdActividad], [IdConfiguracionActividad], [IdCanal], [IdUsuarioResponsable], [FechaCreacion], [idCliente], [FlgHabilitado], [idContacto], [observaciones], [Fecha], [Latitud], [Longitud], [IdTipoActividad]) VALUES (32, 1, 1, 2, CAST(N'2019-03-03 14:22:23.703' AS DateTime), 1, N'T', 1, N'2', CAST(N'2019-03-02 00:00:00.000' AS DateTime), -12.0446976, -76.927795199999991, NULL)
INSERT [dbo].[GRActividad] ([IdActividad], [IdConfiguracionActividad], [IdCanal], [IdUsuarioResponsable], [FechaCreacion], [idCliente], [FlgHabilitado], [idContacto], [observaciones], [Fecha], [Latitud], [Longitud], [IdTipoActividad]) VALUES (33, 2, 2, 3, CAST(N'2019-03-03 14:22:59.317' AS DateTime), 2, N'T', 2, N'3', CAST(N'2019-03-02 00:00:00.000' AS DateTime), -12.0446976, -76.927795199999991, NULL)
SET IDENTITY_INSERT [dbo].[GRActividad] OFF
SET IDENTITY_INSERT [dbo].[GRCanal] ON 

INSERT [dbo].[GRCanal] ([IdCanal], [Codigo], [Nombre]) VALUES (1, N'B2B', N'B2B')
INSERT [dbo].[GRCanal] ([IdCanal], [Codigo], [Nombre]) VALUES (2, N'B2C', N'B2C')
SET IDENTITY_INSERT [dbo].[GRCanal] OFF
SET IDENTITY_INSERT [dbo].[GRCliente] ON 

INSERT [dbo].[GRCliente] ([CLI_PK], [Razon_Social], [RUC], [FlgHabilitado], [Direccion], [Referencia], [IdCanal]) VALUES (1, N'Cliente B2B', N'10448118940', N'T', N'LIMA', N'LIMA', 1)
INSERT [dbo].[GRCliente] ([CLI_PK], [Razon_Social], [RUC], [FlgHabilitado], [Direccion], [Referencia], [IdCanal]) VALUES (2, N'Cliente B2C', N'1044811894', N'T', N'Arequipa', N'Arequipa', 2)
INSERT [dbo].[GRCliente] ([CLI_PK], [Razon_Social], [RUC], [FlgHabilitado], [Direccion], [Referencia], [IdCanal]) VALUES (3, N'CLIENTES SAC', N'23456786542', N'T', N'LIMA PERU', N'LIMA', 1)
INSERT [dbo].[GRCliente] ([CLI_PK], [Razon_Social], [RUC], [FlgHabilitado], [Direccion], [Referencia], [IdCanal]) VALUES (4, N'CLIENTES2 SAC', N'10236786542', N'T', N'MIRAFLORES PERU', N'LIMA', 2)
INSERT [dbo].[GRCliente] ([CLI_PK], [Razon_Social], [RUC], [FlgHabilitado], [Direccion], [Referencia], [IdCanal]) VALUES (5, N'cliente SANTIAGO VIDAL SAC', N'10448118946', N'T', N'LIMA', N'LIMA 33', 1)
INSERT [dbo].[GRCliente] ([CLI_PK], [Razon_Social], [RUC], [FlgHabilitado], [Direccion], [Referencia], [IdCanal]) VALUES (6, N'Jose Campana SAV', N'10215551122', N'T', N'San Isidro', N'San Isidro', 1)
SET IDENTITY_INSERT [dbo].[GRCliente] OFF
SET IDENTITY_INSERT [dbo].[GRClienteZona] ON 

INSERT [dbo].[GRClienteZona] ([IdClienteZona], [idCliente], [idZona]) VALUES (1, 1, 1)
INSERT [dbo].[GRClienteZona] ([IdClienteZona], [idCliente], [idZona]) VALUES (2, 1, 2)
INSERT [dbo].[GRClienteZona] ([IdClienteZona], [idCliente], [idZona]) VALUES (5, 2, 1)
INSERT [dbo].[GRClienteZona] ([IdClienteZona], [idCliente], [idZona]) VALUES (6, 2, 2)
INSERT [dbo].[GRClienteZona] ([IdClienteZona], [idCliente], [idZona]) VALUES (7, 3, 4)
INSERT [dbo].[GRClienteZona] ([IdClienteZona], [idCliente], [idZona]) VALUES (8, 4, 4)
INSERT [dbo].[GRClienteZona] ([IdClienteZona], [idCliente], [idZona]) VALUES (13, 6, 4)
INSERT [dbo].[GRClienteZona] ([IdClienteZona], [idCliente], [idZona]) VALUES (14, 6, 5)
INSERT [dbo].[GRClienteZona] ([IdClienteZona], [idCliente], [idZona]) VALUES (15, 5, 1)
INSERT [dbo].[GRClienteZona] ([IdClienteZona], [idCliente], [idZona]) VALUES (16, 5, 2)
SET IDENTITY_INSERT [dbo].[GRClienteZona] OFF
SET IDENTITY_INSERT [dbo].[GRContacto] ON 

INSERT [dbo].[GRContacto] ([IdContacto], [Nombre], [Telefono], [Email], [Cargo], [IdCliente], [IdZona], [Flag]) VALUES (1, N'Contacto B2B', N'981514640', N'b2b@gmail.com', N'Operador', 1, 1, N'T')
INSERT [dbo].[GRContacto] ([IdContacto], [Nombre], [Telefono], [Email], [Cargo], [IdCliente], [IdZona], [Flag]) VALUES (2, N'Contacto B2C', N'981514641', N'b2c@gmail.com', N'Especialista', 2, 2, N'T')
INSERT [dbo].[GRContacto] ([IdContacto], [Nombre], [Telefono], [Email], [Cargo], [IdCliente], [IdZona], [Flag]) VALUES (3, N'Santiago Vidal', N'981514644', N'santiago.vidalr@gmail.com', N'Especialista de Desarrollo', 1, 2, N'T')
INSERT [dbo].[GRContacto] ([IdContacto], [Nombre], [Telefono], [Email], [Cargo], [IdCliente], [IdZona], [Flag]) VALUES (4, N'CONTACTO', N'987654321', N'CONTACTO@CORREO.PE', N'JEFE', 3, 4, N'T')
INSERT [dbo].[GRContacto] ([IdContacto], [Nombre], [Telefono], [Email], [Cargo], [IdCliente], [IdZona], [Flag]) VALUES (5, N'CONTACTO', N'987654321', N'CONTACTO@CORREO.PE', N'JEFE', 3, 4, N'T')
INSERT [dbo].[GRContacto] ([IdContacto], [Nombre], [Telefono], [Email], [Cargo], [IdCliente], [IdZona], [Flag]) VALUES (6, N'CONTACTO', N'987654321', N'CONTACTO@CORREO.PE', N'JEFE', 3, 4, N'T')
INSERT [dbo].[GRContacto] ([IdContacto], [Nombre], [Telefono], [Email], [Cargo], [IdCliente], [IdZona], [Flag]) VALUES (7, N'CONTACTO4676', N'987654321', N'CONTACTO@CORREO.PE', N'JEFE', 3, 4, N'T')
INSERT [dbo].[GRContacto] ([IdContacto], [Nombre], [Telefono], [Email], [Cargo], [IdCliente], [IdZona], [Flag]) VALUES (8, N'contacto 0328', N'99990328', N'0328@gmail.com', N'contacto', 3, 1, N'T')
INSERT [dbo].[GRContacto] ([IdContacto], [Nombre], [Telefono], [Email], [Cargo], [IdCliente], [IdZona], [Flag]) VALUES (9, N'Judith', N'941934459', N'Jidith.collantes.c@gmail.com', N'Jefe', 3, 1, N'T')
INSERT [dbo].[GRContacto] ([IdContacto], [Nombre], [Telefono], [Email], [Cargo], [IdCliente], [IdZona], [Flag]) VALUES (10, N'1', N'1', N'1', N'1', 4, 2, N'F')
INSERT [dbo].[GRContacto] ([IdContacto], [Nombre], [Telefono], [Email], [Cargo], [IdCliente], [IdZona], [Flag]) VALUES (11, N'CONTACTO', N'987654321', N'CONTACTO@CORREO.PE', N'JEFE', 3, 4, N'T')
INSERT [dbo].[GRContacto] ([IdContacto], [Nombre], [Telefono], [Email], [Cargo], [IdCliente], [IdZona], [Flag]) VALUES (12, N'CONTACTO', N'987654321', N'CONTACTO@CORREO.PE', N'JEFE', 3, 4, N'F')
SET IDENTITY_INSERT [dbo].[GRContacto] OFF
SET IDENTITY_INSERT [dbo].[GRGrupo] ON 

INSERT [dbo].[GRGrupo] ([IDGrupo], [Codigo], [Nombre], [IdNivel], [CodigoPadreGrupo], [FlgHabilitado], [tipo]) VALUES (1, N'sdfsdfsdfs', N'sdfsdf', 0, N'', N'T', N'G')
INSERT [dbo].[GRGrupo] ([IDGrupo], [Codigo], [Nombre], [IdNivel], [CodigoPadreGrupo], [FlgHabilitado], [tipo]) VALUES (2, N'001', N'Pais', 0, N'', N'T', N'G')
INSERT [dbo].[GRGrupo] ([IDGrupo], [Codigo], [Nombre], [IdNivel], [CodigoPadreGrupo], [FlgHabilitado], [tipo]) VALUES (3, N'002', N'CAPITAL', 0, N'2', N'T', N'G')
INSERT [dbo].[GRGrupo] ([IDGrupo], [Codigo], [Nombre], [IdNivel], [CodigoPadreGrupo], [FlgHabilitado], [tipo]) VALUES (4, N'003', N'CAPITAL PROV', 0, N'3', N'T', N'G')
SET IDENTITY_INSERT [dbo].[GRGrupo] OFF
SET IDENTITY_INSERT [dbo].[GRGrupoDetalle] ON 

INSERT [dbo].[GRGrupoDetalle] ([IdGrupoDetalle], [IdGrupo], [Codigo], [Nombre], [IdCodigoDetallePadre], [FlgHabilitado]) VALUES (1, 1, N'hjhj', N'jjkkkj', N'', N'F')
INSERT [dbo].[GRGrupoDetalle] ([IdGrupoDetalle], [IdGrupo], [Codigo], [Nombre], [IdCodigoDetallePadre], [FlgHabilitado]) VALUES (2, 2, N'per01', N'Perú', N'', N'T')
INSERT [dbo].[GRGrupoDetalle] ([IdGrupoDetalle], [IdGrupo], [Codigo], [Nombre], [IdCodigoDetallePadre], [FlgHabilitado]) VALUES (3, 2, N've01', N'Venezuela', N'', N'T')
INSERT [dbo].[GRGrupoDetalle] ([IdGrupoDetalle], [IdGrupo], [Codigo], [Nombre], [IdCodigoDetallePadre], [FlgHabilitado]) VALUES (4, 3, N'lim01', N'Lima', N'per01', N'T')
INSERT [dbo].[GRGrupoDetalle] ([IdGrupoDetalle], [IdGrupo], [Codigo], [Nombre], [IdCodigoDetallePadre], [FlgHabilitado]) VALUES (5, 3, N'car01', N'Caracas', N've01', N'T')
INSERT [dbo].[GRGrupoDetalle] ([IdGrupoDetalle], [IdGrupo], [Codigo], [Nombre], [IdCodigoDetallePadre], [FlgHabilitado]) VALUES (6, 4, N'001', N'LIMA PROV', N'lim01', N'T')
INSERT [dbo].[GRGrupoDetalle] ([IdGrupoDetalle], [IdGrupo], [Codigo], [Nombre], [IdCodigoDetallePadre], [FlgHabilitado]) VALUES (7, 4, N'CAR01', N'CARACAS PROV', N'car01', N'T')
SET IDENTITY_INSERT [dbo].[GRGrupoDetalle] OFF
SET IDENTITY_INSERT [dbo].[GRPerfil] ON 

INSERT [dbo].[GRPerfil] ([IdPerfil], [Descripcion], [FlgHabilitado]) VALUES (2, N'Administrador', N'T')
INSERT [dbo].[GRPerfil] ([IdPerfil], [Descripcion], [FlgHabilitado]) VALUES (4, N'Vendedor', N'T')
INSERT [dbo].[GRPerfil] ([IdPerfil], [Descripcion], [FlgHabilitado]) VALUES (5, N'Coordinador', N'T')
INSERT [dbo].[GRPerfil] ([IdPerfil], [Descripcion], [FlgHabilitado]) VALUES (6, N'Gerente Comercial', N'T')
INSERT [dbo].[GRPerfil] ([IdPerfil], [Descripcion], [FlgHabilitado]) VALUES (7, N'Jefe de Ventas', N'T')
INSERT [dbo].[GRPerfil] ([IdPerfil], [Descripcion], [FlgHabilitado]) VALUES (8, N'Jefe de Canal', N'T')
SET IDENTITY_INSERT [dbo].[GRPerfil] OFF
INSERT [dbo].[GRPerfilMenu] ([IdPerfil], [IdMenu], [flagHome], [FlgHome]) VALUES (2, 3, NULL, NULL)
INSERT [dbo].[GRPerfilMenu] ([IdPerfil], [IdMenu], [flagHome], [FlgHome]) VALUES (2, 4, NULL, NULL)
INSERT [dbo].[GRPerfilMenu] ([IdPerfil], [IdMenu], [flagHome], [FlgHome]) VALUES (2, 5, NULL, NULL)
INSERT [dbo].[GRPerfilMenu] ([IdPerfil], [IdMenu], [flagHome], [FlgHome]) VALUES (2, 6, NULL, NULL)
INSERT [dbo].[GRPerfilMenu] ([IdPerfil], [IdMenu], [flagHome], [FlgHome]) VALUES (2, 7, NULL, NULL)
INSERT [dbo].[GRPerfilMenu] ([IdPerfil], [IdMenu], [flagHome], [FlgHome]) VALUES (2, 8, NULL, NULL)
INSERT [dbo].[GRPerfilMenu] ([IdPerfil], [IdMenu], [flagHome], [FlgHome]) VALUES (2, 9, NULL, NULL)
INSERT [dbo].[GRPerfilMenu] ([IdPerfil], [IdMenu], [flagHome], [FlgHome]) VALUES (2, 12, NULL, NULL)
INSERT [dbo].[GRPerfilMenu] ([IdPerfil], [IdMenu], [flagHome], [FlgHome]) VALUES (2, 13, NULL, NULL)
INSERT [dbo].[GRPerfilMenu] ([IdPerfil], [IdMenu], [flagHome], [FlgHome]) VALUES (2, 14, NULL, NULL)
INSERT [dbo].[GRPerfilMenu] ([IdPerfil], [IdMenu], [flagHome], [FlgHome]) VALUES (2, 19, NULL, NULL)
INSERT [dbo].[GRPerfilMenu] ([IdPerfil], [IdMenu], [flagHome], [FlgHome]) VALUES (2, 21, NULL, NULL)
INSERT [dbo].[GRPerfilMenu] ([IdPerfil], [IdMenu], [flagHome], [FlgHome]) VALUES (2, 22, NULL, NULL)
INSERT [dbo].[GRPerfilMenu] ([IdPerfil], [IdMenu], [flagHome], [FlgHome]) VALUES (2, 23, NULL, NULL)
INSERT [dbo].[GRPerfilMenu] ([IdPerfil], [IdMenu], [flagHome], [FlgHome]) VALUES (2, 24, NULL, NULL)
INSERT [dbo].[GRPerfilMenu] ([IdPerfil], [IdMenu], [flagHome], [FlgHome]) VALUES (2, 25, NULL, NULL)
INSERT [dbo].[GRPerfilMenu] ([IdPerfil], [IdMenu], [flagHome], [FlgHome]) VALUES (4, 11, NULL, NULL)
INSERT [dbo].[GRPerfilMenu] ([IdPerfil], [IdMenu], [flagHome], [FlgHome]) VALUES (4, 12, NULL, NULL)
INSERT [dbo].[GRPerfilMenu] ([IdPerfil], [IdMenu], [flagHome], [FlgHome]) VALUES (4, 26, NULL, N'T')
INSERT [dbo].[GRPerfilMenu] ([IdPerfil], [IdMenu], [flagHome], [FlgHome]) VALUES (4, 27, NULL, NULL)
SET IDENTITY_INSERT [dbo].[GRSubTipoActividad] ON 

INSERT [dbo].[GRSubTipoActividad] ([IDSubTipoActividad], [Codigo], [Descripcion], [FlgHabilitado], [IDTipoActividad]) VALUES (1, N'1', N'DET B2B 1 ', N'T', 1)
INSERT [dbo].[GRSubTipoActividad] ([IDSubTipoActividad], [Codigo], [Descripcion], [FlgHabilitado], [IDTipoActividad]) VALUES (2, N'2', N'DET B2C', N'T', 2)
INSERT [dbo].[GRSubTipoActividad] ([IDSubTipoActividad], [Codigo], [Descripcion], [FlgHabilitado], [IDTipoActividad]) VALUES (3, N'3', N'Tipo Actividad', N'T', 3)
INSERT [dbo].[GRSubTipoActividad] ([IDSubTipoActividad], [Codigo], [Descripcion], [FlgHabilitado], [IDTipoActividad]) VALUES (4, N'4', N'Identificación de Necesidades', N'T', 4)
INSERT [dbo].[GRSubTipoActividad] ([IDSubTipoActividad], [Codigo], [Descripcion], [FlgHabilitado], [IDTipoActividad]) VALUES (5, N'5', N'Propuesta de Beneficios', N'T', 4)
INSERT [dbo].[GRSubTipoActividad] ([IDSubTipoActividad], [Codigo], [Descripcion], [FlgHabilitado], [IDTipoActividad]) VALUES (6, N'6', N'Negociación y Cierre', N'T', 4)
INSERT [dbo].[GRSubTipoActividad] ([IDSubTipoActividad], [Codigo], [Descripcion], [FlgHabilitado], [IDTipoActividad]) VALUES (7, N'', N'TEST 3 DET', N'T', 9)
INSERT [dbo].[GRSubTipoActividad] ([IDSubTipoActividad], [Codigo], [Descripcion], [FlgHabilitado], [IDTipoActividad]) VALUES (8, N'8', N'test 4', N'T', 9)
INSERT [dbo].[GRSubTipoActividad] ([IDSubTipoActividad], [Codigo], [Descripcion], [FlgHabilitado], [IDTipoActividad]) VALUES (9, N'9', N'detalle', N'T', 1)
INSERT [dbo].[GRSubTipoActividad] ([IDSubTipoActividad], [Codigo], [Descripcion], [FlgHabilitado], [IDTipoActividad]) VALUES (10, N'10', N'1231312312312', N'T', 7)
INSERT [dbo].[GRSubTipoActividad] ([IDSubTipoActividad], [Codigo], [Descripcion], [FlgHabilitado], [IDTipoActividad]) VALUES (11, N'11', N'qweqeqweqweqweqweqweqweqwe', N'T', 3)
SET IDENTITY_INSERT [dbo].[GRSubTipoActividad] OFF
SET IDENTITY_INSERT [dbo].[GRSubTipoActividad_Detalle] ON 

INSERT [dbo].[GRSubTipoActividad_Detalle] ([IDSubTipoActividad], [IdSubTipoActividadDetalle], [Etiqueta], [IdTipoControl], [CodigoGeneral], [Modificable], [Obligatorio], [MaxCaracter], [FlgHabilitado], [FlgPadre], [IdSubTipoActividadDetPadre]) VALUES (1, 1, N'Comentarios', N'2', N'', N'F', N'T', N'50', N'T', N' ', NULL)
INSERT [dbo].[GRSubTipoActividad_Detalle] ([IDSubTipoActividad], [IdSubTipoActividadDetalle], [Etiqueta], [IdTipoControl], [CodigoGeneral], [Modificable], [Obligatorio], [MaxCaracter], [FlgHabilitado], [FlgPadre], [IdSubTipoActividadDetPadre]) VALUES (1, 2, N'Cantidad', N'5', N'', N'F', N'T', N'5', N'T', N' ', NULL)
INSERT [dbo].[GRSubTipoActividad_Detalle] ([IDSubTipoActividad], [IdSubTipoActividadDetalle], [Etiqueta], [IdTipoControl], [CodigoGeneral], [Modificable], [Obligatorio], [MaxCaracter], [FlgHabilitado], [FlgPadre], [IdSubTipoActividadDetPadre]) VALUES (1, 22, N'Pais', N'4', N'2', N'F', N'T', N'', N'T', N' ', NULL)
INSERT [dbo].[GRSubTipoActividad_Detalle] ([IDSubTipoActividad], [IdSubTipoActividadDetalle], [Etiqueta], [IdTipoControl], [CodigoGeneral], [Modificable], [Obligatorio], [MaxCaracter], [FlgHabilitado], [FlgPadre], [IdSubTipoActividadDetPadre]) VALUES (1, 23, N'nuevo', N'4', N'3', N'F', N'T', N'', N'T', N' ', 22)
INSERT [dbo].[GRSubTipoActividad_Detalle] ([IDSubTipoActividad], [IdSubTipoActividadDetalle], [Etiqueta], [IdTipoControl], [CodigoGeneral], [Modificable], [Obligatorio], [MaxCaracter], [FlgHabilitado], [FlgPadre], [IdSubTipoActividadDetPadre]) VALUES (2, 3, N'Comentarios', N'2', N'', N'F', N'T', N'50', N'T', N' ', NULL)
INSERT [dbo].[GRSubTipoActividad_Detalle] ([IDSubTipoActividad], [IdSubTipoActividadDetalle], [Etiqueta], [IdTipoControl], [CodigoGeneral], [Modificable], [Obligatorio], [MaxCaracter], [FlgHabilitado], [FlgPadre], [IdSubTipoActividadDetPadre]) VALUES (2, 4, N'Detalles', N'2', N'', N'F', N'T', N'50', N'T', N' ', NULL)
INSERT [dbo].[GRSubTipoActividad_Detalle] ([IDSubTipoActividad], [IdSubTipoActividadDetalle], [Etiqueta], [IdTipoControl], [CodigoGeneral], [Modificable], [Obligatorio], [MaxCaracter], [FlgHabilitado], [FlgPadre], [IdSubTipoActividadDetPadre]) VALUES (2, 15, N'foto', N'10', N'', N'F', N'T', N'', N'T', N' ', NULL)
INSERT [dbo].[GRSubTipoActividad_Detalle] ([IDSubTipoActividad], [IdSubTipoActividadDetalle], [Etiqueta], [IdTipoControl], [CodigoGeneral], [Modificable], [Obligatorio], [MaxCaracter], [FlgHabilitado], [FlgPadre], [IdSubTipoActividadDetPadre]) VALUES (2, 19, N'pais', N'4', N'2', N'F', N'T', N'', N'T', N' ', NULL)
INSERT [dbo].[GRSubTipoActividad_Detalle] ([IDSubTipoActividad], [IdSubTipoActividadDetalle], [Etiqueta], [IdTipoControl], [CodigoGeneral], [Modificable], [Obligatorio], [MaxCaracter], [FlgHabilitado], [FlgPadre], [IdSubTipoActividadDetPadre]) VALUES (2, 20, N'caputal', N'4', N'3', N'F', N'T', N'', N'T', N' ', 19)
INSERT [dbo].[GRSubTipoActividad_Detalle] ([IDSubTipoActividad], [IdSubTipoActividadDetalle], [Etiqueta], [IdTipoControl], [CodigoGeneral], [Modificable], [Obligatorio], [MaxCaracter], [FlgHabilitado], [FlgPadre], [IdSubTipoActividadDetPadre]) VALUES (2, 21, N'provincia', N'4', N'4', N'F', N'T', N'', N'T', N' ', 20)
INSERT [dbo].[GRSubTipoActividad_Detalle] ([IDSubTipoActividad], [IdSubTipoActividadDetalle], [Etiqueta], [IdTipoControl], [CodigoGeneral], [Modificable], [Obligatorio], [MaxCaracter], [FlgHabilitado], [FlgPadre], [IdSubTipoActividadDetPadre]) VALUES (3, 5, N'Cometario', N'2', N'', N'F', N'T', N'100', N'T', N' ', NULL)
INSERT [dbo].[GRSubTipoActividad_Detalle] ([IDSubTipoActividad], [IdSubTipoActividadDetalle], [Etiqueta], [IdTipoControl], [CodigoGeneral], [Modificable], [Obligatorio], [MaxCaracter], [FlgHabilitado], [FlgPadre], [IdSubTipoActividadDetPadre]) VALUES (3, 16, N'pais', N'4', N'2', N'F', N'T', N'', N'T', N' ', NULL)
INSERT [dbo].[GRSubTipoActividad_Detalle] ([IDSubTipoActividad], [IdSubTipoActividadDetalle], [Etiqueta], [IdTipoControl], [CodigoGeneral], [Modificable], [Obligatorio], [MaxCaracter], [FlgHabilitado], [FlgPadre], [IdSubTipoActividadDetPadre]) VALUES (3, 17, N'capital', N'4', N'3', N'F', N'T', N'', N'T', N' ', 16)
INSERT [dbo].[GRSubTipoActividad_Detalle] ([IDSubTipoActividad], [IdSubTipoActividadDetalle], [Etiqueta], [IdTipoControl], [CodigoGeneral], [Modificable], [Obligatorio], [MaxCaracter], [FlgHabilitado], [FlgPadre], [IdSubTipoActividadDetPadre]) VALUES (3, 18, N'provincia', N'4', N'4', N'F', N'T', N'', N'T', N' ', 17)
INSERT [dbo].[GRSubTipoActividad_Detalle] ([IDSubTipoActividad], [IdSubTipoActividadDetalle], [Etiqueta], [IdTipoControl], [CodigoGeneral], [Modificable], [Obligatorio], [MaxCaracter], [FlgHabilitado], [FlgPadre], [IdSubTipoActividadDetPadre]) VALUES (4, 6, N'Comentario', N'2', N'', N'F', N'T', N'20', N'T', N' ', NULL)
INSERT [dbo].[GRSubTipoActividad_Detalle] ([IDSubTipoActividad], [IdSubTipoActividadDetalle], [Etiqueta], [IdTipoControl], [CodigoGeneral], [Modificable], [Obligatorio], [MaxCaracter], [FlgHabilitado], [FlgPadre], [IdSubTipoActividadDetPadre]) VALUES (5, 7, N'Comentarios', N'2', N'', N'F', N'T', N'30', N'T', N' ', NULL)
INSERT [dbo].[GRSubTipoActividad_Detalle] ([IDSubTipoActividad], [IdSubTipoActividadDetalle], [Etiqueta], [IdTipoControl], [CodigoGeneral], [Modificable], [Obligatorio], [MaxCaracter], [FlgHabilitado], [FlgPadre], [IdSubTipoActividadDetPadre]) VALUES (6, 8, N'Comentarios', N'2', N'', N'F', N'T', N'30', N'T', N' ', NULL)
INSERT [dbo].[GRSubTipoActividad_Detalle] ([IDSubTipoActividad], [IdSubTipoActividadDetalle], [Etiqueta], [IdTipoControl], [CodigoGeneral], [Modificable], [Obligatorio], [MaxCaracter], [FlgHabilitado], [FlgPadre], [IdSubTipoActividadDetPadre]) VALUES (7, 9, N'TELEFONO', N'5', N'', N'F', N'T', N'9', N'T', N' ', NULL)
INSERT [dbo].[GRSubTipoActividad_Detalle] ([IDSubTipoActividad], [IdSubTipoActividadDetalle], [Etiqueta], [IdTipoControl], [CodigoGeneral], [Modificable], [Obligatorio], [MaxCaracter], [FlgHabilitado], [FlgPadre], [IdSubTipoActividadDetPadre]) VALUES (7, 10, N'numero', N'5', N'', N'F', N'T', N'5', N'T', N' ', NULL)
INSERT [dbo].[GRSubTipoActividad_Detalle] ([IDSubTipoActividad], [IdSubTipoActividadDetalle], [Etiqueta], [IdTipoControl], [CodigoGeneral], [Modificable], [Obligatorio], [MaxCaracter], [FlgHabilitado], [FlgPadre], [IdSubTipoActividadDetPadre]) VALUES (8, 11, N'telefono ', N'2', N'', N'F', N'T', N'1', N'T', N' ', NULL)
INSERT [dbo].[GRSubTipoActividad_Detalle] ([IDSubTipoActividad], [IdSubTipoActividadDetalle], [Etiqueta], [IdTipoControl], [CodigoGeneral], [Modificable], [Obligatorio], [MaxCaracter], [FlgHabilitado], [FlgPadre], [IdSubTipoActividadDetPadre]) VALUES (9, 12, N'etiqueta', N'2', N'', N'F', N'T', N'10', N'T', N' ', NULL)
INSERT [dbo].[GRSubTipoActividad_Detalle] ([IDSubTipoActividad], [IdSubTipoActividadDetalle], [Etiqueta], [IdTipoControl], [CodigoGeneral], [Modificable], [Obligatorio], [MaxCaracter], [FlgHabilitado], [FlgPadre], [IdSubTipoActividadDetPadre]) VALUES (10, 13, N'123213', N'2', N'', N'F', N'T', N'12', N'T', N' ', NULL)
INSERT [dbo].[GRSubTipoActividad_Detalle] ([IDSubTipoActividad], [IdSubTipoActividadDetalle], [Etiqueta], [IdTipoControl], [CodigoGeneral], [Modificable], [Obligatorio], [MaxCaracter], [FlgHabilitado], [FlgPadre], [IdSubTipoActividadDetPadre]) VALUES (11, 14, N'texto2312313123', N'2', N'', N'F', N'T', N'20', N'T', N' ', NULL)
SET IDENTITY_INSERT [dbo].[GRSubTipoActividad_Detalle] OFF
SET IDENTITY_INSERT [dbo].[GRTipoActividad] ON 

INSERT [dbo].[GRTipoActividad] ([id], [codigo], [nombre], [FlagTA], [IdCanal], [meta]) VALUES (1, N'1', N'Tipo B2B', N'T', 1, N'10')
INSERT [dbo].[GRTipoActividad] ([id], [codigo], [nombre], [FlagTA], [IdCanal], [meta]) VALUES (2, N'2', N'TIPO B2C', N'T', 2, N'15')
INSERT [dbo].[GRTipoActividad] ([id], [codigo], [nombre], [FlagTA], [IdCanal], [meta]) VALUES (3, N'3', N'ACTIVIDAD 3', N'T', 1, N'15')
INSERT [dbo].[GRTipoActividad] ([id], [codigo], [nombre], [FlagTA], [IdCanal], [meta]) VALUES (4, N'4', N'CAPACITACION', N'T', 1, N'12')
INSERT [dbo].[GRTipoActividad] ([id], [codigo], [nombre], [FlagTA], [IdCanal], [meta]) VALUES (5, N'5', N'MANTENIMIENTO', N'T', 1, N'15')
INSERT [dbo].[GRTipoActividad] ([id], [codigo], [nombre], [FlagTA], [IdCanal], [meta]) VALUES (7, N'', N'TEST', N'T', 1, N'100')
INSERT [dbo].[GRTipoActividad] ([id], [codigo], [nombre], [FlagTA], [IdCanal], [meta]) VALUES (8, N'', N'TEST 2', N'T', 1, N'12')
INSERT [dbo].[GRTipoActividad] ([id], [codigo], [nombre], [FlagTA], [IdCanal], [meta]) VALUES (9, N'9', N'TEST 3', N'T', 1, N'50')
INSERT [dbo].[GRTipoActividad] ([id], [codigo], [nombre], [FlagTA], [IdCanal], [meta]) VALUES (10, N'10', N'test 100006', N'T', 2, N'100')
SET IDENTITY_INSERT [dbo].[GRTipoActividad] OFF
SET IDENTITY_INSERT [dbo].[GRUsuario] ON 

INSERT [dbo].[GRUsuario] ([IdUsuario], [Codigo], [Nombres], [Apellidos], [LoginUsuario], [Clave], [Email], [FlgHabilitado], [IdCanal], [IdZona], [IdPerfil], [FlagAutenticacionAD]) VALUES (1, N'1', N'Administrador', N'', N'admin', N'DD84F0EE24CFD17BA4AC744AFAD8DE1687C2A400', N'admin@solgas.com.pe', N'T', 1, 1, 2, N'F')
INSERT [dbo].[GRUsuario] ([IdUsuario], [Codigo], [Nombres], [Apellidos], [LoginUsuario], [Clave], [Email], [FlgHabilitado], [IdCanal], [IdZona], [IdPerfil], [FlagAutenticacionAD]) VALUES (2, N'ub2b', N'b2b', N'', N'b2b', N'356A192B7913B04C54574D18C28D46E6395428AB', N'b2b@solgas.pe', N'T', 1, 1, 4, N'F')
INSERT [dbo].[GRUsuario] ([IdUsuario], [Codigo], [Nombres], [Apellidos], [LoginUsuario], [Clave], [Email], [FlgHabilitado], [IdCanal], [IdZona], [IdPerfil], [FlagAutenticacionAD]) VALUES (3, N'ub2c', N'Usuario B2C', N'', N'b2c', N'356A192B7913B04C54574D18C28D46E6395428AB', N'b2c@solgas.pe', N'T', 2, 2, 4, N'F')
INSERT [dbo].[GRUsuario] ([IdUsuario], [Codigo], [Nombres], [Apellidos], [LoginUsuario], [Clave], [Email], [FlgHabilitado], [IdCanal], [IdZona], [IdPerfil], [FlagAutenticacionAD]) VALUES (4, N'USU1', N'USUARIO', N'', N'USU123', N'F7C3BC1D808E04732ADF679965CCC34CA7AE3441', N'CORREO@CORREO.PE', N'T', 1, 3, 2, N'F')
INSERT [dbo].[GRUsuario] ([IdUsuario], [Codigo], [Nombres], [Apellidos], [LoginUsuario], [Clave], [Email], [FlgHabilitado], [IdCanal], [IdZona], [IdPerfil], [FlagAutenticacionAD]) VALUES (5, N'USU2', N'USUARIO2', N'', N'USU12345', N'BFE54CAA6D483CC3887DCE9D1B8EB91408F1EA7A', N'CORREO2@CORREO.PE', N'T', 2, 4, 4, N'F')
INSERT [dbo].[GRUsuario] ([IdUsuario], [Codigo], [Nombres], [Apellidos], [LoginUsuario], [Clave], [Email], [FlgHabilitado], [IdCanal], [IdZona], [IdPerfil], [FlagAutenticacionAD]) VALUES (6, N'JCOLLANTES', N'Judith Roxana Collantes Coba', N'', N'AdmiB2B', N'DD84F0EE24CFD17BA4AC744AFAD8DE1687C2A400', N'judith.collantes@solgas.com', N'T', 1, 3, 2, N'F')
INSERT [dbo].[GRUsuario] ([IdUsuario], [Codigo], [Nombres], [Apellidos], [LoginUsuario], [Clave], [Email], [FlgHabilitado], [IdCanal], [IdZona], [IdPerfil], [FlagAutenticacionAD]) VALUES (7, N'svidal', N'Santiago Vida', N'', N'1', N'356A192B7913B04C54574D18C28D46E6395428AB', N'usuario_prueba@solgas.com.pe', N'T', 1, 2, 2, N'F')
INSERT [dbo].[GRUsuario] ([IdUsuario], [Codigo], [Nombres], [Apellidos], [LoginUsuario], [Clave], [Email], [FlgHabilitado], [IdCanal], [IdZona], [IdPerfil], [FlagAutenticacionAD]) VALUES (8, N'1231312', N'3123123', N'', N'1231231231', N'9498BA1BFA2F0188CE3A4227235090402201A486', N'asadas@gnauk.com', N'T', 1, 1, 2, N'F')
INSERT [dbo].[GRUsuario] ([IdUsuario], [Codigo], [Nombres], [Apellidos], [LoginUsuario], [Clave], [Email], [FlgHabilitado], [IdCanal], [IdZona], [IdPerfil], [FlagAutenticacionAD]) VALUES (10, N'10', N'JOSE ANTONIO CAMPANA', N'', N'JCAMPANA', N'356A192B7913B04C54574D18C28D46E6395428AB', N'jose.campana@entel.pe', N'T', 1, 2, 4, N'T')
INSERT [dbo].[GRUsuario] ([IdUsuario], [Codigo], [Nombres], [Apellidos], [LoginUsuario], [Clave], [Email], [FlgHabilitado], [IdCanal], [IdZona], [IdPerfil], [FlagAutenticacionAD]) VALUES (11, N'11', N'MARCO ANTONIO LOPEZ', N'', N'MMUNOZ', N'356A192B7913B04C54574D18C28D46E6395428AB', N'MARCOMUNIOZ6@ENTEL.PE', N'T', 1, 1, 4, N'F')
INSERT [dbo].[GRUsuario] ([IdUsuario], [Codigo], [Nombres], [Apellidos], [LoginUsuario], [Clave], [Email], [FlgHabilitado], [IdCanal], [IdZona], [IdPerfil], [FlagAutenticacionAD]) VALUES (12, N'12', N'Pablo Barrientos', N'', N'pbarriento', N'7C4A8D09CA3762AF61E59520943DC26494F8941B', N'pbarrientos@entel.pe', N'T', 2, 5, 4, N'T')
SET IDENTITY_INSERT [dbo].[GRUsuario] OFF
SET IDENTITY_INSERT [dbo].[GRZona] ON 

INSERT [dbo].[GRZona] ([IdZona], [Codigo], [Nombre], [Flag]) VALUES (1, N'1', N'Lima', N'T')
INSERT [dbo].[GRZona] ([IdZona], [Codigo], [Nombre], [Flag]) VALUES (2, N'2', N'Arequipa', N'T')
INSERT [dbo].[GRZona] ([IdZona], [Codigo], [Nombre], [Flag]) VALUES (3, N'ZON01', N'ZONA 1', N'T')
INSERT [dbo].[GRZona] ([IdZona], [Codigo], [Nombre], [Flag]) VALUES (4, N'ZON02', N'ZONA 2', N'T')
INSERT [dbo].[GRZona] ([IdZona], [Codigo], [Nombre], [Flag]) VALUES (5, N'5', N'Zona 50000', N'T')
INSERT [dbo].[GRZona] ([IdZona], [Codigo], [Nombre], [Flag]) VALUES (6, N'1324567809', N'Lima Oeste', N'T')
SET IDENTITY_INSERT [dbo].[GRZona] OFF
SET IDENTITY_INSERT [dbo].[TRActividadDetalleControl] ON 

INSERT [dbo].[TRActividadDetalleControl] ([IdActividadDetalleControl], [IdActividad], [IdConfiguracionActividadDetalle], [ValorControl], [IdGeneral]) VALUES (1, 1, 1, N'comentario 1', N'')
INSERT [dbo].[TRActividadDetalleControl] ([IdActividadDetalleControl], [IdActividad], [IdConfiguracionActividadDetalle], [ValorControl], [IdGeneral]) VALUES (2, 1, 2, N'50', N'')
INSERT [dbo].[TRActividadDetalleControl] ([IdActividadDetalleControl], [IdActividad], [IdConfiguracionActividadDetalle], [ValorControl], [IdGeneral]) VALUES (3, 2, 1, N'comentario 1', N'')
INSERT [dbo].[TRActividadDetalleControl] ([IdActividadDetalleControl], [IdActividad], [IdConfiguracionActividadDetalle], [ValorControl], [IdGeneral]) VALUES (4, 2, 2, N'50', N'')
INSERT [dbo].[TRActividadDetalleControl] ([IdActividadDetalleControl], [IdActividad], [IdConfiguracionActividadDetalle], [ValorControl], [IdGeneral]) VALUES (5, 3, 3, N'comentario 0120', N'')
INSERT [dbo].[TRActividadDetalleControl] ([IdActividadDetalleControl], [IdActividad], [IdConfiguracionActividadDetalle], [ValorControl], [IdGeneral]) VALUES (6, 3, 4, N'detalle 0120', N'')
INSERT [dbo].[TRActividadDetalleControl] ([IdActividadDetalleControl], [IdActividad], [IdConfiguracionActividadDetalle], [ValorControl], [IdGeneral]) VALUES (7, 4, 1, N'coment 0121', N'')
INSERT [dbo].[TRActividadDetalleControl] ([IdActividadDetalleControl], [IdActividad], [IdConfiguracionActividadDetalle], [ValorControl], [IdGeneral]) VALUES (8, 4, 2, N'0121', N'')
INSERT [dbo].[TRActividadDetalleControl] ([IdActividadDetalleControl], [IdActividad], [IdConfiguracionActividadDetalle], [ValorControl], [IdGeneral]) VALUES (9, 5, 1, N'comentario 1', N'')
INSERT [dbo].[TRActividadDetalleControl] ([IdActividadDetalleControl], [IdActividad], [IdConfiguracionActividadDetalle], [ValorControl], [IdGeneral]) VALUES (10, 5, 2, N'50', N'')
INSERT [dbo].[TRActividadDetalleControl] ([IdActividadDetalleControl], [IdActividad], [IdConfiguracionActividadDetalle], [ValorControl], [IdGeneral]) VALUES (11, 6, 1, N'comentario 0328', N'')
INSERT [dbo].[TRActividadDetalleControl] ([IdActividadDetalleControl], [IdActividad], [IdConfiguracionActividadDetalle], [ValorControl], [IdGeneral]) VALUES (12, 6, 2, N'3258', N'')
INSERT [dbo].[TRActividadDetalleControl] ([IdActividadDetalleControl], [IdActividad], [IdConfiguracionActividadDetalle], [ValorControl], [IdGeneral]) VALUES (13, 7, 1, N'Prueba', N'')
INSERT [dbo].[TRActividadDetalleControl] ([IdActividadDetalleControl], [IdActividad], [IdConfiguracionActividadDetalle], [ValorControl], [IdGeneral]) VALUES (14, 7, 2, N'1', N'')
INSERT [dbo].[TRActividadDetalleControl] ([IdActividadDetalleControl], [IdActividad], [IdConfiguracionActividadDetalle], [ValorControl], [IdGeneral]) VALUES (15, 8, 5, N'Prueba', N'')
INSERT [dbo].[TRActividadDetalleControl] ([IdActividadDetalleControl], [IdActividad], [IdConfiguracionActividadDetalle], [ValorControl], [IdGeneral]) VALUES (16, 9, 5, N'Prueba tres', N'')
INSERT [dbo].[TRActividadDetalleControl] ([IdActividadDetalleControl], [IdActividad], [IdConfiguracionActividadDetalle], [ValorControl], [IdGeneral]) VALUES (17, 10, 1, N'Prueba 5', N'')
INSERT [dbo].[TRActividadDetalleControl] ([IdActividadDetalleControl], [IdActividad], [IdConfiguracionActividadDetalle], [ValorControl], [IdGeneral]) VALUES (18, 10, 2, N'5', N'')
INSERT [dbo].[TRActividadDetalleControl] ([IdActividadDetalleControl], [IdActividad], [IdConfiguracionActividadDetalle], [ValorControl], [IdGeneral]) VALUES (19, 11, 1, N'Prueba', N'')
INSERT [dbo].[TRActividadDetalleControl] ([IdActividadDetalleControl], [IdActividad], [IdConfiguracionActividadDetalle], [ValorControl], [IdGeneral]) VALUES (20, 11, 2, N'3', N'')
INSERT [dbo].[TRActividadDetalleControl] ([IdActividadDetalleControl], [IdActividad], [IdConfiguracionActividadDetalle], [ValorControl], [IdGeneral]) VALUES (21, 12, 3, N'Prueba uno', N'')
INSERT [dbo].[TRActividadDetalleControl] ([IdActividadDetalleControl], [IdActividad], [IdConfiguracionActividadDetalle], [ValorControl], [IdGeneral]) VALUES (22, 12, 4, N'Pruebas y mas oruebas', N'')
INSERT [dbo].[TRActividadDetalleControl] ([IdActividadDetalleControl], [IdActividad], [IdConfiguracionActividadDetalle], [ValorControl], [IdGeneral]) VALUES (23, 13, 3, N'Prueba dos', N'')
INSERT [dbo].[TRActividadDetalleControl] ([IdActividadDetalleControl], [IdActividad], [IdConfiguracionActividadDetalle], [ValorControl], [IdGeneral]) VALUES (24, 13, 4, N'Pruebas y mas oruebas', N'')
INSERT [dbo].[TRActividadDetalleControl] ([IdActividadDetalleControl], [IdActividad], [IdConfiguracionActividadDetalle], [ValorControl], [IdGeneral]) VALUES (25, 14, 6, N'Prueba', N'')
INSERT [dbo].[TRActividadDetalleControl] ([IdActividadDetalleControl], [IdActividad], [IdConfiguracionActividadDetalle], [ValorControl], [IdGeneral]) VALUES (26, 15, 7, N'Prueba', N'')
INSERT [dbo].[TRActividadDetalleControl] ([IdActividadDetalleControl], [IdActividad], [IdConfiguracionActividadDetalle], [ValorControl], [IdGeneral]) VALUES (27, 16, 3, N'1', N'')
INSERT [dbo].[TRActividadDetalleControl] ([IdActividadDetalleControl], [IdActividad], [IdConfiguracionActividadDetalle], [ValorControl], [IdGeneral]) VALUES (28, 16, 4, N'1', N'')
INSERT [dbo].[TRActividadDetalleControl] ([IdActividadDetalleControl], [IdActividad], [IdConfiguracionActividadDetalle], [ValorControl], [IdGeneral]) VALUES (29, 17, 3, N'1', N'')
INSERT [dbo].[TRActividadDetalleControl] ([IdActividadDetalleControl], [IdActividad], [IdConfiguracionActividadDetalle], [ValorControl], [IdGeneral]) VALUES (30, 17, 4, N'1', N'')
INSERT [dbo].[TRActividadDetalleControl] ([IdActividadDetalleControl], [IdActividad], [IdConfiguracionActividadDetalle], [ValorControl], [IdGeneral]) VALUES (31, 18, 1, N'1', N'')
INSERT [dbo].[TRActividadDetalleControl] ([IdActividadDetalleControl], [IdActividad], [IdConfiguracionActividadDetalle], [ValorControl], [IdGeneral]) VALUES (32, 18, 2, N'1', N'')
INSERT [dbo].[TRActividadDetalleControl] ([IdActividadDetalleControl], [IdActividad], [IdConfiguracionActividadDetalle], [ValorControl], [IdGeneral]) VALUES (33, 19, 3, N'comentario 1', N'')
INSERT [dbo].[TRActividadDetalleControl] ([IdActividadDetalleControl], [IdActividad], [IdConfiguracionActividadDetalle], [ValorControl], [IdGeneral]) VALUES (34, 19, 4, N'detalles 1', N'')
INSERT [dbo].[TRActividadDetalleControl] ([IdActividadDetalleControl], [IdActividad], [IdConfiguracionActividadDetalle], [ValorControl], [IdGeneral]) VALUES (35, 24, 3, N'coment 1', N'')
INSERT [dbo].[TRActividadDetalleControl] ([IdActividadDetalleControl], [IdActividad], [IdConfiguracionActividadDetalle], [ValorControl], [IdGeneral]) VALUES (36, 24, 4, N'detalle 1', N'')
INSERT [dbo].[TRActividadDetalleControl] ([IdActividadDetalleControl], [IdActividad], [IdConfiguracionActividadDetalle], [ValorControl], [IdGeneral]) VALUES (37, 25, 1, N'Comnetsrio', N'')
INSERT [dbo].[TRActividadDetalleControl] ([IdActividadDetalleControl], [IdActividad], [IdConfiguracionActividadDetalle], [ValorControl], [IdGeneral]) VALUES (38, 25, 2, N'10', N'')
INSERT [dbo].[TRActividadDetalleControl] ([IdActividadDetalleControl], [IdActividad], [IdConfiguracionActividadDetalle], [ValorControl], [IdGeneral]) VALUES (39, 26, 14, N'asdasdad', N'')
INSERT [dbo].[TRActividadDetalleControl] ([IdActividadDetalleControl], [IdActividad], [IdConfiguracionActividadDetalle], [ValorControl], [IdGeneral]) VALUES (40, 27, 3, N'hjkhhj', N'')
INSERT [dbo].[TRActividadDetalleControl] ([IdActividadDetalleControl], [IdActividad], [IdConfiguracionActividadDetalle], [ValorControl], [IdGeneral]) VALUES (41, 27, 4, N'hjasd', N'')
INSERT [dbo].[TRActividadDetalleControl] ([IdActividadDetalleControl], [IdActividad], [IdConfiguracionActividadDetalle], [ValorControl], [IdGeneral]) VALUES (42, 27, 15, N'02_14_2019_11_13_25_15_3', N'')
INSERT [dbo].[TRActividadDetalleControl] ([IdActividadDetalleControl], [IdActividad], [IdConfiguracionActividadDetalle], [ValorControl], [IdGeneral]) VALUES (43, 28, 1, N'wqdasd', N'')
INSERT [dbo].[TRActividadDetalleControl] ([IdActividadDetalleControl], [IdActividad], [IdConfiguracionActividadDetalle], [ValorControl], [IdGeneral]) VALUES (44, 28, 2, N'10', N'')
INSERT [dbo].[TRActividadDetalleControl] ([IdActividadDetalleControl], [IdActividad], [IdConfiguracionActividadDetalle], [ValorControl], [IdGeneral]) VALUES (45, 32, 1, N'dd', N'')
INSERT [dbo].[TRActividadDetalleControl] ([IdActividadDetalleControl], [IdActividad], [IdConfiguracionActividadDetalle], [ValorControl], [IdGeneral]) VALUES (46, 32, 2, N'2', N'')
INSERT [dbo].[TRActividadDetalleControl] ([IdActividadDetalleControl], [IdActividad], [IdConfiguracionActividadDetalle], [ValorControl], [IdGeneral]) VALUES (47, 32, 22, N've01', N'2')
INSERT [dbo].[TRActividadDetalleControl] ([IdActividadDetalleControl], [IdActividad], [IdConfiguracionActividadDetalle], [ValorControl], [IdGeneral]) VALUES (48, 32, 23, N'car01', N'3')
INSERT [dbo].[TRActividadDetalleControl] ([IdActividadDetalleControl], [IdActividad], [IdConfiguracionActividadDetalle], [ValorControl], [IdGeneral]) VALUES (49, 33, 3, N'sd', N'')
INSERT [dbo].[TRActividadDetalleControl] ([IdActividadDetalleControl], [IdActividad], [IdConfiguracionActividadDetalle], [ValorControl], [IdGeneral]) VALUES (50, 33, 4, N'sd', N'')
INSERT [dbo].[TRActividadDetalleControl] ([IdActividadDetalleControl], [IdActividad], [IdConfiguracionActividadDetalle], [ValorControl], [IdGeneral]) VALUES (51, 33, 15, N'03_03_2019_14_22_46_15_3', N'')
INSERT [dbo].[TRActividadDetalleControl] ([IdActividadDetalleControl], [IdActividad], [IdConfiguracionActividadDetalle], [ValorControl], [IdGeneral]) VALUES (52, 33, 19, N'per01', N'2')
INSERT [dbo].[TRActividadDetalleControl] ([IdActividadDetalleControl], [IdActividad], [IdConfiguracionActividadDetalle], [ValorControl], [IdGeneral]) VALUES (53, 33, 20, N'lim01', N'3')
INSERT [dbo].[TRActividadDetalleControl] ([IdActividadDetalleControl], [IdActividad], [IdConfiguracionActividadDetalle], [ValorControl], [IdGeneral]) VALUES (54, 33, 21, N'001', N'4')
SET IDENTITY_INSERT [dbo].[TRActividadDetalleControl] OFF
SET IDENTITY_INSERT [dbo].[TRFoto] ON 

INSERT [dbo].[TRFoto] ([IdActividad], [IdFoto], [Fecha], [Foto], [NombreFoto], [FlgHabilitado]) VALUES (27, 1, CAST(N'2019-02-14 11:18:48.317' AS DateTime), 0xFFD8FFE000104A46494600010101006000600000FFDB0043000302020302020303030304030304050805050404050A070706080C0A0C0C0B0A0B0B0D0E12100D0E110E0B0B1016101113141515150C0F171816141812141514FFDB00430103040405040509050509140D0B0D1414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414FFC000110802F9055503012200021101031101FFC4001F0000010501010101010100000000000000000102030405060708090A0BFFC400B5100002010303020403050504040000017D01020300041105122131410613516107227114328191A1082342B1C11552D1F02433627282090A161718191A25262728292A3435363738393A434445464748494A535455565758595A636465666768696A737475767778797A838485868788898A92939495969798999AA2A3A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6D7D8D9DAE1E2E3E4E5E6E7E8E9EAF1F2F3F4F5F6F7F8F9FAFFC4001F0100030101010101010101010000000000000102030405060708090A0BFFC400B51100020102040403040705040400010277000102031104052131061241510761711322328108144291A1B1C109233352F0156272D10A162434E125F11718191A262728292A35363738393A434445464748494A535455565758595A636465666768696A737475767778797A82838485868788898A92939495969798999AA2A3A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6D7D8D9DAE2E3E4E5E6E7E8E9EAF2F3F4F5F6F7F8F9FAFFDA000C03010002110311003F00FCFCA28A2800E73D335EB7FB36FC0FB7F8F1F12D3C2D3EACFA606B6370B2471872F86504649E30AC5B383F771DF23C92BDB3F637D7750D0BE3F68034A992DF50BC8AE2D2DDE4194F31A1628187A16551F8D5463CD251BDAE44E5CB172B5EC7DDDA87FC137FE10DB7872CAD251AA9BD89023EA105FF00972CCF9C967DC1A351D40010718E73C9F857F698FD9BD3E01EA56DE478821D5ED6F26916183611344A391B88CAB718E41079E82BF49FC1D0EBDA45AEADA46AD6DAB08E286D27F3754984A91CCEB99628A4DCC5D7773D70391F5F857FE0A0FAF35DFC42D0B4ADBB05AD934E471CEF7DA39FFB667F3AEBC561D61EA3829296DAAF3D4E3C2621E269AA8E2E3BE8FC9D8F95638CCB22A2F526924431C855BAA9A4A4EB927935C477E960A93CF93CBF2F71D99C91EB51D140CD1834696F15A541B539C66A431CBA4E9E920F92791C1561E957BC352493C2C8EFFBB8BDBEB54668EE35EBE90C400893A7F740F5ADA4BB1D5CAB9538F525F0DDEC71DE4A266D8F2F209E067D2BAADB5E7B29662370CED041C0F7AE8FC2B7D34C64B773BD1406563DBDAB5A72D6C6F86AB7F71A37A9D814EFE1A4DA6BA0F4920A51DA9768C51DF340C1A81463773453B00B49DE9DD0FB51EFDA8B0AE07BD18EB4B463F0A2C50DA5DA2968A4509B4D18A5A2AAC4D83F868A5F6F7A41F374A2C572853A9B4BCD01CA20FA52AD2FE14503B09DFD297B51E83B514C2C14ABD68FE2A55C7E34C2C1DFDA939E294F1C50B93DA98EC1CD2E7DA8A01A005FA5273DF8A5A33C6314D0AC147AD2FF000D2530B0EC5263DE9DB4D283DAA82C47DCE452E3E6E94EFE2E9C62958FB5318DC50547E94EDBD2976B3741D2818DE3D680B9A76DF6A5DB8CF7340EC3474A732EEA50BDB1CD2AE7F0A0AE51847B5285FC29DCD1CD55C56130475A4EBED521CB0A6EDCE01068B85846FBA0D26DEB8E69E578A3145C56635579F7A730A5C7A734A39EB52511E00E7BD3BF0A5C77EF4555C03B6699D2A4DBC63B50C36FB9A41623C52723B53D5734F551DF8A770B1160F14EC1A7607AD1B77671C5171F28D028514E65E9415E295C761856976EEC53BD29699361BC7AE291578A7EDC8A2994331CF4E29DB7752FE14EDA3D281588F681EF4629F8C7B526DA02C1B693DBAD3FA7BD342F53EB40C36D1B4629C776DCD2AB75A0643B486E053DA9DB6865F7A0437F879E290AD29538A7734011EDCD1B69FB7F2A39E680B0CD949B4FA54949B7A9A0061072475A4C74A91B3D69BE9EB4009B7B1A4DB8CD49DA8C7A52B811E3A0A663DEA5EDD682B45C5619B71C9E691C6718A957DE90AFA74A90B1118CFAD1FCEA5DA31D79A6EDF9A80B0D61D69BB772E2A42BEBC534460E79A09B0C0B8F7A5E38C0A7639A56522AAE16198E7F9D27BD3F6F3F5A1942D3158663AD1F85285F9A9369C7BD01619F8734EC529C52ECFCA95C2C47C7AD2549EBC5302F4A621083D68A7375271484714086F34734BB76F2D454809FA537BD2F3CE4518EA6900D2B96F6A38F5A72A9C72692A18AC369BB4D3CF1D052122A42C35BB8A6F5A71CF5EB48D52161B452EDF9734948560A28A4E7A502B0DA3F9D3D79A41EB4B40B09D3EB494A7834367B51A0AC34AFBD0A38A51C51468160A46EB4A7BD21F7E29D84263AD25394526DA2C02514BB79C53BF9D02633AD1B4518C5141160ED4DA77B526D3413CAC4A434FDA29B4084A302968A02C373E9494EFC29B525052352D152C91945145210C619A6F39C629FEF477CE79A09714331DA8C5041C514190CAFB93C0FFF0004F9F0EF8A3E1EF853C4B73E27D5213AD6976B7CF1C51C588DE5856428323A02C71F4AF874AFA57EC5FC279B6FECFBF0C467FE603A6FFE922D7C6F12E32BE0B0F19D09F2BB9DB86829CED247E6A7ED49F0434EF805E3DD3741D3352BAD520BAD2E3BF696ED5432B34B2A151B463188C1FC4D78E357D93FF0522F09C90F8A3C1FE28FB42B457760FA6FD9F6FCCA6191A4DD9EE0F9F8C76DBEF5F1BD7AB9362658BC052AD395E4D6AFCEF632AD150A8E2911E3A52114FE9EF499F6AF68E6B09B69BB7B76A7F4A4CD224695F4A28DD454580E568AE9FE16F866D3C6FF0014BC19E1AD4249E1B0D6B5AB3D36E24B565595639A748D8A160406018E3208CF635D778D3E1CF87B50D17C2DAC782D2FF448B57D6752D09AC7C5FACD985692D044C6E23BB68EDA211309829DE06D74237364639DE893EFFF0003F568F316ADAEDFF05FE517F71E555A7E1BF126A5E10D7AC75AD1EEDEC754B1944D6F711805A371D08CF15DA5AFECF3E3DBCBED62D9349B345D2059B5EDECDAD584565125DC6D25AC82E9E710B472AA9DAEAE5492AB9DCCA0D3B7F81BE38BA3ADA7F62A5A5C69177369D716FA85FDB5A4D2DD44BBE4B7B78E5955AE6555C1290076F9D38F9D729E9BFF005B7F9AFBD0EDAD8F70D2FF00E0A2DF11A3F0FCDA6EB367A6EB93951E55EC88D148A7D5829C37E0057CFBF123E24EB7F15BC4D26BBAFCB14B7CD1AC43C98F62AA0CE001F89EBCD757AD7C09D46FB5FB1B3F0AAACF64DE1DD1756BBBCD6F54B3B0823B8BEB549442269DE28F2CE6411C792E551BEF6D6358327C19F165AE95A26A57F67A7E8F69AD5C4D6B62DABEB56362D2491492C72EE59A7468D51E191599C2A83B413974DCDDD3E57DEDF3BD89D2DCCBB27F7ABAFC0E2A92BA2D6FE1F7887C3FE30B7F0ADD69AD2EBB726DFECB6B632C7782EBCF55680C1242CE92AC81D0AB233039E0D7A16BDFB376B9A3F83FC2A56DD6EBC5BAD788350D2C4167AB595DD8ADBDB5B412B486785DA34285E7F319E5010467705DA4D2FB3CDFD6E97EAAE52577CBFD6CDFE499E37456C78ABC27A9F82F571A6EAB1DBACED0A5C452D95EC17B6F344DF75E29E0778E45E08CA3100AB03C8206543119A6445382C680B17743BC7B6BAF2B76126F95B3DBD0D757636B1DADBF951AE171F7BD6B855668D8156C329C822BBBD2EEBEDD630CCC30597E6C57552D5347A1857CDEEB317C3D622E1EF8C8998DC94CFE3563C336ED67717D6EC3946183F5CD6D5B402DA2D88B81FCE88ADD63B8797A33800FE1D2AE3048EB8D151717D892968C714EFAD6C750DC75A0633D29D4536313DCD1B453BD3346D2474C53B15613D68A5C7146DE94589B09FD68EF4AD460D162D20EFC51F853B18C53B3ED4011B51B6976D3BF5A5A0EC474ABF4E69CA9BA9F81FA52BA0194A149EDFAD39568DBB781C52B80CDA69DB734A453B68E68B8EC47E59F4A319ED5283D2819FE2A2E1623DB46D2ADCF352803D3147BF5A771D86B00DCF7A4DBF2D3BDA969DF41D88F69A3D38A9029F4A36E719E2AEE161BD7A52EDA708F1D0D1B28B8AC27F0D34AD3F6FE34E2A2843686853B739A4DBC629EA3E6C76A5E3AD30E519B4734EDBBB9A77AD0B9C63B569A0586EDE69C7DF834BCE79E285EFC5171D8685F5A39A9001DE936FCC7D298EC37229DF74014B47BF5A6026DA5C53BEBC51B6915619834E0B4A3B719A51F74D01618C0D1B71521E693FCF140584C67BD2327A53D5BAF146DF5E9415623DBC9A36D485334817F3A9E64161BCF4C52EDF5EB4BB46EC53E9DC7CA465318C1A172314EE68FE545C3958CE69CAB4FA4FBBF4A4D85863679A07CDDE9D4BFAD2B85B5198C63BD26DA9168C7E74D483946D26DEDDE9FB40E2976739AAB8B948F9A750C39A7EDF5E29F307291D2EDA76DA5C7CA3BD3B858605A52334ABCFB548ABD68B8EC43B7AE68C6DCD48DD09A455FE545C7CA336F4A5C1F4A55CEEA7EDEB487623DB9F6A4A7B2FCB49D38EB4EE4D86B0DA31463B53F3CF4CD215FC28B85866D14841A902F4A28B8ACC8FF0086936FB53F8EDCD2EDE945C5619B6931F2D49B4F3C526CED525F28DC7CBEA693AE0E3152B2D376FE340AC3768FA5263F2A7E77718A76DC2FA9A03948B069314FE7AD1B7A7A8A09B0DDA36F4A6EDFC6A42BD714DC7E740EC336D183522AF1934868172919054E7BD277A936D27E14C8B11F3B8E28DA476A9B6F7C734DDBC1A02C4580BD066940F969DB68E83D690588F68E6936F4A7EC3C52FF001114C5623E7FC69B83D2A5A197E6CD3B87290A825083432EDE6A42BE94840DD9CF1522B0D0BC034817AE6A4C1A6BAFE2680B0C65A6943DAA5E0AE69B8E82B30E5233CD336FB54CCB4DDB8EBC566D87291D26CDD52328CD017752B93623C7069816A520D26071537111EDA5C53B67CC7D2931F8D2B80DDBB6936F6E95273437514088B69CD1D3DE9F8A550680223477C53F69663D8526DAA15866314BDA9DB7FBD48D4F40B0CC1FC29DEB47A51B4D1A1360F4A4A5F6EF47F0D30B09452E3AD2504D86D18E339A75140586D26D19A5C1A4A04D0981F4A4240A7521E7BD161586E7DA8229D8EB495248DCFB5253B9F5A4DD520336D27B549D3DE9869086FF000F1CD19F6A565F968EDEF40AC30E69B4FDA6BBBF871E11D1F5EF0EF89B55BCD2B5DF16DF690F6E4F873C317715BDF7D95C4866BEF9E09CC914451159523E3CD5667403E64DF2A727B2FEBFAFBDE8633928ABBFEBFAFF0081B9C171E95EE6FF00B63FC43B5F00F857C37A5DFC7A43681135AADE5BC31B1B8B7091AC28EAEAC032042370C6430C8C8C9F39D27E1E6ADE2AB0D22EF47D31ACF4FBAD3E6D44EABAE6B561696B340B78F6C25DD2B4696FFBC023F2E491999812A48200D6D63E086B963A5F802EAC6F34AD62EBC5D6D3DC456765AB58C8D6DE54B3AB162970DFBA58E0323CCC1638FE65720A1AE2AF87A18951F6F05249E975D75E9F27BF5F31C6B28DF96451F88BF1ABC69F16ADEC21F166B6FABC560CED6CAD0451F965C00DF711739DA3AFA570D9CF6AEF6C7E0778D354B8D462B5D3EC26834F16AD71A88D734F160AB73E67D9D85D99FC9657689D032B91BC6C24390A6B789BE0FF008B7C1B62977AE697069B17F68269732CDA95A7996774E19922BA41296B62CA8CC0CC101552738E6B5A74E9508AA74E2A2BB2D17DDEAD7DE47B4527772BBFF817FCB5F438BC0A4DB5BBE2FF00066ADE07BAB187558ED76DF5B9BAB4B9D3F50B7BFB6B88848F1968E7B79248DB0E8EA406C82A4102B0F15B269EC0328DA29DC7A525261619453B1D68A4458CEF01F8B1BC03E3EF0B78A52CFF00B45B43D56D754167E6F95E7F932AC9B37ED6DB9DB8CE0E33D0D747E1FF008E9E2287E2B43E3DF16DDEB9E34BE860BBB5B76BCD6A4FB75824A922C6D69752ACBE4C90B4A648DB610AC32141E470148EC1393EB8E6B9E3CD26A2B7D6DF3D19E56C9F9DBF0DBF33E84D63E3AF857E267827E25EA3E34D0F55BEFB65CF85AD2DF477F15AFF006BDE0B3B7BC8DAE4DD4B6EE653F73CC3E49FF5BD5495233EDFF6BAD7AEB4CF1469DAAC3E2AD161D535DB9D6ED9BC09E2B9342687CF89226B69C79132DC44AB145B72AAC30FF31DE40D0F0F7EC75E2AD4BC7DE22F0F69FA8E8DACDD7861E2B7D5AEF4BB6D4EFA2B6BA95DD63B72B0593C85B6C6CE5D50C68301DD58EDAF3CF15FC2FBEF09E9126ADE28D5744F0E6A324970967E1DBD7B97BDBF104ED04AE9E442F1A279B1CA80CB247B8C6E57200263954E4D7F3FE3F0FDF7B27DEDB68CD16CA4B78DBE5A34BD34BAF5DF53ACF0AFED63AA6836FA869DFD9DE24D234CBCD1F43D38DC7847C52FA3EA51CDA6DB7D9D65172B03A98E55672D0B46C01284365327134AFDA00E9BE28F066AD3F87F53BE4F0E58EAD6297536B63FB4E47BCB9BA9D6ED2E8C044775135D02B3796DF3C7BC052405B3E33F82373E1CBFF185CF88B56F0B7822DB4ED62E748B48967BF9EDEF2EA140F2C16604534C5503C7F3CFB47EF1017CE71D15BFECDF37C51F889A5785FC14B0E9D792785342D55E19EDF51BB5967BAB385A5767B7B79C42A657C9794C71AEE1C80386E4E7FBCDDB77FBE327FF00A4DFEF56E84F2A4B96FA25FF00A4B51FCDAFC6FADCE2BC55F1EB53F11FC6ED0FE2541A6DD477BA38D34476DAD6A6FA8CD746CD11034F705119DA411E59B00E58E31C5743E17FDA634CF86B73E1787C0BE03D4743D2F48D5B54D4AE16EBC4AF35E5C25FDA25ACA91DCC76F1181D11331C8AA4A90A48620965F047ECE7E27F88D71E18B6B0D274D856E345BBD52E2E2C7EDF77308A0BE92D5DEE2185277693CD508AB6B191B76B1030EC3CEFE20781352F86DE3BD63C33ABC2F15E69B308E4DB1C8B90CA1D182C8AAEA19595B0EAAC33865520806915C8BADFE7AEBF2BAFEB52B91DEFD5597A59597CD27EBF80EF893E383F113C4F1EAED79E2CBD2B6C96E65F197883FB6AF7E56638171E4C3F27CDC26CE0E4E4E78E639CE4120D58B892268E32399B24BF18A89BCBD87058301F99F4A9492D8257BEA16F01B899225382E40CD77F636BF658638401B54707D6B84F25EDE38AE55D186ECE14F2BF5AEFACEE3ED16B14A0603206AEBA3D4F4707D49BD28CF518A5028C1C56E7A960FA50CB4BB7A52F55CF5A0AB0D5A77E39A6E0E334BF8628B858197752D28E9C73460555D0C319E9467DA855278E94FDBD053D07622C773CD3B6F7ED4E54E4D0CA7A76A2E161BDA957E638E94E2A028EE6976EEF6A34109B70B9EB48ABF2D3C7A50BDB8A4558455E3146DF6A78E3EB4631EE6A06342D14BB7AF3401DF8A761D8074A5C7E342A93E82971DA900DA011DE9DB73C034E603038E682AC328FC2976D1B769E46698EC2607B53B68A5DBF2D25016D40676F4A4FC334FDB85A31D69DC04FD68E3D29554D1CFAD5685585C0E946DCF6A5DB8C52A83487CA3157E6A7151F8D2E314559361B821453979F6A5F7A50A3F0A771D906DF9B068C7E74BB6969DC7CAC6B0EDDE8EC29D4BB6AAE2185718E68DBF953D97776A5DBC1029DCAE51BB7B9A76DE29D814AAA4E39C550586638A5C103D6A4DA29BB4D050DDBD38A360F4A7F34607D281586ED14847CB4EEC052F5F6A863B1181463A1A7F72693DEA0AB0DDBDFDE8A9170C01C734DDBFCE95C7CA26DF97349B0F4CF14FC74F4A36FCB8CD2D44376D1B71EF526DF5E2936914AECAB11ED1EB4EDBDA9C32ADD29769CE7BD30B11EDDB4BC039EB4EC7F9C52EDF978A616447B7A629D8DB4F55C62874DC7AD58F948C8CD2E36AFAD2B293ED4EC155A62B0CC6714BCD3D97BE28C73ED5771728D0B9346DF98D498079CE2803E6A07622DBD6969FB40CD1B793413CAC66DE462978CE334EC73C7346DF6A0761857E5F4A4DBC53CE69769DBD281588C01B8639A1C6EA9319E3A51B7DA81F291ED1C526DF9BDAA4DBEB4DA0561BB71F9D0401527BD0541EB40AC4401A5C1A753B03AD03E5647C71CD271C714FC51C7A71405866CA4E3D2A4A368A0919B7E6CF6A695EF8A90E7B75A6F228011576D376FE752EDE69B8DADC8A04336F5E690E3B1E6A463B7B5376FAFA5021B8CF7A461CF1CD4838EA690AEEA0761981E9405E69FE5F6A4DDED8A02C46C3DB14549D8522F340588F34C3561940A8CD04586521FCE9E39A4EE3D2813437EED348A936E29AD9EDCD04D86E7B628A7E01E83029BB7F1A90B11FF000FBD26DCAFA549B7A535BAE7150161BC7A52549FC551E08CFAD6520B0D651487E5A7B5232D413CAC8E9B526DCD359437B502B0DF5A555F5A314329CF5A042350529719A5A02C47B3B52F4E29DB7B507B718A0761ADC7BD37F0A7F19E94BE9C555C5CAC8D948E739A695CF1526DA36E2842B116DFC2978F4A7FF1535B22992331EF452E3DE8AA1586FAD253B6FE749B681D83DA901F6A294504583F4A663B53DA93F84502136FE5487AD3B149B4D16158693CE314DC74A931EB4DA9131BFCA8A56F4A179CF7A824695C743CD371D7BD487AE4F14DDA28023639C76A5C74A737E629B8F7A05610835B9E07F13683E0CF11D8EB9A9F86F58D6356D32FADEFF4DBAD1F5C1A698A489B76C9736F2974242FDC31B0C37CDC8C5AF85FA4D8F883E2AF81747D4E0FB5699A9EBF61637506F64F32196E111D77290C32A48C8208EC6BA1B6D374CF8C1A1EA83C2BE0DB5F0CF8AB4CF145968505969B7F7325AEA515E34D1C5917534AC9324908CB09150A39CA82B929C9C5C52DDFF9C57E6D1C95A54DA946A6CB7EDADFFC995341F8F73C7AE683A96BDE1BD4A51A6D9DF5B5CE9FA1EAD0DA58EA7F69D4A6BE78AE6DE6B4B847B6FDF6CF21811F22B6E040022F097C789FC27AA780F58B4F094F65ABF861754B1274CD5DAD2DE5D3EFA5BA9248A1558BCDB7990DDB08E659582F968761E6BA5F117ECBFE28F0A6AB716FAC6A5A4E91616DA4CFACCDAA6AD0EA1A7C2B041710C1300971691CCECA6E2261B6321C36232EDF2D6049F072E2C67D527D53C57E1AD23C3B651584A9E25BA9EE5EC6EC5EC6D25A884456EF312E892310D12ECF2DB7ED380708C69D95B6D7F16D7E2F992EFAA46528526E577BEAFE497E5757EDA37AD8E7BE227C4EBBF1B7867C4BA284F176A9FDB7369539D4BC61E26FED8BD83EC5F6BFDD897ECD16E46FB5F0B81B4A1FBDBB8D76F8F574BE3AF19788A6F0541A8C1E25F17E9BE28934CBCBCF3228D6D1AE18DB3662C387FB46371000D9CAB6715D47827F67C7BEF16E8FA7F8C3C4FA2F862CEE3C5EBE1292069E796EEEAE14C0CEB6DE4DBCD1FCD1DC214924213246E20119E724F86736A1A0EA171A3EA5E1CD52C74FD4757861D4EDE6BE4BAD44595B41713C4B1CB12261229198663462639B24811E67DC8FBD7FEF7DDC8EFF00841FFC3EB2E146A7EEDF5D3FF4A5FA3465FC52F8AD7DF17754F0DCF736DAEC6BA2584B622EBC49AF36B17D741E7926DD2CE618BA799B400A005502B92CE2BBBB1F85334DA69D5354F13F877C37A4476761733DFEA935C94824BD577B5B76586DE4732BC51B4DF2A9554C16652715CB789BC3F7BE11F136ABA0EA71C71EA3A6DC35B4EB1482442C3BAB0E1948C104750455C5469BE45BEBFF0007F3FC7B1BC5A92D1DF6336931C53BBE292ACA1B8C5141CD148564737244D6F6A3FBB30054E3F3A6C36EBE74B14A3900EDFF007BD2AEEA13799711D9C601587853DCB51A1DD2FF006A1FB40F99C6DC91C035CD4DB5252479FCAB9AC777FF000B635CD7B54F1D6ABAF7863C37E27D37C67A8C7AA6A5A1EA297496B1DD44CE639A0786E239A365124ABC4B82B23060DC639DD5BC7D36A9E114F0D6A5E0FF000F5E269CD3C3A36A3235E0BAD1EDE598CC6DA175B90B244AED215FB42CAC3CC6F9B9E346DED92DE1F2D7EE7BD71FA9016BA85DC472AAC71F8E2A9AF66E2A3D2DF868BE69689EE969B1B55A2A9A525FD7F5FF0004EDFC53F1C359F155E789E3F15785FC37E268358D567D72182ED6EE21A55E4E81267B5686E6370182459495A44CC4876E739DAD17F685F16F87E7D26E2E7C3BE16D62DE13A24964BA9C375E5DADC699035BDADC7EEAE10BB84662CAFBD0939082BCB2DB48B8BCB9F2D06EE06E909E003DEBB0FECC46B7B785F0C2239A74E3656F4FC36FBBEFFB854A87B44EEBBFE3BFC9F5EFAF76765ADFC4B7F0EDC681A0E90FA178FB46B4F0D5DE8FAF457167771E9BA9B5D6A53DFB247BCC170A227780AC83CB70F11C12BD7CAF5298DE6A93DC45A5D9F84EC242A534EB392668210140C219E496420E33F33B1C93DB02BAC48D63FB8AABF418AC2D5F464B995AEEE6E445181C2AFCDD3DEA654D4755E7F8B6FF0036CE8AB47955EFBEFE6ED6BFABB6A60DC5BC335DA25BC8D3AED3B9BF9E2ABCCC762AB0DA546391C9A974B6DBA846147CACE57E63D8F5A1260B2C914E18A8C85E3243761F9D49E77C4B42BAB797838CE0E769E86BD074864934F8191762B2F0B9CE3DAB8092DE486411B2307DB9C375C7AD763E11B847D3447B817427E5CF3FE715B527B9DD83769B4CDB5A5DBD28A5EB5D27B484DBED46DF634FA282B9589E5E6865F97D69DC9A555DDC76A07623DBC629DB3DA9DD734B557616184629734EDA68A2E161A3393DA9DB69C413477EB45C761B4B8F6A5DB4517042727E942D3B9A4C76A2E3B087BD28EC69CCB46DA45F28DE79A157AE79A7EDA147CDE94EE160DA69BB7238A9196855A91D90C5E8066959391938A76DE734BB681DB41806DA29C474E7BD017E6F6A02C260F2280A76F4A7E371F4A4CFB503E5136F5CD1B7DE9FD7BD1B7A1FCE81D8685A3D853D41A02E334058660D3B07B53B6F7A5AA2AC35A9368A791D29303E955717289FC3ED463A53B6D2E07A5171D84E3029314EC714628D42C26DEB4BB79CD3877A5C71E9543E519CFE1DA9EA071EB4EDBD3D2855E7345CAE5136D285E29DB738A7AC7F2F3C5689E83E5643CFA52FA9ED4FDB827BD1B3E5E0E6AB40E519CD27DEC11C54BDBA668E95371F2916D19CD2E3DAA5D9F2E297674A40A242CB49B73537979F6A46439A2E55863003140507F3A91573DB2694003B521588CAE7AD26DEDDEA4C1A5DA76E715255866DA36E29FB7D7EB46DC37AD3B05866D3E94AAB8F7A76DA7602D48EC458E9C51B79CD4DB7BD302D3B0AC3680BF37B53F6FCD428DBDEAC2C46413D68DBD38A9B6EEE9C52ED1D31CD01622C6579EB498E318A931F350577720D5215889852E3E5C548573D69A573542E5627E1463BD3B6FB52EDC503E519CEDC51CF7A763926823D680B0839A6EDA976818EB48D856EB9A06338A4E7BD3BF0E68C7BD02B0DE4F6A4D829FB48079A3F0A039466DE3149834EF5C9C53B1400CDA3AE28C751DA9FB7F3A4DBD7BD02B0CDB4857A7A549FCE91BD280B0C2B49B6A4FE2C51B6822CC663E6149B7DA9E579E2976E47A503E56479EF8C5277CF7A90A77EB48CB8CFAE281728C2B405DDF5A7FEB48320E68158632527DDF6A9187434DC1EB405866DA46E7B54B499F6E68172B19DA9BB7B1A9557F3A4DBF366A47622DBEF4DDA3EA6A634CC50886866CE29BB7A7A54C3A5349ED8A2E896867AD376FAD49B79C5379E953A834336F6A6F3EB52F1CD260D4DC561A07E74D6069E463DA93A7BD21F291FA7AE6931B5B3D69F804E6931B463BD672132365A4E4E29FD7A52636D48AC30E4B0EC29BB49ED52B60F4A6ED3EB40AC478FCE8DB91EF4F2BD280BDFA504588D451F514F236D2FD681D88F1F36697DE9581DDC51B4D016130293918A751C7AD021B8EA29AD9EB4FDBD68607A75A685622EA41C52301D0D4A46D0052141D49E6A85621651C628DA3AD3997E61CD2EDEF9AAB13623CD0D526D3BA98CB4584336FCD46DA5FE2A5E3D28111D38F4A5DBED4352D02C328FBDD3814BB7AD1B68D0561BED46D14B8E00A2A6E40D602929FF007BDA9BB6A4425271E94EFAD25048C6A4E69D83452B816741D7EF7C25E26D0FC41A6C504DA8E8DA85BEA56D1DD2B189E4864122870A412A4A8C8041C77157AF7E267887EDFA4DC786F4BD1BC071E9BACC7E215B5D096E248EE3508C9F2E799AEA69E47DA0B058CBF96A19F080BB96C76F5C534FB52766D3EDFF0001FE693F5499CF2A309DF996FA7E7FE6FEF676BE19F89DE18D16E7E20DFDDFC3DF09E872EB3E19B8B04D26C57537B3D56E25BFB394C7229BA7684048A52A627842E3820EDAC95F8AFADEA171ABAEB3E18F0CEBDE1DD4A2D3E34F0BDF25DAD8588B288C569E418AE1265F2E37913E695B78918BEF27239DF2D5FEF286FA8A5C0FA567ECE3A5B64ADF736D7DCDE9DBA58CFD847DE6FABBFE097E3657EFD4D76F8A5E33B9D6349D4AE9B4E9EFF4BF16C9E33B7B8680826F5C5B8D85430510A8B68C2A2A8C0C8CE30010FC4BD7F4FD4B479F49D1343D0EDB49F12CDE28B6B1B4173243F689A28229626334EEED0BAC032A5B3FBC71BB0405C8CFB5376D1C9156FEB6B7FF00231FB87EC21FD79DFF00F9297DE6DDAFC46D61B50F16DC6B9A0681E2ED3FC517D0EA579A2EAEB72B690DC425C40D018278A5411A48F12AF9857636D60D818C5D4B55D4BC49AF6ADAEEB332DC6A9AA5CB5D5C3A2844DCC738551C2A8E81470000074A46FBB4C614D45269FF005D3FC92F448B8D3516DAEA2639CF7A461E9C8A76D3EB46DDC29D87623A29F4522794AB2787DBFB692746FDC93BC9F423B555BED1F1AA6E8CED064571F43C1FE9F9D7527E9ED505DDB9995590E2552594E38E7B1ACF96D61CA847A1320AC4D4F485975233390CB226D09DCB76AD087548D815DADE7AF062039CFD6BDB3F629D321D5BF69DF0747AAD9A5C4521BC1E44C81A3C0B29CF20F5358E22A7B1A72AB6BF2A6FEE469251A968B3C2BC3D66F62B73049F795F009F4C56BED15FB22DE0FD02D7549A08F47B028A46375B21EA01F4F7AFC702C1F950464F43D6BC6C9F3959A3AB154F9792DD6FBDFC9763AFD8FB28A49E8C4AE53C596A5184B25D6F63FF002C7D07AD75BB7AD64DFF0087ED6F2E1AEEE259063EF00C00AFA19ABA39B11072868715147B9867E538CAB7A91DAB7F43D1E2BC920BB8DD982B6248DFA861CFE554A38CEB3AB08E04DB0AE4281D028F5AEBB44D246936A533BE47E58F6CFA5674D5F567061A8B94B9BA1CB6BB11BCD727442432A7AFA0E454BA78692386FED1313C2764D12FF12F4CE2BA2B4D16186EA7B973BA694E791C01E82B3BC2FA7B5ADEEA00FDD56F2C7BF39FF0A696BA9B468B5357EA74414950718A7629769A50A2BA6E7AD613D3346DA5EE29FB6994347A74A36D3940EE28C1EB40EC371DA9703D69DC7AD2FA71934C2C263B526DA9140A46FA522AC228E334BE5FBD2A8F971DA9FE8681D88C2E29768A71146DF7A0761AAB8A5D9FC54E514B8A0AB0C61CD2D3B146DA02C378F5A545C3734EDA7070297B71CD03B0DA45F4E94F55F5E949B680B0942F735271D051B1477A0AB0CDBD05263E5F7A93D68DBCE680B0DED9A4C53CAF146D340EC37147D78A760D288FA50161AAA7AD2ED3522FCDD062855DC0F38A0BE51841EB498E9526DE08A3CBC7BD315866DE3346DA9703BF1463D78AA0B1173CD3956A42BC50B8F4CD2D47618471EB46D2D8C8A7365BB53971DE81DB51A23EF8A4E839FCEA7C7B534FCCDD3355A0EC34034BD063A53F69EE3149B71CF5A0AB08A3A53BA53B68A5DB9AA0E5634AEE5CD22AF4A7F3B714BE9557D0762361DA97D29DB7B1E28DBDA95C9B0DC73D28A5652B4607F9145CB486ED3D69FB73DA9DB3D78F4A771DBD6A6E57291EDEF49B7D2A6EBD38A660F34AE4D88B07E94FED8A5DB8E8734E6CF6E690EC331D3229369E6A45EF4B81E949487CA317BD26DA7EDF6A5DB561623DB46D03AF15205DDDFBD1B7D6AAE2E563157BFBD0DDF8A900C1F5A197F0AA0B0C5CE0518A776E947E148566376D1F76A42A7AD371E838AA1D86EDE73DE875CF4A93B761463D0668B8588B6F4A7327E74EC714AA33D698EC40C3A8F6A55523DEA42BCE294719C0A39856D467D78A4DBC7BE6A56401738A8F9A7741618063BD2ED39CE29FC7AD3B68E9DA8B85884A93C0E2803F3A90252ED39CD171588B6E3AD0C3352B2E173D69814A9A62198EB498FC2A6DB96F4A4DBC503B116DA42BBB9152FF000D37A7D6822C3768EB4727A53C2D29507B503B116DF9A9694A7CD4BB31EF40AC342E0F3CD215A9B68CD26DA064181CD1B7A761526DF6A0FA502B119ED9A6E3A548C9D31CD017A52B85866DF7A6004354FB70691941CF6A9B8EC317AD3307A639A9141F4A36FCD4C9B116DF5A6B2F4A971CE29302A3985622DBB7346DCE054ACBBB34D65C77A7615889BEF63B527AD49B69ADF2F51411623DBD697EB4FC0C934D22B315867D7814D231ED526DDA307AD26DF6A91588CA8029ACB8F6A9187B62931521623DB8A00C0E6A52BDFB5232F38ED485619B40ED51ED3536D349B7DA817291F1E94707AD49B41E3A6293140588D94E334DE3D6A5A695A09B0CDBDC734BB7A60D2EDEBED4B9F6A02C47B7DA8FA1E95275E948DF4A056194629C579349C7AD5222C33F0A4C1E69FD7DA8EB9A6162365E4134719CE2A43CF5A67D39A448DDBD4E734D2BD78A7ED1F4A36934AE4B20DBED4366A5A465F6A771588FB9A6E0D49B4D1B68B886718A1B029FFAD36931D88F9F4A0FE54F6A68EF489686D00529C7A73467D681586B75E78A4E3D69D463B502E51A714D273C629D49504D86738C678A4DB4FEBED49B4D2D49B0C3818C0A29D4100521586D34D3BDE93EF76A7726C338F5A36FE54EA29888F69E79A6E38A7ED347E1413623C1ED453BB0A2A4394D7A314EDBCD1B452E6D0EBB104D6B13B162BC9EE0915ECDFB197D9349FDA73C0D732C915B47E65D45E648C1465ECE7555C9EE59940EE4903BD790EDCF6A6CCAACBB4BEC604329070720E41AE7C45355E8CE95EDCC9AFBD585CA96B63F5A754F8D5E04D37C4FA8DB5F78C344B2B9B798C1343717F123C6E9F2B2B02DC1041AFCC7F8B89A42FC52F158D00DB9D17FB4A7FB19B360D0F95BCEDD8471B71D31C572B7DA9C97D793DD5F5DB4F7770E649669DF73C8C4E4B313C924F7A896E226C912291DF0C2BC0CA725865739D48D47272DFB1D32A9CD65D890AD41756A2EE1689C9D8DD79ED532B6E1956047B53BF9D7D399DAFB905AD8C1629B2089507FB3D7F3AB1F5A30697EF531C63CAACB41B4D8E111BC840FBEDB8FBD4BB452FA505D95D3131C669D4E5FBB48077EB4F42EC26DE69EBF7B1DA9304FB52FBE2AEE1642EDE9CD1EC69D494CAE51003E94BCE78A5A72FB7340AC33695E69DFCE8E793DE8C1A0AB07623A51CE7D2971BBEB4FFE740EC336FE74BB7E5CF34E504D2E380B41561AA9F2D2EDC75A936ED5F7A46CF1DE95C7619B7AD1B7919A976FCBEF46DC0F5145C2C46573DE80A5B1C549E50A50BB4F1D28B97CA26DA4DBF2F1CD4BD7D8D263B517191F964714D5538E953F146DF9B34C3948761EFC53CAF5A936F39A368F5A07CA43CEDE94E58FA549B7B76A5DBED40AC4463EA280A78E2A6F5EF4BFCE81D88C2EDA5DBF28A9000C79E2931F2D0046ABF9D054A81CD498E738A3CB3415623553F85017DEA7F2F0BC73C526DC555C2C44141E29DE5D4AABD78E2936814C08D54E791814EDB8E29FB7E94E55C800F4A064640C51B4FD2A52BC91D697CBEB4AE5588BDA976FCB9A7E00A307681DA995619EB8E6957EB4ED9F4A779607439A2E85619B78CF7A555F5A519039A7B638E28294466DF97228553F853F1D476A5C7CA295C76232BEB49CEEF6A978A4DBC0A57158685FC451B48C7714ECE3229DCEDCD0591E0F3C51B7A53B14BB734EE2D060C535B3C0A7ED3BA971F2E7DEA2E0911ED34B83C7AFA538F5E9473D39CFD28013AE68E69C1739CD1C038EB4D301BB08A51D41A72B7AD3F68C6318A7702261ED46DA931DBB51B7A55DC1A185718A4DBED9A931D3D0D28CAF1DE95C2C47B7B75A5DBC6297F8B3ED4F1F363B56816220B8FA629DF852E3AFA53B1D3D680B11EDA4DBF4A7B0DBEF46DEE3A55DC5619B7AD2F34E0A79A76D3C639A91D88B1D33C5376F5CF153AA818CF34D65E38EB4D242B1163BD3F69DA3D294AD3B8F4AA0488F69F4A4DA7D3B54BC734DC7AD03B119418A5DA0D3FCBA36D02688FAB0A36E7DAA4DA33D31F8D18AAB0B948767CB49E5F71CD4ECA3D0D2329ED4AE1CA44ABCF5CD2BFCB8A91548E4F143AEE1D39A3417290ED6EB8A76DE9D8F7A936FCB8A6B74E0D31F289ED8E3348D1FCD8A78F7348DC738ACD872916CEF4DD87754DCE31DA8FE2A9BB15885976B7B52EDA7EDA52A28B8EC47B7DE9ADD31526DC5376D21588F6F423A518C62A4DA3A53587CB9A7723950CDBDFBD376FF002A97D69BB715216633A6699E5D4CCB4DDB4F989647B69ACBC7B5487F5A4DB95CD4DC2C45C7AD1B7BD48AB9E7AD2B2F1C51A07290EDC74E734DDA7F5A97078A36F4A9B9245B78C1E68DBDAA5C0E69BB4D48588994F6149FC552ED27A7349B79340AC47B7F3A6ED3F5A9B07AE28DB40B94888F97A5331ED53F3DE99B7B504588768A5A7B262811FAD2B91623F4A4C548C9E9498E99E2987291D2EDE94EF2E9194646281584C7E74CFE5527D78A465AA1116073E94B8A7E2902F3CF4A02C31A99C54CCA2998E9DE8B91619DBA514F3F95205CE2A456222297E94E65EBDE93EB413619C9A314EFC2931E87340AC30E2939FA8A7D358F18C502E5236FA5210054BF8546413413611A91A9DD7B527DEA04328A76D149B7F2A5701BD68269691AA49B0D3FAD264FA53F68A6D0458368A6D3B9A3BE2A45622F7A0D3A93D68246E0D253A9BCF34262E56252352D27E14C561BB68A773E945211B38A5DA39A3681C75A5E456773BAC257B9FC2FF07EA179E02D2FC3427F0DDA45F11DAF16E1F57D7B4FB3BB8A3894C5A5BC76F34CB3C81AF56527CB46DC1463278AF0EAAD79693EA17B6D7975A8DECF77691C70DA4D25C397B648CE6358C93940A7A01803B5125CD1717D77F4FF003D8E5AF4A752DC8ECD6BF3E87AFF00C38F107897459BE09787F42F15EB5F0D6C7C5ED35BEA1AB68F686792E75B5D465B6FB35DA99A10F1C518B7CC4CCC15652DB1BCC3987C0ABA9C9E38FD95A18164BB8A1D4AE2DE4B8484AC6CD6FAF5CC9373D06C88ABB0CFCAAC09E2BCE745F1178B3C2FFDAFFD89E35F11E8FF00DB12B4DA9FD87549E1FB73B6EDCD36D71E613B9B25B3F78FAD55D0EF35FF000BF87AFF00C3FA1F8AB5CD1B40D4777DBB4AB1BF9A1B5BADCA15BCD89582BE54053B81C818A9F7B994FAA7CDF3D6CBC92BB4BCADD8E3960EA4A3285F47A7E7AF9B774DF9DEDBE94F4BBE1AA0BDBB0FE64735DCCF1C83A3297241FCAAEEDEF5159D9C7636C9044308A302A703DE9C23C9151EC7B5ABD588334E23A528FD69DB7756972907B526DF9B14EC0F5A76D1D682B946AF4C6285C6EE95263D2936D31D808F94669DB452EDC0028DB4218DCFB51DFA53C7D2971EF55718CDBF852AAE7DA9FB4D3B6FCB47331D8628EF432FB62A455F7A7A8A65729104C51B7D7AD49B4FAF14BB71EE682B948D579C538273935205A5DA280486E3A6297685E9428EF4BD69176136D1B7AD3D57729A187A50161BB6969CB934BB7A7D682AC336FE146DF6A9000DC9205181F8500302FF003A523AD3A8DBDA995619B4528518CD3B6FE54BB39AA24663E5CF7A5DBCFB53940A3F9548ECC6B2F3E94EDA0727D29DD460F4A565A772B948F6EDF7A5A7EDE4FA5285C517172B19FC3D29D8F97DA9FB4F0291976B1FAD31D868A5F5E0F34E2319A5DB40EC4783FA53B68CF029DB783C734BB71819E680B1132D3D46314FD86976F15571A88DA31D71CD3B6F5CF068E71902A476D46EDFE54A169EABBBF953B6FCBCF1557191AFDDA6E0FD6A554EDD68543523B0CC6452AAF5A76CF9A9DB681D88B1E9CD2EDF6A9B606C526DEBC5057291AA73415A936E1BDA8C06F6A056230B4BB0D3C21E3B53F07B0A9B858842FA7148D9FAD4DB683EFEB4EE572A20F7C1A50BEFDEA555EF9A4DB91EB5171588B6FCDBB142AFCC339A976FCBCF5A3677CD0D8EC46D1EDCF6A02F3E9C54D8EBDE936EE3B47028B8588D57BD0149C629FB4714EC723D28B8EC47F514739E39A9786A4DBB9C9F4A7CC3B119F971914B8CF269FB32A38A4C0E3BD1CC4D84DA3D68F2F23D29FE5F71C8A36F4E954A43E51817A7B51522A9EE69BB464569726C31969554F34F65C52F214D3E6172B230BD6971CE338A781D682A541EE3D69DC7618BF973498E01208A781FCE82369C134EE2B1160E3A50460FAD4A14FAD1B79C76A77122265EB498A9B6FAD26DABB85991B2E1A83FA1A9368DC3D7141E98C517022740C080334AAB4FC7CDED4BB7E5C8E695C446CA3279A4A9B68DB4DF2F2B9A0762365DD9A368CF5A7ED3DB8A31DE9DC2C336FB734DDB9E2A50B4796739A3998588F6FE3415A9146ECF18A6B7DDCE79A8B888B14D2B52EDEB46DEB9A571D88E938A93686CE0F6A4C7AD4E816D08C2F5A465152EDE69BB7E5A41CA46C3AD271B7A714F23F1A4A7717291EDA4C0DD8A93AE703146DC7BD170E51870690A639A90A81DFBF6A6E2A6E4D889A31E94DE0E2A51D7A52633DF8A9B8B948BBD271BBA53F6F6A318C9345C8B0DDB48CA17B53FB63BD1B78CD016445B475EB46DA7EDE94A73D280B11FA9A6F1D40CD4856936FB50491F34DF6C62A52B498EF8A02C3314DDBD3152526D2B8E6822C336D336F4E38A997DFAD1C7A5405889BD97F5A667DB8A936FB52328DB8AA25A23F4C0A3033CD3847B69FD73EB4C9B10EDEB4DE735371CF14C2BF8555C5CA47B45271E94FDB494881A7E94D5519352521F6A4218537537DB352E3D69B8A02C4617B8E69ACB9A97069BB7D2821A19DE86C0A732D1D3DCD02B10D1B7DB9A93149CE6826C3307DE9BB76F4E6A4653EB4D39341362361B723BD3481D873529C734DDBBBAF14AE1623DB85F5A36FCA29F8C75A07E9524916C3D866936FCD83C54A7914C19DDC734123181A4EBCD49D69BB739ED400CA36FBD2EDA46A9DDEA2B09B4532A4A66D34AE45846F969B4EDBEB498E2913619B692A4DBD39A4A02C45452FD4514EE676376942F73C52FAE78A72FA56763BC662907D2A4DA3B0A36F6A771DB51B834BB76E39C8A771E94EC51734E56315714A01F4E69DF85281CFA9A2E1CAC6A8EFD69FF00A52D1F8532AC0AA0F6A31F952A834FDBEF5486273C7A52ED14EFBDC51B698EC21273D3340CF5A7629C179CD03E511714EA6F4C719A9147AD05A4376FE74E5E57D69D8C73405EDEB41A58028F5A31D69DB7E6F6A368A7A025A586AAEE040A700739E94A061A968D0AB0DF7A5C657A734FF2C1E8695576D17172B181769A5C53FAF6A31EF45CB1368C63146D3D29FB7F3A774C7A503B1105DB4FFC297AF6A5DBE9CD171D88F6D2EDEBDA9EA3D78A50A7AFBD172AC47B70BEA69DB7E5A7AAFE149D7A521586ED34814EECD48AB428EDD6A8761BB7DA8C549B7D7814ED9F952B8EC42AB9ED4FDBC53B14AA3A517019B7B7F3A36F1F8D48ABB8F5CD2ED04114C7623C1E98A36F3ED52EDEF46D3E94AE162365A4C6EEF52EDE946DF6AB019B475A5DB4FC0DC69DB7E6E99145C06AF3CD26DC9C54810839A400EE06914317EF74E29769F4A95947A526DF7A771F291AAE3703CD3BB74A72AFCD4A3D3145C2C302856CFA52E3D29DB7B1A76DC74E68B8EC3140E9DA8DBED4FDBC6474A52BFE734C761ACBF852638E2A5FBD4DC15C521D88F1D41A70E29CAB9E33D69DB076E68B8EC336863C714ACBF8D382F7E94EDB9E3A54956447B7AF14DDBED529E3BD20CD2B872A23DBB7A7348AB95E477A942F5A5DA6A6E3E5642C3DE9157E5CF5A94AD0AB40ACC8D53E526947BD4AAA7D38A4F2C7EB45CAE523A40BEB52F1C9E94C09B6A6E3B06DEB49D31915281F28CF143286E28E61588DBA00294AF5E73834BB3BF5A715E45171D88F1DE851BB18A7AAE6976F43D055DC5623C6723146CE9527F2A28B8B946EDCF4EB4DDA4F18A907CBCD2EDF969DD8F948C2F5E949B6A60BD78FA537CBF7AD10B948B68CFB53B0700819A7ECC2FAD2EDE9C7EB57A13CA44A3DA976F53EF4ED83A77A76DF9AA89E522C1FAD2EDF5A7EC3C9A1BF5C550EC45B7BF7A5C1C8E29FB08CD057B628B8AC336FD3F0A36F18ED52E05260719E290588FDB1ED48DD33D2A560370A465DD9EF4072917D78A181EA40A904785CD2EDF6CD3B8B948F6F4A0AFE029F82ADCF1401F8D171D88F1EF8A4DB52ED20F4CD151A0D4484AFFB3834DDBC735291BA9197AE2A2E2B113263148578A9B1DBA714DDBD7BD02E523DBD3BD34AFB54B8E39E2936FB7E19E690B948B6FCBC51B78A936F6E94BB32D8ED4AE16640570BEB4DCFA0A9DA3EDD69AD1E3A504DBA106DDDD4629AC3E5F7A98A8A1968B872B211C8C74A69F947B549B7E6C537CB3D690ACC6014B8049C8A76DF5E052F21B9A90B222D9D3D734817E6A936F4146DE9FD29936230B49B4E73EF52B2E06053769E6A82C45B4F6A56F619A93683CD0DEFC51715889D48C8C60D331D33C54ECA3F4A8F69A10B97519D6936FA54BB453769A62B116DF6A30467352EDA6E3E6A825A23DB9F6A4DBCD4ACB9E3A534AEDEF9AB2191E393C536A5A4DBD7B504D86EDC5318065CF4A93EED35BA70281D866DF9B148CA3D29FB7E6A0818E79A08B1115E78E94D519ED52EDF973DE9A381D282742365EB49B4F6152F1E9481695C9E5644CB4D3DEA6618F7A66DEBC5326C331D6931B7EB4FDBDE93BF1CD021948CA7DA9C57A7D69AD8E98E6A49B11FE9453F6FAD267AFD6A6E2B11ED3EB9A369A715FC28CFB51A0AC331EF4DCFB734FED49B7A51A0AC867AF149B69E57F3A33C63B52E644323650B494FC5378CF4E29DC9B0DA66D1D6A465A6918A8BEB7246D37BD3A91971489B0DA6B0A750CB413CAC663BD36A4FC2933E8334AE223C7B514E61451720DBDBB7DE9CBF2D1D314EDBED4CEFE5622F6A777C50140EF5D27C3DF016ABF137C6361E1AD11227D52F7CCF25667D8A7646D2364FFBA86B3949422E527648D0E73149B7AF3CD7D0717EC3BF132662163D2430382AD7B8FF00D96BC0769C9C8E6B930F8CC3E2EFEC26A56DEC58D5A1453B650A87AF6AEC0B09B467D314BCE2A41F4A02F7EA2AAE5586853D40C8A5DB8C13D29CBD4FA52B8CB550EC371EBD29D8EBEF4BB7381D69FB714CAB11ED3C53F14EC1C0A715F97D299490CDA0629C1436295531DE979DBCF0682921B4E55A5DB8C719A728F97140C6F6FC69CABEB4BB4649EF9CD3C7BF1417CA336E4D07B6076A7ED3F5A5C1A02C34714B8FC29FE58614E0B9EA2915619B48EF4DD9D78A9B6F727146CF4A63B11AA8CD3BCB3D3A53F6E464734BB7141561983CF146DCFB0A7EDF9B8E68DA681D8685C0F5A5ED814F0A05053A73C503B0D036F6C9A42A4E303834E2A548C53D63231E9E940588F6F5A72A8FC69FB69426DE4F34AE3B119527FF00D54BB7E5A936D0ABC532B948F6D2ED3D2A4DBF373C8A5C7E540588F69F4A4C1FD6A4F5A31DE9E81CA371C114A38EB4F55EBCD057773482C336E7A714BB3A639A760ED1C52ECF7AAE8161BB7F5A50BBBA5387B8CD3B69ED458A5123C53950377C1A72AF34EDBC67BD01CA4454E71D69FB3F3A7ED2AC7804D1B4E73D681D8632914A233807A1CD49B78A0AF41415CA47E57A7147967763352A2D2ED140F948BCBDA0007346DC76A971EBC1A36E7D8531D88987B66828C719A976FF003A5DBF28145C7622553C71C8A76DE29EA9C669597AD4DC3948C263DCD18E71520519A4519F7A7604869031CF34DDBCFA54BB39CFBD2EDEF8A92B948D467DA8DBEDDEA5DA7818E680B9F6350C640D1EDEA3F5A157A7AD4AC99CD1B79078A2C82C47B71C51B7A549B4EE00FF002A36D2B8ECC8BCBC738A29FB68DBF371CF3599230AE5793498EC2A4DA339A02E33415619838028C1207602A4C648228DBF2E281D911ED0B46DED9A76DE38E78A5507EB4D3648C0BCF4E6969CABEF46DFC6AAE3B21BB41EDF9D1E5E734EDBD69C172A73EB5498AC4783D28DB9FAD48CBCE452953C714EE1623C1E29420DA78A919471839A154EDAD531588B6F5A02E3AF26A4DB95CE7A51B71F5ABB8AC376FE94D2BBBDAA4D9479631EF5698588FCBCD1B7DE9FB7D69CA9DBF2A9B872916DEBC5228FC6A53F78F146DE68B8588CA9FAD056A4DB494C2C4542AE4D49B47A51B48C1A2E1619B32DCD26DFE552B2ED5EB4DEA4714AE2B1091B8F278A0AF7A95573C76A465DADE9503E522D9B89FAD1B722A50B9183C504038ED45C5CA45C375A6EDC75A976FA8C5232F4F5A90B11EDF989A6EDE9FE152B29EA46297F0A039487CBE871C51B719A957DE90AFCD8A5726C4010F2714374A9B6ED3EB4D2BEDDE90B9481979CF4A4DBF8D4BB4FA522A91D68B8B95906D03BD376FEB561A3A6F97B58F18A9B8729032631DE936E08F5A9F6D376134221A18AAB4C65CE31D7D2A665DDED9A455EA3A1F5AB1588B6773C7A7BD3597F9D4DC6DE94C6056912E2317F3A66DE70054BB79C52AE171C66A89B10B29A632D5965A8D9704F7A6222DB4BB453CAFE749B4FA5500CDBCFB5376F5352E3A5205A813220A179EF4DDA5739E6A561ED49B78F6F5A62B116DED49B4FA54BC53306826C339A4653EB526DC669197B53B8ADA10F3CD2EDC0A7E3DA93CBCAD1715867BF4A6E09ED526DF5A6E2911CA3368A4C75EF4EF6C52F03B54DC9E523651C5376FAD49B73D69197A76A2EC5622E3D6936F5F5A9369EE31430C52BB2794876EEC527DDA978EB4C65DD47525C466DE69ACBD6A5EE4D37AD04588F1C0E29BB454853D0D34E3D2815866DEB4DC1A969B8A571586329E4D376F7A908349EF8A926C44411F951ED5232EEA69155725A18DFAD34AD3CFEB4D2B524323651B72291B9E9C53D864534AF5CD04586D30F3D6A4FE74D2BE9CD2B886D37269FED4D6A923946E3D68A5A28158DFDBBBBE2979DC69C1726971D4D55CF446601C66BDBBF62FC2FED31E0D3EF79FF00A473D78AEDE9C577BF023E215AFC28F8B3E1FF0014DF5B4D776762F28962831BF6C90BC448CF048DF9C77C6322B97191954C3548415DB8BB7DC0E3A1FAA3773675CB91EEBFFA08AFC81D7345BDF0EEB57BA5EA1035ADF59CEF04F0B754752411C7B8AFAE75CFDBE12CFC4FAA7F67F855354B05B975B6BB6BF688CD102423EC3112B9500E3B57CB1E3CF14378EBC69ADF885ADBEC4DA9DE49766DC3EF11EF6276EEC0CE33D702BE37873018CC155AD2C4439633B3DD79F67E66BA59239D65C549B38A5DBBB19A5DBDBBD7DD058685A5E3E98A763A638A77D39A0A1BB31ED4B8A728A07E669956D05A5C7CB9A5DBF3629CA33CD172921A14F4E9E94F650475A5DA3D69D8AD2E5588F6904679A76D1EB4EFE74EFE2F6A63B0CE31D2940A5C1CE3A52ED3DA82EC26DF6A72AFE74BC6338A76DC1CF4A57048681E9C8A555CF5A551DA9DE5F7A0634A9F4A7F6E9C7AD2EDA5DB48BB09B47A52E29CAB4BC8F714C761BB7BD1C7E352053DC51B6A4AB0D0B93914BB47619A728DBED49DE80B09F8518F96A4F4C534A9E9D2AAE343368DDCF14FDBEF4BB71F4A777345C7623C1EF4FC0A56E3DA97693CD48EC260F718A3691DB8A7E3BE293DB3543B31BB78F7A5D9FE4D3B07AD3B6D171A445B28DBC838E2A50A78CD2EDE83BD170E5647B7BF6A5DA7D29DB29C173DE8B8F9462AD2EC1B78E69E536F4A55F4CD3B8EC46171C0A555DD4FDA319CF14EDB4F4019B79F6A76D1D2971D41A3B54DC761BB7AFA5382E38CD3B6FB51B7AF735571D86EDEA69CAA08E94AB193DE9C57DB345C6340F4E28DB4A07E14EDB45C633FC293AAF4A7EDFF00269DB47183F8517023EDEBE94BB7E5A93B838A5F2F0B468696225FA52B2F5A91569553754DC562255CFDEFCE97CBE7352EDDBF5A51C9F6A07CA45E5F5A368DB526DE94AA3DA98EC4617BD1B40E6A5DBD680BF9D40EC44CBF8714606DA976FCDCF229ACA073D680B113293F4A4DA7A118A988149B7E6DB59DCAE522DBD4D232E3B54BB7AFA526DE83BE68B13622C7E5EF462A5651D29A1474EA71482D619B7773D052F4ED4FDB903903EB4797E9C9A02C47B7DA976D3F6FCDC734B8F6E940588420E86976F049A7B2E7AD0C0FD0501623E99C8C5397D3DF9A56CF51D052AAF5C73CE680B07F3EB4632D8A5FF0C53FF8BAFE954161BB7DA8DBDA9CA415C9E33DE95B1C6335A5C7CA46C3774149B73F5A90AFCD8A02E319AAE627946AAF1CF34DE39E69FB70D9E94840E9D7DAAB985CA3194F5C67F9528E33D702948DBDE8C7CBD68B87289F951838E38A72A8A50BB5B34D05867F3A4D9526CA02E3AF34C56230A47D295B039C7E3528C1620F4F6A36F3ED4AE3B116DFC0535976FD2A6D845232D2B8F948768CE7BD06305B9E9526D3B873C52EDE2A456D2C40ABF362871536C0327A523267D853B87291052780334922155E0671EB53796719C7148579E4F35171F29561759A10E380DDBD08A7EDE0D575636B7CD111FBB9B2EBECDD0FF8FE75736FE545CCA3AA772154F98FA50CBD2A655F97DE94AFD0D055910FE14DFAD4ACBE94DDBF2FBD01622C7B629BB3A9A9F6F5E69BB454D8394836F38FCA8D95318FA1ED49E5F4A6458AFB41F6A36D4CCBCF1C8A6E054A62B1091BBBD0CB52ED03B7346DCF51DEAB52794AE54F146CA9769E322936D599B20D9CD0E32D803BD4854EEFA52EDFCFAD3D0CF9595CA9DBCF5A4DBEF53F51EB4DDBF9D30688B6FA52363D2A565DB4DC138E0502B1160D26D1B41F5A95B029BB295C56236E39C536A5653E9C8A36F38C531F290ED149B6A664DBD0D47F8D2B93623DB4353F69CD215E3DE8B888C8E9EB483834FDB96C526D1EB4684916DCE4D26DCE7B54AC31DA931EA28B8588B6F03346DF9B14FC1A4DBF354DC8B11FD29187E7526DFCA8651C64E2826C43FCE936FCD8A763BD2B5322C33BE698CB52EDC63BD33B6695C5618CA298C060E2A63FA53197BF7F6A926C4471EB487EEE6A42BDBAD359768C1A08B0CC7B5213CF4A76DF94F3CD260D02E563783ED4DF5C53F6D3718A572465271E94E20FD68A2E435723DBC9A1A9C739348DC0F5A4491FE14DCEE5E94FDB8C535B34EE4B447C7AD3303BD4B9F6A66DA44D84C5329FED484E2919D867D39A29DB40A2826E77BE11F0A8F144DAD34BAD699A05968FA6B6AB797DAB7DA3CA4844D143C082195CB1799380BEBCD6CB7C2F36527889F56F16F86F45D3347FECD6FED5B97BD96DEF52FE179AD6480416B24855E38D8FCE88474201C8189E15F1D47F0F60F1CDDE2C65D4350F0BBE9FA75B6A9A647A85B5CDC9BEB493CB92192378C8F2E290E64181B7A86C574DA2F8F340BA5F88D35978C7C35A3EA5E2F9F41D5A2B1F19787EE355B3D3FC98AED2E6C115EC6E94080C912C2C1702228A1810CA14DF2ABC7B2FBDCADF96BE5D6F7473D6C4568549452D2FA7DD1F2F36BCFA5ACCC29FC276FA7E87A7EA1A8F8A7C3FA5CFA8C26F2C74EBA7BAFB45D5A09DA1372A56DD902EE8E52119D6522338424A86B5E2CF03D87857C3FA36AB1F8DBC37AE26B30B5CE9F6BA62EA226B88526785DC79D671AA85923704330276E40208AA5A4EA3E1FD3FE1BEADA4EBFE2AD0FC5B6496770342D063D2EE8EA5A66A0F38C496F70F6EA915AB61A478C4D870FCC224395CF8617F1D41F0A7C39E1EB2BCD6F5DD2B45BEB4B9D3AC2C66966595AFEEEE02AA84F9FF0074EAE4A64019CF20E149BBDA3DD7DD697E3A2BF4D7CECB5A75EAB92E6DAFFE5AFA7F5AEEF4FC0FE0BBEF881E24B6D134F9AD2DAE2649256B8BE97CA8214452C59DF0703A0E9D580EF5CF4D38B592786E47D96E2DE4786682520323A92194FB8208AECF5586C3E17F85BC4BA2F8EBC31E2C83C49E215B5B2B7D26DDE4D0EEE2B0590CF2DC89AE2CE652AD3410C6142E4ED9391DFA287E2CF8726D63E20EA161E2C9FC1BE1EF1559DBEA97F656175A8C3AF26A22DA559ADA39A1B5FB35CC4F33333A4C238DBCE52AD1952549CB9758EB65F8EFA7CB7ECF4DCB78B9C6AB8F2DE3D1F975FC76DB4D753CB6EAEEC2DE6F2E1D52CB5041124866B56902AB3282C8448887729254E015C8382C304DED574CB9D0EF20B4BE8BECF713D9DBDFC49BD5F7413C6B2C4F9527EF2329C1E467900F15DC787BE3269D7563AB42DE363E1DD0AE3C25A259DDCBA3BEA763ADCD7B69A5F92F6F03456EF04B0F9A591E3B82A8D90C8EB8DF5CF7C43F89D1FC457D1F5DD63E245CEAD2D9783EC21874BD423BEB89A3D4E28EDA1BA858C8A23432B09A6F3519C3795F36198539692718F7B7CAD2D7F05F7AEE2A18E95470538D935F8FBBFE6EFE97D91CFF000DDA976F4AB3AA5C787639A78F44F13A788197539ED6355D366B5F32D1563315D65C9C798CD22F967E65F2F27EF0A8B6F7ED42773D8A728D48F347619B7068550DCE6A4DBBBFAD2EDE7DE99AA88CDB9C53D576F5E2976E314BF7A82F9436F714BB48C77A55CEEF5A928B8EC47B7BD2E0F1FE14FDA3AE78A76DF7AA1F2B19B69DB3031D29DDB9A5DBCE6A8A1BB7BF6A76DA551D8D3F6E6905862AE73D8D38678A763381D334A7E55CD4DCA4842A3D38A00DC78E29DDF1E94ABD69EA5D86814BB7D3914F55C75A5DBED46A5584DA467D69A7031DEA4EBC8E294A839C8FA5055B423E9D052F97CE47352053D69768F4FD68B87291AAD281BA9E17E5F7A705E9E948AB11EDA36E39FE1A938FA52ECC11DE9DCAB0CDB9FA669769DD4FDB8F71460F38E68B858680475A5DBD697BF4A72E695C7619B7D78CD1B48CF7A9180EDC9EF4AA84E69DC2C47CEEE78147AE06454857D0F14A00EFC734B9915CA478EA7029DB71D3BF5A7EDE7A7342A8EBED4EE1CA30A83F4A5DB5205F947AD2EDF97D281F2B23DBDA97CBF97BE2A455EBE94ECE471D280E52155E9E94E65C1CF70734FDBC714E2A4E38A65729105ED4A170D526D1C5288FE6FF000A02C45B69DB70BD79A91A3FC05288E995C842ABDFB1A7EDF9B8E453D57DB834F0BD0018A07CA57DA7BF27DA976F4E2A6D9CE7BD3B6F4CD3B8F948941EB8E334BB4F535263D051B4F43C7352572B23D871C8C1EB4EDB8E29F8CE78E7A7E14EF6E8681F2916DE09C526C1FD2A6C1E0D181C8FC681D8882D2F9786F4152F9670051CFF00FAEAAE1CA478CE7803346D1CFE95211C628641C63A67F1A9292232BF850CBDEA5DB9F71ED498A02C43B4B678A4319EFF00A5582339C50540C7614AC2B15D94A90718A4DB838EB5676F1EA280BD074A5CA3E52A63A0C51E580B93C55BF2FA773EB414078C5160E5EE54D8770CF5F5A763A7193536CDDD697CBE87FF00AD485CA41B32DD3146D1F8D48573CF43DA9BB43548AD619D7B645376741528F93A74FA51C50162108476A1633D8F352F7E4719A4553F950047E5D2AC63B9E7B548578E3F5A730039229A63B116CEB4BCFA53F6F0293DEAC2C3546EC52329DD526DA465EE298AC3318E0E68C01818E69DD3B1FCE942EEE4531588D7DFD28E3D33C549B46D3C668550D4839462AF4038A5D9CE71D6A551DC8E47A539A3ED543E522DBD291A3E9C719A982ED5A52B9E3AF7E947307290A47ED8A36FCC076A999682A28B8F9485A936FAD4AC3E5C81C523672001C54B62B106D069FB47229D8DBFFD6A5ED9039A570B11ED0CD8E94A540CE3918A93839A693F8D505866DF971D298CBC83533E71E94D65C7D2931D8CDD52DDE4B52F00CCF11F3231EA47207E238A5B7BC4B9B782E133B24EBED907FAF157D97764560B37F67DDDE5893812AFDAADFD323EF2FE7CFE34AE71D4FDDC94BA1B5B7E623D2A39245810B60B6DEBB467F9554B8BAB492DFCD60D2B15CFEEDDB827D70463F1E3DEB94D4274B9BA44FB34705A6E02496672E7FDD009E5BF41EB4CC6B627D9C743A81AD58F98B1B4C2376214070467F3EF4EBDBF86C0C6B2B80F2B6D8D4756CFA0FEB5E6BE27D62D63B192C7CB4B5B9B565921312FCB21CE0F4ED839CFB52784F56BFD6F587BC925895C2EC59A73F2C60F641EB45FA1E43CD17B45456B7B7FC13D5B6FA8A465F6AAB61652DAE19EE5AE998E599BA7E157D94FE541F410D6379103205EA29ACA077A9C8CF6E3BD232F5E281B440CBB73FA6699B7E6C75A9F6F4079A4641D7A5413620DBD33C51B78A91940C7A50CBE9D6AC9E52165F6EF4D61E82AC7BE2936FBD3279483079078CD214EBC9152ED1D3D2855F9B14EE2E52BF97D38A4299E9C1A9B0303D69ACBEF55A11621DB49C75A97D3149B4F7140AC45B734D20FE35315C66936E690B948190D0CB8EF8A95B34D2A7D88A7A0AC44CBDFAD37AF6A95B1F8FB51B69136D489A31EB51B2927A5586514C65DA78A40D10EDC74E6907B8C0A97F9D21E7AD1726DA588B6F3B69AD9A971F37E149C7A54936222A31E949B6A4719E4534FE5413622DB9E6936D4A57F3A4DA39F4A64D8876FB7149B6A56F4A69CF5A41623DBEDDA9BB7E5EB52D236076A5726C45B78C523293C62A4E69AC31489B11E06314CC0DD52FAFAD336D3B99B444DC2E2917EF7352F5ED4DDA07D68B99D86B7A0A630F5E2A4F5EF4DDBF8D483891F6EBCD35862A5E3AE29B8A0CC8D853700D48CBF8535A8258C3FA535BB5498FCA98DF4A5733688DBBE053596A46229A7BE79A4411E3B52797D2A4A6918A09688BA51526CF5A29DC83A368924C6F556C74C8A6B5AC2C72618C9F75153001A9769EB8A67ABCA995D2D6156CAC280FB2814DB8B18AE1482BB73FC4A00356D40A5318F5C50351451B5D2E1B3903A659BFDAC7F8559FB1C3264B431B1F5282A658F34E5E302829452D083EC56E38F223FFBE053BEC5037DE863FF00BE054FF853B6E282F9510A5AC51B6522453EAAA0549B7A8EA69C14F3C52F1EB415CA3546DA76D14EDB938A00CF34876131BBA734BF8734E553E94EC63BE68D0AB0CE99E7AD397073918A76DE869429EFC505F289B6947BD2E0F24F14ACB9CF7FE74EE1613008A72FCD814BB7E5A76DA572B944DBDB3C7AD387CBD29DE949B7E618AB2AC26DA7347ED4E0BEBC51F87EB5172AC22A8EB8A02E0F1D69FB7E5A76D19CF7A771D84C66971F29F5F5A5DBEBC51B79F6A5734B0DDBD7B9A763F9D3941F4C52ECA43B0CDA69DCF03751D707A53B1D79FF000A602052339A55C6D0338A76DCE33DE8DBB4103A522AC376D3B6638A7EDE3D6976FCBCD3B8EC33693D38A5DBED4EDBD7F4A5C7A73CF14CB23DBD2976D3F6FBD3B6F4C734AE223DBE9432D49B5B078A5EBFC3F5A2E1623507F0A503A60607BD3F67E1F5A76DCF5E3EB48A23DBF303DE9547AD3CA9CE0F146DF4A771D84F4E314ABC2F4E69CA993CF04D2ED3DC5202355E718E29DB413DFF002A7F46A1416E9FAD003571D71914E0BFE4D3917D29DB7AFF000FD2ACAB6834AF6E94BB7BE29E170D8EBED47D69DCBB0CDBB7DC52EDCAFA9A7053E94EDBD00FC68B858605DB4BEE700FE94FDA0FD3D680BD78E3D28B8EC30E79391DE976F5CF7A936F7CE68D848EBDA8B97CA45F77009CF34A40ED4FC640EDF514A13A1EC28B9361B81C1CE28C0C1EF526DF97FF00AD405C1E3915372866DDBD4826820E076C9A7F967838EB4A17A0FBDE940B9591EDEF4B8F5E2A4D9EDF951B7A532EC47B71CD3B685EF4E551BBD2956327DE9DC2C47B7D3D69769E73FD2A461B7B527964F18C8A9023C0CF1C7D68DBDBF9F352EDE9C53BCBFE75572F9484E3B6290292DCF4A9429F45A4E99EDF85171588997078347D2A6DB9EFD6A351E9CD4872B21C0FE1ED52328DBF5A7ECF7A708C0C83D29681CA57DA0A83E948CA5471CD5AF286454653E6A42E521DB83EBE949B4FA0A9FCBC77C5376FFB38F6A41CA4457F134DD9B7A9A9C26D539EB8A66D1934C5CA45B7D4D2E074EF5214E80F19A4DBE9CD016183D319A6EC2727BD3D4956C7BD040EB45C4F51A33BB03A773432EDEE79F6A775183C8A4C1FD3B53B8AC331D8807F0A5E738A77F2C73ED463A64557320D06FB1C0A5DA3EB4E0A29557039A570B0AA3A1A5DBC73CD2EDF4FFEB52EDF43D29DCA13D31D2976923D2976F7ED411DBBD30B0DC1EBEB46DE3BD3C20EB9EBEF4A57B6698EC45B777B50C0706A4DA71E9F8D35D71FC3F9D66C3948863B0E94BB76AE738E3D29CA06EC6718A715CF7A130E521DB8EFCD331E871CF1523673922AB5EDF476516F908CF65EE4FB54F31129460AF27644B248B17CC5B1FD7E9EF58FABF8A6CF4740D705F6671945C807D0FA579F78BBC6C6EBCC11CB149BB8C282C571DBDBEB5C1CDAA5D4C30F2B6DCF0A4E6AB98F91C6678A9B71A2AE7BBE93E34D2358597CABA08D18DC564E0E3DBD6A96B7A959EAD642EAC6657BBB1FDF85E8769E0823E9FCABC37CD64656CB061C835AFA7F8AAEECF531745F2CC9E5487FBCB8C734732E879CB3D9CE3ECEAC4F53D07508B50B4F2118493C79217F8510F208EC38239393C52DE68A1AC6EAF5F33CB2C6618158656353D4807A1EBC9F4AF27B7F105CE9F237D9A6709BB2003D57D3E95E91E23F187DB743863B252F2DC4796553CF4048F600673F4FAE2F7573A70D8EA55A9494F789E59A95A8B4D46EE0918B185D9031E73CE3156BC37AD7F626A4B2C9189ADE41B268C8FBCA7BD66191A6959D8F2C7279A3AD629EA7C7FB571A9CF1EF73E83F0FBAFD91445279B01198D89CFCA7B8FA77AD7D9EBC57947C2CF1208263A65CBE236F9A2663D09EAB5EB3FA8F6AD8FD3B2EC4AC5508C968C66DF4EF4DDA323BD4BB72BE8DEF46DC7D3B5173D4E52065C1CF7A42BDBBD4FB0FA53197AF4A9279590E33C118F6A6ECE454BD714A548E69F313CA42D1F240E94C2B8E7DEA7DBD3231EB4D299E4D3B89C4858700668F6A9197E6A194714CCF94AFB47A7D29196A6D94DDBEBC502E522DB8E94D39E2A765EA39A61519C5026AC44CBCE48A66D2A338A9E45E9DC63AD30AF518E6991622C719EB415FCAA5DBB7E9EB4DA5717295F68FAD1CEEC74A91BE94953762B116077A6B29EB52B2E69197E5EDF854DC9B10ED1B8F149826A5651DB8A42B9E94EE268880FC4D36A52BCE68C67A74A7CC4B441B7F0A1BEEE6A42A381DE9BB73EF4EE67622E7EB4D2BDBDEA5E3D29BB4F4A2E2B116CFE74607A549EF4DEBEDCD02B0CC77A8D978F7A9B6D3597D0E2A1B248CAF1EF4D6518A91BAE69A68D0445B69BB719A9719A4DB8E6912EC43B7F9D26D1EB52D35940ED419B443B71437FF00AE9FB7A8A4C5040C6E299B6A4DBD68614F425A21C139CD378FA54B4CA2E4586F1519CF352F1EB4D63ED8A443442C0D262A5607D31517AD04388DDBDE929E47D334CE7BD066D0DDBD79A297F0A295CCEC74EA3DBF4A55049FAD3F6F4EC7D28C555CF5D0D55A7039EA2954161C0A76DC76C51729098E98E29714EDBF95295E9C7EB45CA1147BD2D397BFAD2FB668B8EC201DA936FA734EE318EF4EDBB68D0A117DFAD1D7B6297DE9F8DC300F148AB0DDA69FF85285A5E7BF140D2136F4F5A31BBA8FD694A8E314E0BD282EC357B9A551B69CABF3673C52AAD05584DBD81A39FAD3F605E01A17919A07611471934EC67041E6957E6FCA9FB7A83415D2C370453B1C64F1405E01A77A63F1A0A03C7CB4AB4719C1A9368EDCD2B96463A74A5C7CA4669EAA7D29587191D68B808ABD28E770E29DEC0E69D83D682AC31572A01A5C7FFAAA4C75346D345CAB0CDA78F4A76CEC7834E29DBA53B6532AC317AF5C53B6E450A0EDE98C53B69DC0645034371919E801A30475A936FB520EE3206280E5626DEB934BF852EDC3E7AD28EF4806907E828DBF8D49B72A771A36EDE3345C3958C55F7C51ED4FC1E79FD29DF87F2A0A447E5FCD9EA69DB718EDF5A71195E983FA503EEF5C9FA5172AC1E5F42297677ED4EE0F7C518C739A43E51810E734EDA70381EF4EDBC7A0CD2AE1BBF269DCA48671E9C669D82734A30383CD3C2FAF2695C761AAB8E7AE682A3FBD9A7AAF5CE4934BB473ED557158685E83DE976F6CD2E71EFCD3B60DA3B522EC34A86E9EF48474C8FD69CABE9FE79A5D9B4818CD2B82117952294027A0E2942A853EF4A176E4E78CF1549956136F463D69768C7534A41C7269428C7079F4A2E3B0DDA780680BB7B5483E6EA7AD26DEC38A572ADA8CC6DC7AD2AAFCD9A76307AD39547AF140AC47F414053F8549B7774ED42A8C119A571D86ED19FAD1B7DF1CD498149B4FF7A8B97619C96FA53F6F63D68FBDC81460F20E28B8B4B8DF4F4A1467FC29DB7AE6948DA79A2E046DCF418A4DDEF4E2A7A018A6B2EDEF43958635B3CE3AD0ABF9FAD0D9E4E3147DDCD473084A5F6C7E74ABD3F0A067EBF4E29DC04F7C52E09208E477A5CF4CF1934EC1E45302265A6E0AE3B8A9F6E79ED4DE8A38CD20B10ED6C67348A463078FC2A5E3919A6B29DBF28A2E2B5C66D3D734D6C73C60D48F8CF4A637048CE69732131BB73D81FAD27183E94EFAF4EDEF48633EB4B985CA33D00EBDE971C920E6947CA31D2938C7A1A3989B09B71EE297F9D2F3B8E33F434719F7FE74EE16136E704D3B6EE030B83FA52A9CF38C53949E87A7B53B9431BE83F0A72AF1C0A71C64F6A141E4FAF7A2E4D83F8691727B5397BE0678A400371CE31C7BD51A585DBCF03F4A438C0FE75285DA3D299D083FD28B872B11B3F87D282BF28239A53D79CE29F81C0C7E54AE55884AEDA86695618D99D96303AB31C5586CFA7FF5AB97F16346B1AAC9999B92B0F63EE7DBF5FA774B5673D69FB1873A33FC49F102DECECE6362566653B3CE7388F77A0F535E37AD6B97DACDC34B7570D29EC031E2B47C497325D5F32BBFC91FF08E07A6303B573CD966CF5A67E5F9963EAE226E327A2FB83D38FD29D1B2AC819937AA91914DA9FCE3FD9E2311E02B9DCE3B9ED9FC01FD683C38EF72C4DB2FCB4A80EEC711A8FBA3D0D53685E35F9863B9E3B75CD25BDC496D2078CE08AD086E45FC92B48A649DF01638F80001814CD74A9BEE6674FA5692EA463D2FCA8982CC7E473DF6753F9F03F0AA33426DE468DB190699D338A1364464E9C9DBA852D149DC0A46669E85BBED88C8C2394302ADE87D2BDEBC3F70F79A746F227972FDD75FF6871C57836930886FE3F34E22247CFDBDBF3AF79F0C5CA5C69602925A33B0E4608C0E33EF83D6B45B1F6DC3FA4A4AE6A6DF5A4DBF2FB549C6D23FA51B7DEA6E7DCEA45B7D290AE73C7E953A823B669B8EB91839A77D09B106D1B79F5A691E8726A77500019CE7DE9ACB40B948B6FCA7FC6A3E7F1A9F6FA8C0A6EDC373C7F5A64D88596936E7DEA6651CFF009C5359719EC33DA8B91621DBD29368EDCD4FE5F527815195C63DE8B8B948BEF2FBD23293EF5291D4E29980723BD1727948C81D4535875ED5295C723EB48C3E6A2E271212085E79151EDCD4EDE9DE998C633CF6A465CAC85C75E6A3AB2C02F351B6076340AC447E949F88A795FE74D60291161AABC7BD1D28C1EB8A3B7B53019D7DA9B9E718E295BEB9A4FAD2204C7E7EF4C603918A7EE3D7AD26EE72453BA20636D34C3F2B54B4D028B8588F6F7CF229BB777038F5A7E3BF4A0E07D297319D88CFD69AC071521C3640EB51B0DBEF45C4329A47AD3FEBC526339C722993618719F5A4DA734FC7A5376E78E94AE4D86718E94DE7BF5A7B6693939A08B11FF0D26D14EC535BE9CD04D84F5A6374CD49907D8535875C738A2E2688F68A632FA5494DC7E145CCAC30F4E3AD35BDF8A919474A632FE545C8688B9DD48C3D0548D90734DDD45C823DBF37E19A63D4DB4547B68B99B447B4F6A29DB4F6E94549363ABEDEB4053F539A50B91EB4BCF506ACF56C228AF4AFD9DFC0BA67C4AF8C5A078735A491F4CBDFB409561728DF25BCAEB823FDA55AF385C7AE6BD9FF0063DF93F68BF081F7BBFF00D249AB8F19270C35492766A2FF0020926A2DA3EA0FF8631F86B0DDC96D2D8DEB9438DCB7B27391915F9F6CA158E07435FADD3DC0935CB92A723728FC9457E5A7C46F0CC1E0EF1F788743B695E7B7D3EFA6B68E4931B9955C804E3BE2BE338631D571356BD3AD372B5AD777D2EEFF00A0A95DFC4738B8F4C734BB4FA0A7AAE391CD0A016E78AFBE37B0981EBF9D0BC672314FD99EDC52EDC719A076136D2814FE5BA50065A99A25D46EDE45285A7A8E334A17A60E7D682AC263DA8A936EEE471CD1B4F6A8E61D8681D38C50B4E09F352EDDDDB0299690DEBC11834BB36D3F079E3BD38503B6A47B7D8669E17818E29DB7FBBC9A5DA3AE39CD32944451C6064D3D78E0D26DF4A7AE09CF7A901BB7D79A76DF9734EDBD3F9D2050DDFAF5A0D2C1B7E63E9ED4E1E87BD3D547D69A06ECE681A4228E3918A78193E8285F7C5285CD22921BB4EEE94FEB8E2976FE06976E3048CD21D8450775398039C53B1D3D68C6EEA38F5A65D846F6E69540C818CF39A538F4CD3B6F719CFE540EC336003914EFE20339A701C904E2978A02C3157E5FC697F0A76DE9F5A5DA71C7340586E00F97A9A503DA9CA85411DA936F5E7028B8F946ED1DA8DBFECE2A451D88C528E9D39CFA51A15CA317DBD6976FDEC738E94F651F853BFBBE9F4A2E3B11ECC75C74E3DE976FDE20539876C134AAA581E39F6A9B9562355C9E066942F6C76ED52AAF20F5FD297B7079C50162355CFB0CF7A72AED39C669DB76E29C3E5E07A555C7619DB2075A5503AE38F4A7F4ED8A02F4A571D86EDFE79A4DA7AE3352FA0C5285193DB8A07CAC8D14AAE452EDE87B53D5718EFDA9DB790698EC31533D450AB9A7853BBA629766DE7F3A0AB11AA8073DE9403F4A90F2334A1095CE31C52B8EC46ABC53B9EA4714E0B9C9E01A0AFCD93D7D281D866334AA0F6C0A7ED008EA052AAEEE945CAB0CDBC0FF0067AD2E0F6EB4E208FA83D28CF7C60D3B8EC30A1E00FD6931EA315263B91CD26D14C2C33A1E286F619352347F2FB7D6976FCDCF159DC7621C7FF5E9C318C0E94EDBEBEB498FC68B8586B77E3F2A6B021AA5607AF4148CBBB9A4DDC5CA5729EFC52E073C54AD1F381D29BC7E159DD8AC208FD295578FEB4EC0FC338A76C3926AAE5588F19EF8A76DCE31C0A784CF5ED4BB0B631C7F934EEC7CA45B4E0F149B7AF7353141DB349B3818E94C394AFB7767149B7E50318E3153326339E948DED4AE4E9D0836E3A7349B73DB8F5A931D3B52B2E30474A862E520C718A46FBBEF8E2A5652AB4D64C83FA521588B6918A186D39EBE95211F30C9C8CD348E7039A5A8588C0C6334BE5F6079FA539978CF26950763C53E61586ED3EBCD3D41F5C52E0F1ED48334730EC18C30C0CD3D47B673519057A669EBF787A53B8728E5F940F7A1010B8F5A146003D0FBD2718207A7BD5F30EC49CF19149827D3F0347F1D285E3D4D0E43B0CDA7D29D834E55071FE346D1D314AEC6911B29E7BF39AE1FC6137D8A29266E49E154F56624E07F5FA035DEE3F13DC579B7C42B9F216E279C74CC56B0F73C7CF21FE5F871D4D545EA79599BE5A0D9E5D791830C97339DA6440573FC477678FD7F2AC4AD47865BEDD2C9FBD58A3E303E518C8C7F33F406A80B77308931C31C0AD4FC92B272B3B68C88D4CD78FF0064FB2A95F277873C7248CE3F99FCEA3893CE9913B938FC7D2896331CCD18F98A315CFAE2839D7324DA1BD29F1CAF0C8AF19C30E41A60A28207C9234AD97393F4A6D252FAD00DB7B89EB4507BD4D716B2DA842CBF2BAEE561D08340ECED7446199BAB1001C8E6BD83E0EEACF7D677B6F23F98F19461BBA918C7F4AF1C5FAE2BB6F853746DFC551E1BE5923DACA3DFA1FCF1F9D52DCF6729AEE8E2A0EFB9EE78F5E291805E73C54823F5A431EDFCAA4FD67948D41A52A704E3269E576F3EB4E550A7D0E2985880AFCA48273D29ACA493C7153952FD3D7351E3AE7A53B93622C7B62938EC2A423B8E98A439FE9489B111EDC74A610718E953107391CF7A8DB9C738F5A2E2B11F4C0279A6C9F373CFE14FDB86348C31D295C8645DFA73498EBC629DB7F3A56E947311623C1FD314DDBDEA565C2F5E69BEFE945C4D1132F5E29AC3DAA461DBA53777BD55C86465475ED4C65E8318352632A69A170D8ED53726DA9163D0639CD44CA31563686ED513636F4A643445B7BD35B352903B536B2B93D085B96CE293FCF352B7DEE94CDBF952E622C47C77E2936E6A5F6A6F7C53BB1584FD69B82BEFCD3CFB8C53771F4A2E2B0CC739C7069A47CBCAD4B8FC3D69AD9EFCF34EE4588B6F514DDB52F6C629BD304F5A2E4F290ED07B739A4FE1A976F5CD47B70734C81BB7F2A6EEF514FC0C526DA107291B639E293F8A9FC71C53597D2973116233D7819A43D41A93B669BEBCD1CC4586B2D478EF52918FAD376EDFAD3E61588B68F4E6936F5EF4F239CD1CD2B93644383DC5371C7AD4ACB49557326885876A6EDF6A976FB546CA3D6923271D46537A7B9A7B0A4DBD0D0C9688C7145388F7A2811D528FC45397AFF8D3B6E7BE280BD0F6AA3D4B08B1D6AF85BC4DAA7833C4165ADE8B76F63A959BEF867500952410460F04104820F504D66AAFE15E84DA7E89A7FC12D2BC49A9786B4D3A5CBE1AD5750D4FC451EB131D5AD6F23BCB8B6B231D8ADCE1A16956DA26736FB079873229E41351F66DC95D76EFA376F9DADE6EC8E4C4622186E5E75F13B1475AF8C5E34D6B5CBFD48F89355B27BC9DE7682CEFA68E28CB313B514370A33803D2B93BCBCB9D4AF27BABB9E4BAB9998BC934CE5DDD8F25998F249F535D8F8ABC1F61A8C1F0BFFE1178CD9CFAD697A55B6B5E74CF225B5E5C584579F6B72C4EC8DE379CF651F659700015B1E225F0549F10358D33C07E1BB3F106A977A6685A9E83E17F116AD736C2F6CEEAD04970F0C893C464BBDED0E21F3390EE238DC801728D1A741B8C22959F2E8BB7FC0D7D35E8CE459A61DC6328A7AAE6F96DFD7FC157F32EFCF1498FC78A874F6792394C914D6E56575F22E0E648F071B5B81C8E8781D3A0AB5B73DB1C62A94AEAE7B6ACD5C40BBBB53B071EFE94BB4FA528CFA7157745AB0D404539BAD3B1ED4A1703D695C696835578CF5A773D40CD3BB74FCA9CAA3A76A2E5D86EDE869C06D5E29C7A62936FCB5172AC263A1EF4B834FDB4AA07714EE69CA26DA36E3A0CD49B7D39A369E3B0A570B0D58C73DA9793D3A53FEEE39C52AAE063F953E61D8695DDC0A0FDE029EA0F34E61F30E282AC376E7DA81EA79A936FBD2E318E30682AC3719F6A3676C77A705EA09C53FAE7B5069623DBE82976F239A91415E9CD3957AEE1482C463A67BD3B6EDC7734F0BD7B8A5FBCDF4A9B8F948F07A53B0171CE29DF7B18A7607A714CA1807A7AD39412D9A54C8EA29C176F079141562361D4F4FA53C0CB60F04539B3DA80A3B8A6161B8C63BD2EDE79E0D380C0DA694027A73482C2754EFF00A50ABD78A7EDFD69DB69DCAB1170AA3B9A5DADB73EF526DE9DBEB47B638CD20B0C1F2D3B6FCA003CD3F6FE942FD29DF51F2B23C134E55C2E0F1F4A9319E718A40A4A91D2A2E3E5136EEC0278A4EBC74A93683D3E6F4A0A82450E45586283DB9A705FA539569CABE8334B98761A003DF1471B8F18A76DE9814A543373D6AAE3B0C1CF078A538F4E6A465229001BBA517294589B4350ABDFA549F77E868DA4F38C51CC3B0C5534EDA07A93F5A76D39A5DBCE473F851CC031547E342A8030381DBDE9FB71CD2ED1CD55CBB0CDB95E3934A0638A9154F7E98A197E6F7CF5A4D8586609F6A5DBF8549B4F19E4FB50A0F14AE3B111C9EDF951B7273822A6DBC633DE9369F4C9CF4A0BE523E9DB3477F4A9594AE4F6FA51E5F38C7145D8729198F7714DD9DFB9A995707FCE6865F4E953CC1620D84F4A7050781D6A50BB738E69197F2AAB8EC41B0FF160526DDB8C5586519E4669BE5E1B8CE3351A8AC4417AE7939A31ED532C7B5BF1A31DF19A91D887CB1823A73914FEFCE0D3B6F00F19A51EDD6A85623DBDFA003B53FF004A0719CD1E99A076115B3DA9BB46DC714FF5FAD054ECC6DFCAAB990EC42C032F4C7E34DDA39EF52B0ED8E69BB73C7EBEB50D93CA44CA7AE3A5254ADDF8A632E3B7151CC1CA3597814D61B471FAD4BCF5EF8EF4D3B9719E734730B9485811C81DE9ACBD7839F4A9F19FAE734853DB1F8D4DC56443B557A74FA52EDE3152B2EECF6A558CB1E9420E520DBF951B78153EC39C76A7AC7EDC0A457295B69CE0714BE59DB53ED3D48C539549C7A51A8F94AFB79240A5552DD0F3DF3563676C71EB49B493E95488E5647B474C5001247A1A97FCF348BE9545728DF2C703146DF978EBEF4E6CF18E68DDD38E3D69DCAB0CDA30735E31F17B507B8F125BE9F11E634F9B1FED638FC867F1AF679A458219246FBA8093F41DEBC96C7C3D71AE6B926A374987999A50ADD9430E3F2FE55A2691F3B9C4675692A305BB2958F8756CFC1ED2103CCB9817CBFF00BE1989FC815FF81543AE7847EC3A7DAEC8F6848D558919F9B6E6BD361F0CEDD2E3B53F7A15641FEEEEE0FE55675CD212F2D4C7B40046081D7A70694A4FA1C6F288CA8EAB5B1F38E93632C9AB45128F9F242E4756AD0F126867498D3791BB1827D48C64FD33C575F0E9BA7F86F5882F7509E3811096C1249E87B6327923F2AE57C6FE29B6F115E9FB2230B65601198632003CFAF535A272B9F19570D4B0D424A72F7AE731D07E946E18E3E94F6919B6741B4D3A4B594336579EA7F0AD0F07908BF0A5A414B41985747A5599D574708BF3BC2DC2FA8EEB5CE56E7843558F49BEDD36F68DBF8235DC4927A0A67661651551467B3DCC89AD8C57524206707001EBD78AD8F0CCC747F125A4AAD911BA87C742A48191FA1A8354905D6B52BC913598DF9224EA3EB8AD1F0DD88D47C510423EECACE3F25C8FE4283A295351AEB93B9F4347D3201C75A3A0C63269F12EC545CE46DC669DC86C66A398FD8E2B44D9115EA4D1B7AF6A9154E33D4D211C71CD0558663A1079F7A6EDEB9E6A5C1CE7BD308F9B8E99E69DC394899406A615C63771DEA77E299C7A54DC8E52131FCBD7F4A6B28E6A6E793D298DEC334DB135A10B28E08F4A63019C77A9D9772E699B7A52B99D910ECEA39A465E054BB7A8EB8A46EFD86695C5621DA72463E98A637A8E054CDEC298C196A798868888254E69ACBB6A53F7BB629BFCA8E615884B64E7BD2673C62A465E94D61E9C7D69DCCEC42CBDA9ACBDAA66E8477A677C51721A202BD71934CC71D6AC15CE69BB7D0719A572794AFEF8CD2377E6A665DAD4C65CD491623DBD734DDBD4FE5536DA8D97A76A64D866DED405EE3934EC751D690AE38A6161ADDBB520E3AD3F6E3B63F1A4C73CD1733B111EBD314B8C714F39DBEB4DFC680B6962261C534A8152E3D691877A2E4B890326DA465C7D2A6200EB4C6F9860714C822C53596A4C7E74D65EB8E695C9B11B2D3306A623764D33B6714C9B21840DD4C60578A976F39A6B2F3ED413623E3D3349B4F352639A42BD706822C44D91EF4C6A9B1C93DAA3DB9ED918A08688CFB1A630A9980FA546CBDE9EA652891E29AD93802A4DBE94D6E735466D0CC1A297693DF145233B1D7B2FE346DFF1A5DBB69401BBF0C507B1618B9ED55A1D535EB7BFF0E482CF4BBBB3D074BBED1E3B1BA491A1BFB4BB9269268EE54480B02D3B60A94236A11865DD575475E29CABB793F4A57BAB3DBFE035F936BE6615B0D4F1092A8AF63287887C722D75A821B8B1B18B57F0D59F85AE628622C05ADB42B047226F66DB3184491971FC33CA001BB8BDA3F88353B2D734FD5353F067857C457DA6D9E9767A75C6A0B76AD6A2C6158A171E55CA6F2422332C9BD0B2F080120DADBD39A50B9AAE777BF5DFF37F9B7F79CAB2AC3256E5F2F9592B7DC92F915AD9AF6E1AEAEB52B9379A8DDCF25D5CDC3000C92C8C59D88000E4927818E6AC6DE9DE97E94FDBEBC542B45591EAC636561BB78140E84549B7B52AAF5239A0D6C3173E9CD2E0FA5397DB9A76CF6EF4F40B098A55518C74A7282DD695578E3AD2290D55E78A5DBD29D8DD8ED4EDBC6682AC37D314EDBD3B53B695A51C638A0BB09B79033C53B1F2D18C1E79A7FF000FE341490DDA79E3347A9A7F38E94EFE13C6295D17CA336FB52EDCF34E51DFB1E94E0BFE7340EC20C6D39A5C7F3A52BBB19FD29CB9E78A2E035546D3C52EDFC29C8A49CD26D1EBCD172D4589B4D48A370346DEE06714EDBC7BD218D0BBB827F0A02E7A8C53C67A118A728C54DCA18CBFA53979E29DB7A74A5541D73C5172F946D183F5A705EF4BF757A77AAB9361AAB9F73408CF18E45491AE79EF9A763E63804F14AE5D889BE9CD28181C0ED4F0BF371CD2ED639E3F2A62B06D1C8CF38EB4A1453B6FAAE3F1A5F63C1A772D2198A45E9C8E3D2A4DA54F228C0EBDA97321F2EA3719E9C11EB46D5A931CE4D1B06DEBC7AD2B8EC336F4EDEF4FFA8C669DB7E61C7E54A3B73D282AC47B46DFF0A157774E2A4E17191C52EDC74A43E51A17D050171C014F2BF9638A5DBD393F8522B9467A0C52ED1C1EFF00CA9F82CBC71CD057F1CD03E518147734B81C714E550DD7D29DB7A1A02C3028031D29554F56E4549E581DB34BFC3C74A63B0CDBDFD29557B54981F4E69A07CD9CF3E945C3419C9E719A72A03EA29FB7BE7BD3F86EF45CAE518A372F4A193B8A706E98E7F1A5C02C7DA82EC336EEF6A509F853874EB8A5C06145C761BB070406FCE8DBFCE9CBECB8A5C77A9E601A31EB48141C1EB4E5FBBDBDFDA9318EB473009B4F1C53B603F4A76D1DCE00E69C149CFA505591115143271ED536D2D9FF001A197DEAAE572912A865E7FF00AF49E58EB9FE752E39A0E7B734B990AC43B7183FCAA3D986FC2ACED07201E698C8319CF7C567261CAC8B6F6029BB7771D6A7F2C81CF14CDA0E38C52159919F9BA7A52138C83CFD2A42B9A0AFE0295C2C47F4CF5A46F6E9DE9FB70793CD3B6E79EB934AE3B10B7B0CD26DC3F5E2A6DA76E7FA51E5E73C138A2EC39595F6E73FE34EDBB860F152AAE0F228651BBDB145C5CA41B390D49B4F353EDEDC1A4DBD73C52158AECA3A1E4F4A4DBD4D59DBF2F4E734853D0520E52054C8E9934BB47E3E95379678F534BE5FCBEF543E52358FAD4BE580BEE7A8A72AFCB4EC1607F955685289015DB9E338A368DA70302A6F2CB13DF1EB4C6FBBD315371586951BB39A6ED1CD3BF880CE6823A76E281591195E873F9F342A67D8D3FD39A5A770B0D68C6D1FAD35A3E9C54A1B3C1EF4311B4E4555C2C5796DC4D1B46C7E523040A861B186DF0020CE31D3B55ACF24F4C561F8B3C5D63E11D3CDCDD3E646044512FDE90F6C7B7A9A16BB1CD5A74E8C5D4A8EC916F5CD72C7C3BA73DE5F5C2C10AF1F3756F603A9FF003F5AF21F17FC68B9BC46834556B688FDEB9939908F61D07E35C5F89FC5BA878BB5037174D85CED8A14276C633DBFC6B26EA3F2E62BFDDE3F535D718A47E6D98E7D5ABB70C3FBB1FC449E49EEEE0C92BBCB237259CE49FC69D05BCB22C9288CBAC6BBDF23A0276E7F3229B246EAA83BB0C7A75FFF00557416F629F649016084848881FC5D4FEA42553D0F98A74DD4936F7322C6C4DCDD088633C63F3EB5A7A8AC765624B9559DF2A1777CDE8C319ABD6362233633C8CA04A1D48E9B41CF7FA83FA554F1678822D42436F6A15EDFCCF33CDC752579C7E348ECF670A549CA5F11CE2F4A5A28AA3C50A96CE133DD44AAFB189CAB5455A3E1FD29F57D4E0B78C91B9B1907A67BD335A71729A8A5734B54B165D39A598E6E1DB91C9C007D4D62697AB5D68B7F05DDA3849A23B973C8E98AE9BC4569369E5E1493ED36EEFE5AAB105C63AFE9C7E35CB4F12AA828416CF200C632073493EC77E2A2E9CFDDD1A3DCFC15F142CBC49B2D6EC2D9EA0470AC7E493FDD3FD2BBAC0CE79AF9313746DB94946072083820FAFD6BD77E1BFC4EFB418F4BD5E4FDE02162B86E8DFEC9F7F7A528DD687D76559EB9C950C568FA3FF33D5D7180071ED499F9B205039E9F87F4A3A75E9ED585DA3EE56A27238C679A68CF3E86976EDA4077633D28E643B0CEFC714D3F953DF19E0534AE7BD2B8B9469E4FE14C651C771527DEE9D28C0EE71426434458DD9E698C3F0353F5F6A6B2F7E2813895F1F850CA0E79FC29C7D871EF4841EFD5A973226C4440C038C6299B7DB1C54C467927F4A68CFE3410C848C0FBB4D653D335315CAD336E7D8D04B444CA7A0E698DEDCD4CDEF4D34B988E521A6B2FCDD306A4C0F4A4FBF9FE947309A22C1E7B534FA7E95330EBC546DF4A2E45885BD47AD26DE7E95215C5376F4E94C9688994A8C6720533EF735332FE348C3D31D695CCDC480FD78A52B91EF526DF5A69E29DC9E51ACB95E0534A9E79CD4BCED3C629BB7D78A62688F1F85215F7A7D237BF14AE411B2FAF3F4A63024E3B54DB401E94D6154042FEF4DC7B54CCBF9537155725A212307F1A6EDE6A461EF9A4C7CDD6A49E5236E39EB4DDBC60722A465F97FC69B83419B431B03B629ADD0D484751D693E5A6472B21C7E548CA2A4DBD076A6B2F7A64D8676F5A6D3DBB5348EBED45C968898533D0D4CCA1BDAA36038C714AE66D11F4E7B53768A7B2D211DA8326885A8A7F228AAB93CA75FB7B138A5029DB718ED4AA3B66A6E7A960FE2E076A08FC29CABEBC76A72AF39ED545728D00719A5E73EB4F083D3BD3B6F7A45D86EDF6A50BF852E29EA3D39A2E5A427B819A4FE5DE9DB7A7F2A7638E78A2E166336FE14E5FA53B6E4D3870A33C5172EC330581E29547CB4EDBC67B52AE3A0E79A8B8F946F39A76CFCF14FF002F81428CF3D68B95CAC4DBD3D29DC9C1E9FCE9DB7F014ACBF9522EC3769CD3B6F3C52E0FE34AAA37629731426DF4E69C176EEA5FA53F6F19C522AC30753C74F4A366DE48A957AE7B52EDE6915619B475C52EDE69FB4E074229557209F4A771D90D65C83C52E0FA5382E7A8A72A9FCE8BB2B946EDEF4AA39C93CD3DBFC8A5DA7F4A2E52434276A5DA718ED4EDBD474A5C7CD8E28B9561BEA7F3E29CABF374C8A551963CFE54FDBD38FD68B95623DBC834EDBF87EB4EC7B714A08EDD7E9482C31576E31CD2EDE33FA53F69E3E5CF146DF97078A0633B03DE9E3E6EF8142A8EE0E29FD7B53B8586ED1B7D39A5DA38A7ECDCD432ED5FE545CB5118B8EA4D281DF1C7BD2ED39008A7051C679A43B0DC7E42976F20FB53F865040A3040C75A2E3B0CD98EA71CD1B6A4C0346DEF8A9BB1D860CEE1E98A5F61C53C2E7DB8C52AF618CF340EC357BFAE29D8E9DFE94AAB9E8314FDA7763EED03B1160F04703BD2AA9F4EB4FDBBBA8C03DE85058F031414263DB9A711C0E39A52A4F4A4C7D7F0A770171E873405EEC3814FE78C0E3D6971955F4C629DCAB11E077E685F718A7EDF4E79A5DB839A570B06DEA00E6970198E0629C46DC6462863E839EF4F42D21B839CE79F6A4F5E39A931E868DB523E523E5B20F1CD03E5E83F0A93693D064531B3D08C54DC560DBEBD7DA979DBE94AAA314F2BB941A2E5588D72A3A7E34A177AF4E7EB4FD9B5B8E69DE59DDFFD6A2E5D88C71D474E29CB823038A5DA0F1EF4B1AE54B743DE8B8AC371D73DE97900FF005A7AA16504FE1432155F5A7A8EC4783F4A4C0FC2A5DBF2E690A631C531A447B719C7EB46CEE4E69FDC0C6451C6D1C62A2E2B11329E98A4E0D49C52796383D28E62B948769EC2908C640A947CBC752052EDF9B247159F30AC4217007AE3A53B69DDE9EB52F97DC7738A194F19E79E29A0B116D2063AD3CA9A9554F4ED4BB3E5C62A8762B95DB9C0ED48C8558F1D6AD6DA632F3C75A039742B6C19C8EB48D1D5865CF6C9F6A66D1839A57D6C2B2216519E39A36EDE6A665F941C734D65DDC91C51A0F948F6E79C60D3B6E79A91BE98A36FA71487623DBC629F80DCE2851CE7A53DB68F6CFBD3B9245CE083C67AD46CB9C54CC3A547D6A64C6E246C0B371D29AC0F152E0B2D232939C7353CC2E522EBDB9A39DB52797CE7AD0CA3803F1A63E51993E98A565F9714AD505CCEB6F6EF248E1234059998F403AE7DA9F3132B4536FA195E27F125A785B4A96F6EDF08A3E441D646EC07B9FE55F36F893C4979E28D466BDBB7C96C2A2FF0C607F08F415A9F10FC69278BF5A79232CBA7C2764099EBEAE7DEB0BEC7E669F1B8E1A46E99EBCE3FA7EB5E8528F2AD4FC8F39CCA58EAAE953F817E24DA3591B8D42D236E436D3F867FC2AEBE93F6879A44E9F31191D71B5063FE04C7FEF9ADCD234B78753B9660A12CE07DDCF3B910A9FF00C7ABA1F0E683BEDE2DEA08DD046CC7B65BCD7FCB9A7291CF86C039C545AFE91C90F0DC8971631483CC769655638FE18C803F50D5B375A347A4E956935CB2C606660F8E01DA1973F97EB5D169FA488E64B9B993CB863B39E42CDD016DB927F335E75E2FF1549E29BD58E23B2CA0F9624FEFE17193F5A94F999D95E952C0D3BBF89EDF8091CC7C4929B667F22DCCBB917030013C93593AD491BEA32AC2A1628CEC451C002ADDAC6D6F68EF22941B372B2FAE7A7E63F9D62B3166249C9AD7C8F9CAF51CA0B9B762D14515479C15D17C3FD4A1D2FC471B4D855910C4AC7A073D0FE26B9DA75BECFB445BF84DC0123B7BD06D46A3A552335BA3B1D63E6BE70BC053B17F00598FD795AE4AF59BED0C49E9C63AF02BAC1BDB4B9839533424C4C493C9249DDEC30AA3F1AE4AEA231CC57A7A67BFBFD2A51E9631F3FBFDC924B53242B7118CA9CEE03B118CFE1C8EB550F18209C8E47352DBDC3DB87DA7E49176BAFAD24DB3CC3B3943CAFF008559E64ACD26BA1EC9F0C7E242EA51C5A56A528178A36C3339C0907607DEBD2FF87D3B73D7EB5F272C8D0C892212AEA772B0F5F5AF7EF877E3987C4FA5A432BECBF8170EADFC7EE3F1ED58548E9CC8FD0B21CD7DA2FAB577AF47DFC8ECBF0EB49EFC51BB38F5A3A8E9839AE53EE2DD869F969A7E5EB4F3CA8CF5A42BB8E695C4307DDA5EB4B8E0F1C50DF749A6A44DB5B0D6ED51E7E6E95276E9DE9A7B9E9F8D315867AE700FA530934FC1071C119E691BEE9E99A5722C4446DC163CD273D79A9597BE79A8F69C7E94C561ADD0F14C6EA3DEA56EA4D31871D2AAE89B11B53300F1DEA5D84F23914CDA7D08CD2B99B8B22E29B83C9A9B68C7A531B18268B8588B8A632F43ED53EDEBDA9B8FF228B90D10367D29BB7AD4ADC526D3F8D2B9043F5E94DE3FC8A98F3D714DC107A669DC9B11D338DD8C54CDEC290AF39C5327948B68F5A4C76FE2A9B6F6C53597A628138E9621A6B28E9D0D4C7D31CD3768271D7F0A7733B11EDC7BD35A3A95BE5C71F9D31BE6FF00EB52BB22C44C29ACBB549EA2A6DBEA39A632F1D78AAB8322653F85371D29F8F97AD2607BD55C8B119F4229181DDD2A43D39E29AC33922A6E4B198ED4C3F2FD6A5DBD7BD37677355726C44CBB79A691EB52B7EB4D6C6319E295C8688597B53580E7DAA46CD35BBF14EE67622A6E02F4A976FE151B2D1725A226CB669AC3E5E29FC8CFAD27D78A2E65623A2976D14AE6676817F3EC28C05C7BD3D71C719A771E9547AF618AB8F7AD8F0BF856FF00C61AC47A6E9A8925DBAB32ABB8518032793597B093CE2BD1FF0067D91EDFE2758C80E0AC52107F0A47362EB4A8509D58EE9049FB3EF8D218D99AC2000727FD253FC6B8BD63C37A968723ADED9CB02AC8D1798C876161D406E86BEE5BFBAF324646D81C8DD19561C83D8FE15E39FB4AE83A1E9BF0FF00C3B7BA5CF746F6F2FE4FB5C3718C2C8A84B6DC7F0FCCBD6BAE9C68B84DD4934D2D34DDF99F2D85CE3175B134E97226A4F5E965DCF9B36FCDD38A5DA79C53D57D4669C32B9AE4B9F73CA3768E79A4EE78C53F04F1DFE94FDB9A45729195E3AF14EDBF928A7F1E9C52E39C54DC7CAC6EDE734B8EBC53FA311FA52853B73DB348BB0DDA31D7A77A5D9D29DD0FAFE14BB4F4C76A7A0C67BD3BA9C01C5395734F45F98F6A43B118FBC78A784E41C64FA5382FA53CAF2323348D14467F0F03269DE83BD3F69FAF34BB4F23A5172F948D576B73D29CDC0C74A7AAFCB4B8F5A2E3B0C55F9467A814F50381DC539475FCA8DB45CAE5117EF1FF001A7018CFD2955064FAD3B6F1487664650B74C7069768E2A5DBF2D27F9E95372F94685E0E69FB406E94A3E6CF19A785F97000FCE80E5235C632169FE99181F853B69E474A732F18E3F2A655867039EA68190C3BFD69CABDCD38E73FED501619B475CD0ABC9F5A936EDE4F34281CF3FA505728D0BD3B734B8E9C549B7774E69403C7008A076230B9E4D0BD3839FC29FB783ED4E5CAE49A0445B723AD28E3A629FB7D4669D81CD22AC3194E281FC5EA2A40A38C9A36819CF3415619CB633D69DB776403C77A78E79349B4E680B0D55CFBE69CBC7F4A5C605395718F5A2E5588F91818A5DBDF9A936F18F6A065B682690EC331F31F4F6A00209E9ED4FE704E38A40A70B9A02C22A1CF4C53FF008720D382B30008EDEB4BB70076C0A65590C5FAD07D08C035285DB85F5142AFAFFF005A95C2CC685DCA78E6942E723AD49B4FE19A5EE48E69DCBB116DDDC6734AA84E73526D1F5A4DD95C7AFA52B8C8F6F4CF14BB368E463F1A7F5E7B500755348761319E83146DE809EF4EC018E393D28D83AF7A05611541E87EB4AA3E5C0E694671D7F4A7283C7F8D2B943768DB91D68DA79C1EB4FE9F5A36FB7EB45CAD0628EC78F7A551D463934F55F9B3DE9DB7A76ED4C76183048069AABB97BFE75273FD69FC6EC11914AE047B33E829BB4E3F1E2A6F2CFD6938FBBF4ED45C0AECAC38E2855EDD768A9D946EC673F85023C7A7359EA32B843FAD18239C64FA55858FE5EB4BE5FBF34D87290AC65813F5A6E3D715682E39C6693CBDBEE290EC41B08FA7EB46DF94B7E62AC6CEFD851B7938E455858AEBD0803F3A785EE6A458F77E34ED9F292C29DC45723E507383498F9B38CD5865EC7934DDBD3EB5371D880A038C1A6E0743C0AB18C6D1DE9A54A9C90338A9E642B15D908346CE304E3153B2FCA31D28C7343657295F69C0EE7BD29507E9EC2A7DBDE99B48F6A02C47B7A8EB4EDBEF52739F4A3E9CD1CC162074F4A66CEB563CBE4FA5057DA80B15BCBA531E01F5A9FCBF6E69ACBCE4F350162068F68C535976F18A9CAFCDD691A3FF002680B15597E6FF000AF23F8D1E3275D9E1DB16FDF4B8372C3A818E107F3FCABD17C67E2287C27A0DCDFC986741B6243FC6E7A0FE7F80AF9C34D96E358D567BDB86696691CB349DC31C9FE9FA574D185DDD9F17C418F74A0B094DFBD2DFD0CF5D3A4998851BB6B053B7DFBD75CDE1B68E0B1B75506496410631D3223C9FFC78D6AF867C2334BA6C57654FEF2E7E5FC01233FA576B79E1F7FEDC88A8CAC6A5801D8E5B07FEF95ADDD549D8F9CC1E512941CDAD5D8C2D2F4B69B4ED4A69131F688366EEE7CD9031FD2BBAD1F468A2B48D48C664690807B905463F0C54B67A288ED844D8DBB40FC860573BF147C6DFF088E8696D6CDFF132BA52B1FAA2F76FF0F7FC6B9F99CDD91F5EA952CBE8BAF53EC9C07C57F164371A80D1AC24DB6F0A88EE2453F78E47CA3D863F135C6DA59A4F772D99F966E151BB16538C7E5FCAB2DA369164973B88C1663D7BD6FDA6C5D36D2F4FCAB112927A9E4B647E5FA8AEF4B951F9856C44F1D5E5567B74F4296A974F1DAA599E181CC8B8C107B8FCC03F89ACEB7B7370C540E7DCF4FF003C7E7525F5D4DA9DF4D752E19E6724E38E4F5FE957AC6CFCB821BC64DD03931315F5001FE46A96C70D9D6A8EDB232BD41E39A286FBE7EB4551C6D59D82994FA6B5025B9B7E1EBB335F4904B2612E130C5FA36074FC8E2AADF296BA79197B938F6FA7E154AD6736B750CB8DDB195B69EFEA2BB2BFD3966B5376704CDFBE3B460B0E800FA93F9544B467A9453C441C7AAFC8E3248CC68770C64F14DED566F7FD66DC7DD02AA83EB5679F515993DC4676C191F7BA7BF4AD4F07EBE3C39AE4174CBBE1DC048BED9EA3DFBD6446C64962563F2AB714B6EBBAE9549FE2C506B4A6E9D48D486E8FAA2D6E12EA08A68983C722EE561DC1A97F879AE23E1C6A4F02FF0066C8DF220CAEFE4AE4E3F11FFD6EC6BBAC1CE6BCCA9EECB43F6DC1D7FACD18CED663793D050CBC1A90291DA9195BD2A548EDB1176FE948CBB7E9526D0B9CF269AD9E98EB45C9B117E14857B91F9549CFA6467AD34A91D38A7726C45D0939CD1ED9FD2A4FC474A4C7AF14856184719EA453767E3CD49B7D07EB49B6A89B11B0E093C0A8D94F5CD4DB4FA526DDBD0504D887B74A6F3C7BD4ADDF029369F4C734C5622C531972B9ED529069AEBD89E05225A206E1B0699B71D6A6653FA534E303030295CCF9485B0BD79A632F7EF53B28F4FCA9A57823F9D172394842F3487E5CE0D4DE5F18E69A0628B8B948FF002CD376FCB526DE28C739A7CC2B11B5370476CD4BB79C9E949B7AF6AAB90D10F5C9029B8CB6EC54CC075CE29BF77DC5573222C43DBA669BD3815363B530A8E8053B90D11B2E09C8A637A54CDF2FB8F5A8D9474EB45C8688B68E78A615C67E9D2A6DA691B2DD38A5726DA1030E071F9D2E3E6A9369CE31DA98714EE4F291B0F7A8CAFA9C54CCA3E869BB7AF6A667622DBF8D3580E6A5DBDE9879E833407291FAF1F4A6B01D47352F3F9537F87278A08B15CA9EB8CD31BAF26A7651CFE74C917F1A5732E5202B824D34A91DEA5618FAD33038F4AAB99116DDD4549BB9E945233B1D980569769E9D29EABCFA0A7639C638A3A1EBD8605F4E45779F04F56D1B44F88DA6CFE20D562D1B496CC73DECCE116353804E4F19C5711B41247414ACAAD90C037D69A66188A1F58A32A57B5CFBB6C758F847A9DD29D37E22A5EA6FF967B5BB89F1EFC25786FED5175A5C371A2697A2DFC9A969B1BCF711DC483697DCB08CE303F895C74ED5E00D63048DCC11B7D5454A91AA2E1142A8EC062ADCD35B1E260F25FAB578D6E7BDBCBCBD436FCDEB4B8C1EB523432476B15CB4532DACB2B5BC770626113C8A159903E305807424672030F5149C9E7A5667D446CF66205C50A0F71C669CAA071DE9DB719C7348A1368EDC8A5DB4EDBC1F4A7AAF345CD5219B7DA97B63760FD29FB7D3934BED8CD4F30F419B78A7EDF973D38C7B53B68E99CF14BB4EEC678A455860524FA539465BD29C176AE3AD394E7B668B94909B3A76A5DBDE940E9D69CAA695CB484DBFFD7A7797E9CD2FAD3BD7D3D452B9761A17AE39A5DA7D29E14671D47AD3B69F4A0AE5235CF6E694AFAF3CE29FB7A52EDC50161BCEDE2976FE75205DBC8A4C6E24838A572AC3553703C77CD3B69CE31522A8DB9EFED46D068BA34E518A06D26942F7C1A7AA7507BD2EDE31DA9290728CFBCD818A76037F8D3CAF72297686C6452E61F28D038C7B50176E09A7A819CD0C071EB563E518C1BA019A728393F4A7852D8E41A154707AD170E5102B2F4346DE9DA9E17A0A3D70734AE87619B78E2976E5BFC29ECA7AE39E94BB09CF6FFF00551A8F9466D39EDF9D382F34EC738C52ED01481EA295C7CA3187CB8E73F4A5DB526D1EFCD2EDDD8FE945C76645B71C678F6A52BD871CD48A838E4E69597B1E0D1CDA15CA46ABBC62970071D69FF7BA8A5C2E46052B8588D94AF3B78ED4E09B719E69E7D47349827145CAB0DDA5B1C6295804E9C8A907EEC03C9FA0A66DF6FA555C2C378FA107152718C63FC2936F2BEB4BCF1E953CC240A7DB8A5DBF850A3F4A7851C71CD05D84380B498F5E29CC8734A46719A2E5586A91C6471463F3A76DCE79ED4B8DBC9E295C2C30AE1467D6953EF629EABCEE1DE9369E4E3A734931D8455DD9FA52606EC7E952ED23A8C50C3E5E9CD2BB1F28C55C367AFBD2EC3CE3B7B53D403FFEAA7AF2BC503B11AAFA8E47BD2AA83DA9DCFA7E940FA629DC2C031F4A1572B934F1F3739CD183DB8A7CC3B0DDA3FA52ED039C629EBEE39A3CBE83752B858680AC7A914310BFE34FDBDBBD1D0E719A63B0D0BC9EC691971818E0549B7B66976FCA477A9B95CA44B8E01ED4BB7D78A936821B3D69563EF45C444AA3B8C52E0648078A903638047D714BB3E6EB55CC559916DF4ED49D80A9481CE0F349E58DC31CD2E661621DB9CE38CD3D79539E94EF2CED229554743D295C3948F6FCD49B73CE78A9546DC71DE91BB719A2E1C843E5FE348502E322AC6076A3CBDC727A545C7CA56D9F31C8C53C261B9153851C9EB46D2723B531F29018F6B544EB96E9FE1565D7D4E38C629A50F271C503B1032FCC0F4A4DBED53797D324669719E3A5170B11B28E829BE5F4E3BD4BB78A5C74C8FCA98F94AEC0FD29BB7F3A9CA0C73498E48CF153715880AFA739C53197E53C16EF561978E2B1FC51A83E97A3CF2C2375D30115BA76673C0FEA7E80D4DFA19D492A71727D0F11F8C1E246D7FC4034EB63BEDECF281473BE53D71F4385FCEAF7813C0A26D1EDAE1D58B4A0C8B9F72063F015AFA5FC38F26C83CA0BDE3BAB3C87AE4E5891FF007D8FCABD3B4FD2E1D2ED2DEDA2FB9128453DF818AE99D4E5872C4F8AC2E573C4E2A58AC5753334FD152C6C62802E151F38C7A118FD00AB5F655599A4232D8C7F3FF1357D929A579CE39AE3BB3EC6346318D97433754D420D2F4F9EEEE0EC86142EC7E9CFEB5F2D78A3C4173E28D7AEAFAE09DCEC4227F7147402BD5BE38F899F16FE1FB690067FDEDC1CF61F757F9FE95E50FA7B47ADC51CA43AB88DDD874D8EA0923F026BD2C346CB9DEE7E63C4D8C9622AAC2D3F862F5F365BF06A5BDD5F5D595C8C25E42D16EFEEB64153FF007D01F9D529AE27FB20D28C46392295CCBF507A7E60D4AD6FFD917530C325C40ECB91D32318FD7357FC33672EA5793DD5C9DED71BC1908E771E73F9E3F3AEAF33E569C2524A8A5AFE8CCDD274A96F6095D50B15745F61BB8CFF002AF44D074F8AF7C2BAAA087CB2025E4431FC2CA50FEAA699E13D09A6D0F5C9106CDD7290A9EC1811FE22BBDD1F4329A6DB078BCBF32196274EE0330751F80DC2B9EA54B687D5E5995CACA4FB3FF23E6E652ACC3D091FAD255CD72DC5A6B17B00FF00967330FD4D53AEC8BBAB9F015A2E1371ECEC277A38DA73F7BB52D2C2AAD2C7B812B919C75A667119DBA63BD7A1F86BFE26DE13F2B04CB0168B71E48CF0BF90FE75C2DD216CC871BB38DA38C03D3FAFE55D4FC31BD54D52EAC9DB093C7B947A95E48FC467F2A897C27AF97B54F12A32D9E853D534F8FED37533068A38CAAA803963DFF4E3EB9AC296C658F2CD1B0F977FE7CD7A8EB1A4B9BBB1B264F32423ED370CA3905989551EFD08FAD721AD6933C56ED72F3093E654033D80C1FC8E07FC0856719DF63B7198270BBB1CA85DD800E3827F4A96150D0C8D9C3A90452C90490C6B332FC92038FA648CFE86A38FE5218FCC17A81C66B6B9E059C773DEFC0289AAE93637C83131400B8ECE00047D386FD2BBCDBE95E5BF02B52F334EBDB163931BF9883D01FF00EB8AF54E95E5D6BA9D99FB464B38D5C1C26BAEE26DEBDFDA9BE59CF5C8A94718E051B76FF85648F76C43E5F3F8D47B7D4638AB3B071C73DF8A632E39A2E438906DC60F6A611ED9AB0571827A7A547D00C0A643891950BDF34DFE1271935205CE0F4A6B2E09239A2E4F291B7A75FC28FBB9E952EDF979E299B71F5CE28B8B946107D38A6B77C9E7D315230FCA9369EA3AD171588CFB71F5A63038E0719A90AE7AD1B7A63A9AA23959115CF7C53197693DFDAA665F94678A4DBD8F0296A2E52BEDDDC77A4DBF2E7F2A98A8A6E3A02714730B9480AFE148CBF31EFE9561A3FC2A3DBF2E2911CA42547603F2A6151D47353B02BEF46DEB9E29F31362065A6ECE83AE6A6DBC1CD376E73DA827948FD7229ADF77D2A4DBED4D2A7D2AEE438916DFC699B7A54F8FC69847B52E622C4583F8D35A32C39E2A638EB9A8C7B0CD5DCCDC5119C0EA69A579F7A97E56CE690D55C9B10739A6F39C54D81D69369EC471411620653E9CD3083C678A9CAD336D1725A2265E73D699CE4F6A9F83919EBD69BB7B5047290639CD336E7A54D839C8A6B2F7A7722CC89BBD376D48CA39FAD35969F3226C42CBE94D6CFA62A62BF9530AEDC62919B440CBCD46CA17BF1561BD7A547B7BD331688B028A715F7C51419D99DBF7E94E51CFBD3B6FE34A3D31CD07AF635FC07069B7DE38B2B5D62C26D4F4C3A7EA97535B4170D03B982C279D00917953BE35E7047A82320CBA1F89BC3BE30D2FC1512780E1D1EEFC67E12D735892E20D4AF9C6997562B7A2236EAF31CA39B352EB2F984EF3B4A015CBEA9A35A6B1088AEA3DF1839C564CDF0FF47689B6DB61BB72056AE49C796DD3F496BF8A7FF6EF99E2E2F0589AD5BDA52A965DB53B8B2BFD056C7C1FE243E1BBED774BF1B5E69D1E95E1FD0E79AE351844583AAC69179819D965510A066CB24D9CAB0046FEB1E1DD4B46D4BC5D1597C37B7F16788AC4692E9E16D2E6D52D4D8D85D2CCD2DDCD04F2FDA62953642AFE63B45179C1983A1535E717DA6CBAF6AB6334FA758E8BA66996AD69A7E97A6B48618119D9DD8195E47677776666662790061555465EA7F0CF47BCB29C2DBE2775C07C80739CFA56D19D3E7D5697FC34D3F0FC5F91E7C32FCC254AEEABE6B5BAF4EBEBE9D75DB47E83F176C62F0FCD75A269A8F6DA4E9BF13F5EB2B783CD697CB852D34EDAA5D892DD7A935918DC31D05654DA54BAF78E7C45E32D62DEDE3D775BBD7BEB816808895D89242062C40FA935B383D8570ABD937BD97E114BF4B9EDE5B87AB87A1CB55EADB7F7B6FF0051B8F6EB4EE3904629C14F5A72AF5A1B3D848685E31DA9D83DBD734E55E8474C53913A67A63148A4866D3C71C9A76CC678A79519C8EB4BB7BD2B97623E83A53957E6E39A936E453B61F4C0EF4AE5DB41800E7D4D2EDC0EBCD49B79E451B76F6FD69DCBB0D55DC314F553DB914FF2FDBB528FA714B98B511A141146C5F5C53C0C74146DE8319A4D8EC26DF9491FCA9C14F1C75A7EDF979E9EB4153D01EB53CC5244783DF229EABD33DB9A9020F7A5DB91F5A57292446453957F0A9046586473C52EDC76E3EB4AE5588D630CC314EEBCD3B691F5ED46D14F418DDBD707A5281EA29FB71CE3F5A7EDDBDB3EB48AB11EDC734AABDFA9A763DB9A915470471EB40EC44142E451B771E952EDF9C6452052D8E31CFAD03B0CE847514EDB8FAD49B7B838E68DBF363B520B116DF7C0CD3BCB0DD07352F979E3A5215CAD0558604CFE79A7104838C7D69C23F6C0A76DC76E471557D03946AAF038CD26DEC07E7522AF7A7503E522DBC1EC6947DDA7EDCE4FF5A5503D0D4DD95CA33695E4734EDA17B8A7638CF4A5F2F8CEDDA3D3AD31D88F6F1EF4BB70318F7A90A6314BB08C77A9B8EC45B76F4E6855F518A970074E69DB4AE3E945C2C43E99E2936E718EB53B2EEC7A5342EDC1A3982C46177518CE0763E952EDE39A52A3B0E6AEE82C30281B48E69CAA38C8A5DBDF3C7D2A50075DB9A571D88F1B97AD1B067839C549B48C8031FAD1B46493D295C7622DBCE3AD39546314EDA36D3B6E4FA52B8C8D4630053BFF00D54018C823A53C003B64D2B95CA336D1D7AE05498248C669BB3D69072B1AB9C038EFDA97695E8314F55DB814B8F9738CD1CC5288C5FA53B1D0F614E1F4A147CA7D3D68B95CA205DB927A53CAFF00B38FC6955739C52841F4ED4D31A5DC60E3B734EF2FD69ECBF9D3B05B8C7F2A2E1623D83006734AABFCE9F8EE460D285FA96A771F291ED3D2955719C8A97F87A51B471CE68B8588954918EB4A1472474A902E71CE28F2FF00CFAD171D88C282B9EF460640ED5205C639A4DBF3531D88D54E738A56514FD8777F2F7A5DA02F424E3A8A02C45B7A8A1633CF1D2A6DBD7D28EE401F4A570B10EDDDD690AEDC0A9F6EEFCA865CF1F9D21D8802F3D314A23DD904739A95978C76A4DA78C9CF7A5A8588F6F7F7A4DBEDC77A976FBFE34AAA0F51F29A7CC162265C71D7E949B09ED8152953D851B380290EC4023C71B69BE5F7CE4D582A76D26DDDC0EB4261621F2F0C7B9A695C9C678A9D94AE718C51B46EE2A5DC2CCADE51DDD31CD0579E060FAF6A9CAF19EA698CBF952B858831C938E4556B8B18EE6589E45C98C92A0F624119FC89FCEAE903771C629BB7E6E953CC4F2A6ACD1585BA2AE71C6734922EEC9AB3E583C75A8D976E49E28B8256D0ACC3D2B3F5AD4A1D0F4ABABFB96DB0C119727E83FAD6A95DB9AF1DF8F9E25F26D2DB438DBE7907DA27C76404ED07EA727F0AAA71E79A479998E256070B3ACF75B7A9E41ACEAB71AE6AF73AA5C3059AE19A4099C80BD001E9818ABDA7DD2FF6B6853DCC5B638422485B243C7BC827E9B4E3EAA6AA4DA7AC96B11893E650F921B2182F24FE82BB8B6F0D9BFF000769970CAA92D9CCF6EEE41DA5490E33EC18D7AF2928A48FC7B0B42B62AACA5BBDFF002B999E38D152DF5410A29DFB7E76EA0E0019FC76E7F1AD4F0CE84FFD871CA14AB4A5654C7B3A63F2DC47E15D8788FC20FAA0B29601F3CD1A46FF005CED27F5FD2BB1B1F0DC367676B08E16150318F7C9FCCD70CABA5148FB4C3E4CE7899D46ACBA199E15D145BE93796B328C35CB3918EB9DA6BA3F2D57B0FC054AB088F3B57196C9FC80FE9515CB98622CB8DDCEDCF4CF5C572F3733D4FB28518D1A7CABA23E56F1C44B0F8C75A8D7855B971CF5E0906B0EAFF88AE3ED5AFEA52962FBEE64624F53963542BDF82B451FCFD8C929622A35B5D852703B8241CE68F414336E5505402060E3BD59C9B1BC6D56FED45D32EDB68932FF00ED39EA3FCF6AA9E1CBE6D27C43A75F381B5665723FD9DC01FCC66B5AC585E68F6F66308B27CCF83D707AFE5C7E3ED599AD44B1AAB2F0EE07CAA3EE281C0FCB159ADDDCF5E50E550AB1E967F33DDEE34D68A396EC7370CDF23F18DEE142FF00DF2307F0AE13C67E17923FB158C2763B31FBC7FBC41FE67FF1DAF56F05DC2EB9E14D2EED954EE8173DFE6036D52D5B475BAD7BCE75063897231D738FF02C6BCB8D4E49D99FA7D6C0C715868CE3F6ADFF0004F12D76C52E35A16912EC8ADE0591831E8AA831F98E7EA6B0A5B130C6CF90CBBFCBE39E7193FCC57A45F6862EAEB50B8FE3BA955338FBA8A4B39FA023F206B1F5BD156DF4FF00F57B7626EFF811FE1FA8CFE95DB1A89E87C262B2F7794ADB7E462F803C4ADE12F1247315DF0C9FBA9533D54F71EE2BE94B59A3BCB749A260F1C8BBD5877079E3DABE5592D7E752382C7F1FAFE86BD7FE13EB53E9D1FF0066DEBB3DACAD9B598FF037743E9EB515E1CCAE7ABC3B8D9D0A9F569FC2CF51DA7A6290A9FA5499254E3F0A4DB8F7AF3133F4EB75236CF634D20FA7152367DA9AD81EE29F330E5223C74A6367F1F6A9997A719A66D2D4B988E522C6DED9A6E3D8D4DCF403348DEFC53E626C45B7E6C8E69BDF38A9594FD3F1A6B7CBEF4730AC46DC9E9C0A4DBFFD6A7EDE7269BB4718E68E627946328A6F97DEA52BF28046693D2AEE2E523206DC75349B7E5E074A7E3D39A08CF7A7CC85CA40DDF8A6ED3537463914638A2E4B8906DDBF7A9A54673531007B9A6EDE483C5233B117979CF7A66D39353EDC9C74A6347B4E69DC5CA43B718E29BB7353E31D298CB8ED54458876F6EF4D65CA9ED5315F9B34D6C7A719A2E472909503E94D2BC74FC6A7DA0F6A632E6823948597D052328E6A5C718F4A66DDDCD3B93CA425739CE3348579E78A94AEDCFF005A632E3B51733E52165C77A4E36E7153363B0CD336E07AD3E621A23DBBA9B83BAA52319FEED33014F5FCE8D45CA46CA739C526DA90A96E7DA9A7A53239484AFA714D65EF536371E94C23D6823948187A8A6EDEC7AD4ECB807BD478EB4F988E5216FCE9BB78A936FB5339DA7BD3E63171444EB9C8C714D2A7D2A56CF3DE98D5466D10328CF4A2A5DA3E945591CA76F8CE31C52EDEB4EDA3752F1CE78A93D4B09C8C83C8A76D38E94A3D714BE9939A772D4440015CF5A7FAFF002A5E476A368EBD454F3176054C7245376919E2A651B5707A63F5A72A9A8E62F948C0EF8A76DDB8EFF4A7A8F514A47A0A2E5728DDB4E55271C53F6E39C6714AAB4AE5A43547383C1A02FA0CE2A4DB8A0283D4714EE57288143302694F3DB8A72A67DA9CBF37D2917CA300CF5A7EDF6C53957BE29EAA1B0715372EC37CBC75A3695EBC8A9368C8039E69DB41A2FA95623C633CE6976F41526C2B4EF2E90EC4617FBD4F55E99E69E23183C53B68CFD4D05243197B63F5A36E71C7DEA9386EB803E94E1FE4D22F948A34DBEA7D7DA9CB1EEE31DAA40A1BD852FBE295CAB11F97F371C52EDC0048DDCF6E94F6CF434BB39FD68B8EC30281938EF4B8EA29E3254F61EF4DDA7DA8B858400920E3BD2B253D53F0A5DB9CFBD4DC762300EDA728F7A91632DED4BB7E5F7A5CC3B11EDE7AF7A5DBF2D48BDF23F0A555E39E2AB987623DBD07A1A5DBCF4E6A5DBF30000383463B60D4F315CA45F43C53B6F4E7AD49E5E318E94BB0718349C82C478EE297675C9C73526DDB8C52F97C11C75ED47315623F2F1DB3EBC52AA7BF352FF93404C7239C0A5762B11ED1F8D2ED01B818C1A976E0F1CD1B7A9EDF4A2E3B11F97DFB53953F3A73478A5C11ED4AE5588F6E29DB768029FB339A5C71D3F3A771F290ED3CD2EC2A4822A7DBC1EF49E59E98CE6907290E0B76CD3B691D0726A5551919E2942EDE94D3457291283CF1D7AD3D57DB14F11E07349E59E33C7145C5CA45C763814EF2C60F6F6A7EC070694AF51EBD298F9591843B4678A5DA33C9C54ACBD3BD1B7BFE75371F2916D3CE7918A76D03FD9C53F6FAF41EB4BB77B6314EE3B1185C0CD014F1F2F3F5A90739E314B80A338E68B8EC45B738FE94B8E29EABF37B53B68CE7B9A4524336E7040A50800C549B47B1FC28F2C1A039591E0AB63B53B9EE3BE69FB7D053847EBD6A6E5588D70C39A5C7CDC8E3E94E553D453B6EEEA2AC2C2051CF1C76A53838C8E3BD3993A7B518EA3271FF00D6A571F2B1A385F7A5DBB979EBEF526D1DCD285C0AAB8F948B6EEE07068DB920608C54BB3232322851B8550B9591EC03393418F352797DCD380DBF4F7A7742B32255FAFD69140C60D4DC726931C8FD68B85991ECF5181F5A555038ED9EB4FDBDBAFE14A107AF7A572AC458EB918A420700735300391DFD3BD34AFB1A96CAE522DB914E0B819F5A753B1BB3521621EABC0C52EDF55CD4BB00EF405F4A61623FE2F414981C9231EF9A936F4EFEB49B6936C761981B7DE865EA73814F55A42BBB934AE223655DBEB4CC11D2A6DBDBF4A6B28FC2A6E55881D4E492314D23AE466A7DBD7BD3767539A9B85884AE78EF4D655CF3C1A9F6FE5EB4C2A39EB4EE1621653E9C5336EE5191C54EC9BBA50537106A45629C8BB724F4CF5FA0AF967C6FA837883C45ADDFBFCD1B4A228F1D957FCAFE75F4F6B8CD1E9F2004AEE1B4B7F7571F31FC003F8D7CBED632DD2BCE89FBB9E790B7B12D8C7F2FCC577615EADB3E0F8A5CE50A7456DB8EF0CA9FB2C19CB09376D5C670772E47D30AD5EE7E15D150F877ECF34600915770F52146EFCDB35E77F0EFC3C66904320DD25A488C46EEB1C8707F2607F026BDC61B710C2AAA3007068C4D4D6C8AE1DC1354FDA4914ADADFC885108DDB4F5C7EB530527A5592BDF1834CE831815E6BDCFB651B2B10951DB9AC8F10DC3DAE9F33A1F9C231562385E305BF0F4F5C56D9FA66B2FC44A3FB1EEB71C6E43C9ED8FBC7F204D5C3739B10AD4A47C8777BBED326EFBDBD893EBCD45525D7FAE2D86D859B6B1EFCD45DABE9E3B1FCE157E37EA1C8F702ACDDC05618A5C7EECE141031DAABC60B385E818E335D7E87A5C9AB784F568D14CAF0C666504E48DBCB63F0CD4CE4A27461A83C43715BBBFE04BE132B71E15D44280D730E231CF2118E4F3DB9C01F5355B54B10ED04259B0143162B8CB3B67F138E31D38A93E174E5B5C9B4F3B4C57511254F765E40FCEBA5D674F9163BFB898E3C9DCF1FA74D89F880E4FBED358C9F2CCFA0C3D1588C12925B68CEC7E04EA7F6BF08CB699CBDA5C3263FD96F9BF9935DE5D59868E4641F3B0E2BC83E00DC08758D62CC9C2BC6AE07D18827F5AF6DC7C95E5E27DDA8CFD1F219FB7CBA09F4BA388BCF0E8FB32C083686C46CDFEC91963F8A061F535CBF89F4B7BCD3E48D5313C9229231EA7E5FEA3F0AF5A9ED526421B82548FCEB9DBAF0EB49A824DC948774807F78E381F983F9D453ABAA37C5E5EA716A2BA58F05D674D682FA7FB38CA43318236FEF2C6305BF1383F8D7A6F84ED96FA1B67853E4B800BFB3839FCFFC4D3E6F07889A08D865B63165FF006CE4E7E9806AFF00C29B731DADFDBCCA15AD2E59147A83C83FAD764EA294343E670397BC3E2D292D25FF000E76F12ED55C0CD2AAE1B19C8A9F6FB531901FFEB579BCC7E81CAAD622651D85376E471D7A549B7A8C50BF77A76A5CC472B22D9EB51ED01B1902A73F4CD35978E067BD3B8DA213E98A632D4F4CC066C034EE4D8888DDDA9AC9EBD2A7C1F4E69ACBBB8345C9E522DBF88A0AFB734FDBD8518EF9A62B10B7CAA48E68DBEF4FC6011D7B52B2FF003A7727948BCBFCA98D9E7152B6291BEE8E28BB13890B01DF93ED49B7A0FE7537F171D291946323915772394AECA14D232E38FCEA6603DC1A685F5F9A9F313CA43CB1CF7C537D79A9997A1CD3768F5A7721A222BD7D698CA2A765EFD7E94CDA3F1A5A91CA438E9C679A6B0ED8A988DA3D29A40C629F310D10ECA66DA98AEDEBCD232ED3C9AAB93CA41F4E6930B8C54D8F4A632E33E94EE4F29011B988EA29B8C67D3153B27CB4C6E3228B99D885BAD376D4C46381C9F5A4D9B5B07B51721C48197D29ACBED536DE69BB7F1A64588181DD463E6153797DE98463E9EB40B948F696CF6A8D9718EF536D24E318A6B2FCC38E3EB55726C576CD34AE2A7EBF514C65A2E6562065F97DE9857E5A9D97F3A8D94F3DE83371206017E94D6A9B6F6C546CB9A69994A244D8CD14ACA73DA8A7764729DC283EDBA9EAB9FA528523AD3B6F4E69DCF53946F2A31FFEAA72AE69EAA3FCF35EA5F08742F044BE1BF13EBDE38B0D6350B1D365B48228B4591165DD319064862011F20EF5AD384EB4D53A6AEDE88E3C762E8E5D869E2B10ED08EACF2A2BE83F3A91549E82BDE6F358FD9EECA3DCFE10F88446338125BFF596B07C570FC30F147C38D535DF0168BE26D26EF4BD4AD2D2E7FB7A588ABA4C93B0D82376E861E738EA3AD77D7CAF1B86A6EAD5A6D45753E6B01C6194663888E1B0D539A52765B7F99E4F81C75C52AF5E9814F19CE3B52A81DEBC8B9F75CA3557B9E29CA05382814EDB8ED4143307EB4E507B60FD69769FF3CD4817039E71ED45CBB11E0E7A53828A70523248CD2ED201ED45C761171D7D4D39714FDB83F5A76DC7D3D6915619D08ED405E3A9A940E9814F55E80D22911AA0273DA9EA3DA9DB7069573C7BD4F3176131B680BDFAD3D57E6F6A785F7A5CC689118FA53B6FCB91D734FDA475E2800354F30D446EDF9BD4526C3BB919A9F68EB46DEF4AECAB0C55CAD1B45498EDDA80A187148AE518B1FE34BB7E5CD49DFA734EDB405888AEDFAFBD017AE4F1ED52E39268D84F23A52B8EC35576918048A5DA3819E3F5A7ED3FC2718A5C0E31CD17191E3FC9A73274C734F11FE34F1CF6C503B10E08FA7D29CB1E01C9C54A0638CD0AA3D39A571DB523DB8CFE9C52F97CE7B7EB4F553CE69DCED3DFE94AE2B323FD452AAF703F3A9157E5C52ECC1F5A572AC47B370E452ED1C7D6A4008E052EDF4A2E57291F97F81342AF7C66A4119EB9C734E5C74C52B8EC336F4F97B51B42F4E4D3DBD73F4A55038AAB8F948C2863CD2EDEFF00CEA4652B8C0FC68DA339CD2B95618A0F7A5501BAD4B8A4551D71919A8B8AC336F4EC682BCE071522FDDCF7CFA5030AC4E3B628B8C8FAF7E68EFC0E2A4F5C8C53B67C98EF4F9AE323E0F5346406C75A7EDFE54AABF8FE155CC047EE3F3A5048CD3F07D852EDFC453B80C039C629154F39E3E94FDBCE71834EDB9E9D695C64583923D6976956F4A9075C9E4D033C719353CC3B318A324F7FA52AAE3AD3C29CF1C7147D4638FAD1CC3B0C0BB72073F5A714FF00229C13F9D3D948AAB97CA3369E6976FF000E38A785CF039A5C1FEEE054F307291ED3DB9346DE99E4D4BB7BD1B7B51CC1CA302F079C9A503F2F5A7ED2BF5A5DB9FF001A3982C46CBD3D6976F45FE54FDBEB4BB7BE0D55C7619819EB4E6A46DBD73FA53B6F4F5A770B0817E5E78E694677734F518EBF514AAA053BB0B0CDDF374A4FC29FB78F6A5DA7D69730EC354039A6FD69FB4FA629597A76F5A7761618A7A51C6DCD3F651B47D452B8EC336EDC9EBF5A0A61B8CF3526DDDC679F5A36D4DC7622DA460D1B3BF4F7ED52EDDB8029ACBEFD68B976198DBEE68F5E0D4BB40C5263E6F6EF4AE2E523DBB6931C722A6DA1B8A4E69F30B9591E3E6E949B4549E9EB4DDA7AD1CC3E523207E14D65E952EDED4856A2E1621E09EE28C7352F1EB4D618E4715370B1115A6B2FCD9CD4DF8505460E7814C762B11D3D2829F31CD4FB4EDA42A09CF5A57158C2F1430B7D07509D87CB1C0EC47FB3B72DFA035E25E1BD0E49B4446991843B7F7C40E7919723DC2943F957BB788B4D6D53499AD17FE5A3206FF74302C3F1008FC6B334AF0EC7671AC6AA3CB50368C71C139CFD415FC856F4EA28459E0E3B03F5AAD193D9183E15F0FC963A9095C032AC66DE62380704367F41F99AEC4A638FCE9F6F631D9AAA272000A3E80607D6A4318E6B09CF99DCF4F0F875420A112BB28EFC546CA3047F4AB257D4546CA7AD62E4CEBE5200BD36FF002AE7BC62B25C69AD6A830660CACDD957D7FCFBD74CC0FE3599AF5AB5D69D2A20C92A47A5542767A9CB8887352715D51F1C5F4663B968CEECA96EBEE7350EE15B5AFE9EEBE2492D232CCE485C739C81CFF5ACC92CCAB600E9C7AD7D6424AC7F37E228CA3564ADB3B16747B517B30859C2AC836EEC77EDFE7EB5EB9F097417864B98A7888474657047B6D3F98E6BCFBC1FA4FF00694CAF1390F1ED7DA472707B7BFF004CD7D2BA2E9696B1A4A38322A93C77239FD735E6E2AAF2AE53EE786B2DF6D255A4B6FD4F97F456FF00845FC7B02C8702D6F7CB63EDBB6D7A6F8D2C65B636D10E619E632953E801DA3F3C8AE07E2E69ADA57C40D4863025759D4FD4673F9E6BD62F1ADFC51E16D0F5201590DB82E7FBA554B3FEAB8AD272F76153B9965F4796A62B07B38BBAFBEC70DF0B6E0E9BE3EB189FE533C0F1B7B92491FA0AFA176F407815F31BDC7FC23FE26F0FDDEEE219119DBD57773FA647E15F4FAF299CF1D47E55CB8CDE323E9F86256855A0FECB5F8A1BB7241C7EB48C9ED8352756E941E7B579B73EDEC674DA6AC9334A1B0C571823DEAB693A2FF654B3BE57F7C54B63D40C56D6DEB4D6FA5573357327460DF35B52168FA9CFEB4D651DAA665E738C7E148CA3D295CD2C42DC74A6FB761ED53303DBD29A70B8CF229F3217290ED03BE29AD1EE39A9CAFE14C64DD8FE1CD3B92E2458C9A465DB52EC3F8F7A0A71D79CD172794876F39ED4DD9CF3C0A9B6E3DE9BB474A2E2E521DA3BE4526DF981EDE953F1B4F3C53597AFB53279480A6D3D3BE682A3D79A9997AE3AD3361C8F5AAE627948997AFAD35854CDF788F7A6B0F6A7CC88E520F5A4DBBB8E454DB7AF7A4F2CF5345C562165CE09E29BB42E6A6DA73C0CD26CCF6A05CA40CBCD339FA5582BD3D6A365FC2823948B6FE74DE3AF352E0F5FE948DE878355725A2165F5E0531973D2A7DA1BBD4638ED42666E245B734DD9B71DEA72A3B0FCE99B474FCA9DC871488767BD30F2326A6618CE29BF8557311CB720C6698DD0E2AC633DB14DC71CF14EE43890633DFBD262A565EF4CDA7D2A88B116DEBDCD3596A6DBB453580E3DBD69DC9E521C63BD21C1C54ACBDA9857E6F7A5722C444724E39A694CD4ECA73FE151B014EE67CA42CA7393C5376D4D83D0D331B7AD1726C42CBF9546C03633C54CC082475A632FAF06990D1015EB4C751CF7A99B8F7A8F686AA306883F0A2A62B8F7A2AAE4729DC632719CD3B6E54639A72A134F553C74C523D7E523DBE871F4AF6AF817A6C7AEF82FC5BA43CE96A9717DA748F2B2EE2110CC485078C9E9CFAD78D05FC2BD37E0CF8FB4EF01B6A8F7CD20FB4797B024424076EECE47E34BDA56A5EFD0972CD6CED7B3E8EDE47879D61238CC0D4C3CE1CF195934BAABABAD0EFBE297C295D615AE74CD4F7BB5B988C3752EC0AC07CACA547E1822BCEA3F07CFE05F847E25B1B8BC3753DE6A9A6CB236FDCB958EEC614761923DEBD87FE1A5FC3ED1EC6899BFEDC96BCFBE2C7C50D23C6DE1B165602449BED29295F2046A400C3A8EFCD7251C466D1A71C356C539D25F6796D7B6DADF65BF9F5D91F0395F0DE13038F8E2E8E1250936B5D6CBBD935D7A9E39B7A9E8714E084AF38A785CD1B0F61C1EF5D67EBD61141CF3F9538A8FA7D69CAA7EB4E55DA319A4CD397B88A0D2ED38C0E69DB7A64E29DB7E5E39FA5172AC336F3C75A76D1CF39C7B53941E9EF4FDBF28228B95CA336F3923029CAA58671D29CABDB14FDBDFB0A8E61A88CDA5B3FD29FB4F6EB4AA46DDC38A5DBDFB54B668906DE3269DE5EDE9C8A5C7AF34AABBBD8505A430267A53FE53C53B04E38E29DB7FD9E6A2E3B08ABCE0FF00F5E915368CD3F674EC3D6A4DA18814AE3B11F97DF3CD3B68CE31526D27A7346DEA695CAB11ED1C0C714BB72318C54813AE68E7033D3E94AE3B0DDA3B538EDF4FF1A72AE371F6ED4FDA3AE69DC7CAC87692BC1E9EB4B823815214DD9E452AAF6C60D4B63B0C54F9BDB3DE8D9ED52ED1F8FA51B7A9F4A398AB0C55DBE94AB1E0647EB522A75FD29D8E7DA95D8EC47B4FA0A163F9B8193DF9A900EBDE9DE5F39EF4AE3E51814647381471F81A7ED3C76FC2858FA0A5A9561A141CEDCE6858F04647EB5228E84F14E64C74C530B11AAEECF61405C700D49B7B6734AB1B6D3DE915619B7A9EF46DC63BFAD49B7906976FB52B8EC88CA92318A02F715205A718FD462A87622DA7774A36B1E3A54A17E6CF6C74A5C70334AE1622DBEFC52EDDB8C54AABED4A547CBC503E522F2FA8079A5F2C9C9E82A50B8FFEB51B41CE39A04A245B7A7EB4BB7E51D3352AAF3D3228DBD38A02C42109F9A97047D6A655CF078A565DDD38A6558876FB6294215E3152050DCF6F5A5DB8C8A2E1622D84E38A52B8EA3152E3752B638E9F95034885578F4A5DBDBAD3C2EEC834BB79C8348AB0C65E83A526DDAC3031526339A555CB501618BF7B9C629C178048EB4E553E94E0B8C714AE322DA4714EDA4F6C8A9B6839E7029A5476AA01AABC723B5211B7AF15263FC3A5046EEA290EC3369EA318A5DA7AF6A7EDF9452ED14AE3B117271C53B6F5A7EDA31F362A8AB0C209CF4A141CF4A7FF005F6A141E94C561368C0A73295E6971DBF53D2942F7355CC82C3369EE28200EBC8A760F1D3D69719A90B0DDB49838C548B9F4CD20527B503B11FAE0669DB4EDA7EDF6A4DBD88A4161B83F8D14E2BD3B52EDF6A7718D0A41C019A6EDEC79A971D38A42A7A52023DBD8F06976F5F5A7EDEDDE938031D6900CDA4F6E291BAF4A936F5078A46EBC0A9E61D8667E5E949EF8A7953CF6A4DBFE714AE1619B7A9EC6936F6A9768F5A61CE7D0D47320B1137D2936E72793536DCF0291B229DD0C8F07F84523027B73E952F3E949B295D8C8187A0A4DBED8A98AEDE94DDBBB38E94AEC2C4381ED9A66D20E71C7A54DB7DB34D653F41EB4B9B4B0104899E9CA9A6B2FE35395C5336EE39E8295C2CC81973D3A546E9D41AB1B714D6C7150DD89B15DA33D722A19A32C8CBB73C55B65C9E0533CBE3A66A14B50B2B58F99FC4DE1F917E285ADA0387789E525782701F38FAED38FEA6A96A1E17365A96763341BD48038F9738CE7D2BD005BFF006E7C75B9936E63B38844ADDB22239FC98B7D0D76979E0B86F21313C790CB8E9D811FE27F2AF69E21D3505E47E671C9A38D9579C3F9DFE48F20F843668BE26680EE70BBE3C903E521B83FA63FE055F41AC7B500C617A0AF32F873A24763E3CF13DB941FB9995C3F6F9D7711F867F4AF54651815CD8BA8A73B9F49C3F87787C2B8BDEEFF0003C1FF0068ED0F649A5EAC8BFDEB690FE195FCF9A77C1CD43FB63C13AA68C54192DDCBAE7A856E4FEA31F8D7A27C56F0EFFC245E08D46051BE6897CF8F039CAF3FCB8AF09F82DE201A1F8DEDE291C2DBDF29B793774DC7943F9803F1AEDC3CBDA619C7AA3E533282CBF3D8567A46A2B3FC9FE8C778F349912EEDEDD467ECC161C8EA4E0B9FFD0FF4AFA474395AF347B19D861A48118E7D4A8CD794F8A3C3BFF15D5AC001D9753395DDFF005C719FFBEABD834BB730E9F6A8C002918071D3A573E22A29D281EEE4B83747175E5D1E84BB7A678CD26D352F9676E7BD183C579E9D8FB3E523DBD3D29ACB8F7A9997B7E54DDB81EB4F51729032F39F4F4A1930473536DED4C65F5A5762E522DB8EBC534A9618C54CCBDF3C5214C73D28BB17290329CE00CD205CF5A9F1F3673CD26C03B77AA5226C407B923148CBDF1835395E334CDA4FBFA55730B9483CB238A369FAD58651FE45465339E3FA534EE4F2906DEE452363D2A7E33D29366EA771729095FCE9982702A7652B9CD2347C8355726C57F2C12063348CB9EF935318C8F7A6B211CD0472906DEB48C878152853DF8A52BDE987290328E39EB4DDBD4F4AB0CBFECD47B7DA95C9E5216F619A63A1E78C55823AD3197AF14C8E521DBD69863C2E71561939C67F3A6B2FE34AEC9B15CA82DE94C2BD6ACB2E7DAA22B55722C41B714D2BDB3DB153943C71C535942F5A77337120DA29ADF29CE39A9B68EA298CA47B0A7CC4F2F62365E73D299B7BD4B8EF9A6B2E323D45519F290EDF5FFEB5376FCD81CD4CCB4D2B8EB4EEC8B10B2E4734C65F6A9BEB49839F7F4A7764F290EDEB4C2A7D2A6DA7F5A6ED3CF145CCDC48703934D6E7A54CCA05319416E9C5176458876E73DE9AE9906A665A632FCB8E99AAE621C481971D6A360739C54ECA14FAD46CB4EE64D106C1B8F151EDF949381563077678A8D947A55DCCDC4876E3B5152514EE67CA774A3AD3F6FE34E55EA6971D69DCF4C41818C0AB1A6E9F2EB1A9C36504B6F6EEC92CF25C5D31482DE18A369259A4201211234663804E07009C0A8B1D2A09AF8E8F7D05FBE9C756B1F26E6CAFB4F597CA6B8B5B881E09951F6B6C7D9236D6C1C300707A5553B3959FF4FA5FCAFB9CD8B9548509CA8ABC92D0B3A76A5E15F145FF00D93C31E25BCD4E73637B771C57DA28B56B86B785A6D916DB99370648E4C16DAD90A361DC76C1F6DB6FB1F86E55B80F71AD59CBA82DB6CC18ADD6668A372DBB92ED14BC60602A9E77718A979A0F84AF3C3173E0E9F5AD625D1AFD2ECAEB5A541624428DCC27CB9E6F337A96566CA0C7F09CF16E3FB0EB5E37D5756D2B4FBBD2FC3B6F6F6FA568B677E54DC4367044B1C7E615246F214B360919635A4D414535BFF5AFABBA5DB47E478984AD8D9E2634DBBC1ABDDAB6BDBF5EFAA3676E29557B8E07A53BCB0CA31D7EB4EF6FCEB9EE7D6728CDBD31CD3FF8471CF7A5DBC0C0CFE34FD8718F5E952D97CA46B8C629FB7E6181C5391473DE9DB6A6E5D86A8CF7C52AA91EC334F5F9B040E33401F89A5CC3B0817A7A7BD3BF0CFE34AABF88A708871819A9B956055C678A36F7C835205217A81EB4AB8EBD052B9490C03F0FAD382D3F68DA0FB53B6F7ED9A9E62AC336FF00B391F5A7ED1CF34EDBB57AD0ABF9522F944C63DE9769E3DAA5DA00F4A02F4C7EB4AE3E51A14AF53934BB69C10AF34E1CFE74AE5728C65EF824FA53957E5C9FC7DA9700633D69CBC93CD2B8F946ECEB838A4DBED527AE7AFB52F9791903F5AA0B0C0B807D69D86A5C743D69553A6722A6E5586629DC73CD3F6F2053BCB217279A2E56846ABF88A76395C74EF4FDBC01DA9C17AF6A2E1623C601ED8A76C34FD9B79EBF5A77E345CAB11853EB46DE30054BB7D062809F2FAD2B8F948C2FA0CF269C131F4A917E6278C5181D0F4A570B0DD9EA30682BD81C0A902F7EB4119C7D297315CA3563E3346DED8FCAA4DB8C76A76D03BD170E521DA3EB4BFC38352ED0B93F95057E61DE8E62AC4583918E6976F4E9C548CA37714AA81B033F4A5CC162355F949A5DBD3352140BC67F0A36EEC70695D811F6618A76D39C53F6FB50A9D3BD170235F5C62971D29EAA78A50A063355CC5588F1D2976FCC3D29EAB9A70028E60B1115E3DA822A4DBD460D1B79E69F30598DDBFAD34A96E41A97F5A197B1E28B95CA46AA7918C52D3F1B863A53BF88567CC3B116DEA451FA8A7EDC375ED4AAA36E734EEC2C3571EB8A36FAFAD4823CD0CBC74A45586E3A0ED4AB8A5C0E08E6855E955CC09099E00C77A368EFC53F6FE346DFCE8E610DEB818FCA9703AD3D703B51B78DD8A43B11EDE4F140E98C9A93B8A3D302AB982C3307914B8E714E504B74E297037671C7AD1CC1619E5FCA297EEF18CFB53D79C0C518FCE9F30586E3E6C1E28A76CDC40A52BED9A770B0C1FAD18A9146EF6346DE9FD6973058663A51CD3F69F4A5DBD7D69730588D970318FD69172724D49B73DB27148CBD7D68B9434673ED487EE9C8E7B5498CE3D29391DB9A5710C6E1B0451C95DC38A7E318E686ED81C77A572AC331EBC537EEF5A98A8EE7AD2606EC54B7A95CA478CF6A4DBF293CFF00854BB78FC690AD4B9072913669ACA4D4FB43671C5376F0295C3948B1B7A526DA9B6E79EF4D61B7071CD1726CC8B6F1EF4DDB8EBC54FB7E6A6EDDD4B98AE522E7F0A4DB52EDF97A734D6EBD3BD315888A8552714C6E7A702A639E8052321E38A43E5440CBEF4DF2CD4ADF5A377E74AE043247DFBD46CA4363AFD2AC48A776714DDA08CF4ACDBB9562B6DE314C7C2AB301EBDFA5592BF374E298D18E78E2A6E070FE11F08FD86FE5D566DDF69B82EEE4FF0079DB763F0AEB8C6429F5AB1B3AE0533078A729B9CB999851C3C28C7961EA701A4C2F67F14F5A50310DCDA42E78E378381F9F3F9576C54F1512E9A83547BC006F78FCBAB8D1D6939F358C70F43D8A92E8DB6549230CA411918C62BE42F1E686FE0EF1B5FDA440C6B0CFE740DD3E43F3291F4E9F857D8A63AF04FDA53C3A639B4DD6635E24CDBC87DC72BFA647E15DF97D5E5ACA0F667C8F1760FDB607DBC7E2A6EFF27A1DCE8B1C3E3687C31AFAAFCCAA4C9E80ED6523F3AEF1542E003C578A7ECDFE2269ECF50D1647CF90DF6887E87871F9807F1AF6FDBE8326B2C5A74AABA7D0F5321AF1C660A35D6EF7F55A3187AD2EDC73D69DB73DA9D81BAB9548FA2B11F979C67A8A465DB5301C938A6EDE955CC4D8831DF38348CBEBCD4FB4139A6EDDBD78A2E3B1015E3A52EDA9769CE6936F34C5621D949B7D715371C007348CB9C6471485620DBF9D0578C7A76A95976D215E39E2AAE4D881948C678A8F6F1826ACE32467D29BB68B8729079796CF4A6EDFC7E95631F2E334C65EA41C51726C43B7269AC83D7E953EDF5A6B2E40E29F310D1085C75EB8A6ED383CD4CCBEF4DDBDF8355CC1CA43B7AFA5376FCDE82A7D94CA3985CA427F314DDA3D6A5651DB8A6EC1D73C53B93623FF001A63633533260703F5A66DE7345D99D889969BB769CF5352FD4629AC14D3E625A2220EEE9CD4657AF3539FBBD7AFB5376F7031557239480AF5FA53597D78A9D93AE29A57D68B9162A8523DA9ACA79E38AB0CBE9D69BF515667621DBDB151B2F73C0A9F1DA9BB3D79FAD3B93CA41B71D29081C63F1A98AE7B530C7D2825C48997151EDA99945376F4A7722C44CBE94CDBC6735619471DA99B7B019A2E67CA4040FC698CA4718CD4EC81727029981D71410E240C08F7A695CFE1D2A62A0719EF4D65DBC0E735464E241B3A0FCEA16FA7156994F503F3A8DD474C669A666E257618E31F8546CBF2E6ACB2F3CD46CBD734EE64D1032F3454854D157733B1D6EB9A80D2749B9BCEBE52EEE9EF5DA6B5A7F85A7F88573E1ED2175FB08349F883A6F82AFE7D4AEA0985F2DDBC83CDB665B78C24882262C8C24C07439EC78CF1269EDAA685796B1FDE95368C7D453BC45E26F1478EBE2B69FF00113C433EAFAA8D17C4916BDA4F86AFB5592786C5126590DBC0CE088D48445CAA0E83E5E315DB42547DD557BEBE978FE9CCBE77E88F2738A798CA6BEA2DAB465F7D9DBF1B12781EFECFC497B1FDB6792D34C8A7B87BCBA5037C3696E8D2CF20E31911C6C4718CE2B6FC36BE18D57C65E2FD3350D72E34DD12C7418B5DD2F56711AA186E66B55B496E0918F2C2DDA1936ED236B63A62B9DB0D7FFE119D3B5783C1BE10BCD3EF356B67B479BC537367AD436E924C8F3ED85EC1227DE8BE5FCEAD80CDEB597E29D5F5FF0012E9D71A6EA1E1AB292EEEBC2B2F84A5D4F4B482C2016A6FE1BC8596D608123531F9724785C6E1203C14F99525494173EAECFEFB3FD796DDAECE2C556CD67513A116A3EEAFC62DBFBB993F91AFA878A34CF06785EDF54F14E8FADCB7F1F88751F0F5F693637915A3C325BC36AE0EF7B79B9CCEF9E08236E08EA6DFC54F10683E19F107C57D3343B6D7211E06B46712EA17905C0BC946A36B6BBB0B6D1EC5D93B9DB927207CD8041E6BC60FAC78C3E1FF0084FC2779A2C51DDE832C93CDAF4531326A7BA1B7822F3536E03C715B449BC1F982AE464126978FC6B7E2CBDF8A7AAC5A1B4171E3A468CDB1B9DE2C835FC1779DDB0799FF001EFB3A2FDFCF6C1DE0F0FEDA2A56E55BFDD1FD79BFAB187FC2C72C6724D4AFAAFF00B7FF00F91FEAE7A44D6FA747F183C59E10FB45E1B0D1E5D5E38A7F93CE6FB25A4F3A6E3B369C98541C28C82718EB59FE07D6341D42C1759F13DECFA6786ED6C5AFF51BAB655324719758630BB811969658D791D09A8EFBC616175F10EF3C670780BC4105EEAB3EA32EABA749E2186489D6F2D66B771038B053115F38B02DE67DDC11DEA826B175A4F862E7C37E10F0C2D8595F496C6EA7F17C561AF130C21C88447358AC5832387DC137651476AE782A71E573D6CB5F5BBFF34FE475C6BE692A6E118BE67149376D1F5EFADBCBB1A7089A1D4B54D32EF68BED2EF25B1B80A30A5E372BB87B1C647B115638CF3FD6AA49AB6A7E27F134DADEAD611596A33D95ADBDE3DB0448AEA68631179EB1222245B911328A30082475C0BCCADC7715C52F75B57BF9F7F3F99F61839D4A94212AD1B4ADAAF31A17AE3AD3FBFAD2A8C91C669C103545CEDB3136FAFAE6976F6A93675EE0719A5F2C76E9EF45CB511AABDA9E172724734E55CF3DA9EA9DF26A4B4866DEC38A76D18F4E29EABC73C53BCBDA7348761817241E94F55E07F4A93605EA291454DCA511BB7BD3F6E17DBDE8DBEBC1A938C63B6295CBE5183F5F4A5C75E94F58F9E98CD2F97D80A9B94302963C8E28DA7A549B71ED4FE36918A77022518ED9A5D94F55DBD79A5552320D22EC336F52463F1A76D0B9E33EF4FD9C1E29CA9C9CD2E60B223C0EB4EF2F8E0F34F11E79C60E29EA0E31D8D21A445B79CE6976656A4F2FE6F5A77F7B8A7CC3B10853E9526CCE0D48ABD69C57A76F4CF7A570B117A9229DB79F5A7ED27008EF4EC1E714B98AB1185DA3A52EC2546462A455DDC1FD28DB8C0CE3DAA6EC2C46AB4A0673EB526DC7BD1B7F0A2EC63157D38A7041DFBD38214EBCD2F97C5218C61EDC53957E53F4A795F9B9A31D71D314D31D86AA1F4CF6A5DB8E7AD3F69FEA7DA939CE6A798633693C819A555EB526D1D7B53B68E98A655888A8FC0F7A52BD3FC29FB79C52F7A9B8588B6D1B78F4A97682BC53719145C2C331DBA52ECF6A79E588ED4B823B7354323DBF951B7AF15205DB8A36F5FA5003768A4DBF2D3F69E78A5F2F8E94D00DDA2936F634EDB8EB4EEB9EF4AEC7623DA39EF4BB7A7AD3B6F51ED4A7E98FAD20B11B2E39A50BD29E17E6C0E452AF4FBB405860503AFEB46DDDDF8A7ED271914B819E99A2E50C29D79CD1B73526D23B629307D053B80DDB4BB791CE0D3C2F028D9C8F5FAD021BED8C5001C7B53FD0118341FBD9038A2E03029C609A36E31E95215DC067AD18ED8A063157BD1E98E6A4DBC629163DD45CAE5637E94BCFF77F5A72C7F2E6942657A7E54EE2B323DA3F0A002391CD49E59E051B7A0C52BF62B9466C3E98CD001DC33D2A5DA68D945D8B9591EDF7A5C7BD39572E69DE58E78FC68B8EC439A5DBB8E471526DEA318A714C607EB4AEC394899777D29BB7BF7F6A9BEEB6314A47520E0D172D221285BE9EB411CFF3E2A5E071DFD29B83B49E94AFA0EC3767CDED48D18DC3079CD3F69EB8A36F7EF4B980882F51D695979CD3DB1DA9368DB523B0DDA48C28CD376F7EF536C2A7246691946E1DE9DD0884E028C50725700735232F181C814D5C9391EBD0501618CA78A66036706A52067E94DC060474A4C5623E9C53770DD8EF5271F86690AFE14B61B4307403F3A36EEF6A76D1C514AE2B1032EEE9C7A533D323153EDCF348173EF557D09EA4257775A42956197E5C76A6B2F4358FA1B58808F4E69863F5AB1B36F41CE2987E6A09B106D3CE0547B3B55ADB4C68F6B1C77A00AAD1EDE9D691BE95676FB546CA47239A9B8EC40C9D40AE53E277857FE12AF046A7668BBAE153CE87D9D79007E008FC6BB1F2CB0C74A91220410464631446A3A7252473E230F1C4529D19ED2563E2DF873E246F08F8CAC2EE46F2E1DFE54F9FEEB1C1CFE3FCABEC45DB22ABA9C8203020F0475AF8FBE29786DFC2FE3AD56CD976C6D219A13D03239C8FCB9FC8D7D25F067C423C4DE02B091DB7CF6CBF6797D72BC027F0C7E75EFE60954A50C423F30E13AD2C262EBE5B534B3BAF96E765B79346D1DB9A97CB1BB9A685EA471CD7837EC7EA96433B75E3346DEF526DF9B1D683F4E6A856216F614DDB5395C838A6ED1CFAD1761CA43B49E949B7D2A5C75E46695542FD7D2AB98562B951F8D1B47A60D4BB7BF5349B7927B5170B116DFC69AC9C54DB3B53597B9E29F30B948BEF703D29ACA7D3E95332AFE349B471E947313665729B7A8A4DB9E9D6A7652D9C9A6EDEF4730AC4017B1A6F7CE2A7DBB7A1CD35815C70714D489B10ED1D48A6EDE3DAA6D9CF4EF48CB8E94F991362B94273D8D336559C75A6941CE055DC9E5640CB9C63AE69857D00EB53B21DD4D207A668E617290EDF61EF4C65EBED537F163149B7F1A7722C4063C5376F4C8CD4CCBEB46DDBD714C9E52BB2F5C72698CA3A5592B4CDBD78A772794ADB7DA9BB4D59DB8F7A8D97A51733B106DF9A98CA7B8C9153ED2734C2BD7157723948367BF146D3C9ED5334751B2F6CF34F989E521C67069857DB02A76538E981E94D6538E9549DCCF94836F5A6B27352B0EBCD34E4E3EB45C9E52365FC6998A9981DC7D698CA69DC9B10ED1CD30AF5EF53B2E2A32BB73D8D06762065DD48578C77A976F4A6B0F7A77317120607A9E6A32BE9CFA54F8E86A365DBCF6A69993890E31C939A61E474A9D97DFF003151B20E40A7733688367BD15271DF9A29DD93CA77FC63A52ECCE0834ED9FCA9C578C75AA67A9CA3318E314BB70704F18A7850D8029CABD290911ED05A976E1B1522C7DE94286C7A522EC46BEE40A7EDEA475A705C7207E74E55EE681D88F667AD3B6956CF6A7FA53829E78E3E94AE3E51829EABB7A718F5A76DE49E94F55E39A572EC302FCBC53957728C75A5DA4719A9163EE295C690CDBB73D4D3F6F071D680075CD48A3A81C52B97618A3D7A53F1818A701C0E3BD39474A9284DA59734BB7E503DA9FB76F279A5C67000E052B8EC37CB1C73F953B39ED8A50BD78A7EDEF8C95A9B9A72B19B6942E3A73526C383D8F6A5F2FF0097F9C52B8EC34AFCA08E68F2CE7D6A5DA38EA053953DFAF4F6A571D88847B73D0D2F97F3720D4A5430C53829E72334AEC7622DBF37BD3B6F7A91403D452AAEEE76F140EC336F7E9408CAFBD3D94F183CD3F1C018C0A6D8588B907269DB7AD3C263BD3B6FCB48646A3BFBD2AC79EBCF6A936E3A1CF7A5F2C6E1CE067345C647B69DB48FAD4814719E7E94BB063AF348AE5647B71F4A5F2FF2A7E38A5DA0FB548EC336F61C1C53B6F14F0A1BEB8A4C1CE295C761BD314EDBDFB67A52AA7E0334EDBDB34B982C4781D69768E40A732ED619A5C534D30B0DD838E78A36F5E78A7AAE303AD1F8F140586EDF4E686538007E34FDA68C74A06205FC6831FBD3BD286EDC75A2E80695E3079A40A371F6A93E948A9DE8B80D2B8E8334A074A785DD9ED46CAAE6403361E3DBDA919476ED528F73CF6A31EC49A3990EC47B7F0A5E3183CD3F6F5C7F0D2ECDA738A9E70B113023195E4FBD3B1919C53B6F7EBEF4BB4F2A054F3B288F68C67B1A36F5079A914718A5DB9C52E6D4AB1171C9E68DBC0E6A6DBB792327D29BE59E077A4A41CAC6607AD2EDDBCD3D538CD38051CE7BF4A39839591EDFCE8519FC2A4DBD714AB1E38229F3072B2303048229DB7FD934E2BB8E7BE79A531FE747314A246077CF34BB7A8A917071D8D1B7FC9A5CC0D219B76F247146D239239A7E4ED271460FFBD55CC52447B4EEA73636F4A7119E40C52FD467E953CC162309D8734E6E3031F953B68C8FD7DA8EE053E62B944EBED4720E31814E6507FCF4A551DE8E60B0CE791DE83CF7A72AE0FCDDE9C9DF3D453E60B0CF2E9DE5FCB8CE450CA4E4019A77F0D2E626C30E7A629187CDCF029E5790714B8FC28BB2AC307B0A698F269FB4918C52ECF5E295C08F69F4A465C600E79A9767CD8EF46CEB52572B230BED9CD1B7B9E6A4DA7D28DA7B0CD3B8EC4614F5C629BB73C76A94A938A4DBC934AE2B0CFE1E067F1A5E9838CD3F86C8C63F0A303A819FE94682B1030DAC38FAD348DA30062ACECE724669AC819B8E2AAE162B15F9319E7E949B7DAA768B18C9C53768FAD1CC3B15D979C53769E9DEAC140691A32A2B36C0836E3AF34DC0DD8AB1B7A5288F3CD6529F296A372A9F98E471405FCAA768F6F4E94DD87D2A3DA072EA47B772D2607A77A7331E3D29B54A5AD82C34AF43D0D3768EE2A4391DA97EF64FBD6BCC856210A7BD2150A7DEA53F4A695DCB8EF53261620D83BD35979A9F691D29BFC3537158836724D489DF8A715A17DB9A4F51A3C0BF6A4F0E7996FA5EB71AF3166DA638EC794CFEBF9D617ECCDE285B1D72FF004499B6A5E279D0E7FE7A28E47E2A7F4AF76F889E15FF0084C7C21A9696A409A58C9899BA075E573ED9E3F1AF8D741D527F0A7892D2F42B473D94E0BA9E08C1C153EFD6BE8B02D627092A0FA1F90F1046594E754B3082D25BFE4FF03EE62BF37D2A3F2C74CE6A3D36FE2D574FB6BC8183C33C4B2A30F42323F53FA559EBED5F3BAC7DD67EB309C6A414E3B35723651C718A6ECEB5295CD18ED8A6A459163683C60D3768E702A6FBBDE91B9C718F5E2AB990AC41B7AF4A6EC2DC558651E948C36F20669DC2C41B707DA936F41536071CE293681CF5A770B10602F079A4C64802AC329E846299E5F4F4CD2E60B10EDE318A465E3A54BB7A52327534EE4D8873ED4D61536DEBC5232E3DE8B899032F3FE14D60467DAA66CD34F3C639AAB8B948B6F148CBCD4DB7DA91971DF3CD1717295F69E71D299B76F4E6AC6DEA299B7F0AAB91CA40C3E6EF4C236F518AB18ED8A6B2E69DC9B15F1C669BB7A8A9C27B77A6951CE7028E626C40CBBBA0E949C6718A98A9E29BB7A678AAE6158870693B9FAD4ACBDFB535978C76A3989688596A3C6EFE9561970DED51B2557319B445F87D698C9C6718A99BBF34DFC7355727948366EA8CC7904E6AD6C18CE2A365C7D29DC871202A38A695E9E9536DE99A6EDE31D453B99D885907AD30AEDE7156367E74C65E41A44F290ED0DCE2A368FAE4E3D3353B2FE749B7AF19155764B8959971FE79A89873D39AB4CA3B726A261F30E326AEE66E241B7D4E0D35971D6A62006A6B2919FD28B99389032FB546DD06462AC30EE462A32334EE64E2576078A630C1CD4E5698C2AAE64E24057D28A976E7AD155732B1DF797EBC0A5507BF1F5A7EDC601A72E7EB45CF46C33073CF147F16314F0BD3B9A76DF947AE28B9561817DB1C53B0DD31938A7EDEA0F14B8E8307348A486EDE99342AFAF4A7ED38DB9EF4A14B0C1A5CC31BB46DCD2A8CF19E29FB7E5A77B0A2E5D866DE9E829CBD3FAD3B6F514AABDEA7982C376839ED4F0BD314A06EEA29EAA7A6327EB4AE5A430276FE5526DE31DE971DBB50A9FC54AE5D8551D067F0A76DC71D29EAB9F6A708E80B0C5076E4F5F4A9153A76C53F6F514AABD38A96CD12136F1CF14EDB9183C1A5C1E84669E3EF71C0A9B95618ABCE79229427E58A785EBDA9DB7E5F4A41623DBF80A72AF4CF152EDEDDA9557A7A52E62AC31570DD323148AA4722A5181D0D2ED1B89CFE947317CA47B37633C669DB0E3B62A45A728CE0629730B9591ED3CD285DBD0549B71EA79A5D99C1E829730EC47B4EEE94BB7E5E7F4A9368C9EE68FC29730EC47B69DB7E504D3B01A9FB7BD2BB19085F438A7053DCE31526D279EA3342AE391D2973011EDEE39A5D9C54A63F9BB526DEB5376047B72DE98A5E776719A97CBF941EF4BC671DA93771D88FEE8F5F5F6A5DA0F23AD3FCBF9BA7EB4E45C1CFA9A570B11118ED46DA9B03A91C7B526DFC0D098588CAEEC75A366DCFA7A54A172BEF4BB4E492302A82C47F875A4F2FA67F4A9B03D2931D295C63197A639149B78A94A9E9D69769A571588B685EA68DA413526C39A1863A773DE9DC2C3168DBF2FBD4BB02F6A3693820E298C8F68EDC114EFC7914E0BB78C50B8C67D68191E3AF38A55079E86A42B9C914BB47714AE572B2265EF4BB79DD52347C1A555DDD07152D95622DB822976D49B73EA6976F6C54DD8EDA117E273F4A5F7C53F69CF519F5A52A7AD171D862A9C74E28651B31526DC1F4C75C52EDE7D68BA191EDDBEB42C7CF5E2A52B9A39A39B4022DA5720739346DA978FCA8D9F2D57321916DE7DE976E07A9FA549B052EDDA7753B810FF09A5553526DE734AA87D78345C7623C76E829318E40E2A5DBC6307029C579C63028B858876FBF3E94E11FE3CD4A5475229769EE7EBED4AE3B107965BB71EB4BB09C718E2A6DA0E71D294AE7A0A8E60B1084E33EB46D2DCE38A976653A6697934F982C43B7D3346C3B6A7DBB464D0173CF7A2EC08803DF9FA522AF419C54DB7902839660B55CC1620DBD4E29DB7A8E952EDF6FAD0CA147AD2E6291160F3CE0FD2976F1EF526D39FEB46D3C9EC28B811F97DF149823A9A931DC7348CDE953CC32309C5232E72169CD95A5DA1B9E41A5726C33686A3CB2DC018A7EDDA703A669FD074C9EF4D31BDC89542F079A6853B4F4A9F031FE3498F5A39892064A8F6FE1565B0B91509E7A8A7CC3B1185E7A5230E3A54DB7D29ADEC33F5ABBAB01015F98D2AAD4BE5F193D7DA998F96B96A6E6911B262A2E7E952E08A6C91FE75CFCC6CEC42CBF953769EFC54ACB95A4C1E7D6AA32B13CA42CB46D247BD4814FF152EDDDC1FC2AD4C9E523C77A677E6A70A3D6936FCBF4AA722794ADB76F14D2A39EDC559619CD31969260438C7BF14D6185E86A7F2C8E69BB4B0345F50B10FF00915F217C7AF0BB787FC7D7332AE2DB501F694C0EE7861F99CFE35F613AE781DABCAFF680F039F14783CDEC11937FA666640BD590E378FD33F857A197D7F635D37B33E4789F2E79865F251579435466FECE3E2C1AC7844E95236EBAD35B1863C98C9CAFEB91F857AE6DCFD715F17FC2BF1B37817C5D697EFB9ACE43E4DCA8FEE1EA7F0EB5F67DBCC9710C7344E248A450C8EBD08C641FA1AE8CD287B1ABCEB691C3C25992C6E063424FDF868FD3A0B8E3AF7A0E3A54857F2CD27DE5F7AF1AE7DDD88D97DA9BC9A9997834CD84FB53521588F9E9FCA83E99EB4F2A7F1A50B8E314F982C4416936F538CD4D80A3D69BB43700E2AB9856232B9CE69B835363E63FCA9BB7DAA7985621D9F2D26DEA0E454DB7DA9BDFD2AB98762022908233DEA6DA29A40A7CC1620DA0E71CD26DE9FD2A6DBDA9196AB989E5641B7E539E0D348E0F38A9BF88F1C5215F949EA29DC5621DB9A4DBD4FA54806D6228DB8EB5576162BB29C714CDB8EF9AB0C31F4A66DEF45D9162065DC338A695E981F9D580B8CD336D3B93CA40C33D0669A540FF00EB54E57AD4647CD55723948B693D78A695F973D6A623BE78A695C2F14F9886883F0A630F4E953B0DB4D29D28E6279484AE79A66D1F855864EA334C65E314C5CA418C706A36F6E2AC32861C9A8CAF5155CC43B91153D31CD336F5AB057B5336E3F2A3988E520E87269301B3DAA6F2F7673DA98CA79E2AB988E52268F907BD4641E6A7DBD69B8CF63D7D69F310D1032E39EB4C65C76A9F8C918C53187B552919B895993DF35195F6AB4CBC71C1A8B6FE355744345765A89BDC55A65C6735195033EBED4D332712BE3351B2F6A9D93E5CE2A3C1AA317122DA4514FE0D14CCB94EFC2EEE3391EB4EDBC77A5FA503AEEE4D6973BEC20C0FFF00553B9E69707D0D1B7DF359F321A41B862942739CE697EEE0F734923AC11B48CC022825893803DE9A69E882EA29B6C76C03AD3D7DF9AE1EEBE327856C9E453A8F9BE59C37931B3E391F9F5C574DA1F88B4FF106989A8D8DCACB68E71BCFCB83DC1CE39FFEB554A9CE2AF2473D1C5E1EBCB929CD37EA692F3EC7A52ED1C50BF3639FCA9C472B8FC6B3B9DA90AA09EA39A0295EBC8F6A555C30CF4EB4F0BD3BD05584541C1C714ED800CF3F953A352DC631DA9E7A63A9A5A176100E0678A72C676FD2957B53F6FCBE9537281546DA7AA9E7AD3BF869CB9F5A9E61A5A08B1F5E7069CA9D29554F5EB4EC05A9E61A4183C1A3D38E29D8F945380A8E62EC204C1F5A1548A71CA8000CE69DB7F0A2E5584DB8EB4EDBC538AE54734BB4FAD2B8EC336F19C53BDE9FB7A8C0FCA9C17D295C6300C7414BB0E4F63DA9EAB91EB4A178C139A006EC39146DC9A7ED38C539576E3BD0045B4EEC53B6F1CF5F5A936F3D30697CB3D4F4A4045B07D314F0BC669C54F14E443DF9E69F4023F2C6EFE94EDA719C54BE5F27D680B52044A9BB83D3DE97CB1D2A5F2C7714BB78CF6A43B11AAF507A51E5FD39A908C8C678A5F2EA6FA9445B79E9CFA52ED3E9C673526DE7078CD2ED15171D888AE7BF3E94BB3BD4AB1E28F2CFA751DA9A6222D98ED9A15739E79F4A95541ED834EDBBBA0A398BE522DBC668DA3FC2A5F2C75E9F5A4DBD3DBD28E6B93623DA339EFEB46D23A8A976919FF0A55EFC66A930B1171D33CD1E5EECFAE335315DD914DDB9EBD68B85862C7DFA8A31DB1F4A902F4ED46D2DCFA53B97623C76C77A4DA3B1E3E952ED3CFAD3554F000CD4F30586676E06DE3D2947CC381C53B69E8066942E381C67D69731490D61B707BD2E3A734FDA701473498DBDBBD4B95C6376FA7346D3D8538FDEEB8A54E01CF4CF5A8722AC376703B7D6976EEE4714E51D33CF39A30783D3E94730584DBD71405CE31D7D69D83814E20FA54B90C8F6EEC6297677A78C2F4EB46323D29F300C55EA40CD2D382EDE01EF46D27DA97300CDBD68C738A93F4A4DB9191C55F3058685CF3D334AABDB34EF63C527A8A5CC3B0B8EE290290BED4AB9F4A72FCC7A51CE21BB68DA41E9C548CBB7E6C527F0F4C51CC3B0C20F381B6855FC2957F2A771D8F5A9B8EC45B790474EF4EDA77629E334BB4B2820D1CC5588C315C71814EDB8C1CE28DBEBDA9C148E48AAE60B0CE781D28C1EDC548D96E3A5347CDD28E61728153F9D371EA29E7EEFD3B529386031D6AB987619C938A029EB8C53F04F3C0A4DA718A9E61D88F6FCBDFAD26DE48F4A90E7391CE682A47D29730AC4454F6A1870060D48BFD314E61F2E40A1482C43B4E7DE9EA0F7A5A5A57111E37703A8A1A9FB7FC8A4DA33EF9A7763B11B29CE7151B01566A261F31C8C5439D8A48842E3AD1B734F6FA714C6F6A8551D8BE543586D18A6ED3D7B51939F7EB48B9A9949B1A490A17F1A6B72C69FB7A51B7E6ACEE321D9CE307F0A42A179EA6A6C75E714DDBBB04F1577E6021EBC8E6823760D49B0AB6077A1B6A9E7BD3D008B6F4A31B5B18CD3D57774E4FA53821DC0D17B09906DDC7348EBE95398FB526D1F4A2EC2C570A7EB48CA7F1A9D97A914DC7CDCD176162BED392718A866896456570195810548E083D6AEF97C1A8DA31493138A96E7C53F183E1F49E01F164D0A12DA7DD666B673D949E54FB8E9C7B57B1FECDFF1046B5A33F87AF1F37B620BC0CC79922F4FAA9C7E047BD763F1A3E1E9F1E784658ADC01A8DA9F3ED8FA9030533EFCFE2057C9FE0BF12CFE0AF1558EA68ADBEDA5C491F7299C383EFD7F2AFB1A328E63837097C4BFA4CFC531B4E5C2F9D46BD356A53FE99F74FDE030323D290FCDD0557D1F52B6D6B4FB6BFB49566B6B8412C6EBD0A91C7E357557B74AF9095E2F959FB3D3946AC54E2EE99132E7DE91BD33F954DB7B1E0D37674F7A8E634E5447B477EB49B4EDE6A42B9EB49D78C55DC7623D838ED48C9C640C0A971B7B64D201ED55764F2B2165C669A735315CF5A465EF4C9B1095278EF51EDC726A66CD20C1E734730884A9ED432FCD8A95971CD26373138E3D68D3A81063DE902F3536DC1C75A6ED3D4734EE046C9CD47B7AE3A7A54BB4B76A465F5E3D6AF5158888EFB69ADCFBD4A704F5A61FA53B86A42DDB23029369C918A95978C138FC2936F6A7CC4D887692A78C533AE46715338EA00A6B285E3AD352219195E0D33CB3B8D49B69196AB984EC43B4F1C5376EECD4C579E9C5376F5A7725A2165C7BD376FF002A94AE187A537EBC7A5172394899719CF351B2F5E6ACEDDDF5A8D96AAE4B8D8836F5FD298CB8CFA5582BD2A365201079AAE622C42DDE9367B54BB73D39A4DA69DC5620DBD734D2BB7DF8A9980E94DDBC5172394836F5A6B2ED238E95636E78A8F6D3E621C4AFB3777C531BD866AC32E314D65C37AD3B93CA56DB9EA69854F3EF53EDC1F6A6367145CC5AB903544D8CF4AB122823238A858671FAD68A464E240DD7DA99B47D07AD4EDDF3C546CBB8F356A4612457C7B515295FC68A7733B1DFF978C7AE29DB79C7B5320996E11644E5189009E01EBDE9EE55464B2A8E84961F9E6ADDD6876269ABA136904E4D3B9523D7E95E7BF113E2F5A7836244B7486FAF9890D6FE761931DC819AE3742FDA347CB0EA1A7ED8FBCB1C858FF2AE9861AA548F324785533CC050ADEC2753DE3D7BC4FAC5C68BA7F9D696BF6BBA92458A38D8ED556638CB1ECA3BD78678CBE356A97F637FA3C9A7C31ACA1E16951D8670C4641CF422BD52D3C41A3FC5AF0EDCDBDB5CCF04008F3F036381FDDEFD47A1AF2FF889F082EEDB527B9D1A19A7B59388ADEDD4B79602AF2C49CE383DBB575E1A3084B96A2B33C3CEEAE32B53F69829DE0F7B1E3D815D6F83BE246A3E0DB3B8B481239AD66757649777057B8E78AC4BEF0DEA7A688FCFB3953792A3E5CFCC18AE3DB9047E159BB7D457B8E30A8ADBA3F2FA75ABE0A7CD16E2FEE3EB0F05FC4D835CF0CDD6A7A8DB36982CD774AD8DD1B29190CA73CF4C63D4D70FAF7ED1BF6CF32D343D3255959B6C77170C32477F93D47B9AF22D07C44DA7A4B69751B5DE9D3232980CCD1AAB1E8C0AF071F4AA4D6ADA85D2C16CEBB002132428C0EE7DEB8238382936CFABAFC458BAD4610A52E9AF767D17F09FE2EFFC2512AE93AC1D9AB60F97208F6A4A064E3D9B8AF595C8C57CA5F0CAF74AF0BF8834FD46F356895D58F9D6F22302836B00738E4F35EA571FB456827505B7582EBC8120066F2F823B9C67238AF3B138797B4FDDA3EC329CE692C247EBB51295EDBFE67AF29E4E0E69C8BB9401FF00D7AF22F117ED19A36957221D3ED9B558F66E3346FB5771E8BCFA77AF3FD7BF68CD7F50BC47D3E286CAC8302612A1CC9EA19B1FFA0E2B0860AACFA1DF88E24CBF0EF954EEEF6D0FA842F3D29FB7DF35E2DE1DFDA4F49B98122D42CEE2DEE4803728DC84E3A7B735D3E97F1CBC29A85D4711D47ECC5C003CE4650189FBA4E3F5AE79E1EB47747A54738C0D64B96AAD4F4600374A5451DAAB5BEA16F24888B20DF202554F52319E077E0E7E957157B9E05723F77467B116A4AE989B496C7DDA9154B2D3B9DDED4EDA78A9B9761BB4F18C734EDB9F6A7607D29C173D693762AC263D79A5DA39C734E55038A705CF14143369E78A760D3FCBC71CD2ED3CF5A2E03429FC297CBEFD6A5D98E0734A171D0734B9808F69F4A555EBC54BE59FC7D053957D39A9B8EC302EECFE94A232DD69C8BED918CD483AE28B8C8B6EEF6A5DA7B8CD3C0E7D29CAB4AE04617F1A1415A915723D0FBD3B6671B854F30C8F6F419A7050CBEF52797D7BD2EDFCFDE9730588F6EEEB4BB7800739A902114AAB9F7347305887CB2B9E314AB1E6A7DBF29346CFCB14AFA5C76643E58DC78A72AFE55285DDC91CD26C3F415372B9488AE41C0C1A76DE0E054BB0E493C50568B9445B33ED415F5E2A5F9B938E01CF4A36918E3353CC87622DBD3D69DB4714EFE2A1569DC4336ED341185CD481485E6864C0CE28E61588F6EE07B5013E507A1F7A97686EF8A630F97A66A82C331D78E828E79DC2A5652BDB8A6E0F5A398A198C526D3D739A936F4A1A3F96A1B190FE14EA936FCBD0D1E5FE553CC5588F6F4C734E519E83AD3B69CD3F69E462A6E1622E38E3EB4BB4FF00F5A9FB4F6A7051E9CE69733B8EC47B48EBC9A4DBDB1536DCFB50401C52E6023DA7800D2ED3C64E29C17D052A8EF55719195DA49C526DF98D4A57775E946D19A570B10E0743C53F9A936ED1EB48AA7D39F7A3987618CBB7DE936B7A1A9769F4A5C67DA9731445B7DA8FC2A5DB405E703A7AD3E610CC0A42BF2D4BB4F403349B7AD2B80CDB95C51B76FE74FEC3D69707D39A57603368A455F6A9B91480738E94F9808B69F4E297AAF4CD49B7AAD26DEBC6295CAB8DDA29304E6A403DA97675A3982E336FCBD39A3039A90AFB52329A398633055BA505326A5DBD4FB5376D3E601AABB693195A9307A1E682A7A628E602365E7DA91863A549B7A122865A5CC0331D07BD2ED3BA9DB70A3BD18E871D68E6019B71CF5E29A63C54DB4D232EEFCE9F30106D3CD26DED536C3C1C8A5DA4718AAB8112AFA8A465EBC73526318A5DBD4915131A29B0FCAA2653C0AB7B054663EC2B9948D0AC6304E71DB14E0BE9CD4AA99E29369AD2E047B72B8E946DC71D6A5F2FA67A52EDCF438159B6043B416EBC52ED1CE39A90C7B7D69761DB82314D4AC040CA3BD2797C6319A9C4646066976D37202BAAE07039A695231804D4FB79F4A431E7A9A5CDADC0836FE1F5A663D39AB3E5F193CD33660648C9F4A7CC3206538F7A6ED27EB560AEE007348506319C73473058ADB0F27F5A630F97356987A0CD31A31D00C0A570B14DA31FD6BE3EF8FDE096F0978DE5B88A3DBA7EA39B88980E03FF001AFE079FA1AFB2FCB1E99C8C579CFC74F05FFC261E04BC48D7377679BA878E72A32547D56BD6CB715F57C426F67B9F29C4D95ACCB2F9C62BDE8ABA3CFF00F65DF187DAB4FBDF0ECF2665B7267B7563D509F980FA1C71EF5EF4413D457C19E0DF125C7843C4DA7EAF6C4EEB790332E7875FE253F8715F76E977D0EAFA75ADEDBB6F82E23595187A30C8FE62BB738C3FB2ABED63B48F0F82F33FAD615E12ABF7E9FE5FF009F147F0D3D9369E99146D056BE78FD208D97E5E28C02B81C9A900C718A6EDE71DEAC561BB76FBE698E3D2A4DA57AD237D39A41622DA7A8E69196A51EF4D65DA71D6A9482C42CBE9CD376D4ECBC9E39F4A66D1F4A2E2E521DBCF27F2A19483D38F4A98AF191D69ACA49CD3BEA1621DA2936F4A95A32B49B4F7AAB91CAC85A98C9C66A6D9B813D29BCE334F9839590ECF6A8DA3F4E6AC05E714C64E739AA4C562BB039CD260F3DAA768FF002A685C669888B9DA7A53197BF7A9F66401D0D3369E3BD2B93621EBED4D6527A0A9BCB0573D299B48A61621DA79F4A4DBC6454C57DA9BB71FD69F31362164E714C2315291CE7BD35B2DD0734F989B117A7D29ACBDAA6C1FC69BB72D9CD57312D5C808F4E78A69519CD4C54F3C76C533D78CD57313CA445768CD34AD4FDB34CDA3BD1CC4F2909C938ED4D68FF954DB7E6A6EDEBE9EB57CC676212A6A3DBD8D4FCFA74A6B2EEF6145C8E52BB2FA531863079F7AB3B473C544CBEB9AAB92E240576A9F5A8D97BD5865EE3F3A8DB1CF7A7732B15D96A1652DED569948E7AD46CBEBC555CCA48AAD1D3197BD596EFC74A8997E6E7815573094480AE28A936D15572394F9FF00C09F10B56F05DCCBF6296231489FBC86E3FD5B607078E7349ADFC50F126B81D25D62E7C976DE1233B17E9C006B94A736D605B90D9C6DEF8F5CD7DC3A5072E6E53F9F3EBF89F64A8FB47CABCC7348D753879E6662C72D231C9FAD4D71A4CB6F6F15C10AD0499D8CC79C0EF8ED5547507B8A749234CDB9D8B1F73D2B4D765A1CBCCACD308E57819BCB7D84771D6BB1D03E286BDE1FD1E6B7B7D50B9675291CC0CA40C60F27A28C76F5AE33028C0EE33512A719AB49686D47155B0FAD39346E6ABE31D5356F3166B8CA392C42A01C9393FA9AC3A303D28AB5151564633A92AAF9A6EEC55650D9601BEB4E9A358D50A4AB2071B881FC3CE39A3CE666070AA40C0C01496FE58990CE19A1FE2D9D7EA28EA42D741519836431CE739CD3E699EE256925769246392CC7249A95D209AEFCB80F9311E034C71C8F5A1D6086D668DE3DF3EF1B27593E500673C7BF1417CAFB95B68EA6971D7D4F5A4CD1B87A8A7A9979202BEA3A9E95A7A06833EB978D6B0AB79846D4C2820B9E55492463247149A7E877B771BCB1DACCFB5804511B7CC4827AE3D3BFB8AEB347F885ADF80E37B4B6D32CAD2664F32676837B9C676B1F988520935854A92B351D4F530D8782929621B8C7D0AFA7B78AF4DD6F4F9B37E97B0C8A228E667246085C7E807D2BECBB3DEF6B1194012951B80E81B15F31FC3DF8C5AAB6B2D2EAF78BA9C8EDF25B3C4A833D72A5540DD9E80E3AD7D456E43C68DB4AEE00E0D7CC660E4A4949247EB9C311A5EC653A751CAFDFA0F5E99A7850DDF9A55EB4EC1EFD7D6BC83EDC36FE34F653B85387346DF9B83DA86EE30DBF2F4CD3B1C6053B6E07AFAD2F4CE460D2E61D8455E98A705EC39A7ED14E55A570B0D0A79A70FBD9C7D29C14E3DFD29CAA5B6F1D695C7CAC62AFAF0334EDA7391D69EAB9EB4EDBF9D47315619B73D294277C74A7EDC676D382F50783DFDEAAE2B11EDA5DA4719CD49B7A7A1A558FD067F1A57B6C0336FAF5A76DDB8FA54817E6F4A36F3E948BB11EDA7EDFCE9F8E3DE976F63D7D2A2E161801DDF8D1B7BEDE7EB4FC7CD9ED4EF2FD393473024478F4E94BE58C75C0A7ECEBCE47D2976EEC0A571EA302F03B52AAF18F7A7E0EEE94BD38F7A9B8C671BB9E948CA7774E2A4FC28E3A11934B98111F23BE68DA31F7BB549B3E5E3AD1B4E3A7B7269DCAB91F967A8349B405C8FC6A6DB86E2936F14AE490B2F39FC29C3B669ECBF31F4A360A2E3B119F98F4E29B83F854E57E5E569A57E51C629DC647B7A526DEF9E7F4A976D26DC9ED8A5CC808F1DB8A361E066A5DB8EDDE8DBED51CC323DB46DE991D6A5C6074E686EDC54731445D1700FE94E65E7E53C549B3E6CE79F4A5DBCE73CD1CDDC08D54AF279A4DBDEA6DB8A36FB714AE045B7B75A5DBBBE952F97F9518ED4AE043B78CFB505790454BB4918C714BB71F4A772884F3C01463A7152EDE7028C77FE54B98646BCE4F146D2BDB9A936F5A02F5E28B80CDA68D9C0A976F5F5A5DBCE4D170210BDBA53D5319A7ED1DE8E768A4047B4FA714BE5FB7EB4F0381DE8DB9A5CC033CB149E5F7A936FA52D3E6023DA476E3D68D99F7A705A52BEBC52E6019B7B52852D9E29FB7D781405C53E6018169D8EB4FD9E83F5A00EE4D170187F2A5DBDF34AABCFAD295FC297315A8C2BC9F7A369EB4FC74A5E98E73473088761DC3D294AD4BE9814854F3C8A7CC51195FCBD690AEE3C73529FA5205FC295C066D349B70DD73532A9DA0526086F4A39808F07F1CD18F6A9368A5C75E29F30883CB1EB405A7EDE6976FB51CE323DBED4D91485A97028651CF18A4E5728AADF5E6A3752C2AC3474DF2C7AD6172CAE17183FAD2ED1F87AD49B2811F7EB5576045B0E40A369C76E9537963D28F2FA8A570222A47439A4DBC71D7DEA5F2C95E9CFAD0233E9CD17022C7BF14BE5FE9526C1FFEAA4DBEF4B9808B0303E5A614E3B5580A3D334DDB4B98762BE09A36B7A54FB4FD0D215A5CC55915D579A6FBE2AC94DDC914CDBF851CC3B10EDFCEA3C715636FCDCF14D65E4353E60B106D23EB51B461D48203023041AB5B3BF5A6347D7039AA5206AFA1F0E7C6CF038F03F8EAF2DE05D963747ED36F8E0056272BFF00013C57B2FECC7E3BFED8D066F0EDDC9BAEB4F3BADF3D5A12791FF013FCC56EFED25E013E27F05B6A76F1EEBFD28F9DF28E5A3380E3F2E7F035F2FF0080FC593F82FC59A6EAF1310B04A3CD51FC711E1D7F15AFBAA2D66580E597C4BF43F0BC5A970CE7DEDA2AD4E7AFC9EFF71F7B15F5E6976F4C0CF34DB3B88EF6DE1B885C4904AA1D187752320FE231F9D4F83B71DABE25BE57667EE5092A91538ECC85548CFBD37CBCF1D054FB7AE29A54E49A398BB10F967D699B79CD58DA714DD9F5CD1CC162BE05232E33C54FB7DA939EFD2AAE2B15F6FE749B4D4ECA179A4651D00C9A771101F9738A69A99A3F7A66C279AA0E522EBCF6A36D49E5EEE94DD9CE319A2E4D88F1DFA526DE318E29ED1D21041028B85889940F5A8CAFE59A9F1F375CD3081B88F5ED542B11321E9D29A531EF536D2339A637CD4F981D88580E94D0A739278A9F07151EDDB9F4A5CC45889BE94C0BD3A54CCBBBA535978E78A77158848F414CF2CF3DAA665C9E7A52555C8B10B2FF002A66071CD4CDF7BF0C535970D4EE3D487079A4C0C11FCEA5DA4E71C9A6ECCE4D50AC888AF18A615A9CFD734C6EDC7345C9B10B2FB75A632FCC39E2A7DB9F7A6ED1E94264D8808EE39A6ED353B2F4A632E3DAAAEC9E52274CE315195F7A98034C3DF8A7721A22607D2A3DB5332D31874C1CFE15A5C8712165F96A3DBF363B54E463DEA361B4555CCDA216FE75130AB07151ED1CD5DCC9C4AE57A9A8996AD32F3EE6A265ED8FD69DCC25120DB453F6E3A5145D91CA7C974BEDDA928C8AFD10FE650A28DC303EBCF3499CE3A73407A0B452F2413B4E1783C1E33EB4832CBBB69C640CE3F1F4F6A43B3EA1402B8604FCDC6052C6033A866C027AF6AD2B9D3CC164D770A096D6490C21D9D776E5E49DA09383C73EF45CB8C1C95D198576F27D7A7EBFD3F5A5A9AEAF1AE9553CB48E353911C6303A62A05F73412EDB21530580E99E3A735B769E1AB9B8B35BE58DFEC65B6AB6771DC3A8200E31D7D7158B19455624BACA0829B7A7E35ACDE2AD51AC4591BA26DC49E6EDDA3EF6319CE3278A892969CA7451F64AEEAFC8BDAC7845EDADA6BDB35736514713169586E6DCA49217AE320FD062ADFC3EB5D2FF00B723FED9B1BABAB568C3470431E5A52189E0FA71DB278AADA0AEA5E34D413484B986396E08CCD2B6CC2818233D30064FAF1577C59E15B7F0EDBDA882E05C5C2338FB440EA63745C7CE39C8396031EC6B06DBF724F73D5A718C25F5CA71F7577EE7A34DF14FC3DE24D6A2D1D34FBCB3D3C4B1889AD5551E4D847CAC3D383C0CE715D73FC1EF0ED8EB516AD75A82C7A63C6498EE9D41B966624EE638E0020600CF15F306F96DE45922668AE55C3EF8F2AC0F6391DF35D1EA9E268752D0ADED25D2E0B5B8DB837AA5F7C8C0E599B27049F615C5530CD35ECE4D23DCC3E734E7193C5D25292775D3E47D63A3F84FC1FA6C305B59DB69FB6472F02828589CE46D27923835D805DBC63078E0FE55F05E8DAD5C695A9D95C4404E96AEA638E473D8E783DB9F4AFA97C15F1B34393C1916A5AD6A515ACA84ACEBB8BB062E780A013D31CE2BC8C5E0AA53B34DC8FB7C9B3EC26294A0E2A9D8F53FBCD834EE7D2BC9755FDA4BC2B67782DED0DD5F8E01B8863023CFA7CE54FE95E8BA578B34BD634B6BEB7BD85E044DF21DEB98C1E46EC138FEBEB5E74A85582BCA27D351CC30B886D52A89DB7D4D8DA76E41A917AE6BC8EFBF694F0958DC5EDBACB7539894B4722C3F24840FBA0E739F7C63DEBADF87BF13B4BF88515C8D3D2E6392DB1E60B88C2E41CE08C123920F0483ED44B0F5A11E69474228E6783C454F654AA272F53B25EF4E0BB973D4D22E08EBD3F5FF00F5753520F5ED5CA7B161157F1CD3D475E7F3A30472781522D20102F53D69F81E8693DF1C54981DCFE55221ABF30A7053DD48A7AFCD9A5E17BE452B8EC336F18A76DED4EDBF952E07D68B8EC204EB9E2971DB6D39569DB7E5A9BEA3B0D0BF9D1B7D4F4A9157A83D6976E7BE2A798647B69FB7AD3B6D183D295C08CAE0FF009EBE94E00F5C669FB7775A36F0062B3BB013E6DA69141A936FB50ABF37B517603547504E294A8FAD3F69C8FAD2E3AF1473011EDEF46CC74EB5305CF3498F6A91D88B67CBC8C51E5F6CD4EB1E54679A465F4E684C2C47B7A7AD359768A982EDEB46DF97345C7CAC876E3AF348054FB46DF7A4D83D714B98AB1105ED8E69597AE29F81F8D18C13C7145C2C45B3751B477E2A465E946DC7BD2EA3235519F5A5F2EA5DBDFB7A51B68B8C8B6F233FA52EDEFF00CE9FB78EB4E2B8F7A5CC8443B3F3A5DBEE6A6DA339A3CB353CC042B1F7A7ECC0F514FC6D04F5A5DBCFBFA54DC08B19E71CD0147A549EBC714EA340212B9A36F6A947D28DBCFBD172AE45CD181D718FA549B4F4C668DB4AEED7191941F8D0AA4D498E697068BB023C7BD18F535260D26391E828B80DDBED463AE4629FB48EF9A5F6EF4B9808F8C70286FA53BF0A5FCB14AE0376818A42BED8A76DA5DA7F1A576047B73C52FBE29FB73F4A5E3D29DC062AF6A555EC7AD3B9E78C518F5A7701AAB8ED4BF7B9E94EDBED8A4DB4EE0338DDCF4A728DC714EDA29703D0D4731572361E9D28FE1A715A4C628B9237EEE7D28E0D494D0B45D9571B93471DCE4D3B1D3E5A40BD69F36960B8DE7D29DF77DE8D9DC5260EDC628E60133D78C9A4DC476CD2F5F6A5DB4B98AD066E14B93B68C1A6606304D2E6285DD939EF4991D29ABF2E49A786ED4AE1618CA1B18A6ED1EB52EDDF4DDBF854DCA43369C50A077EB4EDBCE7A9A52A29DC91BB07FF00AE90AF5A7EDEFDA9768F4A9BB288B6F6CD279639C1CD4B8347E14B985722FC29BB7AFB54C57DF9A36D2E619091ED4BB7AF7F4A93667346DEF49B6590EDF969ACB8F7A9994F4CD34AD2E61907AD0D1F5F5A9997DA9BB69730C8368E476A6EDF518AB0C0734DC0AABB02BB264D376FB559DB4C65FCEAEE0529EDD2E2278A450D1BA95653D083D457C23F167C18FE05F1D6A5A688D92D59FCFB663DE263F2E3FF0041FA835F7C34676FAD784FED51E07FED7F0CC1AFDBC7BAE34F6C4BEBE537F81FE66BE8325C5FB0C472B7A48F86E30CB3EBF97BAB1579D3D57EA897F667F1F2788BC2A743B9933A869780AA4FCD2427A1FF00809E0FE15ED3B7DABE0FF84BE283E0FF00883A4DF9731C26510CFEF1B9C1CFE60FE15F78AF51CE41FF00F5D567587587AFCF1DA465C1B9A4B1F81F6555FBD4F4F9741BB7032299B7F3A98A9FAD26DF7E6BE7F98FBE2165229BB7AFAD4D83D734DC75CF154A4045B3AD376EECF6A9249846096E2B12F3C4D6D6A482EA08EC6B48A73F84994A31F899AA579A6B0EB58B0F8BECAE30CB2A15F5F4FAD69DBDF437480A3861EABC83EB8FC6AE509C75922635213F85DC98D33A63BD4B80D9A4FEF006A6FAD8D7522E7D3347D29FCFFF00A871432F614B9856213C8E69BE5EE2326A665DA49A4DBBBF1ABE602168F3CF4351ED19E953B2FCC29AD47305881A3EA69A56A76F7149B3BD1CC472B2BE0F4C546C8578E956714DDBF8D3B858AFB71DA99C7A7156303A8A88A9DDC55264D88594374E94C61F2F4A9D94F6CD46DDC7F4A771588DBDF834DDB52E3BF5A4E38EC2A82C4072B9C5271EB53328E7DAA3DA31EB45C9E5444DF376E6936F7EFEDDAA5DA698CA155AA89B11EDA615DADED53365698D9CF3CD3B8B948981079A611F28A948EB4DC0EF4EE2B11B7CCBD6A32383FCAA665A63034D3337121FE74C6E79E953B67B546CBC62A9326C45B475A848EB563031EF51329F5E29F319B4884AF19EB51B275A9D948A6328AD398CB9485976FD6A22BCE6AC546CBD79AA4CCA48AE47AD15230A2AB98CACCF95745B5B5B8927FB679DE5AC2CC8611D1C11B7770783ED56A3D061BC92D9ACE4FB4C45D04E10E597773B401CE00EADD2B0B8C74E718AD4D17C4DA978766F3B4FB96B694A18CBA0192A4E483ED5FA24A32DD3D4FE6DA35292B46AAD3F13B093E1BFD8E4021B98D86CF2AE1AE13387CB711807E6E147D370CE2B98D37C332DC3248E8E2C8E4C923A152AA1802467EA0679E5BA715A16FF001435E874F164D751BDB86328568533BF39DD9EB9CF7AE9BE1DEB937883C5DFDA1AEC92DC45B49595582242FCE0118CE0FB7B572BF6B4D3933DA8C7038AAD08D2BA7E659F0FF824DE599B3974A31D9ADCA3C97C2126430B01B54AF6393D4804E7A55DF88DE11D2BC27A64ECBA5E6C6F02EC95D446F0CCA4E0804962A5770E7B815C5F8E3C77ABEB134F62F7816C63949486DA3D8BF9F5231D492735C85C5E5C5EB29B89A5B828303CC62F81F8D4C294E6D4E4EDE45D6C7E1A953950A54EEFBBB7DDE82DF185AF2516E1843BB0A1983138FA541B475C52E31C118E7BD15DEB43E56EDBBEC0A0ED240240EA71C0A4DDF81EB4EDC40C0271E99A7473797BD7F8586082324FD298243154B6E20703938E40FAD3949A7DBDDC96EC4C6ECAAC304139CD23633F2F0281CB642233C6728ECA7D57834BB8FA9FCE90F1CD14ACB4761733B58B163A84FA6CC25B77F2DC639DA1BA7D455B5F11DE33C2D7023BC109263499728B9EB80B8ACCA58E1926915110C8EDC28519349A4CD6152A25CB07F21ADFEB0B05D83AF1D0548D732346ABBB2A0631D339A7DE58CFA75C182E6268A55504C6DD40238CD434EC67EF45BBE82670C180DB8F4AE8FC35E2292D5E6B69A26BAB79E13088D24F2C6F3C2B103EF1192013D33EC2B9F48CC922A02A0B7424E2BA6D3FC3779AA69665B7586D23B7658DE5326D2EFCB019CF2723D7F0ACEA72DACF53B707ED14F9A9B3563F849AEEA1A5C9A8241E547E7796219898D95B6EEC9DDFC3D83671C75AE6749D4350D3752F22DB52934F6DE11A586628090D81C838FD6BD9BE1FF8D67D6BC0B7BE1DBBBF5BABD95BCB8A0D844CAA0EF3207E7700377E55E63F11749B5D33524FB059CF6F62C0A896798C86471F7B90A00C71DBBFE5C34AA4A73942AAFF0023DCC7616950A74F138493D56BDEFD763D7FE02F8B3C5FE28F1648D71AA5CDF595BC08B3C374D8565E1772F18C8C673DF69CE4D7D28A3B57CFDFB33F892FA3D3E6D3F50B1F26CA084BC37C576FC9BBEE127DDB23EA78AF7CB6BC82E41314AB2A28E5908239F71DFDBE95F298EFE3356B23F5EC82CF034FDF726F5D772C607BD3B695E71D0D2AF39CF069DB769EBCFBD79D7B6E7D2F28AA38EB914FDB42F41CF14FC0E33523B09B4FA5382F6EB4E238CFB5001DD9A9B8AC26DC6413F4A76D14E1C0CE3F3A76D353CC50DDBD074A76DED4A0669557E5A9BB0102FAF14053E9C53847B78EF4EDBF2FD695C06EDA5DBDB06947D7A53946569377DC061EF91C53B069C31DE9CABD32290C6EDA36F4A7E3B5382E695C647B7E6E78A705A72AE4D3B6FA73537191F974BB7E5CD38A9EB8A5DBCE29730EC46074E6948CD498DD8E31432F04D2E61223DBED415352EDA4F5A572AC43B38349B7DAA61F9526DCE31C517023F2FBF7A0AD49C939E949834D80CDBD28DB8229FD3B66976F435376047B71EF4B8E0715260601A3D054F300CDBD29BB46D27DAA4C05C53B6A9181537023551DE8DA791521FAF349C70734EE03768DD8A4C75F4A7FAE39E293B6318A8B80854F63483AF4A5E4F34EA39804C1EDCD3769E84734FE7751B4EECE7814AE5586953483269D8E319E29401473086E3B1E28DBD69D9E4F14BC52E6288F9EBDA8FE2CD48DE829BB7B7A54DD008A3DBEB4856A4F6EE682BB7A9CD2E6023FAD1B7DA9FB28C13EDEF4B9C061CF4A30339A7EDA36E38A7CC033F952F14B8E31D2970467BD5DD80DDB49B7DAA4DBEBC0A5DA297377019B777D7DA9DB4FAD3B18F6A39E78A5CE047B4F346D34FDB46C347300CC7BD37D38A9A8DBDE95C08B69A0AEDA93EBCD26DA7CC0478A314FE47BD1FAD3B80CDBF371CD2153E9D2A5F4A4DB9A9E61917D78A36FB549B71EE694AD2E61DC876D3594726A7E38A465ED4AE5DCAFE5E79A72AEEED8A93F0A50A0D1CC55C66DC52327A5498EC69CC2A6E45C87069BB6A5DBCE09A08A9E6288B1F4C52ED39CF7A7EDC7519A36FB53E6111EDA36F6CF152632BD6855EFDE97369A8C8F6F5E2936D4BB693A672734B980876D2347536DFC2928E6190ED1B73EF432D4DB6998DDDE95D97723DB4CDBDBBD4D81EB49B7AD171DD1032E29ACA776715332D3597A55730C8F69F4A66DA9CF1EF4C61B7DE9F30C89947D6B3F5AD2A1D6B4BBCB0B94DF05CC2F13AB7F7586335ABB7393D6A365F97A55A972B4D742651528B8BEA7E70F883479BC3DAE5FE9B3A9596D66788E7D9B835F6D7C12F1A8F1D7C3FD3EF1CEEBDB75FB2DCE7AEF418CFE2307F1AF9FFF006A8F079D0BC710EAD121FB2EAB1025BB79AB80C3F2DA7F1AB7FB25F8A1F4FF00185EE86F2ED82FE132C6AC7FE5A273FF00A06EFC857E858D8AC7E5CABAF896A7E1993D59643C413C24BE09B71FBFE13EB000F27149B47A549B7A50CBC57E7CA47EEBE841B0F3C535804524D4FB4F3E95CDF8C3C451E8963233CAA9B467E638AD209D4972C499CA34E2E727648E13E2B7C461E18B590471C8D2E3E5DABC0AF9C35BF89DACEB133B1262527A2B76A9FE2778DA4D7B589043233460E3EF6781DFD2B83224CE48623F3AFD232DCBE14A9294D6A7E01C47C415B15899D2A136A0BB1A1FF091EA6AC717B3A64E4A8738AF45F84DF16351D2B58834F9E4334172FE5FCCC7E52C473FA1FCEBCA07E669F0CCF6D324D1314910EE561D41AF56B616956838B89F2383CD31583AF1AB09BD3A5CFBDF4BF115ADD2B6D99095382A0E4D6BF98BE517DC02E33F41DEBE22F04FC40D434DD62057B8628D20662D93939AF62F8C5F13EF2CFC1F6D6BA748164D406D3246727CB03E720F6E4819FAD7C3E23299D3AB1A71EA7EE781E2AC3E2B075311356E4DCF4AF0DF8A26F18788AF24B06FF891D9334025C713C80E188F60723F5AEC9B23A5791FC2DBEBED3FC27A740B633C76AC9B8341107439EB939041FC715EABA7C8D35B862AE83FE9A0C57958C87B2A9CB6D11F4B95E21E2682A927ACB525DA7D29BF5A9590A9EB9A6ED3C8FC3A7EB5C1CC7B046C0707BD31854C579C9E4D331EF4730586601CE39A6EDEB5205C1A41C6722AB982C41B3834DDA463BD4BCFA51C7A7354A4220D81B9E9510423AF1565B18CE298EBDFA0A6A4162BB29A615C9CE39AB2CA7383C7D69BB7AF1C7AD5733158ADB463DA99B33803A55964E7A533674E4557313CAC81A3FA54672D9FFEB5596519269368E7A555C562AEDF6CD35978C0E6A764F9B8E94D78F19A7CC49015C7AD376FBD48CA7D2936EEAAB8AC42CBBA998E326A72BDFB5336865A771588994FA533D6A72B9CD465719F4A698B94876F5C9A8D810DEB53B2FA5319467155CC66E240CB8CF6A6320E41E2A7DB516D1DF8AAB99F2916DA8CAF1EDEB561976FB9A8DB0BDB355733712BB2D46DEA3915676F5A8D97BD55CC9C4AC46D38EB454ACBE9FCA8AAB99D8F8EFBF4F6A39E878A7DC3A4D348D147E5AB1DDB4BE71ED4CEF9EF5FA77A9FCB561D1C6F336C8D4B375DAA0934F9A29ACE4921910C52290194A80411DA8B7BA9AD64DF148626E995A8D98C8CCEC72CC7249EA4D2EBE457324B4DC4919E43976673C72C7278E946E2BF7495CFA1A2AD697671DFDE2C72CA228872C7AB11DF68EE69DEC8514E72B1582868DD8BFCCB8C0C75A591557187DC71C8C631525E7906E1FEC81C40385F33EF71DCD44ABE6CCA1995371C1273819A16A16FB2252AB2AA9CAE73D1B3D2ACDED9C567753422EE39FCB3C4908DC8DF435517B8A05F0BB12CAD06FF00DD2BB260732F5F7AD3D1FC3379AE5B4F2DAAA930B0056470990727209E38DBEB5915734FD5EF34D63F669DE2CA95201C8C1041E3F13512BDB435A4E1CF7A9B04F63369B320B88B69D8B218E438C827D8F4355776EE47033433B336E762C7A72727A1007D28DD548CE5BDE2839DB93C54F67A85CE9EC64B699A073FC51920FE74CE161C9756663F74F5001EBFD29BC3ED52D81DFDBF1A370578BD1EA3A4B892E24324F23CCE7AB3B124FE34CA7315F2E30B1AEE5FBCCA492D9ED8A9A4B368ED639FCD8D84848112925C1047047E34B990F9652BF52B83B7770AD9F5ED56A0BA5FB2B44572CE7FD61C9DBEB85FAD56917CB6DA4AB1201CAE71CF3E9D3AFE5526C792152CE362B6D0B9DDEE7814349950E78B760B0BEB9D2EE96E6CE79209D7A4913156FCEAECDAB2DC7CF20FDE3125CB00E5B3D5B71279F7AD7D2FC3FA56ADA5DFDCDC6B7159CD6E8645B710B36FC761EF9C77EF5CE5D4314522185C3C6C3A83920F7CFE359DE1277EA74CE3568415E5EEBE9735F50D662FB0F95A7CB736F16E05A279998C873F29C0E381DEBD4FF661F183697E22BE82F7534B5D2E487CC2B3B8DA64C8C1049E0F5E9E95E63E11F016A9E36B7D4E4D2E259E4B08BCF78CB0562A33903D7A7A552D37C3BA85E3A4BE4CB0C0D279667284AE41071FAFEB5C95A9D2AB4E549CB55F79EBE5F8AC5E13114F14A2EDD3A268FBFBFE12ED0A3BC7B67D5AC96E2360AD135C286048E98CE735B29F32F1F377C8E783FF00D6AFCFFF001559D8E9BE20BB8EDB5837F67148BB2E782D2F030DB73F8735F5CFECFF00E36BDF1D7825EE6FFCB67B5B836A9322ED2EAAAA72C3A67E6238F4AF93C6E07D8535520EE8FD6B26CFBFB4ABCE854872C96D6EA7A62A93CE29FB4B51B7A73CD3D53DF8AF1398FB1B0D008A7E29DB7E619E9EF4AAA7BFD6937CC16117BE453B6E7DA947A5387CDD690584FBBC0A5DBF2E01A705ED8A5F2F8A9B886ED3F8D281F3673C53F69F4A76DE295C08F1F37B52AAFE74FDBEF4EDA3774A9E61D866DCF5A5C1E4D38FCBDA9DB719CF353718D55E314E51E94E03E634B8A4D8C6AAFA52EDA763F0A003537603769F4A36F1F5A7E0E7DA9D8F5E2A7989B91ED3CF1D28EBD78A701F74F5A369CF4A49B1DC67BE38A4DBD4FAD48334DE4F6C555CAD0632F4078A5DB8C53A9790BEF45C3419B6936F5F4A93069A63DBD295C2E37BE28C0A7ECFCE936D4EA171BB7E5F5A31D4F434ACB46D345C62FA1C5205C1E29C07AD2E339A96C5A0DC7B5376834FFD451B4366973068336F6A5653D4D2EDE0D2B2FBD45F50B8CD87B52ECDD527F2A39A7CC1722DB8F7A383EC29F4BB474A9BB18CF6A455A7EDF5A3EEE33CF3400CDBEBC1CD0A3F0A7F1EB8341CFA545D25601BB718A36FE34EA28D00681D3D69369C8279A7AE3349B4FE1537189F77DE8EF9A5DB8CD2F6C53BAB0AE37068EC71CD3A9319F6A2E3136E4D2EDDA33D69E29360A7CC03403DE8DA4E78A90628DBCD2E626E336FB51B466A46A4C52E60B8CE7D293F0FD69FB76F5E69697305C8F6E7A7146DF949A7ED18A5A398645B7D39A369A931F37A8A4DB55CC319B76FBD1B7F2A7EDA4DBC63DE9F30EE336F3475A7ED2327AD153CC1719B71CD2D3BF8BD6936FE34B982E46ABB78A561DC1A78F9B8342FEB4730C8F07A50176E3152EDE78E69368CE6A6E2B9160EEE94B5214C7BD215153CC511FF003A4C7B53F68A55C77A5CC033028C1F4A76DA752E6D02E45F7BB5014839CD3CF6A36E051CC03391EF49CFA53F6E29368A772AE33AFD2A3EFD6AC30A66DF6A2E52631A9ACBD33521E0534FCD41572220D2D3B1EF4BEBEB45C2E42CA4D1B6A42BE949834CBB916C14D0BD7BD4DB6931DA8BB15C8594F619A6B29A9F6E7EB4CEB9E29F317A1E4DFB46F847FE12AF86B7CE89BAEF4F3F6B89B1C8DBF7867DC13F957C6DE10D7A5F0CF8A74AD5A2251ECEE1253B4E32A0F23E98CD7E8CDEDA47796B2C132068A5428EA7A107A8AFCF1F881E1893C1BE32D5F4891580B69DD63DC3EF21E55BF106BEF787710AA53A98593F3FF33F1DE39C1CA8D6A398D35AECFE5B1FA09A7DF45AA58DBDDC0E1E09D1648DBB152320FEB5636F15E31FB2DF8E97C47E083A2CEE0DF6907CB00F5784F287F9AFE02BDA8735F258BA12C2D79D27D0FD3F2BC74730C153C447AA57F52ADD4E2DA07738E01E3BD7C8DF1F3C557FAA6A4D6817CBB4DDB720E7711FED57D2FF0010358FEC8D1E5919CC6BB7963DABE2CF1BEB726ADAD4B3BCE8D12928BE582339F41EBEF5F4190E1FDA4FDABD8F93E31C77B1C27B084ACE455D27C18BAD6120D674F1704FFA892429FA918FF3F8545E24F056AFE0F917EDF0F921C65595F2A47AE7B8AC4BADBBB688F69EA4B139A7CBAA5ECD0A412DD492471FDC477242FD2BF4051A97BA969E87E192A986E470942D2E8D3FD0AC5B71C9EB4B4751E94B5D0797EA496B23437113A1DADBB83E9EF5D15D5F45AA6B514426678E35585654888320CE4923A926B98A9B4FD427D36E96E6D9CC732F21875158CE9F37BDD4ECC3E23D97B8F676BFC8FA2FE19EA0A6E059FDA59195408E3BBEA17B9019481D0F523F0AF7FB18D96DD323E6C76C7F4E2BE7CF813E2CD3B5CBC94EAC0DFEAF21DCF348A0B20038C37B0AF45F187C63D23C2B7F1E89A6BC77DABC830220772467A85623F88FF77B77C57E779851AB5B13ECE11BB3FA1723C661E865EB11526945BB2FF23D19B18E948AA7939F6AF30F0CFC5CB3D46F62B7D4AF24D22F6641B16F221F6697DD5B6AF3DBEF63EB5E9F1E76A938248C8DB9C7D7DEBC3AD46741F2CD1F5985C5D2C6272A4EE4678EDFAD27AD4BB7DBA8F4A6F97B96B9EE77588B6D3597AD4CCA47B535971557416212BB48A4DBEBC54801E38A4DBD71CD3B8881969A57902A6DBDE995571588F6F39C734CA9581ED4DDA3D28B8AC45B69BB42F5A9997A533A76C0A7CC1621D9DF34C68FA6054FB7A5319777D6AD48442C98F7F7A632FE46AC6DEF4CDA3D2AB985645639DB9EBF853767E7561978FBBFAD34C61792734F98562BB2D30A7B55964E7806A3DA4AE718AAE60E520653D853194F426A7DB9EDDE98F186C60E2A9488B320D98C53197DAAC347D298467B50992D158AFCB914CDA5BB54ECA7D3069AD1D69733B15BEF1F7A8F6FAF1561969ACB4EE6762BB2D3197B8E6A765E4F6A8DBE9549993442DF5A2A42BE98A2AAE65CA7C97E2FD362D2F5996180B8C92CCAE172B939C7CA4F3FE71588D91DBFCFB56869F247717E67BD9DF7677333209198FA1048CF6FCEBAA46F0DC8D70B732269C1A2C285B6677DD8E000490A093D4E7815FA6F33A692DCFE6454638894A719249F46EC737A0F87DFC457C6D219A38A610BC8BBB9DEC39098EC6A95F5A358CDE5B891245F9658E6408C8E3AAE33DBDF157D3505D275679A1916668E5DF0CF1FC98DB9C631D3A8FCA8F14EAD1EB9AC35FAC92CB34CA1E696550A4C98F9880000067D2A939392EC4CA14FD869F127F819028C03D79A558DCF2A8CC3E948587D2B538B50C60FA9A4C77CE78C53D03AC7E684DCBD37E3201EC0FBF14D690B0519076AE3A0A689D8314FF240B71206C92482BC67EBD7A5333ED5A3A7C7F6926D4169A69D9628428C609239CFD2A5BB235A71E6959EE66EECF4FAD4D691C324AA257F2D7924938EC715BFA83E856F7735AC9673011A794B7113E0974CEE3B4E7EF1C7D2B26C74D9EF2EA0B4B2F9AE26DA02ACAB8E70D8CF6C0033FD2A14D35735745D395AF737BC2FA6E95AA69FAA26A1782C5E144648F6AB34AC188C0248E707A5645CE9A2DE592E522966D3925D9BB853F4279E71449A6B59DBCF25EC6229A40040369C37383823E5E3DEADDE6921AC605B4D4FFB4E35DACF043148A2263C01860067AF3ED59DECF7DCEBE55520A2A1EF47EFDFB0AC349D46E9E1894D9C6D71184691B7158F6E1F2D803D4F20566EB71D9C7A95C269F334D622422369060B2E7AE29759D06EF41BA5B5BE85ADA7DAA4C322E1D41008FCC126AACD3B4EFBE4F9DB017A6380315A4526EF17A1CB5A6D2F6738DA49F618B907E5EE3F4AD79A4BFBBB18ADCC48AB00DE4AED566DD81DBE82B3F4FBB6B1BE86E1300AB6EDDB03E07A80460FE34EB9BE6BABC96570B2062705A2087A601C2E39C76E954FDE689A6E3C9BEE6BE8DA94B16993DA1D2AD678636499EE1A0CC89823E5273F749E2BB9F88179E1986C749B6D16E7EC71AD9B5DBCB04799249194284247DDC0C83E98359FF0E3C649E12FED5D4EF7455B9B1982DACAA26C6D07071B189249C707D8D70FE27D5A0D735CB9BDB7B45B1B793688AD95B22350A1401F9571723A95B556513DC957861F0497329395B4B6A92F32078D648D6E1668CB8214A00779E33B8E7A8CE47E14D92DD96DD6E8B2346ECD85F3016FCAAB6D1F5A368CE7183EBDEBBACFA33E7F9FC8FABBF65DD5BC2CFA4DE4560B259EB2427DA96E2452B260758FA7191C8F7AF64BBF0969971A1EA1A741656D14778B20936A0019986324F7AFCF3B4BA92C6E04B133075391B588E6BD7BC27FB4DF88F49D5E23A8F933E9BB7635BC2810818C021BAF1EE6BE5F1996D6753DAD191FA8651C4982FABC3098D825656BADB53D47C27FB2CDB786FC410DE4F7C97D6913EC782E130258DA2656247F092E723D00F5AF5DF04F8174AF00D85CD9E910BDBDBCD39B831B313B58AAA90327A7CBFAD79D7C3BFDA534CF1C788A2D224D3EE2C259CB88672EAC84804E0F42338F4AF668DD5A40A082719C7D7A63D6BE7F193C4F372D7DD743EEF28A196F27B5C059AEFF009A24523F0A95538229ABC718CD48A3B579773E8D6BB0A57D6976F7E94BF8714EA8B8EC3428C73C53D54FE1EF4E5A7EDF6A5CC1623DBC839E29DB47AD397B538A9A5CC88B0DC1CF4A5C718CD2EDC63346DCF7E69F30C36FE74EDB9C9A368A772DD78A8B8C6814B8C75A72FA52AE6A3985710AEDE7A8A36F4F4A76D03DE971EF49C82E37A7BD14EDB8E4F146DC76A2E48628C734BB4FD297B62973011AFD295B8EB4BDFAD387A7EB51CC8067349B7F4A7E0D273C53E601A57A62909E98A7EDEB474F6A572AE37AF7A2948F4A36D17EE171BB79CD2EDEDD0D3B6F4C1CD37673D695D8C4C0348453CFD285C76149B1E833F0A5551EB4FDB474A9BB26E20E3A0A36D3F8A38F4A2E1719B693A7519A9307AE3347AD45C2E33B628C75A76D1D6932775174171BB41CF7A29D8A4C64E0D2E643D04A465A7ED14C707B7383CFA0A9E628A37B232465958061D9BA547A4EAF1EA48548D9321DAC99C90781FE7F0AAFE23F3EDF4FB9B98363C90A16309C0DE00E4649186EE0D7CE8BF1A6DFC3FF001534ABB8EE77E8DA8A88AE39E13381BB1D88EFF4AF470F849E2A127057B1E662F30A383E5F6CED7763EA4C63DE8ED48195A3057953D3F1E948B2A4AAA6375704E32A78AF32E7A5CCB41DEB4A71C7A5341EA7391D3FFAF5E77F17BE29C5E02B4B3B2B50B3EB5A949E55BC391F22FF00148727A0F7C735BD1A53AF35082B9CF88C453C341D4AAEC8EE1F5247BA6B58489675E5F6F2101F5AB8AA540F9B737EB5E45F0FFC4B7171225BCC9716493364485559277C72C2404E4FFB39CFCA7A76F59B7552BF2C9BF8EDD69E228CA8CB959546B46BD3538EC4A319E94BB69DB7F0A5DB5CBCDA58DB41BB4F029CBEB4BF850A39E98A5CC2BA1368E99A33ED4BB69DB68E615C8FF0A36D498EB46DE297305C8F6D3A9DB453769A3982E2639CF7A69FA53F1F9526DA771DD09D00A46CD3A8A2EC571B49F853F68A5C7434F98647F8D0A39E453CAF19A054F30EE47B79A3069DCFAD2FB77A5CDDC633E9404FCE9D8A06475EB45C06119E9498F7A9168A5CC0479F6A534EDBD73C7349F853BA2AE376FAD18F6A936F7A51D052B8113527B77A7EDA3D6939241718CBF8D2E3BF7A762855A8E610CC629B8C76A9286E7AD3E604C8F696C73494FDA7A679A6F1F8D1CC68991EDC8A465DB525260F193C53E62AE336F5E2936F5A969B47305C8F6F14DF4E2A5A4DBB7AD3B9445EF8E291BE952B7A0E94C65A398A23DDED47F0D3C2F349B6AB982E4520DC057CB3FB5E7821A3B8D3BC5104784702D2E5BFDAE4A13F86457D52CB5C9FC4EF0BA78C3C0BACE94C819E6B76319C67120E548FA102BD4CB316F0B8A8545B75F43C4CEF00B32C054A0F7B69EA7C85FB37F8BC7863E2759432314B7D4C7D89F8E77311B0FF00DF5FCEBEE0E3A57E694524FA6DEABC6EF05CDBC990C386465231FA8AFD05F863E334F1FF0082B4CD670A934D1E2745E8B203861FA67F1AFA8E25C35DC3151D9AB33E0B8131D68D4CBE7BA775FA947E296986FBC3F701537394247E55F36780FE06EA7F10AF2F752B83F62D36D59A38D997EFB0E303DBD6BEC5B9B38EEA231C8372FA5436DA6DBD8598B6B78D628B07E5418192726BE7F079A4F074E50A7F13FC0FBCCCB25C3E6B569CEBEB18FE27C43A0FC1BD53C67E31D474DB47105A58B1FB45E48380338E3D4E7A56B78ABE07BF866CEF2E23779E38D711865C12C4F00E33C9F6AFADED74DD33C2B0DCCECF6F671CEE19E5930A3818E4F4AF3FF1DFC5CF02E9718B4BCD504AEE372FD9E179471D0E40C67E84D7B90CE3195AA45528B6B43E527C2F9560E8CDE226949B766DEDE47C5B716F25B9DAEB8FF3FCEA3C8AEC7C7DAC68775F6783433E74414EE9648997E663BB8CE0F5E39AE3D31E62171B941E429C66BEFE8D47529F33563F13C6D0A787ACE9D39732EEB611891DB3EC3F3A4CB36054B1CE6D6E7CD84E0A9F94B8CF6C527D9CA063BD41550D8DDC9C81FE35B5CE3E5474FA0F8EAFBC1F67341611C49772A94370465972307F1A3C13E1A9BC59ACB34B7E60B8DDBD9CBFCE49FE2049FF003EF5CFD88B559435DDC32AFDE223525BF9577FA0F8EFC33E1F91248AD350B82B93825573C73D4FAD79B5E32826E946F27D4FA4C0496225058AA89538EC9B3DDFC33E07D42D7ECED3DC2EA2A502FDA8A843B48C1CA81D08EC770EA4E0E01F52D334C5D36CD215C6D1D001803E83B5783693FB5378774DB5585747BF0149CED65E49EA7AF5F7ADCFF86AEF09491E56DF50493BF9D10551F8826BE071583CC2B4AF2A6D9FB665F9B64B87828D3AEBFAF53D9B6919E3B5376F506BCA349FDA37C39AB5C2C51B5C3BB6015F2428193EBB89FD2BD4EC6F22D46D56684E51B9073D6BC4AD87AD8776A91B1F5585C7E1B1A9BC3CD49790EDA7AF514DF2FA7353F97C75A36EDEA735CDCC7A362BECCF7A465F9B1539539C53761C834F9892BF97D7BD31976E3D2A728476E29A57B75AAE602BEDE334DDBE9C8A9CAE3B5376FE34F98562165EA698463DEA775E314D31EDE4D5DC2C40CB4DD952B2FCC69B83CD1CC162265C0FFEB5336F5E3E95314DDDE9AC3A5526C8B10329A6B027DAA72076E29ACA29F30EC405475CF14D3ED53B2F1C5336F26AAE2B1032F4ED5184DC79E0558DA79C8A66CEA3155CC1CA5765C7B9A67DDCD586502A165F6CD5264588FA7B9A88AFE26A7DBF9D33EB5A5D90D22AB0E9C52301CD5865E94CC7B55DCC9C4ADB6A361F31A9F057834C65F9BAD52666D15F6E3B5152628A2EC8E547C56A029C83823A2F63437CD9CF1DA933F9D048C1E6BF5C47F26DFEE3761F0FDAEA1A3DACB6576D2EAF24CD1369FE5F24019DE1B3C0C11F91AC79E1FB3F960C8AE4AEE3B5BEEFB1F7A9ECAEA1B712F9B0B3B104C4EB26D646ECC7D4554766919998F2C727B64D6714F999BD470945492D4B0AC63B560CE771202C6A4138EBB8FA0AB7A1E9F1EA57D1DBBABCE652142467695273CFDD39C63A5517B8D8C56179155970DB8F3D066961BEB8B5911E199E375E5594F23AF3FA9A6EF6628CA3192E6D8BD169062D6ADF4EB9B8305ACD346AD267F858F0E47D093F4AB9E2AF095E783753FECFBC28D3326F2B102C0824E3071DC60F1EA2A28358B5B8D1EF22BF865B8BF703C9B8F30EE5C6300E73C75F7AD6B8F1F49AE69B22EA7A6C7777B1411411EA2A0F9B12A1C02727B8AC1FB4E64D1E8C69E1A74DA72F7B75E9D51CA436B2DD090C313CBB177B2A0DC554119271F5C56CF857C1DA9F8BB5686C34D8156E0219DA432600418F9891D30463DF22BB0F15FC46D26D5B4F7F0A6912E948962F6B7324F1AA19D1801920120F201CE6B3FE1886D7BC5C82EBCEB99658D9A489653009422E426E0700719E7D2A5D4A8E9CA6D58DE960E87D6A1454B9BBDB45F266B6B7F05F56F08F8127D6AEAED1165857CDB268B2E8C64000C9E9C739159DAC7C3F6D1ADD2382357D4658DA552938CC6A1872E80FCA4A95201FEF76EDDBFC44F19EABAF782BCB4882694B2A178A457691B6B8E44A461B9239033D2B94D43C1B76DAA432BEB0B65AB5C3AC2D6BB1A27F3242A31DF82A4E5B9E87B9AE1A556ACA379CBAB3DEC56130B1ADC986836AD149DFBDF557EE69E95FB3C6B5A9C91DB5EDDAC1A93B168E1037958867321F4524003AE793D2BBEB3F823A2DBFD9AF20D4A4B76B41E5DCE9CD06F2F20EF8043678CF7FCB9AF67F07F85E3F0D696B134ED7D79261AE2F66E649987424FA018C0E959BE27D360B7F1568D7281A3FB54AD1DC3C4C50B2AAB6D2D81CF2C307B6063AD7853CC2AD49B8291F794387F0986A6A6A17969BB7BFF5B9F25FC66D521D77C70AEB14F67161626FB47CD22804A963CE7180383CD73FE21F01EB3E19B586EEF2CE58EDA6457590A1C00C48404FA90338F715EF1FB41782F48F05DA69DAED85AA8BD9AE995DA6632EECC67B3679CF73CD79078C3E2C6B5E33D2ECACEE322CACD832E380EE3A16EBEDC57BD85C44AA5383A5F0F5B9F9B66983A542BD68E2A4FDA5F4B2D353889A378A4DB2C6CADFDD7041E7A75A6E3E620AE1BA7BE47B76AF41D4BC5FAB0326A1AE688B2CD711EEB4B86B731F9396DC0AB771DB93F4AE0AEAEA6BA9A49276323B312CCDEE79CFE63F4AF5213735A9F3588A30A36E595EFE56B0DC9DB8E7667F0E3A7E5CFE74DE58FCA0939E31CFE94F323490A0FE053447234720743B5D4E430EB5A6B6396E0D1958A37DCA43E781D473DE9B535C463CB498CAAF2C8C4BC6A3040E3938E3B9FCAA11CD306828A4EAD8079EB8FF003FE78A7C99590829E51CE36679A02CED7D844631B0642558742A706BD97E0CFC61BFF0DDD5DDCEAFA85CEA90C112476F60F3125D89C7CB9E9815E33477C8E0FAF7E98AE5C461E1888724D1E965F9857CBAAAAB49FCBA1FA13E07F8A5A478E1592CD8C370882468662324138C819E79E3FC2BB65FBBD33FCFDB35F99DA3DF4B67A842F05C35AC9BBE598395DA7AE720F15F79FC1FF1A5FF008934182DB59B74B7D5A0B78DD9A370D1CC87215B23BF07239AF84CCB2DFA9FBF0D51FB670FF102CD93A7523692FC4F411F5EF4E3EDD69BB7D78A728E739AF9EE64F63ED6C394548BCD357EE9F5A773E9482C2FF9E2976EEE79A179C714BEF4B4243A62803E6A76DA3078A800E7AD2D2F3CD381E28E615C601DA9FB76E29297691DAA2E4850A3F1A72AFAD3B68EF50D80DA3674A7051DE82BB78EF4262B89EBC714831DE9E07BD0573DA8B886F5C0E9494EC6EE2971F8D4DC7719473E9526D346D34AEC2E47D7BD2714FDBD282BD38A2EC061538C518FCE9E17B9A36F6A398647B4FD314BB7BD3B6FE14BC76E6872621BF5E2936F229FB71EF428DAB53CC036936F34FDB8F7A36F5ED4B9863451CFF76971B475AAF3EA315BEDDE70A4E37751F4CFAD17B86E581D8D378F5A6C928545901DC84AF2BEFC71F9D3FBF5C7D6B3725B0098CB7A51B07734FEB8A4239FFEB66A39806E0F06929973790D9C61E6952252700B37F2AE7B5AF1D58E8F179E21B9D42D933E7CD60826F271D4B283BB033C900F4ED5AC69CA7F0A2255214D5E4CD1D6EF2E6CED9DADB69940CFEF07007A903FC40F715E19E3EF8ADADF86EE1EEEF6ECC166B9108B5050CA4EE08C8B83B8743CB11C1E4D7A4EAFE3AB0D77429EE342BD86F9780CB1B80C0E47DFDC72A077C8E2BE29F8BBAFDC6ABE2CB913CCD7206332C80EE93A776F98F248E49AFA9C9F03EDE56AA8F90E22CCDE0B0EA7465AB3D87C25FB604B1C26DBC51A425DC63E55BAB3015997D5909C13EEA40F6AF18F8B97FA16ADE2FB8D4BC373674DBC3E6FD9F9061727E65C1F53CD7296FE5CB0C8EF22C61071B509249F4C553691A462599989EBB8E6BEE30D9750C35473A4ADE5D0FC9F1D9D6271B878D1AEF9ADB3EA7BE681FB4EEB7FF0830D1DF6AEA5616DB62BC693E6942820718EA015FAE09F6AEC3E1AFC7F9751BDB759A750661289232388E4623CB279E873DBDEBE52F9B919AD7F0CEB3FD8FA9452B2978F2048AA704A74383EB835CD88CA70F284B963A9E96078971B4EAC23567EEDAC7E865E78EB4EF0EF8606A9ACDC45631AC5B8A64939C03B47AB608FCEBE0FF1EFC42BFF001F78CEF75FBB95E3666C5BC48DFEA6307E551F41F89EF9AB5F133E276A7E37D76E276B93E46648628D4616388B7DD1EC401F9D709D31EB5865594AC127527F14BF05D8DB887883FB426A8D27EE47F17DCFA4FE10F8FF0045FB0DBB6BD7EF1DCAC9B20698E57713D803F4E4AFAE2BEA8D1F52B5D5AD126B42AE87A48BFC8FA57E65DADDC96732CB110B229041201C63A75AFA5BF676F8CF7B3EA074FD44C770642AA16260921FF68AFDD6E9D8E79AF1F3BCA5B8BAF4BA1F4FC39C451A9CB83AFA3E8FFCCFAC3D29CBE84532095668D5D7A1E454BF7BB57E75CC7E9B70CFB518A76DE29DCD1CC48DEBF4A5DB463B52EDA39843307E94F5A36EEE94B53CC17236F4C51B7F0A936E69369A7CC171BF85232EDC7AD3A8DBF35573011EDA36D3F69CE40A300D1CEC0663AD2E3BD295F7A5DBF9D1CEEF718CE76E3B537F0A94F6A422A79863369FAD18EE066A4C0A434B982E47B68DA4D49460FA52E661723DB8FAD181E9526DE7349B68B85C677A36F4A715FC28F7C52B9570C76EF494BB4FE34BB68E66491B2FE749B7E5F7A96936FE552E571DC615346D34FDBD682B47305C8F68EB49D3DEA4DBED4DDBD68E62AE336F71CD3596A5DB494F987723DBF9D37676C54A45368E61DC8F6D2636D4ADF4E69BB714D48B23DB4D395F7152D1B78A7CC1722DA36E4D232D4ACBF28A6B0A9E62EE458F98D35B3531FBD4CDBBB9AAE6288FF0A6328F4CD4F5132FAD5730F73E01F8EDE1297C1FF13356B731ECB7BA93ED56F8E851B27F20723F0AF4DFD907C706D755D4BC2B70EC63B95FB4DAAE385751FBC1F8AF3FF0135D97ED6FE076D63C276BAF5BC6A67D2DB12903E63137F4071F99AF993E1DF8AA4F04F8D348D651982DBCC0C9B7BC672187E2A4FE75FAC61A6B36CA5C5EE95BE68FC171B07C3FC411AB1D23277F937A9FA26DB704F39C57987C54F8E3A27C3EB59228AE21BED5C676DAA9276FBBE3A0CD5EF8BDE303E1DF03CD7B6B27EF24883C78EA720631F9D7C616FA3EA7E2DD5A425669E7639D83248EFC0EC3A57CAE5195D3C45EAE21DA28FD1B8833CAD81842960E3CD526B4F22F78FBE2C6BDF10EEA3935095208A3FB90DB1651F892727F1AE3769909E0B9EE7AD6DF88BC21A8F87AEBCABAB6789B6EFDBDC027BFE7FA57691E9FE1FF0087BA3DBFF6C9FED1D5AE14486D2D5C6E854AF01CF40735FA2427430F4D470F1BDFA23F18A9431B9862272C64ECD6EE5D0F32FB3BB36044D923B2E4FF009EB4CFBADD32471EB8F5ED5B9A9F89CDF4E069D68B616EA17081B731C7AB7F857A1F8C3C2E9E25F01C1E20F0F5B37D8620A6E214DA8216DBF380BD5B07B92063A035ACF14E9B8AA8AC99CD472D8E254DD09F3386BB6FE8790FDE6CE31EC297CC65903F561D73DE9A1A91BA7AD771E1A6D3268ADE1B891879CB07CBBBE6071BBFBB5D3C7F0D755BAD345F5B5BF9F07C9F3C5F32B8248CEE1C7503F3AE767B589ACA09A12CCE47CEA79C60F3F874EB563C3BE2CD5BC2B7065D2EFA5B52C72E8AD947FF00797A1FC45735455251BD17667A787FAB426962A2DA7DBA1767F01EB16AD2A3DAC8258F864DBCF4639FA614D625AD9CD3DF456F1A1F39DB62AF72C7A7EB8AF7CF00FED1BA7DD6A11C3E2ED3224328D9FDA36AB951EEE87B727A7E55E8CDF05FC3DE22D734EF136913C66033C770AF6E73148158640C74E9D2BC3A99B55C249C7174EC9ECFA1F634B873099A4154CB2BF3496E9E8EC7CAFE0FF143F867548E68E35624FCC1B7654FB00CB9AFB4FE18F89A3F1378761970EAE07DD930323D476C7E27EB5F32F8FBE05EA5E159A6B8B6CCD067CCDA07032E147FE842BE85F823A5BE9FE178D5A26809FBF19E36B639AF173AAD86C561D55A6EECFABE13C2E3B2FC64F095E368A3D0C12D91F8D260FD6A638E69BFCABE0798FD7EC44CB8C76A439F5C54ACB4DDBD78A7CC2B111F9873D299B7A0152EDA4C6DE319AAE619132F7A8D979C54ED9DA29BB7E50738AA158AFB41A695C74AB0CBE94CFF000ABE61D8AACA79A4DB561D4F39A63211DA8B8AC43B7F3A6328E7D6AC6CF4E6987BF155CEC440CA09C53596A665E29B4F989B107F174A6E2A6239FF001A632F4FE94D482C42405EF4C2BF2FBD4ECBE8335137A63157CC220DB4C61DAA7DBD463E94C65E7DAAD3248307D3151301CD5865F97D6A22BD78AAE6239510B2E2995315EBDAA261F9D6B725A2165F7A632FAF153EDEBDEA361CD5A6672890ECF7A2A42A7E9453B93A1F2EF82FC173F8F1459BC0D0F931B2C3790DB808180076C8C3A8F73CF22B3F54F0AE9BA378652E27D4BCCD6276C456512FDDDAE55B7E7BE06463AE456A68BAC6A3F0F34196F20BF9ACA6BE4061B266575910E72586381B7A1E2A9F8075CD23FE1304BFF133492C5216CEC5055491B7775E31C1E335FA97EF2F2927A1FCD4A3869C29D1B7BED34DBD91C61F94FA1046477C8A55FDE1C2F278FE9CFD2BDCF5EF837A3FFC22F0EBFA3CF26A16CAC45C2798BF2C5BB05D582E7207A8FC2B464F839A56BBA0DEEA7E1B46B2D4ECDC3BD9CE4C8AF85DC40EF86CF1DB9E959FD7E972DDE9AD8AFF005771576B47657F55E47802F94AB890B6E56FE01D477E6A1661C7BF3CD7A4F827E1EDA789B5E09AA5D9B2D3670DB59308E18AF4C12461581073EDD3356E3D2FC31F0D3C77241A848759B358251BC47BC2311F2B641C11D3E9EF5BBC4C57BB6D6D738E395D5E58D5A8D28376BBFEAE6158693E1DBBB0B1BAB7D425824F28FDA2DD54B18641801CB630558FA6719F6AC4F1369296737DAACE7FB5D849B51A65002F99B41283D4807D315E97AAE8F67E2C82EB4AF0C694D2DCC8B05C5C5EA80238A2F29720FA1C83C0F7AC7F88DF0BC7C3FD07CA9AF1AFAFF7472BBC20F94B1B6EC93F42B8CFFB5ED5CD4EBAE7577ABE8CF4B1997CBD94E5082E58EBCCBBF65DFCCF328D5A6648C6E24B6171CF27D3DEBD03C27A130F13E9767A55D07699D479B22AC4431E1A2258104E01383F4C678A8FE19F874789B50D623FB2F9D247A71481224DC4484801B3DB0324FE95DF697F0AFC57676B79A35C35BC968D0ADCA491E24F9C65A365070C391CFD41ABC4622316E0DEA2CB32FA8F92BA8B927AE9BE9D3FE09D37C7A9EE34DF0668BE1B2F35D6ADA848238DD625505411F2315007523A0EC3D2BC5F5CF07EB3A2A2EA02FDAEAD259DACA4BC93276BC6DCA9CF254001890303D6BDCFC17A91F8CDF11B4AD4DA0DBA77876CD0C9B9701AF1BA8FC0827F0F7AF61B3D06D2F21D4EC6E6DA1B8B27B86630B2020E42B1DDEBC9AF03EB8F069536AEF767DD54C9D6712962633696D1DFA18BF09F55D5352F0DC11EAC609A4886D86EADDC309A3006D63E86A6F1D6A16FA3EA7A4CF79711DB5BBACD0F9933854562C8E096271F751B156B47D2F4AF015BDFAC0CB6BA7DB402E1DA46C2AE5E463C9E801FD0015E17AA7C4393E2578D2DF534D42D744D06C1DE2B59F5140E016C299562FE27E4F27E55C8AF3A9D1FAC559558AB451F478BC77D4E8D3A32779BB6FF008BE874DE3B925F8C5E35D2744B65921F0BE9E7EDD7772EA53CD1FC2002380C01033D412C3802BB0F17F80BC2CBE03D5E6B5D26C6D02D9CAE8F0C6102B08D829E38279AD8F0E7857C3BA5D92CB0CCBAA492B79B35F4D379AD70DDD988C83DB03000C0C62B2BE30F8C34AF0B7C3BD5E259AD5AE2680C105AEF52CCCDC7099C9C64F6ED4FDA4E55214E9DD25FD6A73D5C3D2A385AD5F11CAE724DDF47D34FB8F92FC59F142FFC4FA2695A5ABCF6D65650471184CC595D9571BB07F974AC2D0759B7B3D42CDB50B44BEB180B6610AAA4EE1DCE327920FE157BC69E1B5F0ADE58D90E2E3ECA924D2EE24176196039E80F1C573879EAC49F5AFB9A54E1C968AD0FC3F135EB7D6252AB2BC96E5AD4AC8DA342EC1963B8412A06C6719239C74E9D2AAEEAB3A6C61AEC3183ED31A2E5D39C6DEE78E78F5FCEAE6AF69A52DC3FF65DCCF7112E30B2A007181924FD49ED5AF328BE5672B87347DA27A193EB81C771FD29D236E62C142FB0AB575344B0C620FBAD8772E067777039E40C7EB514B209235411AA32E4B3A9CEECF4155732947CC7C7A8CD15B2C09E5950C1D498D4B02338F9B19EE7BD412B79923B9258B1C966A6A8DD9E7068C86A2C4B6D8B49EBCE29685C16009F949EDD6988D6F0BF8666F165F3DA5BCF6F03AA17CDC3ED52A08DC4707247A77ADAF09FC48F12FC33B89E3D1B5236ED21DB2A3A2BA1D878FBC0FE95534DF13C5A0DB98B4B59A19A58D3CF9BE42FE6A93CA311951827A1EB56BC45E1D69FC31A6F882CED248AD6567B694BCFE6B348BC93C28C67D067A678AE0A894A5CB5A3EEBD8F768F350A6AB6164D4E29B6D1EF5F08FF006A59F53BFB2D1FC456EF73717530885FC6AA00DC70BB954019CF1C0AFA6D7E64C8FBBEBFE7DABF30EC9A78675B8B7768A587122BA9DA5307EF03EA2BF43BE0FEB8DE22F875A1DE4973F699CDB224D2EE04EE03E6CFB8F4AF8ACEF050C338D4A4AC9EE7EAFC2B9C56CC213A189D651B6BDD33B35E47A53C7D69154F14EDA1BAD7CB5CFD03405C9E71CD3954352FAD2EDA9BB26E0147D69DC74C50A30BEF4BFA52D491305BDA9769DD90334A01A76DA8E615C6EDC75E69DB69DB6971EF53CC4DC4550B9CF3415CD3867AD001A5CC4DD88ABEF46D3D4D48077A3D4D2E6019CB527E15271B738A52BE95371E847B73430A7FAD2367EB41236929FB6936D2E6431BDC514EDA29369FAD3B809F851B79CE69DF5E280A0D2E60BB1981F8D230A9700B0CF14DDA589A1B005148403F4A7746A36F6CD45C068F4071476A5FE114376A96EDA85D94754BA5B3B292466DA146735F23FC4CF8DD2697AD5CD9D9CA40F98491E1829F43838C30F5FD2BEA8F1C5C2DB7866F9B69693CB2114776C1C73E95F03F8F7C23AA3CE9A8269322D8328D97001779CE00329EFF0031E46474AFAEC86851AD272ABA9F25C478DC461B0EBEACB5EA7ABF813F694BA1E7D9DF5CEC568F746B26D0AAC17A6719C640AF55F849F1B62F895ACBD86D29710F9AFB14E728A5403F4E7F5AF854EFB6DC8772E467918C1F4AF66FD9475AFECCF88B2A15566B8B6640CDD80652DF8715EEE6594508E1E75A9AD4F96C9389B1588C552C2D67A36D5CFBAA4215727A571FE2DF190D16DE56CC71ED193BC9C81EB804574924CB710A157053AF04107DABC1BF682F1A69DE15D2DEDA54B57BEB907CA8E4E64F6CE57A7B9C67F4AF83C0D0788AEA9B5A9FA7637110C261A75E6ED63CBFE227C586D4A690DBF88A68AE1170635698EE6CF51FBC2A0FB579C5B78BFC576367E67F6CC96D0921E392E594C8707A2E416C7B0207B560AEAF15A89E7102BDFCA49566C15887B2FAD64CD35C5F48F7133B4CF9FBEC7279ED5FAC61F054E9C54523F06C5E6D56BCFDA733BBE89BB1D16ADE3CD5EFB561A80BFCDEAE374F02ED0C477C1EFEDD2B135AD6AF3C41A84B7D7D289AE243F33050074F4AA7B718EE7BEEA5FD457A31A30859C5599E0D6C556AAAD39369BBD9EC34E3BFAD694BA34F69636974E547DA4FC919FBD8E30D8EB839E0F4F7ACFDDB59580DC579C56E7F6D5BDD470BC88E2E54319243825892A46DFEE800631D29D4E6D2C854234E57727A989242D1C8C8CBB581E94DAD5D72686FBCBBC8635859D72D1E7A63A9E5893FA7B0C5650AB849B4999558724DC53136F7EB522AB49F3052474C0EB9A6AF27DFFCF35EA7F0CF4DB0FB744B716D1DEAC98DD264A481B1B87CC40C6E0081D81AC3115BD8479E4B63B3038578CABECD4AC79A416B25D4533478DD12976566C12BD3207B6727D8549A2EA52E93AB5ADDC0EC9244EAC194F3C1AF64F1C7C1FF00B3F91AB68EF2C52093F7CB39003211C30E38208656078E335E35A9D98B1D5668554AAABF1B87201E6B0A38AA58B838C5DFBA3B71580AF96D5529AB34FEF3F43BE11F8ADBC55E13B3B89594CDE582EC87E53EFD71F867820D775BBD39AF05FD9DF5ED3F4FF065AEA1757D0D8C1329127DA655550EB952C324633820F3CE01EA49AEFA2F8E9E05B8BE7B68BC436B23C6A59DE324C6A077DFD315F8F63307516226A941B5E87EF987C6D37429CAA4D26D773D014EEC714B835E47A7FC6AB9BFFB36A69648343BEBC92DEC1F3F3DC2A2939FF65DF6B9407AED0B8C906BD66DAE12F2DE39A23BA3750CA7D6BCEAF87AB87B7B456B9D347114EBFC0EE3F6FE3453F14A062B97991B730C0319C5181526DFC297E94B987719B69BB7AF7A928A2E1723DBDE936F7A976D215E78E69F30B988F6D057F3A93F0A0AF7A5CC323DBED49B4E7352EDA36D1CC17645B28C0A91A9BB49A4176336D0CB9E00A7ED392683CF6A572C66D346DA7FE14BB7DA8B8AE4617D79A36D3F6EDE7AD0568B8C611EA3346D1D7BD382E2976D2B8B988D57BD073E94FDA6936E68B8F9869FA5263D69FDE933D28B8C4E36F5A4C107DA9FB7B5260D1702339FA514F20B7D295BE5A57191639E29BB7A54A56936FE34F98630A9F5A6EDE3DE9F8347E153CC34C8F6EEA4FE2E95230A4EADC0C53E61DD9132F714738A7D26D3DA9DCB23C134DDB5332F14CC77A398A4C8BF0A4DBD7352ED34DC55DCD2E47DB34C65CFB54A579E3A535949EBC53455CC9F11E8B6FE21D12FF4DB81986EE0785B8ECCB8CFF5AFCE2F116893F86F5DD434ABB52B3DA4CF0BF1E84807E8457E9832E7A715F18FED71E15FEC6F1F5B6A91A6D8B53801240E37AE030FAE36FE75F71C2D8C74F112C3B7A4D5FE68FCDB8DF02AB60E38A4B583FC19DC7C31BE9FE2F7C36D134F94192E746984172EDC964519889FAF1FF7C9AF5CF027C39D37C19625CC31C97F216925B8603393C91EC00AF96BF65DF1C3785FE2443A6CCCDF63D63FD18FCDF764EA87F3F97FE055F4E7C62F88B61F0F7C293CF7320FB65CAB476D6E0FCD23638E3D39E7E98A336A388A58CFAB51F867AA3AB87B1D86C565D1C6626DCD4959B7E47CC3F1FBC791788BC49736BA742B15946E57ED0A41336D62370E32067B7B57902AB5C4A0292CEC7F1AB1A8EA13EA5772DC4EDBE4724B6381C9CD6B43A7A68FA4DBEAAED99E42CB1C2DDCF40DEE2BF43C3518E12846925AAFCCFC7F1F899E6D8CA95E4F4EBE8675E45FD96A61721AE0E09656E50771F5AD9D27C6BA9F877C2BA8E8B6B285B4D4B6F98ACA772007E62BFDDCF43EB5836F05C6A97BB9B74B239DCEDDFD49FE74DBD9449752051FBB43B1467B018AEA94233B427AEB738215A7876EA516E2B54BCF4B102AE286A5FBD4DAE83CD1F15C490ACAA876AC8007F714C0319C1A280BB8E00AAD23A95772560FF3F5AE9FC23F10BC43E07BA47D1B569ECE1908DF0F0F19FAA302B9F7C5730D956C118EF4F8D880C01E9C8FAD615A9D3AB0E59ABA3A30F5AA61A6A74A5CAFBAD19F6E7C3DF1C3F8EB4C4B6D66D55A7923CF9F1C6046E3AF627073EB8AF45B7B38ED1488942827240AF9F3F66CBCFB6AC40E7F76339072BF957D17CFD6BF17CD69AC3E25D2868BB1FD4590E2258BC142B4DDDFE23197A7A77A8F1D462A7DA5B02936F1C735E3DCFA2B916D27DA9196A465A465C63BD3B85C8B69C7A5359791EB526D2693CBDD45D8C84FE749B4F3C54AC33D3151F3DB8AB4D8EC45B7AF148531DB9A95811EFEB4D3C9EBCD5730588595853307BD4E79EBC7D69ACBC134F9844057B77A6951C9C62A62A698CBD6AB9808997AD3597A62A561F36334D6C83CF155702068CFAD30AF1DAA7C0E7BD336FE554162BB7D78A6354ECBDAA1C7CC01AB449115E9519CF43C54ED4C65CF27AD6898AC42D8C1E38A8DA31CE0D4CD8EB4DC7A0AB20ADB79C546CA2AC950B5132555C9688302987DF8A98A9A632D68A466C8A8A539A2AAE46A7C4B70D2497329B92E67C90FB877F4A7DF58B4105B5C2C32476F32FCA646C9254E1BB7009FF269246DE923347F3F676FBDE9FE7EB562CF5D16F64F6B71676F770B83B5DD71247C6321C7F5E95FB0EB6BC4FE4B5CB2BF33D4F5BF83FE21B55D3CE8116A4A62BECACDA7DC45C9661FC0C338C60E73CF3C0AF53F04B5D683A5FF006A48A6E21B766D3AF42292C444C5567031CE0673DF193DABE75F85CDE196D6A14D76692D9198C664DDF21561C74E54820FB73EC73F4FFC2B82CEEFC337BA5B44CF6EB733802672C5D0CAC14E7AF45FD2BE73308FB3936BE67EAFC3B56588A714DABC53B6BDADBA3CABC5BE1BD0F49F1F36A760A97BA6DC5B9D485A83BE1731C83CE4DBD0E541E0FA533E3443E1FF00113433D9DAC30BC313B49756E31BE465FDCC7EF9DA7A74FCAB7FE28787743B1F17681F63B88F48825F385C5D5BCBBB03CB6241424A91F2F3C720E2B84F04496533585EEBFE75969562AD25948EAD8BB9B380E4F4C201D3B9A741F34635537A1C78B4A32A9829452527BF6DAFF99D67C35D6EDFC07E0896D8D94D36AB7D33DB4DB7120695436471CE029539C743553E2543A9699E05BE9F56F2239EF7304D1BC85E41223064030303824F04E43543F0E26B7BAF160965B77B4B4BAB179613348A9187DD8660AD8383F7467B0AE67E347C40B2F105E5FE9DA6C8A2CD6689C019399047B5B69FAE47E02AE3093C468BD48C562614B2CB4A56D3962BF37FD773D67F655F0C41A57846EB5D9DC25C6A129886F6DA362670067D79F5E95E9B6B71078523BC122CDFD92EEF2A5C6C322C27A32311C85E0E0E30067A57C690FC48D61BC2F69A1C30DBFF0067D9A3804C3971924B306EC7E9E952687F13FC53E178C7D9AFE59AD244F2DADE752F0900F208231F520E79A9AF96D4AD52551BEA183E24C26170D0C3C20ECA36BFE7A7A9F49FECD725BDAF83BC4170FB231FDAF70647638180AA4739F4AF53D3E68B4FD19AFAF185B2C9BAE64690E020272012471C607E15F227C33F88D69A2E837D6315B5BBEB57DA834D12DECC62B3B78F825CE4F538232324E3AD7A37873C5DA0FC42F1425B78BBC52BABCAB2F970E956B0B41A797C8DB8E3320EBF7CF6EF5E7E33072751CE4B43E8B2BCE297D5A950835CD6B2BBB24C678BF5CBEF8956BAAEA37FF6AD27E1E4129632C6A7ED1A9ED184545FEE9209C9E39CE7D3E72D4F5B37D24D1DAA35A58E7096C1CB6D51EB9279AFBDFC6DE10B1F167856E741690D9ACA9B20F25B66C6C1DBD31903B8C57CCBE39FD97F5AD1A6B89F44DB7BA7C4BBC076FDE602E59B1F5E0575E5B8BA11BC25EEF6FEBB9F3BC4594E39C955A5EFAEAFAFA7923CA7C3BE1FD735EB88ED74A8A699E60C11165D81F03240C9009C0C919ED59974BE4A88248E48EE51984A1CE067A01ED8E6BD656E0FC1CF0FC30DC4F6DA95F6A11A5F59470B624B57298F337AB74E791D1B15E4973752DDDC4B717129966958BBBF7624E49AF7E949D49CA56D0F87C6525878469F33E77BAEDB0C6964963546919923E1558E40AB02CD0210D2057DB955C12589DB8038EF9AACAC8AC0BAE571D0360FB5743E15F0EDF6A8A6E61B459ED437946495F6C70B118DEC411B5549539271EF5B4E4A11BEC7050A72AF3E55EF36753E0FB5F0D68FA58D41B53B8B6F12408F9B7687309E082AF9EC4718CF5AF3892E1A49A4900556624ED5030A3D056C6B5A3DDE8DA95CDA3DDA4AAB232B5C291B59979E1BD79071EE2B1E6DAC81922DAA4F55C9E7B8E7AF6FCEB2A4A3772BDEE7562AA3928C3979797F17DFD42349A447748CB4684331D9903B024FA7D78A8DBF78D9C72C7F8462AEE99ACDDE912BC96D2EC660032BA865600E70548208F622A9EE2C493D6BA75D6E79ED46CAC1B40CFCEA79E99C1E9450CC49C9249A2A8C829369E83A93464F5E82A5B583ED7731DB02B1B4CEA81DDB685270324FA52654537244DA95ACFA65F3DBDDAA09631B0ED391F5C8EB5D05BF8CF59FEC9B5B0D3A25B486DA368DDA28C31937920B12C0ED2C0ED3B71918EB589058BAEA914578CCB1ACA237900DDD08C91CF3C723D6BEFDB1F83FE191E1FD3ECE0B2548EDF6CD0BB72E5B6B6C2E7AB6D2E703A0C0F4AF0730C7D2C1F273ABDFF03EC325C9F1198AAB2A33E5B5BD4F94FC03E1ED4BC79A143A2C71D95A46CB2456866870F33B3038F382F6C33727247406BE80F817F0BFC43F0E8F96F70069F2DC5C09ADA4182C3FE59C880FDDE474CF46F6AEE7E1DFC29D1BE1C58BC1A723BC930432C93396DCE011BC67A6431E98E95DBF9638E2BE2F1D9ABADCD4A1F0B3F52CA7248E0D46B557FBC4AC228A728EA29DB69FB71D2BC0E63EAC8D57DE9C17F1A76DF9BA53B1D31482E3147CDD38A788F775A7ED22976ED5A8E626E336F3ED4BFCE9FB73ED4BB40CE79A9E626E371D28C014FDA2976F4A8B8AE331C934EE9EF4EDB405A2E035452EDA7E3D3A51B4F3CF7A9B9171A7B51B4D3B683D29596A2E1719B69307A53CA9CE31437079E0D1CC17194DDBD2A4DA3EB4797F2D1CC573219B451B7E5CD3F6F5A31EF4EE491EDA169FB4FAF146D0293631981DF8A76DE314A40C5263F0A8E62AE371CFA50542F14BB7AD2FB54F305C66DEB48C02E496000A9369EDC557BD593ECB288555A5C61779C2EEF7F6A2F7958573CABE297C6CF0F78451ACEFD45DC246D962560242A480DB41F4C9EB8CF6CD6A47ACF87BE287827ED3A35CC5358326D6455F9A3C7F0141C823A63F235F26FC71D3752BEF115EDE5D4F35D32F28CFC0DA5B1B9540E0120E07A0E6BCF7C3FE2EF10780750173A55F5C69F33AF23195753D32A720FE3D2BF44A39146A5084E854B4D6BE47E7388E279E17172A789A5FBB5A79FAFCCDAF8B5E115F0C7892E92081E2B667CC65BA8ED8FA8F4EDEF5CAF87B509B4DD5A09A29DE02582C8D1B6D2549F9813DC1A935DF166A9E269849A85E4972E38CC849EF9C566DBE3CD5C950179C37438E6BED695392A3C95B7B6A7E6988C45378DF6D865657BA3EB2BAF8F3A6F803C0A22D3A0597549D36D9247299234E3E66763F3614FB7278CE39AF9A358BAD67C5DAC5CDF5F4D3DFEA32ABC92348724AA8C9DA3FBA00380381DAAB5BCF15C5F09AECB25B83848837CCABD80CFA67AFB57A11F1BE95A6E97043A4DBA5CDF468E1AF2E50AE372346178EA007272700FA579147090C037EC63794BA9F498AC754CEB5AF3E48452B47B9C1E97E1D92E239E790620484C87D0F238FD6B63539B4AD0ACED6CE148A6B98A2679DD97932B0E147A81D7F11EF543529AF239CDA9D414C317DF9A13853C01818EBD3F9D656A164EB3818766DA0BBB9DC49C71F8E38FAD7A693A92BC9D8F06528D0838D386BB6A57B5F2E6B8C3866527A20E7DEB46E20D35ADC9866CCCCC76A6480A3D4E40F5FD2B4F4AD02E5AD545ADB6FBB605464FCDB891DB3EE00F7CF615CD5D59CB6AC0C88406C9071C1C120E3FCF515B4651A92D24724A12A304E51BDC6242F26E2832AA71BBD7DA99247E5C855874FD6954B2B6E0594FF009FEB475E73CFBD74EA79EED6BDB51FE7308D506D50BC8DAA01FCC734CA28A64DDB3B7F855E1FD375CD6244D42451285C4113E5433E38C9E4638EFEF5ED563E14D3F48D2ED6F65B9B7D2D63CA3DDB90BE5927952A485E3AF1D86470431F30F85BE2886D6E2C96CEDC49AE7CD1081E31E44AB85D99C60EEFBD93ED5C878EBC71ABF8DF57BAB9D5258E02BF2A5AC29E5C63076850075383D4E4F1D6BE6EB50AF8AC47227CB147DF6171985CB3050A8A2A537FD6BE87B2F8BBF695B1B7D37FB3747B15BFBB8F08F7ACA56DDB07AAAE377381D87E831E0FAFEBD71E24D5A7D42E5638E6988DCB0A6C51818E959A1475C52AAF3851D4F6EB5EA617034706BF77BF53E7330CE317997BB55FBABA2D87AC8FB704EE04679A1643C8FBA1BEF7279F634A96F2C90BCCB13185085693B0C9C0E7EBFC8D364B792376478D95958A9520F07DFF002AEDB45B6795CD33B5F08FC48D4F43B68AC02ACF12CAB345F2EE9015390149E809C7FDF22BEC8F83FF001B749F13E936D657CADA4EA0BFBA58AE015490FA2B74CE3B673FAE3E0DB3559959198074F9D3777C7519FA73F857D0DF0877FD8D5F7CD768E04CCA53760AA90403E80A8FFBEBA00335F199EE06856A5CEE3A9FA3F0CE3F10EAFB172BC6C7D971B798323907A1A7EDCD50D1DD5AD9421DD1E015FCAAFE0D7E44FDD763F5A7A680C28DA319A7628A5726E376AD2FBD2F1E94B81B69730C6F1E94DA7D1B46452E60B898FCE9B8A9369CE49A6EDF4AAE60B8DC7CB4DA976F149B6A79808D80A36FB53B6D2D1CC50CA56A5DA3751B78A9B87306DA6D3A97031D28B8B9866DF6A29F4D6EFEB4730EE263DB8A6ECF514F0BEB4B4B987722A705FC2969A79A39863197D295948A307B52D2E601BB4D18E29F4947300D00D054734EA28E61DC6004F5A4C1A92936D2E62EE47B7F2A6ED35328C2F34DC75E29F305C89968FC69ECB49B7F2A5CC50C6523BD3483F4A90AFE34955CC17236A6B003DAA5DB96A630EB4D4B52D31BB45308A929BCF34F98AB919E68DBEF4AC39A0FD39ABE6D4AD08F8C74AF24FDA5BC1ABE2CF8637EEB117BBD38FDB212A32DC03B87E2B9FCABD74E3D2A19EDE39E178E44578DC1565619041EC6BAF0B88786AF0AB17AA39F15878E2F0F3A13DA4AC7E61D8DDC9A7DEDBDDC2E566B791654653820AB6473F5AECBE28FC44B8F89DE2C3AB4AAD0C2B1AAC5013909F2E4E3F1E6A9FC56F089F02FC42D674639314537990B118DD1B7CCBFA1FD0D73DA7DB3DE5C6C404B63B73DABF7987B2C42862F7D34F23F99E4F11829D5C06D76AEBD19B9F0F74DB5D635F10DD8DC9B4B15F5F7FCF9FA03543C59A82EA5AD48D136E821C45163A6D1F2F03B74FD6BA5B7D047867C0379AC4F23437F733FD92DD14F3B4A9DE41FA605731A1F876F754C4B6F0B4810ABF4E08DC07F3C66A6352129CAAC9E8B4F99D7568D5A7429E1143DE93E67DF5D8F46D1FC2A9A3FC32BBF1211991E0F2D0E3EEB13B4FE79AF2319EB8AFA37E3A5B9F0EFC26F0E69708F222BC9C3951DF6AF20FE26BE7792131C618E304E07CC33C77AE5CAEB7B784EB49EEF4F91DDC4585585A94B0D08FC3057F5644D4DA396CE39A712588635EEA3E32CD0953D8347F6C87CE6F2E3DC017EA1727BFF00F5AA0A4DA0F3DE892E6562A0F966A4CF44F1DFC33BED374B8B56860CDBAAAA4AAA7251B1D4FA83C10475C8C64579DABED607AF622BEAEF811A85BFC49F86F71A0EA28A6EAD505B8994FCCF1820AE7DC0017E98AF9F7E24780EE7C09AF4969206687276484707FC8AF9CC063DCAB4F075FE28EDE87DBE6F94C5616966784578496BE4CF7FFD95F45787497BC61F24872AD8AFA139E7D2BE41FD99FE265DF8635C3A25C8F3B4BBC653F31F9A163FC43D89E31F4EFC1FB0F1F2FE15F9CF1153A94B1AE53D9ABA3F60E13C552AF964234F471D1FA91AE4D26D1EBCD49B0F5A36D7CD731F67722C7E3487BD49B4669ACBB6852191E3E5CD3307152ED348CB5A5CA5E64581D8669A577311526DFC69B834731572368C8CD46D1F5E6A765C75E78A6FA53E60B906DE29BB7AF7A9997AD232ED5355CC16206FCA9857AD4EE808C814C65EB55715887BFB530AFCBC9A95936D3587BD5A0B10E3F0A6EDDD9EC3F335349CF18E715E61F16BC79A9785ACFCBD32D99A4001699C1118F6E9C9FA1AEDC3529622A2A71DD9C98AC4C3074A55AA6C8F4560338DC33D71FD4FB544EBD49E9D735F226A5F1E3C517170ACB7090B21C8D99C67F1EBF435D0683FB486A31DACF06A912C92EDCC4E38048EAA7EBFA57D24B87B1518F34753E229F1B6573A9C8DB5EA8FA2F50D5ACF4E8565B89D2342DB465BA93DBF4A8EC354B7D4A3F320904833D54FA8C8FD39FC6BE3DF127C4CD535D9C2F9CF1DBC523347196C91C9C64F7E09AF43F877F123CC4B2D3518C68CF99A40A77B31C0C28FA63F235AD6C8EA51A2A77D4C70BC6384C562BD8A568F73E8861CFB5318119E3145AB3496E84A9438C856EBCF4CD3DB9079AF98D4FD062D4AD6EA40C00A691BB3DAA57C0E3F2CF5AA4DA959A5C791F6A8BCEDD831EE05BE98EC6B44A52D5214A493B363D97A546CBC8F7AB1B78C9A6ED03AF34264B2BF4E28A795F5183455DC2C7C95E20F13681E26FB288F44B8D3A48D1C16FB519449212700E40DABD79E7A572B71632438254E09C12149C373C670327A7E74B3DBAD8E627675BA036490EDCE181C633DEA08AE66864565765756C839EFEB5FB2C60A2BDC67F2556ADEDE7CD556BE5A1EDDA5FECEAFA97C3B8B59F364B2D6B679EB6F23031B2019039C6DF5E6AEF827E23476DE03BA0352583C430CD216843045119707009FBC7938C64F35D368B3DF7C6DF8431E9E97B736BA8DB15172EEA57ED0067041FE20707F115E0BAE781E7D3985CC51B1D3A59A64B59B39790AB151C0EFC7A678E95E253E6AF2952C44B54F4F43EEB137CB1D3AF80A7EECA3ABDAF7EBEA8D4F89DAAF883C49E25B1B6D75ADEDE6655F2EDF3B63B7562400EC471D067EBEBC577BF1435697FE10DD0ED7EC127F63C71086CEDE30019C281BA47241DA0E385C67E6C9238CF88DF69B3E9B2A8D4A3747922DF1E4FCC3A819F4FA536EB5EBFBE82D619EEA468AD63F2A18F3808BCE4003EA6BD17864F93974B1F351CCDD355D4AF79BEBA9DCF867C5096BE28D326B1BD3A52383652DBCC4B1891C91F29C70BD39EA0F38A3E2E595969AD0DBDBCF06F924324567045B041132A925D8E4B12D91D7F84FF7AB808E60B242B3421D50E4853B59875C13F4E2AFEB3AF5CF889916548D5CB0CBEDF99F08146E3F419FC4D69EC5AA9192E8652C72A9859D29ABBBDFAFCCE99FC45E18BAF0FDBC47C3AD697D6E890C920BAC899B6E3CC236641C8C95F435675CF11785D7E1EC36B6F035DF89667659A690058E15CF2C83BEEC0E7D8D70BA85949A7C9146D3C72EF40FFBB7C804FF0009F7A9347D624D12E1E686DADAE24603067844814839DCA0F19CFAD1EC22D5D7A98FD7A76942692E6566EDB7DD63A7F02F8A9ECF4E97406B4D364B5BB9964692F06D6040C101FF00C7A569F8935CF0FF0087FC64CFA45825EDBC2B1A49B5DA2552A03318D812C096C8DC49F6CD79EB5F4B248CD2379BBD8BB06EE49CFE1CD4533196669304066C8C9CE2A9E1D39395F7E810CC6A53A51A71DD34EF6EC7A9FC41F8D1A978CA3D36EACA4BBD25B4E2163293127A0F98B8E5CF1E95A961FB50F8BEDF419F49956CEEEE654F2A2BC71B5E21D0960383F8F4AF2AD566D32EA5B14D3E396D57C9517325CBEE065C9CB01FC23153AD9D95A35BDC477324D0F227558CEF8F900E071D73C60D61F55C3F2C5381DDFDAB8F9559CE35B596F6FB858974CD42F94EA379A833B82D3CD0C4929C8C6463772001D7F4AB36F1786AD44B75E75E5EEDC2A59C9108B39CE4970E7A71C01CFB557F0E784AF3C577E6D6C305C872AB202380A48CF6191C0E7A915D5DC7C17D7EC7C2F6FAC2594778978882244256442725980E32460039EB9AB9CE9C1A8F35BC8E3A54311593A90A5CDE7ADFFAF91CD4F2786A4B199E317F05D95568E28C2B448DDC3138E3D0FBF35E83F04BC61AA6852DEC7E1AD16DAF5D6212DD497D7042796000D8E00009C9E49C5793EA36D3D9DD3A5CC32413F0CCB28C3038E78F5A9B43BAFB2DF2C8D732416EFF0024FE53105A3246F0718ED4EB51552934DDD7DE183C6CF0F89535EEBDB45FAB3BCF1578B8F8BAEEE1AFAC74FD06D25733C112DBB3A4D264C65830C617D5874DA303359BAA69AD6F70BA3F873ECDACB04FB4CB79671BBAA82B8603793803D4815A5AAF85354F8A1E2463E188AF352D1AD634896EE4468E0B641D1724632073C609E702BB2F82DE1DFECBF0EEA9A96B57F2E8FE1F8E1945D4D1DA6659D5DD14283B771040CFB63DCD704AB42853F75EDD3FAD4F6A9E1EAE32BC954564EFEF7A6FAEC783C50AC92222979246CE551738F4FCCD45DC76AF57F881E27F0368B75A7C9E01B69CDF445CC971751650A91C7CAC3960727A63815E7926936F0D9F99717A22BC71B85B989B2071824E31CFD78AF468D6F68949AB5CF9DC460D529B8C24A5CBD56DF7941218DADA495E46565236A0438604F5DDDA9B71E4F9CC20DE613F777E370C8EFF00AFE5532ADB2AA069A6CB6FDE368E38257BF35030DB1A0C0DA4EE5E064FB9AEB385A4908CDBB1D80ADBF0569BFDB5E23B3D3963124D7922C113B26F58D8B0C315C1C81E95879F96BD77E09D94F74D2DE68DA6C1A9788D664486474676B45C63CCD98C1E870D9E31D39AE3C55474A8B923D1CAA8AC4E2A107B1EF1F03FE037FC22F06AE3C471FDB647BB8E58209235F2C6C24A4AB939DDCE3F9D7BD2AFAF23A5721F0D6E3C513E9AC9E28B78D2EE362A934385590763B4E181FAA8AED36F5AFC971B5AA56AB2751DDFE07F44E5F86A384A11851565F888ABD853B69E99A728C629C16BCEBF43D0BF51156957E9C53D47CB9A705E30686437719B475A55A76DCF4E69DB41ED83537648B48053954FA52EDA9246FA52EDF4E695579A71151726E336FE34FDBD2976E29FED49C8571BEF49B7914FED8ED40527359F3682BB23E7818A705EFDA9D8A72A9DD9ACF9985C8C2D2E3DE9ECBE9CD29F5ED45D8B422DBD39A465CFA54878A4C63DA9DC771BB691976F6E2A41DE97B75A5CC4F311526DF9A9FB452FF17AD1CC322DBEBD28FC334F65A5CF7C54B9587723FC28C7BF14FDB4BB4D4730EE47B451B7F0A91940A6F3D7B52B8C6EDA69512295C67231F9D4B8EB4DC6EE94B998AE79D789BE0B685E26D516FAE61CC825593685015B008C1F624E7F0AF917C51F0B354F166ADABEADA7DA3B59CBA83DBD9E781E52E46E3DB078C63DEBEF2D56FECF4BB19EE6FAEA2B3B58D7F7B34B204541EEC4F15F33F8FBF6AEF0BF86D1B46F0A68EBAC240762DCB7EEA0DD9C8D831B88F7FE75F6592E2F1D276A1172DBD123E473BA396CA2A58D928AF2DD9E1D71F02BC4363A4DF6AF3D93A5858C7E75C0561B8286C36D18C920727B704579EACD6F6E2ED047E7172A2363FC233939FC303F1AED22F8D3E28935ABCBD7D7AFADE39D194DA46DE740C08C796637254A11DB15C148ED248CEDF798E4E381F957E97868E23555DAD7B1F91E3AA60D38CB029AB5F7259AE24BC911A4E88028083A0EF53DD4890C9146AA0044F99A338DF9E549FC081F851A55DADACC7CCF955C6DDD8E3E950EA023FB5318CB7978E0E31D3BD75EEEC79FB439FAB3B0974FB4B38609F51922B40D7A50DBC677B44B18218100F392460D6CB7C40F0B58EA734D6DA4DC5F42BB4C624DB1A965070C4E4F1CB1FAE2BCD7ECEB0C6924FBFE619543E98EBF4A8497F2FE63F203D3B7AD733C2C6A5B9E573D38E655282B52825D75D59DD5D7C5BBC06716BA75ADBA4836866CBB28C6383C0FEF76FE235CEEADE279F58F2C490411AC6AA882353C00A5477F524D41A6E8377A8496E225C79C0BAB74F941233F9823F0AD0D43C272DADD46BB4AC291C4D348CBC23322920F7E09229C6187A2EC91152BE3B151BCDDD7A182F72D26CDE14843D3A0352F932DF31711A8393961903B71E9D39F5AB571A74AD711AC7179522FDEF3B08BD323EF1EE3B7523A0AAB73A95D5D7981E6631C9234AD1AFCA858F53B4715D29DF589E6CA3C8DA995B1D47A53A93B7347BD6A730FB7B996CAE12781DA2993EEC8A70475FF001A36B4DBE5697F79B86771E4E7BD68683E1F9BC4325D2C334317D9E2F38F9CFB4B8DCAB85F7F9B3F406A8CD6A6DEE9A3909D8B218FCC0B90707A81DEB3E64E5E6747B3A9182935EEB18217F30A05C9E831DC9AD2D17C3F75ABDD4D1468FE6428EF855CFDD059BF10A09FC2B3609E5B7B849636DB229041201C63D8D763E04F88D71E15D426967B3B7BCB5BA95259372EDDBC9C95DBC0DCACEB8031827D05615E55214DBA6AE74E0E387A95631ACEC8EFFC37F0A6E75278DE483CCD2AE9C89D232C04727CCAEA3D49011D7B6703B56D6B9FB39FF63DBC2A9235F4B23C8F24800F9A3DAA63C70793B9B39C57D09F0B354D03C6DE19F334B58D21997CB921C83B5979EDD40CAFBE09181D2BBF9B468EE2355963591D093B9BDC107F9D7E5989E20C450ACE12566BA1FB5D0C832FA9457DA4FA9F9A17DE1FB8D1FC40D64C9E6BC32206001E0B107691EBDBEB5F577C13F09259D8C53449BE172F1B2364AB7CCACA549E9F293F88ED5AC9F05626F1ACFA84B1028D2B5D48CDCE599B083F0CEE23B57A4683E118F446D908291310707A8C8C83ED86DCBF4507A9AE8CD338862A82845EA619364BFD9B8894DEABA1D268717D9E1F2C70B8C63D0FA56AEDA86CE2DAA491C9EB567F0AFCEE52D5B3EC652BB6C66D1B4F7A72D3B68E69140FAD47313A0DDBCD1B4D49C51FC54B985719B4D1C7AD3F8F4A3F86973011EDDD401EBC549F5E2936839CD2E71E8329B86F4A936FAD1D549155CC223DA6936D49C51D052E61DC8D96971ED4FDA4D1ED53CC223206E23A50B4FC7E34629730EE46569302A4653EB46D1E94730EE478FC6976E7BE29DEC453BEF7153CF67A0C8186DA6FB0E4D48CA39149B475A5CC50D61CD14BFC54BB453E62AE47CFE14BB69F8DB9A5A3982E47B7F3A5EE69C3D69B8A3982E373ED4DC0E6A4A4DBED4B9863691A9D838A36D2E61E837F0A6FF153E90AD3E618C6A0FA629DB7D6928E62AE33F8A98C2A4C7E74D65AB5219115E9E9487EED4A7D314DDBDAAB98BB91B75E0526D39C9152907AD31AAB9808D96931C548D4CC75A7CC6973E5AFDB33C1EBE468DE25894065636939C7272095FEA2BC07E19EBB67E1DF1C6937BA926FD3FCDD970319C23705B1EC48FCABEF6F8A1E0A8BC7DE08D5B46936ABCF17EE6423EE4A3E643F9E07E35F9CD7969258DDCF6D32ED9A191A365FF681C62BF61E19C52C6E05E166F58DD7C9FF0091F8A716E15E0330863A9AD256FBD1E9BFB423DB58F8D5B44D3987F67D9A8C202705D8027F206BD77F66EF018D5FC3A9A85C20088CD6D22772C319FCD0A7E5EA6BE71F0ED9DEF8B35C86005EEEF1F6A0DC724818EE7DBF957DFF00F0EFC2A9E11F0C5BD9AA6D959564971FDFDA07F203F2AE6CFB10B2FC14309197BDD59EAF0DC1E6398D4CCA4BDDE8BA7A7C8F10FDAC344592DFC21650139699E28D07718524FD7A7E75F3D78F349BCD31AC5E7B736D198F6449DF6824F27BF5AFA5BE365DFF006A7C73F00E8EAEBFBA2D2B06E465D80FFD92A6FDA23E16C5A8785619ACA1DAD66095DA327939DA3F3AC72BCC56069E1A8D5FB777F89D99BE52B36A98BA94DFBF0497DC933E3FD3A359B51811A369519D432C7D48CD5B9F4C165ACB5A37CF1C770D093EB838AD8F87BA6DCFFC275A6C31C4AF7515C293038E5F6B7CCBF5C64FE15DA7C66F06A7867E206A31A2F948F24579127AA336D3FAE3F3AFB8962A31C5468AFB4AE8FCC29E5D39606A622DF0CADF81C67F63D9FF00CF018FA9FF001A72E87687ADB8F5EA6BB5F8670DA5FF008A134DBC8619A3D46292CD1A6507CB92442B1B8C8E18395C1AF58F037C37D3B5DB7F0D584FA727DAB45B886EB5994459792099249CA49DFE548D5707A6E3D2BD0A93508DD9E452A6EA4945753CE7E10CB2E9735CC76934F6831826099D33EC706BA8F1AF85D7C5D6252E669A7994EE469A577E7F135D9681E0FD3350D4B48B68E78B4BD4B50D32FAF2386DEC94473C914D349B5DC11B7E452ABC374C70319EDE2F83B1B1D2EDE6F105A41A8DDCB6A925A6F85995672B828A26F319943292191075C12393F278B928E23DAC56BDCFB9C0F34B0AF0F36ECB468F94BC23E1B8F4BF164116C28773287476192B9E9CD7B60D5B505E3FB4F50FFC0C97FF008AAB1E32F86365A469FA6EB5A66A2D7ABFDA135BCBE65B7925258C2EE03E66DCA43020F07D40AE93C50D67A4DA69912E9D033DF6836E3CC545531CA66DC65E9CB108573C1C375ED58E2EA4312E3292B9D181A73C1C5C212695FB9CA7F6B6A3FF00413D43FF000325FF00E2A8FED5D43FE827A87FE064BFFC55773A97C32D27497D4BED3E2398269B7C9657463D3B272E18A320F306EFBA77025718382DC669E85E10834FF1F6A9A56A2ABA8AE931DDC9E4A6E0B74F0A332AF1838254640E719FAD707B3A7FCABEE3D3FAC55FE77F7B391FED5D47FE8277FF00F8192FFF00154DFED6D43FE8277FFF008172FF00F155E82DE1FB9F1B697A6DFCD71A15969FBAE5E6974BD3FC99AD9628D6474755441210B8DBC9C96FBD54EDFE1AE9F7566FA947ADCBFD8E34F7BF599AC713FC932C4F198FCCC06CB6410E41E391CE0F674FF957DC3FAC55FE77F7B389FED4D43FE8277FFF0081727FF1549FDA9A89FF009895FF00FE05C9FF00C557A143F07A137772F71AF436DA4AADB186F2610C4D279F1F98B949664030B9C80CC7D01E71E7D7D6A2C6FAE6DBCE8AE3C991A3F3606DD1BE091B94F7071907D29FB3A7FCABEE1FD62B7F3BFBC4FED3BFCFFC84EFFF00F02E5FFE2A93FB4EFF00FE8257FF00F8172FFF00155091DE9A451ECA9FF2AFB87F58ADFCEFEF64DFDA97FF00F413BFFF00C0B97FF8AA69D4B50E3FE2657DFF0081727FF1551514FD953FE55F70FEB15BF9DFDEC94EA57FFF00411BEFFC0B93FF008AA43A95FF00FD04AF8FFDBDC9FF00C554471494FD9D3FE55F70FEB15BF9DFDEC97FB4EFFF00E8257DFF0081727FF1547F695FFF00D046FBFF0002E4FF00E2AA1C526DA7ECE9FF002AFB83EB15BF9DFDEC91B52BEFFA08DF1FFB7B93FF008AA4FED0BEFF00A08DF63FEBEA4FFE2AA2349B6ABD9D3FE55F707D62B7F3BFBD9236A17BFF00410BE3FF006F727FF155CFF8CAF19B459BED973713A1FE096E1D813DB826B5EE372C64A9C1AF29F155E4F35F3C72DC348AA78538C0FCABD1C1E1A152A5D25A1E5E618FAB428BBC9BBF99CCBE8766FBA4785793D327FC6A2FEC7B25E9028FC4D5CEBEF4BD2BEB12B1F9AC9F36A521A3597FCF051F89AD1D074DB3B7BC0C17C9039CA311FD454552DACDE44BBF1BB6F38238FC6A6A479A3665D29BA7352475F2F8AAEEF268B4EB4BDBC4B44C1655B9906F3E9F7B8AEAA5F114DA6E9A27BABEBC8428FBBF6A9093EC3E6AF2FD3EE12098DC38F981CE3040FC3149A96A536A9382E711AF0A83A2FBE2BCB9E069CDA5CAAC8FA5A59D57A70949CDB93DB566D5C78A351F175EBDAFDBAED2DBFE787DA64C301D89CF26BA5F0DE88745F9AD259AD91864AC533AE7EB835CD78334564BFF0038F2377CC9E9D48615E87B76F0062B8312E9C5FB3A6958F5700EBD45EDEB49B97A8E37977D3EDB79FF0081327FF15486EAEBFE7F6F3FF0264FFE2A931495E7FB387F2A3DCF6F5BF9DFDEC5FB55CF7BDBCFFC0993FC68A6EDA29F243F950BEB15BF9DFDECF13F1C7C2DD67C1F64BA9DE3C335ACD298E2962272FF00ED053FE7915C4A9EEDCF3D6BED68D6C7E287C3BFB65CD9074680C91D9A7EF047205246C3E9D3835F226BDE09D73C3B97D474BB8B48CBEC56910E0B7A0F5E3F957B982C67B46E956D248F95CEF28583942AE1BDE84B53D2FE147C61B8F0EF8564F0C89A382EEEE7D9697B70C3CAB58D86199B8EC4E47D6BD66EBE0ADAF87BC291DDE917725F6A769179CB7376E0876C87240E8A3238C76EF5F2F68BE17BDB8FB15C3A116D74EF12044124870BD7CB193824E01C7635F55F827C37E21D6BC2F6DA2486EBC3BE1F8536BFDA48FB65C03D515493E547D813CFA015C79846349FB4A72B5F7F33E8F22A9531945D2C453BB8AB45F6FD3E67CCFF0011B49B0B5B8B596C1A4FB50B757BE86404BC5316391F4CE71EC47E369BE0CF8AAEB42D3F5AB6B0373637EC822F28E5FE6EE47600F15EC5F1FBC0B6BE0AF07CB268B6A20D3EE63586EDB92CCEAFBD1D89392796193ED5DC7C1DF114D27C25D0E6B5F25FCB87C9DDBFA3A13956E382474FA5278F9C70EAA52D75B6A73D1E1FA388C7D5C3E25D9A5CDA7F5D8F9CEE3E01F8AAD63B867D3A48FECE56379199446EC5F00A9247CB823919AE1B59F0FDC6876F632DCAAAADE46D3469905800CCA370F7C57DADF1B3C6F0F827E1E6A0D7172ADA8DE47E45B44BF2966618C81C9C0049CFB57C87E24D36E752D1FF00E122D42E2DEDEE2E9D12DAC14E5FC851B7CCC0E8B9C0F7E4D74E03175F10B9AA2491E4E7795E0F013F6541B725ABF2362C7E04F8AF55D074DD5F4CB34BFB6BE8FCD5F26400AE4E3073DEB8AD5345BBD1E79A1BC87C9922768DF70E372E370CF723A7B57B6781FF006A36F0AF83ED3469F46376D696DE4C3324BD581E3703DB19E9E95C3789BC7DA36BDA0C76A6C2F2EB505477375712055495DCBB15404FCBCFD4F7AE9A55315ED1A9C7DD3931985CAFD8AA985ABEF5B55E7A6870323F99B410A36FB75A6E3A0C64D2D3ADE3F3A6442CA8A4F56E95EA1F2CB57635FC3FA45BDE6AD656F7D38B7B69A45DD3A1DDB14900E7D3AD5FF19F85E5F0CEBD79686392C21425A18E6258B007039C60FAE6B13749A5DF37C8D0CA47EEC93C8CF439CFD3A1AF49D6BE2F4BE28F08DBE9B368D6979A9436A2D5AF268F7CDF286CB0E70300E2B86A4AA46A271D51EE50861A5879426F966B55A6FE4725E1AD5A0D16DE4BB7BFBD83507C80B6E71E62104609EA0F43F453DF14697F12FC47A13DB369FABDD422DDF746ACC182FE04115CB49034076C8841C8272339E334E0A4286F982FAD6EE8D394B9A4AE70AC6D68251A6F96DD9EE5BD6357BBD7B52B9D46FE6371773B17791800493EC381F85773F0A34BF06DD6A72DCF8C25BBBB86150CB676A8C7770092E579007A71EF5E778DD4B1CB2460F97F29200C85E47A63D2956A7CF0704EDE83C2E27D8D6F6D38F3DBA3D8FAF756F8A9E1F3A65AF86BE1C690FE21D4EE5432DBC61BC9B78CF2DB893C71C1E98F5AAB71F06B57F104D13FC46F18496B6F7255BFB1F4A84A449B721537EDD8B8C903239CE73CD647C17F8B9E07F00FC2B78350B7960D55A6315D476880DC5C03C8937657E5C1E3E6E2A96ADE15D47E2C5E5E6AFE045BFD174655286CA498C264917019C20620138C7A9FAE40F90519529B8A7CA97DA7ADFF00C8FD49D4A78AA71A92B549357E48DD24BCFF00E0981E24F107847C0FA96AFA141E11782D70601752B896453829B8E7392324E33D474AE6BE2478E341F18F895A5B3B1FF89706896369731BEC53F3EEC0C65B9E7A0F4E29BF15A38B4ED5A2F0E6937BA84CB1AA35C5BDE301E539453B376E395525B86C6DC9E39359FE1DB4D4FC60B6FA35BB599D22D0C7732AFCA9C6769CC8177120331C7B9C66BDBA74E11846B49F4EFF00D6A7C9622BD6AD525838C55AFA2B2FEADE665FFC2BEF10DC58DDEAF61A3DC2E8EA924AD72BCC691F27E66E0640C704E791C648AB1A2FC29F14EB7749676FA3CC5E6805C45249195564CE060FB92062BEA3D63E30787FC2FE084B1B2B29934AB7416B1C36C8BB9C2FF11CFDD04F4257249E76D705E13F8AFE27F1178DE0B82B0E95E1C8A2259F535DA8B1A939C360AEEE78000C91DAB8D6618994252E44979B3D0791E029568539556DBED6FEAC70B27ECCFE2B93C592787ECC41757105AC7753CDB8AC69BBA8048E48391F857BDFC0BF8237FF000B64B892FEF4477DA832A47E56DDD12AB12DF781072A178FF6ABBBD2FC6DE165B19E4D235AB1B9BCCAA8659465C8E8BDCE31E95BF73777975A869B751C30AC5968E15BA63134AC57259701885C0C723279E06013F338CCCB158887B39AB23EDF2DC870382ACABD27CD2E9AECBFE18E86DA3F2D9A3333CCE0672D8C8EB8FBA07A558550EB953907BD66416F7D7176F2C9750AA60218E15662A46782C4807A9EC2B4E1856D94220C2FD49AF979E9A1F61B8BB4FA8A76D3DC53E8E6B3108BE838A5DBC53B683EB4BB7E6EBC5215C6AE69DB69CA29FB6A2E4318B9E29FB4D3956971ED537B6C48C55A5C74C734E5E074E68C7CB52D9225395777346DE29CA0562D8AE376D3875E6976F5A5DBE9CD222E3703B734BB452ED3EB8A55038A915C6F27BD2000F7EF527F16286A570B9194C1A461B6A5FA7349B69290EE478C76A369A7F3D6976D4B905C8997F0A36F7A7F3E942834AE3B91F5ED8A36E7DA9F8F9BDA9DB79F6A24C39888026976F1E86A455FC2868F3CD47305C8B6E57D68C738ED52EDA6ECA9E60E6232B8E95475CD4E2D174BB8BE954BAC2BBB62F5727A28F72703F1AD2DB9AA3AB58C57F6134736DD9B49CB745201F9BE83AFE1CD694DAE74D8DB47C6BF15A6F1A7C5D9E79EFE6FB06876E19A2B14C88502804B31FE2386562C477C57CE770B1C398102B3AB323386C8604F6AF7AFDA33E355B6AD33F853C2ED8D26DA494DD5EA9FF8FA91986E51FEC8C0FAE0F6AF008D76AB16250AE0A8F5E471F9735FB965309C70C9CE3CA9EC8FC273EAD42A625C68C9C9ADDFF9162F2D9ACD14385766C1DDBB23919C7D79FD2A16B795665842319781B3BE7D29D70658F11331F94EE3839193CE68FB549F6B4B866264DD92C3AD7B8B9AC7CDC941C8DAD6B4F1A5681A6A3C913C971998C6399220090431E982791ED8F5E71AD658A1BB8E59E333C68D964F5A75FDFBDFDC6F7C2AA8C228E88BD80A83AF5A9A716A3693D4BAD554A7782D16DF22D48D2EA8D7772E306350FB57EEAA9655C7FE3D8AEBB42F86F7372914936E2AC54940BD9A14707FF2220FC6B3FC03A869F0EA371A76A9B62B0D5225B692E08FF538955D5BE99500FD6BEE9B0F853A38B5D3A4B65CC71AC2432E08708B0853F4DB10E9D457CD66F9B7F675A9B5BEC7D8E479347334EB392D3FCCF23D03E0C7D8F42F2D220F2C962D1C04FF000F131C93F59D7F2AA1F10B47D23E1CCD7BA8DDC2B797AD3C91C08FF2EEF94EE3C8F942803D4FCDDCD7D4935ADAE91A3B4B3EC8A0B788EE6380028500F27A7DDAFCF0F8C5F11A6F881E2FBF9A3909D3D667580293865DC30DF53815F359354AF9A6225293F717F563EC3389E1326C1A5149CF6472FAE6B4358BF33AC42340BB1573855F7FAFB9CE4F3597D28C0EBDE86AFD3631508A8A3F19A951D593931F0C9147366542EB83F286DA7A71FAD307AD2BC724688C55951BEE9E808CF5F7A45E94D34F621DE3A3058CB101796AB91493DBF991A4DE6B42F90A837AF1925867D2AA46AF212141254678F4F5AB1A6B243A847E736C4C367777F94E17F1381F8D44B44DA35A5BAB6971D7B6BB02CC030120DC55860AFA67D89C63EB4CB368E4B8863B990AC05C65CF3806BD2FC4DE168351863BC8260F6696E1A3F2D4B34BDC9E38DA338EBD51B1DABCF75CD37FB3AE44788D8B8126216C85CFF0FE0723EA0FB572D0C446B2B27A9E962B07530B2E67AAFCCEC3C13E2CD4BE1378E34DD5F4C2FF006199BCE5B7DDC5C5AEF6539F7215BE9B735FA39A75F45A969F6F7709DD0CF1AC8871C95619AFCBAF0FDD25DEB5A3DB6A5297D3E39D626321CEC899C6F03D00CB1C7A926BF47BE12B49FF00080E908F279BE544AA1C1CF180473E9CD7E6FC5F8684153AD6B4B55EBD99FA2F09626538D4A77F774F977F91D5FD8E3F988500939271CE718A71B70CC370EF9FD7353734EC57E61CCCFD1AEF718176F34BCD3954FF00153E973326E46D40C0E8296976F5A1C82E271E949F853B9A36D2BB109F8D02976D145D8EE27BD260D3F68A1852B93CC30FA5253CAF149B68B95711A936E739A76DE39A2973008B4D65DB4FA2A79C646CBE947E14FF00E2A5FE753CC808BAD14FDA33C7347F3A5CDDC066DCF1DE94FDDA750DF7689487723D8698CBB7A722A56E0534FDDA5CC34454BB4FAD3B68E9463B51CC55C6EDE7147AE4D3803CF7A760679E947305C8E8A76DA0AD1CC171BB7DA936EEA7D2F0DED47330B91118A5DA294AE68EBED473318D6A69E79A7E2987D4D1CC34358D19F6A763A7A52353E62866DE691969FCE6820FA557314458F6A4DBEB52525573144657DEA3C7AD4FCD3768F4A7CC5DC84AD26DCF7E2A5DB81E94D65E314F98772BB2EE1D2BE0BFDA5BC1AFE11F8A37D225BB4563A862EA1703E5627EFE3E8D9E3DFDEBEFA65AF09FDAEBC22BAD7C375D557FD7E953890123F85F0AC3FF00413F857D6F0CE39E171F14F69E8CF94E27C0AC765D3B7C51D57CB73C0BF6595B5B8F8C1A74173CB18676847F79FCB3C7FDF3B8FE15F75A8C0C62BF343C19E2297C27E2CD23588A4689ECEE639772F5C646E1F913F9D7E95E9B7D6FAC69B6D7D692096DEE635962707EF2B0041AF6B8CE84A388A75BA35F89E0F03E2A32C2CF0CF74EFF0079F3FEADE0EBDD6BE3F2EB2DB9D6D2EA3445C7DD45407FF6635EF97D631DF40D14AA197D0D3974C856F1EE446BE6B756EE6AD63BD7C662B1D2C4F22DB9525F71FA1E1F0F4F0F29CA1BC9DDFA9F2D5A7C33874DFDA424C2BAC00ADE4663EC48EFE9F36EABBFB56E801752D0B570B859A392CDD87037065917F91AFA13FE11FB4FED69352F297ED4E8B196C7381D3F99AE13E3FF008607893C17002066D6FA19B711D064A7FECE2BE8F039C4AB6618694DEC944F9EC7E574E19762614D7C5797EA7C8DA4C93DBDE45716EED1CD1307475EAAC0E41FCC0AF48F00FC42D7F4EF1AEBBE76A0C67D7EDDADEF5DA34FDF29C1C63185E063E5C7A543F09F4AB117D78FA8C0278A090A63687DADB480DB4E0360E0ED3C1C60D74FE3EF097D9756D3F54DF11CDE5943E6D940912B472062AC06C1B4E074C0E4720F06BF58AD888D59BC3F73F15A385951A6B12B74F621B9D635AB3D42C2EA0B82AFA779915BB2C684A47216F317A7390EFC9C9E78ED5DCAFC40D753EC045DC665B168DA09DAD62330F2FF00D58690AEE655C0C2B12381C529D1748BFD0C6A165F6ACC967F6C88CB229181308C82028C93D7DBA73D6B5878674EB5D7238E24B822D75486D64176559275624F0028C602FBE41CF1D2BE72A5472B465D0FAA828FC71EA72D75AE5F5EE9AB6134FBED16E1EE847B147EF5C00CD9033C851C74E2A2BFD5AEF545B51752F9A2D615B787E5036C6A490BC0E7A9E4F35B375A1E9D6FA09BB9AEFCBBD9CBBC10AEEC10B26DDB808476273BC638E2ADE82D656BE1E82E2F0D9AC46F2459967B5F36599024676236D3B4F279DCB82739AC0D8C8BEF166ABA97DBFED375E67DBEE12EAE3F76837CA8182B7038C6F6E06073513F893537F103EB62F248F55698DC1BA8B08DE6139246DC01F41C57476FE1BB1D5354B68A65FB3432C169123C726CFDEBC40FDD11B162793CED1C1CB73542DFC3FA7BDADAC6E6E4DEDC5ACF38757511A18CC981B76E48213D463DFA006327F88DE20B8B8B49BED91426D5DDE34B7B48618F738DAE591102B6E1C1DC0E47078AAF77E38D6AF3ED024BB458E7B5FB13430DBC51C621DE1F62A2A8541B803F281CE7D4D61E282BE9401D0C3F10B5E84B7FA5C7323450C262B8B58658F6C4BB633B1D0AEE51C06C6EE4F35CECD234D23C8E773B92CC7D49EB46DA4A631B453B148453B8C4229BB69D451718DDB4DC75A929B8A7718DC5369F4555C6465690F14F2B54359BC934FB09668E3F32403E55AB8A7269225C9455C8759D62D34980BDD49B01E8BD49FA0AF2EF106A769A95D196DE391727E62D819AB51E8FA878935169260E4B72CCDD07B56B5D7805E38E2087271966F5FF003CD7BF4551C33F7A5A9F2D899E271D16A9C3DD397B7BEB286C6588DB334CFF00F2D370C0ACF66DDD6B775CF0DB6930A48C76966039AC47545C6D6DC7BD7AB4DC64B9A3A9F3B5E1529BE49AD867E3C55AF25639955240CB228C9155A30778C004D0D8DC4818E7A56AF5D0C13E5405BB0FBA3A569F87F4D6D4EF9630320727E9597C719E2AEAF9F0BF996D234608CE637C1FD0D4544F96CB465D16B9D4A4AE8F4DD3ECD2D26545EAB919FCEB53F5AF18B6F116AD6F79F2DECE70C7EF367D7D6BA1B1F881A85BB017089709F4DA7F3AF0E781A9BA773EBE967187D22D347D33F087E1C785BC436F3EA5E2EF1269DA6DAB23C56D63FDA1145705882BE6B0272A14F2A08F988048DBC3F07E32F0DA78575E9EC21D52C759B65F9A1BEB09D658E4439C13B49DADC72A7A7B8209E3749F16D86AD850FE44DFF3CE4E33F435B5C7E15E7CA12A6ED2563DBA7569D65CD4DDD11D14EC51517343CD3E03FC5EB0F86D71A926AA2692CEE114A2C110661229217BF4233F9533E2DFC6A6F1B78920B8D38343A5DAC2638A3B9405B2EA448D8248CE0903F3AF3CF0FF00876F3C5DAA35969E90ACC50BEC92408303B0DC793DB1EA7DEAB6ABA5BE8F7AF6AF2A49247C3189B72838E99E3241CFB706BE97EAF41D7F68FE23E3659963BEA31C33FE1AD4F7AF843F177C23E17F2EC2D341BB8EE1885F3238D669E41C925CF5C01D9702BE81D13C5D67AC6EBE86EA236263DDBB70248C91923AA9C8C9047D715F06787757FEC0D5A0BC485659223B903120039F6AFA53E14788346F12EA971B346B7B52913E678EF0AC5B98920089C003001F7E3DEBC7CC7051FE24533EE38773A9548AA351A4FA74367F69AF1959C5F0CE3B5B675B96D5E40B132E794520961EDD3F3AE1349F1D45F0A7E1CCBA06AD1C96FAEC2524B785091E6AC987DEDFC2707239AE47E3978B26BBF88D646ECFDA60D3E38CA409C2061C85C6300640E9D8525A781FC51E3196E3C5DA9472DC5CAA7DB0426232158B70C641FBA08DC557AE13D3A9430D0A5868AA8EC9EBFE470E2B30AD5B30AD530C9B9AF77C92EAFEF388F1B78DB59F1E6B4FAAEB3334B330FDD2636C68BD9547A63BF7AC592EA492477DC4EE5DBF37381E83D3DBD2BA1F12787B57DB0DE5D466659D4183CB524327232060719047AFAD7324FF00F5EBE8297272251D91F018A7595493AADDDEBAF510296200E7EB4E8E33231550588E71EC29BB4BBE141DC4FCB8AE9FC65E158FC330697145750DEBC96CB3DC1B75C881DF27CB2E0904818E9DFE95529C5350EE630A329425512D15BF1399A553B5811D474C8CD58B2D36EF518E792D6DA59D205DD2B22921073C9C7D0E3D7151DADBC97D711410234B3C8C1123519DC4F181EFD2B4BA325195F446EE91A85FEA56A6D0DF2FFA3A1FB3C3222B6DC7CDC1C1239158F25CDDD9B03F6868DE48F2DE5B11C7BE2A2916E34DBADAC8F0CD19C9571820E0103F976E95D36B5F0D359D274BD37519D16487525F321319C83C2E541C6091B81C0F7F438C14A14DABB5AEC77F2D6AD0BC62DF2EECE53AF5E69C0EEEA7F5AD5B5F0EACD65712CD7D05BDC4646DB6623748BB4B31072070074EF9C0C52685E13D47C42BBAC63494F98502B38078196272785008E4F1EF5AF3C52BB672FB0A8DA8A576CCC6FAD5C87539AD74B9AD112158AE08DD214567E3B03D4569AF82AF1992271E55CB923CB97E418ECC09C020F6C678AC0E58942C5481D3A7E1F5A9528CF662946745FBCAD73723D59F5AFB147711DBACD6AC3374C44794C8015801838E79233CD7B1DD7C64D5BC21A147A4787AE6D6DADEEA625B568C4714977920395520EC1CE0310381C66B94F0FF00C191AC784F4AD46EFC43A6E8D26A124B125BDDA90460E093EADEC718E3D6B83F13784755F0A5E7917F6D2C485B6C52329559070415C8E84115E74E343153E46D3B743E969D6C76594DD4B35CF6D57FC0EE7D3B79A2C7F133C376FE1ED1348B58D2DEDDAE6E5A4937F9D705392D2AE59B05B1BB90CCDD08422BB7F833E1D9B4DF87AF7F3F85B4BD22FCA79B1B887E691391965C6E070BC0CF391EB5E35FB29F8BB58D1F5E9B49B6885ED8DCECF3E176FDE2E3761E33DD72791D7927DABD9FE2B7C5AF19F8159DECFC2B672D963E5B8B9B966F9B247DD5033C0E832465493CD7C962E9D6557EA94F6DF73F41C0D4C2CA82CCA7A36ACD72F5F23CD6CFF682835CD7E5B1D76088695244047059DA6D904DC6D00066DCB9E991C67EE9C56BDFFED1D63E17D1869375E1096DE6F2F7CA92C6A63DAC01DC5718CB7048E39C8E335E33E3192E2FB50B5F172CABA6996E047148CE37A4C98258A9C9C2B9238000C703B57A0DDDD4DF153E075C3DDEA4227D3EFE28FEDD798DE2270BBD4EC19605B07A6703273C67D0A985A10F67271F75F9ECFF0053C7A598632A46AC2125CF1D765AAF5678CDE78A2CB52F1BAEB460821B32EB23DB6CD8140EA8B8EF9C1DDD7273D79AF431FB445F9D53FB526F0C5BB695CDBC11AC8E157001DBE6F52D8C138C706B90F0BFC2B4F1178DAE2CAD9EF2FB40B696457BFB48092EA9E83A0C9C0E7D6B0FC51E16BFF0E5AAC535F44D66266315A35C299173C1768C13B4E001EBC57B33A585C44B91EAD1F2F4B1598E129BAB1D1377E9FD58FB7FE0AF8C6C3E2068F34DA64571656D1156789DBCC8F730E7696C918208C13835EACA3F2AF803E0BF8C3C45A3F8BAD57434B892D249235BB8EC223244C9903254F19FA1EE79AFBFD58B28C0EDF8D7E759BE11612B5A3B33F5DC973179861B99AF7968C763DA9FB4528FBB4A17D6BE7EE7BB71A01FAD3B6F4A705A76DFBB49B22E22AE69CABEBC52E073CD3871F5ACB9886D8817AD2AAEEA77F2A5C7BD4731376302FCDED4BB7B53F6EDED9A5EF8A9E610CDA7A74A5DA29DC714ED86A1B26E331F29A55EDDA9FB69367E151CC171BB7B50169FB7B669401F8D4F3B10C2BF9D1802A4C7B51B2A7983988F686E3A1A39EF4FDBDB14BB7D68B8EE47B73ED4734FEB432D2B8B9911E0D2EDDB4EC01D79A5C7B5400CD9ED4B8CE78C53FF001CD3A93905C8B6F3D2973ED526D1B7A526DA9E60B916DA368A90A9EC79A6EDA9E61DD117A9ED5F27FED49FB462431DE782FC31741A561E56A17F0B709DCC48C3BF182474E473C9AF57FDA53C7B73E0DF041B3D3C4BFDA5A96E883C7C7951F7627B127007FC0BFBB5F9F1A80F2EF254DFB983952DD01C753F9D7E85C3394D3ACFEB75B5B6CBF53E0F89734A9422B0D4746F7656489A66088A598F6515A9AD5BB4377F671160D8A88656EA3CC1927FAFE55D97837C2F3E8BA35F789AF225FB2DB45940CB9DEE47C8BF4C95CFB1359D7BA0DC7867C086E6FD09975C993C8661C88D09667FA9240FCEBF47FAD45CD462EEAF6F9FFC03E0BEA3521479A7A6977E9D3EF6713E63347E581C160DD3D0629829CC479842F205357A57A51DB43E7A4EE14B451E9EB8C9A6F4124C4DC4118AFAEBF64EF8E735E341E0AD618CAB12EEB0BA63CA8FF9E6E7DBA03F81AF917F5AB9A6EB173A2CAD3D94CF05C1531874382148C1C1EDC578F9A65D4F34C3BA535AF47D8F6F28CCA795D75557C2F75E47D0DFB547ED02FE27BE9FC21E1F9F6E916CFB6F2EA36E6E5C7F0023F801CF4EA7D857CD9B41CF6C7FFAA97D49393D4F34ACA5719EE322B7C060A8E5F42342974FC4E5CC31D5731AEEB55F97A7613DF348CD8C1C6697148D9E31D6BD23CDEA756DA80D4B41B5D34C1198A37567BA51930A9E4AFA75EF9E3A5733710FD9EE258FE6011D970C307AD6DF902CEC5E5B0964B89D61CDE3AA011246C1540CE739CB0072064F1D3AF3E3E66271D7935CF4ADAD8EFC54AF18F32D49236F2E456C77C119ED53EACB18B80632B875C94524ED3E99AAD4983EB5B72EB738F9FDDE5F33E8FF0084D74BE2CF86D65A7DBC5149A84533DB5D1071225A20F37767BB3BBA283D8A8F4AF3BF895E159B4B926BC96D1166BA412BBC6A51149F9D828EC002A00ECB91D6BA3FD93F584B7F1BDF6932C5E745A85B6ED9DD9A33BC2E7D0FF857B5FC5DF08C526817B25C159CC588CCD8F964903EF91B1D834BB7E9CE2BE0AA62BFB3F32749ED277FBCFD3E8E1FFB532B8D4EA95BEE3E28F2D9407618071D7EB81FCBF5AFA87F653F8F1FD87710782F5E97167339FB0DDB9E2363D11B3FC2DDBD0D7CFBE34B3165AEDCC3146C96D1ED58F7775C601FCBF3EB55A7B52B0E9F73187FDE271B460E55B07073D7BD7D166184A39A61BD9D45BECFB33E4B2FC456CAF14E74B5B6EBC8FD535C7A7F9EB4A2BC1FF665F8DC3C796371A06A32336A7A7AFEE659BFD64D081FC47BB2F4C8EA0671D71EF0B5FCFF008DC2D4C0D7746A2D51FB8E1B110C55255A9ECC369A750BF3515C274DC4DA29DEB463BD2543620A5F5A31F352F029F32109ED4DDA7753F70A4FAD2E6013B7BD14BFC546318EF53CC02520E296979A398637F869369A75151CC171BF85253FDE976D2B8EE336F7F6A3B669D454F300CA314B46D3EB4B98BB8DDB4374A7FF003A42B8E7A9A5CC0336EEE29ACBF362A4A4EF9ED473011E28DA69DB4526DA5CC55C4ED8C52EDA5A367A52E6D4426D3494E3484629F36A3B8CC74A5DA6968A3986329BB4D3F1F8D1B6973B2AE369BB453CAF149B6AF98131B8A6D4BB47AD3368E298C6E291A9FB47AD35968E6D4AB8CDBED4DDA6A6DBCF5A695F4A7CC352232314DDA6A6C7CD4C6155CC55C8F1ED49B6A43D68DA68E61DC8B6D6478A3C3F6BE28F0FEA1A55E26FB7BB88C4C3D32383F9D6D63A531D33DAB4A75A54E4A717AA14929C5C5ECCFCB7D73469FC3FAD5F69974863B8B499E0915BB1562A7FC6BECDFD913C7327893E1EC9A35C15371A2C9E4A1CF2D0BE5933F43B87E55E33FB5CF825FC3BF113FB6517FD17588FCCCFA4880071FCBF3AE6FF00670F8849E01F89966F773793A66A03ECB72C4FCABB88DAE7E8C064FA66BF74CC211CF72455A9EB24935EAB747E1F819BC8B3C74E5A45B6BE4F667E80E36A8C5376F14F03E5FA77A306BF09E6773F7552BABA18CB5C9FC4CFF9136F811CEF83FF00472575CDF5AAF796505FDBB41750477103E37472A07538391907DC0AE9C356542AC2A357E569FDCCCB114DD6A53A69DB9935F7A3E5EF05DBDCF87F54D5A5B79A4B690DC968E5898A30C8EC473DEAEF8C3EDBAD68F7AA6EE77B962B3876958B1913956CE7A8E707B66BE814F05E8119761A269F96393FE8A9E98F4A46F06E8583FF00125D3FFF000163FF000AFBCFF59E9BA8AA723BE87C47FAAF3E470F68ACFC8F98BE197882E6F3406B36B9949B6CC5B0B9C796CDBF6FD3764E3D6BBDD4FC43A8EAD782E66BA9432C865891646DB0B139F9013F2F3E95E71636B63F07BF691B8D3350B3827F0F6B2DB635B88959221236636008E007F97E99AFA8FF00E110D0B247F62E9FD7FE7D63FF000AF5734CD69E1EA46A283719ABA7F99E5E5593D4C442745CD29536D3F9753C65752BC8ECE4B51773ADAC8DB9E01236C63C7257382781F95426690C2B1176312B1611E4ED04E0138F5E07E55ED8DE10D097FE60BA79FF00B758FF00C293FE111D0FFE80DA7FFE02C7FE15E27FAC34BF919EE7FABB57FE7E2FB8F1CB7D6B51B4DDE4DFDD42595558C7332E42F0A0E0F41DBD2A117B720A113CA0A2B229DE7E556CEE03D01C9CFAE4D7B47FC223A1F4FEC5D3FF00F0163FF0A4FF00844742FF00A02E9FFF0080B1FF00851FEB0D2FF9F6CAFF00576AFF00CFC5F733C428AF6DFF00844743FF00A0369FFF0080B1FF008527FC223A1FFD01B4FF00FC058FFC28FF0058697FCFB63FF572AFFCFC5F733C4E936D7B5B784B4319FF0089369FFF0080A9FE14DFF844B43DD8FEC7D3FF00F0163FF0AAFF0058697F232BFD5BABFF003F17DCCF15A4AF6AFF00844B431FF306D3CFFDBAA7F8527FC227A273FF00126D3FFF000153FC29FF00AC149FD863FF0056EB7FCFC5F733C5B68A4C7B57B4FF00C227A27FD01B4FFF00C054FF000A6B7853441FF307D3FF00F0153FC29FFAC14FF9195FEAD56FF9F8BEE678BD15ECEDE13D13A9D1F4F1FF006EB1FF008537FE113D13FE80F618FF00AF54FF000AAFEDFA5FC8C7FEAD55FF009F8BEE678CD1B6BD95BC25A21FF983D87FE0327F8537FE113D17FE81161FF80A9FE155FDBF4FF9195FEACD6FF9F8BEE678D545342B3A9475C83D6BD9DBC29A2FFD01EC3FF0153FC29ADE15D17FE81161FF0080C9FE14E39F537AA832BFD58ADFF3F17DCCF188E048548450B9F6AE57C55E368B4866B6B5026BB1C13FC29F5F7F6AEABE30789AD96F8F843C23A2D9DCEBD30FDFCD15B21FB329ED9C70C6BC97C69F07EE3E1FF865354D567325D5C7C8B0E73F39193CFB0C9AFAECBEBD2AAE2F11A396CBAB3E3735C26230EA70C2BE650F8A56D17FC131EF750B8D4A6696E65799C9EAC7A7D2A0DA76E7B5712ACEB2E7712AAD839CE29F34CD77724C60C516EC01CF1F5AFB8568E88FCB25CD26E527A9D9E3E5CF7CF1457170ACB3F9ECA788937119E71903FAD45E6337F130FC69A66728B8A4D9DDC7199B70047033CD11CCF09F918AF39E0D70AB3488D90E73F5A4F31BAEE6FCE9EFB85EDB1EA7A6DC69975328BB8DE199B8336F1B3247248DBC7E757F55F07490C6D2C07CD4DB91B79CF4EFF9D78EF98FFDE6FCEBBFF859F13A2F08EA0969ACD941A968D29F9FCE895E483FDA52474F51F9579B89552845D5A3ADBA1EEE0EA51C55454318D46FB4ADF9D891B49BB87E6685C63FD935D6784B5EBA55FB3CD99A207824FCCBFE22BDDF4ED03C35AE69F15ED8D8D8DC5A4CBB9244854823F2EBEDDAB8FBAF8536963E3AB3BFB5B5896C265613DB98C14DC0E4102BE4E5C4346BA953AD4ED247E854F836BE19C2B61AB2945DB6ECFA99C31D68AF4EFF00846749FF00A05D97FE03A7F8515E1FF6DD3FE467D57FAB35BFE7E2FB99F13E87E2B7F0D873696D1AB3BC6CD206656DAB9C28607214B60F1FDD1506ABAD5DEB70A35C3C7B4330047DF031C29279DA3B0AA09340CD179911544C06F2F3961DCF27AE32315A9E2ABFD2356D504BA3E9FF00D956D811ADBB13840380CC4924B1E4939AFD57963CFB6BDCFC0F9A72A3CAE7A2E8620E4AE3EF67AE702BABF03E830EA97528FB5DAC77E8E3C9B7BD2443704F54DDD15FD3247D6A8F87ED6CA6BE413C6B3411A3195C96E09380F803A29238EF8AD493C2F76B28B0B636FA822AEF8E7B772EA15B9C929DD7DC719E40ACEACD3BC1E8746129CA9B55B741E2E9AF3C69F101E216EA971F240B6FE7021422F2039C0C706BED1F08F8AB42B4F0BD94819BED57518692D548B89D9B00631106E8000300000715F297ECD696171F16ACC6A49F6ADE922C6193CC52E78C9F418EFF00A57DD76F61059A110411C2BE91A051FA57CAE715234D42835A247E99C2B87955A75319CDACDBBDFF00A47C9DF19F47FF00857FE1D935CD32F2DF4EBCD7246827D2A144758518EEC2E79560BD48C0C935F39955F2D12372F2C99DEB8E98E83DF3FD6BE86FDB235CB79BC49A368D005F36D6232CAA800C17C6D07F019FC6B80F09DBF86349D3FEC9AD58C906B586769AE6768F0AE842AAA846C6012D9C75E2BD6CBA6E3868D46B57F91F219C50588CC2A53A6D4630B6BD3FA643F06752F0F59F8922B7D6ACE4BA33711CA85008C93804A93F30C1CF1E95EC7F1FF4FF00093782E0D3AE3508745D534B8FFD1F4BB75045CB12363E7BAE3775E73BBD315F315D18DAFBFD197CB6F309015FE403B60900818F5A9756BC7BEBB6965965BA90AED67B87DEF81C0C115D35308AB568D55269A38E8E691A381A98374D3BF521B15BBBC636166D238B9705ADE37F95C8E8587438C9A5D3EE1B49D4A29C3BAC9012E8D176600953F98155919A360C8E438390C0F3F9D27CDB836E3915E95B75D0F9C8CECD3BEC753A85BEB1E1AD534AD7B526B79F50BA097F143724BBE031237AF6FBAA71FDD61EB8AB31F8CB58D5269248AF162492E7F77A7A48D1471BB9C92899C018047E35B7AC7C6687C5FE151A6F887428AF2F61B610437B6A444ECC33B5DCE0E4AE4F0300F7CD79DEA56B35BCC15AD3EC60AEF58F07214F39279EC7AD72538BA8BF7B1D51EBD6AB1C3CBFD9E6DC1DBBAD7CCD2F145BDCDC6BB7AAE96A1ADD844E6C40F2931850323A9E0723393CD7AB782DF4BF02E997D1C715AAB5D089975DD6ACDB3126D21961842991C96DDD428C2F279ADCFD9A6EBC16D67AA97D01E5D6ACED7CD6BFBA712EE6276AAC6B8C2E588518C9E6B0BC5D6FE04D6BC69A7E9579E22D436424437F7A557CBDF9F9F692060024F5F4EF5E6D5ACEA4DE1DC5D97E27D061709F56A4B18A71729BD2EF6E9D7F4FBCF35F1E6AD3EB1AFCB7C75BBFD7118E23BEBC8CC2588C7DD5DC768E9C0FCA9B6B63A10D35A7935676B868806B64B7666DE7380A7A1ED9248EFD6BBA9A6F0E78D355D2F42D36C888E19E75864B30F3CDE5A81B59C3F50DB7763B0E727A5735796579636375E148AC20BD9C48B7A66B640F7077202101C720292485F524FA576D3AAB9546D6FF0023C8AB876A53AB7E74F6B5F7EDDCB767E32D2E6F04DC787A6B1491E2B8FB4596A739656DDB7023C282067DCE064F3595337887C6DAE4505F5F5E6A3A9A9F2EDDE49FCC0C41DA76B96C0007A139AC4D16C62D46F0C37778BA659F2ED33A33203B4E063AF3FF00EBA636977D6F2C2225767601E3F2B39239231EC00CD6EA8C62DB8EFDCE5962AAD650F6BAC5249A5E5FD68CFA87E037C34F12F83FC797505FDADE416571149135F4326F4D9ECE395662411B79F94FB571DE3EB74F0F7C57BF961B4D46E20B72B1A4171A92C93A4B90558659BDCED278079C554F00FED1BAE7853C19A8DBDDEA736A4E6236F6D0CDB5648188E244723E603FBA7A62BCEED3C4527893C416489E65B5D5D4DB2EE7B8B97613337CA0BB1CE3F01F4AF0A9E1711EDE756B68AD63EB2B63F06B0D470F866EFE7E7D3B13F8CB50BAD492DEF351814DCCCD23B32C0B13193CCC33300A14E48DB93EE6BD6B47F0CDF78E3E1C5A5BC76AD750EF5956DAD74C9CC484928373228123AE59B1C01C0049E07A37C21FD9F7C2DA2EA16DA8DC7886DFC4DA9F93224D6D0CB1496E19BA90012D9193924E79E95EFDA6E976DA4DA25B5AC49044A490AA300E7E95E363B36A74DAA7495DAF97DC7BD96647524A553112F8D5ADBFDE789F8374DD7BC0BF0FD3498E6B95B88D76C7158E8770163253E6CBB2E1BE7FE207A76CF15F357C50F86BA8F863569AEF55D4ADA6BEBE669D775B4D1B3E7A9612AA9EA4F6238CFB57DF7E23826B8D16E218159E597647953F300CE031FC149FCABC47F6B4D02F2EBC2D652E8DA25C5F6A5712C76D25D5AC4D23C712E58261738058F2475AE3CAF317F58B495B9B767467B96C1E0EFBF26CB53E3BF0FF008A358F05EB30DF697A83D9DE43F2ACB13646DF4F42BEC6BEB0F847FB565A5F683F67F164CC755595628E4B5B573E703C1271C0233CE3F0AF2BF09FEC93E21D73C29A86A57F2FF62DEC5B5EDEDEE130B2C6537312474232063D8D78C7DAB50D0669ED096B59124D92075C3AB29F5232A4118EDCD7D5E228E0F368CA316B9A3D4F88C16331F90CA2EA45A84BA3D4FD48D27518B57B08AEE01279320DCBE646C8D8F70C011F4ABD8CF15E29F00BE20EA7AB681A4D97887CC8F51B88DBC9924C6EB85418DE7D3208C7AE09AF6B51F77A8F7AFCB31546587AAE0FA1FB3D1AD1AF4E3521D470FAD3BFC8A5DA69C23E9ED5E73B9771154FAD2ED2D9F5F4A555C7B9A76DA97A1171AA38C52EDEA314EFC29FF8D4DC571BB4D2EDC7BD2F6A72F4A8B92342D183CD4817E51EB46DAC7989E61B8A31ED526D3D73463DEA6E223514BB42D3B6EDA5DBF9D45C0652EDA5D9D69DCD2B80DDB4D3F5A936F1EF46DA5B00CE3D28DA6A4DA29BB4D2B85C8C2F734EDA7AD3CAE7AD3B1D074A8E60B916DE714BB71EF4FC5145C57185694FA53A8DB9E3A1ACF982E47B7BD2F97DE9FB45260D4DC2E783FC76D22F352BFF002E3B792E6268BCEC7F0AEC538FD4F4FF006BDABE6FF85DFB3B6B5E36D59EE6EADBECFA6AEE399F39272476F7E7F0AFBF6F34D86E8E644527695E9D8F6A4B1D36DF4DB710DB44B1463380A307939FE66BEAB0BC41570986F61496BDCF371996E1F1B52152B2BF2F43E69F8EDE13D36C6E3C03E03B085561D535012DD471F044281179F6241FC50D79A7ED99A4C5E1FF0011F86F4CB7558ECE2B29248D0762D21CE3F1AFA3348D1E4F147C7CF11EAB71017B3D16D6D6CAD646E46FDAF23E3DC193F957CF5FB510BDBEF88DA9EB17F64D2695059BD9D9B8FBBB802A1FFEFB7CFD315F4793E21CB194A9CA5F0C6FEB291F399C5294B07524959C9FDCA3B7CB4B9F3B58C0AEB33BF016362B91FC401C0FF3E9551474ED5EB9F0AFE1ECBE2ED0FC4B12A328B7D365995CE0FEFA3F9F07D01438FAD71FE2DF87DA8784F4F6B9BC474DB786D402B8CE0139CFE1FCBD467F44A78EA32AD2A3CDEF2E87E755B2CAD0C3C6BA8FBBB9C985E71D6BA5D0FC2F7DAD68D74F6B6CD2B41FBC72073B7D7E99E3F3AC3B7B569AE238D07CCD8E9EFF00E457DDDFB3BF80AD3FE1108AE66B5F2E595544892A0EAB8040FF00672B8C1EE0F635E76739A7F66D2552DAB3D4C83278E65527ED1DA291F09DF69F3584BE5CD1B46FD36B7AFA7E9FAD53FBA482327A57B07ED2CFA3DAFC52B9D3F485063B05F2EE245CFCD2F561FF0001E071E86BC853264040CB6722BD8C257788A11ACD5AEAE7838EC3C30F899D1A6EE93B12DBDAC971D14B6E076E3BF6FF000FCEA161E5B3293D0E33D6BD73C61E151A67876CF50B7B5685F508FCD8446A594020099723A6C704FA9F3131C5792488D0B15652841DB86183C76FAD3C362235D732162F08F0AE316156B4BB29350D422B7897748E7000AAA4EDE08E6BA8F85F64753F1F68B6EACCAAD3A8664192173C9FD6B5AD53D9529CFB2BFDC6183A5EDB114E93EAD7E24DE268EFFC2FA28D0DE7CDA4D2ADDA850412C531C92067192BF5048E39AE417A57A87ED11736CBE3A5D36D1162B6D3A0FB3C480E4A2125955BFE024123B1635E615860E6EAD08D5B59C8EACD20A8E2A54A2EEA3A20A28A2BB8F20ECFE0CEBE3C37F14BC377CEFB6217891C849C2856F97F2E47E55F6D7C4C4B4D434ED1F4BB7944D25FC988F6BFDFD8C08CFAE1CC64FB29AFCF25255830382A7208ED5EFBF023C797379E22D29F58BC33C5A5D95F496719624895947DE27B61DBF2AF87CFF2C75AAC71B0DE3D3F2FC4FD1B8633454A12C0C97C4FE5E679E7C56D423D47C4B76D04423B5865F213DD500451FF007CA8FD2A859C31DD7806E6466C4B697A855B1D030E9F4C835A3F14F528E6D6FCA851502B1761B30776493F867F2C91CED15C9D9DE3C56579006FDDCA1491938E0FFF00AABDFA1172C3C3E47858A9C69E32AA7ADEEBE67BA7C14D602EA36BAAA2A5B6B5A7A853181B16EE1C82506380D81B80E9C647195AFB7B49BE8B54B082EE16DD14D1AC8A7D8818AFCFCF82BE22D296F2D34ED75BC80D204B4BE24ED5C9FF00532E3FE59B1390DD548CF4C8AFB67E16C32E9BA4CDA5CB71E7AD9CC56266605C237CEA1801E8DD471FCABF2BE2CA095553EABF13F4BE1DAAAA6154574FCCEDB6D014FE34EA5DB5F9BF31F58263147974B8DB4BB45170194ADCF1DE976FE546DA42B8DDA28A7ED1D69BFC54730C3F873DE85A5ED83C51F76A79900CDA68E7A52D0C31EF50E60230A158F434BB7DE8DBCE6A79D8083F5A6F3EB4FDB4B834B9BB011F3D0F14EE3D69768A369F4E2A798771B453B1D78A4DB494804A6E3A53FE9C9A4A5CC55C6D348352518F5A5CC1CC336FB5232E29E071D734628E62AE478F4A5C7514B8F9B1DA976F38A39AE319B6865EF4F23149DF34B9B510CDA29369EBDAA4C0FAD27E145D742B41BB4522AF734EA461DE9F3068230FCA9BC53BF86929F30C6D230229ECB453E62AE447D68C6EE69D80DED45352DC633146D14EE3D293D69F368033AF348C29FF0077F3A439A9E72AE336E7DA92A46A66D357CE31981D291A9D83B7D29197A54F39478DFED49E078FC59F0AEFAE962325F69445DC253AE010241F4DB93F857C0FC8C3039E73F976AFD55BCB68EF2D658264578A452AEAC321811820FE06BF357E2A782EE7C01E3BD5746B98BCB11CAD242DD9E26E548FC3F91AFD9B8171EAA519E0A4F6D57CF73F28E35C0B53A78C8ADF47F2D8FBDBE0DF8C13C75F0DB42D554EE99A0114C3FE9A20D87F3C13F8D76C3F4AF93FF626F1A4CD75ADF85667DD008BEDF6C33CAB060AE3E872A7F0FAD7D63F4AFCFF003EC1FF0067E63528DB47AAF467DDE458E58EC053AADEBB3F54271F85376FF2A7FAD257CF739F404473D6998E7D454D8EA29BB78AD798B4CF02FDAC3E1BBF88FC1F1F88AC17FE265A31F31B6F568380DF88383F4CD76FF03BE2143F11BE1EE9FA8EF06FA01F66BD8FBA4ABFE230C3EBED5DDEA16316A167716D3A89219A368D97B104608FCABE4DF80BA94DF0B7E3AEB7E0BB96D9697B2B428ADDE45CB447EA54E3F115F698397F69E555283D6747DE8FA7547C8E32D97E654F12B48D5F765EBD19F5B32D26DF5A7F5EDD686EBD38AF8BE6D753EC532361CD376E3AF35232D14FDA148878DD9A465C549B474CD18ABE62EE438A6E3BD49814983473D8A233C526DFCA9ECB9CFA535978F6AAE6EE55C8D80EC69B81D3BD4B4CDBF856AAA1A5C8D9452106A4DBEBC523552905C8F6E3AF4A1976D38F2707A537079AAE75629319F85437085A17543B5F076B7A1C715636E314D68C7AFBD5C67666BA338CF04FC3AB1F06FDB6E54FDA751BE94C9717521CBBE7A01E805717FB49786E5D6FC188F1866F264DC235EFC1AF656ACAF10430CBA4DC89D4346B197C37B035EB60F1D5618C85793BBB9E7623054AA6127864AD169FE27E74DE799048E9CAAB6095C77A23510DABB12CB239DA076357BC4D319F5CBAB8645FDE4CE4A479DAB9623152D869ABAD78834FD3607692092458D582F382476F5EBF957F417B54A92A92E9B9FCB13A0FEB12A50D5A7645A9BC3AFA7F81A2D564428F753F9287A700649FD2B9AAFA13F699D26DFC31E15F0A68F6ABB5232EC4FAE15467F9D7CF75CB95E2BEB98755FBB7F99DF9E60965F895865AB8A57F56B50A28A2BD63E74286E463B7F5A29D0BEC9A26C6EDA7EE9EF41514AE7AB7C11F88577E07D4E3B5B995A6D16E597ED10F24DB9638F300EC3A6EFAD7D611C91DCC51CB13ABC6C32AEA73F883E95F1E7C2D5327C48D29A68BCCB6BE95A3911FA1565231F5E95F60697A5C7A4D9A5AC1F2C49C2AF603D2BF22E278D2A7898CA0AD2923FA17822B579E0E54E4EF08BD3C891968A948FF00668AF8EE63F4BB1F9E97132CDB1446AAA8BE9D79CD355CC672BC1AFA5BC31FB28E8F69E1DFB478CBC4D068FAA4993F671711848B191CB13CD7210FECCDAAF882F35193C2F72759D1EDDA38ADEF9A3F2D6E6424070A49C6C4E72E3238E335FBD7F68E1D3E56EC975E87F26D4C8F1B151972DDCBA5F5FB8F35F05E8373E23F1169F69199922B9B88ED9A789776D2C78CFF009EC6BE9FF88DF076EB4DFD9FECAD156CED352D1435D4D246B92E39DC011DD94AE7B7CBED5DAFC01F81707C3FD3A6BFBE463AA5C48DFBB7398D543615941E870339EBCD763F1A2331FC2BF139C67FD02418C7B57CC63F33F6B5E30A3B2773F40CBB228E172DAB2ADF14A2FE5D51F247EC9FE178FC4DE3ABA3340CD0DAC4B38B98E4DAF0C81BE5C1F7E7F2AFB2FC59E20B6F08F86F51D5EECEDB6B388C8C3D783819F7381F535F31FEC3EBBF5CF12A9393F678FF00F4234BFB6778EAE64D634DF09DA5C32DB245F69BA890F123B7080FAE064E3A64D6B8FA4F1798468BDAC8796E2E395E42AB435937A7ADEC798F84659BE2078FB54F19EBF14B7961A7BFDBEE2289496998B010DBA8F76DA3E99359DF17BC49E20F13F889752F10E9E3499E54FDD5AAA0461170558F7DA411C9EB835F637ECF5F0AE2F87BF0EED22BA855B54BEDB7975B947CAE46557FE0238FAE6BC27E347C1BD6757F1478B7C5DAE5DAE91A45BDC2C76CD2299249C6C0116351DBA01EF9F4AEBA38FA2F16E9A568C744FF0003C5C764F8AA397C66AEE727792F3DEEDF96C785697E28B8D251CC7142F371B26741BA3C00A36FE00FE759333F9D233901431CED5E829BB46D0770CE71B7BAFA6693BFE18C57D4A8A4EE7E7B3A95249466F61690FA0AD8F0AE871788B527B292ED6D25689DA1321015E4032149ED9F5AA3A869775A4DC245728A923A24836BAB0DACA181C827B11C76CF34732BD86E94D4154B686968FA6E9D1DE38D62F0C307D944CA2DD81667FE15E87F1AD8D3743856C4DCC1269F716D24D05A4A6490F9DBDFE6DEB91C01B704F4E0F5ACDF0568FA6EB3AB4B67ABCED6569E4C8C6F514B080A82D9C2E7703D3159D35E48B35D369E2486D31B1B6A95C291B7E6F4CE7FF1EAE697BD2E54CF4A9CA3469A9B82B6BEBA1ED5F0E534DB5D71E1F0EDFBC777637AC8D68E05C2DF8491CA32045C91F74E76F1806B13E31782ECE1BA96F2C2CEDF4A732B09A1BBBF8DA72428662630711819E9B89C9C638AF2ED0B529B48D4A3B986692175072D14AD1B631C8DCA4100FD6AD8F107DABED0D79043249328549A443FB9C73F2007A9E993CF7EB5CDF559C6AAA89DCF4279951AF835879C15FA7918F6F2490CCAF13B2C8A41568CE0823B8F4AEB348D73C4F636F7B79A7DDCF0C56D1F933C8AF90A920DA46DE9CE466B94F33E68CC63615EA7DFD6A592EA69232A647F2B18DB9F9464E79FC6BD09454F747834EB3A5AA6F4EC6BD8786AEFC41657B7568B1B359C0D713A2E77901F19000391F3543E4C36FA1C376BA87CD2398A5B10089318E5BD36E38E4F5CF154F4DD4AE34AB912C0E40E03A64ED9003F758670CBEC78ADED597C3DA86810CFA79B8B4D4A272255B90D24978EEC4EE0C30A81171EE49ACA578CACF6674439254DCA3BA5ADFF0035FE44FF000CFC39A778B3C75A5E99A94A6CECA6606460865E00FE2DA410A7BF3C66BD2FEC7E08F847E3CD66DB519E5D6AD190AC50DBC0635466219590EE24B2E7A6578E849E2BCEBE1AF8AEFBC13E204BB8F488354B7B76CDDC725B09488F9DFF0030E9C6793C71935F477C77F0869DA2F87F42D5F45D1ADAC6DAFE68C4F70232F32C6E87F7457695DA411927FBA057878DAFC9888D29ED25DFA9F599661E0F04F114A2B9E0F5BA6F7D3E6725E03F12783EDB5C3E31B53AE694D1CA64BA63034AD71B896D81B246CCAEDE47427241E6BEBCF0FEB565E24D2EDB51D3675B9B49D77C72A7423FCFF235F3BFC2DFD9D63D7FE1CC11EB73DEE9B34D79F6B8BC9997E64E02EE1EBB72B83DCD7D07E11F0969FE0BD1E3D334B8DA2B5525F6B3E70C7AE33D3E9D2BE2B36AB87A926A9B6E4B4F91FA36511C4D3A69558A49ABE9A6BD743636E318A368EB9FF3FE4D49B7DA976EDE6BE72F6B58F7DEA44D0AB82AC3208C1F7AF27F891F027C39A87866F27D23C3D67FDB36F0B7D9A43C1CE41249EEDC1FCCFAD7AFEDF6A5515B51C4D4C34D4E9BB1C589C3D2C54392A2B9F17697F07BE214367A55FD9D97D9F5D8DA59209246CFD963455DA0B1E7713F285C631C57D7FE1B8B515D16CD355923975058FF007D24230AE4742076C8C1FC6B536E473D6957EF1E2B4C6E3E58C4B9D25639B07838E0D3509377EE0B4EC1E4D1B7D29D8F4AF22E77DC4FE2A774A3029541A872B80BD578A146697F0A70F97B5437A5881368EFC5382D18A77E15949F622E2EDF6A1569CB4B5937A08652F23AF269D4608EB517246EDA307AD3D6976FBD2B80C5A36FF3A76DA5DB4B985CC331EA28DBD6A419E692A1CAE3B8DDBED49F85494A3E94B9BB0AE4417AD18A936F19A369A9B85C8F6D2EDF6A90AFA7349B4D2B85C6EDF7A6E2A4DA69297321DC6E39EB453FCBA6EDACF983986FE14D65A9A9BB4D2B8EE52B7B282D5A778A3546964F3242A3966C0193F801F9578E7ED55E198F52F84B74D1429E6ADDDB8CF43B5A40368F53B8AFE55EDCD5CBF8FBC267C63A7E9F65BD561875086E66CFF12A65B1F5DC13F5AEDC0629E1F131AB296CCE7C4D3F6D4A54BBE861FC2EF86BA7783FC2EB12DAC7F6ABC890DD3ED00B9DA0106BC17F6DAF0FB5B68DA6DDC691ADB0BEF9F03E62EE8DD3DB0A49FC2BEBA58C00001D38AF9F7F6D7B559BE16D812305B57817F02B2715ED64B8EA92CD61526EF77FA1C39A457D42A538AB26BF53E65F877F096F7C55E2AD39444F6F6CE8ADB88EA55549C7E041FA1AFB9AF2F2C7E19F812FF549DD6182D6032B6EE9B828038EFD0703AE6A5F0778174FD1ACAD5D2D551E1DC10ED008CE47FE8381F80AF17FDB1FC453B58E8FE1FB46223DC2F2E994F619F2D4FB92AC7D80E6BD2C46367C419853A1F653FC0C6187A392E0A5EC756F567C99E36BE9B52D4B51D5A6C79F7F7B213D0EDC28383EA7E7C13EA2ADF807C132F882DEE6E9232EF6A44EA84F12229CC8BFF7C863FF0001354F56B6FB55BE8B651AE66923799703972CEDD3EA147E35F537C24F867058E8B0DE5948268E7851D9BAEC6C2B1E3B8E15B1DC12A71B88AFD1731CC2380C22D6DD17CBFE01F0996E58F1F8C94DAD159BFCCB5F13BC02917C21D9651A4A6DCAC9665871086E188C74C284EDC94F6AF94EEBC3324F71A70B6B6D966FE64514CC0869D9465DCF1C03DBDABF476DFC36BA87869ED27840564C05F6AF22F1DF8234BF0BE8F71AC4D68AD06936D23246CA0041B49651DB270173FED57C46499F3A77A32D5B7A7CCFB8CE326A38ABD5E6B28AFCB53E11B852B33AFF0074915EE7FB37F81A5D535FB1D4E1DC0C492309957E50C1B1B5BE9F29E3B3FB578E693A54BE25D721B3899229AEA5DABBC900139C7D6BEDCFD97FC16345F0FA5C7449637825848FBAF90C1BEA5481FF00001E95F69C498F584C0B8A7EF33E1786303F58C6FB6947DD8EB7F33E64FDA3BC3E74AF88B77782168E3BF2D3A963D403B47E3C0CFB93E82BCB057D13FB6818EC7E205A5B80A5E5D3E224E79189242DF9923F2AF9D56BD6C96B3AF97D2A8FB23C0CF69C61985551EE3A8A28FA57B6782276ADEF085EA58DE4F23CCD10481CAE0FDE6C0DABF89C0FC6B0467183573454F3754B74F20DC976D8220D8DCD8C0FD6B2AC94A9B4F63BB093953AF170DCBD7515E788359725CCD331CBB750A3FF00ADFD2BA6F0AF87D7CBD66DE58FCC97EC2EEA719C1C8C7D3FFD67D2BD33C0DF0B61F0DD8CF77ADCD1DA34800960BA9160707031862C3E56CF5F6238EB59ABAF7853C33E2220EAF0DDC3347279F35AC6CCA091EC3A7B0E8146715F2D5332556F4A82BA5D91F77472654796BE2E49396F7672DF08F45B7BED625B1D42105880551B8DFDFF004EB91C8CE73D457DC9F0BB4B974BD37C999FCE08BB62B863890C7927CB7F52A49C7D4E3835E01E11F0BF87FC48F6D73A25E437D2DAB6E31C2FF3940DD0770C0F2B90320853D4E3EA5F0B69E967A5C6148718015F1CB2E38FC474FC2BF37E29C72ACD4767D8FB7C9B051C1E1FBF67DD1B1D7DA936D3B69A39AFCDF98F72E033428DDD39A5C1A071C52E715C4A4E7B53E93D78A8E763B8DA36E0E69DCE3DE8FC28E618DC739A56A5C7CB46D3C0A8E642B8C029D4A17E6A77AE78A3982E47B7DA8DBED4FF00D293A673CD67CE1711BA8C525296A2A79C63703E947E34B4542A83B867DA9B4BEFD29339ED4B9FB8C4DA7D297B7BD1CD277A5ED577010FF5A31F8D2B51FC353ED3501BB46EE94ADD38A3F8A95A8F69A80CF7A3F8A9693AE68557A16232E695BE5EB4EE3D69AB4736A4DC6FDEF6A4CF38E94B8EA6931B850A669706F6A4A527D46693935A7B518DF6A4C1EFC53B1DBBD26DA4E6AD718DC1F5A39F5A7F34DDC78AB8D44171A69BD33DE9DB6936EDA4EA97710E40348B939A77E949CD1CDD404A4A5A29738C0F34CA7D37E9CD573265894DC5498E299FCE853019B7D6BE51FDB63C105868FE29887DD1F629FF0032C87F56AFAC4FEB5C57C5CF01C5F123C07A968AEFE5CD221781FF00B932F29F86783F5AFA2C8330FECFCC69566ECAF67E878F9BE13EBD82A943AB5A7A9F03FC1DF16B781FE24E85AA89BC8816E04770DDBCA6F95B3ED83FA57E91AC82450CAC191802A7D73D08FCEBF2B6681EDA6921954A3C6C5195BA823835F7DFECC3E3A5F1B7C2BD35269BCDD434A1F619F71CB617FD5B1FAA639FF64D7E99C7781F69469E614FA68FD1EC7E7FC178DF6556A6067EBF33D648A46A90FBD376FB57E2DCC7EBB7198A46F6A76DA5C71EF4EE51130F94D7C7FF00B5A68F71E11F891A078BB4FF00DCBCA887CC03FE5BC4D904FD576FFDF26BEC36538E2BC47F6B6F0BB6BBF0AA7BB8977CBA6CEB71F28FE0FBADFCF35F57C318AFABE6508CBE19FBAFD19F3F9F50FAC65F512DD7BCBD51EB5A0EB10F88B46B0D4ED8E60BC81274FA3283FF00D6AD0E735E25FB2378A9B5FF00858B6523EF9F4AB86B723BEC3F3A7E1C91FF000135EDF8AF2F33C3BC0E36AD07F65E877E598A58CC252AFDD223DBF36314D2BF954BB69A413C0AF3B9B53D6B9132ED6A4DBD6A5D869ACA6AB9C08B6FB526DE3D2A4C639A4DB43917721DA690AF18A9B6D37CB357CE3B9011E869AC307AD58DB8A6ECAB532D321D878A66D19E2A72BC5466323A552968591ECF4E69ACBEF529523A5232F4C7355729322C6DEF9A6EDFCAA6DB4DDBCE2A948D11015F9B1D6B2BC4D692DE6837F143FEB6481D53EA456CB2D3719ED5BD1AAE9CD4FB3092E64D33E04D43C1F710F89CE96C86578A531B31EFCFCA4FB1CD7BEFC17F81E3C377ABAB6A015E60731AB0E57DEBB297E13C527C4A975FE3C8751FBBC719DA07F4AF438E2586311A8E17A57DE66BC4553114634683B5D6A7C3E57C33430B899E26B2BB4FDDF43E41FDAD358379E3BB2D3C642D9DB0FA12E7FF00AC2BC3F9E6BD97F6A65F33E23CD22C6CBB218A32C7A310B9247E7FA578FDBE1B78EA42E6BF52C939639751B2B688FC6F899CAA66F5E52EF64454514BB4952DD00FCABDCBF53E56C2518DCC06714527E14C6B73EB1F81FE00B4FF00847EC750BD895AFADE52F1CA0F0C31907F0CFE95ECDB6BE61F82BF1826D3ADECB4ABB917CB8CF96198F3827FC2BEA0560D1AB83952339FA8AFC233DA388A38B6EB6A9EC7F51F0C623095B010586DD25CDEA42568A4FB5C1B8832A023DC515E0A84DF43EADCE2B46CEDB4FF00831E0ED2E40F6DE1BD3C4A063CD9601239FAB3649FC6BA84D3521458E38D638D461514600FA0AEB1B4B39E99A89F4C3E95F40F14E776D9F9BD3AB4E9FC0AC730D687EB5C67C5CD3CCFF0D3C4E80726C26FFD009AF53974C6E06315CEF8F7447BDF07EB702AF325A4A9F5CA11550AEAF72EBD653A338DF74CF87FF625D4E2B1F1B6BD04ADB524D3FCD24F0308C33FA135CE784E393E397ED2497322F9B6925EB5CB0C6408623903E9C2FE75E59A2F88352F08EA17EF61298269A196CE438FE0705580F7AFACBF616F85F34363A9F8D6E8328BA536569195EAA082CFF9803F035FA7E33970BED31ADEAE292FEBEE3F2FCAEA3C7CB0F826BDDA6DB7F7DD1F4D2DB0550A060018C565EB9E1DB6D6922F3E18E49217592359012BB8104023BF207D315D4CB6BB5493C0519666E00FFEB7BF615F22FED11FB54490DEBF85FC05705AE73E5DD6A50AE4EE271E5C3EA7FDAFC07AD7C0E0E8D5C65551A7BAEBFA9FA763F32C3E0E8F3D5D7B2EAFC91E2BF1FBC21E1EF06F8AEF2C34DB967D44CBE64B047B4C7106DC58641C03F7401DB19AF2C8D8074C9DBCF2DE95E9579FB3EFC406F0E0F11DC6913CB04D1BDDC8CEE0C9E5FCA448D93C96DD9F5E0922B90F09F846FF00C4F7CA90419B6565134F212B1A038032D8E09E9F522BF4FC2D4A54E9722A9CCD6E7E218BA156AE2AEA8F2736C8885AC6D6F73199630A8E664B8561CA96DA415EBD7B76F7E2B31A40CD22C8CD3A64AAE5FA1C707F415D26B56FA759E9B09D36F5EDE593CC86E6D998960AAD95DC420DDBBD3B6D15CB9DCD86C3156F941C7071CF1EFF00E35D74DA97BC716222E9B50FD4D2D1BC497DE1F82F62B397CA1790F932EE407E4E38F6E9DAA0FED6BAFB09B22EBF6666DE5762E49C83D719EC3BD5A97C27AB43A6DBDF9D3AE05ADC1211FCB3CE003903D0820E4E33CFA565329562AC086538231DFB8C55C5C26DB8EAC897B5825195D2FD0B50C76934172D3CD2472A2A8811630439DC01DDCF002E4E79E6AB36D19D8723270DCE4D4FBED9A53E5B490A1520A93BF9DBD38F561E9DEABFA0EF5A2EC8C656EC2D6968F3D85AB5CFDBE03744A158D165DA15FB31C6738FEED6613C71EB57ECF43BEBD9A38D6178D6564459243B631BF1B72C7800F5CFA544DC52D5D8BA2A7CDEE46ECD393458A4D1FF00B5A1D4B4F52AED00B33F2CC718C305EE0E7FF1D353E877CABA72D9DE69326AE6E23952C6346D8239186DF30607CE4609C1E38ADFD43F67EF1BE9BE1D8358B8D18C1692465CB1701940ECC3A82411F4CD79DCCD27980484EF8C6CEBC81E99AE7A728574F92573BAAAA985927520E0DAFCCE87C3FE34D53C3B3C91D95ECD6715C662B9CBAE1E23842AD952318CF6AFB9FF00676F1CDD7C46F00E35AFB1DCDD5ABF94DF6728414DBF2965048538C8C103A702BF3E7ECF2F99B046DBF83B40E413D0FE391FA576DE057F14E972C3169D7B7FA2C77CCAC93AB4C91CDB318C95EA00DC7FC2BCCCD7054F134ADCC935D4F7F20CD2AE0EAF2CA2E5167E962055C053B075001C7148971134C634915A41D55581618F5C74AF9CFC0F79E3DF04DD5EEB9E28F145B5FF008563B4966498319E23B480A370F9949DCA40E49E78F4E73E1DDBEBC97BAA78D7C35A8D8EA370180BDB390B172A555D8A9918104967C0CF615F9F3CB1FBCF9F6EBD1B3F528E66A528A706AFBAEA977B1F5C6D1D8D2ED3D315CC781BC6569E2CB20AAC21D46200DCD9BB7EF216CFF10F43D88AEAC0E2BC3A91953972C91EB29C5EA98C0B4E55F5E94EDB4FDA2B9F998AE4657774E2953AF34FDBD28DBED59C98AE26D34B83DF814FE7B734AAB59137B6E379EF42A9F4A76DA5C1E3B0ACEE2BA0F4A503D78A36F4A5ACDB0B86DF6A76DF5A5A5E4D66D9171B83C53F14BFAD1B4D60D917100A5A751B4545D886E3DA976D3DBE94A3153710CDBC528FBD4EDBED477A5701B81B8D2ED1E94EDBDFBD28153715C6D14A4703D6976D473073219B6976D2EDE734A54B74A5763B916DCD3B68A763140EF53CC1719C7AD26D1BBDA9F81471E952E42B8CA1969FB7F2A39351CC3B8C65F9734DA94296EA299B40EB53CC1713069BB6A5DBF35215F4A5CDA58688D96BE7FF00DB48E3E18691DB76BB6C0FD364B5F41E3DABE7BFDB73E5F851A6B038D9AD5BB7E492FF00535ECE4725FDA34BD7F43CCCCDFF00B2CCF78B551F658B8E362FF2AF9ABF683D0FFB73E27699A529F2CDD58BDC4ADD46D2DE516F6DAB1293F438AFA5EC3E6B1B76EB98D7F957947C58D04378AA7D70A366DB409A1DFD9419093F880CD5793E2961F172975D52F53B2AD3F6F18C3D0F8F75AF00DFDEEADA73E9F1C917916F13C2AC7E6D8402A41F7DC07FBC47A8AFB37E09E9F04DE1C835048FCA92E5019A3030A24E878ED939E3B1268D3FE195B471D8908336F02C71B63A851B707F01FAB7AD777E1FD1E3D262758542239DC71C658F24FD4F7AF4B3BCED63A92A5FCA4E132FA7807527096B2349536AE00C718E95F30FEDBDE365D17C1FA6F86AD582DC6AB379D71EBE4C641DBF467C7FDF07B1AFA936D7C11FB62C925F7C667B69AE58DADBDA44C17B4608E7F5C565C2542388CCA2E6F48EBF76C7919F579D2C0CA31DE5A7DFB9E47F0C6CEEEE3C65A54D6ABBE5B6B949C2EEDB92A77607B9DA715FA47E09D320874E79E0448D6E1FCDC274CF3D3F3AF86FF677D3EE342F8911C7776ECD6ED18916455F958020ABA9F4F7F426BEF8F0B90DA4C2DE5888FF00717A67DBDABE838DB13CD56305B7733E17A2E86024DFDA67C3FF00B6925E5DFC52370F111656F6F1DAC5263196C6F7E7BE3711F857CFB22F972118C57D93FB6D68EBFD8BA44FC0924BC91549F4111623F515F1DDE2B2CC4B9F998027F115FA170CE2157CB6972E96563F3BE22A0A9E3AA35D7521A746CA240186E07B5376B152C0703834F89BCB94314DFC1F97F0E3F5AFA93E623F1093753C11D47CC39FC6A7D2A458B53B6679CDB2091774E137F9786C83EF513EF918B13BB1D48F5EE698BF781EE3A52DE2D1B27C934D7468F5BD3FE1EC7F132F8CD6DE368757D59CB0F22E83A4C5541DBF7B8C9000006719A7DFFECF3E21B594431A3B4CD1F9C22604617807F1F997F3AF288666B790CC8EC8E38050E08CF7AFA73E02FED292695A8DA7877C6B22DC5AB2AA5B6AACDB9A2C818590F71CFDEED8E735F2198BC7E029BAB84F7D2FB36B3F95B43EE72FA996E39AA58B8B8C9F54DFEA79FF00C37D735BF847E32BAD2EE618EDAE572CAB3C21831C0190723861C7A1AFB67E1AF8F93C5FA444F25BFD9AE36F2A07CADDC95F6FA74AE43E3BFC1DB6F1E78746ADA544926AD6D0931326312C64AB633DF81C5657C02D2759D27634AC2E34EB8405D58FEF21931923FDA5FD56BF35CDF1386CE309F5C4946A2D1A3F42CAF0F3C1A9619BE687D97D8F7C553E9C52E07D29CBE946DAFCCB9CF56E26290AD3F03D290F6F5A873D42E21FA52D1B4D18F5A3982E33DE9DB453BAFB5379F5A8F696189FC3472581A1A9DD2B27535013DFBD27F0D1BB18C8A6F3D2B375805CEE5CF4A31F8D147E959FB6D063589F4A29D8A4C7E7587B6650831EB494EFBB40FD68F6AC062E7BD2D3B6D3697B41E827005263A53FF95252F68171BC6719A4DB4FC5183C53E64319B7E6A3B0CD49B690C7C52E6023DB4952F1E949B7E6CD353D4AB91EDF6A4C549B4EEC51B2AF9F5111F7A29DB7D28E69F30EE3318E9494F22839A7CC5730CDA293069FB68DB54A43B8C6A36FBD3B6D1B4D1CC047B682B8C549494EFE6322283E94DFA8C54F4857AD0A4C08B1DA9ACBF954AD1FE5479676D57315722DBF9D376FB54FB69BB7DA8521F310B7D29B8C54FB69A53B62AB98BE622E3F1A63267B54DE5D37F0AD5487E87E78FED37E0F5F08FC5AD4D218CC76D7A16F231D07CFF7B1EDB81ADCFD92FE2443E0AF880DA55F3F9761AD85B7F309E239B77EED8FB1C95FF81035EDBFB64780935EF02C3E208212F7DA54986655C930B1F9B3EC0E0D7C4B6F3496D3A4D1B14911832B0EA083906BFA4F28A94F88B21F6151EB6E57F2D99F8766D4E793673F58A6AC9BE65FAA3F5631B8F3FCA9769AE47E1178C9BE207C3BD135C7E26B887F7CA0E7122B146FCD949FC6BB2032335FCF189A33C3569D19EF16D7DC7ED987C447114A3563B323DBED49B7E6A93F9D263F3AC398E9B919FA564F8A74383C47E1ED4B4C9C661BCB69216FA32E335B6CBC546C3E5F6AD6956953A91A91DD58524A51717D4F89BF64DF105C783BE2CEA5E19BA2563BF4920643C6D9A224AFE6378FC6BED2DB9C77AF8AFE3C5AB7C2AFDA1EC7C436CA5209A58B50DA9C67E6C483F43F9D7DA5657515F5AC1730B09209E3596375E8CACA1811EC41E3EB5F7BC57155DD0CC60B4AB157F547C7F0E49E1DD7C049FF000E5A7A324A6EDA9B6D26DF6AF81B9F6B744463ED4D6538A9CFA53319A7D47722DB9A42B52EDA6B0F7AABB2B9991EDCFB1A4DBED521068DB5571DC81949E29ACB56368EA2A365AA522F9889978EB4DDA6A6C6EE2936FAD5A657310320EDCD35978E78AB1B734D2BBB8155CCCB522BB0E9C530839AB0CB4D68FDAAB98AB95F14DA9BCBC533DEB452355A9118C7A531B8A9FA6298CB569949BEE7877C69F84373F107C416B3C2EB0410C1976C6771C9FE95F3178A3C1B79E13BFF0022E2264675CF20E00E83FA57E85797C62BCD7E2A7C318BC65A7CBE57CB363860067839C57E8D9271254C338E1AB7C07C367BC3343308CEBD25FBD7F89F0B4D11864DBD78AD2F0FC76F34CE97276A6DDC1FD0FB8F4FD6BD9BC55FB3ECFA6F866C355B7CCD3C883CD871CA9233FE3F95787CD6B3585C491BA3AEC62AC3DF3D3EB5FAC61730C3E3E9B74A5B1F8AE3B29C5E515A3F5886E57B8511CCEAA4328270734D652A4648E456B4FA0DC9D15F5291628208DFCB50E70D23770A3BE38CFD6B2315E953929ABC59E155A73A72F795AFA8E8E678240E848653C10715F58F84FE305B6A7E09B4792F231A8429870EEB1918FA9E457C98C78C56D68FAC4F67A7CD6F0CAD0348C32572091F9D78F9A65D4F1F18F3EE99F4BC3F9D56C9EACDC3692FF863ACF1C7C44D464D725921BB7B7858FC8BB8E31ED4555F0B6832EAB0DC34F14736D61B7CD04919CFA7E14561CB84A5EE34B43B672CC715275E337696BD4FD947D1FE5C62ABB68E076AEC1A01F8D47240AFD457E592C05BA9EA471D238FFEC818276E6B2B58D3563D3EE99D7E511B13F4C1CD77CD6AACB81C573DE34856CFC27AB4FD92DA463F829AE2AD879D385D1D30C73B58FC57BAD24F8A7E23C9A65847B4EA1AA1B78576F42F2ED18FCC7E55FAD9E10F00D8F827C31A6E85A7C7B2D6C215857D4E060B1F524E4D7E64FECE30C7AAFED31E09052364935E89C093A1C3EEF4EB5F6FFED97FB4C5A7C23D06E7C31A2CAC7C5F7D08DA40C0B5898906427B1EB8FCEBF45CFA8D7C4430D86A5D7FE01F3D9462A184A552BCB76FFA478BFED7DFB48192F2E7E1F7832E1A5B8693ECFA85E5A9CB163C182323B9270D8F4C5697C13FD98D3E10F832E7C77E2CB25BBD7D2DA4B88ACDC022C9366738EF27407D3A75AD0FD84FF6657B8893E26F8B2CDA49663BF4882E173D4926E483EA47CA4FFBDE95F587C54D360B8F07DCC170545A492C29732311B56232AEF27D82E4927A015E6637110CBA9C701867DB9A5D59EA6124F135BEB98AD65F657639AD37C2B05DF84ED2C64532DBC96490B2B0232A502E0F7C9AF8E3F68A5F0AFC13D063F007856D12F3C41A8798F712B9265812470E385380D955C03D02E7AD7AFF00C74FDB2B4DD16E9FC2BF0DE0FF0084A3C4B73FB88AF2D7F790C1213801401FBC6EDC103DFB5791E87F02754F0C5F5A6A7AD5EB78ABE2CEB170922F86A29124F262122348D732107CB21430247DDDC073D2965F85A945BC4621B516EE977F5EC8DF1B982C53F674BD1CBB2EA9799C66B9FB2BDFF84FC3BA7DEF89B505BBF15EB52A5BD86830C9995E462324B9E0E06727EE8E013EBEC1A57EC87756F7DA4EB3A9BE9F25FC012596D2D63F2ADE2F2D570AA3A396DB8666C0E4E074AEF7C2BF0CFC4FE22F8ABA7CBE267B583C476701D5351BDB6945C7901D8C76F6D12B4616351FBC6FE3CECC9CD7BBC9F0E6CEE94FDBA6BCD43272C2E276D8C7FDC5C2E3DB14B159C568A4A33D5EF6EDE45E130984A7792876B5FCBAFA9F367C2DBCD5BC50DE26D3B5AD066B7B6133DBD9ADAB893CB42A47C8C46100CB10C4E3E6C2838AF1A97F63FD6AE3E275CC7169D25AF87A4791E19966DEA984C852E79C64AAEEC73C919C57E855AF876DF4FB7486D6DD2DA051848E14DAA063A003FCF35E17F1C3F680B4F03EA1FF00088F84AD4F897C7D764470E9F002EB6EC41C34B8EE3FBBE9D4E2B0C2E3F132AAFEAB1DD59F9799D98D8E16B4212C53BF2EDE7E47C57FB44FC129FE14DC69934B736205E411A9B5818890C810798DB3A05DD9E7B8AF1E58E6DDB8C6C70371C29271D73E95F71787FF00643F89FE22D66F7C45E2AF12E8DFDA9A844629FED565FDA125B291CA283855E38C2D784FC4EF82BE25F841E3DB6D0E2BD33596AB2F976D72A6387ED0B801D82FCC234CB91C93D335F6F83CCA9D961EA4D4A68F87C5E0253A8EB429B8C5BB58F209F459F4DFB1CF768F0DADDA79B1498CEE5E9D3D7835EF76FF00B4559DBF84ECBC33A3F86E14D2A18956EF51D4A037394C72420607192700B7038ED5E97F0E7F650D3BC41A0F86EE7577BEFED3D3AE4B5D40AE66B7955646CA0DF845070082BC63B5627C7AFD967C5FE22F115A5CF87F4AB7163E588E2D3E0902A59A293D73F2E5B706241CF5E3A57355CCF0589AAA8D57A2F923D4A381C665F4A53A0AFCD6D3A907C3F9BC2BF199B51B3F1078AB58F105E58C04D9E9B74E6CECA418206C86360CC73B78C827BD79BFC56F8376163E359F40F0A595DADD5AC11B4D0CCC6432CF23A0F2D4E3680BE6A2F5EB9E6BEC7F863FB34E83F0DEE34BD4AC8345AB41024773246309336C2AD90795C939FF00808F535E913F8474C9B5017D25942D79851E71405B0183019FA807F015F333CEA387C43787BB8F6E9F71F4D2CA638CA115884B9FAB57D7E67C91A1FECD57BE0DD27C21ABB5B5A9D5630D16A9673106278DF7139E7748FF003281B7A6D18C72693E2F7C44D57E1EF85F4BB5F0AE87F631641AD1AEBC98EEA1B5CE088F702DB64CF1861C7BD7D87369715C346648D5FCB6DC9B86769C6323DF19FCEB3EDFC1FA5D92DE2C3A7DBA2DE4DF689D76022493FBC41EFC0AE08E712954552BAE6B743D2FECF853A2E9615F237D7EEFCCFCDBD7FC41E2BD67C07234F3CB756124E65B9FB3C3F6611487EEC6CA368619F99540C0E71DC0E3F45D7F54F06EB892B6D95F2AD2DB5C6248E552385653904E0F7E95FA6BE34B1F0C49672681AADBC2CBAA26CFB3ADBB387E7393B54804373CD7C55F15AD6DFC53E2C83C27E18F082DBEA3728ACF7D716A639AE084001419C2AF07E6E339E7A66BEB72ECD238B8CA12A768F5EDEBE67C8E6196D5C338D78567296897767BBFECE5E1F83C45A95E78E3EC9169175710A5B3585899238FEEA637C678CE002A4718735F416C23822B82FD9F7C1F77E13F857A1DB6A0261A8BDBAC93ADC03BD09E429C924000818CF18AF47F24F7AFCFB30ACAAE26767A6DF71FA1E17F7742317BDAEFD5EE55D829769CD59F2877E28DA2BCCB9D5CE57F2CF4A5DB8A9F6E7DA9BB7DF8ACDB0E6232BDAB1750F16699A65F259CF771C770DC796CE01FC077ADD958451BB1FE104F1D6BE1FF008FDF15A09BC7C5FEC715CDB59CDE5BCD0EF8E55EC5436EC1239E833915EA65F81963EA38456C7357C5D2C243DA567A1F6AD9EA10DF26E88871EC7DAACE381C715F2DFC31FDA2349F0FC1A87F6D5E2882DE156593A19170BB481EB861FAD6FF00C3BFDAAECFC7FE388F4C8ECA6B3B59B22DDE4009968AD9462E9B9CB934468B15859CE31A7515E5B6A7D0D4BB6955B728F4FA52F1D335E03B5EC6B71169541E69540F5A7564C4EC37EEF6A70A556A3D3B566C91768A31EB4B49D6A02E2D385271F5A55C541370346296978E6A4917149B471819CD1B87AD6578A6D756BED06EE0D0EF21B0D4D97F737171119110E7D075E3D6A60B9E4A37B12E56573CEE7FDA3BC2D6FE367F0DB3DC4974B73F64F39500884801C82C48C743CFB7BD7AA2DDC6EAA432E586E1F43CFF00857C99F143E10EA7E2BF1E584F13476DA8C16B6F7571A8DC5B036B7926E40F201BB80BBF24771EF5D7785FE34E89F117C463C3363AA5CE8FAEC51FD8A1BB8A026290E412CAA48C8E0819C75AFA5C4E574DD2855C2F457975B1C94ABCB99C71168EBEEF9A3E89DDF2FB551BED62CF4C7B749E78E26B86D916E60BBDBD064F3C73F4AF24F891A978C35AF1141E0DD3AC2F34CD25955DF5EB597E63B54F078C019EC0E78EB8CD7A347E07D323D1B4D8AF54EAB3E9A3CC8AEEF0F992EFE0B393D89FD335E154C2C68C632AB2D65D16A75466A4DD892EBC65670F8A21D08C77325DC90F9E5A2B7778D172546E900DA338EE78C7BD6F85F7C1EF5C3DAEAFA1C37CBABCB25A5C5D4D3C96B04B07CE7E62B84E09E7807D2B7BC2F67ADC3F6B7D665B79247998C42D989511E7E51C80735CF5E0A2935A5BF1F435768EE6DEDEC0668DBD2A5E2A86B9AB45A168F79A8CC8EF0DAC4D2BAA292C428CF03DEB8A2A53928C77664E492BB2D6DF4E69AC2BC9BE17FED1DA2FC50F1049A45BD85E69B742332A0BA0B8651CE783C6460FF5AF585B88E49362BA96C740735AE230F5F0B3E4AD1B3142A46A479A0EE8728C7346DDDDAB87F88DF16747F87B62AF712FDAAEE46658ED6120B654027763A000F24FFF005ABA1F08EB936BFA2DB5F4B6E6DDE65DDE56776DE7A123AFD6A2746B429AAB28DA2CD13E64DA7B1AE50E73D28D9530C639A302B87998B98836F35F3DFEDBB1B7FC29E81D46426AB031FA6D7FFEB57D11B735E15FB675B097E05EA4E549315DDBBAF3D3F78013F9135ED64553FE1468FAFE679999EB839FA1EC1A1C82E346B0907224B78DFF003506A2F10E870788349BAB19C1093A18C95EB83599F0AAF0DF7C35F0A5C39DCF26996CC4FA9312D7578E6BCAAF37471134B74DFE67A94EA689AEC50B6B258D0291D3A7E58AB0B18E3B54BD28651D735C6EADDB65F33647B4D7C41FB40785EE7C55F167C6B2C51EE6B7B48E2518249C240DFD5BA7A1AFB871F957946A7E0EF3BC59AEEA4543F98C4ECC0C901221FD0D7D470F662B2FAF3ADE56FC4E3C460E18EB53A8F4479C7C05D0F4DF1478674E9E3B2365AC69245A5C5ACBD07CC1B8F58DF0587A12E3BE6BE89D234FFECDD3E2B704954185DDD40ED5C7F84FC1F1693A90BBB6DAA586C75518DF19C609FA1C1FA8F5E6BD0F01540CE6B9339C77D66BCA717A3D5791D74E9FB0A51A5BD8F9A3F6A8D3E7D7BC59E03D0E0B76B87B896EA72A0640CC61067D0038FCEBE42F8A9E0BB9F00F89869F740991A259727A1C965E3FEF9AFD12D6F435D53E3269174FFEAECF4A988E9F33348063F5FD2BE44FDB8A158BE2F59A2EDD834A8B0ABD5479929E7F1AFD3384B346EAD1C0C76506DFADCF86E22C243EAB3AF25EF392FBB63C123B166D39E6218E3E60179C73825BD3FC4D54CFCC3EB5E929E159E1F8676452131C97E65BE9A40B9FF478F80CDE833DBB96F6AE1BC33629AAF88F4AB2958AC57175144CCBD833853F8D7EA74F13094673BE913E06B60DD39D287F325F89DFE8DF0DAEAD7E196A9E2AD42D76DAAEC16AC7397DD95618F4C9073ED5E663E55CD7DBBFB56DA7FC221F0374ED12C5112369A34999463E45C9C0F4C9C7E46BE22AF1321CC2799D19E2A5D64D2F4563D7CF30B4B05529E1E9AD96FDDB0A9ADD44922464F0CE3DB0738CD4353C5097577C70AB9C9FE75F495367E67CE4374DF43ECFFD9CFE24DE785EE22F01F8AA7C311FE8134C725738FDD163EE783F857D1BA4E876FA4C4E96E8173C9C0C735F0AF8474DD7BE23786EC2736CF31D260957ED719F9A4450A6304FF7802467FC2BED0F851AC5CEB3E06D2EE2F1CCB71E4A8694F57C773EFC57F39F15E0E186A8EB52766DFBC9747DFE67EED95D59CB0EB7E5D1ABF55E675DD3B52F348C46ECE69DB86DEBCD7E6DED0F586D04739C529C53722B275842FAD21FBA29DC74A6B718CD2F6A01E949B4D2EEF9BD697B62A5D5B8C66DCB75A39CE314EFF3D29FC562E6EE3B90E3E61CD2FF003CD3F0377B501467D6A3982E3152942FAD3F6814BC540AE45B0E69366E3C7153645270281DC8FCB3D290A15C9A9B8A323B1CD505C83611F5A367B54FC5369587723E318C51B69FC53B68E28B05C842F5A5E3D78A7F14328A2C3E621A3EB532A8EF415DDD4D3D47CC4581B69306A6F2FDE9BB451AA0E623FA0CD253D8F23D293753B8730CC73405A771EB47E354A455C695A4DB4FA4C8A7CC31B49B4D3B8A5DD56A4323DB415E29FC7AD1DA9F30EE338F4A0D3A9314EE17108C5376D3E969F30EE47B4526DA7E050D55761CC336D26D14FA69C7AD3B9571368A66DDDED4FE31D6933BAAAE172365A66D3533526D15772EE63F893458FC41A0DFE99363CABB81E06CF4E54AE7F5AFCC3F17F866F3C1BE25D4B45BF4F2EE6CA768581EF83C30F661C8F622BF544819F5AF8CFF006DAF04CB67E22D33C4D144BF66BB8C5B4CEA39F3173B73FF0001FF00D06BF56E01CD3EAF8C960E6FDDA8BF147C271760562308ABA5AC3F266B7EC43E3991D75AF09DC4B945FF004EB45FEEE7E5957FF4038F63EF5F57FD46057E69FC19F184DE05F899A0EA91B84885CAC571BB80627215F3F4049FC2BF4BF6E3209E9C74FCEB9B8EF01F54CC56223A2A9AFCF67FE66BC238EFAC60BD94B783B7C86ED146DEF527149C57E6D767DD73116D149B7B76A936FCB498F7AA522AE7CCBFB6C7829B52F0AE97E228172FA7CA60971FF3CE4C73F8328FFBEABB8FD967C50FE27F837A48964DF71A73BD9393E88729FF008EB28FC2BACF8CDE1F5F127C32F1158B26F2D66EEBDFE651B87EB5F3D7EC39E28116A1E21F0E48E732469791213FDD3B5FF9A9FC2BF4AA329661C33383D5D1927F267C5D76B079E53A8B6AB1B3F547D6B8E2971F9D3F68A42BDC57E73767DB5C8F6E690AD49B7AFA52639AAE62AE47B69A63CF152ED1D73CD1819CF7ABB97721E3D28DBED526DA4C75AAB8EE45B76D3196A7DBC530AEECD3D008F67B531BE953377E29BB6AAE590F34A578A795A39C51765731015A465EB52B29F4A632D697344C85901EB5115E73561945336E723A8AD532E322061ED4C6FA54ED519EB8AD53344EE438DBD6A3641D854E57775A6EDAD62CD53B14AE2DE39A031BAA9423EE915E1DF11757F877E12D41FCFD2BFB47517F9BC8B78F8CE3A9246057AAFC42D465D2BC37772C49248FB090B1900F4EE7B0AF896C6CF52F15F8DADAD4BB35CDDB90D264B1C609EA79E0715FA170DE07EB119E22A546A11E89D8F8CE24CC9E0E14E852A6A539ED757B143E207890F89B586B85B73656DFF2CADF764203D4E3B1AE5BD7D6BEA0BCFD97565934922E4E1A426E78EC141E3F1CD79A7C71F86161F0DDB4CFB34E5A79F77991B0E9800EE1F8E47E02BF4BC067382AF38E1A83D4FC9336E1DCCA9C6A6371295BAEBF91E5AAAD1E1CA657A7CD9ABB1DF416D73BE2B71854236BF3F311827F3E6AA4D7125C302E78CE702A2FA735F49CB7DCF8B53E4D228D2D2AEB544597EC535C46848DCB13B0E7DF14532D7569EDE155B6DB0638731BB2EE3EA4668AE5941C9DECBEE3D0A756318A8F3B3F7F3ECA075351B598EED5695874CD26D535F0F2A3092B9EA29B28BDB6DE82B8CF8B43ECFF000E3C46E39C584C7FF1C35E83B43579D7ED01A95B683F07FC577D72E23861D3A62CC7A7DC23F3CFF3AF1730C3DA84F977E86B0AAD1F887A4EBBA8787358B6D534BBB9B4FD46D6512C1756EE524898742A47435F4B7ECCBF047C4DFB59FC519FC5DE35B8BABEF0FD9CAB25FDFDC103ED520C6DB78F1C741CE380BF519F0AF849F0DEFF00E2F7C48D0BC25A71F2EE353B91134CDCAC283991CFFBAA09FC2BF6D3E1FF00C3BD1BE19F8434CF0DE85682D74EB0856240A002E7F89DBD598FCC6BF42C7E23EAB422E2BDF6BEE3C6C253E67CD37A2D6DE626A13699E12D065B9B97874DD2F4F83E776C2C50C6ABC0F6000E057C0BF18FF694F197ED3BAF5E7C3BF845A3DC5C68D704C1737FB007B98F3862598E228CFA9E48F4E95DFF00FC14B3E21DDE97E13F0FF82B4F9D925D66E0C9711A3619E34C00A7FD92C7FF001DC57B4FC27F08F837F650F80F6573AABDB68C91DA25CEABA84B8124F3B283C9EAC4125428F4C0F5AF8DC2D18C693C6D58F33E6B4579ADDFDE7AF3AB2A8DC2F65D7FC8F1AF04FECD3E17FD947C2275CD66E27F1278D6F82DADADAD9B18CCF70E38820C00FB49FBC4900A83B8015EDBF077E108F01D8DDEBFADC76B2F8A752456BB7B78C2C16710E52DA003858D727D37364E2BE2BBCFDB53C5DE32F8F4FE22F0CF82A2F14A5A45259E87A64F6F34CD6CAC46E9C2467FD6B600279C025462BBDBAD07F6B3FDA0A4923D4AE53C07A15C6E492DA32B68150F55217333601E8ED8AE8AF86A9563CF89AAA3292D9BD52ED60A5888C55A946E7D1FE07F15786747D2F59F14EB7AE69BA69D62FA59D65BAB948F1027EEA203711C614B0FF7CFAD717E34FDB9BE0EF8559E2B7D6AE7C4772B9FDD68F68D20DC0F4DF26C4FC89AE2FC13FF0004CBF0DDAC90CBE2DF15EA5AF3460036B6404110F552C77311F42B5EF5E07FD947E15FC3C68DF47F07581B88C645CDD83752E7D9A42D8FC2B85D3C045D9294EC92ECB4FC4E9588C44969EEFE27CCADF17BE377ED35A80D3FE1EF87A5F02F86662564D76F81DE13B91215FBDFECC609F7EF5E95F097F639D3BE17DADECCDAD6A3A8EB37CA56E75284882560DCB2AC832EA33C9C38CF7CD7D46B671431AC71C4A88A301557000F4A1601C6060FAD70E26B559C7D961FF771F2DFEFDCDA94B965CF3F79F9FE87CFEFFB3C6856E91AADA5B5DAA20897FB46233FC9DC125B04FD45743A47C31D1744BD82E60D36CCCD026D8A4FB244248F8C615828238AF5B92DBCCE49C9EB9350B69F130C18D49EB9AF06A53C53BDA6D9EB471CAD668E31AD8FA60D4525A7B575771A42B36145576D1DD4E02E47AD797255E17BC6E76C3190DCE61AD07A7BF4A8DACC7715D2B68EFF00DDA824D2DFB0E6B2F6D28EE8E98E2D3EA73ED678E314D6B315B6DA7B29E54D4525AB01F76A9629753A2388F33CF754D1FC4B7BE22F96F34F87C3C21C18D6367B93270436E276803938C73C57E787C73D76EF44F8BDAE848DAC750D3E5611DC5F96B89EE1485DBBB76540DA7E500600AFD4B92D5B006DE9EBDABC73C6DFB26F807C73AC5E6ADA8E9D37F695E4FE65CDCC73BEF7FBDF2F5C01C8E98E82BE9B27CE68612B3956DAD6D17FC31E4E654AB62A9C63465669DF53CB3F62EF895E25F1EF86EE34ED62D5AE74FD310476FAA64659811FBB6E793820E7D8F7AFA59AD7D064D60F80BE14F873E0EE95A8C3A15AC967633389DE2CB3E36201C6724F4CFBE6B83F167ED6BF0F7C26A897975746ED988FB225B912A800105C1FB80E78CF358E23FE14F133A982836AFB23D3A15FEAD422B113D56ECF566831D067150DC325AC6D2CCE9146BD5E46DAA3EA4D7C75F15BF6CEBE9B51F37C133FD974D921910DC5EA296DC3014C69923AF3F303D6B808FE297C48F88DA5C126AC351D6345F3BF7D1441618EECB38291F0064E54F0BC000E6BD2A790625C6352B3515DBA93FDAF4653F674FDE7E47DE36BE20D2AFEF05B5B6A36F713B217D914818ED0704E07B83FAD79C7ED09F152FBE16F8692EF4F851EE646C2BCAA4A0C73CE2BCBBE0FDE782B74DA32F872F64D48B87BB863475961752B8D855B91BB9E393B8F2457D3B269763E28D262FED0D2CF92C38B7BD41B978C61873CD79B52953C16222E716E2BB9EAB94A54AF1766D7AD8F9A7C01FB64E97ADDA8B5F1858C9A586011B50B55668B9EA48C647E19AF9FBF684F88DA57C40D540F0EE856D61A4D8B7971DD42A3CD99724296C7DD538C81EFCD7D41FB44FECE77BE39B084F8660B2B5102906DC288CFD4719CD7C25E28F0D5FF008375EBDD1AF46DB9B590C52AF38CFD383FA57DEE4747035E6F13434976BEC7C0E7B88C5D3A6B0F515E2FA94E05B8D5EEEDEDE04696672B1AC69924918007F2FCABEF4F823F01F48F0A78674CD63C43B4EA96E825124A5556DC724FB1EA7926BE16F0FDE5FE8D7D2C9636EC751456443B09784FF1301EA0647FF5EBBBF84FE0BF167C5CD725D322D4EE9ED9897BBF3EE982B7721BB9CF6EB5EA67187957A5CBED3920B7EECE1C8F131C3D4F769F35496DD91F696B5FB51781749D62DF48B1BE935BBD99FCA1FD9F1EF8918F00348481FF007CEEAF53D13525D5F4D8AE957689067BF1F9815F397837C1FF000BF4B92E34FBB78B47BFD1E55792E2E82C79646DC4866196EFD0F3E95EC70FC5EF02D8E9D0CC9E21B04B5650CADE728C03EAB9CD7E558EC2C1251C2C24EDD5A3F50A329460D5671E6BF43B81F2E49C0FAD547D52DD2658CB805BEEF39FF3D0D78C7C5CFDACBC27F0FF004E58F4A9A2F106AD3A931436F2831C7EF2367F415F29F8C3F693D5F58F11C1A87874DD6876E00796D9EE0CE1A53F78AEECED5F615B60B87B178C873B8D91C15F38C0E167C952577D91FA40A4328228606B9FF87FA95D6ADE11D2AEAF21F2279ADA3919739232A0F3EF5D11C6E00FA74AF98A909426E2FA1EBCA493128A7ED1E9DB34EF2C7A573B9585CC88F6FBD2A8F6A916314EDB8ACAE2B8C93DA8DA295BE6E9460D652649CCF8FBC77A5FC39F0D5D6B7ABCAC96D0FCAB1C78324AE7A46A3BB13F9578CA7ED95A0EA1A9DB5969FA1EA2F2C936C95E6F2C08C7AE431C93CF191D3BD7BAF89BC2BA4F8BF4B974DD6AC21D42CA45C34328E31EDDC1FA57957893F660F0C4DA7E990E977136856DA6C9F6825656732104105D99BE50A158038E33ED5EFE5F2CB5C397169B977E879D59E25545ECEDCBA6E717AB7ED01E10BCD77C3FA85DF88751B2B4DF731CF622D1C2046DC509206EDD954C718F5C735836FA57C3BF04473F8E741B89EF2EA149AEAD9250C623260825805C80BC7248E4919E09136B3F0E7C37F1535ABC897549E6D674EB15B582C74D31617FBD3B36DDB8C907208DDD075A9F4CF837E15B1FEDEF002F8B04B359DBA5D46CD261E02C83CD0C01098E0B15392030F424FD4C6383A305184A4BF9974B5FD3CCC1BC44AA3E7A69DBE177EA74B6BFB55E8725E683A4DF4325B1B8D8D3EA13111C4A707242F24A91900FBD7ABF8FA1D67C45A2C16FA0DE431432330BEDCF87F2590E42F0707247A76ED9AF8FA4FD95758D63C6766744B66BCF0EC84B1BEF3479780C791C8E38038CF4CD7AA788352F1668963A85EDFDF47E0ED2ADF646B6B1CD89EE0EC1F3EE93696CB6460FF09E84F15C38ACB706AB53780A8AF6D53D7D341E1F155EA46A3C4C2D6DADF89A3E09F889E01F8196F0695757F235FDD48F25C886369047216DA0B9C0C6027EB5F44E8FA95B6B1A7C17D6C4B4132074661838ED5F9D9E14D67C4BE30D536E9F6B6FABEA50CD24A971796E924D3040AC42BB7DF217F8703EF0E3E635F66E8FF1734BF0C43A4E85E26BBB4B3F10CEC218B4FB53E6B919014B2A0C296FBD838E0F415C19F6553A2E12A7794DDF9BAFFC322B098C8E222DBD174E9A1EA1232C6ACCDC05193FCEB3358F12691A1C2ADA9DF5BDAC321083ED0EAA1B3D0609E6A7D493EDDA5DE411CAB1C9242D187FEE12A403FE7D2BE15F86FF001BAD25F16DCE97E25D160D5EE3509CDADC5C5D10B0AC7B88DE171C1FF39AF072DCAEA63A9D4AB17A4374B7773A2A6269539C694DEB2D8F55F8ADAA7847FE13AD4F41B4B76D3B57D66152DAB7D9924B7C00083F27CF8E31B8818C9EBD6AAF83A63F007549750F1278DEC6F347752BF61B59D9F636782B0F24679CE06063AD33F6ABF0E9D63C309269D136956DA1AF99F6A08B147768DE5A2AA303962A5FD8753CF6F96E6F05DE6BC2D6E747BB8F5026026412CCB148B22AEE9170EDD793F53DB919FD132DC0D2CC7071F6952D17A34D5DDD6DAF43C1C663AB60EA7B3A74AED6D67BA7E5D4E9B5AD71F5AF8CDA86A7E02BFD43ECB713B5CAC8C5D9D973BDF72F565DDCE0F6AFBB7E11D9DD68BE10B687568A2B5BD9E579244D85097C9C920B107EAA4AFA57C1FF000BB56B2F82DE3E17DE2FD16FBED91262158D8009BD0F27FBDC15EE3A9CF6AF6AD5355BFF008D7E2F68F49D6EF06850C9E7A4AD2321B6675000381F2A7F08E7D0F39CD4F11605E2792845F2D382BF3BEA464B597B39393BCA4F58DF63EC6186C10723DBF3A7566F866CDF4FD0EC2D5E5133430AC664DDBB760019CD6AEDF6AFC4252519389F57B3B11EDAF20FDABADD66F813E27CAEEDA91BE31D31229CD7B174AF33FDA49377C0FF00190C67FD049FD457A1955471CC685BF997E87063B5C3545E4C3F677BA6BDF827E0D95F961A7A47FF007C6547E8B5E8DB7BE6BCA7F654B8FB57C07F0A1231B22923FF00BE65715EB5819C76ACF357C98FAF1ED27F99BE1A5CD4212EE910EDF6A6B21AB3B476A4DBD2BC8E65B1D5CC41B7E5AAB258C534A2465058020F1D73D7F95686D1E94DF2F049A15471D8A52B14E1B58ADD42A28500629FB71EF565907A547B71DB8AC9D472D4AE6B947FB360FB77DACAAFDA36797BF1FC39CE33F5AF827F6DC8447F193CC0A416B18416CF5E3A63F1FD6BF40993BF6AF94FF6BEF0347AB789BC357E6DF7C7224CB3C807CCA1400BFF00A10FC457DF705E3A387CD14AA6CE2D7E07879CE1A78CC2FB386AEE8F39F1068D7DA6FECB3A6EA51C389B537B7D3C1C7EF3C852F2607D5B713EC2BE75B5F334ED52176CA490CCA4E7AAB035FA65A2FC33B1D53C0BE0CD32E430B3D32DD66300E43CA61281B9E78DEE7F2AF873F6A6F0DDB785FE39788AD2CE210DB3F917088A3032F046ED8FF8116AFD3F86F3CA58FAD5F0695DBE695FE76B1F279E605D1A74ABDF6B2B1EE3FB6C788A1B8F00F84E38E61E6DF9FB414DDF7A3080E7F361FAFA57C6FDABE80F8E7AA3F8A3E1DFC2D9F61747D2D97CCCFF00CB45DA9B47BFCA73F41F8F87CBA5B45A67DA5810DB906DFF0078311FFA0D7BDC3746383CBD527DE5F7DD9E6676E589C573ADACBF22ABDBBA4853A9033C7D01FCEBDC3F679F82F07C5CD3AF4BDD2C22CE465997AB7CCAA633F43893F2AA9E24F869FD9F6DE14D4E087FD0752D2A2662DC1F39E26DC3F0E0FE35ECDFB127836FB478F57D52646169770A246CAD80DC9CFE58FD6BCFE20CE3D8E575311869DA4AD6FBF53D2CA72A952C645558DE3AFF009A3D67E12FC2E87E1ACDA8E9901325A3246C85C6776410C3D3A8FD6BBCD07455D1ED25B68C2A45E74924617A05662C07EBFA56B6D19CE39A50BD6BF99B199B57C6CE53A8F7B5FD51FA724A2928E8911B27E548576F5E454BCD057E5AF2DD41DD91EDA4D829FF00851B739A5ED122AE331ED495363DA99B2A3DA30E61B8CF6A36F1526D1415A5CEC398663A51B0D3F68A551D6A5C9DEE2B8CDA075E68A7851E94BB47A51CD20B91D342E4E338A9197A62976D1CCC7723DB49B6A4DBED4BB40ED9A7CCC2E47C1F6A31E94FDBED4BB31DA85361722FC28DB52EDF6A3653F68C5CC43B7DA96A4DBED4BB68F68C3988B6D18F6A7B2D1B4D3F681CC316976D3B6D078A3DA31F30CE949B453F6D376D6AA49943369F5A360A7F1EB49B68E64319B79A4DBFAD4B4954321F2CFAD1E59A9B6FB51B7DA985D95FCBA4DB9F6AB0CB4DD9ED40EE4457F0A5DA6A465DD415A0643CD254BB7E5CD26DDBF7A9DD8EE47FCA8A9768DB9A4C7B628B8F988FF0C52114F6F7A368AAE61DC66D14D2B8ED52EDF6A4DB55CE323D94857B5494873F855C657191514FDA2936D69CC5731162BC9FF698F04CFE36F84BAAC16885EEECCADEC4B8C96D9CB01FF012C3EB8AF5CD9ED51CD0AC90BA3AEE561B483DC1EA2BD1CBF192C162A9E223BC5A673E229C7114654A5B4958FC93C95EF939EBF4AFD28F80BE337F1F7C2BD13549E4325E2C5F66B8763CB489F296FA9E0FE35F01FC56F09CFE09F885AE6913C3E479372CD1AF628DCA11F8115EEFFB0FF8EA683C41AAF84277DD6D7501BCB607F865423701EC54E7FE01F5AFE81E30C2C735C9E38BA5AB85A5F27BFF005E47E47C3F5E5976672C34F6775F76C7D8FB78A4DBEF4F0B4BB7DABF9C399A3F67B91153D29AC98ED53914C65ABE61A655B8B64B985A29002AC0AB03DC1AF853E10C2FF0DFF6A6874A6388D750B8D38FFB4B20609FA9535F7A6DE2BE14FDA3B1E0CFDA461D5A0FDD1F32D6FB70E3E65DA0FF00E815FA47074DD6FAD605ED529BFBD1F23C451E4A74713D6134FE4FFA47DCFB7DA936D2DADC47796D15C4477452A07523B82011FCEA42B5F9DCAF16D3E87D7C67CC9344041FC282BD2A52BCE3B5232F34291A5C87069369F4E2A5DBDE9065863A55A915723FD69A454A5714DDBC55A63BB23653E94C03153532AE2CD1319EB4DDBED526DE283D6AF98AB9095EB4D619A98FDEA63505DC8581A6B54AD51D5A293226069AD5231A8F9AD93EE689AEA46C2A365E73DEA7A66D1E95A459A459037714D6A7B77A422B54CD53B98FE25D186B9A45C5931E255DB587E1FF00863A0786A48A6B7B28FED31722665CB027DEBB2651D7BD432615493D3AD7A14F155A10F654E568B2254A9D49294D5DA30BC5BE2AD37C19A24FAA6A732C36F0A9DB9EAED8E147B9AF857E287C40BDF88DE207D4EE808A204A41003911AFA1F535DB7ED15E3BB9F1578C27B3DCC34BD3F31C3083F79FBB9F7EA3F0AF1F58DA4B76933F2A9E33DC9EC2BF6EE19C96380A31C554FE24BF04CFC378BB3E9E32ABC0D1D29C5EBE6D1150CA7838CF7A7346F1AA175C071B97DC72323F23F954B3426386190F1E629C7E75F757D8FCCD45BBBEC451AEECFCD8A29B45161687F411BB146EAC6D03589F57B369A6B7481379113A4A1FCD418C3903EEE4FF000E6AF5E5FC1A6D9CB75733476F6F121792695B6A228049249E0003B9AFCBBDA697E87D83872BB32EACC6BE1BFF00829BFC5A9749F06E91E09B39BCB9B5597ED17614E33027DD5FA16C7FDF3F5AFADBC1BF12B42F1FE8973AB6877525D584133C26768248D59940E50B28DEBCF0471EF5F919FB5F7C5B8FE2FF00C6CD5F51B490CBA5D931B1B46231B950E0B01EED9FC315D585A33C563A9D19ED1F79FE9F8EA71629FB3A6FBB3DEBFE096FF0FC6A3E3AF1378CA687745A5DAAD95BB91FF2D25E5B1EE114FF00DF55FA57B82FD057CEDFB0AFC394F877FB39787F7A6CBED68BEAF7271839930231FF007E963E3D49AF63F1E78D2C3C05E11D575ED5261059D840D3C8CC707804E07A9F415DB9BE2AF5649740A34F920AE7E70FED99E38D2754FDB1B4183579F6685A0BD98BD62376C42E259303BFC84577BE0FF09F8B3F6FEF882DE28F14FDAF43F849A54CCB63611B14FB51070154F76E3E66ED9C0E79AF957C36FA67ED01FB464B7DE2FD5E2F0F68DAB5FCD7D7B7733E0C302EE711A77C901630064E48E2BF587E1BFC5AF8516BE0FB7B4F0AF89748B7D1349816258D65F28431AA29048601B2032E73EBD8D77430F3C360A8C796F34BEE6F77FE473D2E6A9CCFA5EE757E0CF87BE1DF87BA447A6F87346B3D22CE25DBB2DA1085BFDE3D58FB9269FA934B61AB5B089F9BC3E5ED61B86E009C819EC0366BE75F8BDFF0516F86DE019AF74EF0F49278BB5580300F67C5A6F1DBCEE8DCF75047BD7CA9E28FF828FF00C40F115FE953416961A5456575F681E4A312E30C36BE4FDDC3738E4D794F2AC4E29F35ADFD6BF81D70AF0A7ACDA47EA62C2238D01FA063C7E3D31F950CA79DDC81FC27D6BF14FC45FB4B78EB5EF1AFFC24971AFDDDC5FC32896095669122561C6563CED0BDF18AFA5FE12FFC142FC73AE5DD8E957DA5DA6AB7169A6CEEEA13649A84E80B46011C271E83923B039AE9AD93CE9D35352D4BA55A15E5CB07767E89B547B7E5AF21F0CFED41E19D52CF4283505B88B5AD42341243636EF35BC7290A5904B8C10A582EEE99C8EA315EABA5EA506A5A7A5CC72290C4AED56C9C838C71F435F3B568B84ACCED9539C3744E573D45276E9CD3E6DB0AA97609B8E067D4F6A46239C30DC393FD6B92DAD96E677D2E3047F85376E6A75CB76EF8FD29BB4773594A0BAB2EE56642588C7150496F5A1B07D69AD1E6B967421345AA9CBB19725AFA7350BD98F4CD6CF978C714DF2F39F96B867838BD99BC6BC91CFB58EE27B556B8B311AB3326E0A3D2BA6921F90B6CC903200EF81D2BE5CF881FB625EF82F5EBFB08BC0975AC9858460595DC720EAC0EE29BB0D90329D475E87358C72A9D69FB3A4FDE3AA9E22566FA23CE7E317ED51E26B7D7DF46F0269BF6DBB6568A288DB48D282ACC1A4752BD005E14118DC324F4AF9C356F876FE23F13EB09E2BF186993F8A2E6192E252B1C922A4C173B6470176633D006E98C0C73DAFC56F88D2EB1E2283C47AB5EE9BE18B7821377A7E93E1D7512F9C63F90CAC3055FE62A411CEC3DB06BE63BAF10EA579A85CDD3DF5C4F75747F7B34AE59DF9C72C793C715FA7E5396CE8D28FB35C8EDABEAFE67998EC6528CFF007D1E6F2E9B7AEE77F75E07D3743D3E5BCB6D5ACEE5A396316F69229792E9B715EB80141E0E09CE3B735F43FECE7677B1EB13F83B505B79DACB12CACB1388E059932C14E31B8160A0703E638E9CFC7D6BE1FD6758B89D638A69E54CC9282D9600024B30CE7A77AED7C37E201E0B104B7126EB6BE7499E5B5964DF6922B92AE0646E2A33F2927835DF9860E55E8FB1E7BC8ACB3308E1AB7B554F962D58FB5EE3E1E78A7C15E2EF126ABA058437F2A69114505D4D1AC4B713A92431CB74452073E9C7A57CC3E3CFDA2BE25F8E3C412E9F65A84F6AE3F722D74D3E5C6A4100B33039273DC1A81BF6A0F165A0D73484F13CBAE69B733BCA2F3507911A58C26D08067E55238D831C9AF046B8977391238DC7270C79FAD70E5593D584A53C5A8C9E96D0ACCB398D48423464ECF7B68CEE3C65AC78BFC27AAB59DD78B2FA6B9DA24716FA8C8E172011921B83CF4AE1AE2696F2779A795A69A43B9A4918B313EA49E698572C49396CE73DF3EB4B5F654A9469ADB5EBD0F8DAD5E5564F576F3771CB3CCB319848E25249326E3B8E7AF35674BD6750D16ED6EAC2F67B4B853912C321561F88AF4DF853A07816E3C2B7DA978BF4AD53549CDE8B7B6163ABA58AA284DCD9DD6F2EE2491E9800F5ABB7DA87C1EB6C85F01F8B38FF00A9A603FF00B675AB8464ACD1842A4E9B4E2F547973EB5A8EB57572D7DAACA5E726591AE1D9848C3B9AA2D752B2F941F2B9C0C81CD7A1DCF8BBE0FDB6437C3EF15B8FFB1A20FF00E43A658788BE15F8B1F50D2B4BF04789B4AD48E9D79736B7971E228678E2921B79255DD18B552C094C6030EB53ECA31D1235F6F396EDFDECF3F6B1B8854BB42E10705B07068B561F6C8B68690165F973C9E6A3B1B5D4FC41ABDA687A2D9CFAA6AB79208E0B380176763EDF4E493C01C9AF7FD2FF00613F1FAAE98DAA78BB41D0359BF66FB169B2CB249248E885D94150012AA093B73802BC7CC336CBF2D4A38DAAA0E5B2EB6EAECAEECBBDAC766170B5F113F69460E4935FF0D77D4F44F1D7ED59A87C34D2FF00B1B489ECB56D5AE2DE2955D4164D3C95CEC6F98EF6C63D00FD2BCEBE12F8A7E257C5EF1C2B1F10EA0D146C24B8984E634881271851853D31FF00EAAF29F891F0C3C61F037C4505AF8CF4B59629D89B6BE89FCCB6B8C10582B60738EAA4035D57817E236B3E10F86FE37D6B446B7B4BE8EEB4C48736B1CC88AF24A085570C32477C679AF9D9E17094F2FF006F8051A9ED1C5295F4BCA4A3BEBB37A9EEE273DAF4715EDB149AE569725EDD52573F4C74B86482C608E594CF22A85321032E71C9C018FCB8AB9B4D7E71DD7ED19F1E3C23A6C726B69AB6896470914B71A024117B282D1002B324FDAF3E2BB485878B1917EE853616E0E7FEFDD7E791E1CC7D6F7E12A6D77526FF00F6C3D2FF005B9545CD0A375FE3FF00ED4FD2FDBEB47E15F13FECA7FB417C40F889F19ADF43F117881B51D31AC6E26307D9A28FE75D9B4E5541EE7BF7AA7F11BE3B7C4BB1F8ADE21D0743D76E4C505FBDBDAD9C16B1C8F818C281B0926BB72DE12C4636B56A35AAA8BA7C9B272BF3F35BF97F959CB2E337CCA11C3ABFBCDDE76494793AF2BFE6EDD373EE5C0146DEF5F9D9E22FDA0BE33786E458F51D6B50D36471B916EF4E8E22C3DB746335C95FFED6BF1721FB9E30957FEDD20FFE22BDF7E1FCD3B4B1367FE0FF00ED8B8F17569C54E3878B4FAAA97FFDB0FD02F89F61E2CBE934A5F0E6A10E9B6B133CD793498F99540C0E4F19E79C1E719AC7F117C58F096B5A6EBFE1F5953549ADEDE48E585C621760B9DACD90319DB9E6BC5FE25FC46F145CFEC89E11F138D4D5F5ED4842B75713DBC7224BB8FCD98CA95E42FA57CAB63F147C7B73A835AE9F0D8DFDD61BF776BA05B48E540F9880B1671EB5E653E1D9A9D4A7CF17ECA4E37D637B59DDE8FBF73D9A79ED3AB87A539C1AF691BDB7B6AD5B757DBB1D0DDFC52D6348D46E0E9D670F859E63B6686C2264665C05218B3138382DF5EB557C43E20BAD3ED6D22B7D49750975185AE6F4C0E5886762194F1D48553C7AD51D37E2C78D7C40B736B6CD69A8496F0B4D2456FA1DB3848D3EF391E570A3B9E8335DC7ECD1E2ED4BC69F1560D3F5DB6D36FACCD9CD32C30E9D6D03EF528508911030E7D0D7DBFF000BDE9528E9BDA576FF00F255F99F3F52ADE12E5A92774ED7565A6EBE27BF5D0EB3E0BF8AFE26784F478134786C6C34CBEC2ADDEB0CC14EC463C12703807A71EA7A53F5AD37C5FF0010FC3BE27BED57C479B28671198E39038BD9986420DBB8228C10327D07AE34BE24FC57F14699AB6B1A65BEA891DA2DECD1C76FF6580AAA2B9000053D0015E7337C6AF1A59DBB4706B7E4C070C523B58154E0E41C04F503F2AF5EA643878D69CD544A57FF009F69EDFF00710F98C2F13E655F0D072C345C651FF9FD2D9ADB4A26EFC55FD9FF00C49E09874BFB36A693DC1D39AE6F6032AC6F6C1401C9CE5C12703A7403AF35E4FE0BF889ABF84FC43A6EA515D4928B39FCE58DB95C9382707B9F5EB5B1A9FC76F1C5F6F173E2279837CACB2410B67D01CA5757E03D253E217893C2975AAC42F2E96D1AE67758923431C73CE06E0A00396F2C74E83AD7753CBE9C70B38D6A9ED1ADFDC51BA6D2E939773A3078AC7E6199D0C3D0A6A9FB4928AB5473B3B5F674E3A69DCC5D43E3378F35FD4AF3535F11DE470CDB808D6E7688C67855008E7E61C8FEF0AE8BE19FC41F07DDC6D6BE28B4517923091F566B659A60FBB71CB16DC73B5707AF26BD2756F117C3C37D2DAEA10E9CF730398DD5EC892A4704642FB7E95E796FE17F86B67E2B9F534D416E6C0AFEEB4B92190C7139CE7248E5467E51DBF015CF4724A18DB61E2D524FAFC297A9F719B539E48BEB31C553C438E8E2A49CBFF01BBF9DB63BBF8BDF1D3C25E36B3D091AC1B53B4B5924597CF6D920C2380420E1812D9EBD57D2BE79F889E24B2F1378827D5749D35747B370B1A431E1000AA070A3A1C8CF5E735D4F8B3E0B4B71E56A9E1297EDBA35D12DE5CAFB5ADC64E4E5B194EBCF5F5F5AE7BC1BF0B354F185934F62CACE9308CC3D0F0064E7A67918ACD6434787E4A9547656D1B7EEB4F677DACFBF4EA7CF471D8BE22BC70B4AF25ABB2F7972EFA6FA762869BE2FB9B99ECADB5493EDD651B8C7DA54CBB011B4B28247451D3A715F5F4BF127E1DF8FB4CD3FC1F62353B0FB40823796CAD156572B85F2DC63E5033807A0E9D3AF9369FF00B3CDA4771A6DB6B974D15EF96A5A083CB5D8A4923CCC29C9393D4938AFD08FF8667F097862D748D43C29A643A7DF69F0469234792F731AC654E49CE7392C477233D6BE478F68D2C8E860B1188775594E54DC249C6D1E5D6EAE9AF7959ABA7BA76D4CB86B3DA58AC5E2304DBE7A6D29F345A6AF7B2E8D3D1DEFAAEA54D2F4F8B4CD3E0B78030863408A18E4E00C66AE556B9BC86C6D64B89DD6282252CF2370140AF27F117C60BABA91D348DB6D6E0E04CCA0BB7BF3C0AFC130397E27349CBD82D16EDEC8FD8E8E1E7886D40F5E6CB66BCF3F68651FF0A4FC679E9FD9CFFCC570F63F16F5DB29F7BDDC7771778E45047E639FD6B73E2678CAC7C67F027C6324388E78F4F6F3ADC9C94E473EE2BD8A79262F2EC6D0AB52CE1CD1D574D56E6599E06AE1F0B393D559EC43FB22BEFF00809E1CFF0067CE1FF919EBD8EB42EBC55A7F85FE13E912D87867463E65B24484DB80AAA23C0200F6FC2B8FD2EC4EB1E1ED0EE24BCBB8DFEC68C5A1971E61788025B8E48CE47BD7959DC283C5CF111ABA49B6FDDDAFAAEBA9E160B115A5414553D6364B5DED64FA68742A473DE8C8DC2B9896DBFB375ED1E25BEB893CE797293DC9F9B6C58E176FCDD33C918249F6AF33FDA035EB887C4DE17D19B597D0F4ABC907DAAF1338894BEDF3180EA17FAE69F0FE435388732A19751AAA3ED1397335B28F35F4EBF0E9B1CB98E731CB7075715569DDC1A8D93EAF96DADB4F88F71663D853770C57C9FA87857559AFE7B5D0FC5D25E5DC73B5AFF65EAE5AC2F4CCBC9894926191C8C3284932CA41AC1D3F5C692CEFAC754BEBED2B55B5908692595D64C83868990F208F4C66BF6AA5E08D7C44B96198C57AD37FFC99F9ED6F12A1878F34B06FE525FF00C89F676E0450CD5E157D683C1BF173C3B75E17F100D4FC17E21F2DACE3FB6996588320DF14F1B1DF1B6EDC5770CE3BE457D13158E93A1F86A7F1478A6EE5B4D0A3945B4105B8FF0048BFB83C2C510FAE727D8F202923F34CEB80B30CAB34A395D0A8AABA90E7E6B38A8A4ECF993BDACFCDFDE7DCE55C4D4332C2CF12E9B8B8CB96CBDE6DF4E5B5AF732325B3CE0561788BC2B67E22B8B092EA3127D958B856E8738247E82AE4DF1252EA42D65E1CD16C2D89F960B92F7129FF0079C639FCFEA6BA0F09DD68DF1124974CB185745F14C70B4D0D8F9C5EDEF957961131E55C0EDC7D08E474D5E04C7E160EB60B111A9512F86CE37FF0B7A3FC0F61E615F0DFBCC561DC21DEEA56FF00125AA32A385618911385500281D80ED5F03FEDCD691C1F182CE545C3CFA4C2CE7D4892400FE43F4AFBDA491B31C5126F9E56D91C6C76F38C9CFA000127E9EBC557D5FE16F876FA49B59D4347B2D6B5C8AD9922BCBDB6590A60121514E40193EE7D49AF4FC31C931D8CC64F306B9692BC5B7D65A5D25E5D76FBCF8AE34E20C26068470DF1D47EF59745DDBF3E87C91F097E1EC7F19BF673D1ACB3B2FB4ABEB88A2988FBB9F9C7D010C2B0FE2F7C0B7D0BE10CDE215091F956BA7CB2C63EF06002381F8CC7F2AFB63C71E09D2FC14B6506951980C9650DCC922C69039775C9C88D54771C62BC47E33EB097FF00047C5DA55C00248ED3CC89C003785915B040E8463B751F435FA066B90673945458DC2CD55C3B9A724AEA51527AB6BAABBDD3D3AAB5D9E2653C6997660FFB2F154BD9D7E5E54DB4D49A5B5F4B3F2B6BB5EE6CEB9F0DA3F1BFC3DF075BC60466D22B7978FEE88C647E35DEF847C2B69E13D1E0B0B44091A280401819C727F3AE475FF8A9A1FC29F857A46B3AA3B387B4863B5B48C8F36E5FCB042A83D80EAC7803F2AF977C49FB6878F354BE77D2C58E89699F9218E0133E3FDA77073F8015F9065DC33C43C554E70C2452A3193F7A4ECAF7D96EDBF45A1FA8E2B38C265B18C2ABF7ACB45AB3EEBA76D35F19FC3BFDB6B59B3BF8ADFC636306A360EC035E58C5E5CF103FC4573B5C0F4014FD7A57D83A56AB65AE6976BA9585CC777617512CD0DC4672AE846430FC2BE4388385F35E19AB1A59853B297C324EF17E8FBF93B3F23A7059AE1B1F172A32DB74F468B549F85636A3AE98DCC76E3A756358DA6F8D05F6E92DAE22BB891B6B6C39C1F4AD29F0BE3EA51F6AECBCB5FC74B23E56B71BE5D4AB3A718CA515F69256FCEE7654541A7DE45A85B8963FC57D2B8FF893F132D3C050A4091ADDEA932EE4809C2A2FF79BDBD077C5781472FC4D6C4FD4E10BD4EDFD74F33F42CB6F9BF27D4BDFE7DADFD696EB7D8EDF3D68AF9FA3F107C59F1458B6A7A35B34901C98D418608DB1FDDDFCB7EBF5AA9E03FDA72FEDFC45FD81E3AD1DF4B9C4BE4B5E0E3CA6E9FBC5C0E3DC0E3F5AF72A70DE2E319BA53854943E28C65792F958F771194D4A1CD18D48CE51DD45B6D7E16FC4FA3368A2A9EA9A941A4E9EF7731CC6A380A7EF1EC05793DC78FAEFC55A93D9D85D8322C822FB2DB3FCC189C007D79E2BEAF827C39CD78DB9AB509469508BB39CBABB5DA8A5AC9A5ABD925BB3F0FE32F10F2CE0DE5A55612AB5A4AFC90E8AF64E4F68A6F45BB6F647B1B7B0A071DABCEFC41E17F17F81759B0B299A496EEF57740B68E640EDD0A600E581EA315D5689AD5D497B3E95ABDAB586AD6FF7E190609E33D3D71CFBD7BFC5BE12667C3581799E1ABC713422AF271BA9456DCCE2EF78A7BB4DDBAA4B53C4E17F15301C418DFECCC5E1E786ACDD9296B16ED751E6B2B49AD52695FA36F436E8E7D38A5C7A573FAF78DF4CF0EDE456B74ECD2BFDE1180767A66BF1DCB32BC7E7388FAAE5D45D5A966ED157765BBFEBAD96ECFD9AAD7A7423CF565646FF007E94B5C1FC4AD766B1D2B4BD434DB878BCC25D1D491B94852323FC6BC23E3378F358D523D1A46BC920DAB2295818A06208F9881DEBF4BCA7C35CC335CB6866AAAC614E72945A69F345C5C96DB3BF2F74D763C0C767B4B02E71716DAB7A3BDBAFCCFACB2280315F9FE7C55AA2E33A9DD0FF00B6CDFE35D4F877C35E3DF156C3A7C3A9185BA5C5C48D0C5FF7D3119FC335DD88F0D960E9FB5C4E3E308F7946CBF191E451E2A96225C9470CE4FB277FC91F6BD15F1378075ED563F891A05ACDA8DC36DD5618645F398A9FDE8561D791D6BE87F1178F6E6E2F248ED65305BA9C29438247A935DB9778439A66D982C1E0EBC5C1479A5369A51BBB256576DBB3B6CAC9EA7CD710789B9770E60962B174A4E72972C6116AEECAEDDDD924AEAFBBBB5A1EA5471EB5C8E8BE15F89BABE971DED8683AA5C59B2EE494C38DE3D54372C3E95069BE38B8B1D4DF4CD7AD64B2B98DB63F9D198DE36F46538C7E55BE6FE0A710E5F42A6230956962792EDC69C9F3D97F75C55DF926DF4499E5657E316498DAD4A8E36855C37B4B252A914A177FDE4DE9E6D25D5D8ED3753ABC97E366AB71A6DE69EB0DCBC68622C76360753CD7AA7C1FFD91FC43E2ED22DF58F17EB979A0DB5C28921D3AD8037250F20C8CD90991FC3827D7078AECC8FC1F8E6D90E1F3DC4E651A31AC9B51F66E4F49356D24AFB5F6D0F4331F116AE1338AF9461700EABA56BCB9D456A93BEB176DFBEA4B4576BE28FD89EC67B073E1DF176AD657CAB941A8B2CF131F43B55587D467E86BE48F1669BE29F873E2DB8D0B5C6B8B2D4AD8E7E590957520ED911BF894F63EC41E4115EF60FC0DA798C26F0B9B45CA29BB3A4D3FFD2F6F357B1E5E3BC51C465B287D6B2D6A3276BAA89AFF00D277F5B5CFA0A8AF927C35E14F1778E23D62E343B3BAD4E1D2E13737AF1C807931FCC771C91D95BA7A552F0AE93E22F1C6BB6BA368515C6A5AA5D6EF26DA27019F6A9638C9038504FE15EC3FA3CC9735F368FBBBFEEB6EBAFEF343C65E333972DB2D97BDB7EF37E9A7B9AEA7D87B4534819AF9ABFE14E78ED7E1FEBFE3195160D2743BD6D3EFA392E809E3955D51C04EE159D41E7E99AF51FD9AE19B59F07DDFDA2E36C50DE4AF2DC4CC4AC31AC71924FB73D07527D4D7C271778433E18CAE59950C7AAED4E30E550E5D65E7CF2DB4E87D870DF88AF3FCC6397D5C13A3CD1724DCAFA2F2E55B9E84ABBBB50C953CFE328ACD8C7A3DB476D12F4B9B88D649DFDCEEC84FA28E3D4D59D13C47AEF89355B7D3A048757B89C954B7B986320E0124EEC02A0004E4118C57E5B4F86AA4D28BABEFBE895D5FD6E9FDC9F95CFD9251AD18BA928A515AEAEDA7DD6FC4CEA3656E6B5A3ADBB5CB47035A5C5AB2ADDD933893C9DDF75D5BF8E36ECDDBA1EC4E05DDD43636B2DC5C3AC50C6A59DDBA015F378BC0E23055DE1EB47DEFCFD3FABDF47A8A9D4555271FEBFAFC77449B4D260D79D5C7C558E692E1E1516F650AB3B48D82DB40C93E9D8F1FAD313E255F59E8363A85E5BAACB3462592DD8FDD07903381838C67DEBEA29F07E6D2C2FD739528DED66F5BDAF6EDEBAE9757DCD9E9895837FC4E5E6B7657B6BD15DDEDDECFB33D1C8E692B33C2BE25B2F1769297F62C4C7B8A3A37DE8DC004A9FCC1FA115B1B2BE3EA29D1A8E9545692DD03BC5D9916DA6EDCB63391526DF6AC8875B76F3FCDB42628E79220F0B82D8538FBA71FCEBDFC9722CCF88AAD4A195D2F69384799A4D5ED74B4BB57D5AD16A78B9A67580C969C2B6615392327CA9BBDAF66F5B6DA27ABD0D4C0A4DA3EB556D753B3BC7D915C2F9BFF003C9FE47CFA053827F0AB174EB670CB2CE7CB8E252CEC47DD03935C58CCBF1B97D6FAB62E8CA9CFF965169FDCCEEC3E3B0B8CA5EDF0F56338774D35F7A1DD3DE8DA6A33F695EBA5EADFF82D9FFF0088A82E2F9AD580934ED554919FF9065C1FE495EB2E19CF5ED81ABFF82E7FE479CF883285BE329FFE0C8FF996786A197D2B324F11DADBC6F24D06A30448373C92E9D70AAA0752494C01EE6B5B69F5AF331D96E3B2C7158EA13A5CDB73C5C6F6DED74AF6B9DF84CC7078F4DE0EB46A72EFCB252B5FBD9BB11AA7AF4A465009AEABC3FE1486F747BCD5750BC8AD2CEDD72AAF22A9639C6E393C283F89C1039AE0B53F18695A6F8E1ACDEE164F0F4C63856FE142BE5B7467DAE7A139EA7A608AFB9CA7C3DCF739C17D7B0F04A2D5D293B392F2D1AD7A5DABEFB1F2D9971AE5395E29612BCDB95ECECAE93F3D6FA75B2762FEDE7A714A56B5B49D2A5935AD36D351B1B8B233CD1ABDBDC00B20466039C138C83EBDEBDB3C55F0DFC11E11F0F6ADAD5EE9D76F67A6DB49753086E1D9CA22963B41232703D6BCCCA783F33CE2756952E58CA9CB964A4DA77F9267AF8DE21C1E0614EA4DB9466AE9AB5ADF368F9F592936D491FED1DF02656451A1F8A32E401F20EE7FEBAD7D1379F06FC269673BA58CEAEB133A9FB4B9C10A48AFA6C4785F9F6155EB382F9CBA7FDBA791478DB2BC43B53E67F25FE67CE1B70691978A9197078A7C24C33248A14B29C85750CA7EA0F06BF29A2A32A894E5CABBDAF6F91F7539CA316E2AEFB1F157EDC9E0A96D75ED17C530A335BDC43F649C81C2BA925327DC31FF00BE6BE7CF879E32B9F00F8DB48D7AD89DF6730765CFDE4E8CBF8A9AFD5AF8CFF0CB40F8F9F0F6EFC1971650F843C50C23961D4560736B1CAADBB32A293B14A63903E527278E2BF2AFC7FE07FF0084175EBAD3A3D52DB5C86DE7920FED2D3D24FB2CACACC0EC7655DDF77B71CF7AFEAFC86838E56B2FC4CD4EC9C6EBB5AF692DD357574F63F11CDABA9E33EB9462E3D75EFDD774EDA347EA0D85DC7A8585B5DC443457112CA84742ACA194FE5FCEACEDF6AF0CFD8EBC7773E32F857F60BD984D75A2CDF640D9F98C3B731E7D48E47D16BDE367181C57F3266B84796E36A6165F65FE07ECB80C52C5E1A159752BB29C526DA9B6F6A465C579AA6BB9E8DD10EDE40ED5F1B7EDD3A0B43E22F0F6AE13E49A07B766FF00694E47E86BECEDA3AD7CFBFB6BF87CEA5F0AE1D41065B4EBC476E3F85F29FCCAD7DA70862BD8671475D2575F7FFC13C3CF297D632FAB1ECAFF0071E89F03F5BFF8483E13785EF73B99AC638D8FFB48369FD56BBA65AF06FD8BFC409AC7C1F1A787067D2EF658593B857FDE29FCD9BFEF9AF7B6AF373BC3FD5732AF476B49FF009FE4756575BDBE0E94FC911B2D336FBD4C47AD348C578899EBA64349D2A4A6B0AD11633AD2638C76A77D692A93659163AD26D14F3F4A6B56A8A433D690F5148CDB7BFF00F5FB0A6EF0707231DB9FC7FC2AA317BD8BB8A579EB51B7D29EC4D35F02B58969A18D8A8DB1DBA578B7C73F897E28F85FAF69BA85A22DDE80CBB67B71092C1B9E4BE38FC0D5ED0FE38596BDE20B1874B68AEF4BB9B56BAB89DA4024B76084F9457391F30C138EF9E9CD7D1C723C54A847130578BFEACCE1FED0C3C6B3A127692B69EBDBB989E37FDA2EFBC29E2F9F478BC2975710C4554CD212A5893C900020AFA73D8D7B4D8DD0BCB482E363C7E6A2BF9726032E40383CF5AF07F157C71BCB3D5FCB97C21F6694068E2D5DB1347901B05485391CE71935E89F066FFC4FAB78416FFC51711CF777123345E5C46321338190147A57A99960151C1D3AAA92A6D68FDEBB9339B098A73C4CE1ED1CD7A5947FCCEE9BE5A67F0D656BDE2AD3FC373DA457D2BC46EA41145B6267CB1C0EC38EB5A22E2333791E62F9A17718F3F363A671E95F33ECE718A935A33E86324DD908C9F9D31BAD4ACA73D6A260775289AC5A1185417119921651C12B8A9E9BD41AD62F95DD1AA67C41F1BFC37258F8E2FC88CAA4E81D131D81C735E6D67A7BCD7020DAC3D15BD7AE2BEF5F19FC38D3FC5B796D753C6BE6C4DC923A8F4AF38F117C17D23C23677DAF8CDC4B6ECD71142C7E52D8E14FB57ECB96F13D17421424BDED8FC9F36E12AB5B133C55292E56EF6FCCF923588FECF7A60CE7CB0140F4EF8FCCD32E6F04F676D115C3C21813EA0F4ADBD0741B8F1678CA3B4646DD7371F395ED93938F4AEBBE3F7C2F4F877E29B692D0634CBF8B7A363EEC8301D7F320FE35F7AB194235A9E1A4FDE6AE7E60F2EC44F0F57174E3EE45D99E5B9A2B63C516496E9A6DE5B80D0DE5B893E8E0ED71FF007D034576AAD17A9E54F0F3849C6D73EF8D73F6B3BC8FC136BAD687E32F0EDCBCCE0DCE9D2DB3C335944E0308830EA57691BC8C1CF4E457C8D7DFB45F8D4CC4DA78B35C5732C8E77DF33A61DB2405C7EBD3DABCBFED937D9FC812B2C04826353852474240EA7DEA255C8C0190074AF3F0B96D2C2F325AA7E9B76D11DD88CCA75ED6563F507E04FED19F0FA0FD9FEE62B1D7AF7FB4749B369AFEDF508F74CB211D5768DA5723803A646715F9866E05D5F9B8B82CEAD2EF73DC82D926A1E470188E31F87A515A61F2FA787C555C5C1EB34935E97FF339B118A75D46EB63F41356FF008297E91E1DF0BE83A7F84BC2EF33436C6DE74BF62820D8A16329B73BB24027DB23AF35F2B7C65FDA9FC7FF001D2DED6D7C45A9A476102ECFB1D82986294E73975048638C0F4AF25A4AD6182A109B9A8EADDC8A98AA95172EC817E5E848FC6A7FB75C79221F3E4F2BFB9B8E3F2FC07E42A0A2BBB7DCE58C9A4D262636F4EDD29E90B33007E505B1B88EFF00FD6CD12491ED41186DD8F98915A575E203776688D6B1ADD29506E00C02AAA001B471D8738CD436FA22A2A3BB7A99CD0CB161CA15E7863DCFA7BD755E1BF88DAC786AFAE2FED63B492FE4271712C0A5D0B0652CA401CED76E3A743D40239CF9EF64024BC088AA5D5A5C85E067000CF7E2AB2AEE600B2A827966E40A528A9C7964690A93A32E683B33E81F0FFEDB1E3EF0FC9A95C2CB09D42687C9B596182254B51D88468DB38C13F78649C9C9E6BADF05FF00C144FC6FE1F5BF9754D3F4FD5EFE6911A09A4531C7075DE7CB18058F1CE4631EE6BE50CEEED47F2E78FAF5AE3FA8619EAE08EBFED2C57595FF00C8FD1DB8FF00829C7866E3C0334B2E81787C59E51F2ED6303ECE24070A4B9E718393C76C5787D8FF00C146FE26D96A97775058E932C770EAED14F14AFB117F85487C6393CE33F37B0AF94BF0A07CBD38358C32AC2539B9A85DB079857FB3A1F5AE81FB757C4DD0FC5907896EAE2DEF743D4A4319D36F648E40B1EE1B946CC32609C02473EFCD7DABA47EDA1F09B56D263BB975D7B299E13325ACD6B28926C641F28053BFE6046475AFC86D066B28EFD3FB4A4916C88C4DE546AEE547600918FC0D767F132FFC096BFD969E011A9DBC9F6763A8DD5DC846F77E7CB507076A83B493807D2B8F1596E1EAB8D270FB97E6764318DD37526D3B1FB43E0DF1768FE38D0AD757D1A7FB4D9DC2EE01B2AE3B7CCA7A1CE7AD6C34D13CBE489144DB77797B816C7D3FAD7E1F7C15F8C7ABFC12F1E59F89F4A5FB4CB00656B691CAA4CAC08C363B64838F6ADF9BF6AAF895378AE7F108F114D15EC8182AC606C40DC600C7F778C9FAF5AF1EAF0FCBDA5A93D0D638CA164E5757F99FB356BAAD85DDC496F05EC12DC43C491A4AACC878EA074E083F8D5A3F2F4E78C9F4FCFD6BF0F7C3BF1DBC6DE16F1647E21B0D76F61BD59048EBE73EC970790C33C8C01D6BD4B5EFDBF3E2CEB5A94D770EB69A52BC7E5ADAD9C2BE5A01D4807927EA6B2A9C3F5F4E5917F5CC3495E323EF6F8F3FB59780FE17D9EA3A4BEB515DEBBE4CB10B6B23E6BDBCBB0EDF30023033818C839EE335F97FAE7C5CD4F53D3174A6D57547B3DF2DC4A3ED011A599C0E4FCB92BC0FBC4E71DAB8AF10788B53F15EB575AB6B17D36A1A8DD3EF9AE6E1B73B9E9C9FA71F40076AA0A4631D07A57BF81C9E9617DE93E693FEB43CDA98F9B5CB4F444B71752DE48249A4691F006E639380001FA0A8F8F5A5A43CA8C75EE6BDF514B448F2DC9C9DDEE76DF0A7C616FE15D6AEDAF47FA1DF5ABD94B3143208E372B96DA3AF4E9F5A97E206B5E1BD4B4BD3A2D277BCB0CB379B2B038284FCBD78CE771E07008073824F10970F1AC8AA76AC9F79703069814B2B383809D589E47400FF009F4AE4FAB45D5F6B7D4EFF00AE4BD87B0B5D048632DF20603D58E49349F4E7E95D0DBDAE967C28B1AC6D73AF5C5C865652C123842F2BE8589E7BF0477C8AE874AF87A75A963D43548C687A79405604CF9F30EECA1BEE83EADF8035BC67CDA1CB3A7C8AF7390D07C37A978A3504B2D2ECE5BCB86FE18C70A3D589E147B935EF9E16FD95EC1AC924F10EB53A5CB0F9A1B10A150FA6E60777E429DA278B6D3C27662CB45D3A0B7807F16D3B98FAB1CE58FB9ABDFF000B2F51987CD1C7D7B647F5AD4C4C3F8C1E11F0E7C19F0169AB6BA8DCCB6D73A84B239BA65672C22501542A8CF06BE60D6FE274D79232D8DAAC31F679BE663F8741FAD7B0FED4BAF4BAE780BC34F32AAB26A572060E73FBA8ABE66A60695C789351BA625EE0F3D9540FE95E8BFB36DB8F117C5ED374EBD9A416D79677F6F2B478DC15ECE652464633835E515EA3FB33DD2D9FC63D2677FBB1DB5EB71D78B498D0B711F61FFC13AFC11A5CDAA78E7C572A2BDD5ADC8D36DA49C8CC30E0C8E73D89F9327D16B37E224DE3CFDA57C55E28F8ADE03B996DB40F86CEA9E1A45427FB4A689C3DCC883BE5467DD7627735C27C2BF1D691F0C7C67E31F06F89AFAFB4AF01F8D97636A964FE5CB68493FC583B54AB346C71C0C1E9CD7D33E11FD8B7E17D8C7A76ABE1DF1378A2386075BAB49EC75B5688302195976A6D3C815F84679529E4D9D62330C6B7CD3E554DB873C392CB9D6EACE5AC5F549B7F691F7983A73C760A950C3ABA8DF995ECF9AEECFF005F5B2E85BF881AE7877F6A5FD90F54F11C11C6A5F4D92F7CBE0B58DF40A5D933DB0C08CF757F7AF8F3C2FE1DD3C7ECBBA8EB292DC7DB2FB56B08674665D8A239E42A578CF43CE49E95EB9FB407887C0DF03342F19F82BE1B6A37779AFF008DA7FF008986970DCACD69A70627CC64555FDDBB2B140993C63380A2B83F1169F0F84FF663BBD321963967B5BED3E49B61C8F31A5919BF0C9C7D057ADC3B83786CB2B4A8A92A152B5395352D1A4E70BFE3A27D6D7EA7CFF13D65354A152CEA479549AEFCEADFE7E57B1EB32789F56D5BF6C8F167846FB53BCD47C25A9C32417FA45D4E64B48E1164ADBD51B210AB007231C9F7AE57C0FF0004FC0FE2E8FC2DAC5C5B4C9A3EA5A0880EDBA7C36A8D75F6757CE723246EDBD3DABCAFC45FB4F789FC5E9AB85B0D0F41BAD622F2752D4747B1F2AF2EE3C01B1E56666DA4000818C8AC0D33E38788740F05E95E17B3FB3269BA5EAC9ABDBBB21F33CD57DEA84E71B37738C67DEB969E439953C3C23876A94F969C1A8CB7E58C94A6EC92E66DC6DBBB4757D17E671C263A3452A4F92568A767D93BCBD5B6ADE48FA3FF00665F05E93E15FDA53C01A24504906AB37855EEF5793CC2499E62182E0F0B84DBC003AD73F6B2A43FB67CC80924788E45033D7E5358DFB2D7C53D57C5DFB55CFE30D462824D4A5D36E2530C394886D589155724900003BD71BF153E205E7813F698F126BF631C126A1A7EB525C451DC02D1EEC7460082473EB5FA5709D2A987AF5678AD66BD8B96B7D7F78DA5E4AF65E46B2A35EBD19E1E4EF39D3AAB7D2F254FAF6BE9E8779E3AF156816FE093E16F1078DA3F14DCDE6BF15D79F6723DC0D2AD412B29123AFDE20FDD19E95C1FED15E0DD27C2D2E98FA178762B0D12E5A5365AE59EA8D7D06A710C6D249E1241D59463EF7B5793C1E2292DF5C8B5410C13CA9722EBC89E3DF0BB6FDDB594F553D08EE2B63E217C5DD4BC7BA5E9BA48D3349D0345D3A4927834DD1ADCC30F9B2637C872C49270075C0AFD1EA56A5569CF9959E89757A3EEEFFA745B686F86CB6B60ABD27464DC6F272D6CAED5AEA31B2BE8AD74D6EFE2D5FD5BF116D628FF00608F86D3EE6F324960561D8004E3F9D79FFECF7A75FDBD9F887C4DA3A4526A56A6DEC2D8CB3244BF3CAB24D8672067CB4C633FC54FF889A8CA3F643F0AC1E6FC91DAE9AE1327E525A404FA73FD2BE7FB8F1B5E5CF82ECFC305214D36DEF64BFDCAA7CC96575099739C101460600AFCAB31CBE55AAE268C2CB9AA26EFAE8E3193D2EAF7D9ABADCFD3728C6430F430D5A777CB076B69AF34D2D6CED6DEF6E87B45C7C34B1D07E337C45B24B9BCB5B75D1F50D42DBEC772D0E6374122292A46E4F9882A7838E6B07F643B18EFBE334103DCC91A3E9B704C88402B8D87238F6AE49FE356B86EA1BA686C9EE63D09BC3C6568DB325B118DCDF373201C03D3DAB73F6569BCBF8B04FF00774BB93FAA54E170D5E9C2D88776D417CD68DFCF73A71D5E8554FEAEADFC47F7ABA5F2D8FB0BE00D9E9BE2ED5BE303DFE91A6EAC2D7C43A54700D4741B8D5C46AD79701F6C56E448BB80E5F3B0606F04578FFC7AF8A3F0FBC3FF00183C73A437C16D16EFEC7AE5EDBF9ABAFEA1007093B2EE11C6E1101C7DD5014741C5647C3CFDA42D7E0CEB1F112CAE7C3B37883FB675AB5B95316AF3E9FE4FD96E65739780876DDBFA676F1F3061C561F8EFF6ACB7F1778D35FD717E13FC3829A95FCF76BFDA3A135C5CE2472C3CD904AA1DF9E58019393815F7188D2B4D79BFCCF80C0AE5C2525FDD8FE48FA6F4BD07C1FE2BFD97E2F11E9BF0FF00C3FA03CDF0EF5E9E254D1AEEF67B7952EA55571A9C84C60FCB9092032FF7485C0AF3DFD97BC2B6DAC7846C6E03B473B44F03C9B7212249A4618F72CFF8E0572CBFB6B58DEFC2F6F0B9F87763A4CBFF0008C6A3E1D13E89A8CF696511B995E4F323B1DCD1606FE4B65C9C90C0715E85FB1EEA1158FC3BD39AEEE112C2E26BB89831C10C987CE7BE770E3F2E6BCCC74AB47055FEADF1B8E9EBCCBFA47D1E4F5E786CD70B5E9CACE326EFA7F24975EF7B195AD477DAA7ECDFE22F0FDB5FE9D14F71F15FEC70FDBAF20B702130942EECEDB922F3CA658FCA0F3D2B8EFDA55A3F01F807E0CF83AFAE34D3E29D1B48D40EB16FA6DE43762069AF59E10F2C4CCA58C7C819240AF3BD47C07E1FD4BC59E29BCF15F863E245CEA53EB1772473F86EDAD4DABDB9909420CA85893CE79C74AF25D4BC05E2AB7D46ED74DF0A6BD1E9DE73FD985D5A112F9593B37ED1B776319C719E95E8D1C2E22494141C9ADEC99C18EA9ECAACEA621F2DDBD5E9D7CCFAF7E1485D6BE1EE8B079B2C22EA19223343F7D373B2E5783C8CF1C5697C37B2B1F0BCDF648164FB3DB48EA3781E631DE796E9F313D7A5617C095BCD0FC05E195D46CE586EED41696D6652AE312B1C107A6463F3AEA7C4324DA6F8C6EF53362F6361A94EF756E8C300658964FA86CFE183DEBD2F10F2F954CB70B87B7BCE927E7E68FBEF04B31A38ACCB32A5392E693718FC9EB6F5D1FC8A9E34F8C365AA6BD73676B622D6289944D25D4016E43A8C119CF09E9EB9AFA9FF00669F8E977E30F0EDCD85FB79CFA4B450ADD0FBC55958A06F71B1867BE077EBF3BDF5D78E3C411CD6FE1CF10E87A7D95DA08E66BCB006E4263053CCC3065FC01AF53F83BE0FB0F857E11FEC9B4BA7D5352BC984F7774A983348176A222E4E15464019C92493D6BF15E2FE23C86BF0252C8A9E1631C552943D972CA7392DBDACA6E54E0A2A4972F2A72BBE5764A2999D4E07CDB0FC5B5734AD51CA9CD353BC54535AF22566EF6DEFA75EECEE3F6866B6B1F08AC967E628BDBD31CA8C46DDBB4B607E247E55E4BF0CECEDB47F0DEB9E22BBB38354B9B3BB834FD3E1BC4F32047911E433489D1CAAC7B554F193920E315EF7F13FC0F71E2CF86AB67145FF00133B50B751C59C9320077203DCE18E3DC0AF9ABC27E3293C1F26A3617DA72EA9A4DF054BDD3A5731316424A491B81949109386C118241041AEDE02580A1470FF005BA69A84939C575D37F3FD6D63F2AE29E21CD38773AAF18559468E229A8A96BA72BDD5BAA77BDB5B4EFABB1EC5F0D7C449E3CF132685AFE97A6DF1B88A57B6BC8EC22865824442F825140642148208E320835D8F8EBE19E89ACFC3EF116986DA3B186E6CA40F2DA46A92050B9C038F61D6B97F80DA8E97ABEA9A9DFE81A0DD69F67047F669752D52ED6E267760098610A8AA800C166E58E40E0135EAFE22B732F86B558F18692D6551ED946C579BE236659563B89A87F6443963151E7B2E54E57BECBB2B5FB9F65C235F195325954AF55CE326F96F7DB6EBADAF73CCBC3BA56B7F113E1ADA5A437BA758D8DA31892492091E50A8B8E40600F15D6E9FA0D86896BA46951F9D70B25B2C5652B4EAAD3EC8B702CBB3E505549CF38E38F4E1FE0078AFECFE11B9B46B1BEBD53A832EFB689A455123632CC79C0C649F439AE935086DBC376D0F8B2DD2F7EEB2CBA46AB29473103F3188B64C32285DCAD9DA470DC357852CBF28AD8CAB87C6C146FA477E5BD9D9C9A69A4B4E8D5AF7B6E7AF4F1F8BF614E7877ADAF25D7A5EDA59FF0056366CFC2F05F5E4573A8DB6A5A5ADA5CB5B2C91DC23DB492320215C850790D95C8C678CE78AF97BF6E2D3EDB45F13F8720859A449ACA4DC24239F9C8C715F44F9BAD7C42D1F52FEC7F15AC7A06A917996DE54414CEE140292A9198CAE006519619CE718AF92BF6CE9B5AB5D53C2316B9F2DD2D948101656708180F9CAF04E77608EDB73CE6BEE386B27CBF2DCF30D2A0942B422D4A1ADD3716EF0BEF17AF576F9D97CE6758CC46272DAD19DDC24D352D35B34BDEB6CED6388F1D4D77AB683E1CD5E582E2769749B793539D7735BEE32496F68EDD84AF141B4FA94E3BD58D4B546F1F7C3B975A958CFE23F0CBC50EA3393992EF4D93E482773FC4D0C98899CF255E3CE719AE4B49F8D1AEE99E097F07BFD92EFC373337DA2D6584799321DC550C83E6C46EED227F7589EC71587E15F185F785F5DB7BDD3F55BBD258910CD756AAAF2790CC0480A30DB20DB9251861B18AFDF3DA4ADE9B1F9972C6FEBB9EDDF08FC689E32F891E0DD3EEE0F2EE7FB4A2517111C0F2F3D08E84FBD7B6FEDADE2ABBD0FC4DF0CB49B5665D334DD21EFD2363F2BCEEC15D8FBED079EDBCFAD78D6896FE1DB5FDA43E1F5DF84D52E347BCBA8C9D52D5E316D7D306F99D60403ECAE07DF848183C8E2BEDDF15F83B46F12EA7A2EA9A9C1E6DC6910DD5BC658065786E2231C88E0F55DA474C60A83DCD7E6FC478BA78DCDA14AA351A93A4927D6CA6DB5EBD7E47E91C17521917FB57273C21393E5E9770B2F4573CCFE1C5B5A41E15D7F4FF18D84F0E9779E1D8FC5D63AC58EE6D891A905438182EBE660A1EE3D0E6BC274DF1B6BF61E32F87DE22B285E0B6FED944B5B85607CF951E3499300F4DB301EFB8FA57DB1E17D4343F08F85ECB40D3191348B3B716B1413CE66FDD0CFCAC589DDD48E7B715C6EA5F0FBC33AD78D341D78AC49A5F86ADDCD868F67108EDEDAE1A41219F098DC7E5188F182466B82A60796319735B97FCD3DFB2D4FB9C3714479F111AB4F9955FF00E4651D23B294BDDBBBDAC9E9B153C4D3C761E30D49A27C1DD2F965B90374AFCE3FE002BB4D1FC236970FA06ACF6B69E27D11AD9BFB52FF0050000B008A5E5FDDA11F3B1015783C673EFE1FE35F1D697AB7D9EE2D9CDA5D413496D2C129F9CE58B2B11DB9DC319FE2ADBB5F8893FC37F0BD8DBE87AA28F10EAA5751D52F2D9C388540220B51D47CAB92DFED31AFAFC8E9D3AD97C7EA91E5F7A775B6AE526DBED7BF37ABB1FCE5C4152597E6F55662AF1E58C93DEE928A4927A3D572B5D126D3563D1264D2BE25F857514F027853477D696E4594AED906DA1933E5DC07CE30A01DC393C7039AF9FF00E2DF83B44FF8486F7C2761AB4DABD84CAB65717BB55499186D936638E32707F9D76D0FED2FE2A5D52D1F58D40EA5A38252F34F48A389678581575F940F9B69241F502B9FD07C0116A5F1427B3D2EF63D5341B265BC8AFA170434446E841F47CE14A9E4156F4AF6318D65F82C454C54AD050975BDEEAD6BBEB7B24ADADFA9F314AB4334C6E163818F355F6914DD946D677BA8A6F4B5DC9DDDB97A5F5F3CF8A3F0FF00C27E32F168B1F1044B3DAE8F6B15A5940BE38D3342F2C150CE7C9B94676CFCA370E3E41E95CAFF00C33EFC2BFF00A0637FE1DED07FF8CD745F1BBC51E38F0BE836FE37F044B69F6119B6D6A0B8D22D6F5A1911881366689C85392A48381F21EE48F1FB5FDAE3C7971182FAAE8703F7493C33A68FD7ECF5F25C1F18D6C9E8D2C3B49D35CB25769A9AF8AFE6DEBE77BF53FA273653FAED49CB552774FBA7B7E1A7E077BFF0CFBF0AFF00E8187FF0EF683FFC66BDEBE0C784F4CD0FE136AD06892B259D96A4D0DA427C4169AD2C68C913B03716CA1397773B7191BB9EA2BE43B8FDACFE23DC4B1DA69D7DA3DDDCCCC11162F0B69AC4B1380AA3ECF9624F1815F797C0FF000CF88F4FF8631A78D2681BC49AAB9BDBD8EDAD21B64B76655548FCB8555372A226703EF6EE4D7CF78852A1472FA74B14D4A5CE9C55DB7A75F96D7F3B1180A35EB7B58D176BC5AFBD6C713A878375EF1458DCE9BA0C46E755963668A289F6B1DBF33609E0700FE6077AE1BC03E0FD66F99756D36C6E2DF4696E069C1EE1B87BAC8CAEDEBED9F5AFA659B4AF84FE1D275EFB77DB3C4824B489F4BDA67B5B503E6906EF5247BE31E8697E1BEB7E12F0CCE9A768926AB7CD7D22EC9F54B74482DA500EC7DBDDB38FD2BE4B051A71C2AC3D69A4EA6AF5DAF6E5F77ADEDF2B9F211A5ECD7B1A9A37BF97CBA9CB7857C133E93E30D4744D4A78D8DAA9595AD1B72EF1B4F048F7C74AF91FC597C3C59F1A6EEC6691962B8D63EC2A49C954F37CB5FC8015F75685E1CBCF0F5D5F3EA7219B549A5633B939258B64B7E279FCABE14FDA83C25A9FC28F8B52EBD6B132E97A95CFF6859DD2AFCAB2EEDCE84FF78364E3D08F7AF91CBE38696675B923CB369A57DF47B3F35FA1FD2BE17D4965F4A746A3E594E2F96FD2EEF6FD4FBB6DBE1EE93676F15BC0F3C70C4811114AE1540C01D2BE6AFDAB3E1969D67E20D1F51B35679AEA075999F1925080A781E8D8FF00808AF6CF85DF1CBC35F13BC256FABDAEA56B6D70231F6CB39A65592DE4C7CC0827EEE7386E847E22BCB7E2BF8993E2078B2D6DB4E43730423ECF0151CCAE4E491F5E3FEF9CD79794E069E171AE71A5C8E37E67AFF5FD5CF4F20A38E8E637C436A30BF35F6DBBFAEBF898B777D2C9F0E7C228EF21758A449379C83B24289FF8EA8FCEBCEBE09E979FDA2745B56DCA91DF4B2B2EE237AAA338048EC4806BE85F885F0FFF00B3FE1F68CB6DB659F4B461388CF5DE77330F501B3F81AF15D0747817E2A7843513737560D36A50DB5C5CDACBE59556CAA8CF6DC48427D0D7F56F0A3C263384294B2DB2F632A9CC9746E526DFAB4D4BD3D0FE20E2BC44F0BE2263562D5E962797D9DF671B2515AE96D251F5F53EF49B45B69ECECB569620D731BB0B793BA2B2E1B1F5C7E95F35F8D3504D57E3EC7146FB631776F64EEBD78DAAFF008F2457D1DF12BC4967F0EFC0AF7729C1858AC1131E6497076A8FC4E4FA006BE50F863A4DCF893C6F06A339675827FB64F31EEC1B70FC4B7F5F4AF5B0F2A34B27C763F1ED2A4A9CE3AECEEB6F9ED6EADF73C6E2073966F80CAB00AF5A55613D37567A37F2D6FD147B1A57F6BA841AC6B70F86DAF6F7588F51B9596D4461E316EBF71C938C367701D738C71D0F3BAF69BE1D6F87D1EA16D7935CF891AF112F63BAC2BC7957276AF75CE3E6CFD71D2BE84B8F1968DA1C933DCC5269C646CBCCD6C42B9F52EA083F89AE03C59E0BF077C41D6A2D46D359B7B5999BFD252DDD0994F638CF0DEF8FEB9FC7B23E27C152AB0AD88C34A8525C8FDAC62DF3F22D213718FBD0E9149BE5B2BDD6DFD555A85592E552E67AE8FA5FAAF3398F8B5A3DBE9FF0CBC1D7113C8D24F6E85C31181FBB43C715F327C59C269FA2B67966981FC367F8D7D5DF1FA382CFC1BE1EB1B5DC60B53E5233904955550327D78AF92BE30C9B6C7431FED4E7FF0040AFAFC86A50ADC2B4EAD0568CAAD46BE739B3C5CD79D4A4A6F5B2FD0F50FD9CEC7C3B71E1549DA1D3E5D7C5C4A1CC9B1AE1501F9783C818F4AF43F1B5C78C21B507C2D6BA65CCD8E7EDD2B0707FD91C29FC4D7887C22B2F879A5F836DF5FF0013C964BAA9B89553ED529770AAD85D910FE78ADDD7FF006A1D2B4E629A0585DEA2CBD24BC2228BF01CB1FD2BF99B37C9F1D9867F56B60284AB25277F691B534EFB297359C574DBD0FBCCBF30C2E172A853C5558D36D2B723F7BD5AB68FEF3CC3E17A3DEFC62F0B417795926D7AD927DB8C86370A1B1F8935EE915F69FE19F88F0FDB236BAD2F4FD517CE8D864C90A4A370C772541E2BC03E14DF35C7C64F08DCB001E4D7AD65207404DC29FCB9AFA4FE2AE8A9E07F89D6FADDEE9A352D02E6F12F24B7C954986F0D2C24F6279FC08AFEB8E0FCC6861F389E5D55DA75A95E2B6BB83774BCED26D7927D8FE56E3FCB2AE2B2FA18FA6AF1A35356D5ECA56D5F95E2AFE763EAEF1CE97E25F8B5AB59F887E18FC50B58AD2381766971DC1440C0925982E793C655D78C57CE3FB48EB1E329BC6B63FF0009AE8F67A4EA90D9AC51CD60331DDA8627CC0D93939278E36F4C56FEB9E19F823E38D721F12F873E232F8062902BDC6946D5A392161D7CAE46C271DB70CF23D2B9CFDAB3E38685F14359D074FF000E4B35EE99A243247FDA570A55AE5DF60246402400839206493C7AFE8594509D1C551853A6DC527772A7C92879396D2BBF5EE7C3E7FC98AC0D7A956A28CE528B4A3539E1535DD45DDC2CB5E9D8B3F0F74BB2F1A7C4BF8529A8A34F6FE5DC5DCF095327982DBCD7550A065B3B178E49E95EADE22FDBDB4CB4F1E41A4D9787B538B46B59585FDC5C5B1FB6BE14E123B7254A65B196739033F2E6BE57D0FE266A1F0E75EF01789BCB69D749BB92448471E6C04812203EE1E41F535FA3FE1FB5F02FC5C5D03C7FA4C367A8DD423CDB2D5ADFE4B88F2A55A276183D09568DB81E95E263B0D84CB230F6F439E8FEF54795D9464EAD47FAAF4B3D1D8FACC92A62B1D46D42B7255FDDB95D5DC92A705FA3F5BEEAE781F8C7F6FF00D22CE3B0B9F0FF0087B549424F8BCB7D5ADC5BAC909079494336D7040C02A4104F4AE4FF00698F1A683F1A7E1CF833C7BA569F7FA74F1EA5FD9920BFB53133A491B3E15FEEC8A19386524727A6715F6378ABC07A0F8E1B4E1AF69B0EAB0E9F3FDA60B7B91BA112E080EC9F758804E37038C9AF877F6D0F8E3A578DBC6DE1FF00067876E22BAD3742B8F32EEE2DC83135C91B0468470446B9048E32C476ACB279E131588A7F52C3B84A0A4E52E6BAE5B3D1E8AF7F97CCEFCE29E2B0F85ABF5CAEA719594572D9DEEB55AE96F9FC8CFF00D8DFFE45AF8D3FF62EB7FE813D70DFB1AFFC9C6783BEB71FFA4D255FFD93FE26E83E03F1A6BDA4F8A67FB1F87FC4BA7BE9D3DE1FBB031276B37A290CE33D8904F19AF4CF85FF000BFC13FB37F8B64F1FEBBF12F41D7ACB4E826FECCB1D2A5592E6E5DD0AAE5431E7692303232724802BEA71D53D854C6D29A77AB15C964DDDF2F2DB4F33E332FA7F58A581AB092B5193E7BB4ACB994AFAF91CB78DFE19699A97C29F8C1E3692F7524D4EC7C65756D1DA4775B6CDD7ED1180CF163E660246E73E9553E0CDD7F66FC0CBA74243DF6BEF0487FD88E089C0FC5981FF00808AD1D3FC6967AF7EC7BF1324BBBEB48758D57C50D7C2C4CEA263BE5B772553392073CE3B1F4AA5F03F4B7F107C0FD56C60F9AFE1D65EEED22EF2B0863578C7FB4CA4E3D4A81DEBF3BE3AE77C3788A75B56AAC631FF00C056DF8A5EA7E93E1F7B08F16E0AA2D22E9B6FE6E5ABF4D1BF436B4DF3756BE8AD6078D6490FDF9A408883BB331E800FFEB64D7B66AD0681F083C16B7569325D7882E548B4D4180F32493182E8A7EEC6A09E3A1CE1B24ED1E37E11F13E85E03D3E0D7A586D7C45E2295985A5848D982C31FF002D665C659C9CE1474C6739E9CBF883C65A878A3569F52D4EE4DCDE4C72CD80AAA3FBAAA38551E82BF98E854A782A4E4927565B7F7577F5F4DBBAD53FED4C46595F32C4286B1A10DFA73BED6DF9575BD93E89E8D7A27847C5175AE78E236D42E1EE5F52492DAE1DB192A633B703A0DA5548F4DB543F684F0EDD4761E1FD07C3F15D5FEA5ACDE1892DD704BED00E381C0058313D06DCD45F08EC8B5F5CF886E415B1B08A4484F399A7642B85F5D8AC58E3A65477AF74F0878CBC37E2CD1D350F0E5C5BDEC8A85253E6092E2063C3A3774E57D83601E4573617011C5E2235EAC5370D6EF7D76FC537AFAF53E6B39C74729C7C254637E556B6CB9B5B5FD2EB6F43E2CD7F47D1FC13AED868BE23D42782C1A68D75463032C9146A773A851C90C405CFA1279AFA1BC55F00F42F17E8F0B699A9DD59193648B23FEF51A33827E53820E0F1C8F715CFFED31E22F0547E13BBD47C4DA658EB535A9FB3DA2C8E524799B811ABA10C40E58F381835E45AA7ED2BAD7887C3AB6D6179FD9526E5388014740B8C2ABE79191EC7B74AFB3CEF1585CC2961965B4A549D3E6524E5785DB5AAEADBEB7D928A5B1F2DC3596F11E23195F1D89C4A9F3B8A52B24D28A7A3495ACAF7565AB6DBDCFA9F41F857A078774B834FB07B88ADE118032A4B1EA598E3927B9AD26F02E9CBD67B91DFAAFF0085789FC31BAD5FC70DA778BAEF52BED2A54768EE6D54FF00A35E850A3CC51FC392D8EFCA9AF47D43E2C787E1D71349975CB68B51DA8A2DDE5018920607D7A57E5189C0E09D4972D2E79EF2DDD9F5BB3D0ABF5CA55650A937A3B743A2FF0084174DFF009F8B9FCD7FC2BC8758FB3E87ABEA762D29565BB9592397891D49C820771CF51C57ADDBEA90B487ED37A6D62DBB84851DC1F6E071F8E29DAC6976FAB6980CB05BEA16E58623BEDAD03FA812287507EA2BF43F0FB195723C64B33C0609548B5C92B4945D9B4FCDE96EC7E73C6597C33CC22C0E2312E124F993716D5D26ADD3BF73E7BD4266BE25047B63FF006864FF00F5ABAEF05E92BA97817C59F6AB9B83F62864F2137E428306EC739E335B9AE7C3FD1C4427B3B4D7744940CF930C6351B7938E8A4121467B978F8F4A8B4BD0EFF43F09F892290ABCF7D03948ADC1C9FDCED008C9F9B3D813F535FB271E716E4B99E534F095528D6E7A7251766F492BEAB6B79DAE7E57C1FC2B9AE5199D4C4A97352E49ABABA576B4D1FE97B77367C79E27BED23C5569035F369BA4A5A7DA0B29C0B87CB060C7B85C2FCA3D727B552B6F134BE27D26CF51459A3B79F7BABB1D8CE80B2A9C673824641E8473573C45E36D2AEA1F25A39AEE3639D926953CAA08EF831100D721ACF8B27B823EC69230230DF69D32F33E981B63E98C57D261AAE535B33863A55B96A422E17E74A0E37BEAAFABBBD1F4B1F3589A798C3012C2C6973425252F81B92764B47D1596ABCCB3E30BE6D4FC23777538105C5C69EEB25BC63E48BE53C061F2B1E7A8AD8F1D68B1E83AAD8AD9DE5C2892DE66656652BB83C601C6307EF1EBEB5E7D79A96A175A05C6962D65312DBB43676D69A75D22292080A372600E95E97E30D2EF75E9ADAE2D6684CB047247E55C65558315390C01C1050763D6BE378BB1BC3F433DCAAA63E54E7457B5E6DA697325BA57DDBEDE67D670CE173AAF93E650C1C670AAFD972EF06F95F46DAD92EFE4705A96B176B0EDB8861BA5552AB32FEEE40371600E7860096C723EF1AF37F1AEAC9F657915F690470EB86079C120F51C1E848E2BBED73C3BADE9F19B8D5B4DBCB7B75C66611978067FDA5CE07BB0158137C2D5F8917B1DB8D4C5959C68B24B242A2469172E36A9CE01E7AF38F4AFD471D8FC932EC99E6185ACBD8C12D23AA4B44B45AAE892FC0FCFB0384CE31D9B2C0E2E8B55277D64ACDB49BDF48BF37F89ECBF05FE21C9F1DEF8EBD79A5FF63C5A7DCDBDAC26193789E5501A46391D324600E80E3B57AA7ED0BF13BC23A3F80FC71E1DBEF1269B67AF4DA3DCA47A6CF3849DCBC4DB02A9E4EEED8AE27E1DE9363E0D8346D1349845B585BCA8AA9D4B12E0B331EEC49249F7AEF7F686F805A2FC76F0EB5ADD15D3F5FB4DC74DD59532D0B1FE07FEF44C7AAF6EA39AFC1F85331C16698FC5E36117084A717E7A2B26FE4B53F7DCDB0789C0E0A861652E69462FF17776FBF43F2DED670B34049C00E84FB722BF5AFC37F12BC27E3DFB6DA7877C49A76B93416ACF3A584E25312952016C74C9F5AFCD5F0CFECE3E3AF127C54B9F0149A6369BA95910F7F793026DADA02789F70E1D587DC03963C71838FD17F861F0C341F83DE0DFEC0F0FC1B2258A492E2EE503CEBB9BCB399643DCFA0E8A3815FACF1055A152947DEBC9276B6D67DFF43E2727A756137A5969BF91E6D75E0BD32354DAD765833297DE9B1C6011D718239FA835CE6ADAB687E11F17F857465B5BBD4B59D66E9A382D51E371084467334C83E6F286DE48A97C55E30B1F05E91A86BFA932A436F19666639C9C0011413C16200F7EFD2BC97F67F5BBF146A9AB7C51D7FCB4D475C060D322938105886EAB9E81CA8FAAA29FE235FC6581A186853A999D4A69421A415B79FD9F551F8A5F24F73F7CC454C5CA6B0B0AAEF2BB7E51EBF7ECBFE01F4BDA789BFE11FD3F56FB3F8760B8B8B88D9E692EDDA692E1BEF112120641E7E5181935F9FF00FB4AFC359BC67F132F6FBC49E24D5F50699565B68B7A2DBC11B2E42431EDC228E981FAD7DC51F882E042CB1BA9F97F7727DE31B76233D47B743EDD6BE6DFDACA29ACF47D2759B5D39556DE56B69FCBC88D0360A95CF3B7208EBC138E06057D3F09E7556598468E26574EE96896AF5BF4D5BEBFE678F9965F3FABCE56D559DEF7DBA7FC03CDFF00665F0743E03F1C4B63A66A324D69AB45E535B5DE3779CA4B214600039195C100FB9CE2BEA19217864647528EA7055860835F0DE83F132E741D62C7518AD479F6B7093C643E06548383C7B57E8369FAD5878D343B0BF781923BA81668E553F3A061900FF780A8F1032683C4C3194DD9CD59F66D7E5A1DDC2F9849529509EA97EA735B7BE29ACB5A9A86912D88F307EFADC9C0953A7D0FA1ACCF6AFC4E74E54A5CB35667E8F19466AF1633AF6AE07E3B787FFE124F845E28B2037486C9E54FF793E71FAAD7A0554D4AD56FAC2E6D9C6639A3646FA118C576E02BBC36269D58FD969FE25548FB484A0F667C5FFB0AF895ECFC61AFE84CC7CABEB559D467F8E36C671F466FCABED4C735F9F5F01646F03FED276560490A6F27B0639C70432AFF0021F9D7E8332D7DFF001CD151CCE35E3B548A7FA7E87CBF0CD497D565465F664D08D4DA7D32BF3C4CFB2184531AA4614C615A234431A9B4E34D6E2B5B1A218D4D27A539BB715E33F1C3E366B1F0AB52D3A3B3D0A2D46CEE860DC492305462700640C0273DCF38AF430183AD985654282F79FC8C6B6229E1A9BAD51FBA8F4DF126830789B479EC2EB7AC720C6E8DD9194839EA0E457CE5E2AF1D78B7E016BB2D95A5B4DAD785A3759A4B8BA123BFCE3017CD248E083DBB77EF99AE7ED357DE2CD4EDB4BB1926F0E6A51B0569A19D248247C8CE72381D7BF4AF63F8911DA4DF0C649EFA7B8D4245B55F3AE74E032FB80DCE01EC78AFBAC2602B6513A7431D0528557671EDB6BFD33C9957A398C24F0B52D28EB75DFB1E4FE22FDA33C4BADFC40D2AD7C1661D434FB8846CB72AAC657209209FBCA41E3DF6FBD7213FED61E3FD0B52BCB6D434EB51344CE8609A02A636E80123A8539EC3EB5E6DA2F8E26D159ED742716532B379721B6469252338C9C120E31C63F1AD2F127C54D46F26D1EE6EF514D7F52B588A4A6EADD5E22A589F2CEEE58E304F15FA553C870B4DC69FD5E2E16EBBFAB3E0AA6755EA41CD621C657E96B76B257B9EA4DFB4A4BE33F86BE22B2D674882EEF56255896389FCA753C12E0636919EBC5792FC30F07C1E309B56CDA5FC4F6F6CD246B62C4EE3866DA78380403DF9381DEB035CF1E5EEAD792CF610AE8627804173069B98A29F1DD95719CFA57BB7ECFF00A3DCE8BE4EA5ACEA96F6D6F35B95B4F3268D4BC8183AAE48C9C738EA011ED5A56C3D3C970552587872B93BDB7D74D919616BCF39C6D3857973285EF2B6E79CFC27F0A7882E35CB6D52DEC99B4EB1B8CCA6F1D91723E6604020E40FA0E2BEBFBDF8A1A3E83E13B4D6B53BBB7844D18221B79158B1E8420CFCDF85709E3AF8FDE1AF0BDE69D049BAEAE1891710C43F721581079E41233EDF97354EFBE1DF817C41A3EA1AEE83636DAFDC496FBACF4C5BADA9E6719500375FA57C6660DE673A75730A4E11BD9596FEAFA7A9F7180A34B2C854A583A8A73DDDDEDE88D8BCF8E7E1BD6BC3E7509AC1A7D316E16197CD2ACD0F7590A75DB91D7DBF3E3B57FDABF4ED1F57B890684F2DCAAECDCF304254B657076FA73F957956ADE3ED63C0BA6BE8D2F862CF4C5BA56F3ACAE6367EA782558F5C8E0F5AF3CD3F4D5F1148D717BA84767264B667E15971D8E7AD7D260F86F05CAE75637874D6F75F23E7B1BC4B8C8B8D2C3CBF79D6EADF99F7E1F885A7C3E0587C532B6FB17B65B865B7224C671951D3383C67F0E0D617C37F8C563F13752BFB7B0B478A3B54573233824E49C0C62BC8AEFE2C5A683A0F85344F0CEAF6BADC2D0476973A4CB111BC15C1DC5BD49DBF7B83D38AB5F0674FBCF0CF8CB54BAB6921B5D05774D7CA1C15B78F9C2F0CC4107D735F253C8E951C2D6A938DA5F66F7DAF6DBB9F594F36AB56B518D369AD14ADAEAD5CFA4C822995E6FAFF00C72F0FAE8777368BA8C17BA8AA1682DDC30DE41E9C81CD6B7C2CF18EA1E36F0E35F6A366B693799B57CB6CABA1C104751EBDEBE5A796E268D1FAC548D95EDAEFF71F4F4F1B42A5454A12BB7D8EC185676B9A6AEADA5DC5AB73E629519E99AD4DA698C0571539CA9C94E2F547A3BA699F3FFC19F862FE1DF1F78825BFB7DC1187D9E465E0E0E49FD7F4ADCFDA83C3CBABFC2FBB9FCBDD3D8CC93A3639033B5BF4635EBFE5AAB16000278CD50D774A835AD2EE2CAE155E19D7690C38AFA48E715679853C654E964FD11E24B29A2B0153034F48CEFF007BD4FCE86D4D67D3ED6DA5E96E5F6F5E871FD41A2BD0BE3E7C33FF008417C70EBA7C4C34BBD4F3A01C90A7A3AE40F5E7F1A2BF79C3E2B0D88A31AB0968D5CFE73C5E0F1F84AF2A1CB7E5D0F2FA50C5738F4C52515EA1F3E1451450014514500145145001471DE8A295C3476045793A73B79E9DB3C91F4A3EEE3BF7CD694FFF001E161FEE1FE6F543FE5DDBFDFA88CF98DEA5350EA328A28AD0C028A28A0028F70307D68A29ED6F310514514587D2E14BFCBD3B525146A87ADB987C6CA9265A312AE08DA491C918078F7E6A3514EA4A421C0D03E5148BD695A800CFBF35ADE1DF0EEA7E26B86B3D3A059B1FBC92462A88800EACE7A0E6B31BFD4AD7B37C3AFF009260FF00F5F8DFFA08A5D0B5EEC8AFA3F86F4EF0DB9B9FDCEA3AAE066E1620B146463FD5A6319E3EF11F402AD5C5C4B7521795D9DD8E496E4934F6FB8FFEEFF5A64BFEB0FD692D986FAB18B80AC0A86246031278E7923F2C7E352249B6A36FE1FF0074FF003A9ADFFD61FA551068E9FAF6A36103C16B2910B36F68D903AEE031BB041C1C5593E28D5C47BFCC4DBD33E447FF00C4D5BD07FE5FBFEB9BD677FCBBA7FBD511936CDA54D28DC78F156AADFF002D633FF6C23FFE26A49BC45A9ADBCBB6F176480C2C638D1090C3EEF0320153CFAE6A7F0E7FC8565FF72AFEABFF001F1FF0387FF41A87565CDCA52A51E4E6384D6347B7D6ACBC8BE8566858903711B94E3823B8FAD7249F0CD6CD5E2B0D7352B1B47FBD6F0CE554FE0081FA57AD78A3FE4210FF00D7B2FF002AC4AB494A3A99BF765A1CC7873C11A6F86732DB445EE0F1E7CA416F7C7615E91E0748B50FB569DA85ADADEE8F752426EA2BCB31711AED7F95DB3C2E01639AC16FF563E95DFF00C37FF901F8A3FED9FF0026AE2C7421570F2854575A7E1AAFB99B51C3D2AF53D9D58DD15B5FB6F86365692AE99E1CD0EE6ED65503FE2571F96C8554E41C7AEE1CE0F238AE46F17458CEE3E0AF0CA47200F1EFD2D065724647E20D4117F1FF009F5A92EFFE3EBFE00DFD6BCDA394E123EEB8DDFABFF330AD86C3CFDE5492F43B3F0CDE697A25DC57BE1AF09691617135A4915CCFFD9F1A394760AC136FDE5FBB5DA78BBE1DF84ACFC0373E34F11691A36B7E26BE311301D31576BB8CEE9891B89DA09C0EA6B23C13FEB3C1DFF5D67FE4B5E97FB4D7FAE97FDC8FFF00451AE28B780C4469E11B829BF7ADD6DB5EFEACF72194E05E15D59524DADBE76BFE4BEE3E7DF0CE8BA3F8ABC416DA3E99E05F0CCB3DD48238E4974EDBB49EE707803E95EADA47ECFDE10D3D74F9FC61E1DD034CB6BAF315AE2CF4D8E5811C636A1936ED2E486F901270BEF56FF655FF0091E24FAA7F3AF70F8FBFF249AE3FEBA5AFFE8E159E619DE3A38E860E9547152EBD7A9784C9F032A1ED6A534DDCF9A7E25782D6CEF8F85B486D3BC4D67104B75D2869263820488165043808A5727A1E724E7B57944BE19B28F23FE10EF0ECAC080561B18A4209240042938391D0F3C74AFA47C6DFF24A5FE937FE84B5F3AE9BFF0021683FEBBC7FFA18AF470B4D6253A988F7A5D5BDDFADAC3AD7C1463430EF962B65D175D0CD9B4DD22DE568A5F07E831C8A70637D351581CF423B1AB9A2EA96BE1BBC6BAD2F40D1B4EB9643134D6B64B1C85091B9770E99C0AD7F1C7FC8D9AB7FD76FEB587FF2D2BD5A783C3AB4D415D6A799531B88927073766ADF79CC6B1E06D1F58D42F2F1FEDF1BDD4EF2B01708402CC49C7EEFDE90FC19D0FCC8CB5F5F8824C85955E324FA7040E0FBE2BA65FBE3EB5607FACB3FA2FF00335EA55C5549372D2EFF00BB1FF23C9C3E168C52A76765FDE97F99CB37C25F0EDBC322BEA17E1E3DBB114A92F93C9FB8318FFEB57B17C27D76D7C3FE0E1E0EB7B481A34BBFB5C1A8DF12D28691E35640146D1D339F456F5AA9F163FE43363FF5E2BFFA1C954BC1FF00F23143FEE43FFA12D793571556A51E6BA5D74515B356D91EC61F0F4B0F8A8A8A6DAEAE527F836D1EC5F103E1CF8D7C233426C9175B82678D105864382FB8A8DB83D761E477AE6FC0DE778CA1B9BFD4625B4B5B472B28F3C2492ED1B9F682B8C85C1FC71D78AF7FF0AFFC7C6B3FEE5BFF00E86F5E5565FF0026E173F47FE55E2651C5B9CE15D4546B72CDB51E6B27BAECEEAFD9F4E87A39AE4380CC2A2FAEC3DA455DA4DBFCD34EDE5B33A9FEC5D43C37A6697E29F08785D754379337D962965324C9037113843D59972E78F941ED8AF724F0BD978E3C3B00F14E911CD24D0AEFB39176881BAB6DC747CE7E61CF4C77AF29FD927FE40DFF006ECFFF00A12D7D11FF002EEFF45FEB5F97F116779856C5BF6D55CAA27F1B6F9ADD356FA1F4797E1A865B08C7090508AB34A2AD67E563C3EE3F660D1ADEECCBA6EB3A859424E442EA926DF6078FD735DFF81FE1E693E08DD2426E2FEF1860DCDD10CCA3D140E17F9FBD7612F6A677AF87AD98E2AB4B9AA4AED7923EBF119CE3F1B4BD8D7AAE51FEB77BBF98BF6A04708D5C278D7E127863C6F3497373692D9DF3FDEB9B421598FAB020827DF19F7AEF29BDBF1AE386658BC2CFDA51A8E2FC8F95C665F83CCA97B1C652538F66AFFF000CFCD187E0CF0EE9FE05F0ED9E8FA6C4C2DEDD4E5DC02F239396763EA4D6CC922CF1B46C870E36D3FB52AFDE5FAD7247155A75BDACA5793776FBB3A234A961E9468D28DA31564BB25B23E7EFD92FC40B7DA3F88EDD637020BD03923D3FFAD5E99E26F018F15F89ECAF351BE79B45B71BDB49F2B89E5072A647DDCC6BD7CB0A32C0124E00AF1CFD8F7FE3E3C69FF5F8BFCDABE976EB5F4DC458DC461735AAE8CACDA5D1765F77AAD4E7C2C613C3C1497739EBAD04AEB0350D36E3FB38CF817D08843A5C80308F8C8D92AF6719E320822B85F8F1FB3EE89F1DA3D3A4BEBBBAD2EFEC372C5756E03651B92ACA7AF2323918E6BD6297F86BC2A5C499B50A946AD3AED4A926A2ECAE93E9B6ABC9DEDB22EA6030B523384E9DD4F75AEBFD791F22FF00C3BE345FFA1BEFFF00F0113FF8AA3FE1DF1A37FD0DF7FF00F8089FFC557D774E5AF6FF00E2207137FD05BFFC061FFC89E67FABF95FFCF9FC65FE67CE5F0A7F634F0FFC33F1A59F88DF58BDD62E6CDBCC8219235890498C076C13B88ED5EEBAEE912EB51954BCB9B33EB0B56E53ABE731DC459AE655E389C5D7729C744EC95BD2C923D0C3E0F0D84A6E950A6945FA9E6171F0AEFE490B9D7F71EA5A4D3E266FCC633F8D703E30F0F6AB069F3EA3078CE5B4D3ED95A00CC861F9B243288D71CF5C6D19FE55F45CDFF1ED2FFBB5E73E24FF005D67FF00617FFDA6D5F4F9671166B8A92862311292ECEDFE47461B05864DCE14D264367A4E95E19B18EE1F498E7FB5006EEE76170B84666772474EA33D4E457CA1A978FEF752D4359BBB1D36D21B2B662459F9DB197E6DB85C9C9EA0E3071CF6E2BE8FF197FC7ADBFF00D743FC96BC33C6DFF2375C7FD7E5C7FE8D35FA4F0AE3F1981AF2A94EABE69EFDB47D9DD33C6E23C972FCD6946963292925B746BD1AD579D9EA79B5C7C5EB899808F4E48F9E4BCA5BEB8E057D89F05F505B8F0569F2E8F02DAFDAA64B89778E4C6C4F527A9006DCFB57C10DFD7FC6BF423E0CFF00C930F0AFFD8322FF00D016BDBF10330C5E23054BDA5476E6DB65F72DCF9CE0FC972DCB2AD6785A094ADBEADDAFB5DB6EDE4739FB3FDD0BED03C5D61A9491C82CF5DBA43E60002A155F51D383553C45FB19FC2FF185D35FA6932E9EF21DC4E9570628DBFE0032A3F002B94F843F7BE217FD84A7AFA0FE15FF00C89D63F4AFC933CAD8DCA715531982C44A9CA5CB7E56D5F4F27A9F790A34EA6123ED229DBBAF338EF873FB377817E14DD2DEE85A1A0D45410350BB769E75CF5DACC484FF0080815E8CD318586F970738C16C64FA569DD7FC7ACBF4AE1E6FF918A3FA57C72AD8ACD273AD8BAF29C9756DB7F89D985A70E5E584525E4757E20D55FC473BCF7BE5B4640558F198D14700007B5652C36BA60CC6B0DB77F9142F5E9D2B99D77EF7E346BFFEB07FD7BC5FFA157757C355AB53DA54AAE4E7ABBF73AA385A7070514B4F23BAD43539F5A68679595DD6258FCC5FE30A300FE5DFDAB03C4BE13D2FC63A3CDA56B7A7C3A969F37DF8675C8C8E841EA08EC47356FC25FF0022ED8FFD73AD66AF1B135AB7D66556536E57DFADFBFAF999C1FB06A34F4B6C7CD371FB10F8521D50DDE91AEEBDA229FF009656B70A71EC18AEEC7D49AF54F017C21D07E1EFEF6C56EAF6FC8DA6FF00519DA79B07A8527851FEE819EF5E834DAEAAF9BE3F154FD956ACDC7FADFBFCCF46A6658BAD0F6752A36BB5CA4D09652AC032918208C835C0F883E0C69BAB5C196D266D38B1C9454DEA0E73903231F9F18E2BD228AEEC9389337E1CAB2AD95621D372D1DACD3F58C938BF2BAD0F90CE721CAF8869469667415451775BA69F94A2D497C9EA711E28F056B1E3ABBB497C45E259F528ED5364710B658C0F56E0E371EE4824D6FE8FA0DA68366B6B63088621C9E3963EA4F7AD8A2BBB38E30CF73FA11C2E618972A71DA294611BF7E5828A6FCDA39B2BE18C9F25C44F1982A16AB2DE7294A72F4E69B934BC932AF979183C8FA5737AD7C35D075D0C66D3D2191B9325B7EECE7D4E383F8835D753EBC0C0E638ECAEAFB6C0D79539778B6BF267D3CD46A2B4E29A3C766FD9FEDE69914EB5726C54E440D102DFF7D6719FC2B03E26FEC9FA7F8F1B4C1A7EB52687159C6CACAD6DF6832B31077677AE0F1F4FA57BDD3EBEB311C7BC4D8AE4F6D8C6D476568A5EAD28DA4FCE49B386580C2CA2E32A7A3F367C91FF000C1A339FF84D8E7FEC15FF00DBA8FF00860E1FF43BB7FE0A7FFB757D6CD4DAE7FF005DB883FE827FF2487FF2272FF63E03FE7DFE2FFCCF98BC23FB167FC22BE2BD1B5AFF0084C1AEBFB3AF61BBF23FB336799E5B86DBBBCE38CE319C1AFA2B56D12CF5EB196CB51B58EEED5FEF4722E47D47A1F715AD4578D8CCF732CC2BD3C4E22B37387C2D2516BAE8E296B7EA7752C0E1A8D39518D35CB2DD3D53F5BDCF16BFFD98BC3575726482EB50B48CFF00CB2491580FA12A4FE79ACBB6FD956C23BF124DAF5C4B681B3E4ADB85723D37EE23FF001DAF7AA2BED6878A3C65420E9C7319B56B6AA327F7CA2DDFCEF7F33E46A70270D55973CB051BDEFA3925F72695BCB63C6BE23FECEF67E388F4886C753FEC3B5D36030242B6BE76E04E739DEBCE49CF5CE6A8F817E01F8B3E19DDC973E16F89D7FA23CA732A5B58FEEE4C7F7E332956FC457B9D14F05E25F1660708B034719FBB57D254E94F76E4EEE7093776DBD5B3AEBF0764588AEF153C3DA7A6AA538EC925651924AC925A24799F8BBC21F147C73A6C9A7EAFF183507B19176C905AE991DB2C83D1BCB91491EC4E2BCE34DFD90534FBEB69CF8A9A448645731AE9E17201CE33E69C7E55F48D15D94FC54E30A3074A9631462FA2A5457E54D18D5E09C82B494EAD0726BBD4A8FF00399F38B7EC901989FF0084A4F3FF0050FF00FEDB4D1FB22A2E71E2823DFF00B3BFFB6D7D1DFC551CBF7BFE035D51F16B8D5BFF007FFF00CA747FF959C7FF0010EF85FF00E813FF0027A9FF00C99F38CDFB26C30A1964F1584451CBB5801FFB56B9EF8A16563F08FE1DDB6836FAF5E5DDDDCDEB5EA4D69118164051176160C7006D07AE79AFA43C69FF002007FF007ABE5CFDA43FE41BA3FF00D7DCDFFA0AD7D1659C5DC41C552861B36C5FB4A7CD7E5E4A71D56DAC629FE276D1E12C932184F1F9750E4A89357E69BD1E8F4949AFC0E62CFE3E8BED3DBFE125D0CEABAB2903FB4ACAEC5A4D30F59818DD1DBFDADA18F724F35B9A57C56F0B5BE86DA95E6973DDDD9768E1D3FF00B5320305C86902C08C57FDD6E7D457891FBDF9511FDF6FFAE63F957D9D7C9F05565CEE9AE6DFD7E5B1583E2ACDF0F0FABC6BBE4B59775E8F7FC4F4EBEF1F4BE228A2D775CD6F50B12B0496D6BA5E970186DE25E7091E085039C9CF24E7249E6B93F0AFC50D7BC0F71AA3E857F71A5C77F198E5582471B8762707E63C9E4E4735E85F14BFE496F80BFEBCE3AF196FB89FEF0AAC0538578CE4E3E56F43CDC7E26A46718DF5DEFADDB7EACD6F1078B67F188B71AE4B35F4D6A3FD12791CFEECB01B86C24AE38277000F1D6B5FE1EE9E2C35A8351D62D5EEB40B7916499FCA7685D376D20943CFE78C8C115CA0FBB2FF00BDFD2B63C3FF00724FFAE33FFE806AF1380A1C8D46295F4FF863B3039F66108C682AAF97B5CF5EBCFDA3B57D7BC4375A3E9D656A9E1E65789228D4232C4A0FCC0F6E3A0AC1F0DDD786B5CD3755BD96D7555BC86EA293FB461B78E46B68C9DB8CFA927B723031C579E697FF00210B5FF3FC2D5EFF00FB2B7FC807C57FEF45FF00A0B57CD6370786CAB0D2A98685AD6BDB4BEBD4F470F8DAD89A91855774DBFC8F4EF813E2FB3F10787E7D3A2D42E351BBB299B7CD72AC19D58E4119EDFD73DABD37ECA8243226E8653D64858A31FA9079FC6B8FF863FF001FFE25FF00AFB5FF00D0457775F876673950C7CAB61E4E0DEBA3D55FCD58FA885AB53E5A8935FD77B953ECED21533DC4F73B7EEACAFF0020FF00800C2FE38CD49B7F1A9E85ED5E56231588C64FDA622A39CBBB6DFE65D2A54E8479694545792B10EDA4D9EF53D15C86F720DB4C30EE18ED56A8A7CA2E633E1B49EC576D8DFDE58273FBB8640D18CFA238655FC00A8ED74A82CE49254456B997FD6DCB806594E49CB3753C93FD2B529B5E956CC31B88A4A856AD29416C9B6D1CD4F0D4294DD48534A4FAA488ED657B4B88A78F1BE370EB919190722BAF7F8B1AEB1C91687D7F703FC6B94A637DDABC26658DCBD38E16AB827BD9D8AAD86A18969D68295BB9D5FF00C2D2D6F716D967B88009FB38C903381FA9FCEA397E26EB5346E845AA875284ADB8070460D731457A5FEB066ED59E2A7F79CDFD9B825FF2E57DC62789BC2BA678C7479F4AD66CA2D434F9F1E65BCCB95383907D4107A11CD3AD3445D3ECE0B3B694C1676F1AC515BA4681111400AA063A0000AD9A6D785CD3E5E4E6D37B74B9E9DA37E6B6A653E8B6D27FAC8959BFBCAA14FE6B8AC4F88BE194F11780758D2444B2F9B6CEB1A4849F980CA9CF5C820575F50DE7FAB3FEEFF8D74E1673A55A138BD62D0A518C938B5B9F9812C4F0C8E8C082A7691EF939AFB77F65FF00142F88FE165A5BB3EEB9D3256B49149C9C0E508F4186FF00C74D7C6BE23FF90D6A5FF5F32FFE846BE87FD8B7FD6F8B7E96DFCE4AFDF78BA8C71593FB49EF1B35F3FF00873F37C966E8662E11D9DD1F51A4AD16769E08C1079047A1159F79A2C578C5ED710CBD4C2C7E53F43DBE9575BA5317EF8AFE7A94635172CD5D7F5B1FA9C64E2F9A3A1CC4D0BDBC863911A375382AC306A3619535BFE2EFF8F9B4FF00AE5FD6B08FDD35E1D6A2A85774D3BD8F668CFDA53537D4FCF0F8E5BBE1D7ED2777A95B8C3417B6FA8A2E300FDD723F98AFD058678AEA18E686412432287475E8548C83F91AF82BF6D1FF0092D0FF00F5E10FF36AFB63C03FF24FFC35FF0060DB5FFD14B5FA97164555CAB2EC44BE2E5B7E07C964EFD9E658BA4B6BA6741CE7DA90AD3FF86A3AFCBA2CFB74271CE698D8A749DEA36AD11A21B54B54D62CB46B5FB4DFDDC3656F9DBE6CEE11724F4C938CD5DAF34F8FFF00F221DDFF00D774FE75E8E0E847115E14E5B498E4F956876361E28D2B5712FD8352B5BD118CB34132BAAFB707AF1FE35E17F13BE31E8BE24D20F8725D34EB3777172F6F3259C85BC8DA70926E0A477C8C138AC2F037FC8AB75FF5D67FE95CE7C21FF902F89FFDCFFDAAB5FA6E5D91E1F0D2A9886DB70B35D3F23C4C5E2E6D469457C5D77E863FC42FD96F52F0EE8EFAE6817536A8610AF2DA2461648F2B924633DFB0EC6B7BF665B5D4FF00E117F15FDB9EF7FB3E2114C2D82B067237160847CDD323008EA2BE8BD73FE45BD47FE01FFA292BCEFE01FF00C7D5FF00FBE7F98AE9FEDBC4E372E9D3C46AD4959F5DD1CB4F23C360B1B0C4506D269DD74D51F3EFC4DD07C01E218EEB55F085FDC69BA92EC3FD873C458C9904928413D17A83E95E656B6ABA3DD2CF346FE6DBBA3C96F22905867907A7047F3AF40F06FF00C96893FEBEAE3F93560C9FF2356ADFF5C65FFD05ABF44C1E2254A1EC1B725CB7D59F9E63B0B4EB55F6CA2A32E6B68BCF7DCAF67243E30F14DD5F092CF43690B4A3CE244018E0E323A64671DB8C77AE97C45E07D32FB4117DE12D75B53D42D50497BA5C31C98840E24746C6193383EB823D2B898BEF6ADFF5EDFF00B5D2BBFF00D9CFFE4717FF00B055CFFE8B6AD7195274A9FD620FE0E9D1FA86028C2BD58E1EA2BB9DFDED9AF4B18FE07D2B48D52F264F16EA72470456B23DA870C6233727633938524052319EB5DB2FC4BF05783EF2DAC6CF449E48B4F91E5B6D4EDA40FE7E4E41CB2E40CE3F2AE5BE3F7FC8C163FF005ECBFF00A00ACEF0AFFC83ECFF00EB837FE86D5C538C7194A35EADED2FB37B247A74653C0D59E1A8DB9A3F69ABB7F8943C69F12F5BF88DAB3CFA908EE65DA562686D95191339FE11938F53935CEE93A6AEADAA436926A1158AB363CEB80E42FB90AA4FE95D87C2FF00F91EAE3FEB9C9FFA0D72FA77FC8CEDFF005D2BE8A12850A2E14A3CA9474B1F23514F158853AF2E66E47D1DF077F67DB05D3DB54D6A14BCB84DF25ADC4523AC4CBCA8DCA406041E7A0AF2DF12788AE3C0335E5B685ADFFC4C6E26961BE10C031B73809B99707FFAF5F5AE83FF002275AFFD7BB7FE842BE37FF9ABD07FD842BE0B26C555C757C455C43BA8BDBA1FA5E6F83A596E0E84308B95C9DAFD7D4ED7E15F85ECF59D2D64D3DE11A8407CD9E7D5A265B362410D11392B9F7383E99AFA83C1FAFE9175656DA758EA3A75CDE5BC2AB2C1613AB842A003D0938071EB5F35F8FF00FE441B4FFB084DFF00A09AD7FD987FE430BFF5ED27F25AF3738C3FD7B0D3C54E4D59BB2FF827AD954D60EB53C3455EE95DFF00C03EA1A630A7D31ABF3147E86889BAF3C56178B3C61A3F82F4E37FAD5EA595B6EDA198331627B000139FC3B56F3D7867ED7FFF0024DF4FFF00B09A7FE80F5ECE55858637190A137A3679F98E26583C254C44378A3C73E2D78AAFF5EF165C5C69DAFAEA7A53B196D5C5C29D8AD8254A900A90463181D0515E42BFEA13FDE3FD28AFE87A1868D1A51A71D9687F3762730A988AD2AB2DE5AEE7FFD9, N'02_14_2019_11_13_25_15_3', N'T')
INSERT [dbo].[TRFoto] ([IdActividad], [IdFoto], [Fecha], [Foto], [NombreFoto], [FlgHabilitado]) VALUES (33, 2, CAST(N'2019-03-03 14:22:59.383' AS DateTime), 0xFFD8FFE000104A46494600010100000100010000FFDB0043000B08080808080B08080B100B090B10130E0B0B0E1316121213121216151113121213111515191A1B1A1915212124242121302F2F2F3036363636363636363636FFDB0043010C0B0B0C0D0C0F0D0D0F130E0E0E13140E0F0F0E141A12121412121A22181515151518221E201B1B1B201E2525222225252F2F2C2F2F36363636363636363636FFC0001108010C00B603012200021101031101FFC4001F0000010501010101010100000000000000000102030405060708090A0BFFC400B5100002010303020403050504040000017D01020300041105122131410613516107227114328191A1082342B1C11552D1F02433627282090A161718191A25262728292A3435363738393A434445464748494A535455565758595A636465666768696A737475767778797A838485868788898A92939495969798999AA2A3A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6D7D8D9DAE1E2E3E4E5E6E7E8E9EAF1F2F3F4F5F6F7F8F9FAFFC4001F0100030101010101010101010000000000000102030405060708090A0BFFC400B51100020102040403040705040400010277000102031104052131061241510761711322328108144291A1B1C109233352F0156272D10A162434E125F11718191A262728292A35363738393A434445464748494A535455565758595A636465666768696A737475767778797A82838485868788898A92939495969798999AA2A3A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6D7D8D9DAE2E3E4E5E6E7E8E9EAF2F3F4F5F6F7F8F9FAFFDA000C03010002110311003F00E23ECD641FE6B74C7A629E6C6CD882B6E8077E2AEDDC2B13052411DAA28250CC633C579B294D7DA7F7B134D3B0D8ED34F7601AD635C7FB229CF69605B64769171D4EDA996D9E461B18607534F92C5C7CC8FCF7A94E6F5E67F7B06DDB4299B2B2E9F668F3FEED3D34EB166C8B78F03A82B52B298C60F2D51090212DDFD29373FE697C9B126D132D86943E56B68B77FBB4874ED3B19FB2C78FF74506EE09136EC21FF2A37C862E9F2D4CA552DF135F3653602C74C75E2D6218EE145396C74A2A47D962DDEBB45323915B8CE08EB52131BA920E0AF7A952A8BEDCBE6D929BEE3534ED383736B1B0FA531ECB4C69008ED2303BFCB52C0CF1E4B7DD35316C1CC6BC56919CFF009A5F7B296A2AE99A4796336716EFF769A74DD2C1FF008F38BE9B454F0E49C93C7A54C914792D2F4ED57CD3B7C4FEF65AB14974CD2C7CCF69163FDDA91B4DD1F67CB67167D768A5B99230C634FBB4D883EDC678ED50A73BEB27F7B2ADE811697A53F1F638B3FEED5AFEC6D1B6FCD65103EBB4525AA966C29C30EA2B431B976B8E7B55C672EEFEF6528F923322D274939DF6517078F9453E5D1F4751C5945FF7C8AB8830B8F7A598702B54E5DDFDECA514BA2FB8C79748D2C8E2D6307D96AA1D1EC77710263E95B4C8C7B7E3519888EA2A2A4E4BABFBD8D59745F722847A4E9C07CD6B19FC28ABE0628A69CADF13FBD8ACBB222369672DBF9C64CC9D7AD64BC91ABE7A62A94733A2E0700549B1EE10BA0E9D6869B567F81C8E4DEE5D867C9F95B00F5A7B48449F2B9C7A564ACAD1B6C1F8D48D2B67E5EB51ECDA15D97259F126E2323B8A1278657185C1AA45E4EAD535BA0FF587A0A4E3641A9A334902A02546F1555AE37A75C0AA93CCCCF9ED49BF70C54AA7D586AF52DA41E672ADF377A779622E33F37434CB70F1AF99E9DBD6AC6C4950B83F311C7E34FF0021A572D5B2A491863C91D6AD2207190BC76A82CED49548D3EF4872C7D1456A5BC783E6F1E5AF09EF8EF529D9F91D31A7A1008030E9B4E2A1B8568C01D7D2AFBC735DB6635C007E66FF000A957467970CE78FEF1E294E49E9D06A949BD16860BA64E71CD2A649C2D742346831F34A09EC0542FA4ED6CA1E3B62A55BB9A3A2D14ED632CC1938615A6EA44796EBEB50A59CB0B1C023EB4E9A4923C238C835B4056B1020CE78EF5248100058F155A46901F94606691B2C99279AD4CDC98E6B8DC088D781DEA07937505CA8C018A8C56334EE8714F763A8A4A2B58AD0AD0E5A40BE470DC9A6219E08CED6C06E950202075A7CD33B2ED3D074AD396CEC710A6260A24DD927AD22CBB4F3D454D6B3C0B6E55C7CFCD562C8CE4AF7A76BE8C34E8590CD37CA3AD4CCE218BCB27E63D4D54B77DB283DAA69C8249F5ACDAD6CC691B7A65CD858C48F776E93B38E4C9D81EC0569DFE8961A85A35E695188AE5177F92A7E575C738F435CB5EA6FB78DFAA3015B1E18BF9ACDC5B4870A70D0B1FE558C94A31734EEEFAC5F63D1A6A124A9C92B5B46BB99F0286898B1DA4F041EC7A1A9EC63672C80EE29D067B56A6BFA534137F69C4336531CC807F039EA7E873542C60437A1EDCE09C06C1A574E1CDDFF003397D9B855E46BAE8FBA37C451C111E3E760071E83B7E34E44C6D04F1E9F4ED44EB929C1DB9C9FC2A272FD33CB74FA573CA6FA23B9415EEFB1785E246028C6476ED4D7BC127CD3CA42F655ACC7196E1C1C761D6AB3333377E2B3F79EACBBF6359AF6D81CA066F7E94F8B518B38208CF4E6B25411CEDCB76CD26F01F69E09EC7FA53498B98E8C4C9201CFE34CB888BA65793D4564453B2360FCA7D0D695B5D2F1BCF1DEB58CA51264A12F521DA7A38C1EE2A29A30391D6B55ADE265F394161D481FCC566DCCB6EE4790D900720F506BA61513D0C654F955EC509460D3053A56C9A4419E689EAD10870A29EA28AD16C23858CE7863C53A58C85DC0D34A01804F34E11B13B43706B67BDEE7215C31E9EB4F652A4639CD2C90B46793C539572463AD3BAB5C0745C73DEA42E1F96E3DE9E9E5C6A58F2DE955DE4CE4E3AF6A86AE069A059F4F2AA72509E29A2E91AD9149DB327DD3EE3A51A61436B70CCBCAE30DEFCD02055B149D972727F9D64D2D53EE7641BB26BB1D8E8DAC45736621BB198A45DB2AB773D38A8206D334D9D80432649F2D87381DB358161348613B4E083C0FC29CF79E5EE24B0907539C8C5737B36A6D2D9F437734E2A4D2BA5B9D30D42D26824546F9C8E3D47AD42582A924FCC460571AFA8396CA920F6229E9AADD13B18E4740D9A6F0AF712AE74C791BBF5A7C85768E46E02A92384B4F3C925B6E707A1ACA9B5A94123CBE3A7D29468B7A21CA76B799B6F751C083BB9C9A8C6A764CA43A379BFC248E07AD73EF7CF21C9C807A0FE94E594B9E00CD5FB0E55A91CFCCCDC5B8475DB23E327E46FAFA9A4875158A5F2652430FBAC47F3AC67924705003B54678E695DA4B8B7120E6588E18F723B50A9A6B51C9D99DB595F90705BE53D47AD32EED62491EE615C09396C7AFAD73B61732285DF91E87E95D04138963C31C82338F4A85EECBC8A69C96E6749D78A7C74D941490A9FCE90360026B46D3304AD745814540251455A981C7B4426FBB532E9F21192DFAD4103BC6C0A02D5A115C6F3B594AE7B9AD67292DB638AE539ED9D4045F9B1488171B08C3F6AD02833B81CFA5412DBEE3E62F0C2929DF46345165646F9873E94807504706A5293CAD8C73EB5660D3CFDF99F083AD5B9A4B52A316DE9A16ECAD8B69DB23525A562703DBE5157D34A91ACA382E65102AE738E4D2C9732DB5BA0B68F11851B7D6A2B737D740BCA9B13A863DEB8E7526EF2564AFBB3BE314AD1F22D476760B0F930BBB3A8FBE7009AE7AF7779DE5A93B7A0F5F4AE8A158A31FBD07EB9A8A3B4B7BCBA320C154FF0022A6955B36DDD953A69AB2D0E6A509100806E61D4FBFA529B6BD90234119955B014AA9C6E3C6DE7D3BD74CFE1BB09DF73CEE80F50A056AE9BA3DB59FFC8361C1EF2B9CFE59AE955E0A3B5DBEE66A8B6D6BA796E50934CBD5D204650B4C1012075F702B9726E96159AD999CE5D6E62DBFEAF69E33C7715E906D7521CA4C86B36FF4A826DCF75079723FDE9613804F23271C1EB59D2AB1836DABDFB7434AB4F9AD6D2DB1C18959F2A463D88EF4E89981E9D3B57427C2D66BF34772F8EBF301FD2A07D256CCF9A5B7806B4956A6F63254DDF52AD9B0DFC0F9B1D0D5A9638E1D93C63F76E712AFF5FCEA378D370963391ED534A41DABFC24E08FA8EBF8561CDEF2B5ECFA1AB5EE93BC2000C9C8C0AB36D214E3B7514AA9FE8EA3BED029AA99031F4A538DC94EC4F70A240241F787F2A895770C629EAD8057F0A5881A7144B5A8D101F4A2AD8E9456C92EC49C35B5C451C993C035A0B24720CA10D5976B0C458894135716DE1C86849523B1ABA8A3E670D8B8AA0AE7A540FB89C03CFA5590A55063AD42C32DC2F358A6C6208C22EE3C1352EC698610166E98A5DB9500D25D492470F97137979FBCC383F9D1BBB171DEECD9540D122EC04800167E991E829595A4E1E4E7BE3A7E1593A6477620C3CB95E4AEEFFEBD5D6728082D938EDC573D48B4ED7BA3D084AE93209977C822425B3C63E9566DA1642638F83D0D1A6C4584B79277F953F0EA6B4AD23DAA256FF592F118F6F5AB492453DEDDC96DEDE340649BEE275CF735389AF2EF8B64D910FE23C03F4A89B134AB174862E5FDCD5B1738C05E00EDDAA1B48B4BEEEE8AEF6BAA01F2CE0FB537ED5796BC5EC7BA23C6E1C8AB26E33DF1519B85706370307AD0A5DD0DAECCCCBAB595263750485ADE41F749FBA7D2B3A72EDF29FCAB58FF00A34BE4939826FBB9EC7D2A95DC58F9C763B5BFA1AD62EE6124643446270C3857E08EC0D5DB74590A87EBEBEE289A1DF6EE07DE0095FA8E95140D23468F18DCC7B7B8EB4A57DD14B55A9AFB7E523B63B536341B7D69B1CA4280DD7A53D58283FA56AB548C2F67618C0A9CD490E38A86571D01A7C4F8C0A9B7BC2B96F145304A3BD15AD985CE16DCC8241835A29927920D674419E41B7AF6AD61038DA5D47E14EAB4710E7E146791ED48A4161B0714F7C2E3774A2DF6127158F40BBB9211ED9AAB34A77E1D411DAAEB360567CDF3B63BE718AA8A56B95ADC9AD65925976F51DFD854F70E5D84317DE62003F5E2990A08231045CCAFF79BD0558B545FB5C61B9DA727F0E6B19BF78EFA2B45734DD162821B54E3185FF13560C91AB48CBF7615089F5EF5464973731807241FE429CCC7ECE83BCAD93F89A5D11A5FDE6598DD962181F3BF3F9D58F2940F99F2DDFDAAAEE1E66ECF08300562C5AC4EFAC8849FDC39D9B7D3DE85172BF2EB657D41CAD6BF53A068598E03605452DBBA0DF1B6E22A1D4EEDAD2C24993EF630BF53C0AA5A16A535D472453B6E74239F6349293873F45A31B6B9D42FAB2FC999ADCF3F32F23D88A648DE6A2B7691369FAF514060B2320E87B542AC7C951DD1C0FD48A49F614BF2196ED98F2793D0D4366BE548EBD023E573EF4FB761C8ED93FCE9858ACEFB7A1E9F9536C4B4468CC9E602EB8551C8AAFF00381C8E3D69D6CE25288E4F1C11EB572E91C958E350171D6BAA96B1396A3B49998D9CD4899ED43C4C1B6E72452C60E7E6E3152F49026AC3F2D4529383C515AA698ACCE43CA65E9C1F515A164CE7E4965C11D33FE34C6400F2323D2A7B658C9DA46E53C62AE514F46274E36D0B12C41972DC8F5A82DD7631C5694569246A4C03008E55B9155E6B675E42153FC583919F5150E8492D1DFC8C6507D08E4946091DBA9AA23265DD53BBAAE55CE0D4195E7E61ED51CAD2D8127A685B859620777CCEDD49FE9532C856657E959CB200EA339E6B56387CC8DB8F998707D2B9E71B3BB3BA8B6D6C412DCED9C49FDDEBF8D684AE316D83C614FE75CEDD33C7BA393823233EB4B06A13C712A4D1B7969FEAE422B4F657826995CD67B1D3AB8DE73D3BD67AE94535517C31E48CB01FED631496D7D1DC00CA7E6FE253EB5784B95C1E9E95CFCD3A6DA5D747734B2959BE825FC46EECE5817972B941EE39154741B496DC4D25C2946621403D78ABEB27CC083D29ED2772692ABCB070EFA8DC139A9F5446EC04C58F403F4AA6270B13B13800E6997B7A91B18C302E7AFB5664F7A8EA215E3072C6B5A54DB48CA52D5D8BF15C2AA73D0D219FE756E0FAE7AD518B7363A85EA3E956D543004FDD1DE9CA2A2FB8FA16A0B950F82C0648E7D2B523B80C7E67DC31DB9AE6674F2891D467355C5CBC4D9462A7D456D08E9A3309C2E758F0B63CC8FA9F5A708F230786EF5CF43AFDE4640971228FC0D6ADB6BB6370712318A4F46FE86A9A7D7F033E5922F0B73EB454F6C8AEBBD640CA7B83450921F377398BB84C53BA0F5E9525827EF5587183C8352EA5343230954825D4138EC7B8354E2B808DB811915D0DADC35B1DA08627841E808E7D2B3DE1C02AA4E33D473542CF5F985BBC134390784753FCC1AB7A5DDDACCA56E2509203D09C53538B76B90D956E6CE36CB6013EA4563CF122B7519AEAAE214746DAE0E7A735CDDDC250952323D69BB5BB8E232CA0324B86E5579CD7411F93145972173C281C93F4158F6AE426EC6D51DAA6131CF98E727B7D2BCEC4EB2B1D74DD916A4B2B776135CAE4F58E33DBEB560DB45711849546CEC3F95672DC991C293C55C4B907EEFE26B9DCA4ADE468ACCC3B9B26B49FCD8860A9E9EDEF5622BD5751CE0F75F4AD2995651D324F5AC7BAB0653BE33C9F4AD54954569EFDC5AAD8B8260075AAF717E23538396FE15EF548DBDC053F33607353C1A697C492B6491B969AA708EADDEDD01B6D59682E9B08964F3675CBB1EF572FAC20575936019E86A7B6806DC775E054B743CC88A375038A8751B968ECBB2172A4AC65496ED1B018A9A21C10476A7A65E3DADC9E80FA7B53E352579EA2AB564B2ACA839523711D2ADC3A7D85DC206CD9274C83DEAA5CA32E7AFCDD07A5654A6656382CBF426BA29C7677307177D1D8BBA8E94964030941CF45CF359E517039CD466562D9762C7DCE7F9D3B7035BEE57BC96BA8F492584931C8C99F4245151939A28E541F22E5E90B2653942322AA34B91C2D4EE0BAA83EF8AAAE857AD11D898B4D1A316F68A375E4639A7A056C93C35334E25EDCE7F84E055A11FB5632DCC6AC6D2BAEA22964E55D80F4CD3657620167247BD39976FCC4F4AAB3CC0FDDA7AAEA4C652BD916A19030DABF88F6A573B8E17EE8ED4CB54F9437F11E73561930BC5613DCEBA6DDB5DCAE8E43E7353453E1300F5E2A06E29615CB6F3D074152D26B5364CBF14A543487A7414D797763D4F4A0636007FCFAD55924F9B2BF8566A3A8EE5D75508C3BEDA483FD483FDDE00F634CF3372A8FEF21E6A3866C4633D8E29A4C5727F3B6395F7A592E3907AA9EB9AA933E642475C66A132F0467A76A6A02BE84EB37932946FB84E6AF46CAEC31DFA11FD6B2CE5C2B8FC6A781990A9519C1F980FE95693BA25BBA34FCB19CED07D6A64B785B968D483EA2962314A9E6439DBD1D7B83DF3532295FBDF77B57553928F439E49B7B99B75A6D8BB730ED07BA8AA33F876229E645291DC022BA955871F3726A030A6E380715A369EAB415A4BA9C6B68F740E106E03D28AEB5EDC31CA8C51517907B497638C6DE00DC31CD472026B6353855506060E6B35971DB9AAA6EE54745626D398245267B1C9FC6AD24C1CF150E9B1077789BEEBE2B55F4971F2C440C77AC669F33B7526AC24ECD150C0D28219B14C9348531F9A8F9C7515717489F70CC9815A96F65088CC73375E3359B8D5BDEFA762234E499CFC484000741572D2DDAE661193F28C16C7E82B5BFB32D5B02DF39EFE95712DE1B487CA43866FBCCBD493C0C9F61CD68A9B6F5355CCB73969E2512C833EB8A8410385AD7B9B749AEDA2814E18163DF0ABC76CF5ACC9E03148500FBB533A6F6B1A46431E5DA768EC39AA8262F291FC0B4B2C73152E0139E4D521361FAF1DE88D3D0AE6D4D6593280F753D3DA99BB31B01D8E7F2AAEAE402C39C8CE0549191B8FF0075AA79077159CB3061D7183516E2CC38F6348182925BA8E0D58B1B0BABE902C2842939DFDB154A0C2FA0FB781E43B2319E6B66D6CD45BB4C0708859877C8AD0B4D216084201F3819DDEF532C4ABA749230C3052B8F524E315AC295B56672976295BDB89633341F2395DF8ECC3B8ABB05BAC8BBB3CF71E9505A7EE888CE4052C00C76E1862AD47208DCB7561F787AF6E6B571E8884FB932D98A78B351D6AC457304839041A90496FF00DE152D58BD2C523641A8AB52DCDBC670083454F30AC8E1355DC6052460EE1594C0835B5AB6EFB27CDD98567242D29558C658F4AA868AEC3762D80FDF93F97D6BA089EF267F2E24DCDE83FAD53B6D35202923B65C6723B7E75A7149B2338E00656EB8CED3900E2B09D5A6E5BFDC69C92B17EDF4B38DD773FCC3831C433CF7524F715398EC224C2C6777B9CFF3AAC260C9B8E72DD1471EF4F3854DCC47BFF3FD2B78C53575F898CA4D683DA645627808A39C0EA07355659DA566CAED03A0F73D7F21C548E3F778520BB6085F51F79BF215039C907A7F10F4E6AD225B958B5A144B25D5DB700EC4519192012491CFD2AA5EE9B189A56FBD93C71D2AEE8D832DDEDC2B6D4CE0FA13FE3571A067CB1191F4A1AB8D339D8F4F55C291C751597ACE84A57ED16C9893F8D477F7C5766F6E0F18C62ABDD5BE118F4E3049F4EE68B20B9E64ACD1B04EFD0FF854AD2B65555496CF0ABD4FA6056EDC585B4F23B7965429F9400771F7A93467D36DAF95648CA33702490636B1FAFAD62F92FBA2D376D99158E8335CB2CB763CA53C88BBFE35D669F64B6E4055C051802AE0B20083EBC8FC6ACA41E5F35AC6296C4B911AC642100671CD62EA85C2C76AA42991B7E31D87D2BA2791509EDC572DAACFE7DE305E5625080FA1EA6AC89308A397CCCF1FC2C4825783F21E0E6AC98DD1F2E8719196FD0F23DC0ACF86556C2347C6D2A0A0273FC409008EE2AF0955D1582C8B900B707186E09E49E84544AE9A2D3BC498632195883CF073C7E9532DBA5CAEE76C05E091C633DEAB89DB3CB499EE31D194E0F51F8D3D2F06E048CA91CAE719FAE286EE24F5229F4DB9047927CC5FCB1E945586B86EA8768EC324F1FA5153ECD3D4BBD8E4F5221EDC22E59DD8051EF53DBC62D6308EA3CCFE323B7B56A6FB6B7059503CA38563D3F0AC79A6DACF8E588381D79AE6AD356B45EAFB1AC23695EC3FED059CE3F2F5A63DD4B9653C0FF3C5575690A3395C63F4A803E4927F5AC143BEE53933A4B09E26B54691C06C9C86207E15677C7232A863B5B8CED620EEC9382703A0AA7A2B04B169252AA18E573C9C74CE01CD589AE565DCB3B7C8C7385E3007DD71E98AEFA4DF224734EDCCEC586DB386463B1D0EF8D97A8F4917FA8A8198C81C9189636F2E703901FAFC9EA18739A2269245C71E7A1EA38DED8C800768DC77A924F2902DE005DD97CB745EA63CF2AA3B18CF7F4A6DB8BFF205DFA13E88C12FFCA7C0332322E385CAFCC00F535B8FC8C118C76AE4DA59619E3B94DA6489831939DA40ED181EABDEBADDF0CC91DC06C453A87523DC66B44BA8B42020715CF6B7A8442E56C564C3280F2E3AF3F756BA191D622E4FDC51B87B815CA5E68ED751C9740E2F25632AB1EBFEEFE55338F345A4EC2BD9A7D0CD79654958B164DE7386E09FCE9B3CD0CECB1BA6C6FE2DC396FA1C52DB14966925D4159D930A62DC460E70481ED8A9EF2DFCA930885ADD806898F2483CF15CBECE2B4968FB9D1ED5BB3B269763A6F0D5DB4D65F629DCBC9167CB63C9280E31F856AE2662420CD7216328B2BBB2BC8C32AAEE132939186C29FF001AED5E64857721C93C8C7BD7451BDACCCAAB4E574AD72BB44444CF3FCAEA091EF8AE419D59DA50400EC70C3953CF43E86BA9D56F1FEC12485725B08807524F5AE682A49F327CAE0E3A707DA41FD6B5BD96C656BB1876A6E2FC05196E7B7B7F4A9137242AAE02AB02A547F0EEE5467B914C48F74E2345252239642792FD711B7755EB8A7AB2C9BA72D98541DADDC0FE26607B9E82949A7A7E255DFA09E6EE52C3F886E39FEF2F0C3F11CD279CD95DBC7B67B544038546C0059F7141FC21B8DBCF52075A1379C851F30E327A0A7A588BB65BF325C0C367E94555F3522E659304FA1C514AE9685AB8D2818E1CE452078E3385519FA7354BED4EC4F38C0C96A4F3D7CAF35F863F741FE75E4D9DB6D4EE762F4B32F967CC1C7A01D6B2EE115E7448B846E99A4FB47CA70482DC8C67F2A5B6CCD21C1DB8E32065B9F415AD34EEAE6526692470A362150AD801DB1966C71C0A95107F0FF0F51DBEAC7A67DAA28621B70C70BE99E7FE04D532CEA31B72BC7CBEA71D957FAD7A11DAC8E5EB7658120B61E780649117137AB439CE5BD361E40F4A99DD0B0995B74331019D78DCC47CA53D2361C1AAA8C321B8253E658C9C824F5DE7F88FB52C52A03E4BF11C80F903B81D5A2FC0F2B49C7CB51B77D8261E5E21C61067C8C765FE28BF0EA2B5FC397425B392CA53BBECE498C7FB279039F4AC9E65578643FBC5C1593E9F7641F4E869FA7CAD6DA8A48C3F78C4C57083A6E2320FD1BB55290CE82F76C91A40B82643C907A28EB513A8C02B8F948C7F85287124CCDB0AA636A29F4EFF009D04AC48C5C8551C93E83AD3FC8939ED5AC638A74BB5214C8C5245F5239C8A8AD7528C2F917983683F7639C95E7EF54B79325E4B2DDEDC45CC5003DFDC0F5AA36D1D858C32C5768A6E22FDEC7BF90DBC7DDC7AD71CEA4652B25B75368C5A49DFE46AC3611C771343E609229141423B7A56D5A926189A43B8AFC981D7E5E326B95D26648AE19013B1FA06ED9E46D0DCE3B715D2C53DBC6AD24C85F8DF181D9870738ADA8BF749A89A97AA2AF882E5659A3B100148479926383B8FDD00F63595BDD4A9463E630C4736395C756957B81D8D36494CD2CB7329FBC4B337A0E981EE7B53E2F915AE1D76CCD8017D17F86303F535B368CD69F327C23225991B401C807F84F2591BD5CD4177932151B9A38B0599387DC3EE46CBD085EA69CCAD1464290669493E5B7DD2FDD94FF0851D3DEA0598C6A02EE2133B55CE24C9EAD9FE2CD6766B55F731DEFA3FBC6B487EF4A783C974E413EEBD454332DCCB17EE5F08C724A9C1C7B122AC7C8FF3A9F9C7523823FDE5EF5118DA1F995802FF00F7C37E1D8D68992DEBE4450E9B6EB96741BCF56791989FC68AB48C665C07F2197EF2BE0FE5ED454BBF915A230921B88CB6D70D9ED8A8244B97932FDFA0EC2B4595A28B7AB0627B761E95111E69DAC4072338AF394DF63ADA2B2DB4A5B0661D38C0C8AB76F10B440C8C5A4CFDD1D5C775C7D39A72E30B11030BDC77A0B953F28251816247DE0071C5694E4E52B5B422A6912732B372086230D9EA8A3DFD5A9EAF82CDB8E4FDE73D4FD3D0554DC23C14C085B071D949EF8F46FD295F702416F623D2BB9591CBB977CE030A3EE1FE7D8D3C0DEA46EE720893FB8C3A35500DD33F8D4EB700FC83803A9F5A1F9045DB734125678CA8F96E222738E99EE07FB2E29B2B9644BB809DC830E9DCA839C1FF00690D40AE14AC8AA5DD14023BB20F4F75EA2ADA9DA0CC08F25B0D2487A0CF493F1E8454DADB14D9B504925CC497280956032C3A565F886FDA1852D9066498E71EC3FC6AFE80C40961462230DB911BA107A951E9E9589AE5E06BA95D48DA8760E01E1464E29549A51BF7D3E60936CAA8D7720589B2AC00C0C636F7E292265F9E6785A690123CC71FC238C8F5A8D67BA8E15BC56DCFC060DCE73FE02AD417904918995B3221CBA30E063B7A60D70CE575A2B5B73A631B6AF5269E789AD92484676904B1186C8EC3D056C89E2164675C6D64DC07D4702B06EA5596DD6E1CECF31B289C639E4E7E94A6F2592C60B645D92C848523A6D5FE21F4AE8C2BD3531ACEF2B9241B5CE38DB19E7D1A4EA73ECBFCE9EADF31998E23504AFB0EEE7DCF6A66D4555B68C6020F9C7A2FA7D58D23B348FB36EE48C8DE3B17E8ABCF615BBF533F4177F9997933961F2A1FE14EC3EA7A9A89D95B861BBD01ED8F43DA895D0311248A0F56E79E7E9548EA962876C8FCF738FD2A94A2F6681A7D8BA171CB13201DFF00E5A2FF00F142A5475906E700A9E15BF858F4C11D8D5482E619CFFA3481BD79F9B9F406AC46B3493476F6CBFE95365235FE123BB30EC7D0D126ADFA8E2B5DBE42C965E7FEED586C43F36EFEF7A29EE00A2BA5B5D1B4DB58C47A8DCBAB0036C3160843DC6E20E7279345734B1166D234F6479935DDD45F2153C8EFE948B740FCCD90456898D366253B5DB1B011FD6A331264B85F9573F30FE959F347F97EE377CC244FF6951E592509DA64E98C7514497462652AA764630DEB807048FA1A7A13800AED423923D69B2C624D908D8BF2C9827392783574B9399AEBD0C6AF35B7D0B0768412260C12753D813DFE8699CC4C237C9047C98EE3AED3EA476AA563786D256B79BE6858E14638527EBDAAEB46558C321C83CC4FE9DF00FB76ADB5DBF1315E826F2EC0E703B7F8D4A87CC054F0E3AE2A2078C300AF9C3E3B93D08F66A72B9DFB472C3AC638E3FDA35AA5A1327D8BD09FBAC58AED230475CFA01DF356A27C482192306391BE4833F2A31EA243E8DD85548017F9C1F9BA6F3D17D907F5AB4A5154C454BEE1F30F5C74663EA3AD2976EA5475DCB692358CC8E642490446EDC6579F900FF64D61CF12C07CF9250DE686DBCE464F5E95A4E5EE6192367CCC9D6E187DEFEEB4407E46B9B1B943071920FCCA7A839E6B19C3992BBDB73484DA6ECBD0B8A50AB2799B95B69C282795E3BF6A94AADB40C523696470331B0DBC7AFD2A0B69DAD63F3E00A19CEDCB72547720D5D86792668E5790CBBD4F5F6ED5CCF4F348D9C93495BDEEFD0A2229E74549B74EE012918E807A0AB3A7A32E5A4058C4A57C93C104F3F21FE7579E47925F3CE1080028F4038A4670013C6719AAF6C96CB423D96F7776391C46320EF918EE663FDEFF00EB5412B67EFB9607B741FA544D39C55596639C0EB52E7393DEC546115D0B2F2C0A718049EB9155E4B7825CB2A28279A6ADBBC803C9F8015388FCB1F31C8A9BB5B37729A33E5B58C2FCBF230E432F1FAD74FE09FB5182EAFAEDFCD31E21B763F7867E663BBAF4C0AE7E6C10154E735D7F872211E82BB7EF34B231FCC0FE9552A92506AFB8462AF7B6C82E4CB339D84391F7973820FBD15CDEA571796BAA5C4D6B218D9F0AC0742074E28AD29A828ABABBEE632526DB33BCC67DB12E791CF7C1F5A3CC639F9890A368FA565FDBA6CE70A0FE3FE349F6E9B206171F8FF8D1EC9F91AFB45E66A24C772A0FCFB0A912E312229DC5C6F236807E52BD79AC77BD94280028F7E7FC6952E583A36D04E1BFBDE9ECC2B5A74ADAE8635677D0BBA865A46902BFCC40C903D00ABBA74FF6A87ECCFF00EBA3E62CF5C0FE7B4FE958D3DCE636FDDA649073F37B7AB5352FA54C3C6AA8CAD9CA820F6041E7A1ADF94C533A1DAD27EF130B2A655CFAFAA2AFBF5069561070573B7EF60FDE61DF79F6E845670D5AE04E1C24618823A1E31C8C0DD436B175E6C89B230A30FB707193D73F377A9B363D3735E39D40C28C0FEF7527D9053B7907691843CF979C93EECDFD2B106AF720F9815377AE0F03D07CDC53BFB5EE00E123FC8F7FF815696B08DEF30BED65F9665CF94C7A73D50FB1ACB95A18EEDA5953746FF7E1390CA7BF7AACBABDCEEFB91F23D0FF00F1555EE6FE59E6864744DCDC360119C7193F356752178B45C1DA49EA698917ED1E5430FF00A2F439E793525B4BE4868C0F96263B7D769E40AE765BD9BED5C636A365579C0FD735606A7722EDB01406186500E0E3F1AE695176DD6C6AE6B9B6D99B735FEF2708547BFF008521BAC8193D47F9ED58326A13B9CB05FD7FC698D7F371C2FE5FFD7A9541B5D0A7511B324C463DEACC312A8124833FECFF008D7362FE72C010A47B83FE357CEAB707E5DA98FA1FFE2A94A9492B26814D599B45C03C103DAAB4CECC4A28258D66FF00694C01C227E47FF8AA58F549D533B1327BE1BFF8AA854E5DD0F9D1A50DB941994E5BB28ED5D87877F7DA3488BFF2C2660E3D03FCC3FAD79E7F6B5CF5DA9F91FF00E2AB53C3DE22BEB1BD992258DA39E33E62386232A7E5230C3919A52A726B7435512EFA97F57802DF49B863761867D28AAFAD6B53DD796EF0C2AC3232AAD9FC72C68A6A33B7421CD1FFD9, N'03_03_2019_14_22_46_15_3', N'T')
SET IDENTITY_INSERT [dbo].[TRFoto] OFF
ALTER TABLE [dbo].[CFMenu]  WITH NOCHECK ADD  CONSTRAINT [FK_CFMenu_CFEtiqueta] FOREIGN KEY([IdEtiqueta])
REFERENCES [dbo].[CFEtiqueta] ([IdEtiqueta])
GO
ALTER TABLE [dbo].[CFMenu] CHECK CONSTRAINT [FK_CFMenu_CFEtiqueta]
GO
ALTER TABLE [dbo].[CFMenu]  WITH NOCHECK ADD  CONSTRAINT [FK_CFMenu_CFMenu] FOREIGN KEY([IdMenuPadre])
REFERENCES [dbo].[CFMenu] ([IdMenu])
GO
ALTER TABLE [dbo].[CFMenu] CHECK CONSTRAINT [FK_CFMenu_CFMenu]
GO
ALTER TABLE [dbo].[CFValorEtiqueta]  WITH CHECK ADD  CONSTRAINT [FK_CFIdioma_CFEtiqueta] FOREIGN KEY([IdEtiqueta])
REFERENCES [dbo].[CFEtiqueta] ([IdEtiqueta])
GO
ALTER TABLE [dbo].[CFValorEtiqueta] CHECK CONSTRAINT [FK_CFIdioma_CFEtiqueta]
GO
ALTER TABLE [dbo].[CFValorEtiqueta]  WITH CHECK ADD  CONSTRAINT [FK_CFIdioma_CFPais] FOREIGN KEY([IdPais])
REFERENCES [dbo].[CFPais] ([IdPais])
GO
ALTER TABLE [dbo].[CFValorEtiqueta] CHECK CONSTRAINT [FK_CFIdioma_CFPais]
GO
ALTER TABLE [dbo].[GRCliente]  WITH CHECK ADD FOREIGN KEY([IdCanal])
REFERENCES [dbo].[GRCanal] ([IdCanal])
GO
ALTER TABLE [dbo].[GRClienteZona]  WITH CHECK ADD  CONSTRAINT [FK_GRClienteZona_GRCliente] FOREIGN KEY([idCliente])
REFERENCES [dbo].[GRCliente] ([CLI_PK])
GO
ALTER TABLE [dbo].[GRClienteZona] CHECK CONSTRAINT [FK_GRClienteZona_GRCliente]
GO
ALTER TABLE [dbo].[GRClienteZona]  WITH CHECK ADD  CONSTRAINT [FK_GRClienteZona_GRZona] FOREIGN KEY([idZona])
REFERENCES [dbo].[GRZona] ([IdZona])
GO
ALTER TABLE [dbo].[GRClienteZona] CHECK CONSTRAINT [FK_GRClienteZona_GRZona]
GO
ALTER TABLE [dbo].[GRContacto]  WITH CHECK ADD  CONSTRAINT [FK_GRContacto_GRCliente] FOREIGN KEY([IdCliente])
REFERENCES [dbo].[GRCliente] ([CLI_PK])
GO
ALTER TABLE [dbo].[GRContacto] CHECK CONSTRAINT [FK_GRContacto_GRCliente]
GO
ALTER TABLE [dbo].[GRContacto]  WITH CHECK ADD  CONSTRAINT [FK_GRContacto_GRZona1] FOREIGN KEY([IdZona])
REFERENCES [dbo].[GRZona] ([IdZona])
GO
ALTER TABLE [dbo].[GRContacto] CHECK CONSTRAINT [FK_GRContacto_GRZona1]
GO
ALTER TABLE [dbo].[GREtapaDetalle]  WITH CHECK ADD  CONSTRAINT [FK_GREtapaDetalle_Etapa] FOREIGN KEY([IdEtapa])
REFERENCES [dbo].[GREtapa] ([IdEtapa])
GO
ALTER TABLE [dbo].[GREtapaDetalle] CHECK CONSTRAINT [FK_GREtapaDetalle_Etapa]
GO
ALTER TABLE [dbo].[GREtapaDetalle]  WITH CHECK ADD  CONSTRAINT [FK_GREtapaDetalle_TipoControl] FOREIGN KEY([IdTipoControl])
REFERENCES [dbo].[CFTipoControl] ([Id])
GO
ALTER TABLE [dbo].[GREtapaDetalle] CHECK CONSTRAINT [FK_GREtapaDetalle_TipoControl]
GO
ALTER TABLE [dbo].[GREtapaDetallePerfilModifica]  WITH CHECK ADD  CONSTRAINT [FKDetallePerfilModifica_EtapaDetalle] FOREIGN KEY([IdEtapa], [IdEtapaDetalle])
REFERENCES [dbo].[GREtapaDetalle] ([IdEtapa], [IdEtapaDetalle])
GO
ALTER TABLE [dbo].[GREtapaDetallePerfilModifica] CHECK CONSTRAINT [FKDetallePerfilModifica_EtapaDetalle]
GO
ALTER TABLE [dbo].[GREtapaDetallePerfilModifica]  WITH CHECK ADD  CONSTRAINT [FKDetallePerfilModifica_Perfil] FOREIGN KEY([IdPerfilModifica])
REFERENCES [dbo].[GRPerfil] ([IdPerfil])
GO
ALTER TABLE [dbo].[GREtapaDetallePerfilModifica] CHECK CONSTRAINT [FKDetallePerfilModifica_Perfil]
GO
ALTER TABLE [dbo].[GRGrupoUsuario]  WITH CHECK ADD  CONSTRAINT [FKGrupoUsuario_UsuarioCoordinador] FOREIGN KEY([IdUsuarioCoordinador])
REFERENCES [dbo].[GRUsuario] ([IdUsuario])
GO
ALTER TABLE [dbo].[GRGrupoUsuario] CHECK CONSTRAINT [FKGrupoUsuario_UsuarioCoordinador]
GO
ALTER TABLE [dbo].[GRGrupoUsuario]  WITH CHECK ADD  CONSTRAINT [FKGrupoUsuario_UsuarioVendedor] FOREIGN KEY([IdUsuarioVendedor])
REFERENCES [dbo].[GRUsuario] ([IdUsuario])
GO
ALTER TABLE [dbo].[GRGrupoUsuario] CHECK CONSTRAINT [FKGrupoUsuario_UsuarioVendedor]
GO
ALTER TABLE [dbo].[GRPerfilMenu]  WITH CHECK ADD  CONSTRAINT [FK_GRPerfilMenu_CFMenu] FOREIGN KEY([IdMenu])
REFERENCES [dbo].[CFMenu] ([IdMenu])
GO
ALTER TABLE [dbo].[GRPerfilMenu] CHECK CONSTRAINT [FK_GRPerfilMenu_CFMenu]
GO
ALTER TABLE [dbo].[GRSubTipoActividad]  WITH CHECK ADD FOREIGN KEY([IDTipoActividad])
REFERENCES [dbo].[GRTipoActividad] ([id])
GO
ALTER TABLE [dbo].[GRSubTipoActividad_Detalle]  WITH CHECK ADD  CONSTRAINT [FKGRConfiguracionOportunidad_Detalle_ConfigOportunidad] FOREIGN KEY([IDSubTipoActividad])
REFERENCES [dbo].[GRSubTipoActividad] ([IDSubTipoActividad])
GO
ALTER TABLE [dbo].[GRSubTipoActividad_Detalle] CHECK CONSTRAINT [FKGRConfiguracionOportunidad_Detalle_ConfigOportunidad]
GO
ALTER TABLE [dbo].[GRSubTipoActividad_Detalle_PerfilModifica]  WITH CHECK ADD  CONSTRAINT [FKConfiguracionOportunidad_Detalle_PerfilModifica_ConfigOp_Detalle] FOREIGN KEY([IDSubTipoActividad], [IdSubTipoActividadDetalle])
REFERENCES [dbo].[GRSubTipoActividad_Detalle] ([IDSubTipoActividad], [IdSubTipoActividadDetalle])
GO
ALTER TABLE [dbo].[GRSubTipoActividad_Detalle_PerfilModifica] CHECK CONSTRAINT [FKConfiguracionOportunidad_Detalle_PerfilModifica_ConfigOp_Detalle]
GO
ALTER TABLE [dbo].[GRSubTipoActividad_Detalle_PerfilModifica]  WITH CHECK ADD  CONSTRAINT [FKConfiguracionOportunidad_Detalle_PerfilModifica_Perfil] FOREIGN KEY([IdPerfil])
REFERENCES [dbo].[GRPerfil] ([IdPerfil])
GO
ALTER TABLE [dbo].[GRSubTipoActividad_Detalle_PerfilModifica] CHECK CONSTRAINT [FKConfiguracionOportunidad_Detalle_PerfilModifica_Perfil]
GO
ALTER TABLE [dbo].[GRTipoActividad]  WITH CHECK ADD FOREIGN KEY([IdCanal])
REFERENCES [dbo].[GRCanal] ([IdCanal])
GO
ALTER TABLE [dbo].[GRUsuario]  WITH CHECK ADD FOREIGN KEY([IdCanal])
REFERENCES [dbo].[GRCanal] ([IdCanal])
GO
ALTER TABLE [dbo].[GRUsuario]  WITH CHECK ADD FOREIGN KEY([IdPerfil])
REFERENCES [dbo].[GRPerfil] ([IdPerfil])
GO
ALTER TABLE [dbo].[GRUsuario]  WITH CHECK ADD FOREIGN KEY([IdZona])
REFERENCES [dbo].[GRZona] ([IdZona])
GO
ALTER TABLE [dbo].[TRActividadDetalleControl]  WITH CHECK ADD  CONSTRAINT [FK_ActividadDetalleControl_Actividad] FOREIGN KEY([IdActividad])
REFERENCES [dbo].[GRActividad] ([IdActividad])
GO
ALTER TABLE [dbo].[TRActividadDetalleControl] CHECK CONSTRAINT [FK_ActividadDetalleControl_Actividad]
GO
ALTER TABLE [dbo].[TREtapaDetalleControl]  WITH CHECK ADD  CONSTRAINT [FKIdOportunidad_GREtapa] FOREIGN KEY([IdEtapa])
REFERENCES [dbo].[GREtapa] ([IdEtapa])
GO
ALTER TABLE [dbo].[TREtapaDetalleControl] CHECK CONSTRAINT [FKIdOportunidad_GREtapa]
GO
ALTER TABLE [dbo].[TREtapaDetalleControl]  WITH CHECK ADD  CONSTRAINT [FKIdOportunidad_GROportunidad] FOREIGN KEY([IdOportunidad])
REFERENCES [dbo].[GRActividad] ([IdActividad])
GO
ALTER TABLE [dbo].[TREtapaDetalleControl] CHECK CONSTRAINT [FKIdOportunidad_GROportunidad]
GO
ALTER TABLE [dbo].[TROportunidadEtapa]  WITH CHECK ADD  CONSTRAINT [TROportunidadEtapa_Etapa] FOREIGN KEY([IdEtapa])
REFERENCES [dbo].[GREtapa] ([IdEtapa])
GO
ALTER TABLE [dbo].[TROportunidadEtapa] CHECK CONSTRAINT [TROportunidadEtapa_Etapa]
GO
ALTER TABLE [dbo].[TROportunidadEtapa]  WITH CHECK ADD  CONSTRAINT [TROportunidadEtapa_Oportunidad] FOREIGN KEY([IdOportunidad])
REFERENCES [dbo].[GRActividad] ([IdActividad])
GO
ALTER TABLE [dbo].[TROportunidadEtapa] CHECK CONSTRAINT [TROportunidadEtapa_Oportunidad]
GO
/****** Object:  StoredProcedure [dbo].[SP_InsREGISTRA_FOTO]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SP_InsREGISTRA_FOTO]          
(
	 @IdActividad varchar(100)
	,@IdFoto varchar(100)
	,@FOTO IMAGE
)
AS
BEGIN
	INSERT INTO TRFoto (IdActividad,Fecha,Foto,FlgHabilitado,NombreFoto	)
	VALUES ( @IdActividad,GETDATE(),@Foto,'T',@IdFoto)
END








GO
/****** Object:  StoredProcedure [dbo].[SP_RepGraficoDashboardActividad]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_RepGraficoDashboardActividad]--SP_SelGrOportunidadEtapaBand ''
    (
      @IdUsuario VARCHAR(10) = ''
    )
AS -- [SP_RepGraficoDashboardActvidad] ''
    BEGIN      
        SELECT  ta.id AS codigo ,
                ta.nombre ,
                ISNULL(T.total, 0) total ,
                ta.meta ,
                ta.IdCanal
        INTO    #tmpGrafico
        FROM    dbo.GRTipoActividad ta
                LEFT JOIN ( SELECT  COUNT(A.IdActividad) AS total ,
                                    GR.IDTipoActividad
                            FROM    GRActividad A
                                    INNER JOIN dbo.GRSubTipoActividad GR ON GR.IDSubTipoActividad = A.IdConfiguracionActividad
                            WHERE   CAST(A.FechaCreacion AS DATE) = CAST(GETDATE() AS DATE)
                                    AND ( @IdUsuario = ''
                                          OR A.IdUsuarioResponsable = @IdUsuario
                                        )
                            GROUP BY GR.IDTipoActividad
                          ) AS T ON T.IDTipoActividad = ta.id;	
        SELECT DISTINCT
                g.codigo ,
                g.*
        FROM    #tmpGrafico g
                LEFT JOIN dbo.GRUsuario u ON u.IdCanal = g.IdCanal
        WHERE   @IdUsuario = ''
                OR u.IdUsuario = @IdUsuario;
        DROP TABLE #tmpGrafico;
    END;






GO
/****** Object:  StoredProcedure [dbo].[SP_SelUpdOportunidadCerrarBand]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_SelUpdOportunidadCerrarBand]--SP_SelUpdOportunidadCerrarBand '8'
(
	@idoportunidad varchar(20),
	@flag varchar(1)
)
as
begin
	update GROportunidad 
		set IDEstadoActual='3' 
	where IdOportunidad=@idoportunidad
	
	update TROportunidadEtapa
		set IdEstado='3'
	where IdOportunidad=@idoportunidad
end










GO
/****** Object:  StoredProcedure [dbo].[SP_SelUpdOportunidadEliminarBand]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_SelUpdOportunidadEliminarBand]--SP_SelUpdOportunidadEliminarBand '8'
(
	@idoportunidad varchar(20),
	@flag varchar(1)
)
as
begin
	
	if exists(select * from TROportunidadEtapa where IdOportunidad=@idoportunidad and IdEtapa not in (select IdEtapa from GREtapa where isnull(EtapaPredecesora,'0')='0'))
	begin
		RAISERROR ('La oportunidad no puede ser eliminada.',16,1);  
	end
	else
	begin
		update GROportunidad 
			set FlgHabilitado='F' 
		where IdOportunidad=@idoportunidad
	end
end











GO
/****** Object:  StoredProcedure [dbo].[spS_AuxSelIdioma]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[spS_AuxSelIdioma]
AS

SET NOCOUNT ON  

DECLARE @CodPais VARCHAR(2)
SELECT @CodPais = 'PE'
SELECT @CodPais AS CodPais, CFE.CodEtiqueta, CFI.Descripcion FROM CFPais CFP
	INNER JOIN CFValorEtiqueta CFI ON (CFI.IdPais = CFP.IdPais)
	INNER JOIN CFEtiqueta CFE ON (CFI.IdEtiqueta = CFE.IdEtiqueta)
WHERE CodPais = @CodPais
 --select 'PE'  AS CodPais ,CodEtiqueta,Descripcion CFEtiqueta










GO
/****** Object:  StoredProcedure [dbo].[spS_CarInsError]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spS_CarInsError]                               
(                              
 @ID BIGINT,                                               
 @ERR_ESTRUCTURA  VARCHAR(50),  
 @TABLE_NAME VARCHAR(50)  
)                              
AS      
BEGIN      
      
 IF(@TABLE_NAME='USUARIOS')  
 BEGIN  
  INSERT INTO Err_Usuario(Err_Aux) VALUES (@ERR_ESTRUCTURA)      
 END
 ELSE IF(@TABLE_NAME='TIPOS')  
 BEGIN  
  INSERT INTO Err_TIPO(Err_Aux) VALUES (@ERR_ESTRUCTURA)      
 END
 ELSE IF(@TABLE_NAME='GENERALES')  
 BEGIN  
  INSERT INTO ERR_GENERAL(Err_Aux) VALUES (@ERR_ESTRUCTURA)      
 END
 ELSE IF(@TABLE_NAME='CLIENTES')  
 BEGIN  
  INSERT INTO ERR_Cliente(Err_Aux) VALUES (@ERR_ESTRUCTURA)      
 END
      
END










GO
/****** Object:  StoredProcedure [dbo].[spS_GetFotoBase64]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spS_GetFotoBase64] ( @idFoto varchar(100) )
AS
    BEGIN

	DECLARE @img1 varbinary(max)
	Declare @name varchar(500)

	SELECT @img1 = Foto, @name = NombreFoto FROM TRFoto WHERE NombreFoto = @IdFoto

	SELECT
		@name as Nombre,
		CAST('' AS XML).value('xs:base64Binary(sql:variable("@img1"))','VARCHAR(MAX)') AS Imagen
	
END;













GO
/****** Object:  StoredProcedure [dbo].[spS_Login]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spS_Login]--[spS_Login] '98','98'
@codigo varchar(100),
@clave varchar(300),
@TipoAutenticacion varchar(100)='F'


AS
BEGIN
	declare @login varchar(100),@pass varchar(100)
	set @login = (select top 1 LoginUsuario as codigo
	from GRUsuario u
	where (LoginUsuario = @codigo or email = @codigo)
	and u.FlgHabilitado = 'T')

	set @pass = (select top 1 LoginUsuario as codigo
	from GRUsuario u
	where Clave = @clave and LoginUsuario = @codigo
	and u.FlgHabilitado = 'T')


	if @login is null
	begin
		RAISERROR (N'Usuario incorrecto', -- Message text.  
           16, -- Severity,  
           1, -- State,  
           N'abcde'); 
	end
	else if @pass is null and ISNULL(@TipoAutenticacion,'')='T'
	begin
		RAISERROR (N'Contraseña incorrecta', -- Message text.  
           16, -- Severity,  
           1, -- State,  
           N'abcde'); 
	end
	else if @login is null and @pass is null
	begin
		RAISERROR (N'Usuario y contraseña incorrecto', -- Message text.  
           16, -- Severity,  
           1, -- State,  
           N'abcde'); 
	end
	else
	begin
		select IdUsuario as id, Apellidos + ', ' + Nombres as nombre, u.Codigo as codigo,ISNULL(u.IdCanal,0)AS IdCanal,ISNULL(u.IdZona,0)AS IdZona,u.Email,
			c.Nombre Canal,z.Nombre Zona,u.FlagAutenticacionAD AS FlagAutenticacionAD,u.IdPerfil,p.Descripcion perfil
		from GRUsuario u INNER JOIN dbo.GRCanal c ON c.IdCanal = u.IdCanal
		LEFT JOIN dbo.GRZona z ON z.IdZona = u.IdZona INNER join GRPerfil p on p.IdPerfil=u.IdPerfil
		where LoginUsuario = @login
		and (@TipoAutenticacion='F' or Clave = @clave)
		and u.FlgHabilitado = 'T'
	end

	
END









GO
/****** Object:  StoredProcedure [dbo].[spS_ManInsCliente]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spS_ManInsCliente]
    (
      @Razon_Social VARCHAR(50) ,
      @RUC VARCHAR(11) ,
      @Direccion VARCHAR(15) ,
      @Referencia VARCHAR(15) ,
      @IdsZona VARCHAR(MAX) ,
      @IdCanal BIGINT	  
    )
AS
    BEGIN
        INSERT  INTO [dbo].GRCliente
                ( Razon_Social ,
                  RUC ,
                  FlgHabilitado ,
                  Direccion ,
                  Referencia ,
                  IdCanal
                )
        VALUES  ( @Razon_Social ,
                  @RUC ,
                  'T' ,
                  @Direccion ,
                  @Referencia ,
                  @IdCanal
                );

        DECLARE @idCliente BIGINT= 0;
        SET @idCliente = CAST(SCOPE_IDENTITY() AS INT);

        INSERT  INTO dbo.GRClienteZona
                ( idCliente ,
                  idZona
                )
                SELECT  @idCliente ,
                        SPLITVALUE
                FROM    dbo.SPLIT(@IdsZona, ',');

        SELECT  @idCliente;
    END;










GO
/****** Object:  StoredProcedure [dbo].[spS_ManInsGRActividad]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spS_ManInsGRActividad]--spS_ManSelGRGeneralDetalle 2
    (
      @IdConfiguracionActividad BIGINT =NULL,
	  @IdTipoActividad BIGINT =NULL,
      @idCanal INT ,
      @IdUsuarioResponsable BIGINT ,
      @idCliente BIGINT ,
      @lstCrt AS dbo.LstControlDina READONLY ,
      @IdContacto BIGINT ,
      @observaciones VARCHAR(MAX) ,
      @fecha AS DATETIME ,
      @latitud AS FLOAT ,
      @longitud AS FLOAT	
    )
AS
    BEGIN
        INSERT  INTO dbo.GRActividad
                ( IdConfiguracionActividad ,
				  IdTipoActividad,
                  IdCanal ,
                  IdUsuarioResponsable ,
                  FechaCreacion ,
                  idCliente ,
                  FlgHabilitado ,
                  idContacto ,
                  observaciones ,
                  Fecha ,
                  Latitud ,
                  Longitud
                )
        VALUES  ( @IdConfiguracionActividad ,
				  @IdTipoActividad,
                  @idCanal ,
                  @IdUsuarioResponsable ,
                  GETDATE() ,
                  @idCliente ,
                  'T' ,
                  @IdContacto ,
                  @observaciones ,
                  @fecha ,
                  @latitud ,
                  @longitud
                );

        DECLARE @IdActividad INT; 
        SET @IdActividad = ( SELECT CAST(SCOPE_IDENTITY() AS INT)
                           );

        INSERT  INTO TRActividadDetalleControl
                ( IdActividad ,
                  IdConfiguracionActividadDetalle ,
                  ValorControl ,
                  IdGeneral
                )
                SELECT  @IdActividad ,
                        id ,
                        valor ,
                        ( SELECT    CodigoGeneral
                          FROM      dbo.GRSubTipoActividad_Detalle
                          WHERE     IDSubTipoActividadDetalle = id
                        )
                FROM    @lstCrt;
        SELECT  @IdActividad;
    END;









GO
/****** Object:  StoredProcedure [dbo].[spS_ManInsGRContacto]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spS_ManInsGRContacto]
    (
      @Nombre VARCHAR(150) ,
      @Telefono VARCHAR(50) ,
      @Email VARCHAR(50) ,
      @Cargo VARCHAR(50) ,
      @IdCliente BIGINT ,
      @IdZona BIGINT
    )
AS
    BEGIN
        SET NOCOUNT OFF;		
        INSERT  INTO [dbo].[GRContacto]
                ([Nombre] ,
                  [Telefono] ,
                  [Email] ,
                  [Cargo] ,
                  [IdZona] ,
                  [IdCliente] ,
                  [Flag]
                )
        VALUES  ( @Nombre ,
                  @Telefono ,
                  @Email ,
                  @Cargo ,
                  @IdZona ,
                  @IdCliente ,
                  'T'
                );	
        DECLARE @idContaco INT = ( SELECT   CAST(SCOPE_IDENTITY() AS INT));
        SELECT  @idContaco;
    END;



GO
/****** Object:  StoredProcedure [dbo].[sps_ManInsGRSubTipoActividad]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  procedure [dbo].[sps_ManInsGRSubTipoActividad]
(@Codigo varchar(100),
@Descripcion varchar(100),
@idtipoactividad int,
@lstCrt AS [dbo].[LstSubTipoActividadDetalle] READONLY
)
as
begin
	declare @IDSubTipoActividad int
	insert into dbo.GRSubTipoActividad
	        (Codigo,Descripcion,FlgHabilitado,IDSubTipoActividad)
	values (@Codigo,@Descripcion,'T',@idtipoactividad)
	set @IDSubTipoActividad = CAST(scope_identity() AS int)
	update GRSubTipoActividad set Codigo=@IDSubTipoActividad where IDSubTipoActividad=@IDSubTipoActividad
	select id=ROW_NUMBER() over(order by case when IdSubTipoActividadDetPadre='' then 0 else 1 end) ,
	* into #tmplist from @lstCrt
	
	declare @fila int =1,@IdConOpDet varchar(100),@filas int=(select count(1) from #tmplist)
	select * from #tmplist

	while @filas>=@fila
	begin
		print '1'
		declare @Perfiles varchar(max),@filaDat varchar(100)

		select @Perfiles=perfiles,@filaDat=fila,@IdConOpDet=isnull(IdSubTipoActividadDetPadre,'') from #tmplist where id =@fila
		select @IdConOpDet
		if @IdConOpDet='' or @IdConOpDet='0'
		begin
			print 'insert '+@Perfiles
			insert into GRSubTipoActividad_Detalle(IDSubTipoActividad,Etiqueta,IdTipoControl
			,CodigoGeneral,Modificable,Obligatorio,MaxCaracter,FlgHabilitado,FlgPadre)
			select @IDSubTipoActividad,Etiqueta,IdTipoControl
			,CodigoGeneral,Modificable,Obligatorio,MaxCaracter,FlgHabilitado,FlgPadre
			from #tmplist tl where id=@fila

			set @IdConOpDet= (SELECT CAST(scope_identity() AS int))
			
			insert into GRSubTipoActividad_Detalle_PerfilModifica
			(IDSubTipoActividad,IdSubTipoActividadDetalle,IdPerfil,FlgHabilitado)
				SELECT @IDSubTipoActividad,@IdConOpDet, SPLITVALUE,'T' FROM dbo.SPLIT_2(@Perfiles,',') where SPLITVALUE!=''

			update #tmplist
			set IdConfiguracionoportunidadDetalle=@IdConOpDet
			where fila=@filaDat

			if (select IdConfigOportunidadDetPadre from #tmplist where id=@fila)!=''
			begin
				update a
				set a.IdSubTipoActividadDetPadre=c.IdConfiguracionoportunidadDetalle
				from GRSubTipoActividad_Detalle a
				inner join #tmplist b on a.IDSubTipoActividadDetalle=b.IdConfiguracionoportunidadDetalle
				inner join #tmplist c on b.IdConfigOportunidadDetPadre=c.fila
				where b.id=@fila
			end
		
		end
		set @fila= @fila+1
	end
	select @IDSubTipoActividad
end







GO
/****** Object:  StoredProcedure [dbo].[spS_ManInsGRTipoActividad]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spS_ManInsGRTipoActividad]
    (
      @Codigo VARCHAR(50) ,
      @Nombre VARCHAR(150),
	  @IdCanal bigint,
	  @meta varchar(100)
    )
AS
    BEGIN
        /*DECLARE @EXISTE INT;
        SET @EXISTE = 0;
        SELECT  @EXISTE = COUNT(*)
        FROM    [GRTipoActividad]
        WHERE   codigo = @Codigo;
        IF @EXISTE > 0
            BEGIN
                SELECT  -1;
                RETURN;
            END; */
        INSERT  INTO [dbo].[GRTipoActividad]
                ( /*[codigo], */[nombre],[IdCanal],[meta],[FlagTA] )
        VALUES  ( /*@Codigo,*/ @Nombre,@idcanal,@meta, 'T' );
		


        DECLARE @id INT = ( SELECT  CAST(SCOPE_IDENTITY() AS INT));
		UPDATE GRTipoActividad SET codigo=@ID WHERE id =@ID 
        SELECT  @id;
    END;








GO
/****** Object:  StoredProcedure [dbo].[spS_ManInsGrupo]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spS_ManInsGrupo]
(
	@Codigo varchar(50)
	,@Nombre	varchar	(50)
	,@IdNivel	int
	,@CodigoPadreGrupo	varchar	(20)
)
AS
BEGIN
	INSERT	INTO[dbo].GRGrupo(Codigo,Nombre,IdNivel,CodigoPadreGrupo,FlgHabilitado,tipo)
	VALUES(@Codigo,@Nombre,@IdNivel,@CodigoPadreGrupo,'T','G')
	SELECT CAST(scope_identity() AS int)
END









GO
/****** Object:  StoredProcedure [dbo].[spS_ManInsGrupoDetalle]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spS_ManInsGrupoDetalle]
(
	@IdGrupo	bigint
	,@Codigo	varchar(15)
	,@Nombre	varchar(50)
	,@IdCodigoDetallePadre	varchar(50)
)
AS
BEGIN
	INSERT	INTO[dbo].GRGrupoDetalle(IdGrupo,Codigo,Nombre,IdCodigoDetallePadre,FlgHabilitado)
	VALUES(@IdGrupo,@Codigo,@Nombre,@IdCodigoDetallePadre,'T')
	SELECT CAST(scope_identity() AS int)
END










GO
/****** Object:  StoredProcedure [dbo].[spS_ManInsGRUsuario]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spS_ManInsGRUsuario]
(
	@Codigo	VARCHAR	(10),
	@Nombres	VARCHAR	(80),
	@LoginUsuario	VARCHAR	(10),
	@Email	VARCHAR	(100),
	@clave	VARCHAR	(300),
	@vendedores	VARCHAR	(4000),
	@IdPerfil	BIGINT,
	@IdCanal	BIGINT,
	@IdZona		BIGINT,
	@VerificaAD CHAR(1)
)
AS
BEGIN
	INSERT	INTO	[dbo].[GRUsuario]
	(/*Codigo,*/Nombres,LoginUsuario,Email,FlgHabilitado,clave,IdPerfil,Apellidos,IdCanal,IdZona,FlagAutenticacionAD)
	VALUES(/*@Codigo,*/@Nombres,@LoginUsuario,@Email,'T',@clave,@IdPerfil,'',@IdCanal,@IdZona,@VerificaAD)
	
	declare @idUsuario int =(SELECT CAST(scope_identity() AS int))
	update GrUsuario set Codigo=@idUsuario where idusuario =@idUsuario

	if @vendedores ='' or @vendedores =',' or @IdPerfil='2' or @IdPerfil='4' set @vendedores = null
	if @vendedores!= null
	begin
		insert into GRGrupoUsuario(IdUsuarioCoordinador,IdUsuarioVendedor,FlgHabilitado)
		SELECT @idUsuario,SPLITVALUE,'T' FROM dbo.SPLIT_2(@vendedores,',')
	end

	SELECT @idUsuario
END









GO
/****** Object:  StoredProcedure [dbo].[spS_ManInsGRZona]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spS_ManInsGRZona]
    (
      @Codigo VARCHAR(10) ,
      @Nombre VARCHAR(80)
    )
AS
    BEGIN
        DECLARE @EXISTE INT;
        SET @EXISTE = 0;
        SELECT  @EXISTE = COUNT(*)
        FROM    [GRZona]
        WHERE   Codigo = @Codigo;
        IF @EXISTE > 0
            BEGIN
                SELECT  -1;
                RETURN;
            END; 
        INSERT  INTO [dbo].[GRZona]
                ( [Codigo], [Nombre] )
        VALUES  ( @Codigo, @Nombre );
	
        DECLARE @idZona INT = ( SELECT  CAST(SCOPE_IDENTITY() AS INT)
                              );
        SELECT  @idZona;
    END;











GO
/****** Object:  StoredProcedure [dbo].[spS_ManSelClienteAll]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spS_ManSelClienteAll]
    (
      @Razon_Social VARCHAR(50) = '' ,
      @RUC VARCHAR(11) = '' ,
      @Direccion VARCHAR(15) = '' ,
      @Referencia VARCHAR(15) = '' ,
      @IdCanal BIGINT = 0 ,
      @flag VARCHAR(1) = 'T',
	  @filtroCanal varchar(max) ='-1',
	  @filtroUsuario BIGINT =0
	)
AS
    BEGIN
		

        SELECT  c.CLI_PK ,
                c.Razon_Social ,
                c.RUC ,
                c.Direccion ,
                c.Referencia ,
                ISNULL(STUFF(( SELECT   ',' + zon.Nombre
                               FROM     dbo.GRZona zon
                                        INNER JOIN dbo.GRClienteZona cliezo ON cliezo.idZona = zon.IdZona
                               WHERE    cliezo.idCliente = c.CLI_PK
                             FOR
                               XML PATH('')
                             ), 1, 1, ''), '') AS Zonas ,
                ISNULL(STUFF(( SELECT   ',' + zon.Nombre
                               FROM     dbo.GRZona zon
                                        INNER JOIN dbo.GRClienteZona cliezo ON cliezo.idZona = zon.IdZona
                               WHERE    cliezo.idCliente = c.CLI_PK
                             FOR
                               XML PATH('')
                             ), 1, 1, ''), '') AS IdsZona ,
                c.IdCanal ,
                Canal = ca.Nombre ,
                c.FlgHabilitado
        FROM    [dbo].GRCliente c
                LEFT OUTER JOIN dbo.GRCanal ca ON c.IdCanal = ca.IdCanal
        	
	
    END;
GO
/****** Object:  StoredProcedure [dbo].[spS_ManSelClienteAllPaginate]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spS_ManSelClienteAllPaginate]
(
	@Razon_Social	varchar	(50)	  ,
	@RUC	varchar	(11)				  ,
	@Direccion	varchar	(15)		  ,
	@Referencia	varchar	(15)		  ,
	@IdCanal	BIGINT=0,	
	@IdZona		BIGINT=0,
	@flag varchar(1),
	@page int,  
    @rows int  
)
AS
BEGIN
	DECLARE @MAXIMO INT                                        
	DECLARE @MINIMO INT                                        
	DECLARE @TAMTOLAL INT 
	
	SELECT @MAXIMO = (@page * @rows)                                              
	SELECT @MINIMO = @MAXIMO - (@rows - 1) 
	SELECT ROW_NUMBER() OVER (ORDER BY CLI_PK) item,
	c.CLI_PK				,
	c.Razon_Social			,
	c.RUC					,
	c.Direccion				,
	c.Referencia			,
	ISNULL(STUFF((SELECT ','+zon.Nombre FROM dbo.GRZona zon INNER JOIN dbo.GRClienteZona cliezo ON cliezo.idZona = zon.IdZona WHERE cliezo.idCliente=c.CLI_PK AND (@IdZona=0 OR zon.IdZona IN(@IdZona) ) for xml path('')),1,1,''),'') AS Zonas,
	ISNULL(STUFF((SELECT ','+zon.Nombre FROM dbo.GRZona zon INNER JOIN dbo.GRClienteZona cliezo ON cliezo.idZona = zon.IdZona WHERE cliezo.idCliente=c.CLI_PK AND (@IdZona=0 OR zon.IdZona IN(@IdZona) ) for xml path('')),1,1,''),'') AS IdsZona,
	c.IdCanal				,
	Canal=ca.Nombre,
	c.FlgHabilitado			
	INTO #tmp
	--select *
	FROM	[dbo].GRCliente c
	left outer join dbo.GRCanal ca on c.IdCanal=ca.IdCanal
	WHERE
	(@Razon_Social='' OR c.Razon_Social	LIKE '%' +	@Razon_Social + '%') AND 
	(@RUC='' OR c.RUC	LIKE '%' +	@RUC + '%') AND 
	(@Direccion='' OR c.Direccion	LIKE '%' +	@Direccion + '%') AND 
	(@Referencia='' OR c.Referencia	LIKE '%' +	@Referencia + '%') AND 
	(@IdCanal=0 OR c.IdCanal=@IdCanal) AND 
	c.FlgHabilitado = @flag
	
	DECLARE @TOTAL INT = (select count(*) from #tmp)
	select *, @TOTAL as total                  
	from  #tmp
	where @page=0 or item between ((@page - 1) * @rows + 1) AND (@page * @rows) AND IdsZona<>''
END










GO
/****** Object:  StoredProcedure [dbo].[spS_ManSelClienteValida]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[spS_ManSelClienteValida]
(
	
	@CLI_PK	BIGINT,
	@Razon_Social	VARCHAR	(50),
	@RUC	VARCHAR	(11)
)
AS
BEGIN
	SELECT
	case WHEN Razon_Social=@Razon_Social THEN 'La Razon Social ya se encuentra registrado'
	WHEN RUC=@RUC THEN 'El RUC ya se encuentra registrado'
	end Mensaje	
	FROM	[dbo].GRCliente
	WHERE
	(@CLI_PK =0 OR CLI_PK	!=	@CLI_PK) AND 
	((@Razon_Social = '' OR Razon_Social	=	@Razon_Social ) or
	(@RUC = '' OR RUC	=	@RUC ))

END










GO
/****** Object:  StoredProcedure [dbo].[spS_ManSelClienteZonas]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spS_ManSelClienteZonas] ( 
                                                 @idCliente VARCHAR(20) )
AS
    BEGIN 
        SELECT  sel = CASE WHEN cz.idCliente IS NULL THEN 'F'
                           ELSE 'T'
                      END ,
                z.idZona ,
                z.Nombre
        FROM    dbo.GRZona z
                LEFT OUTER JOIN GRClienteZona cz ON cz.idZona = z.IdZona
                                                    AND cz.idCliente = @idCliente WHERE z.Flag='T';
    END;










GO
/****** Object:  StoredProcedure [dbo].[spS_ManSelConfOportDetAll]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spS_ManSelConfOportDetAll]--[spS_ManSelGREtapaAll]'1'
(
	@IDConfigurarOportunidad	VARCHAR	(15)	
)
AS
BEGIN
	
	SELECT ROW_NUMBER() OVER (ORDER BY cod.IdConfiguracionoportunidadDetalle) item,	 		
		cod.IdConfiguracionoportunidadDetalle, 
		cod.IdConfigOportunidadDetPadre, 
		DesConfigOpDetPadre=codp.Etiqueta, 
		cod.IDConfigurarOportunidad,
		cod.Etiqueta, 
		cod.IdTipoControl as IdTipoControl,
		(SELECT Codigo FROM CFTipoControl WHERE Id = cod.IdTipoControl) as TipoControlCodigo ,   		 
		(SELECT Nombre FROM CFTipoControl WHERE Id = cod.IdTipoControl) as TipoControlDescrip ,   		 
		cod.MaxCaracter, 
		cod.CodigoGeneral, 
		DescripcionGeneral=g.Nombre, 
		cod.Obligatorio, 
		cod.Modificable,
		cod.FlgHabilitado,
		cod.FlgPadre,
		Perfiles= (SELECT  STUFF((SELECT distinct',' + convert(nvarchar, edi.IdPerfil) 
			FROM GRConfiguracionOportunidad_Detalle_PerfilModifica edi
		where edi.IdConfiguracionoportunidadDetalle=cod.IdConfiguracionoportunidadDetalle
	   FOR XML PATH(''), TYPE).value('.[1]', 'nvarchar(4000)'), 1, 1, '')),
	   PerfilesDesc =( SELECT  STUFF((SELECT distinct ',' + convert(nvarchar, p.Descripcion) 
			FROM GRConfiguracionOportunidad_Detalle_PerfilModifica edi
			left outer join GRPerfil p on p.IdPerfil=edi.IdPerfil
			where edi.IdConfiguracionoportunidadDetalle=cod.IdConfiguracionoportunidadDetalle
	   FOR XML PATH(''), TYPE).value('.[1]', 'nvarchar(4000)'), 1, 1, ''))
	FROM	[dbo].GRConfiguracionOportunidad_Detalle cod
	left outer join GRGrupo g on cod.CodigoGeneral=g.IDGrupo
	left outer join GRConfiguracionOportunidad_Detalle codP on codP.IdTipoControl='4' and 
		cod.IdConfigOportunidadDetPadre=codp.IdConfiguracionoportunidadDetalle
	WHERE
	(@IDConfigurarOportunidad='' OR cod.IDConfigurarOportunidad	=	@IDConfigurarOportunidad) 	   	

END











GO
/****** Object:  StoredProcedure [dbo].[spS_ManSelEtapaOportunidad]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spS_ManSelEtapaOportunidad]--spS_ManSelEtapaOportunidad '1','7','5'
(
	@idEtapa	varchar(100),
	@idoportunidad	varchar(100),
	@idPerfilUsuario	varchar(100)
)
AS
BEGIN

	select et.IdEtapa,et.Etiqueta,CodigoTipoControl=et.IdTipoControl,et.CodigoGeneral
	,Modificable=case when edpm.IdPerfilModifica is null then 'F' else et.Modificable end,et.Obligatorio,et.MaxCaracter,
	codigoControl=ctc.Codigo/*case ctc.Codigo when '9' then '9IMG' else ctc.Codigo end*/,et.IdEtapaDetalle,edc.ValorControl,edc.IdFoto,txtcontrol=case when ctc.Codigo = 3 then g.Nombre else edc.ValorControl end 
	from GREtapaDetalle et
	left outer join [CFTipoControl] ctc on ctc.Id=et.IdTipoControl
	left outer join TREtapaDetalleControl edc on edc.IdEtapa=et.IdEtapa and edc.IdOportunidad=@idoportunidad and et.IdEtapaDetalle=edc.IdEtapaDetalle
	left outer join GRGrupoDetalle g on et.CodigoGeneral = g.IdGrupo and edc.ValorControl=g.Codigo
	left outer join GREtapaDetallePerfilModifica edpm on edpm.IdEtapaDetalle=et.IdEtapaDetalle and 
		edpm.IdPerfilModifica=@idPerfilUsuario and et.FlgHabilitado='T'
		where et.IdEtapa=@idEtapa and et.FlgHabilitado='T'
		order by et.IdEtapaDetalle
end










GO
/****** Object:  StoredProcedure [dbo].[spS_ManSelGeneralAllPaginate]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spS_ManSelGeneralAllPaginate]
(
	@Codigo	VARCHAR	(50),
	@Nombre	VARCHAR	(50),
	@flag varchar(1),
	@page int,  
    @rows int  
)
AS
BEGIN
	DECLARE @MAXIMO INT                                        
	DECLARE @MINIMO INT                                        
	DECLARE @TAMTOLAL INT 
	
	SELECT @MAXIMO = (@page * @rows)                                              
	SELECT @MINIMO = @MAXIMO - (@rows - 1) 
	SELECT ROW_NUMBER() OVER (ORDER BY g.IDGeneralTipo) item
	,g.IDGeneralTipo
	,g.Codigo
	,g.Nombre
	,g.IdNivel
	,Nivel=''
	,g.CodigoPadreGeneral
	,PadreDescrip=gp.Nombre
	,g.FlgHabilitado
	,g.tipo		
	INTO #tmp
	--select *
	FROM	[dbo].GRGeneral g
	left outer join GRGeneral gp on gp.IDGeneralTipo=g.CodigoPadreGeneral --and gp.IdNivel='1'
	WHERE
	(@Codigo='' OR g.Codigo	LIKE '%' +	@Codigo + '%') AND 
	(@Nombre='' OR g.Nombre LIKE '%' +	@Nombre + '%') AND 
	g.FlgHabilitado = @flag
	
	DECLARE @TOTAL INT = (select count(*) from #tmp)
	select *, @TOTAL as total                  
	from  #tmp
	where @page=0 or item between ((@page - 1) * @rows + 1) AND (@page * @rows) 
END










GO
/****** Object:  StoredProcedure [dbo].[spS_ManSelGRCanalAll]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spS_ManSelGRCanalAll]
    (
      @Codigo VARCHAR(10) = '' ,
      @Nombre VARCHAR(80) = '',
	  @FiltroUsuario varchar(100) = 1
    )
AS
    BEGIN

		DECLARE @IDPERFIL VARCHAR(20),@IdCanal VARCHAR(20)
		SELECT @IDPERFIL= IDPerfil,@IdCanal=IdCanal from GrUsuario where IdUsuario=@FiltroUsuario;
        SELECT  IdCanal ,
                Codigo ,
                Nombre
        FROM    [dbo].GRCanal
        WHERE   ( @Codigo = '' OR Codigo = @Codigo)
                AND ( @Nombre = '' OR Nombre LIKE '%' + @Nombre + '%')
				AND  (@IDPERFIL=2 OR IdCanal=@IdCanal);
    END;








GO
/****** Object:  StoredProcedure [dbo].[spS_ManSelGRCliente]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spS_ManSelGRCliente]--spS_ManSelGRGeneralDetalle 2
    (
      @cliente VARCHAR(100)='' ,
      @idCanal BIGINT=0 ,
      @idZona BIGINT=0
    )
AS
    BEGIN

        SELECT  codigo = C.CLI_PK ,
                descripcion = C.Razon_Social ,
                C.IdCanal
        FROM    GRCliente C
        WHERE   C.FlgHabilitado = 'T'
                AND C.Razon_Social LIKE @cliente + '%'
				AND (@idzona =0 or @idZona in (select idZona from GRClienteZona CZ where  CZ.idCliente = C.CLI_PK))
                AND ( @idCanal = 0 OR C.IdCanal = @idCanal)
    END;










GO
/****** Object:  StoredProcedure [dbo].[spS_ManSelGRCliente2]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spS_ManSelGRCliente2]--[spS_ManSelGRCliente2] 3
    ( @CLI_PK BIGINT )
AS
    BEGIN
        SELECT  c.CLI_PK ,
                c.Razon_Social ,
                c.RUC ,
                c.Direccion ,
                c.Referencia ,
               ISNULL(STUFF((SELECT ','+CONVERT(VARCHAR(max),zon.IdZona) FROM dbo.GRZona zon INNER JOIN dbo.GRClienteZona cliezo ON cliezo.idZona = zon.IdZona WHERE cliezo.idCliente=c.CLI_PK for xml path('')),1,1,''),'') AS IdsZona	,
               ISNULL(STUFF((SELECT ','+zon.Nombre FROM dbo.GRZona zon INNER JOIN dbo.GRClienteZona cliezo ON cliezo.idZona = zon.IdZona WHERE cliezo.idCliente=c.CLI_PK for xml path('')),1,1,''),'') AS Zonas,
                c.IdCanal ,
                Canal = ca.Nombre ,
                c.FlgHabilitado
        FROM    [dbo].GRCliente c
                LEFT OUTER JOIN dbo.GRCanal ca ON c.IdCanal = ca.IdCanal
        WHERE   CLI_PK = @CLI_PK
    END;










GO
/****** Object:  StoredProcedure [dbo].[spS_ManSelGRConfiguracionOportunidad]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spS_ManSelGRConfiguracionOportunidad]
AS
BEGIN
	select IDConfigurarOportunidad, codigo,Descripcion from [GRConfiguracionOportunidad] where FlgHabilitado='T'
end









GO
/****** Object:  StoredProcedure [dbo].[spS_ManSelGRContact]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spS_ManSelGRContact]
AS
    BEGIN 

        SELECT  [IdContacto] ,
                [Nombre] ,
                [Telefono] ,
                [Email] ,
				[Cargo],
                [IdCliente] ,
                [IdZona] ,
                [Flag]
        FROM    [dbo].[GRContacto]
        
    END;




GO
/****** Object:  StoredProcedure [dbo].[spS_ManSelGRContacto]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spS_ManSelGRContacto] @IdContacto BIGINT
AS
    BEGIN 

        SELECT  [IdContacto] ,
                [Nombre] ,
                [Telefono] ,
                [Email] ,
				[Cargo],
                [IdCliente] ,
               dbo.GRContacto.[IdZona] ,
			   Razon_Social Cliente,
                [Flag]
        FROM    [dbo].[GRContacto] INNER JOIN dbo.GRCliente ON GRCliente.CLI_PK = GRContacto.IdCliente
        WHERE   IdContacto = @IdContacto;
    END;








GO
/****** Object:  StoredProcedure [dbo].[spS_ManSelGRContactoAll]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spS_ManSelGRContactoAll]
    (
      @Nombre VARCHAR(150)='' ,
      @Telefono VARCHAR(50) ='',
      @Email VARCHAR(50)='' ,
	  @Cargo VARCHAR(50)='',
      @IdCliente BIGINT =0,
      @IdZona BIGINT=0 ,
      @Flag CHAR(1)='T'
    )
AS
    BEGIN	 	
        SELECT  IdContacto ,
                [Nombre] ,
                [Telefono] ,
                [Email] ,
				[Cargo],
                [IdCliente] ,
                [IdZona] ,
                [Flag]
        FROM    [dbo].GRContacto
        WHERE   ( @Nombre = ''
                  OR Nombre LIKE '%' + @Nombre + '%'
                )
                AND ( @Telefono = ''
                      OR Telefono LIKE '%' + @Telefono + '%'
                    )
                AND ( @Email = ''
                      OR Email LIKE '%' + @Email + '%'
                    )  
					AND ( @Cargo = ''
                      OR Cargo LIKE '%' + @Cargo + '%'
                    )
                AND ( @IdCliente = 0
                      OR IdCliente = @IdCliente
                    )
                AND ( @IdZona = 0
                      OR IdZona = @IdZona
                    )
                AND ( @Flag = ''
                      OR Flag = @Flag
                    );  
    END;









GO
/****** Object:  StoredProcedure [dbo].[spS_ManSelGRContactoAllPaginate]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spS_ManSelGRContactoAllPaginate]
    (
      @Nombre VARCHAR(150) ,
      @Telefono VARCHAR(50) ,
      @Email VARCHAR(50) ,
      @Cargo VARCHAR(50) ,
      @IdCliente BIGINT ,
      @IdZona BIGINT ,
      @Flag VARCHAR(10) ,
      @page INT ,
      @rows INT  
    )
AS
    BEGIN
        DECLARE @MAXIMO INT;                                        
        DECLARE @MINIMO INT;                                        
        DECLARE @TAMTOLAL INT; 
	
        SELECT  @MAXIMO = ( @page * @rows );                                              
        SELECT  @MINIMO = @MAXIMO - ( @rows - 1 ); 
        SELECT  ROW_NUMBER() OVER ( ORDER BY IdContacto ) item ,
                co.IdContacto ,
                co.[Nombre] ,
                co.[Telefono] ,
                co.[Email] ,
                co.[Cargo] ,
                co.[IdCliente] ,
                co.[IdZona] ,
				cli.Razon_Social Cliente,
				z.Nombre Zona,
                co.[Flag]
        INTO    #tmp
        FROM    [dbo].GRContacto co INNER JOIN dbo.GRCliente cli ON co.IdCliente=cli.CLI_PK
		INNER JOIN dbo.GRZona z ON z.IdZona = co.IdZona
        WHERE   ( @Nombre = ''
                  OR co.Nombre LIKE '%' + @Nombre + '%'
                )
                AND ( @Telefono = ''
                      OR co.Telefono LIKE '%' + @Telefono + '%'
                    )
                AND ( @Email = ''
                      OR co.Email LIKE '%' + @Email + '%'
                    )
                AND ( @Cargo = ''
                      OR co.Cargo LIKE '%' + @Cargo + '%'
                    )
                AND ( @IdCliente = 0
                      OR co.IdCliente = @IdCliente
                    )
                AND ( @IdZona = 0
                      OR co.IdZona = @IdZona
                    )
                AND ( @Flag = ''
                      OR co.Flag = @Flag
                    );  
	
        DECLARE @TOTAL INT = ( SELECT   COUNT(*)
                               FROM     #tmp
                             );
        SELECT  * ,
                @TOTAL AS total
        FROM    #tmp
        WHERE   item BETWEEN ( ( @page - 1 ) * @rows + 1 ) AND ( @page * @rows ); 
    END;








GO
/****** Object:  StoredProcedure [dbo].[spS_ManSelGREstado]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spS_ManSelGREstado]
AS
BEGIN

	select codigo=IdEstado,Descripcion from CFEstado where FlgHabilitado='T'
end










GO
/****** Object:  StoredProcedure [dbo].[spS_ManSelGREtapa]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spS_ManSelGREtapa]
(
	@CodEtapa	VARCHAR (15)
)
AS
BEGIN
	SELECT
	E.IdEtapa,
	E.CodEtapa, 
	E.Descripcion, 
	(SELECT IdEtapa FROM GREtapa WHERE IdEtapa = E.EtapaPredecesora ) AS IdEtapaPredecesora,
	(SELECT Descripcion FROM GREtapa WHERE IdEtapa = E.EtapaPredecesora ) AS EtapaPredecesora, 
	E.TiempoEtapa, 
	E.FechaRegistro, 
	E.FlgHabilitado
	FROM	[dbo].[GREtapa]	E
	WHERE	
	(@CodEtapa ='' OR E.CodEtapa = @CodEtapa)  

END










GO
/****** Object:  StoredProcedure [dbo].[spS_ManSelGRGrupo]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spS_ManSelGRGrupo]--[spS_ManSelGRGeneral2] '1'
(
	@IDGrupo	varchar(10)
)
AS
BEGIN
	SELECT
	g.IDGrupo
	,g.Codigo
	,g.Nombre
	,g.IdNivel
	,g.CodigoPadreGrupo
	,g.FlgHabilitado
	,g.tipo		
	FROM	[dbo].GRGrupo g
	WHERE
	IDGrupo	=	@IDGrupo

END










GO
/****** Object:  StoredProcedure [dbo].[spS_ManSelGRGrupoDetalle]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spS_ManSelGRGrupoDetalle]
( 
	@CodigoGrupo varchar (100),
	@idPadre varchar (100)=null
)
AS
BEGIN
	if @idPadre='' set @idPadre =null
	select codigo,Nombre from GRGrupoDetalle where FlgHabilitado='T' and 
	--IdTipo=@CodigoTipo and--(select IDGeneralTipo from GRGeneral where Codigo = @CodigoTipo) and
	IdGrupo=(select IDGrupo from GRGrupo where Idgrupo=@CodigoGrupo) AND
	(@idPadre is null or IdCodigoDetallePadre=@idPadre)
end











GO
/****** Object:  StoredProcedure [dbo].[spS_ManSelGRGrupoDetalle2]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spS_ManSelGRGrupoDetalle2]--[spS_ManSelGRGeneralDetalle2] '1'
(
	@IdGrupoDetalle	bigint
)
AS
BEGIN
	SELECT
	g.IdGrupoDetalle
	,g.IdGrupo
	,g.Codigo
	,g.Nombre
	,Grupo = ge.Nombre
	,g.IdCodigoDetallePadre
	,g.FlgHabilitado	
	--select *
	FROM	[dbo].GRGrupoDetalle g
	left outer join GRGrupo ge on ge.IDGrupo=g.IdGrupo
	WHERE
	IdGrupoDetalle	=	@IdGrupoDetalle

END










GO
/****** Object:  StoredProcedure [dbo].[spS_ManSelGRGrupoDetallePadre]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spS_ManSelGRGrupoDetallePadre]--[spS_ManSelGRGeneralDetallePadre] '12','7' select * from grgeneral
(
	@IdGrupoDetalle	varchar(10),
	@IdGrupo	bigint
)
AS
BEGIN
	--if @IdGeneralDetalle =0 set @IdGeneralDetalle = null
	SELECT
	g.IdGrupoDetalle
	,g.IdGrupo
	,g.Codigo
	,g.Nombre
	,Grupo = ge.Nombre
	,g.IdCodigoDetallePadre
	,g.FlgHabilitado
	,Selecc=case when gds.CodigoPadreGrupo is not null then 'T' else 'F' end 
	--select *
	FROM	[dbo].GRGrupoDetalle g
	inner join GRGrupo ge on ge.IDGrupo=g.IdGrupo and g.IdGrupo=(select CodigoPadreGrupo from GRGrupo where IDGrupo=@IdGrupo)
	--inner join GRGeneralDetalle gd on gd.IdTipo=ge.CodigoPadreGeneral and gd.Codigo=g.IdCodigoDetallePadre
	left outer join (	
	select ge.CodigoPadreGrupo,g.Codigo,g.Nombre,g.IdCodigoDetallePadre
	from GRGrupoDetalle g
	inner join GRGrupo ge on ge.IDGrupo=g.IdGrupo
	inner join GRGrupoDetalle gd on gd.IdGrupo=ge.CodigoPadreGrupo and gd.Codigo=g.IdCodigoDetallePadre
	where  g.IdGrupoDetalle=@IdGrupoDetalle
	)gds on gds.CodigoPadreGrupo=ge.IDGrupo and gds.IdCodigoDetallePadre=g.Codigo
	WHERE 1=1
	--(@IdGeneralDetalle is null or IdGeneralDetalle	!=	@IdGeneralDetalle)

END










GO
/****** Object:  StoredProcedure [dbo].[spS_ManSelGRGrupoPadres]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE	 PROCEDURE [dbo].[spS_ManSelGRGrupoPadres]--[spS_ManSelGRGeneral2] '1'
(
	@IDGrupo	varchar(10)
)
AS
BEGIN
	if @IDGrupo =0 set @IDGrupo=null
	SELECT
	g.IDGrupo
	,g.Codigo
	,g.Nombre
	,g.IdNivel
	,g.CodigoPadreGrupo
	,g.FlgHabilitado
	,g.tipo
	FROM	[dbo].GRGrupo g
	WHERE
	(@IDGrupo is null or g.IDGrupo	!=	@IDGrupo)
	and FlgHabilitado='T'

END










GO
/****** Object:  StoredProcedure [dbo].[spS_ManSelGROportunidad]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spS_ManSelGROportunidad]--spS_ManSelGROportunidad '1'
(
	@IdOportunidad	BIGINT
)
AS
BEGIN
	
	SELECT ROW_NUMBER() OVER (ORDER BY o.IdOportunidad) item,
	O.IdOportunidad as Codigo,
	O.IdUsuarioResponsable as Responsable,
	usu.Apellidos +' ' + usu.Nombres as ResponsableNombre,
	o.ExisteCliente,
	FORMAT(O.FechaCreacion, 'yyyyMMdd') as FechaRegistro,
	c.Razon_Social as Cliente,
	o.idCliente,
	--ru.Nombre as Rubro,
	O.IDEstadoActual,
	O.IdEtapaActual,
	idEtapaSiguiente=(select top 1 IdEtapa from GREtapa where EtapaPredecesora=o.IdEtapaActual),
	EtapaSiguiente=(select top 1 Descripcion from GREtapa where EtapaPredecesora=o.IdEtapaActual),
	et.Descripcion as Etapa,
	o.IdConfiguracionOportunidad,
	fechaInicio=FORMAT(oe.FechaCambioEtapa, 'dd/MM/yyyy hh:mm:ss'),
	fechaFin=FORMAT(oe.FechaCambioEtapa, 'dd/MM/yyyy hh:mm:ss')
	FROM [GROportunidad] O
	left outer join GRUsuario usu on usu.IdUsuario=o.IdUsuarioResponsable
	left outer join GREtapa et on et.IdEtapa=o.IdEtapaActual
	left outer join TROportunidadEtapa oe on oe.IdOportunidad=o.IdOportunidad and oe.IdEtapa=o.IdEtapaActual
	left outer join GRCliente c on o.idCliente=c.CLI_PK
	--left outer join GRGeneralDetalle ru on c.CodRubro=ru.Codigo and ru.IdTipo='2'
	--left outer join GRGeneralDetalle re on c.CodRegion=re.Codigo and re.IdTipo='3'
	--left outer join GRGeneralDetalle ca on c.CodCanal=ca.Codigo and ca.IdTipo='4'
	WHERE 
	o.IdOportunidad=@IdOportunidad
	/*
	select o.IdOportunidad,o.ExisteCliente,o.IdEtapaActual,etapaActual=e.Descripcion,O.IDEstadoActual,ESTADOACTUAL=EST.Descripcion,
	O.IdUsuarioResponsable,USUARIORESPONSABLE=USU.Nombres + ' ' + USU.Apellidos, odc.ValorControl,cod.Etiqueta,cod.CodigoTipoControl,cod.CodigoGeneral
	,cod.Modificable,cod.Obligatorio,cod.MaxCaracter,codigoControl=ctc.Codigo,idOportunidadControl=odc.IdOportunidadDetalleControl,cod.IdConfiguracionoportunidadDetalle,
	o.IdConfiguracionOportunidad
	from [dbo].[GROportunidad] o
	left outer join [GREtapa] e on o.IdEtapaActual=e.IdEtapa
	inner join [GRConfiguracionOportunidad_Detalle] cod on cod.IDConfigurarOportunidad=o.IdConfiguracionOportunidad
	left outer join [CFTipoControl] ctc on ctc.Codigo=cod.CodigoTipoControl
	left outer join [dbo].[TROportunidadDetalleControl] odc on o.IdOportunidad=odc.idoportunidad and cod.IdConfiguracionoportunidadDetalle=odc.IdConfiguracionoportunidadDetalle and
		odc.IdOportunidad=@IdOportunidad
	LEFT OUTER JOIN [dbo].[CFEstado] EST ON EST.IdEstado=O.IDEstadoActual
	LEFT OUTER JOIN GRUsuario USU ON USU.IdUsuario=O.IdUsuarioResponsable*/
	--where o.IdOportunidad=@IdOportunidad
	
end












GO
/****** Object:  StoredProcedure [dbo].[spS_ManSelGROportunidadUsuarioAll]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spS_ManSelGROportunidadUsuarioAll]
(
	@Codigo	VARCHAR	(10),
	@Nombres	VARCHAR	(80),
	@LoginUsuario	VARCHAR	(10),
	@FlgHabilitado	VARCHAR	(10),
	@clave	VARCHAR	(300),
	@IdPerfil	BIGINT,
	@coordinadores varchar (2000)
)
AS
BEGIN
	
	DECLARE @LoginPerfil int 

	IF(@Codigo != '')
	BEGIN
		SET @LoginPerfil = (SELECT IDPERFIL FROM GRUsuario WHERE CODIGO = @Codigo)	 
	END

	if @coordinadores ='-1' set @coordinadores= null

	print @loginperfil

	if(@LoginPerfil = 5)
	BEGIN
		IF(@IdPerfil = 5)
		BEGIN
			SELECT distinct
				U.IdUsuario,
				U.Codigo,
				CONCAT (U.Nombres, ' ', U.Apellidos) as Nombres,
				U.LoginUsuario,
				U.FlgHabilitado,
				U.clave,
				U.IdPerfil
			FROM	[dbo].[GRUsuario] U
			INNER JOIN GRPerfil P ON P.IdPerfil = U.IdPerfil
			WHERE
			(U.Codigo	=	@Codigo)
		END
		ELSE
		IF(@IdPerfil = 4)
		BEGIN
			SELECT distinct
				U.IdUsuario,
				U.Codigo,
				CONCAT (U.Nombres, ' ', U.Apellidos) as Nombres,
				U.LoginUsuario,
				U.FlgHabilitado,
				U.clave,
				U.IdPerfil
			FROM	[dbo].[GRUsuario] U
			INNER JOIN GRPerfil P ON P.IdPerfil = U.IdPerfil
			INNER JOIN GRGrupoUsuario GU ON GU.IDUsuarioVendedor = U.IdUsuario
			WHERE
			(GU.IdUsuarioCoordinador	=	(select IdUsuario from [GRUsuario] where Codigo in(@Codigo))) and
			((@coordinadores IS NULL ) OR (ltrim(rtrim(gu.IdUsuarioCoordinador)) 
				IN ( SELECT ltrim(rtrim(SPLITVALUE)) FROM dbo.SPLIT_2(@coordinadores,',')))) 
			--AND 
			--(@IdPerfil='' OR U.IdPerfil	=	@IdPerfil)
		END	
	END 
	
	ELSE

	if(@LoginPerfil = 4)
	BEGIN	
		IF(@IdPerfil = 5)
		BEGIN
			DECLARE @IDUSUARIOVENDEDOR BIGINT;
			SELECT @IDUSUARIOVENDEDOR=IdUsuario from GRUsuario Where Codigo=@Codigo   
			SELECT distinct 
				U.IdUsuario,
				U.Codigo,
				CONCAT (U.Nombres, ' ', U.Apellidos) as Nombres,
				U.LoginUsuario,
				U.FlgHabilitado,
				U.clave,
				U.IdPerfil
			FROM	[dbo].[GRUsuario] U
			INNER JOIN GRPerfil P ON P.IdPerfil = U.IdPerfil
			INNER JOIN GRGrupoUsuario GU ON GU.IDUsuarioCoordinador = U.IdUsuario
			WHERE
			(gu.IdUsuarioVendedor	=	@IDUSUARIOVENDEDOR/*@Codigo*/) --AND (GU.IdUsuarioVendedor	=	@Codigo) --AND 
		END
		ELSE
		IF(@IdPerfil = 4)
		BEGIN

			SELECT
			distinct
				U.IdUsuario,
				U.Codigo,
				CONCAT (U.Nombres, ' ', U.Apellidos) as Nombres,
				U.LoginUsuario,
				U.FlgHabilitado,
				U.clave,
				U.IdPerfil
			FROM	[dbo].[GRUsuario] U
			INNER JOIN GRPerfil P ON P.IdPerfil = U.IdPerfil
			INNER JOIN GRGrupoUsuario GU ON GU.IDUsuarioVendedor = U.IdUsuario
			WHERE
			(U.Codigo	=	@Codigo) and
			(@coordinadores is null or gu.idUsuarioCoordinador in ( SELECT ltrim(rtrim(SPLITVALUE)) FROM dbo.SPLIT_2(@coordinadores,',')))
			--(GU.IdUsuarioVendedor	=	@Codigo) 
			--AND 
			--(@IdPerfil='' OR U.IdPerfil	=	@IdPerfil)
		END	
	END
	ELSE if(@LoginPerfil = 2)
	BEGIN	
		--set @coordinadores = null
		SELECT
		distinct 
			U.IdUsuario,
			U.Codigo,
			CONCAT (U.Nombres, ' ', U.Apellidos) as Nombres ,
			U.LoginUsuario,
			U.FlgHabilitado,
			U.clave,
			U.IdPerfil
		FROM	[dbo].[GRUsuario] U
		INNER JOIN GRPerfil P ON P.IdPerfil = U.IdPerfil
		left JOIN GRGrupoUsuario GU ON GU.IdUsuarioVendedor = U.IdUsuario
		WHERE
		(@IdPerfil != 4 or gu.FlgHabilitado is not null ) and
		(@Nombres='' OR U.Nombres	=	@Nombres) AND 
		(@LoginUsuario='' OR U.LoginUsuario	=	@LoginUsuario) AND 
		(@FlgHabilitado='' OR U.FlgHabilitado	=	@FlgHabilitado) AND 
		(@clave='' OR U.clave	=	@clave) AND 
		(@IdPerfil='' OR U.IdPerfil	=	@IdPerfil) and
			((@coordinadores IS NULL ) OR (ltrim(rtrim(gu.IdUsuarioCoordinador)) 
				IN ( ( SELECT ltrim(rtrim(SPLITVALUE)) FROM dbo.SPLIT_2(@coordinadores,','))))) 
		
	END

END










GO
/****** Object:  StoredProcedure [dbo].[spS_ManSelGRPerfilAll]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* 
Purpose	: Obtiene un registro de la tabla	[dbo].[GRPerfil]
Author	: Script Auto Generado
Date	: 14/09/2017

Parameters IN 
Test
exec: [dbo].[spS_ManSelGRPerfilAll] 
	@IdPerfil,
	@Nombre,
	@Descripcion,
	@FlgHabilitado

Modifications
	1.-
*/
CREATE PROCEDURE [dbo].[spS_ManSelGRPerfilAll]
(
	@Descripcion	VARCHAR	(100),
	@FlgHabilitado	VARCHAR	(10)
)
AS
BEGIN
	SELECT
	IdPerfil,
	Descripcion,
	FlgHabilitado
	FROM	[dbo].[GRPerfil]
	WHERE
	(@Descripcion='' OR Descripcion	=	@Descripcion) AND 
	(@FlgHabilitado='' OR FlgHabilitado	=	@FlgHabilitado)

END










GO
/****** Object:  StoredProcedure [dbo].[spS_ManSelGRSubTipoActividadAll]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spS_ManSelGRSubTipoActividadAll] ( 
	@Codigo BIGINT = 0,
	@filtroCanal VARCHAR(MAX)='-1',
	@filtroTipoActividad VARCHAR(MAX)='-1',
	@filtroUsuario BIGINT =1
)
AS
    BEGIN
		
		DECLARE @IDPERFIL BIGINT,@FILTROCANALUSUARIO BIGINT;
		SELECT @FILTROCANALUSUARIO=IdCanal,@IDPERFIL=IdPerfil FROM GRUsuario WHERE IdUsuario = @filtroUsuario

        SELECT  C.IDSubTipoActividad ,
                C.Codigo ,
                C.Descripcion ,
                C.FlgHabilitado ,
                C.idtipoactividad
        FROM    [dbo].GRSubTipoActividad C
		WHERE (@filtroCanal ='-1' or C.idTipoActividad in (select Id from grtipoactividad where idcanal in (SELECT  SplitValue FROM dbo.Split_2(@filtroCanal, ',') ) ))
		 AND  (@IDPERFIL=2 or C.idTipoActividad in (select Id from grtipoactividad where idcanal=@FILTROCANALUSUARIO ))  
		 AND  (@filtroTipoActividad = '-1' OR c.idtipoactividad in (SELECT  SplitValue FROM dbo.Split_2(@filtroTipoActividad, ',')))
		--WHERE   C.idtipoactividad = @Codigo;
    END;









GO
/****** Object:  StoredProcedure [dbo].[spS_ManSelGRSubTipoActividadByType]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spS_ManSelGRSubTipoActividadByType] ( @Codigo BIGINT = 0 )
AS
    BEGIN	
        SELECT  C.IDSubTipoActividad ,
                C.Codigo ,
                C.Descripcion ,
                C.FlgHabilitado ,
                C.idtipoactividad
        FROM    [dbo].GRSubTipoActividad C
        WHERE   C.idtipoactividad = @Codigo;
    END;





GO
/****** Object:  StoredProcedure [dbo].[spS_ManSelGRSubTipoActividadPaginate]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spS_ManSelGRSubTipoActividadPaginate]
(
	@Codigo	VARCHAR	(100)= '',  	
	@Descripcion	VARCHAR	(100) = '',  	
	@FlgHabilitado	VARCHAR	(1)= 'T',
	@TipoActividad varchar(50) = '',
	@page int,  
    @rows int  
)
AS
BEGIN
	DECLARE @MAXIMO INT                                        
	DECLARE @MINIMO INT                                        
	DECLARE @TAMTOLAL INT 
	
	SELECT @MAXIMO = (@page * @rows)                                              
	SELECT @MINIMO = @MAXIMO - (@rows - 1) 
	SELECT ROW_NUMBER() OVER (ORDER BY C.IDSubTipoActividad) item,
		C.IDSubTipoActividad
		,C.Codigo
		,C.Descripcion
		,C.FlgHabilitado
		,c.idtipoactividad
		,TipoActividad = t.nombre
	INTO #tmp
	FROM [dbo].GRSubTipoActividad C
	left outer join GRTipoActividad t on c.idtipoactividad = t.id
	WHERE (@Descripcion=''
			OR C.Descripcion	LIKE '%' +	@Descripcion + '%'
		  ) 
			AND (@Codigo=''
			OR C.Codigo	LIKE '%' +	@Codigo + '%'
		  ) 
		  AND ( FlgHabilitado = ''
                      OR c.FlgHabilitado LIKE '%' + @FlgHabilitado + '%'
                    )
		  AND( @TipoActividad = 0 
		  OR c.idtipoactividad = @TipoActividad);
	
	DECLARE @TOTAL INT = (select count(*) from #tmp)
	select *, @TOTAL as total                  
	from  #tmp
	where item between ((@page - 1) * @rows + 1) AND (@page * @rows) 
END







GO
/****** Object:  StoredProcedure [dbo].[spS_ManSelGRSubTipoActividadValida]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spS_ManSelGRSubTipoActividadValida]
(	
	@IDSubTipoActividad	VARCHAR	(10),
	@Codigo	VARCHAR	(10)
)
AS
BEGIN
	SELECT
	case WHEN Codigo=@Codigo THEN 'El Codigo ya se encuentra registrado'
	end Mensaje	, 
	Codigo,
	Descripcion,
	FlgHabilitado
	FROM	[dbo].GRSubTipoActividad
	WHERE	
	(@IDSubTipoActividad =0 OR IDSubTipoActividad !=	@IDSubTipoActividad)-- AND 
	--(@Codigo = '' OR Codigo	=	@Codigo )

END










GO
/****** Object:  StoredProcedure [dbo].[spS_ManSelGRTipoActividad]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spS_ManSelGRTipoActividad] ( @Id int )
AS
    BEGIN
        SELECT  id ,
                Codigo ,
                Nombre,
				IdCanal,
				meta
        FROM    dbo.GRTipoActividad
        WHERE   Id = @Id;
    END;







GO
/****** Object:  StoredProcedure [dbo].[spS_ManSelGRTipoActividadAll]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spS_ManSelGRTipoActividadAll]
    (
      @Codigo VARCHAR(50)='' ,
      @Nombre VARCHAR(150)='' ,
      @Canal bigint=0,
	  @flag CHAR(1)='T',
	  @filtroCanal varchar(max) ='-1',
	  @filtroUsuario bigint =1
    )
AS
    BEGIN
		DECLARE @IDPERFIL BIGINT,@FILTROCANALUSUARIO BIGINT;
		SELECT @FILTROCANALUSUARIO=IdCanal,@IDPERFIL=IdPerfil FROM GRUsuario WHERE IdUsuario = @filtroUsuario

        SELECT  id,
				codigo ,
                nombre ,
                IdCanal,
				FlagTA
        FROM    [dbo].GRTipoActividad
        WHERE   ( @Codigo = '' OR Codigo = @Codigo)
            AND ( @Nombre = '' OR Nombre LIKE '%'+ @Nombre+'%')
            AND ( @Canal = 0 OR IdCanal = @Canal)
			AND ( @flag = '' OR FlagTA = @flag)
		    AND (@filtroCanal= '-1' or IdCanal in (SELECT SplitValue FROM dbo.Split_2(@filtroCanal, ',')))
			AND (@IDPERFIL=2 OR IdCanal=@FILTROCANALUSUARIO);  

    END;








GO
/****** Object:  StoredProcedure [dbo].[spS_ManSelGRTipoActividadAllPaginate]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spS_ManSelGRTipoActividadAllPaginate]
    (
      @Codigo VARCHAR(50)='' ,
      @Nombre VARCHAR(150)='' ,
      @Flag VARCHAR(10)='T' ,
	  @Canal varchar(50)= '',
      @page INT ,
      @rows INT  
    )
AS
    BEGIN
        DECLARE @MAXIMO INT;                                        
        DECLARE @MINIMO INT;                                        
        DECLARE @TAMTOLAL INT; 
	
        SELECT  @MAXIMO = ( @page * @rows );                                              
        SELECT  @MINIMO = @MAXIMO - ( @rows - 1 ); 
        SELECT  ROW_NUMBER() OVER ( ORDER BY Id ) item ,
                t.Id ,
                t.codigo ,
                t.nombre ,
				Canal = c.Nombre,
				FlagTA,
				t.IdCanal                
        INTO    #tmp
        FROM    [dbo].GRTipoActividad t
		left outer join GRCanal c on t.IdCanal = c.IdCanal
        WHERE   ( @Codigo = ''
                  OR t.codigo LIKE '%' + @Codigo + '%'
                )
                AND ( @Nombre = ''
                      OR t.nombre LIKE '%' + @Nombre + '%'
                    )
                AND ( @Flag = ''
                      OR flagTA LIKE '%' + @Flag + '%'
                    )
					AND ( @Canal = 0
                      OR t.IdCanal = @Canal
                    ); 
	
        DECLARE @TOTAL INT = ( SELECT   COUNT(*)
                               FROM     #tmp
                             );
        SELECT  * ,
                @TOTAL AS total
        FROM    #tmp
        WHERE   item BETWEEN ( ( @page - 1 ) * @rows + 1 ) AND ( @page * @rows ); 
    END;








GO
/****** Object:  StoredProcedure [dbo].[spS_ManSelGrupoAllPaginate]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spS_ManSelGrupoAllPaginate]
(
	@Codigo	VARCHAR	(50),
	@Nombre	VARCHAR	(50),
	@flag varchar(1),
	@page int,  
    @rows int  
)
AS
BEGIN
	DECLARE @MAXIMO INT                                        
	DECLARE @MINIMO INT                                        
	DECLARE @TAMTOLAL INT 
	
	SELECT @MAXIMO = (@page * @rows)                                              
	SELECT @MINIMO = @MAXIMO - (@rows - 1) 
	SELECT ROW_NUMBER() OVER (ORDER BY g.IDGrupo) item
	,g.IDGrupo
	,g.Codigo
	,g.Nombre
	,g.IdNivel
	,Nivel=''
	,g.CodigoPadreGrupo
	,PadreDescrip=gp.Nombre
	,g.FlgHabilitado
	,g.tipo		
	INTO #tmp
	--select *
	FROM	[dbo].GRGrupo g
	left outer join dbo.GRGrupo gp on gp.IDGrupo=g.CodigoPadreGrupo --and gp.IdNivel='1'
	WHERE
	(@Codigo='' OR g.Codigo	LIKE '%' +	@Codigo + '%') AND 
	(@Nombre='' OR g.Nombre LIKE '%' +	@Nombre + '%') AND 
	g.FlgHabilitado = @flag
	
	DECLARE @TOTAL INT = (select count(*) from #tmp)
	select *, @TOTAL as total                  
	from  #tmp
	where @page=0 or item between ((@page - 1) * @rows + 1) AND (@page * @rows) 
END





GO
/****** Object:  StoredProcedure [dbo].[spS_ManSelGrupoDetalleAllPaginate]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spS_ManSelGrupoDetalleAllPaginate]
    (
      @IdGrupo VARCHAR(50) ,
      @Codigo VARCHAR(50) ,
      @Nombre VARCHAR(50) ,
      @flag VARCHAR(1) ,
      @page INT ,
      @rows INT  
    )
AS
    BEGIN
        IF @IdGrupo = ''
            OR @IdGrupo = '0'
            SET @IdGrupo = NULL;
        SELECT  ROW_NUMBER() OVER ( ORDER BY g.IdGrupoDetalle ) item ,
                g.IdGrupoDetalle ,
                g.IdGrupo ,
                g.Codigo ,
                g.Nombre ,
                Grupo = ge.Nombre ,
                ge.CodigoPadreGrupo ,
                g.IdCodigoDetallePadre ,
                DetallePadre = gp.Nombre ,
                Padre = geP.Nombre ,
                g.FlgHabilitado
        INTO    #tmp
	--select *
        FROM    [dbo].GRGrupoDetalle g
                LEFT OUTER JOIN GRGrupo ge ON ge.IDGrupo = g.IdGrupo
                LEFT OUTER JOIN GRGrupo geP ON ge.CodigoPadreGrupo = geP.IDGrupo
                LEFT OUTER JOIN GRGrupoDetalle gp ON gp.IdGrupo = geP.IDGrupo
                                                     AND gp.Codigo = g.IdCodigoDetallePadre
        WHERE   ( @IdGrupo IS NULL
                  OR g.IdGrupo = @IdGrupo
                )
                AND ( @Codigo = ''
                      OR g.Codigo LIKE '%' + @Codigo + '%'
                    )
                AND ( @Nombre = ''
                      OR g.Nombre LIKE '%' + @Nombre + '%'
                    )
                AND g.FlgHabilitado = @flag;
	
        DECLARE @TOTAL INT = ( SELECT   COUNT(*)
                               FROM     #tmp
                             );
        SELECT  * ,
                @TOTAL AS total
        FROM    #tmp
        WHERE   @page = 0
                OR item BETWEEN ( ( @page - 1 ) * @rows + 1 ) AND ( @page
                                                              * @rows ); 
    END;










GO
/****** Object:  StoredProcedure [dbo].[spS_ManSelGrupoDetalleValida]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spS_ManSelGrupoDetalleValida]
(
	@IdGrupoDetalle	BIGINT,
	@IdGrupo	bigint,
	@Codigo	VARCHAR	(50),
	@Nombre	VARCHAR	(50)
)
AS
BEGIN
	SELECT
	case WHEN Codigo=@Codigo THEN 'EL Codigo ya se encuentra registrado'
	WHEN Nombre=@Nombre THEN 'El Nombre ya se encuentra registrado'
	end Mensaje	
	FROM	[dbo].GRGrupoDetalle
	WHERE
	(@IdGrupoDetalle =0 OR IdGrupoDetalle	!=	@IdGrupoDetalle) AND 
	((@Codigo = '' OR (Codigo	=	@Codigo and IdGrupo=@IdGrupo)) or
	(@Nombre = '' OR (Nombre	=	@Nombre and IdGrupo=@IdGrupo)))

END










GO
/****** Object:  StoredProcedure [dbo].[spS_ManSelGrupoValida]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spS_ManSelGrupoValida]
(
	@IDGrupo	BIGINT,
	@Codigo	VARCHAR	(50),
	@Nombre	VARCHAR	(50)
)
AS
BEGIN
	SELECT
	case WHEN Codigo=@Codigo THEN 'EL Codigo ya se encuentra registrado'
	WHEN Nombre=@Nombre THEN 'El Nombre ya se encuentra registrado'
	end Mensaje	
	FROM	[dbo].GRGrupo
	WHERE
	(@IDGrupo =0 OR IDGrupo	!=	@IDGrupo) AND 
	((@Codigo = '' OR (Codigo	=	@Codigo )) or
	(@Nombre = '' OR (Nombre	=	@Nombre )))

END










GO
/****** Object:  StoredProcedure [dbo].[spS_ManSelGRUsuario]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spS_ManSelGRUsuario]
(
	@IdUsuario	varchar(10)
)
AS
BEGIN
	SELECT
	IdUsuario,
	Codigo,
	Nombres,
	Apellidos,
	LoginUsuario,
	Email,
	FlgHabilitado,
	clave,
	IdPerfil,
	ISNULL(IdCanal,0)IdCanal,
	ISNULL(IdZona,0)IdZona,
	FlagAutenticacionAD
	FROM	[dbo].[GRUsuario]
	WHERE	IdUsuario	=	@IdUsuario

END










GO
/****** Object:  StoredProcedure [dbo].[spS_ManSelGRUsuarioAll]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* 
Purpose	: Obtiene un registro de la tabla	[dbo].[GRUsuario]
Author	: Script Auto Generado
Date	: 14/09/2017

Parameters IN 

Test
exec: [dbo].[spS_ManSelGRUsuarioAll] 
	@IdUsuario,
	@Codigo,
	@Nombres,			 	
	@LoginUsuario,	   	
	@FlgHabilitado,
	@clave,
	@IdPerfil

Modifications
	1.-
*/
CREATE PROCEDURE [dbo].[spS_ManSelGRUsuarioAll]
(
	@Codigo	VARCHAR	(10),
	@Nombres	VARCHAR	(80),
	--@Apellidos	VARCHAR	(80),
	@LoginUsuario	VARCHAR	(10),
	--@Email	VARCHAR	(100),
	@FlgHabilitado	VARCHAR	(10),
	@clave	VARCHAR	(300),
	@IdPerfil	BIGINT,
	@IdZona	BIGINT,
	@IdCanal	BIGINT,
	@filtroCanal varchar(max) ='-1',
	@filtroUsuario bigint = 1
)
AS -- [spS_ManSelGRUsuarioAll] '','','','','',0,0,0
BEGIN
	 
	DECLARE @IDUSUARIOLOGUEADO BIGINT;
	DECLARE @IDPERFILUSUARIOLOGUEADO BIGINT;

	SELECT @IDUSUARIOLOGUEADO=IdUsuario,@IDPERFILUSUARIOLOGUEADO=IdPerfil FROM GRUsuario WHERE IdUsuario=@FiltroUsuario

	SELECT
		U.IdUsuario,
		U.Codigo,
		CONCAT (U.Nombres, ' ', U.Apellidos) as Nombres ,
		--Apellidos,
		U.LoginUsuario,
		--Email,
		U.FlgHabilitado,
		U.clave,
		U.IdPerfil,
		isnull(U.IdCanal,0) as IdCanal,
		isnull(U.IdZona,0) as IdZona
	FROM	[dbo].[GRUsuario] U
	INNER JOIN GRPerfil P ON P.IdPerfil = U.IdPerfil
	WHERE
	(@IDPERFILUSUARIOLOGUEADO=2 or IdUsuario=@IDUSUARIOLOGUEADO) AND
	--(@Codigo='' OR U.Codigo	=	@Codigo) AND 
	(@Nombres='' OR U.Nombres	=	@Nombres) AND 
	--(@Apellidos='' OR Apellidos	=	@Apellidos) AND 
	(@LoginUsuario='' OR U.LoginUsuario	=	@LoginUsuario) AND 
	--(@Email='' OR Email	=	@Email) AND 
	(@FlgHabilitado='' OR U.FlgHabilitado	=	@FlgHabilitado) AND 
	(@clave='' OR U.clave	=	@clave) AND 
	(@IdPerfil='' OR U.IdPerfil	=	@IdPerfil) AND 
	(@IdZona='' OR U.IdZona	=	@IdZona) AND 
	(@IdCanal='' OR U.IdCanal	=	@IdCanal) AND
	(@filtroCanal= '-1' or U.IdCanal in (SELECT SplitValue FROM dbo.Split_2(@filtroCanal, ',')))
	
	

END




GO
/****** Object:  StoredProcedure [dbo].[spS_ManSelGRUsuarioAllPaginate]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spS_ManSelGRUsuarioAllPaginate]
    (
      @Codigo VARCHAR(10) ,
      @Nombres VARCHAR(200) ,
      @LoginUsuario VARCHAR(10) ,
      @FlgHabilitado VARCHAR(10) ,
      @IdCanal BIGINT ,
      @IdZona BIGINT ,
      @IdPerfil BIGINT ,
      @page INT ,
      @rows INT  
    )
AS
    BEGIN
        DECLARE @MAXIMO INT;                                        
        DECLARE @MINIMO INT;                                        
        DECLARE @TAMTOLAL INT; 
	
        SELECT  @MAXIMO = ( @page * @rows );                                              
        SELECT  @MINIMO = @MAXIMO - ( @rows - 1 ); 
        SELECT  ROW_NUMBER() OVER ( ORDER BY Nombres ) item ,
                u.IdUsuario ,
                u.Codigo ,
                Nombres = u.Apellidos + ' ' + u.Nombres ,
                u.Apellidos ,
                u.LoginUsuario ,
                u.Email ,
                u.FlgHabilitado ,
                u.Clave ,
                 ISNULL(Z.IdZona,0) IdZona,
                NombreZona = Z.Nombre ,
                ISNULL(u.IdCanal,0)IdCanal ,
                NombreCanal = c.Nombre ,
                u.IdPerfil ,
                NombrePerfil = p.Descripcion
        INTO    #tmp
        FROM    [dbo].[GRUsuario] u
                LEFT OUTER JOIN GRPerfil p ON p.IdPerfil = u.IdPerfil
                LEFT OUTER JOIN dbo.GRZona Z ON Z.IdZona = u.IdZona
                LEFT OUTER JOIN GRCanal c ON c.IdCanal = u.IdCanal
        WHERE   ( @Codigo = ''
                  OR u.Codigo LIKE '%' + @Codigo + '%'
                )
                AND ( @Nombres = ''
                      OR u.Apellidos + u.Nombres LIKE '%' + @Nombres + '%'
                    )
                AND ( @LoginUsuario = ''
                      OR u.LoginUsuario LIKE '%' + @LoginUsuario + '%'
                    )
                AND ( @FlgHabilitado = ''
                      OR u.FlgHabilitado LIKE '%' + @FlgHabilitado + '%'
                    )
                AND ( @IdCanal = 0
                      OR u.IdCanal = @IdCanal
                    )
                AND ( @IdZona = 0
                      OR u.IdZona = @IdZona
                    )
                AND ( @IdPerfil = 0
                      OR u.IdPerfil = @IdPerfil
                    );
	
        DECLARE @TOTAL INT = ( SELECT   COUNT(*)
                               FROM     #tmp
                             );
        SELECT  * ,
                @TOTAL AS total
        FROM    #tmp
        WHERE   item BETWEEN ( ( @page - 1 ) * @rows + 1 ) AND ( @page * @rows ); 
    END;






GO
/****** Object:  StoredProcedure [dbo].[spS_ManSelGRUsuarioValida]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* 
Purpose	: Obtiene un registro de la tabla	[dbo].[GRUsuario]
Author	: Script Auto Generado
Date	: 14/09/2017
Parameters IN 
	@IdUsuario	BIGINT,
	@Codigo	VARCHAR	(10),
	@Nombres	VARCHAR	(80),
	@Apellidos	VARCHAR	(80),
	@LoginUsuario	VARCHAR	(10),
	@Email	VARCHAR	(100),
	@FlgHabilitado	VARCHAR	(10),
	@clave	VARCHAR	(300),
	@IdPerfil	BIGINT

Test
exec: [dbo].[spS_ManSelGRUsuarioValida] 
	@IdUsuario,
	@Codigo,
	@Nombres,
	@Apellidos,
	@LoginUsuario,
	@Email,
	@FlgHabilitado,
	@clave,
	@IdPerfil

Modifications
	1.-
*/
CREATE PROCEDURE [dbo].[spS_ManSelGRUsuarioValida]
(
	
	@IdUsuario	BIGINT,
	@Codigo	VARCHAR	(10),
	@LoginUsuario	VARCHAR	(10)
)
AS
BEGIN
	SELECT
	case WHEN Codigo=@Codigo THEN 'El Codigo ya se encuentra registrado'
	WHEN LoginUsuario=@LoginUsuario THEN 'El Login ya se encuentra registrado'
	end Mensaje	, 
	IdUsuario,
	Codigo,
	Nombres,
	--Apellidos,
	LoginUsuario,
	--Email,
	FlgHabilitado,
	clave,
	IdCanal,
	IdZona,
	IdPerfil
	FROM	[dbo].[GRUsuario]
	WHERE
	(@IdUsuario =0 OR IdUsuario	!=	@IdUsuario) AND 
	--((@Codigo = '' OR Codigo	=	@Codigo ) or
	(@LoginUsuario = '' OR LoginUsuario	=	@LoginUsuario )

END










GO
/****** Object:  StoredProcedure [dbo].[spS_ManSelGRZona]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spS_ManSelGRZona] ( @IdZona BIGINT )
AS
    BEGIN
        SELECT  IdZona ,
                Codigo ,
                Nombre
        FROM    dbo.GRZona
        WHERE   IdZona = @IdZona;
    END;










GO
/****** Object:  StoredProcedure [dbo].[spS_ManSelGRZonaAll]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spS_ManSelGRZonaAll]
    (
      @Codigo VARCHAR(10)='' ,
      @Nombre VARCHAR(80)='' ,
      @flag CHAR(1)='T',
	  @FiltroUsuario BIGINT =1
    )
AS
    BEGIN	 	
		DECLARE @FILTROZONA BIGINT;
		DECLARE @IDPERFIL BIGINT;

		SELECT @FILTROZONA=IdZona,@IDPERFIL=IdPerfil FROM GRUsuario WHERE IdUsuario=@FiltroUsuario

        SELECT  IdZona ,
                Codigo ,
                Nombre ,
                Flag
        FROM    [dbo].GRZona
        WHERE   ( @Codigo = '' OR Codigo = @Codigo)
            AND ( @Nombre = '' OR Nombre LIKE '%'+ @Nombre+'%')
            AND ( @flag = '' OR Flag = @flag)
			AND ( @IDPERFIL=2 OR IdZona=@FILTROZONA);  
    END;









GO
/****** Object:  StoredProcedure [dbo].[spS_ManSelGRZonaAllPaginate]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spS_ManSelGRZonaAllPaginate]
    (
      @Codigo VARCHAR(10) ,
      @Nombre VARCHAR(200) ,
      @Flag VARCHAR(10) ,
      @page INT ,
      @rows INT  
    )
AS
    BEGIN
        DECLARE @MAXIMO INT;                                        
        DECLARE @MINIMO INT;                                        
        DECLARE @TAMTOLAL INT; 
	
        SELECT  @MAXIMO = ( @page * @rows );                                              
        SELECT  @MINIMO = @MAXIMO - ( @rows - 1 ); 
        SELECT  ROW_NUMBER() OVER ( ORDER BY IdZona ) item ,
                IdZona ,
                Codigo ,
                Nombre ,
                flag
        INTO    #tmp
        FROM    [dbo].GRZona
        WHERE   ( @Codigo = ''
                  OR Codigo LIKE '%' + @Codigo + '%'
                )
                AND ( @Nombre = ''
                      OR Nombre LIKE '%' + @Nombre + '%'
                    )
                AND ( @Flag = ''
                      OR flag LIKE '%' + @Flag + '%'
                    ); 
	
        DECLARE @TOTAL INT = ( SELECT   COUNT(*)
                               FROM     #tmp
                             );
        SELECT  * ,
                @TOTAL AS total
        FROM    #tmp
        WHERE   item BETWEEN ( ( @page - 1 ) * @rows + 1 ) AND ( @page * @rows ); 
    END;










GO
/****** Object:  StoredProcedure [dbo].[spS_ManSelSubTipoActividad]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spS_ManSelSubTipoActividad]--spS_ManSelConfiguracionOportunidad '1','1'
    (
      @idCodConf VARCHAR(100) ,
      @idoportunidad VARCHAR(100) ,
      @idPerfilUsuario VARCHAR(100)
    )
AS
    BEGIN

        SELECT  IDSubTipoActividad = cod.IDSubTipoActividad ,
                cod.Etiqueta ,
                CodigoTipoControl = cod.IdTipoControl ,
                cod.CodigoGeneral ,
                Modificable = CASE WHEN coddp.IdPerfil IS NULL THEN 'F'
                                   ELSE cod.Modificable
                              END ,
                cod.Obligatorio ,
                cod.MaxCaracter ,
                codigoControl = ctc.Codigo ,
                cod.IdSubTipoActividadDetalle ,
                odc.ValorControl ,
                idPadre = cod.IdSubTipoActividadDetPadre
        FROM    [dbo].[GRSubTipoActividad_Detalle] cod
                LEFT OUTER JOIN [CFTipoControl] ctc ON ctc.Id = cod.IdTipoControl
                LEFT OUTER JOIN TRActividadDetalleControl odc ON odc.IdActividad = @idoportunidad
                                                              AND odc.IdConfiguracionActividadDetalle = cod.IdSubTipoActividadDetalle
                LEFT OUTER JOIN dbo.GRSubTipoActividad_Detalle_PerfilModifica coddp ON coddp.IdSubTipoActividadDetalle = cod.IdSubTipoActividadDetalle
                                                              AND coddp.IdPerfil = @idPerfilUsuario
                                                              AND cod.IDSubTipoActividad = coddp.IDSubTipoActividad
                                                              AND coddp.FlgHabilitado = 'T'
        WHERE   cod.IDSubTipoActividad = @idCodConf
                AND cod.FlgHabilitado = 'T'
        ORDER BY cod.IdSubTipoActividadDetalle;
    END;











GO
/****** Object:  StoredProcedure [dbo].[spS_ManSelSubTipoActividadDetAll]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spS_ManSelSubTipoActividadDetAll]--[spS_ManSelGREtapaAll]'1'
(
	@IDSubTipoActividad	VARCHAR	(15)	
)
AS
BEGIN
	
	SELECT ROW_NUMBER() OVER (ORDER BY cod.IDSubTipoActividadDetalle) item,	 		
		cod.IDSubTipoActividadDetalle, 
		cod.IDSubTipoActividadDetPadre, 
		DesSubTipoActividadDetPadre=codp.Etiqueta, 
		cod.IDSubTipoActividad,
		cod.Etiqueta, 
		cod.IdTipoControl as IdTipoControl,
		(SELECT Codigo FROM CFTipoControl WHERE Id = cod.IdTipoControl) as TipoControlCodigo ,   		 
		(SELECT Nombre FROM CFTipoControl WHERE Id = cod.IdTipoControl) as TipoControlDescrip ,   		 
		cod.MaxCaracter, 
		cod.CodigoGeneral, 
		DescripcionGeneral=g.Nombre, 
		cod.Obligatorio, 
		cod.Modificable,
		cod.FlgHabilitado,
		cod.FlgPadre,
		Perfiles= (SELECT  STUFF((SELECT distinct',' + convert(nvarchar, edi.IdPerfil) 
			FROM dbo.GRSubTipoActividad_Detalle_PerfilModifica edi
		where edi.IDSubTipoActividadDetalle=cod.IDSubTipoActividadDetalle
	   FOR XML PATH(''), TYPE).value('.[1]', 'nvarchar(4000)'), 1, 1, '')),
	   PerfilesDesc =( SELECT  STUFF((SELECT distinct ',' + convert(nvarchar, p.Descripcion) 
			FROM dbo.GRSubTipoActividad_Detalle_PerfilModifica edi
			left outer join GRPerfil p on p.IdPerfil=edi.IdPerfil
			where edi.IDSubTipoActividadDetalle=cod.IDSubTipoActividadDetalle
	   FOR XML PATH(''), TYPE).value('.[1]', 'nvarchar(4000)'), 1, 1, ''))
	FROM	[dbo].GRSubTipoActividad_Detalle cod
	left outer join GRGrupo g on cod.CodigoGeneral=g.IDGrupo
	left outer join dbo.GRSubTipoActividad_Detalle codP on codP.IdTipoControl='4' and 
		cod.IDSubTipoActividadDetPadre=codp.IDSubTipoActividadDetalle
	WHERE
	(@IDSubTipoActividad='' OR cod.IDSubTipoActividad	=	@IDSubTipoActividad) 	   	

END











GO
/****** Object:  StoredProcedure [dbo].[spS_ManSelUsuarioVendedores]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[spS_ManSelUsuarioVendedores](--spS_ManSelUsuarioVendedores '78'
	@Coordinador varchar(20)
)
AS
BEGIN 
	select sel=case when gu.IdUsuarioCoordinador is null then 'F' else 'T' end ,u.IdUsuario,u.Codigo, Nombres= u.Apellidos +' '+ u.Nombres,u.LoginUsuario,u.Email,u.FlgHabilitado,u.clave,u.IdPerfil from GRUsuario u 
	left outer join GRGrupoUsuario gu on gu.IdUsuarioVendedor=u.IdUsuario and gu.IdUsuarioCoordinador=@Coordinador
	where IdPerfil='4'
END










GO
/****** Object:  StoredProcedure [dbo].[spS_ManUpdCliente]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spS_ManUpdCliente]
    (
      @CLI_PK BIGINT ,
      @Razon_Social VARCHAR(50) ,
      @RUC VARCHAR(11) ,
      @Direccion VARCHAR(200) ,
      @Referencia VARCHAR(200) ,
      @IdCanal BIGINT ,
      @IdsZona VARCHAR(MAX)
    )
AS
    BEGIN
        UPDATE  [dbo].GRCliente
        SET     Razon_Social = @Razon_Social ,
                RUC = @RUC ,
                Direccion = @Direccion ,
                Referencia = @Referencia ,
                IdCanal =  @IdCanal
        WHERE   CLI_PK = @CLI_PK;
		DELETE FROM dbo.GRClienteZona WHERE idCliente=@CLI_PK

		 INSERT  INTO dbo.GRClienteZona
                ( idCliente ,
                  idZona
                )
                SELECT  @CLI_PK ,
                        SPLITVALUE
                FROM    dbo.SPLIT(@IdsZona, ',');

    END;



GO
/****** Object:  StoredProcedure [dbo].[spS_ManUpdClienteActivate]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[spS_ManUpdClienteActivate]
(
	@CLI_PK	BIGINT,
	@flag varchar(1)
)
AS
BEGIN
	UPDATE [dbo].GRCliente
	SET
	FlgHabilitado	=	@flag
	WHERE	CLI_PK	=	@CLI_PK	
END










GO
/****** Object:  StoredProcedure [dbo].[spS_ManUpdGRContacto]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spS_ManUpdGRContacto]
    (
      @IdContacto BIGINT ,
      @Nombre VARCHAR(150) ,
      @Telefono VARCHAR(50) ,
      @Email VARCHAR(50) ,
      @Cargo VARCHAR(50) ,
      @IdCliente BIGINT ,
      @IdZona BIGINT
    )
AS
    BEGIN
        UPDATE  [dbo].[GRContacto]
        SET     [Nombre] = @Nombre ,
                [Telefono] = @Telefono ,
                [Email] = @Email ,
                Cargo = @Cargo ,
                [IdCliente] = @IdCliente ,
                [IdZona] = @IdZona
        WHERE   IdContacto = @IdContacto;
    END;








GO
/****** Object:  StoredProcedure [dbo].[spS_ManUpdGRContactoActivate]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spS_ManUpdGRContactoActivate] ( @IdContacto BIGINT )
AS
    BEGIN
        UPDATE  [dbo].[GRContacto]
        SET     Flag = 'T'
        WHERE   IdContacto = @IdContacto;	
    END;









GO
/****** Object:  StoredProcedure [dbo].[spS_ManUpdGRContactoDisabled]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spS_ManUpdGRContactoDisabled] ( @IdContacto BIGINT )
AS
    BEGIN
        UPDATE  [dbo].[GRContacto]
        SET     Flag = 'F'
        WHERE   IdContacto = @IdContacto;	
    END;









GO
/****** Object:  StoredProcedure [dbo].[spS_ManUpdGROportunidadBand]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spS_ManUpdGROportunidadBand]--spS_ManUpdGROportunidadBand 2
( 
	@IdOportunidad bigint,
	@IdConfiguracionOportunidad	bigint,
	@ExisteCliente	char(1)			  ,
	@IdUsuarioResponsable	bigint	  ,
	@idCliente	bigint				  ,

	@Razon_Social	varchar(50),
	@RUC	varchar	(11)	   ,
	@CodRubro	varchar(15)	   ,
	@CodRegion	varchar(15)	   ,
	@CodCanal	varchar(15)	   ,
	@lstCrt AS dbo.LstControlDina READONLY
)
AS
BEGIN
	if @ExisteCliente = 'F' begin
		insert into GRCliente(Razon_Social,RUC,/*CodRubro,CodRegion,CodCanal,*/FlgHabilitado)
		values (@Razon_Social,@RUC,/*@CodRubro,@CodRegion,@CodCanal,*/'T')
		set @idCliente= (SELECT CAST(scope_identity() AS int))
	end

	update GROportunidad 
		set IdConfiguracionOportunidad=@IdConfiguracionOportunidad,
			ExisteCliente=@ExisteCliente,IdUsuarioResponsable=@IdUsuarioResponsable,
			idCliente=@idCliente
	where IdOportunidad=@IdOportunidad

	--declare @IdOportunidad int 
	--set @IdOportunidad=(SELECT CAST(scope_identity() AS int))

	delete from TROportunidadDetalleControl where IdOportunidad=@IdOportunidad
	insert into TROportunidadDetalleControl(IdOportunidad,IdConfiguracionoportunidadDetalle,ValorControl,IdGeneral)
	select @IdOportunidad,id,valor,(select CodigoGeneral from GRConfiguracionOportunidad_Detalle where IdConfiguracionoportunidadDetalle=id) from @lstCrt
	--values (@IdOportunidad,@IdCon,figuracionoportunidadDetalle,@ValorControl,(select CodigoGeneral from GRConfiguracionOportunidad_Detalle where IdConfiguracionoportunidadDetalle=@IdConfiguracionoportunidadDetalle))
	SELECT @IdOportunidad
end










GO
/****** Object:  StoredProcedure [dbo].[spS_ManUpdGROportunidadEtapaBand]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spS_ManUpdGROportunidadEtapaBand]--spS_ManUpdGROportunidadEtapaBand 2
( 
	@IdOportunidad bigint,
	@CambiaEtapa	char(1),
	@lstCrt AS dbo.LstControlDina READONLY,
	@IdUsuario varchar (20)
)
AS
BEGIN
	declare @idetapaNew varchar(10),@idetapaActual varchar(10)
	--set @idetapaNew= (select e.IdEtapa from GROportunidad o inner join GREtapa e on e.EtapaPredecesora=o.IdEtapaActual where IdOportunidad=@IdOportunidad)

	select @idetapaNew=e.IdEtapa,@idetapaActual=o.IdEtapaActual from GROportunidad o 
	left outer join GREtapa e on e.EtapaPredecesora=o.IdEtapaActual and e.FlgHabilitado='T'
	where IdOportunidad=@IdOportunidad
	/*si @idetapaNew is null? dar a ganado*/

	if @CambiaEtapa = 'T' begin
		if @idetapaNew is null 
		begin
			update TROportunidadEtapa
				set IdEstado='2',FechaFinCambioEtapa=GETDATE()
			where IdOportunidad=@IdOportunidad and IdEtapa= @idetapaActual

			update GROportunidad set IDEstadoActual='2' where IdOportunidad=@IdOportunidad
			
			delete from TREtapaDetalleControl where IdOportunidad=@IdOportunidad and IdEtapa=@idetapaActual

			insert into TREtapaDetalleControl(IdOportunidad,IdEtapa,IdEtapaDetalle,ValorControl,IdFoto)
			select @IdOportunidad,@idetapaActual,id,valor,null from @lstCrt
		end
		else
		begin
			insert into TROportunidadEtapa(IdOportunidad,IdEtapa,IdEstado,IdUsuario,FechaCambioEtapa,FechaFinCambioEtapa)
			values (@IdOportunidad,@idetapaNew,'1',@IdUsuario,GETDATE(),null)
			/*Etapa anterior se debe cerrar?*/
			update TROportunidadEtapa
				set IdEstado='3',FechaFinCambioEtapa=GETDATE()
			where IdOportunidad=@IdOportunidad and IdEtapa= @idetapaActual

			update GROportunidad set IdEtapaActual=@idetapaNew where IdOportunidad=@IdOportunidad

			delete from TREtapaDetalleControl where IdOportunidad=@IdOportunidad and IdEtapa=@idetapaActual

			insert into TREtapaDetalleControl(IdOportunidad,IdEtapa,IdEtapaDetalle,ValorControl,IdFoto)
			select @IdOportunidad,@idetapaActual,id,valor,null from @lstCrt
		end
		
		/*
		insert into TROportunidadDetalleControl(IdOportunidad,IdConfiguracionoportunidadDetalle,ValorControl,IdGeneral)
		select @IdOportunidad,id,valor,(select CodigoGeneral from GRConfiguracionOportunidad_Detalle where IdConfiguracionoportunidadDetalle=id) from @lstCrt
		*/
		
	end
	else
	begin
		delete from TREtapaDetalleControl where IdOportunidad=@IdOportunidad and IdEtapa=@idetapaActual

			insert into TREtapaDetalleControl(IdOportunidad,IdEtapa,IdEtapaDetalle,ValorControl,IdFoto)
			select @IdOportunidad,@idetapaActual,id,valor,null from @lstCrt
	end
end










GO
/****** Object:  StoredProcedure [dbo].[sps_ManUpdGRSubTipoActividad]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  procedure [dbo].[sps_ManUpdGRSubTipoActividad]
(
@IDSubTipoActividad varchar(100),
@codigo varchar(100)='',
@Descripcion varchar(100),
@TipoActividad int,
@lstCrt AS dbo.LstSubTipoActividadDetalle READONLY
)
as
begin
	update dbo.GRSubTipoActividad
	set Descripcion=@Descripcion, idtipoactividad=@TipoActividad
	where IDSubTipoActividad=@IDSubTipoActividad

	select id=ROW_NUMBER() over(order by case when IdSubTipoActividadDetPadre='' then 0 else 1 end) ,
	* into #tmplist from @lstCrt
	
	declare @fila int =1,@IdConOpDet varchar(100),@filas int=(select count(1) from #tmplist)

	while @filas>=@fila
	begin
		print '1'
		declare @Perfiles varchar(max),@filaDat varchar(100)

		select @Perfiles=perfiles,@filaDat=fila,@IdConOpDet=isnull(IdSubTipoActividadDetalle,'') from #tmplist where id =@fila
		
		if @IdConOpDet='' or @IdConOpDet='0'
		begin
			print 'insert '+@Perfiles
			insert into dbo.GRSubTipoActividad_Detalle(IDSubTipoActividad,Etiqueta,IdTipoControl
			,CodigoGeneral,Modificable,Obligatorio,MaxCaracter,FlgHabilitado,FlgPadre)
			select @IDSubTipoActividad,Etiqueta,IdTipoControl
			,CodigoGeneral,Modificable,Obligatorio,MaxCaracter,FlgHabilitado,FlgPadre
			from #tmplist tl where id=@fila

			set @IdConOpDet= (SELECT CAST(scope_identity() AS int))
			
			insert into dbo.GRSubTipoActividad_Detalle_PerfilModifica
			(IDSubTipoActividad,IDSubTipoActividadDetalle,IdPerfil,FlgHabilitado)
				SELECT @IDSubTipoActividad,@IdConOpDet, SPLITVALUE,'T' FROM dbo.SPLIT_2(@Perfiles,',') where SPLITVALUE!=''

			update #tmplist
			set IdSubTipoActividadDetalle=@IdConOpDet
			where fila=@filaDat

			if (select IdSubTipoActividadDetPadre from #tmplist where id=@fila)!=''
			begin
				update a
				set a.IdSubTipoActividadDetPadre=c.IdSubTipoActividadDetalle
				from GRSubTipoActividad_Detalle a
				inner join #tmplist b on a.IdSubTipoActividadDetalle=b.IdSubTipoActividadDetalle
				inner join #tmplist c on b.IdSubTipoActividadDetPadre=c.fila
				where b.id=@fila
			end
		
		end
		else
		begin
		print 'update '+@Perfiles
			update a
			set a.Etiqueta=b.Etiqueta,a.IdTipoControl=b.IdTipoControl
			,a.CodigoGeneral=b.CodigoGeneral,a.Modificable=b.Modificable,a.Obligatorio=b.Obligatorio,
			a.MaxCaracter=b.MaxCaracter,a.FlgHabilitado=b.FlgHabilitado,a.FlgPadre=b.FlgPadre
			from GRSubTipoActividad_Detalle a
			inner join #tmplist b on a.IdSubTipoActividadDetalle=b.IdSubTipoActividadDetalle
			where b.id=@fila

			if (select IdSubTipoActividadDetPadre from #tmplist where id=@fila)!=''
			begin
			print '1'
				update a
				set a.IdSubTipoActividadDetPadre=c.IdSubTipoActividadDetalle
				from GRSubTipoActividad_Detalle a
				inner join #tmplist b on a.IdSubTipoActividadDetalle=b.IdSubTipoActividadDetalle
				inner join #tmplist c on b.IdSubTipoActividadDetPadre=c.fila
				where b.id=@fila
			end
			print '2'
			delete from GRSubTipoActividad_Detalle_PerfilModifica 
			where IDSubTipoActividad=@IDSubTipoActividad and IdSubTipoActividadDetalle=@IdConOpDet
			print '3'
			SELECT @IDSubTipoActividad,@IdConOpDet, SPLITVALUE,'T' FROM dbo.SPLIT_2(@Perfiles,',') where SPLITVALUE!=''
			insert into GRSubTipoActividad_Detalle_PerfilModifica
			(IDSubTipoActividad,IdSubTipoActividadDetalle,IdPerfil,FlgHabilitado)
				SELECT @IDSubTipoActividad,@IdConOpDet, SPLITVALUE,'T' FROM dbo.SPLIT_2(@Perfiles,',') where SPLITVALUE!=''

		end
		set @fila= @fila+1
	end
end







GO
/****** Object:  StoredProcedure [dbo].[sps_ManUpdGRSubTipoAtividadActive]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sps_ManUpdGRSubTipoAtividadActive]
(
@IDSubTipoAtividad varchar(100),
@flag varchar(100))
as
begin
	update dbo.GRSubTipoActividad
	set FlgHabilitado=@flag
	where IDSubTipoActividad=@IDSubTipoAtividad
end










GO
/****** Object:  StoredProcedure [dbo].[spS_ManUpdGRTipoActividad]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spS_ManUpdGRTipoActividad]
    (
      @Id int ,
      @Codigo VARCHAR(50) ,
      @Nombre VARCHAR(150),
	  @IdCanal bigint,
	  @meta varchar(100)
    )
AS
    BEGIN
        UPDATE  [dbo].GRTipoActividad
        SET     --Codigo = @Codigo ,
                Nombre = @Nombre,
				IdCanal = @IdCanal,
				meta = @meta
        WHERE   Id = @Id;

    END;
GO
/****** Object:  StoredProcedure [dbo].[spS_ManUpdGRTipoActividadActivate]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--PROCDIMIENTO ALMACENADO ACTIVATE
CREATE PROCEDURE [dbo].[spS_ManUpdGRTipoActividadActivate] ( @Id int )
AS
    BEGIN
        UPDATE  [dbo].[GRTipoActividad]
        SET     FlagTA = 'T'
        WHERE   id = @Id;	
    END;








GO
/****** Object:  StoredProcedure [dbo].[spS_ManUpdGrupo]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spS_ManUpdGrupo]
(
	@IDGrupo	bigint
	,@Nombre	varchar	(50)
	,@IdNivel	int
	,@CodigoPadreGrupo	varchar	(20)
)
AS
BEGIN
	UPDATE	[dbo].grgrupo
	SET Nombre=@Nombre, IdNivel=@IdNivel,CodigoPadreGrupo=@CodigoPadreGrupo
	WHERE	IDGrupo	=	@IDGrupo
END










GO
/****** Object:  StoredProcedure [dbo].[spS_ManUpdGrupoActivate]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spS_ManUpdGrupoActivate]
(
	@IDGrupo	BIGINT,
	@flag varchar(1)
)
AS
BEGIN
	UPDATE [dbo].GRGrupo
	SET
	FlgHabilitado	=	@flag
	WHERE	IDGrupo	=	@IDGrupo
END










GO
/****** Object:  StoredProcedure [dbo].[spS_ManUpdGrupoDetalle]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spS_ManUpdGrupoDetalle]
(
	@IdGrupoDetalle	bigint
	,@Nombre	varchar(50)
	,@IdCodigoDetallePadre	varchar(50)
)
AS
BEGIN
	UPDATE	[dbo].GRGrupoDetalle
	SET Nombre=@Nombre, IdCodigoDetallePadre=@IdCodigoDetallePadre
	WHERE	IdGrupoDetalle	=	@IdGrupoDetalle
END










GO
/****** Object:  StoredProcedure [dbo].[spS_ManUpdGrupoDetalleActivate]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spS_ManUpdGrupoDetalleActivate]
(
	@IdGrupoDetalle	BIGINT,
	@flag varchar(1)
)
AS
BEGIN
	UPDATE [dbo].GRGrupoDetalle
	SET
	FlgHabilitado	=	@flag
	WHERE	IdGrupoDetalle	=	@IdGrupoDetalle	
END










GO
/****** Object:  StoredProcedure [dbo].[spS_ManUpdGRUsuario]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spS_ManUpdGRUsuario]
(
	
	@IdUsuario	BIGINT,
	--@Codigo	VARCHAR	(10),
	@Nombres	VARCHAR	(80),
	@LoginUsuario	VARCHAR	(10),
	@Email	VARCHAR	(100),
	@clave	VARCHAR	(300),
	@vendedores	VARCHAR	(4000),
	@IdPerfil	BIGINT,
	@IdZona	BIGINT,
	@IdCanal	BIGINT,
	@EditPass varchar(1),
	@VerificaAD CHAR(1)
)
AS
BEGIN
	UPDATE	[dbo].[GRUsuario]
	SET
	--Codigo	=	@Codigo,
	Nombres	=	@Nombres,
	LoginUsuario	=	@LoginUsuario,
	Email	=	@Email,
	IdZona	=	@IdZona,
	IdCanal	=	@IdCanal,
	IdPerfil	=	@IdPerfil,
	apellidos ='',
	FlagAutenticacionAD=@VerificaAD
	WHERE	IdUsuario	=	@IdUsuario

	if @EditPass='T' 
		UPDATE	[dbo].[GRUsuario]
		SET
		clave	=	@clave
		WHERE	IdUsuario	=	@IdUsuario

	
	if @vendedores ='' or @vendedores =',' set @vendedores = null
	if @vendedores is not null
	begin		
		
		SELECT @idUsuario,SPLITVALUE,'T' FROM dbo.SPLIT_2(@vendedores,',') where SplitValue!=''
	end
END

GO
/****** Object:  StoredProcedure [dbo].[spS_ManUpdGRUsuarioActivate]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Purpose	: Activa registro en la tabla [dbo].[GRUsuario]
Author	: Script Auto Generado
Date	: 14/09/2017

Parameters IN IdUsuario	BIGINT

Test: No implica test porque realiza modificaciónes en base de datos

Modifications
	1.-
*/
CREATE PROCEDURE [dbo].[spS_ManUpdGRUsuarioActivate]
(
	@IdUsuario	BIGINT
)
AS
BEGIN
	UPDATE [dbo].[GRUsuario]
	SET
	FlgHabilitado	=	'T'
	WHERE	IdUsuario	=	@IdUsuario	
END










GO
/****** Object:  StoredProcedure [dbo].[spS_ManUpdGRUsuarioDesactivate]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Purpose	: Desactiva registro en la tabla [dbo].[GRUsuario]
Author	: Script Auto Generado
Date	: 14/09/2017

Parameters IN IdUsuario	BIGINT

Test: No implica test porque realiza modificaciónes en base de datos

Modifications
	1.-
*/
CREATE PROCEDURE [dbo].[spS_ManUpdGRUsuarioDesactivate]
(
	@IdUsuario	BIGINT
)
AS
BEGIN
	UPDATE [dbo].[GRUsuario]
	SET
	FlgHabilitado	=	'F'
	WHERE	IdUsuario	=	@IdUsuario	
END










GO
/****** Object:  StoredProcedure [dbo].[spS_ManUpdGRZona]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spS_ManUpdGRZona]
    (
      @IdZona BIGINT ,
      @Codigo VARCHAR(10) ,
      @Nombre VARCHAR(80)
    )
AS
    BEGIN
        UPDATE  [dbo].GRZona
        SET     Codigo = @Codigo ,
                Nombre = @Nombre
        WHERE   IdZona = @IdZona;

    END;










GO
/****** Object:  StoredProcedure [dbo].[spS_ManUpdGRZonaActivate]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spS_ManUpdGRZonaActivate] ( @IdZona BIGINT )
AS
    BEGIN
        UPDATE  [dbo].[GRZona]
        SET     Flag = 'T'
        WHERE   IdZona = @IdZona;	
    END;










GO
/****** Object:  StoredProcedure [dbo].[spS_ManUpdGRZonaDisabled]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spS_ManUpdGRZonaDisabled] ( @IdZona BIGINT )
AS
    BEGIN
        UPDATE  [dbo].[GRZona]
        SET     Flag = 'F'
        WHERE   IdZona = @IdZona;	
    END;










GO
/****** Object:  StoredProcedure [dbo].[spS_ManUpdTipoActividadDisabled]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spS_ManUpdTipoActividadDisabled] ( @Id int )
AS
    BEGIN
        UPDATE  [dbo].[GRTipoActividad]
        SET     FlagTA = 'F'
        WHERE   id = @Id;	
    END;








GO
/****** Object:  StoredProcedure [dbo].[spS_ObtenerGrupo]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spS_ObtenerGrupo]	 
(
	@FlgHabilitado	VARCHAR	(10)
)
AS
BEGIN
			 	
	SELECT 
	G.IDGrupo, 
	G.Codigo, 
	G.Nombre, 
	G.IdNivel, 
	G.CodigoPadreGrupo, 
	G.FlgHabilitado
	FROM
	dbo.GRGrupo G
	WHERE	G.FlgHabilitado	=	@FlgHabilitado	   				  	

END











GO
/****** Object:  StoredProcedure [dbo].[spS_ObtenerTipoControl]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spS_ObtenerTipoControl]	 
(
	@FlgHabilitado	VARCHAR	(10)
)
AS
BEGIN
			 	
	SELECT 
	TC.Id, 
	TC.Codigo, 
	TC.Nombre, 
	TC.FlgHabilitado
	FROM
	CFTipoControl TC
	WHERE	TC.FlgHabilitado	=	@FlgHabilitado	   				  	

END











GO
/****** Object:  StoredProcedure [dbo].[spS_RepSelActividadDinamicoAllPaginate]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spS_RepSelActividadDinamicoAllPaginate]
    (
      @FechaInicio VARCHAR(10) ,
      @FechaFin VARCHAR(10) ,
      @Canal VARCHAR(4000) ,
      @Zona VARCHAR(4000) ,
      @TipoActividad VARCHAR(4000) ,
      @DetalleActividad VARCHAR(4000) ,
      @Usuario VARCHAR(4000) ,
      @Cliente VARCHAR(4000) ,
      @page INT ,
      @rows INT,
	  @IdUsuarioLogueado BIGINT
    )
AS -- [dbo].[spS_RepSelActividadDinamicoAllPaginate] '','','','','','','','',1,20
    BEGIN
        DECLARE @MAXIMO INT;
        DECLARE @MINIMO INT;
        DECLARE @TAMTOLAL INT;

        SELECT  @MAXIMO = ( @page * @rows );
        SELECT  @MINIMO = @MAXIMO - ( @rows - 1 );
		
		DECLARE @IDPERFIL BIGINT
		SELECT @IDPERFIL=IdPerfil FROM GRUsuario WHERE IdUsuario=@IdUsuarioLogueado

	   -- GET ACTIVIDAD DATA
        SELECT  ROW_NUMBER() OVER ( ORDER BY A.IdActividad DESC) item ,
                [Codigo] = A.IdActividad ,
                [Fecha] = CONVERT(NVARCHAR(10), ISNULL(A.FechaCreacion, NULL), 103)+' '+CONVERT(NVARCHAR(10), ISNULL(A.FechaCreacion, NULL), 108) ,
                [Canal] = ISNULL(C.Nombre, '') ,
                [Zona] = ISNULL(Z.Nombre, '') ,
                [Tipo Actividad] = ISNULL(TA.nombre, '') ,
                [Sub Tipo Actividad] = ISNULL(DA.Descripcion, '') ,
                [Latitud] = ISNULL(A.Latitud, '') ,
                [Longitud] = ISNULL(A.Longitud, '') ,
                [Usuario] = ISNULL(U.LoginUsuario, '') ,
                [Ruc] = ISNULL(CL.RUC, '') ,
                [Cliente] = ISNULL(CL.Razon_Social, '') ,
                [Contacto] = ISNULL(CO.Nombre, '') ,
                [Telefono] = ISNULL(CO.Telefono, '') ,
                [Email] = ISNULL(CO.Email, '') ,
                [Cargo] = ISNULL(CO.Cargo, '')
        INTO    #TMPOP
        FROM    GRActividad A
                INNER JOIN GRCanal C ON C.IdCanal = A.IdCanal
                INNER JOIN GRCliente CL ON CL.CLI_PK = A.idCliente
                INNER JOIN GRUsuario U ON U.IdUsuario = A.IdUsuarioResponsable
				INNER JOIN GRTipoActividad TA ON TA.Id = A.IdTipoActividad
				LEFT JOIN dbo.GRSubTipoActividad DA ON DA.IDSubTipoActividad = A.idConfiguracionActividad 
                --LEFT JOIN GRClienteZona CZ ON CZ.idCliente = CL.CLI_PK
                INNER JOIN GRZona Z ON Z.IdZona = u.idZona
                INNER JOIN GRContacto CO ON CO.IdContacto = A.idContacto
        WHERE   (@IDPERFIL=2 OR A.IdUsuarioResponsable=@IdUsuarioLogueado)
				AND ( @FechaInicio = ''  OR FORMAT(A.FechaCreacion, 'yyyyMMdd') >= @FechaInicio)
                AND ( @FechaFin = '' OR FORMAT(A.FechaCreacion, 'yyyyMMdd') <= @FechaFin)
                AND ( @Canal = '' OR A.IdCanal IN ( SELECT  SplitValue FROM    dbo.Split_2(@Canal, ',') ))
                AND ( @Zona = '' OR Z.IdZona IN ( SELECT   SplitValue FROM dbo.Split_2(@Zona, ',') ))
                AND ( @TipoActividad = '' OR A.IdTipoActividad IN ( SELECT  SplitValue FROM    dbo.Split_2(@TipoActividad, ',') ))
                AND ( @DetalleActividad = '' OR isnull(A.IdConfiguracionActividad,'-2') IN (SELECT    SplitValue FROM      dbo.Split_2(@DetalleActividad, ',') ))
                AND ( @Usuario = '' OR A.IdUsuarioResponsable IN ( SELECT    SplitValue FROM      dbo.Split_2(@Usuario, ',') ))
                AND ( @Cliente = '' OR A.idCliente IN ( SELECT  SplitValue FROM    dbo.Split_2(@Cliente, ',') ));
		--SELECT * FROM #TMPOP
    /*CONTROLES DINAMICOS*/
        SELECT  IdActividad ,
                Etiqueta = CASE WHEN tc.Codigo = 9 THEN 'DIN_IMG_' + Etiqueta
                                ELSE 'DIN' + Etiqueta
                           END ,
                ValorControl = CASE WHEN tc.Codigo = 3 THEN g.Nombre
                                    ELSE odc.ValorControl
                               END ,
                CodigoTipoControl = IdTipoControl ,
                g.Codigo
        INTO    #TMPCONTROL
        FROM    TRActividadDetalleControl odc
                LEFT OUTER JOIN dbo.GRSubTipoActividad_Detalle cod ON cod.IDSubTipoActividadDetalle = odc.IdConfiguracionActividadDetalle
                LEFT OUTER JOIN CFTipoControl tc ON tc.Id = cod.IdTipoControl
                LEFT OUTER JOIN dbo.GRGrupoDetalle g ON odc.IdGeneral = g.IdGrupo
                                                      AND odc.ValorControl = g.Codigo
        WHERE   tc.Codigo IN ( '1', '3', '4', '5', '6', '9', '10' )
                AND odc.IdActividad IN ( SELECT Codigo
                                         FROM   #TMPOP );


		--SELECT *  FROM #TMPCONTROL ORDER BY IdActividad
        CREATE TABLE #etiquetaTempral
            (
              Etiqueta VARCHAR(MAX) ,
              idActiviadad VARCHAR(MAX)
            );

        INSERT  INTO #etiquetaTempral
                ( Etiqueta ,
                  idActiviadad
                )
                SELECT DISTINCT
                        Etiqueta ,
                        MAX(IdActividad) idactividad
                FROM    #TMPCONTROL
                GROUP BY Etiqueta
                ORDER BY MAX(idactividad) ,
                        Etiqueta;
        DECLARE @ETIQOPORTUNIDAD NVARCHAR(MAX) = '';
        SELECT  @ETIQOPORTUNIDAD += N'[' + Etiqueta + N'],'
        FROM    #etiquetaTempral
        ORDER BY idActiviadad ASC;
        DROP TABLE #etiquetaTempral;
        DECLARE @TOTAL INT = ( SELECT   COUNT(*)
                               FROM     #TMPOP
                             );

        DECLARE @tablaPivot NVARCHAR(MAX) = 'tmp' + FORMAT(GETDATE(),
                                                           'yyyyMMddHHmmss');
    
        --SELECT  @ETIQOPORTUNIDAD += N'[' + Etiqueta + N'],'
        --FROM    ( SELECT DISTINCT
        --                    Etiqueta
        --          FROM      #TMPCONTROL
        --        ) AS i;

        IF LEN(@ETIQOPORTUNIDAD) > 1
            BEGIN
                SET @ETIQOPORTUNIDAD = SUBSTRING(@ETIQOPORTUNIDAD, 1,
                                                 LEN(@ETIQOPORTUNIDAD) - 1);
        --select @ETIQOPORTUNIDAD
                DECLARE @query NVARCHAR(MAX)
            = ' if exists(select * from  sys.objects where name='''
                    + @tablaPivot + ''')' + ' drop table ' + @tablaPivot + ';'
                    + ' SELECT IdActividad, ' + @ETIQOPORTUNIDAD + ' '
                    + ' into ' + @tablaPivot + ' FROM'
                    + ' (SELECT IdActividad,Etiqueta, ValorControl FROM #TMPCONTROL) AS SourceTable'
                    + ' PIVOT' + ' (max(ValorControl)' + ' FOR Etiqueta IN ( '
                    + @ETIQOPORTUNIDAD + ' )' + ' ) AS PivotTable;'
                    + ' select a.*,' + @ETIQOPORTUNIDAD + ' , '
                    + CONVERT(NVARCHAR, @TOTAL) + ' as total from #TMPOP a '
                    + ' left outer join ' + @tablaPivot
                    + ' b on a.Codigo=b.IdActividad'
                    + ' where item between ((' + CONVERT(NVARCHAR, @page)
                    + ' - 1) * ' + CONVERT(NVARCHAR, @rows) + ' + 1) AND ('
                    + CONVERT(NVARCHAR, @page) + ' * '
                    + CONVERT(NVARCHAR, @rows) + ') ' + ' drop table '
                    + @tablaPivot + ' ';
               -- PRINT @query;
                EXECUTE (@query);
            END;
			ELSE 
			BEGIN
				SELECT *, @TOTAL  as total 
				FROM  #TMPOP
				where item between (@page - 1) * (@rows + 1) 
					AND (@page * @rows) 
			END
    END;










GO
/****** Object:  StoredProcedure [dbo].[spS_RepSelActividadDinamicoAllPaginateExcel]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spS_RepSelActividadDinamicoAllPaginateExcel]
    (
      @FechaInicio VARCHAR(10) ,
      @FechaFin VARCHAR(10) ,
      @Canal VARCHAR(4000) ,
      @Zona VARCHAR(4000) ,
      @TipoActividad VARCHAR(4000) ,
      @DetalleActividad VARCHAR(4000) ,
      @Usuario VARCHAR(4000) ,
      @Cliente VARCHAR(4000),
	  @IdUsuarioLogueado BIGINT
    )
AS -- [dbo].[spS_RepSelActividadDinamicoAllPaginateExcel] '','','','','','','',''
    BEGIN
		
		DECLARE @IDPERFIL BIGINT
		SELECT @IDPERFIL=IdPerfil FROM GRUsuario WHERE IdUsuario=@IdUsuarioLogueado

	   -- GET ACTIVIDAD DATA
       SELECT 
			ROW_NUMBER() OVER ( ORDER BY A.IdActividad DESC) item,
			[Codigo] = A.IdActividad,
			[Fecha] = CONVERT(nvarchar(10), ISNULL(A.FechaCreacion, null), 103)+' '+CONVERT(NVARCHAR(10), ISNULL(A.FechaCreacion, NULL), 108) ,
			[Canal] = isnull(C.Nombre,''),
			[Zona] = isnull(Z.Nombre,''),
			[Tipo Actividad] = isnull(TA.nombre,''),
			[Detalle Actividad] = isnull(DA.Descripcion,''),
			[Latitud] = isnull(A.Latitud,''),
			[Longitud] = isnull(A.Longitud,''),
			[Usuario] = isnull(U.LoginUsuario,''),
			[Ruc] = isnull(CL.RUC,''),
			[Cliente] = isnull(CL.Razon_Social,''),
			[Contacto] = isnull(CO.Nombre,''),
			[Telefono] = isnull(CO.Telefono,''),
			[Email] = isnull(CO.Email,''),
			[Cargo] = isnull(CO.Cargo,'')	
		INTO    #TMPOP
		FROM  GRActividad A
        INNER JOIN GRCanal C ON C.IdCanal = A.IdCanal
        INNER JOIN GRCliente CL ON CL.CLI_PK = A.idCliente
        INNER JOIN GRUsuario U ON U.IdUsuario = A.IdUsuarioResponsable
		INNER JOIN GRTipoActividad TA ON TA.Id = A.IdTipoActividad
		LEFT JOIN dbo.GRSubTipoActividad DA ON DA.IDSubTipoActividad = A.idConfiguracionActividad 
        --LEFT JOIN GRClienteZona CZ ON CZ.idCliente = CL.CLI_PK
        INNER JOIN GRZona Z ON Z.IdZona = u.idZona
        INNER JOIN GRContacto CO ON CO.IdContacto = A.idContacto
		WHERE (@IDPERFIL=2 OR A.IdUsuarioResponsable=@IdUsuarioLogueado)
			AND ( @FechaInicio = ''  OR FORMAT(A.FechaCreacion, 'yyyyMMdd') >= @FechaInicio)
            AND ( @FechaFin = '' OR FORMAT(A.FechaCreacion, 'yyyyMMdd') <= @FechaFin)
            AND ( @Canal = '' OR A.IdCanal IN ( SELECT  SplitValue FROM    dbo.Split_2(@Canal, ',') ))
            AND ( @Zona = '' OR Z.IdZona IN ( SELECT   SplitValue FROM dbo.Split_2(@Zona, ',') ))
            AND ( @TipoActividad = '' OR A.IdTipoActividad IN ( SELECT  SplitValue FROM    dbo.Split_2(@TipoActividad, ',') ))
            AND ( @DetalleActividad = '' OR isnull(A.IdConfiguracionActividad,'-2') IN (SELECT    SplitValue FROM      dbo.Split_2(@DetalleActividad, ',') ))
            AND ( @Usuario = '' OR A.IdUsuarioResponsable IN ( SELECT    SplitValue FROM      dbo.Split_2(@Usuario, ',') ))
            AND ( @Cliente = '' OR A.idCliente IN ( SELECT  SplitValue FROM    dbo.Split_2(@Cliente, ',') ));

    /*CONTROLES DINAMICOS*/
        SELECT  IdActividad ,
                Etiqueta = 'DIN' + Etiqueta ,
                ValorControl = CASE WHEN tc.Codigo = 3 THEN g.Nombre
                                    ELSE odc.ValorControl
                               END ,
                CodigoTipoControl = IdTipoControl ,
                g.Codigo
        INTO    #TMPCONTROL
        FROM    TRActividadDetalleControl odc
                LEFT OUTER JOIN dbo.GRSubTipoActividad_Detalle cod ON cod.IDSubTipoActividadDetalle = odc.IdConfiguracionActividadDetalle
                LEFT OUTER JOIN CFTipoControl tc ON tc.Id = cod.IdTipoControl
                LEFT OUTER JOIN GRGrupoDetalle g ON odc.IdGeneral = g.IdGrupo
                                                      AND odc.ValorControl = g.Codigo
        WHERE   tc.Codigo IN ( '1', '3', '4', '5', '6', '10' )
                AND odc.IdActividad IN ( SELECT   IdActividad
                                           FROM     #TMPOP );

        DECLARE @tablaPivot NVARCHAR(MAX) = 'tmp' + FORMAT(GETDATE(),
                                                           'yyyyMMddHHmmss');


     CREATE TABLE #etiquetaTempral
            (
              Etiqueta VARCHAR(MAX) ,
              idActiviadad VARCHAR(MAX)
            );

        INSERT  INTO #etiquetaTempral
                ( Etiqueta ,
                  idActiviadad
                )
                SELECT DISTINCT
                        Etiqueta ,
                        MAX(IdActividad) idactividad
                FROM    #TMPCONTROL
                GROUP BY Etiqueta
                ORDER BY MAX(idactividad) ,
                        Etiqueta;
        DECLARE @ETIQOPORTUNIDAD NVARCHAR(MAX) = '';
        SELECT  @ETIQOPORTUNIDAD += N'[' + Etiqueta + N'],'
        FROM    #etiquetaTempral
        ORDER BY idActiviadad ASC;
        DROP TABLE #etiquetaTempral;

        --DECLARE @ETIQOPORTUNIDAD NVARCHAR(MAX) = '';
        --SELECT  @ETIQOPORTUNIDAD += N'[' + Etiqueta + N'],'
        --FROM    ( SELECT DISTINCT
        --                    Etiqueta
        --          FROM      #TMPCONTROL
        --        ) AS i;

        IF LEN(@ETIQOPORTUNIDAD) > 1
            BEGIN
                SET @ETIQOPORTUNIDAD = SUBSTRING(@ETIQOPORTUNIDAD, 1,
                                                 LEN(@ETIQOPORTUNIDAD) - 1);
        --select @ETIQOPORTUNIDAD
                DECLARE @query NVARCHAR(MAX)
            = ' if exists(select * from  sys.objects where name='''
                    + @tablaPivot + ''')' + ' drop table ' + @tablaPivot + ';'
                    + ' SELECT IdActividad, ' + @ETIQOPORTUNIDAD + ' '
                    + ' into ' + @tablaPivot + ' FROM'
                    + ' (SELECT IdActividad,Etiqueta, ValorControl FROM #TMPCONTROL) AS SourceTable'
                    + ' PIVOT' + ' (max(ValorControl)' + ' FOR Etiqueta IN ( '
                    + @ETIQOPORTUNIDAD + ' )' + ' ) AS PivotTable;'
                    + ' select a.*,' + @ETIQOPORTUNIDAD + ' from #TMPOP a '
                    + ' left outer join ' + @tablaPivot
                    + ' b on a.Codigo=b.IdActividad'
                   + ' drop table '
                    + @tablaPivot + ' ';
                EXECUTE (@query);
            END;
			ELSE
			BEGIN
				SELECT * 
				FROM  #TMPOP
			END
    END;










GO
/****** Object:  StoredProcedure [dbo].[spS_RepSelActividadResumidoAllPaginate]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spS_RepSelActividadResumidoAllPaginate]
(
      @FechaInicio VARCHAR(10) ,
      @FechaFin VARCHAR(10) ,
      @Canal VARCHAR(4000) ,
      @Zona VARCHAR(4000) ,
      @TipoActividad VARCHAR(4000) ,
      @DetalleActividad VARCHAR(4000) ,
      @Usuario VARCHAR(4000) ,
      @Cliente VARCHAR(4000) ,
      @Campo VARCHAR(4000) ,
      @page INT ,
      @rows INT,
	  @IdUsuarioLogueado bigint
)
AS
    BEGIN
        DECLARE @MAXIMO INT;
        DECLARE @MINIMO INT;
        DECLARE @TAMTOLAL INT;

        SELECT  @MAXIMO = ( @page * @rows );
        SELECT  @MINIMO = @MAXIMO - ( @rows - 1 );

		DECLARE @strSQL NVARCHAR(MAX)='';
		
		DECLARE @IDPERFIL BIGINT
		SELECT @IDPERFIL=IdPerfil FROM GRUsuario WHERE IdUsuario=@IdUsuarioLogueado

		set @strSQL = '
		SELECT 
			ROW_NUMBER() OVER ( ORDER BY A.IdActividad ) item,
			[Fecha] = CONVERT(nvarchar(10), ISNULL(A.FechaCreacion, null), 103),
			[Canal] = C.Nombre,
			[Zona] = Z.Nombre,
			[Tipo Actividad] = TA.nombre,
			[Sub Tipo Actividad] = DA.Descripcion,
			[Usuario] = U.LoginUsuario,
			[Cliente] = CL.Razon_Social
		INTO #tmpData
		FROM  GRActividad A
			left join GRCanal C
				ON C.IdCanal = A.IdCanal 
			left join GRCliente CL
				ON cl.CLI_PK = A.idCliente
			left join GRUsuario U
				ON U.IdUsuario = A.IdUsuarioResponsable
			LEFT JOIN GRSubTipoActividad DA ON DA.idSubTipoActividad = A.idConfiguracionActividad 
			INNER JOIN GRTipoActividad TA ON A.IdTipoActividad = TA.Id
			left join GRZona Z
				ON Z.IdZona = u.IdZona
		WHERE ('+CONVERT(VARCHAR(10),@IDPERFIL)+'=2 OR A.IdUsuarioResponsable='+CONVERT(VARCHAR(10),@IdUsuarioLogueado)+') AND
			( ''' + @FechaInicio + ''' = '''' ' +  
		'		OR FORMAT(A.FechaCreacion, ''yyyyMMdd'') >= ''' +  @FechaInicio + '''' +
		'	) ' +
		'	AND (''' + @FechaFin + ''' = '''' ' +
		'			OR FORMAT(A.FechaCreacion, ''yyyyMMdd'') <=''' +  @FechaFin + '''' +
		'		)' +
		'	AND (''' + @Canal + '''= '''''   + 
		'			OR C.IdCanal IN ('     +
		'			SELECT    SplitValue'  +
		'			FROM      dbo.Split_2(''' + @Canal + ''', '','') )' +
		'		) ' +
		'	AND (''' + @Zona + ''' = ''''' +
		'			OR Z.IdZona IN (' +
		'			SELECT    SplitValue ' +
		'			FROM      dbo.Split_2(''' + @Zona + ''', '','') )' +
		'		) ' +
		'	AND ( ''' + @TipoActividad + ''' = '''' ' +
		'			OR TA.id IN ( ' +
		'			SELECT    SplitValue' +
		'			FROM      dbo.Split_2(''' + @TipoActividad + ''', '','') )' +
		'		)' +
		'	AND ( ''' + @DetalleActividad + ''' = ''''' +
		'			OR ISNULL(A.idConfiguracionActividad,''-2'') IN ( ' +
		'			SELECT    SplitValue ' +
		'			FROM      dbo.Split_2(''' + @DetalleActividad + ''', '','') )' +
		'		) ' +
		'	AND (''' + @Usuario + ''' = ''''' +
		'			OR u.IdUsuario IN ( ' +
		'			SELECT    SplitValue ' +
		'			FROM      dbo.Split_2(''' + @Usuario + ''', '','') )' +
		'		) ' +
		'	AND (''' + @Cliente + ''' = ''''' +
		'			OR CL.CLI_PK IN ( ' + 
		'			SELECT    SplitValue' + 
		'			FROM      dbo.Split_2(''' + @Cliente + ''', '','') )' +
		'		) ' +
		
		'' +

		' select ROW_NUMBER() OVER ( ORDER BY ' + @campo + '  ) item ,' + @campo + ', count(*) as [Actividades] INTO #tblFiltrado from #tmpData group by ' + @campo+'
		DECLARE @TOTAL INT = ( SELECT COUNT(*)  FROM #tblFiltrado); SELECT  *, @TOTAL as total from #tblFiltrado where item between ((CONVERT(NVARCHAR, ' + cast(@page as varchar(10)) + ')' +
		+ ' - 1) * ' + cast(@rows as varchar(10)) + ' + 1) AND ( ' +  cast(@page as varchar(10)) + '  * ' +
		+ cast(@rows as varchar(10)) + ')'
		EXEC(@strSQL);
		SELECT CAST('<root><![CDATA[' + @strSQL + ']]></root>' AS XML)
    END






GO
/****** Object:  StoredProcedure [dbo].[spS_RepSelActividadResumidoAllPaginateExcel]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spS_RepSelActividadResumidoAllPaginateExcel]
(
      @FechaInicio VARCHAR(10) ,
      @FechaFin VARCHAR(10) ,
      @Canal VARCHAR(4000) ,
      @Zona VARCHAR(4000) ,
      @TipoActividad VARCHAR(4000) ,
      @DetalleActividad VARCHAR(4000) ,
      @Usuario VARCHAR(4000) ,
      @Cliente VARCHAR(4000) ,
      @Campo VARCHAR(4000),
	  @IdUsuarioLogueado bigint
)
AS
    BEGIN
        
		DECLARE @strSQL NVARCHAR(MAX)='';
		DECLARE @IDPERFIL BIGINT
		SELECT @IDPERFIL=IdPerfil FROM GRUsuario WHERE IdUsuario=@IdUsuarioLogueado

		set @strSQL = '
				SELECT 
			ROW_NUMBER() OVER ( ORDER BY A.IdActividad ) item,
			[Fecha] = CONVERT(nvarchar(10), ISNULL(A.FechaCreacion, null), 103),
			[Canal] = C.Nombre,
			[Zona] = Z.Nombre,
			[Tipo Actividad] = TA.nombre,
			[Sub Tipo Actividad] = DA.Descripcion,
			[Usuario] = U.LoginUsuario,
			[Cliente] = CL.Razon_Social
		INTO #tmpData
		FROM  GRActividad A
			left join GRCanal C
				ON C.IdCanal = A.IdCanal 
			left join GRCliente CL
				ON cl.CLI_PK = A.idCliente
			left join GRUsuario U
				ON U.IdUsuario = A.IdUsuarioResponsable
			/*left join GRTipoActividad TA 
				ON TA.IdCanal = C.IdCanal 
			left join GRConfiguracionOportunidad DA
				ON DA.idtipoactividad = TA.id*/
			LEFT JOIN GRSubTipoActividad DA ON DA.idSubTipoActividad = A.idConfiguracionActividad 
			INNER JOIN GRTipoActividad TA ON A.IdTipoActividad = TA.Id
			left join GRZona Z
				ON Z.IdZona = u.IdZona
		WHERE  ('+CONVERT(VARCHAR(10),@IDPERFIL)+'=2 OR A.IdUsuarioResponsable='+CONVERT(VARCHAR(10),@IdUsuarioLogueado)+') AND
			( ''' + @FechaInicio + ''' = '''' ' +  
		'		OR FORMAT(A.FechaCreacion, ''yyyyMMdd'') >= ''' +  @FechaInicio + '''' +
		'	) ' +
		'	AND (''' + @FechaFin + ''' = '''' ' +
		'			OR FORMAT(A.FechaCreacion, ''yyyyMMdd'') <=''' +  @FechaFin + '''' +
		'		)' +
		'	AND (''' + @Canal + '''= '''''   + 
		'			OR C.IdCanal IN ('     +
		'			SELECT    SplitValue'  +
		'			FROM      dbo.Split_2(''' + @Canal + ''', '','') )' +
		'		) ' +
		'	AND (''' + @Zona + ''' = ''''' +
		'			OR Z.IdZona IN (' +
		'			SELECT    SplitValue ' +
		'			FROM      dbo.Split_2(''' + @Zona + ''', '','') )' +
		'		) ' +
		'	AND ( ''' + @TipoActividad + ''' = '''' ' +
		'			OR TA.id IN ( ' +
		'			SELECT    SplitValue' +
		'			FROM      dbo.Split_2(''' + @TipoActividad + ''', '','') )' +
		'		)' +
		'	AND ( ''' + @DetalleActividad + ''' = ''''' +
		'			OR ISNULL(A.idConfiguracionActividad,''-2'') IN ( ' +
		'			SELECT    SplitValue ' +
		'			FROM      dbo.Split_2(''' + @DetalleActividad + ''', '','') )' +
		'		) ' +
		'	AND (''' + @Usuario + ''' = ''''' +
		'			OR u.IdUsuario IN ( ' +
		'			SELECT    SplitValue ' +
		'			FROM      dbo.Split_2(''' + @Usuario + ''', '','') )' +
		'		) ' +
		'	AND (''' + @Cliente + ''' = ''''' +
		'			OR CL.CLI_PK IN ( ' + 
		'			SELECT    SplitValue' + 
		'			FROM      dbo.Split_2(''' + @Cliente + ''', '','') )' +
		'		) ' +
		
		' select ' + @campo + ', count(*) as [Actividades] from #tmpData group by ' + @campo;

		EXEC(@strSQL);
    END








GO
/****** Object:  StoredProcedure [dbo].[sps_SelGRSubTipoActividad]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sps_SelGRSubTipoActividad]
(@IDSubTipoActividad varchar(100),
@codigo varchar(100),
@Descripcion varchar(100),
@tipoactividad int
)
as
begin
	select * from GRSubTipoActividad
	where IDSubTipoActividad=@IDSubTipoActividad
end







GO
/****** Object:  StoredProcedure [dbo].[spS_SelGrUsuario_Login]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spS_SelGrUsuario_Login]
@LoginUsuario varchar(100)
AS
BEGIN
	SET NOCOUNT OFF;
	select IdUsuario as id, Apellidos + ', ' + Nombres as nombre, u.Codigo as codigo,ISNULL(u.IdCanal,0)AS IdCanal,ISNULL(u.IdZona,0)AS IdZona,u.Email,
		c.Nombre Canal,z.Nombre Zona,u.FlagAutenticacionAD AS FlagAutenticacionAD,u.IdPerfil,p.Descripcion perfil
	from GRUsuario u INNER JOIN dbo.GRCanal c ON c.IdCanal = u.IdCanal
	LEFT JOIN dbo.GRZona z ON z.IdZona = u.IdZona INNER join GRPerfil p on p.IdPerfil=u.IdPerfil
	where (LoginUsuario = @LoginUsuario or email=@LoginUsuario)
	and u.FlgHabilitado = 'T'
END



GO
/****** Object:  StoredProcedure [dbo].[spS_SelPantallaInicio]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[spS_SelPantallaInicio]
	@IDPERFIL INT
as
BEGIN 	
	SELECT TOP 1 m.Url as Url
	FROM GRPerfilMenu pm
	INNER JOIN CFMenu m on pm.IdMenu = m.IdMenu
	where pm.FlgHome='T' and pm.IdPerfil=@IDPERFIL
END

select *
from CFMenu WHERE flg='T'
--IDMENU 6 Bandeja de Oportunidades idperfil 4 Vendedor
--SELECT * FROM GRPERFILMENU WHERE IDMENU=6 AND IDPERFIL=4
UPDATE GRPerfilMenu set FlgHome='T' WHERE IDMENU=6 AND IDPERFIL=4

--EXEC [spS_SelPantallaInicio] '4'










GO
/****** Object:  StoredProcedure [dbo].[spS_TraSelMenu]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spS_TraSelMenu]--[spS_TraSelMenu] 2
@IdPerfil INT
AS
BEGIN
DECLARE @COD_CONFIGURACION CHAR(3)
DECLARE @COD_MANTENIMIENTO_SUPERVISOR CHAR(3)
DECLARE @COD_MANTENIMIENTO CHAR(3)
DECLARE @COD_PAIS CHAR(2)
DECLARE @RESULTADO_ADM BIT
DECLARE @RESULTADO_SPR BIT

SET @COD_PAIS = 'PE'

	;WITH MENHIJO
	AS(
		select 
			CFM.IdMenu,
			IdMenuPadre
		from GRPerfilMenu GRPM
		inner join CFMenu CFM
			on (GRPM.IdMenu = CFM.IdMenu)
			WHERE IdPerfil = @IdPerfil and IdPerfil = @IdPerfil
	), MENPADRE AS(
			SELECT DISTINCT CFM.IdMenu from MENHIJO p
			inner join CFMenu CFM on p.IdMenuPadre=CFM.IdMenu
	), MENUS AS (
		select distinct * from (
		SELECT IdMenu FROM MENPADRE
		UNION ALL
		SELECT IdMenu FROM MENHIJO) as a
	)

SELECT  cm.IdMenu, cm.IdMenuPadre,(STUFF (ci.Descripcion, 1, 1, UPPER(left(ci.Descripcion, 1))))  AS Descripcion ,cm.UrlImagen,cm.Url ,cm.CodMenu AS Codigo
FROM  CFMenu cm
	join CFEtiqueta ce on ce.IdEtiqueta = cm.IdEtiqueta
	join CFValorEtiqueta ci on ci.IdEtiqueta = ce.IdEtiqueta
	join CFPais cp on cp.IdPais = ci.IdPais
	join MENUS cfpm on cfpm.IdMenu = cm.IdMenu
WHERE 
	 cp.CodPais = @COD_PAIS AND cm.flg='T'
ORDER BY cm.Posicion;

END












GO
/****** Object:  StoredProcedure [dbo].[spS_TraSelPerfilMenu]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spS_TraSelPerfilMenu]--[spS_TraSelPerfilMenu] 2
(
	@IdPerfil INT
)
AS
BEGIN
	WITH MENHIJO
	AS(
	select 
		CFM.CodMenu,
		IdMenuPadre
	from GRPerfilMenu GRPM
	inner join CFMenu CFM
		on (GRPM.IdMenu = CFM.IdMenu)
	where IdPerfil = @IdPerfil AND CFM.flg='T'
	),MENPADRE AS(
		SELECT DISTINCT CFM.CodMenu from MENHIJO p
	inner join CFMenu CFM on p.IdMenuPadre=CFM.IdMenu
	)
	SELECT DISTINCT * FROM(
	SELECT CodMenu,NULL IdMenuPadre,'T' FlgCrear, 'T' FlgVer, 'T' FlgEditar, 'T' FlgEliminar FROM MENPADRE
	UNION ALL
	SELECT CodMenu,IdMenuPadre,'T','T','T','T' FROM MENHIJO) AS A
END










GO
/****** Object:  StoredProcedure [dbo].[USP_CARGACLIENTES]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_CARGACLIENTES]
AS
    BEGIN
        DECLARE @ID AS BIGINT;
        DECLARE @RAZON_SOCIAL AS VARCHAR(100);
        DECLARE @RUC AS VARCHAR(100);
        DECLARE @DIRECCION AS VARCHAR(100);
        DECLARE @REFERENCIA AS VARCHAR(100);
        DECLARE @CANAL AS VARCHAR(100);
        DECLARE @ZONA AS VARCHAR(100);

        DECLARE @ID_ZONA AS BIGINT;
        DECLARE @ID_CANAL AS BIGINT;

        DECLARE @IDClIENTE AS BIGINT;

        DECLARE @CONTADOR_REG INT;

        DECLARE @idClienteZona BIGINT= 0;

        DECLARE @SUBIDOS INT= ( SELECT  COUNT(*)
                                FROM    dbo.TMP_Cliente
                              );
        DECLARE @INSERTADOR INT = 0;
        DECLARE @ACTUALIZADOS INT= 0;
        DECLARE @ERRORES INT; 
        DECLARE @ERRORESGeneral VARCHAR(MAX)= ''; 

        TRUNCATE TABLE dbo.ERR_Cliente;

        DECLARE cur_tempCliente CURSOR
        FOR
            SELECT  [ID] ,
                    [Razon_Social] ,
                    [RUC] ,
                    [Referencia] ,
                    [Direccion] ,
                    [CodZona] ,
                    [CodCanal]
            FROM    [dbo].[TMP_Cliente];
        OPEN cur_tempCliente;
        FETCH NEXT FROM cur_tempCliente INTO @ID, @RAZON_SOCIAL, @RUC,
            @REFERENCIA, @DIRECCION, @ZONA, @CANAL;
        WHILE @@FETCH_STATUS = 0
            BEGIN
                SET @ERRORES = 0;
                IF @RAZON_SOCIAL IS NULL
                    OR @RAZON_SOCIAL = ''
                    BEGIN
                        UPDATE  dbo.TMP_Cliente
                        SET     ERR_Razon_Social = ' CAMPOS OBLIGATORIOS VACIO'
                        WHERE   ID = @ID;
                        SET @ERRORES = @ERRORES + 1;
                        SET @ERRORESGeneral = @ERRORESGeneral
                            + ' CAMPOS OBLIGATORIOS VACIO';
                    END;
                IF @RUC IS NULL
                    OR @RUC = ''
                    BEGIN
                        UPDATE  dbo.TMP_Cliente
                        SET     ERR_RUC = ' CAMPOS OBLIGATORIOS VACIO'
                        WHERE   ID = @ID;
                        SET @ERRORES = @ERRORES + 1;
                        SET @ERRORESGeneral = @ERRORESGeneral
                            + ' CAMPOS OBLIGATORIOS VACIO';
                    END;


                IF @DIRECCION IS NULL
                    OR @DIRECCION = ''
                    BEGIN
                        UPDATE  dbo.TMP_Cliente
                        SET     ERR_Direccion = ' CAMPOS OBLIGATORIOS VACIO'
                        WHERE   ID = @ID;
                        SET @ERRORES = @ERRORES + 1;
                        SET @ERRORESGeneral = @ERRORESGeneral
                            + ' CAMPOS OBLIGATORIOS VACIO';
                    END;
                IF @REFERENCIA IS NULL
                    OR @REFERENCIA = ''
                    BEGIN
                        UPDATE  dbo.TMP_Cliente
                        SET     ERR_Referencia = ' CAMPOS OBLIGATORIOS VACIO'
                        WHERE   ID = @ID;
                        SET @ERRORES = @ERRORES + 1;
                        SET @ERRORESGeneral = @ERRORESGeneral
                            + ' CAMPOS OBLIGATORIOS VACIO';
                    END;

                
                IF @ZONA IS NULL
                    OR @ZONA = ''
                    BEGIN
                        UPDATE  dbo.TMP_Cliente
                        SET     ERR_CodZona = ' CAMPOS OBLIGATORIOS VACIO'
                        WHERE   ID = @ID;
                        SET @ERRORES = @ERRORES + 1;
                        SET @ERRORESGeneral = @ERRORESGeneral
                            + ' CAMPOS OBLIGATORIOS VACIO';
                    END;
                ELSE
                    BEGIN
                        SET @ID_ZONA = 0;

                        SET @ID_ZONA = ( SELECT ISNULL(IdZona, 0)
                                         FROM   dbo.GRZona
                                         WHERE  Codigo = @ZONA
                                       );
                        IF @ID_ZONA = 0
                            OR @ID_ZONA IS NULL
                            BEGIN 
                                UPDATE  dbo.TMP_Cliente
                                SET     ERR_CodZona = ' CÓDIGO DE ZONA INVÁLIDO'
                                WHERE   ID = @ID;
                                SET @ERRORES = @ERRORES + 1;
                                SET @ERRORESGeneral = @ERRORESGeneral
                                    + ' CÓDIGO DE ZONA INVÁLIDO';
                            END;
                    END;

                IF @CANAL IS NULL
                    OR @CANAL = ''
                    BEGIN
                        UPDATE  dbo.TMP_Cliente
                        SET     ERR_CodCanal = ' CAMPOS OBLIGATORIOS VACIO'
                        WHERE   ID = @ID;
                        SET @ERRORES = @ERRORES + 1;
                        SET @ERRORESGeneral = @ERRORESGeneral
                            + ' CAMPOS OBLIGATORIOS VACIO';
                    END;
                ELSE
                    BEGIN

                        SELECT  @ID_CANAL = ISNULL(IdCanal, 0)
                        FROM    dbo.GRCanal
                        WHERE   Codigo = @CANAL;
                        IF @ID_CANAL = 0
                            OR @ID_CANAL IS NULL
                            BEGIN
                                UPDATE  dbo.TMP_Cliente
                                SET     ERR_CodCanal = ' CODIGO CANAL INVÁLIDO'
                                WHERE   ID = @ID;
                                SET @ERRORES = @ERRORES + 1;
                                SET @ERRORESGeneral = @ERRORESGeneral
                                    + ' CODIGO CANAL INVÁLIDO';
                            END;
                    END;

                IF @ERRORES = 0
                    BEGIN
                        SET @CONTADOR_REG = 0;
                        SET @CONTADOR_REG = ( SELECT    COUNT(RUC)
                                              FROM      dbo.GRCliente
                                              WHERE     RUC = @RUC
                                            );

                        IF @CONTADOR_REG = 0
                            BEGIN
                                INSERT  INTO dbo.GRCliente
                                        ( Razon_Social ,
                                          RUC ,
                                          FlgHabilitado ,
                                          Direccion ,
                                          Referencia ,
                                          IdCanal
                                        )
                                VALUES  ( @RAZON_SOCIAL ,
                                          @RUC ,
                                          'T' ,
                                          @DIRECCION ,
                                          @REFERENCIA ,
                                          @ID_CANAL
                                        );
                                SET @INSERTADOR = @INSERTADOR + 1;
                                SET @IDClIENTE = 0;
                                SET @IDClIENTE = SCOPE_IDENTITY();
                            END;
                        ELSE
                            BEGIN 
                                UPDATE  [dbo].GRCliente
                                SET     Razon_Social = @RAZON_SOCIAL ,
                                        RUC = @RUC ,
                                        FlgHabilitado = 'T' ,
                                        Direccion = @DIRECCION ,
                                        Referencia = @REFERENCIA ,
                                        IdCanal = @ID_CANAL
                                WHERE   RUC = @RUC;
                                SET @ACTUALIZADOS = @ACTUALIZADOS + 1;
                                SELECT  @IDClIENTE = CLI_PK
                                FROM    dbo.GRCliente
                                WHERE   RUC = @RUC;
                            END;                  

                        SET @idClienteZona = 0;
                        SET @idClienteZona = ( SELECT   COUNT(*)
                                               FROM     dbo.GRClienteZona
                                               WHERE    idCliente = @IDClIENTE
                                                        AND idZona = @ID_ZONA
                                             );
                        IF @idClienteZona = 0
                            BEGIN
                                INSERT  dbo.GRClienteZona
                                        ( idCliente, idZona )
                                VALUES  ( @IDClIENTE, @ID_ZONA );
                            END;
                        END;
                FETCH NEXT FROM cur_tempCliente INTO @ID, @RAZON_SOCIAL, @RUC,
                    @REFERENCIA, @DIRECCION, @ZONA, @CANAL;
            END;
        CLOSE cur_tempCliente;
        DEALLOCATE cur_tempCliente;

        INSERT  INTO dbo.ERR_Cliente
                ( Razon_Social ,
                  RUC ,
                  CodZona ,
                  CodCanal ,
                  ERR_Razon_Social ,
                  ERR_RUC ,
                  ERR_CodZona ,
                  ERR_CodCanal ,
                  ERR_AUX ,
                  Referencia ,
                  ERR_Referencia ,
                  ERR_Direccion ,
                  Direccion
                )
                SELECT  Razon_Social ,
                        RUC ,
                        CodZona ,
                        CodCanal ,
                        ERR_Razon_Social ,
                        ERR_RUC ,
                        ERR_CodZona ,
                        ERR_CodCanal ,
                        ERR_AUX ,
                        Referencia ,
                        ERR_Referencia ,
                        ERR_Direccion ,
                        Direccion
                FROM    dbo.TMP_Cliente;
        TRUNCATE TABLE dbo.TMP_Cliente;

        SELECT  @SUBIDOS subidos ,
                @INSERTADOR insertados ,
                @ACTUALIZADOS actualizados ,
                @ERRORESGeneral;


    END;



GO
/****** Object:  StoredProcedure [dbo].[USP_CARGACONTACTOS]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_CARGACONTACTOS]
AS
    BEGIN
        DECLARE @ID AS BIGINT;
        DECLARE @Nombres AS VARCHAR(100);
        DECLARE @Telefono AS VARCHAR(100);
        DECLARE @Email AS VARCHAR(100);
        DECLARE @Cargo AS VARCHAR(100);
        DECLARE @Ruc_Cliente AS VARCHAR(100);
        DECLARE @COD_ZONA AS VARCHAR(100);

        DECLARE @ID_Cliente AS BIGINT;
        DECLARE @ID_ZONA AS BIGINT;

        DECLARE @CONTADOR_REG INT;

        DECLARE @SUBIDOS INT= ( SELECT  COUNT(*)
                                FROM    dbo.TMP_Contacto
                              );
        DECLARE @INSERTADOR INT = 0;
        DECLARE @ACTUALIZADOS INT= 0;
        DECLARE @ERRORES INT; 
        DECLARE @ERRORESGeneral VARCHAR(MAX)= ''; 

        TRUNCATE TABLE dbo.ERR_Contacto;

        DECLARE cur_tempContacto CURSOR
        FOR
            SELECT  [ID] ,
                    [Nombres] ,
                    [Telefono] ,
                    [Email] ,
                    [Cargo] ,
                    [Ruc_Cliente] ,
                    CodZona
            FROM    [dbo].[TMP_Contacto];
        OPEN cur_tempContacto;
        FETCH NEXT FROM cur_tempContacto INTO @ID, @Nombres, @Telefono, @Email,
            @Cargo, @Ruc_Cliente, @COD_ZONA;
        WHILE @@FETCH_STATUS = 0
            BEGIN
                SET @ERRORES = 0;
                IF @Nombres IS NULL
                    OR @Nombres = ''
                    BEGIN
                        UPDATE  dbo.TMP_Contacto
                        SET     ERR_Nombres = ' CAMPOS OBLIGATORIOS VACIO'
                        WHERE   ID = @ID;
                        SET @ERRORES = @ERRORES + 1;
                        SET @ERRORESGeneral = @ERRORESGeneral
                            + ' CAMPOS OBLIGATORIOS VACIO';
                    END;
                IF @Telefono IS NULL
                    OR @Telefono = ''
                    BEGIN
                        UPDATE  dbo.TMP_Contacto
                        SET     ERR_Telefono = ' CAMPOS OBLIGATORIOS VACIO'
                        WHERE   ID = @ID;
                        SET @ERRORES = @ERRORES + 1;
                        SET @ERRORESGeneral = @ERRORESGeneral
                            + ' CAMPOS OBLIGATORIOS VACIO';
                    END;


                IF @Email IS NULL
                    OR @Email = ''
                    BEGIN
                        UPDATE  dbo.TMP_Contacto
                        SET     ERR_Email = ' CAMPOS OBLIGATORIOS VACIO'
                        WHERE   ID = @ID;
                        SET @ERRORES = @ERRORES + 1;
                        SET @ERRORESGeneral = @ERRORESGeneral
                            + ' CAMPOS OBLIGATORIOS VACIO';
                    END;
                IF @Cargo IS NULL
                    OR @Cargo = ''
                    BEGIN
                        UPDATE  dbo.TMP_Contacto
                        SET     ERR_Cargo = ' CAMPOS OBLIGATORIOS VACIO'
                        WHERE   ID = @ID;
                        SET @ERRORES = @ERRORES + 1;
                        SET @ERRORESGeneral = @ERRORESGeneral
                            + ' CAMPOS OBLIGATORIOS VACIO';
                    END;

                
                IF @Ruc_Cliente IS NULL
                    OR @Ruc_Cliente = ''
                    BEGIN
                        UPDATE  dbo.TMP_Contacto
                        SET     ERR_Ruc_Cliente = ' CAMPOS OBLIGATORIOS VACIO'
                        WHERE   ID = @ID;
                        SET @ERRORES = @ERRORES + 1;
                        SET @ERRORESGeneral = @ERRORESGeneral
                            + ' CAMPOS OBLIGATORIOS VACIO';
                    END;
                ELSE
                    BEGIN
                        SET @ID_Cliente = 0;

                        SET @ID_Cliente = ( SELECT  ISNULL(CLI_PK, 0)
                                            FROM    dbo.GRCliente
                                            WHERE   RUC = @Ruc_Cliente
                                          );
                        IF @ID_Cliente = 0
                            OR @ID_Cliente IS NULL
                            BEGIN 
                                UPDATE  dbo.TMP_Contacto
                                SET     ERR_Ruc_Cliente = 'RUC DE CLIENTE INVÁLIDO'
                                WHERE   ID = @ID;
                                SET @ERRORES = @ERRORES + 1;
                                SET @ERRORESGeneral = @ERRORESGeneral
                                    + ' RUC DE CLIENTE INVÁLIDO';
                            END;
                    END;

                IF @COD_ZONA IS NULL
                    OR @COD_ZONA = ''
                    BEGIN
                        UPDATE  dbo.TMP_Contacto
                        SET     ERR_CodZona = ' CAMPOS OBLIGATORIOS VACIO'
                        WHERE   ID = @ID;
                        SET @ERRORES = @ERRORES + 1;
                        SET @ERRORESGeneral = @ERRORESGeneral
                            + ' CAMPOS OBLIGATORIOS VACIO';
                    END;
                ELSE
                    BEGIN
                        SET @ID_ZONA = 0;

                        SET @ID_ZONA = ( SELECT ISNULL(IdZona, 0)
                                         FROM   dbo.GRZona
                                         WHERE  Codigo = @COD_ZONA
                                       );
                        IF @ID_ZONA = 0
                            OR @ID_ZONA IS NULL
                            BEGIN 
                                UPDATE  dbo.TMP_Contacto
                                SET     ERR_CodZona = ' CÓDIGO DE ZONA INVÁLIDO'
                                WHERE   ID = @ID;
                                SET @ERRORES = @ERRORES + 1;
                                SET @ERRORESGeneral = @ERRORESGeneral
                                    + ' CÓDIGO DE ZONA INVÁLIDO';
                            END;
                    END;
                IF @ERRORES = 0
                    BEGIN
                        --SET @CONTADOR_REG = 0;
                        --SET @CONTADOR_REG = ( SELECT    COUNT(RUC)
                        --                      FROM      dbo.GRCliente
                        --                      WHERE     RUC = @RUC
                        --                    );

                        --IF @CONTADOR_REG = 0
                        --    BEGIN
                        INSERT  INTO dbo.GRContacto
                                ( Nombre ,
                                  Telefono ,
                                  Email ,
                                  Cargo ,
                                  IdCliente ,
                                  IdZona ,
                                  Flag
                                )
                        VALUES  ( @Nombres ,
                                  @Telefono ,
                                  @Email ,
                                  @Cargo ,
                                  @ID_Cliente ,
                                  @ID_ZONA ,
                                  'T' 
                                );
                                
                        SET @INSERTADOR = @INSERTADOR + 1;
                        --SET @IDClIENTE = 0;
                        --SET @IDClIENTE = SCOPE_IDENTITY();
                            --END;
                        --ELSE
                        --    BEGIN 
                        --        UPDATE  [dbo].GRCliente
                        --        SET     Razon_Social = @RAZON_SOCIAL ,
                        --                RUC = @RUC ,
                        --                FlgHabilitado = 'T' ,
                        --                Direccion = @DIRECCION ,
                        --                Referencia = @REFERENCIA ,
                        --                IdCanal = @ID_CANAL
                        --        WHERE   RUC = @RUC;
                        --        SET @ACTUALIZADOS = @ACTUALIZADOS + 1;
                        --        SELECT  @IDClIENTE = CLI_PK
                        --        FROM    dbo.GRCliente
                        --        WHERE   RUC = @RUC;
                        --    END;                 

                    END;
                FETCH NEXT FROM cur_tempContacto INTO @ID, @Nombres, @Telefono,
                    @Email, @Cargo, @Ruc_Cliente, @COD_ZONA;
            END;
        CLOSE cur_tempContacto;
        DEALLOCATE cur_tempContacto;

        INSERT  INTO dbo.ERR_Contacto
                ( Nombres ,
                  Telefono ,
                  Email ,
                  Cargo ,
                  Ruc_Cliente ,
                  CodZona ,
                  ERR_Nombres ,
                  ERR_Telefono ,
                  ERR_Email ,
                  ERR_Cargo ,
                  ERR_Ruc_Cliente ,
                  ERR_AUX ,
                  ERR_CodZona
                )
                SELECT  Nombres ,
                        Telefono ,
                        Email ,
                        Cargo ,
                        Ruc_Cliente ,
                        CodZona ,
                        ERR_Nombres ,
                        ERR_Telefono ,
                        ERR_Email ,
                        ERR_Cargo ,
                        ERR_Ruc_Cliente ,
                        ERR_AUX ,
                        ERR_CodZona
                FROM    dbo.TMP_Contacto;
        TRUNCATE TABLE dbo.TMP_Contacto;

        SELECT  @SUBIDOS subidos ,
                @INSERTADOR insertados ,
                @ACTUALIZADOS actualizados ,
                @ERRORESGeneral;


    END;



GO
/****** Object:  StoredProcedure [dbo].[USP_CARGAUSUARIO]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_CARGAUSUARIO]
AS
    BEGIN
        DECLARE @ID AS BIGINT;
        DECLARE @CODIGO AS VARCHAR(100);
        DECLARE @NOMBRES AS VARCHAR(100);
        DECLARE @LOGIN_USUARIO AS VARCHAR(100);
        DECLARE @CLAVE AS VARCHAR(100);
        DECLARE @COD_PERFIL AS VARCHAR(100);
        DECLARE @EMAIL AS VARCHAR(100);
        DECLARE @ZONA AS VARCHAR(100);
        DECLARE @CANAL AS VARCHAR(100);

        DECLARE @ID_ZONA AS BIGINT;
        DECLARE @ID_CANAL AS BIGINT;
        DECLARE @ID_PERFIL AS BIGINT;

        DECLARE @verificaLogin AS INT; 

        DECLARE @CONTADOR_REG INT;

        DECLARE @SUBIDOS INT= ( SELECT  COUNT(*)
                                FROM    dbo.TMP_Usuario
                              );
        DECLARE @INSERTADOR INT = 0;
        DECLARE @ACTUALIZADOS INT= 0;
        DECLARE @ERRORES INT; 
        DECLARE @ERRORESGeneral VARCHAR(MAX)= ''; 

        TRUNCATE TABLE dbo.ERR_Usuario;

        DECLARE cur_tempUsuario CURSOR
        FOR
            SELECT  [ID] ,
                    [Codigo] ,
                    [Nombres] ,
                    [LoginUsuario] ,
                    [Clave] ,
                    [CodPerfil] ,
                    [Email] ,
                    [ZONA] ,
                    [CANAL]
            FROM    [dbo].[TMP_Usuario];
        OPEN cur_tempUsuario;
        FETCH NEXT FROM cur_tempUsuario INTO @ID, @CODIGO, @NOMBRES,
            @LOGIN_USUARIO, @CLAVE, @COD_PERFIL, @EMAIL, @ZONA, @CANAL;
        WHILE @@FETCH_STATUS = 0
            BEGIN
                SET @ERRORES = 0;
                IF @CODIGO IS NULL
                    OR @CODIGO = ''
                    BEGIN
                        UPDATE  dbo.TMP_Usuario
                        SET     ERR_Codigo = ' CAMPOS OBLIGATORIOS VACIO'
                        WHERE   ID = @ID;
                        SET @ERRORES = @ERRORES + 1;
                        SET @ERRORESGeneral = @ERRORESGeneral
                            + ' CAMPOS OBLIGATORIOS VACIO';
                    END;
                IF @NOMBRES IS NULL
                    OR @NOMBRES = ''
                    BEGIN
                        UPDATE  dbo.TMP_Usuario
                        SET     ERR_Nombres = ' CAMPOS OBLIGATORIOS VACIO'
                        WHERE   ID = @ID;
                        SET @ERRORES = @ERRORES + 1;
                        SET @ERRORESGeneral = @ERRORESGeneral
                            + ' CAMPOS OBLIGATORIOS VACIO';
                    END;


                IF @LOGIN_USUARIO IS NULL
                    OR @LOGIN_USUARIO = ''
                    BEGIN
                        UPDATE  dbo.TMP_Usuario
                        SET     ERR_LoginUsuario = ' CAMPOS OBLIGATORIOS VACIO'
                        WHERE   ID = @ID;
                        SET @ERRORES = @ERRORES + 1;
                        SET @ERRORESGeneral = @ERRORESGeneral
                            + ' CAMPOS OBLIGATORIOS VACIO';
                    END;
                ELSE
                    BEGIN
                        SET @verificaLogin = 0;
                        SET @verificaLogin = ( SELECT   COUNT(*)
                                               FROM     dbo.GRUsuario
                                               WHERE    LoginUsuario = @LOGIN_USUARIO
                                             );
                        IF @verificaLogin > 0
                            BEGIN 
                                UPDATE  dbo.TMP_Usuario
                                SET     ERR_LoginUsuario = ' LOGIN NO DISPONIBLE, USAR OTRO'
                                WHERE   ID = @ID;
                                SET @ERRORES = @ERRORES + 1;
                                SET @ERRORESGeneral = @ERRORESGeneral
                                    + ' LOGIN NO DISPONIBLE, USAR OTRO';
                            END;
                    END; 


                IF @CLAVE IS NULL
                    OR @CLAVE = ''
                    BEGIN
                        UPDATE  dbo.TMP_Usuario
                        SET     ERR_Clave = ' CAMPOS OBLIGATORIOS VACIO'
                        WHERE   ID = @ID;
                        SET @ERRORES = @ERRORES + 1;
                        SET @ERRORESGeneral = @ERRORESGeneral
                            + ' CAMPOS OBLIGATORIOS VACIO';
                    END;

                IF @COD_PERFIL IS NULL
                    OR @COD_PERFIL = ''
                    BEGIN
                        UPDATE  dbo.TMP_Usuario
                        SET     ERR_CodPerfil = ' CAMPOS OBLIGATORIOS VACIO'
                        WHERE   ID = @ID;
                        SET @ERRORES = @ERRORES + 1;
                        SET @ERRORESGeneral = @ERRORESGeneral
                            + ' CAMPOS OBLIGATORIOS VACIO';
                    END;
                ELSE
                    BEGIN
                        IF @COD_PERFIL = 'ADMINISTRADOR'
                            BEGIN
                                SET @ID_PERFIL = 2;
                            END;
                        ELSE
                            IF @COD_PERFIL = 'USUARIO'
                                BEGIN
                                    SET @ID_PERFIL = 4;
                                END;
                            ELSE
                                BEGIN
                                    UPDATE  dbo.TMP_Usuario
                                    SET     ERR_Clave = ' PERFIL NO VÁLIDO'
                                    WHERE   ID = @ID;
                                    SET @ERRORES = @ERRORES + 1;
                                    SET @ERRORESGeneral = @ERRORESGeneral
                                        + ' PERFIL NO VÁLIDO';
                                END;
                    END;

                IF @EMAIL IS NULL
                    OR @EMAIL = ''
                    BEGIN
                        UPDATE  dbo.TMP_Usuario
                        SET     ERR_Email = ' CAMPOS OBLIGATORIOS VACIO'
                        WHERE   ID = @ID;
                        SET @ERRORES = @ERRORES + 1;
                        SET @ERRORESGeneral = @ERRORESGeneral
                            + ' CAMPOS OBLIGATORIOS VACIO';
                    END;
                IF @ZONA IS NULL
                    OR @ZONA = ''
                    BEGIN
                        UPDATE  dbo.TMP_Usuario
                        SET     ERR_ZONA = ' CAMPOS OBLIGATORIOS VACIO'
                        WHERE   ID = @ID;
                        SET @ERRORES = @ERRORES + 1;
                        SET @ERRORESGeneral = @ERRORESGeneral
                            + ' CAMPOS OBLIGATORIOS VACIO';
                    END;
                ELSE
                    BEGIN
                        SET @ID_ZONA = 0;

                        SET @ID_ZONA = ( SELECT ISNULL(IdZona, 0)
                                         FROM   dbo.GRZona
                                         WHERE  Codigo = @ZONA
                                       );
                        IF @ID_ZONA = 0
                            OR @ID_ZONA IS NULL
                            BEGIN 
                                UPDATE  dbo.TMP_Usuario
                                SET     ERR_ZONA = ' CÓDIGO DE ZONA INVÁLIDO'
                                WHERE   ID = @ID;
                                SET @ERRORES = @ERRORES + 1;
                                SET @ERRORESGeneral = @ERRORESGeneral
                                    + ' CÓDIGO DE ZONA INVÁLIDO';
                            END;
                    END;

                IF @CANAL IS NULL
                    OR @CANAL = ''
                    BEGIN
                        UPDATE  dbo.TMP_Usuario
                        SET     ERR_CANAL = ' CAMPOS OBLIGATORIOS VACIO'
                        WHERE   ID = @ID;
                        SET @ERRORES = @ERRORES + 1;
                        SET @ERRORESGeneral = @ERRORESGeneral
                            + ' CAMPOS OBLIGATORIOS VACIO';
                    END;
                ELSE
                    BEGIN

                        SELECT  @ID_CANAL = ISNULL(IdCanal, 0)
                        FROM    dbo.GRCanal
                        WHERE   Codigo = @CANAL;
                        IF @ID_CANAL = 0
                            OR @ID_CANAL IS NULL
                            BEGIN
                                UPDATE  dbo.TMP_Usuario
                                SET     ERR_CANAL = ' CODIGO CANAL INVÁLIDO'
                                WHERE   ID = @ID;
                                SET @ERRORES = @ERRORES + 1;
                                SET @ERRORESGeneral = @ERRORESGeneral
                                    + ' CODIGO CANAL INVÁLIDO';
                            END;
                    END;

                IF @ERRORES = 0
                    BEGIN
                        SET @CONTADOR_REG = 0;
                        SET @CONTADOR_REG = ( SELECT    COUNT(Codigo)
                                              FROM      dbo.GRUsuario
                                              WHERE     Codigo = @CODIGO
                                            );

                        IF @CONTADOR_REG = 0
                            BEGIN
                                INSERT  INTO dbo.GRUsuario
                                        ( Codigo ,
                                          Nombres ,
                                          Apellidos ,
                                          LoginUsuario ,
                                          Clave ,
                                          Email ,
                                          FlgHabilitado ,
                                          IdCanal ,
                                          IdZona ,
                                          IdPerfil ,
                                          FlagAutenticacionAD
                                        )
                                VALUES  ( @CODIGO ,
                                          @NOMBRES ,
                                          '' , -- Apellidos - varchar(80)
                                          @LOGIN_USUARIO ,
                                          @CLAVE ,
                                          @EMAIL ,
                                          'T' , -- FlgHabilitado - varchar(10)
                                          @ID_CANAL , -- IdCanal - bigint
                                          @ID_ZONA , -- IdZona - bigint
                                          @ID_PERFIL , -- IdPerfil - bigint
                                          'F'  -- FlagAutenticacionAD - char(1)
                                        );
                                SET @INSERTADOR = @INSERTADOR + 1;
                            END;
                        ELSE
                            BEGIN 
                                UPDATE  [dbo].[GRUsuario]
                                SET     [Nombres] = @NOMBRES ,
                                        [Apellidos] = '' ,
                                        [LoginUsuario] = @LOGIN_USUARIO ,
                                        [Clave] = @CLAVE ,
                                        [Email] = @EMAIL ,
                                        [FlgHabilitado] = 'T' ,
                                        [IdCanal] = @ID_CANAL ,
                                        [IdZona] = @ID_ZONA ,
                                        [IdPerfil] = @ID_PERFIL ,
                                        [FlagAutenticacionAD] = 'F'
                                WHERE   [Codigo] = @CODIGO;
                                SET @ACTUALIZADOS = @ACTUALIZADOS + 1;
                            END;
                    END;
                FETCH NEXT FROM cur_tempUsuario INTO @ID, @CODIGO, @NOMBRES,
                    @LOGIN_USUARIO, @CLAVE, @COD_PERFIL, @EMAIL, @ZONA, @CANAL;
            END;
        CLOSE cur_tempUsuario;
        DEALLOCATE cur_tempUsuario;

        INSERT  INTO dbo.ERR_Usuario
                ( Codigo ,
                  Nombres ,
                  LoginUsuario ,
                  Clave ,
                  CodPerfil ,
                  Email ,
                  ERR_Codigo ,
                  ERR_Nombres ,
                  ERR_LoginUsuario ,
                  ERR_Clave ,
                  ERR_CodPerfil ,
                  ERR_Email ,
                  ERR_AUX ,
                  ZONA ,
                  CANAL ,
                  ERR_CANAL ,
                  ERR_ZONA
		        )
                SELECT  Codigo ,
                        Nombres ,
                        LoginUsuario ,
                        Clave ,
                        CodPerfil ,
                        Email ,
                        ERR_Codigo ,
                        ERR_Nombres ,
                        ERR_LoginUsuario ,
                        ERR_Clave ,
                        ERR_CodPerfil ,
                        ERR_Email ,
                        ERR_AUX ,
                        ZONA ,
                        CANAL ,
                        ERR_CANAL ,
                        ERR_ZONA
                FROM    dbo.TMP_Usuario;
        TRUNCATE TABLE dbo.TMP_Usuario;

        SELECT  @SUBIDOS subidos ,
                @INSERTADOR insertados ,
                @ACTUALIZADOS actualizados ,
                @ERRORESGeneral;


    END;



GO
/****** Object:  StoredProcedure [dbo].[USP_CARGAZONA]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_CARGAZONA]
AS
    BEGIN
        DECLARE @ID BIGINT;
        DECLARE @CODIGO VARCHAR(MAX);
        DECLARE @NOMBRE VARCHAR(MAX);

        DECLARE @CONTADOR_REG INT;

        DECLARE @SUBIDOS INT= ( SELECT  COUNT(*)
                                FROM    dbo.TMP_ZONA
                              );
        DECLARE @INSERTADOR INT = 0;
        DECLARE @ACTUALIZADOS INT= 0;
        DECLARE @ERRORES INT; 
		DECLARE @ERRORESGeneral VARCHAR(max)=''; 

        TRUNCATE TABLE dbo.ERR_ZONA;
        DECLARE cur_tempZona CURSOR
        FOR
            SELECT  ID ,
                    Codigo ,
                    Nombre
            FROM    dbo.TMP_ZONA;
        OPEN cur_tempZona;
        FETCH NEXT FROM cur_tempZona INTO @ID, @CODIGO, @NOMBRE;
        WHILE @@FETCH_STATUS = 0
            BEGIN
                SET @ERRORES = 0;
                IF @CODIGO IS NULL
                    OR @CODIGO = ''
                    BEGIN
                        UPDATE  dbo.TMP_ZONA
                        SET     ERR_Codigo = ' CAMPOS OBLIGATORIOS VACIO'
                        WHERE   ID = @ID;
                        SET @ERRORES = @ERRORES + 1;
						SET @ERRORESGeneral=@ERRORESGeneral+' CAMPOS OBLIGATORIOS VACIO'
                    END;
              
                IF @NOMBRE IS NULL
                    OR @NOMBRE = ''
                    BEGIN
                        UPDATE  dbo.TMP_ZONA
                        SET     ERR_Nombre = ' CAMPOS OBLIGATORIOS VACIO'
                        WHERE   ID = @ID;
                        SET @ERRORES = @ERRORES + 1;
						SET @ERRORESGeneral=@ERRORESGeneral+' CAMPOS OBLIGATORIOS VACIO'
                    END;
                IF @ERRORES = 0
                    BEGIN
                        SET @CONTADOR_REG = 0;
                        SET @CONTADOR_REG = ( SELECT    COUNT(Codigo)
                                              FROM      dbo.GRZona
                                              WHERE     Codigo = @CODIGO
                                            );
                        IF @CONTADOR_REG = 0
                            BEGIN
                                INSERT  INTO dbo.GRZona
                                        ( Codigo, Nombre, Flag )
                                VALUES  ( @CODIGO, -- Codigo - varchar(50)
                                          @NOMBRE, -- Nombre - varchar(150)
                                          'T'  -- Flag - char(1)
                                          );
                                SET @INSERTADOR = @INSERTADOR + 1;
                            END;
                        ELSE
                            BEGIN 
                                UPDATE  dbo.GRZona
                                SET     Nombre = @NOMBRE
                                WHERE   Codigo = @CODIGO;
                                SET @ACTUALIZADOS = @ACTUALIZADOS + 1;
                            END;
                    END;
                FETCH NEXT FROM cur_tempZona INTO @ID, @CODIGO, @NOMBRE;
            END;
        CLOSE cur_tempZona;
        DEALLOCATE cur_tempZona;
        INSERT  INTO dbo.ERR_ZONA
                ( ID ,
                  Codigo ,
                  Nombre ,
                  ERR_Codigo ,
                  ERR_Nombre ,
                  ERR_AUX
		        )
                SELECT  *
                FROM    dbo.TMP_ZONA;
				TRUNCATE TABLE dbo.TMP_ZONA
        SELECT  @SUBIDOS subidos ,
                @INSERTADOR insertados ,
                @ACTUALIZADOS actualizados ,
                @ERRORESGeneral;

    END;



GO
/****** Object:  StoredProcedure [dbo].[USPC_ERROR_CLIENTE]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[USPC_ERROR_CLIENTE]
AS

SELECT  TOP 100 [ID] AS WEB_FILA,
	Razon_Social AS WEB_RAZONSOCIAL,
	RUC  AS WEB_RUC,
	Direccion AS WEB_DIRECION,
	Referencia AS WEB_REFERENCIA,
	CodZona AS WEB_ZONA,
    CodCanal AS WEB_CANAL,
	DBO.FORMATEAR_ERROR('Razon Social', ERR_Razon_Social) + '|' +
	DBO.FORMATEAR_ERROR('RUC', ERR_RUC) + '|' +
	DBO.FORMATEAR_ERROR('Direccion', ERR_Direccion) + '|' +
	DBO.FORMATEAR_ERROR('Referencia', ERR_Referencia) + '|' + 
	DBO.FORMATEAR_ERROR('CodZona', ERR_CodZona) + '|' + 
	DBO.FORMATEAR_ERROR('CodCanal', ERR_CodCanal) + '|' + 
	ISNULL(ERR_AUX,'') AS WEB_ERROR2
FROM dbo.ERR_Cliente










GO
/****** Object:  StoredProcedure [dbo].[USPC_ERROR_CONTACTOS]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[USPC_ERROR_CONTACTOS]
AS

SELECT  TOP 100 [ID] AS WEB_FILA,
	Nombres AS WEB_NOMBRES,
	Telefono  AS WEB_TELEFONO,
	Email AS WEB_EMAIL,
	Cargo AS WEB_CARGO,
    Ruc_Cliente AS WEB_RUC_CLIENTE,
	CodZona AS WEB_ZONA,
	DBO.FORMATEAR_ERROR('Nombres', ERR_Nombres) + '|' +
	DBO.FORMATEAR_ERROR('Telefono', ERR_Telefono) + '|' +
	DBO.FORMATEAR_ERROR('Email', ERR_Email) + '|' +
	DBO.FORMATEAR_ERROR('Cargo', ERR_Cargo) + '|' + 
	DBO.FORMATEAR_ERROR('Ruc_Cliente', ERR_Ruc_Cliente) + '|' + 
	DBO.FORMATEAR_ERROR('CodZona', ERR_CodZona) + '|' + 
	ISNULL(ERR_AUX,'') AS WEB_ERROR2
FROM dbo.ERR_Contacto










GO
/****** Object:  StoredProcedure [dbo].[USPC_ERROR_USUARIO]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[USPC_ERROR_USUARIO]
AS

SELECT  TOP 100 [ID] AS WEB_FILA,
	Codigo AS WEB_CODIGO,
	Nombres  AS WEB_NOMBRE,
	LoginUsuario AS WEB_LOGIN,
    Clave AS WEB_CLAVE,
	CodPerfil AS WEB_PERFIL,
	Email AS WEB_EMAIL,
	ZONA as WEB_ZONA,
	CANAL as WEB_CANAL,
	DBO.FORMATEAR_ERROR('Codigo', ERR_Codigo) + '|' +
	DBO.FORMATEAR_ERROR('Nombres', ERR_Nombres) + '|' +
	DBO.FORMATEAR_ERROR('LoginUsuario', ERR_LoginUsuario) + '|' +
	DBO.FORMATEAR_ERROR('Clave', ERR_Clave) + '|' + 
	DBO.FORMATEAR_ERROR('CodPerfil', ERR_CodPerfil) + '|' + 
	DBO.FORMATEAR_ERROR('Email', ERR_Email) + '|' + 
	DBO.FORMATEAR_ERROR('ZONA', ERR_ZONA) + '|' + 
	DBO.FORMATEAR_ERROR('CANAL', ERR_CANAL) + '|' + 
	ISNULL(ERR_AUX,'') AS WEB_ERROR2
FROM ERR_Usuario










GO
/****** Object:  StoredProcedure [dbo].[USPC_ERROR_ZONA]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USPC_ERROR_ZONA]
AS
BEGIN

SELECT  TOP 100 [ID] AS WEB_FILA,
	Codigo AS WEB_CODIGO,
	Nombre  AS WEB_NOMBRE,	
	DBO.FORMATEAR_ERROR('CODIGO', ERR_Codigo) + '|' +
	DBO.FORMATEAR_ERROR('NOMBRE', ERR_Nombre) + '|' + 
	ISNULL(ERR_AUX,'') AS WEB_ERROR2
FROM dbo.ERR_ZONA
END



GO
/****** Object:  StoredProcedure [dbo].[USPC_LIMPIAR_TABLA]    Script Date: 3/03/2019 02:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[USPC_LIMPIAR_TABLA]
	@SP_NAME VARCHAR(5000)
AS

DECLARE @SQL VARCHAR(8000)

SET @SQL = 'TRUNCATE TABLE ' + @SP_NAME

EXEC (@SQL)










GO
