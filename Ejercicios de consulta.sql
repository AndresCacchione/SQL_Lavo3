use MonkeyUniv

/*1
Listado de todos los idiomas. */

select Nombre from Idiomas

/*
2
Listado de todos los cursos. */

select Nombre from Cursos

/*
3
Listado con nombre, costo de inscripción, costo de certificación y fecha de estreno de todos los cursos.*/

select Nombre, CostoCurso, CostoCertificacion, Estreno from Cursos

/*
4
Listado con ID, nombre, costo de inscripción e ID de nivel de todos los cursos cuyo costo de certificación sea menor a $ 5000.*/

select * from Cursos

select ID, Nombre, CostoCurso as CostoInscripcion, IDNivel from Cursos where CostoCertificacion < 5000

/*
5
Listado con ID, nombre, costo de inscripción e ID de nivel de todos los cursos cuyo costo de certificación sea mayor a $ 1200.*/

select * from Cursos

select ID, Nombre, CostoCurso as CostoInscripcion, IDNivel from Cursos where CostoCertificacion>1200

/*
6
Listado con nombre, número y duración de todas las clases del curso con ID número 6.*/

select * from Clases

select Nombre, Numero, Duracion from Clases where IDCurso = 6

/*
7
Listado con nombre, número y duración de todas las clases del curso con ID número 10. */

select Nombre, Numero, Duracion from Clases where IDCurso = 10

/*
8
Listado con nombre y duración de todas las clases con ID número 4. Ordenado por duración de mayor a menor.
*/

select * from Clases

select Nombre, Duracion from Clases where IDCurso = 4 order by Duracion desc

/*
9
Listado con nombre, fecha de estreno, costo del curso, costo de certificación ordenados por fecha de estreno de manera creciente.*/

select * from Cursos
select Nombre, Estreno as FechaEstreno, CostoCurso, CostoCertificacion from Cursos order by FechaEstreno asc

/*
10
Listado con nombre, fecha de estreno y costo del curso de todos aquellos cuyo ID de nivel sea 1, 5, 9 o 10.*/

select * from Cursos
select Nombre, Estreno as FechaEstreno, CostoCurso from Cursos where IDNivel in (1,5,9,10)

/*
11
Listado con nombre, fecha de estreno e ID de curso de todos los cursos cuyo número de clase sea 1, 4, o 5.*/

select * from Cursos
select * from Clases

select distinct Cursos.Nombre, Cursos.Estreno as FechaEstreno, Cursos.ID from Cursos inner join Clases on Cursos.ID = Clases.IDCurso and Clases.Numero in (1,4,5)

/*
12
Listado con nombre, duración y costo del curso de todos aquellos cuyo ID de nivel no sean 1, 5, 9 y 10.*/

--select Cursos.Nombre, Clases.Duracion, Cursos.CostoCurso from Cursos inner join Clases on Cursos.ID = Clases.IDCurso Group by Cursos.Nombre
--select Clases.IDCurso, sum(Clases.Duracion) as DuracionTotal, Cursos.CostoCurso from Clases inner join Cursos on Cursos.ID = Clases.IDCurso group by Clases.IDCurso

select Cur.Nombre, sum(Cl.Duracion) as Duracion, Cur.CostoCurso 
from Cursos as Cur inner join Clases as Cl
on Cur.ID = Cl.IDCurso
where Cur.IDNivel not in (1, 5, 9, 10) or IDNivel is null
group by Cl.IDCurso, Cur.Nombre, Cur.CostoCurso

/*
13
Listado con nombre y fecha de estreno de todos los cursos cuya fecha de estreno haya sido en el primer semestre del año 2019.*/

select Nombre, Estreno as fechaEstreno from Cursos where Estreno between '01/01/2019' and '06/30/2019'

/*
14
Listado de cursos cuya fecha de estreno haya sido en el año 2020.*/

select Cursos.Nombre from Cursos where Year(Cursos.Estreno) in (2020)

/*
15
Listado de cursos cuya mes de estreno haya sido entre el 1 y el 4.*/

select Cursos.Nombre from Cursos where MONTH(Cursos.Estreno) between 1 and 4

/*
16
Listado de clases cuya duración se encuentre entre 15 y 90 minutos.*/

select * from Cursos
select * from Clases
select ID, Nombre from Clases where Clases.Duracion between 15 and 90 order by Nombre asc

/*
17
Listado de contenidos cuyo tamaño supere los 5000MB y sean de tipo 4 o sean menores a 400MB y sean de tipo 1.*/

select * from Contenidos where (Tamaño>5000 and IDTipo=4) or (Tamaño<400 and IDTipo=1) order by ID asc, Tamaño desc

/*
18
Listado de cursos que no posean ID de nivel.*/

select * from Cursos where Cursos.IDNivel is null

/*
19
Listado de cursos cuyo costo de certificación corresponda al 20% o más del costo del curso.*/

select * from Cursos where Cursos.CostoCertificacion >= (Cursos.CostoCurso*0.2)

/*
20
Listado de costos de cursado de todos los cursos sin repetir y ordenados de mayor a menor.
*/

select distinct Cursos.CostoCurso from Cursos order by Cursos.CostoCurso desc