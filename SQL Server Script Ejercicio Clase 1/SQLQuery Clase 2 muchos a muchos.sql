Create Database MuchosaMuchos
go
Use MuchosaMuchos
go
Create Table Empleados (
	Mail varchar(60) not null primary key,
	Apellidos varchar(100) not null,
	Nombres varchar(100) not null,
	Fnac date null
)
go

Create table Lenguajes(
	ID int not null primary key identity (1,1),
	Nombre varchar(50) not null
)
go

Create table Lenguajes_x_Empleado(
	Mail varchar(60) not null,
	IDLenguaje int not null,
	Nivel tinyint not null check (Nivel >=1 and Nivel <=10),
	--Primary key(Mail, IDLenguaje)
)

go
Alter table Lenguajes_x_Empleado
Add Constraint PK_LxE Primary key (Mail, IDLenguaje)
go

Alter table Lenguajes_x_Empleado
Add constraint FK_MailEmpleados Foreign key(Mail) References Empleados(Mail)
go
Alter table Lenguajes_x_Empleado
Add constraint FK_Lenguajes Foreign key (IDLenguaje) References Lenguajes(ID)

-- Carga de datos
-- Empleados
Set dateformat 'DMY'
Insert into Empleados (Mail, Apellidos, Nombres, Fnac) values('angel', 'simon', 'angel', '01/01/2000')
Insert into Empleados (Mail, Apellidos, Nombres, Fnac) values('Alejandro', 'Olivera', 'Alejandro', '22/10/1984')
Insert into Empleados (Mail, Apellidos, Nombres, Fnac) values('Silvana', 'Ferrari', 'Silvana', '01/01/2000')

-- Lenguajes
Insert into Lenguajes values('C')
Insert into Lenguajes values('Java')
Insert into Lenguajes values('Javascript')

-- Lenguajes x empleado
Insert into Lenguajes_x_Empleado (Mail, IDLenguaje, Nivel) values('angel',3,6), ('silvana',1,10)
Insert into Lenguajes_x_Empleado (Mail, IDLenguaje, Nivel) values('angel',1,4), ('alejandro',1,10)