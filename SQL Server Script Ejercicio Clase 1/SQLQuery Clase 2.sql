/*Create Database UnoaUno
go
Use UnoaUno
Go
Create table Libros(
 ID bigint not null,
 Titulo varchar(150) not null,
 FechaPublicacion date null
)
Go
Alter Table Libros
Add Paginas smallint null
Go
Alter Table Libros
Add Constraint PK_Libros Primary Key(ID)
Go
Alter Table Libros
Add Constraint CHK_PagPositivas Check (Paginas>0)
go

Create table Portadas(
 ID bigint not null,
 Portada varchar(250),
 Contratapa varchar(250)
)
go
Alter Table Portadas
Add constraint PK_Portada Primary key (ID)
go
Alter Table Portadas
Add constraint FK_PortadasLibros Foreign key (ID) References Libros(ID)
go
Alter table Libros
Drop Column FechaPublicacion
*/
go
-- Carga datos
Insert into Libros(ID, Titulo, Paginas) Values (100, 'Sherlock Holmes', 140)
go
Insert into Libros(ID, Titulo, Paginas) Values (100, 'Carrie', 140)
