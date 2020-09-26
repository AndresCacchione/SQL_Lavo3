use Actividad_1_punto_2
go
create table Paises
(
	IDpais smallint not null identity(1,1),
	NombrePais varchar(50) not null
)
go
alter table Paises
add constraint PK_Paises primary key (IDpais)
go
alter table Paises
add constraint UN_Paises unique (NombrePais)

go
use Actividad_1_punto_2
go
create table Datos_x_usuario
(
	IDDatosUsuario bigint not null identity (1,1),
	Apellido varchar(50) not null,
	Nombre varchar(50) not null,
	FechaNacimiento date not null,
	Genero varchar(1) not null,
	CodigoPostal smallint not null,
	Domicilio varchar(100) not null,
	IDPais smallint not null
)
go
alter table Datos_x_usuario
add constraint PK_Datos_x_usuario primary key (IDDatosUsuario)
go
alter table Datos_x_usuario
add constraint CHK_IDDatosUsuario check (FechaNacimiento<getdate())
go
alter table Datos_x_usuario
add constraint CHKG_IDDatosUsuario check (upper(Genero) in ('M','F'))
go
alter table Datos_x_usuario
add constraint CHKCP_IDDatosUsuario check (CodigoPostal>0)
go
alter table Datos_x_usuario
add constraint FK_IDDatosUsuario foreign key (IDPais) references Paises(IDpais)
go
use Actividad_1_punto_2
go
create table Usuario
(
	IDUsuario bigint not null identity (1,1),
	IDDatosUsuario bigint not null,
	NombreUsuario varchar(50)
)
go
alter table Usuario
add constraint PK_Usuario primary key (IDUsuario)
go
alter table Usuario
add constraint FK_Usuario foreign key (IDDatosUsuario) references Datos_x_usuario(IDDatosUsuario)
go
alter table Usuario
add constraint UNIDDatosUsuario_Usuario unique (IDDatosUsuario)
alter table Usuario
add constraint UNNombreUsuario_Usuario unique (NombreUsuario)

go
use Actividad_1_punto_2
go
create table Mails_x_usuario
(
	IDUsuario bigint not null,
	Email varchar(100) not null
)
go
alter table Mails_x_usuario
add constraint PK_Mails_x_usuario primary key (IDUsuario, Email)
go
alter table Mails_x_usuario
add constraint UN_Mails_x_usuario unique (Email)
go
alter table Mails_x_usuario
add constraint FK_Mails_x_usuario foreign key (IDUsuario) references Usuario(IDUsuario)
go

use Actividad_1_punto_2
go
create table Telefonos_x_usuario
(
	IDUsuario bigint not null,
	Telefono bigint not null
)
go
alter table Telefonos_x_usuario
add constraint PK_Telefonos_x_usuario primary key (IDUsuario, Telefono)
go
alter table Telefonos_x_usuario
add constraint FK_Telefonos_x_usuario foreign key (IDUsuario) references Usuario(IDUsuario)
go

use Actividad_1_punto_2
go
create table Instructores
(
	IDUsuario bigint not null,
	IDCurso bigint not null
)
go
alter table Instructores
add constraint PK_Instructores primary key (IDUsuario,IDCurso)
go
alter table Instructores
add constraint FKIDUsuario_Instructores foreign key (IDUsuario) references Usuario(IDUsuario)
go
alter table Instructores
add constraint FKIDCurso_Instructores foreign key (IDCurso) references Cursos(IDCursos)
go


use Actividad_1_punto_2
go

create table Inscripciones
(
	IDInscripciones bigint not null identity(1,1),
	IDCurso bigint not null,
	IDUsuario bigint not null,
	FechaInscripcion date not null
)

alter table Inscripciones
add constraint PK_Inscripciones primary key(IDCurso, IDUsuario, FechaInscripcion)
go
alter table Inscripciones
add constraint UNIDInscripciones_Inscripciones unique(IDInscripciones)
go
alter table Inscripciones
add constraint CHKFechaInscripcion_Inscripciones check(FechaInscripcion<=getdate())
go
alter table Inscripciones
add constraint FKIDCurso_Inscripciones foreign key (IDCurso) references Cursos(IDCursos)
go
alter table Inscripciones
add constraint FKIDUsuario_Inscripciones foreign key (IDUsuario) references Usuario(IDUsuario)
go


use Actividad_1_punto_2
go

create table Certificaciones
(
	IDInscripcion bigint not null,
	FechaCertificacion date not null
)

alter table Certificaciones
add constraint PK_Certificaciones primary key (IDInscripcion)
go
alter table Certificaciones
add constraint FK_Certificaciones foreign key (IDInscripcion) references Inscripciones(IDInscripciones)
go
alter table Certificaciones
add constraint CHKFechaCertificacion_Certificaciones check (FechaCertificacion<= getdate())
go


use Actividad_1_punto_2
go

create table Reseñas
(
	IDInscripcion bigint not null,
	Mensaje varchar(200) not null,
	Puntaje tinyint not null
)
go
alter table Reseñas
add constraint PK_Reseñas primary key(IDInscripcion)
go
alter table Reseñas
add constraint FKIDInscripcion_Reseñas foreign key (IDInscripcion) references Inscripciones(IDInscripciones)
go
alter table Reseñas
add constraint CHKPuntaje_Reseñas check (Puntaje>=1 and Puntaje <=10)



use Actividad_1_punto_2
go
create table Pagos_x_inscripcion
(
	IDInscripcion bigint not null,
	NumeroDePago tinyint not null,
	FechaPago date not null,
	Importe money not null
)
go
alter table Pagos_x_inscripcion
add constraint PK_Pagos_x_inscripcion primary key (IDInscripcion, NumeroDePago)
go
alter table Pagos_x_inscripcion
add constraint FKIDInscripcion_Pagos_x_inscripcion foreign key (IDInscripcion) references Inscripciones(IDInscripciones)
go
alter table Pagos_x_inscripcion
add constraint CHKNumeroDePago_Pagos_x_inscripcion check (NumeroDePago>0)
go
alter table Pagos_x_inscripcion
add constraint CHKImporte_Pagos_x_inscripcion check (Importe>0)
go
alter table Pagos_x_inscripcion
add constraint CHKFechaPago_Pagos_x_inscripcion check (FechaPago<=getdate())