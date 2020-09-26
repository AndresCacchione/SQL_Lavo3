use Actividad_1_punto_2

go
create table Formatos
(
	ID Bigint not null identity(1,1),
	NombreFormatos varchar(30) not null 
)

go
alter table Formatos
add constraint PK_Formatos primary key (ID)
