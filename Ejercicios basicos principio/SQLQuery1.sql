/*Create Database Clase01 --crea la base de datos.

Use Clase01 --usa la base de datos indicada.
*/
Create Table Areas( --crea la tabla.
	ID smallint not null primary key identity(1, 1), --primer valor que recibe es el valor desde el que empieza, y el segundo de cuanto en cuanto aumento el autonumerico.
	Nombre varchar(50) not null,
	Presupuesto money not null check(Presupuesto>0),
	Mail varchar(100) not null
)

Create Table Empleados(
	Legajo bigint not null primary key,
	IDArea smallint not null foreign key references Areas(ID),
	Apellido varchar(100) not null,
	Nombre varchar(100) not null,
	FechaNac date not null,
	Mail varchar(100) not null unique,
	Telefono varchar(20) null,
	Sueldo money not null check(Sueldo >0)
)