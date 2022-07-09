create database kalum_test --Creando base de datos kalum_test
go
use kalum_test --Seleccionando la base de datos que vamos a utilizar
go
create table ExamenAdmision
(
 ExamenId varchar(128) primary key not null,
 FechaExamen datetime not null
)
go
create table CarreraTecnica
(
 CarreraId varchar(128) primary key not null,
 CarreraTecnica varchar(128) not null
)
go
create table Jornada
(
 JornadaId varchar(128) primary key not null,
 Jornada varchar(2) not null,
 Descripcion varchar(128) not null
)
go
create table Aspirante
(
 NoExpediente varchar(128) primary key not null,
 Apellidos varchar(128) not null,
 Nombres varchar(128) not null,
 Direccion varchar(128) not null,
 Telefono varchar(64) not null,
 Email varchar(128) not null unique,
 Estatus varchar(32) default 'NO ASIGNADO',
 CarreraId varchar(128) not null,
 ExamenId varchar(128) not null,
 JornadaId varchar(128) not null,
 constraint FK_ASPIRANTE_CARRERA_TECNICA foreign key (CarreraId) references CarreraTecnica(CarreraId),
 constraint FK_ASPIRANTE_EXAMEN_ADMISION foreign key (ExamenId) references ExamenAdmision(ExamenId),
 constraint FK_ASPIRANTE_JORNADA foreign key (JornadaId) references Jornada(JornadaId)
)
go
create table ResultadoExamenAdmision
(
 NoExpediente varchar(128) not null,
 Anio varchar(4) not null,
 Descripcion varchar(128) not null,
 Nota int default 0,
 primary key(NoExpediente,Anio),
 constraint FK_RESULTADO_EXAMEN_ADMISION_ASPIRANTE foreign key (NoExpediente) references Aspirante(NoExpediente)
)
go
create table InscripcionPago
(
 BoletaPago varchar(128) not null,
 NoExpediente varchar(128) not null,
 Anio varchar(4) not null,
 FechaPago datetime not null,
 Monto decimal(10,2) not null
 primary key(BoletaPago, NoExpediente, Anio),
 constraint FK_INSCRIPCION_PAGO foreign key (NoExpediente) references Aspirante(NoExpediente)
)
go
create table InversionCarreraTecnica
(
 InversionId varchar(128) not null,
 CarreraId varchar(128) not null,
 MontoInscripcion decimal(10,2) not null,
 NumeroPago int default 0,
 MontoPago decimal(10,2) not null
 primary key(InversionId, CarreraId),
 constraint FK_INVERSION_CARRERA_TECNICA foreign key (CarreraId) references CarreraTecnica(CarreraId)
)
go
create table Alumno
(
 Carne varchar(8) primary key not null,
 Apellidos varchar(128) not null,
 Nombres varchar(128) not null,
 Direccion varchar(128) not null,
 Telefono varchar(64) not null,
 Email varchar(64) not null unique
)
go
create table Cargo
(
 CargoId varchar(128) primary key not null,
 Descripcion varchar(128) not null,
 Prefijo varchar(64) not null,
 Monto decimal(10,2) not null,
 GeneraMora bit not null,
 PorcentajeMora int default 0
)
go
create table CuentaPorCobrar
(
 Cargo varchar(128) primary key not null,
 Anio varchar(4) not null,
 Carne varchar(8) not null,
 CargoId varchar(128) not null,
 Descripcion varchar(128) not null,
 FechaCargo datetime not null,
 FechaAplica datetime not null,
 Monto decimal (10,2) not null,
 Mora decimal (10,2) not null,
 Descuento decimal (10,2) not null,
 constraint FK_CUENTA_POR_COBRAR_ALUMNO foreign key (Carne) references Alumno(Carne),
 constraint FK_CUENTA_POR_COBRAR_CARGO foreign key (CargoId) references Cargo(CargoId)
)
go
create table Inscripcion
(
 InscripcionId varchar(128) primary key not null,
 Carne varchar(8) not null,
 CarreraId varchar(128) not null,
 JornadaId varchar(128) not null,
 Ciclo varchar(4) not null,
 FechaInscripcion datetime not null,
 constraint FK_INSCRIPCION_ALUMNO foreign key (Carne) references Alumno(Carne),
 constraint FK_INSCRIPCION_CARRERA_TECNICA foreign key (CarreraId) references CarreraTecnica(CarreraId),
 constraint FK_INCRIPCION_JORNADA foreign key (JornadaId) references Jornada(JornadaId)
)
go
select * from Aspirante a
go
select * from ExamenAdmision ea
go
select * from CarreraTecnica ct
go
select * from Jornada j
go
--Creacion de carreras tecnicas
insert into CarreraTecnica (CarreraId,CarreraTecnica) values (NEWID(),'Desarrollo de aplicaciones empresariales con .NET Core');
insert into CarreraTecnica (CarreraId,CarreraTecnica) values (NEWID(),'Desarrollo de aplicaciones empresariales con JAVA EE');
insert into CarreraTecnica (CarreraId,CarreraTecnica) values (NEWID(),'Desarrollo de aplicaciones Moviles');
go
--Creacion de examenes de admision
insert into ExamenAdmision (ExamenId,FechaExamen) values (NEWID(),'2022-04-30');
insert into ExamenAdmision (ExamenId,FechaExamen) values (NEWID(),'2022-05-30');
insert into ExamenAdmision (ExamenId,FechaExamen) values (NEWID(),'2022-06-20');
go
--Creacion de jornadas
insert into Jornada (JornadaId,Jornada,Descripcion) values (NEWID(),'JM','Jornada Matutina');
insert into Jornada (JornadaId,Jornada,Descripcion) values (NEWID(),'JV','Jornada Vespertina');
go
--Creacion de aspirantes
insert into Aspirante(NoExpediente,Apellidos,Nombres,Direccion,Telefono,Email,CarreraId,ExamenId,JornadaId) 
values ('EXP-20220001',
'Hernandez Chan',
'Donald Rene',
'Guatemala, Guatemala',
'24340974',
'donaldchan@gmail.com',
'460686D7-495C-4460-8A2D-4122A8F876F7',
'6D31AE9E-05DE-4162-B2B9-FE05201B0349',
'39174948-DA82-438C-9BE4-52F29729B590');
go
insert into Aspirante(NoExpediente,Apellidos,Nombres,Direccion,Telefono,Email,CarreraId,ExamenId,JornadaId) 
values ('EXP-20220002',
'Alvarado Fernandez',
'Nancy Elizabeth',
'Guatemala, Guatemala',
'24340587',
'nancy1987@gmail.com',
'5F108B5C-52F9-42A5-888E-980A7E622195',
'7E029128-55AB-4419-9528-94839628F6D6',
'39174948-DA82-438C-9BE4-52F29729B590');
go
insert into Aspirante(NoExpediente,Apellidos,Nombres,Direccion,Telefono,Email,CarreraId,ExamenId,JornadaId) 
values ('EXP-20220003',
'Reyes Chan',
'Hugo Daniel',
'Guatemala, Guatemala',
'54124585',
'hugorey@gmail.com',
'E073F8D7-05AF-4B53-80DB-210A9EA9CA55',
'B8B7CF58-CAE2-4934-8C19-20ABA5A5A4B5',
'532846E1-CCFA-4B48-BC08-270E96406C04');
go
--Consultas
--01 Mostrar los aspirantes que se van a examinar el dia 30 de abril, se debe mostrar el Expediente, Apellidos, Nombres, Fecha Examen, Carrera Tecnica y Estatus
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
where ea.FechaExamen  = '2022-04-30' order by a.Apellidos
go
--View (Vistas)
create view vw_ListarAspirantePorFechaExamen
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
go
select Apellidos, Nombres, Estatus from vw_ListarAspirantePorFechaExamen where FechaExamen = '2022.04.30' order by Apellidos
go
select * from ResultadoExamenAdmision rea
go
--Trigger(Disparador)--Trabajan a nivel de tablas, el disparador se ejecutara despues que hallamos ejecutado el registro despues que se almacena el dato en la tabla alli despues se ejecuta el disparador
--Trigger que se encarga de actualizar la informacion de la base de datos en la tabla de aspirantes
create trigger tg_ActualizarEstadoAspirante on ResultadoExamenAdmision after insert --Indicamos que disparador se ejecute en tabla ResultadoExamenAdmision despues del insert
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

insert into ResultadoExamenAdmision (NoExpediente, Anio, Descripcion, Nota) values ('EXP-20220002','2022','Resultado Examen',65)
select * from ResultadoExamenAdmision rea
select * from Aspirante a
select * from Alumno 

