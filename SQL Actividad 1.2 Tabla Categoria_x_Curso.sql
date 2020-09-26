use Actividad_1_punto_2
go
create table Categoria_x_Curso
(
	IDCursos Bigint not null,
	IDCategoria int not null 
)
go
alter table Categoria_x_Curso
add constraint PK_Categoria_x_Curso primary key(IDCursos, IDCategoria)
go
alter table Categoria_x_Curso
add constraint FK_IDCursos_Categoria_x_Curso foreign key(IDCursos) references Cursos(IDCursos)
go
alter table Categoria_x_Curso
add constraint FK_IDCategoria_Categoria_x_Curso foreign key(IDCategoria) references categoria(IDCategoria)
go
alter table Categoria_x_Curso
add constraint POS_IDCursos_Categoria_x_Curso check(IDCursos>0)
go
alter table Categoria_x_Curso
add constraint POS_IDCategoria_Categoria_x_Curso check(IDCategoria>0)
