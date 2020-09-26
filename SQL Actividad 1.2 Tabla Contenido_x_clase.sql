use Actividad_1_punto_2
go
create table Contenido_x_clase
(
	IDContenido Bigint not null identity,
	IDClases bigint not null,
	idTipoContenido tinyint not null,
	Tamaño int not null
)
go
alter table Contenido_x_clase
add constraint PK_Contenido_x_clase primary key(IDContenido)
go
alter table Contenido_x_clase
add constraint FK_IDClases_Contenido_x_clase foreign key (IDClases) references Clases_x_curso(IDClases)
go
alter table Contenido_x_clase
add constraint FK_idTipoContenido_Contenido_x_clase foreign key (idTipoContenido) references TipoContenido(idTipoContenido)
go
alter table Contenido_x_clase
add constraint CHK_Tamaño_Contenido_x_clase check (Tamaño>0)
