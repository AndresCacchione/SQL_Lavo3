Use Actividad_1_punto_2
go
create table Formato_x_idioma_x_curso
(
	IDCursos bigint not null,
	IDIdioma Smallint not null,
	IDFormatos Bigint not null	
)
go
alter table Formato_x_idioma_x_curso
add constraint PK_Formato_x_idioma_x_curso primary key(IDCursos,IDIdioma,IDFormatos)
go
alter table Formato_x_idioma_x_curso
add constraint FK_IDCursos_Formato_x_idioma_x_curso foreign key(IDCursos) references Cursos(IDCursos)
go
alter table Formato_x_idioma_x_curso
add constraint FK_IDIdiomas_Formato_x_idioma_x_curso foreign key(IDIdioma) references Idioma(IDIdioma)
go
alter table Formato_x_idioma_x_curso
add constraint FK_IDFormatos_Formato_x_idioma_x_curso foreign key(IDFormatos) references Formatos(ID)
go
alter table Formato_x_idioma_x_curso
add constraint POS_IDCursos_Formato_x_idioma_x_curso check (IDCursos>=1)
go
alter table Formato_x_idioma_x_curso
add constraint POS_IDIdioma_Formato_x_idioma_x_curso check (IDIdioma>=1)
go
alter table Formato_x_idioma_x_curso
add constraint POS_IDFormatos_Formato_x_idioma_x_curso check (IDFormatos>=1)