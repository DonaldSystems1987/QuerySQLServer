USE [kalum_test]
GO
/****** Object:  Table [dbo].[ExamenAdmision]    Script Date: 9/07/2022 11:59:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ExamenAdmision](
	[ExamenId] [varchar](128) NOT NULL,
	[FechaExamen] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ExamenId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CarreraTecnica]    Script Date: 9/07/2022 11:59:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CarreraTecnica](
	[CarreraId] [varchar](128) NOT NULL,
	[Nombre] [varchar](128) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CarreraId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Aspirante]    Script Date: 9/07/2022 11:59:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Aspirante](
	[NoExpediente] [varchar](128) NOT NULL,
	[Apellidos] [varchar](128) NOT NULL,
	[Nombres] [varchar](128) NOT NULL,
	[Direccion] [varchar](128) NOT NULL,
	[Telefono] [varchar](64) NOT NULL,
	[Email] [varchar](128) NOT NULL,
	[Estatus] [varchar](32) NULL,
	[CarreraId] [varchar](128) NOT NULL,
	[ExamenId] [varchar](128) NOT NULL,
	[JornadaId] [varchar](128) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[NoExpediente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_ListarAspirantePorFechaExamen]    Script Date: 9/07/2022 11:59:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vw_ListarAspirantePorFechaExamen]
as
select 
	NoExpediente, 
	Apellidos,
	Nombres, 
	FechaExamen, 
	CarreraTecnica, 
	Estatus 
from Aspirante a 
inner join ExamenAdmision ea on a.ExamenId = ea.ExamenId
inner join CarreraTecnica ct on a.CarreraId = ct.CarreraId
GO
/****** Object:  Table [dbo].[Alumno]    Script Date: 9/07/2022 11:59:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Alumno](
	[Carne] [varchar](8) NOT NULL,
	[Apellidos] [varchar](128) NOT NULL,
	[Nombres] [varchar](128) NOT NULL,
	[Direccion] [varchar](128) NOT NULL,
	[Telefono] [varchar](64) NOT NULL,
	[Email] [varchar](64) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Carne] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cargo]    Script Date: 9/07/2022 11:59:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cargo](
	[CargoId] [varchar](128) NOT NULL,
	[Descripcion] [varchar](128) NOT NULL,
	[Prefijo] [varchar](64) NOT NULL,
	[Monto] [decimal](10, 2) NOT NULL,
	[GeneraMora] [bit] NOT NULL,
	[PorcentajeMora] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[CargoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CuentaPorCobrar]    Script Date: 9/07/2022 11:59:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CuentaPorCobrar](
	[Correlativo] [varchar](128) NOT NULL,
	[Anio] [varchar](4) NOT NULL,
	[Carne] [varchar](8) NOT NULL,
	[CargoId] [varchar](128) NOT NULL,
	[Descripcion] [varchar](128) NOT NULL,
	[FechaCargo] [datetime] NOT NULL,
	[FechaAplica] [datetime] NOT NULL,
	[Monto] [decimal](10, 2) NOT NULL,
	[Mora] [decimal](10, 2) NOT NULL,
	[Descuento] [decimal](10, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Correlativo] ASC,
	[Anio] ASC,
	[Carne] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Inscripcion]    Script Date: 9/07/2022 11:59:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inscripcion](
	[InscripcionId] [varchar](128) NOT NULL,
	[Carne] [varchar](8) NOT NULL,
	[CarreraId] [varchar](128) NOT NULL,
	[JornadaId] [varchar](128) NOT NULL,
	[Ciclo] [varchar](4) NOT NULL,
	[FechaInscripcion] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[InscripcionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[InscripcionPago]    Script Date: 9/07/2022 11:59:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InscripcionPago](
	[BoletaPago] [varchar](128) NOT NULL,
	[NoExpediente] [varchar](128) NOT NULL,
	[Anio] [varchar](4) NOT NULL,
	[FechaPago] [datetime] NOT NULL,
	[Monto] [decimal](10, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[BoletaPago] ASC,
	[NoExpediente] ASC,
	[Anio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[InversionCarreraTecnica]    Script Date: 9/07/2022 11:59:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InversionCarreraTecnica](
	[InversionId] [varchar](128) NOT NULL,
	[CarreraId] [varchar](128) NOT NULL,
	[MontoInscripcion] [decimal](10, 2) NOT NULL,
	[NumeroPago] [int] NULL,
	[MontoPago] [decimal](10, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[InversionId] ASC,
	[CarreraId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Jornada]    Script Date: 9/07/2022 11:59:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Jornada](
	[JornadaId] [varchar](128) NOT NULL,
	[Jorn] [varchar](2) NOT NULL,
	[Descripcion] [varchar](128) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[JornadaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ResultadoExamenAdmision]    Script Date: 9/07/2022 11:59:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ResultadoExamenAdmision](
	[NoExpediente] [varchar](128) NOT NULL,
	[Anio] [varchar](4) NOT NULL,
	[Descripcion] [varchar](128) NOT NULL,
	[Nota] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[NoExpediente] ASC,
	[Anio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Aspirante] ADD  DEFAULT ('NO ASIGNADO') FOR [Estatus]
GO
ALTER TABLE [dbo].[Cargo] ADD  DEFAULT ((0)) FOR [PorcentajeMora]
GO
ALTER TABLE [dbo].[InversionCarreraTecnica] ADD  DEFAULT ((0)) FOR [NumeroPago]
GO
ALTER TABLE [dbo].[ResultadoExamenAdmision] ADD  DEFAULT ((0)) FOR [Nota]
GO
ALTER TABLE [dbo].[Aspirante]  WITH CHECK ADD  CONSTRAINT [FK_ASPIRANTE_CARRERA_TECNICA] FOREIGN KEY([CarreraId])
REFERENCES [dbo].[CarreraTecnica] ([CarreraId])
GO
ALTER TABLE [dbo].[Aspirante] CHECK CONSTRAINT [FK_ASPIRANTE_CARRERA_TECNICA]
GO
ALTER TABLE [dbo].[Aspirante]  WITH CHECK ADD  CONSTRAINT [FK_ASPIRANTE_EXAMEN_ADMISION] FOREIGN KEY([ExamenId])
REFERENCES [dbo].[ExamenAdmision] ([ExamenId])
GO
ALTER TABLE [dbo].[Aspirante] CHECK CONSTRAINT [FK_ASPIRANTE_EXAMEN_ADMISION]
GO
ALTER TABLE [dbo].[Aspirante]  WITH CHECK ADD  CONSTRAINT [FK_ASPIRANTE_JORNADA] FOREIGN KEY([JornadaId])
REFERENCES [dbo].[Jornada] ([JornadaId])
GO
ALTER TABLE [dbo].[Aspirante] CHECK CONSTRAINT [FK_ASPIRANTE_JORNADA]
GO
ALTER TABLE [dbo].[CuentaPorCobrar]  WITH CHECK ADD  CONSTRAINT [FK_CUENTA_POR_COBRAR_ALUMNO] FOREIGN KEY([Carne])
REFERENCES [dbo].[Alumno] ([Carne])
GO
ALTER TABLE [dbo].[CuentaPorCobrar] CHECK CONSTRAINT [FK_CUENTA_POR_COBRAR_ALUMNO]
GO
ALTER TABLE [dbo].[CuentaPorCobrar]  WITH CHECK ADD  CONSTRAINT [FK_CUENTA_POR_COBRAR_CARGO] FOREIGN KEY([CargoId])
REFERENCES [dbo].[Cargo] ([CargoId])
GO
ALTER TABLE [dbo].[CuentaPorCobrar] CHECK CONSTRAINT [FK_CUENTA_POR_COBRAR_CARGO]
GO
ALTER TABLE [dbo].[Inscripcion]  WITH CHECK ADD  CONSTRAINT [FK_INCRIPCION_JORNADA] FOREIGN KEY([JornadaId])
REFERENCES [dbo].[Jornada] ([JornadaId])
GO
ALTER TABLE [dbo].[Inscripcion] CHECK CONSTRAINT [FK_INCRIPCION_JORNADA]
GO
ALTER TABLE [dbo].[Inscripcion]  WITH CHECK ADD  CONSTRAINT [FK_INSCRIPCION_ALUMNO] FOREIGN KEY([Carne])
REFERENCES [dbo].[Alumno] ([Carne])
GO
ALTER TABLE [dbo].[Inscripcion] CHECK CONSTRAINT [FK_INSCRIPCION_ALUMNO]
GO
ALTER TABLE [dbo].[Inscripcion]  WITH CHECK ADD  CONSTRAINT [FK_INSCRIPCION_CARRERA_TECNICA] FOREIGN KEY([CarreraId])
REFERENCES [dbo].[CarreraTecnica] ([CarreraId])
GO
ALTER TABLE [dbo].[Inscripcion] CHECK CONSTRAINT [FK_INSCRIPCION_CARRERA_TECNICA]
GO
ALTER TABLE [dbo].[InscripcionPago]  WITH CHECK ADD  CONSTRAINT [FK_INSCRIPCION_PAGO] FOREIGN KEY([NoExpediente])
REFERENCES [dbo].[Aspirante] ([NoExpediente])
GO
ALTER TABLE [dbo].[InscripcionPago] CHECK CONSTRAINT [FK_INSCRIPCION_PAGO]
GO
ALTER TABLE [dbo].[InversionCarreraTecnica]  WITH CHECK ADD  CONSTRAINT [FK_INVERSION_CARRERA_TECNICA] FOREIGN KEY([CarreraId])
REFERENCES [dbo].[CarreraTecnica] ([CarreraId])
GO
ALTER TABLE [dbo].[InversionCarreraTecnica] CHECK CONSTRAINT [FK_INVERSION_CARRERA_TECNICA]
GO
ALTER TABLE [dbo].[ResultadoExamenAdmision]  WITH CHECK ADD  CONSTRAINT [FK_RESULTADO_EXAMEN_ADMISION_ASPIRANTE] FOREIGN KEY([NoExpediente])
REFERENCES [dbo].[Aspirante] ([NoExpediente])
GO
ALTER TABLE [dbo].[ResultadoExamenAdmision] CHECK CONSTRAINT [FK_RESULTADO_EXAMEN_ADMISION_ASPIRANTE]
GO
/****** Object:  StoredProcedure [dbo].[sp_EnrollmentProcess]    Script Date: 9/07/2022 11:59:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_EnrollmentProcess] @NoExpediente varchar(12), @Ciclo varchar(4), @MesInicioPago int, @CarreraId varchar(128)
AS
BEGIN --Registros que necesitamos de tabla de Aspirantes
    --Variables para informacion de aspirantes
	declare @Apellidos varchar(128) 
	declare @Nombres varchar(128)
	declare @Direccion varchar(128)
	declare @Telefono varchar(64)
	declare @Email varchar(64)
	declare @JornadaId varchar(128)
	--Variables para generar numero de carne
	declare @Exists int
	declare @Carne varchar(12)
	--Varibles para proceso de pago
	declare @MontoInscripcion numeric(10,2)
	declare @NumeroPagos int 
	declare @MontoPago numeric(10,2) --1000000.00
	declare @Descripcion varchar(128)
	declare @Prefijo varchar(6)
	declare @CargoId varchar(128)
	declare @Monto numeric(10,2)
	declare @CorrelativoPagos int
	--Transaccion nos asegura que la data quede persistente, esta se ejecuta o no se ejecuta
	--Inicio de transaccion
	begin transaction
	begin try
	   select @Apellidos = Apellidos, @Nombres = Nombres, @Direccion = Direccion, @Telefono = Telefono, @Email = Email, @JornadaId = JornadaId
			from Aspirante where NoExpediente = @NoExpediente--traer informacion Aspirante
		set @Exists = (select top 1 a.Carne from Alumno a where SUBSTRING(a.Carne,1,4) = @Ciclo ORDER by a.Carne DESC) --para asignar valor a una variable debe colocarse set
		if @Exists is NULL
		BEGIN
			set @Carne = (@Ciclo * 10000) + 1 --Aca se tiene el primer correlativo para el carne
		END
		ELSE 
		BEGIN
			set @Carne = (select top 1 a.Carne from Alumno a where SUBSTRING(a.Carne,1,4) = @Ciclo ORDER by a.Carne DESC) + 1 --tambien puede usarse la variable @Exists + 1
		END
		--Proceso de  inscripcion(Registrar el Alumno en alumno)
		--insert into Alumno values (@Carne, @Apellidos, @Nombres, @Direccion, @Telefono, @Email)
		insert into Alumno values(@Carne,@Apellidos,@Nombres,@Direccion,@Telefono,concat(@Carne,@Email))
		--Registrar la incripcion del alumno
		insert into Inscripcion values(newid(),@Carne,@CarreraId,@JornadaId,@Ciclo,getdate())	
		--Modificando estatus del aspirante
		update Aspirante set estatus = 'INSCRITO CICLO ' + @Ciclo where NoExpediente = @NoExpediente
		--Proceso de cargos
	    --Cargo de inscripcion
		select @MontoInscripcion = MontoInscripcion, @NumeroPagos = NumeroPago, @MontoPago = MontoPago
			from InversionCarreraTecnica ict where ict.CarreraId = @CarreraId
		select @CargoId = CargoId, @Descripcion = Descripcion, @Prefijo = Prefijo
			from Cargo c2 where c2.CargoId = 'B0067498-C3E3-42B2-9D5F-3DB3FB488BA8'
		insert into CuentaPorCobrar values(concat(@Prefijo,substring(@Ciclo,3,2),dbo.lpad('1',2,'0')),@Ciclo,@Carne,@CargoId,@Descripcion,GETDATE(),GETDATE(),@MontoInscripcion,0,0)

		--Cargo pago de carne
		select @CargoId = CargoId, @Descripcion = Descripcion, @Prefijo = Prefijo, @Monto = Monto
			from Cargo c2 where c2.CargoId = '475DCF16-430F-4176-85D6-2CD5A37FB03D'	
		insert into CuentaPorCobrar
		 values(concat(@Prefijo,substring(@Ciclo,3,2),dbo.lpad('1',2,'0')),@Ciclo,@Carne,@CargoId,@Descripcion,GETDATE(),GETDATE(),@Monto,0,0)

		--Cargos mensuales
		set @CorrelativoPagos = 1 --los pagos comenzaran de 1 en adelante
		select @CargoId = CargoId, @Descripcion = Descripcion, @Prefijo = Prefijo from Cargo c2 where c2.CargoId = 'EC403BBE-344E-4772-B6BC-02E84BC8FD14'
		while(@CorrelativoPagos <= @NumeroPagos)
		BEGIN
			insert into CuentaPorCobrar
				values(concat(@Prefijo,substring(@Ciclo,3,2),dbo.lpad(@CorrelativoPagos,2,'0')),@Ciclo,@Carne,@CargoId,@Descripcion,GETDATE(),concat(@Ciclo,'-',dbo.LPAD(@MesInicioPago,2,'0'),'-','05'),@MontoPago,0,0)
			set @CorrelativoPagos = @CorrelativoPagos + 1
			set @MesInicioPago = @MesInicioPago + 1
		END 
		commit transaction -- commit Significa que todo lo que se ejecuto antes finalizo la transaccion
		select 'TRANSACTION SUCCESS' as status, @Carne as carne
	end try
	begin catch--Capturamos el error
		/*SELECT
			ERROR_NUMBER() AS ErrorNumber
			,ERROR_SEVERITY()AS ErrorSeverity
			,ERROR_STATE()AS ErrorState
			,ERROR_PROCEDURE() AS ErrorProcedure
			,ERROR_LINE() AS ErrorLine
			,ERROR_MESSAGE() AS ErrorMessage*/
		rollback transaction--deshacer la transaccion sino se ejecuto correctamente 
		select 'TRANSACTION ERROR' as status, 0 as carne
	end catch
END
GO
/****** Object:  Trigger [dbo].[tg_ActualizarEstadoAspirante]    Script Date: 9/07/2022 11:59:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[tg_ActualizarEstadoAspirante] on [dbo].[ResultadoExamenAdmision] after insert --Indicamos que disparador se ejecute en tabla ResultadoExamenAdmision despues del insert
AS --Necesitamos NoExpediene que se esta modificando, primero validaremos si la nota esta arriba de 70
BEGIN
	declare @Nota int = 0
	declare @Expediente varchar(128)
	declare @Estatus varchar(64) = 'NO ASIGNADO'
	set @Nota = (select Nota from inserted)
	set @Expediente = (select NoExpediente from inserted);
	if @Nota >=70 
	begin
		set @Estatus = 'Sigue proceso de admision'
	end
	ELSE
	BEGIN
		SET @Estatus = 'No sigue proceso de admision'
	END	
	update Aspirante set estatus = @Estatus where NoExpediente = @Expediente 
END
GO
ALTER TABLE [dbo].[ResultadoExamenAdmision] ENABLE TRIGGER [tg_ActualizarEstadoAspirante]
GO
