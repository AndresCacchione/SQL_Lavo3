Create Database Facultad
Use Facultad

Create table Carreras(
	ID char(4) not null primary key,
	Nombre varchar(100) not null,
	FechaCreacion date not null check(FechaCreacion<getdate()),
	Mail varchar(100) not null,
	Nivel varchar(100) not null check(Nivel in ('Diplomatura', 'Pregrado', 'Grado', 'Posgrado'))
)

Create table Alumnos(
	Legajo int not null primary key identity(1000,1),
	IDCarrera char(4) not null foreign key references Carreras(ID),
	Apellidos varchar(100) not null,
	Nombres varchar(100) not null,
	FechaNacimiento date not null check(FechaNacimiento<getdate()),
	Mail varchar(100) not null unique,
	Telefono bigint null check(Telefono>0)
)

Create table Materias(
	Materias smallint not null primary key identity(1,1),
	Nombre varchar(100) not null,
	CargaHoraria smallint not null check(CargaHoraria>0),
	IDCarrera char(4) not null foreign key references Carreras(ID)
)