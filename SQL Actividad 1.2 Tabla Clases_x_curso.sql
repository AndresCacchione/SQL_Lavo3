use	Actividad_1_punto_2
go
create table Clases_x_curso
(
	IDCursos bigint not null,
	IDClases bigint not null identity,
	NombreClase varchar(50) not null,
	NumeroClase smallint not null,
	Duracion smallint not null
)
go
alter table Clases_x_curso
add constraint POS_Duracion_Clases_x_curso check (Duracion>0)
go
alter table Clases_x_curso
add constraint POS_NumeroClase_Clases_x_curso check (NumeroClase>=1)
go
alter table Clases_x_curso
add constraint PK_Clases_x_curso primary key (IDCursos, NumeroClase)
go
alter table Clases_x_curso
add constraint UNIQ_IDClases_Clases_x_curso unique(IDClases)
go
alter table Clases_x_curso
add constraint FK_IDCursos_Clases_x_curso foreign key (IDCursos) references Cursos(IDCursos)