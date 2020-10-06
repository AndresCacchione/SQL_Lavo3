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
	Nombre varchar(100) not null
)
go
alter table Ingrediente
add constraint UNI_NombreI unique (Nombre)

go
create table Ingrediente_x_pizza
(
	idIngrediente bigint not null foreign key references Ingrediente(IDingrediente),
	idPizza bigint not null foreign key references Pizza(IDpizza),
	cantidadUtilizada decimal(6,2) not null check (cantidadUtilizada >0)
)

go
alter table Ingrediente_x_pizza
add constraint PK_ixp primary key (idIngrediente, idPizza)