create database prueba
go
use prueba
--go
--drop table Datospersonales

create table Datospersonales
(
	NombreApellido varchar(50) not null,
	Edad tinyint not null,
	Nacionalidad varchar(30) not null
)
go
alter table Datospersonales
add constraint PK_Datospersonales primary key (NombreApellido)
go
alter table Datospersonales
add default 'Argentina' for Nacionalidad
go
alter table Datospersonales
add default 18 for Edad
go
alter table Datospersonales
add constraint UN_Datospersonales unique (Edad,Nacionalidad)
go
insert into Datospersonales (NombreApellido, Edad) values ('Naza White',20),('Ailen Jero', 26),('Andres Cacchione', 33),('Jeronimo Majdalani',20)
go
insert into Datospersonales (NombreApellido) values ('Naza'),('1000'),('2000')
go
insert into Datospersonales (NombreApellido,Edad,Nacionalidad)
select 'Jose Perez','18', 'Uruguaya'
go
insert into Datospersonales (NombreApellido,Edad,Nacionalidad)
select 'Juan Gonzalez', '22', 'Paraguaya'
go
update Datospersonales set Edad = 25, NombreApellido= 'Andy' where NombreApellido= 'Andres Cacchione'
go
delete from Datospersonales where Nacionalidad = 'Paraguaya' or Edad = '26'
go
select * from Datospersonales

