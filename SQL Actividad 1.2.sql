create database Actividad_1_punto_2
Use Actividad_1_punto_2
go
create table TipoContenido
(
	idTipoContenido Tinyint not null identity(1,1),
	nombreTipoContenido varchar(30) not null
)

GO
alter table tipoContenido
add constraint PK_TC primary key(idTipoContenido)
GO
alter table tipoContenido
add constraint U_TC unique(nombreTipoContenido)
go
--drop table Cursos
set dateformat 'DMY'
go
create table Cursos
(
	IDCursos Bigint not null identity (1,1),
	NombreCursos varchar(50) not null,
	FechaEstreno date not null,
	CostoCursado money not null,
	CostoCertificado money not null,
	Nivel varchar(20) null
)

go
alter table Cursos
add constraint PK_C primary key (IDCursos)
go
alter table Cursos
add constraint CHE_C check (CostoCursado >=0)
go
alter table Cursos
add constraint CHE_CostoCertificado check (CostoCertificado >=0)
go
alter table Cursos
add constraint CHE_nivel check(Nivel in ('Aficionado','Principiante','Medio','Avanzado'))
go
alter table Cursos
add constraint CHE_FechaEstreno check(FechaEstreno <= getdate())