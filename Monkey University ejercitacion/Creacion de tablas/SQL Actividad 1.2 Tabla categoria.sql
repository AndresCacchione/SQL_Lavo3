use Actividad_1_punto_2
go
create table categoria
(
	IDCategoria int not null identity,
	NombreCategoria varchar(20) not null
)
go
alter table categoria
add constraint PK_Categoria primary key (IDCategoria)
go
alter table categoria
add constraint UNI_C unique (NombreCategoria)