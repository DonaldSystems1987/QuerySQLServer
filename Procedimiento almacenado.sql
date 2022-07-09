use kalum_test
go 
--Funcion nos permite rellenar caracteres hacia la derecha (Nos servira para armar los numeros correlativos del carnet)
create function RPAD
(
	@String varchar(MAX),--Creamos funcion llamada String se coloco MAX porque no sabemos cuantos caracteres pueden enviar, CADENA INICIAL
	@length int,         --Parametro que recibira la longitud de cantidad de caracteres que coloquemos, TAMAÑO DEL STRING FINAL
	@pad char            --Colocar caracter con el cual deseamos reemplazar los valores, 
)
returns varchar(MAX)
AS
BEGIN
	return @string + replicate(@pad, @length - len(@String)) --Len nos devuelve la cantidad de caracteres que tiene @string
END
go
select dbo.RPAD('1',4,'0') --Llamando a funcion dbo.RPAD  = 1000
go
--Funcion nos permiete rellenar caracteres hacia la izquierda
create function LPAD
(
	@String varchar(MAX),
	@length int,         
	@pad char            
)
returns varchar(MAX)
AS
BEGIN
	return replicate(@pad, @length - len(@String)) + @String
END
go
select dbo.LPAD('1',4,'0') --Llamando a funcion dbo.LPAD  = 0001
go
select concat('2022',dbo.LPAD('1',4,'0')) --llamando funcion concatenando el año 2022 = 20220001
go
--Creacion de procedimientos almacenados
select * from Aspirante a

select * from CarreraTecnica ct

select * from InversionCarreraTecnica ict 

--Insertaremos la inversion de un estudiante que desea inscribirse tomaremos la CarreraID Y realizaremos un insert a la tabla de InversionCarreraTecnica
insert into InversionCarreraTecnica values(newid(),'460686D7-495C-4460-8A2D-4122A8F876F7',1200,5,750)
insert into InversionCarreraTecnica values(newid(),'E073F8D7-05AF-4B53-80DB-210A9EA9CA55',850,5,850)

select * from Cargo c --Manejaremos 3 cargos pago de incripcion de carrera tecnica, pago mensualidad y carne cada uno con su repectivo prefijo

insert into Cargo values(newid(),'Pago de inscripcion de carrera tecnica Plan fin de semana','INSCT',1200,0,0)
insert into Cargo values(newid(),'Pago mensual carrera tecnica','PGMCT',850,0,0)
insert into Cargo values(newid(),'Carne','CARNE',30,0,0)
--Procediminiento almacenado para el Proceso de inscripcion 
go
alter procedure sp_EnrollmentProcess @NoExpediente varchar(12), @Ciclo varchar(4), @MesInicioPago int, @CarreraId varchar(128)
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

select * from cargo C

select(2022 * 10000) + 1

select SUBSTRING('GUATEMALA',6,4)--substraer caracteres de una cadena = MALA
select SUBSTRING('20220001',1,4)-- 2022 substrae el año

select CONCAT('INSC',SUBSTRING('2022',3,2),dbo.lpad('1',2,'0')) --Concatenar

--modificacion en cuentas por cobrar para que podamos agregar Cargo INSCT2201 correlativamente  INSCT2202,INSCT2203, etc
--Violation of PRIMARY KEY constraint 'PK__CuentaPo__68A1C0DEF3BFE253'. Cannot insert duplicate key in object 'dbo.CuentaPorCobrar'. The duplicate key value is (INSCT2201).
select name from sys.key_constraints where type = 'PK' and OBJECT_NAME(parent_object_id) = N'CuentaPorCobrar' --Trae nombre de la llave primaria
go
alter table CuentaPorCobrar drop constraint PK__CuentaPo__68A1C0DEF3BFE253
go
--Permite que podamos agregar los correlativos en Cargo INSCT2201 correlativamente  INSCT2202,INSCT2203, etc
alter table CuentaPorCobrar add primary key(Cargo,Anio,Carne) 

select * from InversionCarreraTecnica ict where ict.CarreraId = '460686D7-495C-4460-8A2D-4122A8F876F7'

--ejecutar proceso almacenado sino hay error mostrara mensaje: TRANSACTION SUCCESS
execute sp_EnrollmentProcess'EXP-20220001','2022',2,'460686D7-495C-4460-8A2D-4122A8F876F7' 


select * from Aspirante a

select * from Alumno a

delete from Alumno where Carne > 0

select * from Inscripcion i

delete from Inscripcion where Carne > 0

select * from CuentaPorCobrar cc

delete from CuentaPorCobrar where Anio > 0

select * from cargo c

select * from  CuentaPorCobrar cc where carne = 2022003

select * from Aspirante a where a.NoExpediente = 'EXP-20220001';

update Aspirante set Estatus = 'SIGUE PROCESO DE ADMISION' where NoExpediente = 'EXP-20220001'

select * from CarreraTecnica ct

execute sp_rename 'CarreraTecnica.CarreraTecnica', 'Nombre', 'COLUMN'

select * from Jornada j

execute sp_rename 'Jornada.Jornada', 'Jorn', 'COLUMN'

select * from ExamenAdmision ea

select * from Inscripcion i

select * from Alumno a

execute sp_rename 'Alumno.Carnet', 'Carne', 'COLUMN'

select * from CuentaPorCobrar cpc

execute sp_rename 'CuentaPorCobrar.Cargo', 'Correlativo', 'COLUMN'


select * from CuentaPorCobrar cpc

select * from CarreraTecnica ct

select * from ExamenAdmision ea

select * from Aspirante a

select * from Jornada j

select * from Inscripcion i
select * from Alumno a

select * from cargo c

select * from InversionCarreraTecnica ict

execute sp_EnrollmentProcess'EXP-20220001','2022',2,'460686D7-495C-4460-8A2D-4122A8F876F7' 

delete from Alumno WHERE Carne = 20220014


