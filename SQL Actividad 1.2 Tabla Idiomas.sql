Use Actividad_1_punto_2
go
create table Idioma
(
	IDIdioma Smallint not null identity,
	NombreIdioma varchar(20) not null
)
go
alter table Idioma
add constraint PK_I primary key (IDIdioma)
go
alter table Idioma
add constraint UN_I unique(NombreIdioma)

