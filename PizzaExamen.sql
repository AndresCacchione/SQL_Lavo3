create database PizzaExamen
use PizzaExamen
 
create table Pizza
(
	IDpizza bigint identity(1,1) primary key,
	PrecioVenta money not null,
	Nombre varchar(100) not null,
)
go
alter table Pizza
add constraint CHK_PV check (PrecioVenta>0)
go
alter table Pizza
add constraint UNI_NombreP unique (Nombre)
go
create table Ingrediente
(
	IDingrediente bigint identity(1,1) primary key,
	Nombre varchar(100) not null,
	cantidadUtilizada decimal(6,2) not null,
	IDPizza bigint
)
go
alter table Ingrediente
add constraint FK_IDPizza foreign key (IDPizza) references Pizza(IDpizza)
go
alter table Ingrediente
add constraint CHK_cantidadUtilizada check (cantidadUtilizada>0)
go
alter table Ingrediente
add constraint UNI_NombreI unique (Nombre)