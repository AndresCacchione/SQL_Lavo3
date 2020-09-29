use MonkeyUniv

-- Por cada a�o, la cantidad de cursos que se estrenaron en dicho a�o y el promedio de costo de cursada.

select year(c.Estreno) as A�o, count(*) as 'CursosEstrenados', avg(c.CostoCurso) as 'Promedio de costo'
from Cursos c
group by year(c.Estreno)
order by year(c.Estreno) desc

--El idioma que se haya utilizado m�s veces como subt�tulo. Si hay varios idiomas en esa condici�n, mostrarlos a todos.
select aux.Nombre
from
	(select top 1 with ties i.Nombre, count(*) as CantIdiomas
	from Idiomas_x_Curso ixc, TiposIdioma ti, Idiomas i
	where ixc.IDTipo=ti.ID and ixc.IDIdioma=i.ID 
	and ti.Nombre like '%subt�tulo%'
	group by ixc.IDIdioma, i.Nombre
	order by count(*) desc
	) as aux

--Apellidos y nombres de usuarios que cursaron alg�n curso y nunca fueron instructores de cursos.

select distinct dat.apellidos, dat.nombres
from Datos_Personales dat, Inscripciones i
where dat.ID=i.IDUsuario and dat.ID not in
(select distinct IDUsuario 
from Instructores_x_Curso ixc, Datos_Personales
where Datos_Personales.ID = ixc.IDUsuario)

--Para cada usuario mostrar los apellidos y nombres y el costo m�s caro de un curso al que se haya inscripto. En caso de no haberse inscripto a ning�n curso debe figurar igual pero con importe igual a -1.

select dat.nombres, dat.apellidos, isnull(max(i.costo),-1) as 'Costo del curso mas caro'
from Datos_Personales dat left join Inscripciones i
on dat.ID=i.IDUsuario
group by dat.Nombres, dat.Apellidos

--La cantidad de usuarios que hayan realizado rese�as positivos pero nunca una rese�a negativa.

---resoluci�n luego de la explicaci�n---
select count(tablaAux.apenom) as 'Cantidad de usuarios' 
from
	(select dat.nombres + ' , ' + dat.apellidos as apenom,
			(select count(*)
			from Rese�as r, Inscripciones i
			where i.IDUsuario= dat.ID and i.ID=r.IDInscripcion
			and r.Puntaje>6
			) as Positivas,
		
			(select count (*)
			from Rese�as r, Inscripciones i
			where dat.id=i.IDUsuario and i.ID=r.IDInscripcion
			and r.Puntaje<7
			) as Negativas
	from Datos_Personales dat
	) as tablaAux
where tablaAux.Positivas>0 and tablaAux.Negativas=0





--------------------- mal resuelto por mi en el intento -----------------

select count(distinct i.idusuario) as 'Cantidad de usuarios'
from Inscripciones i inner join rese�as res
on i.ID=res.IDInscripcion
where i.ID not in 
(select ins.ID
from Inscripciones ins, Rese�as r
where r.IDInscripcion=ins.ID 
and r.Puntaje < 7)
