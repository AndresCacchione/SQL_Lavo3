use MonkeyUniv
-- (1)  Listado con la cantidad de cursos.
	select count(*) as 'Cantidad Cursos' from Cursos

-- 2  Listado con la cantidad de usuarios.
	select count(*) as 'Cantidad usuarios' from Usuarios

-- (3)  Listado con el promedio de costo de certificaci�n de los cursos.
	select avg(Cursos.CostoCertificacion) as 'Promedio costo cursos' from Cursos

-- 4  Listado con el promedio general de calificaci�n de rese�as.
	select avg(Rese�as.Puntaje) as 'Promedio calificaci�n rese�as' from Rese�as

-- (5)  Listado con la fecha de estreno de curso m�s antigua.
	select min(Cursos.Estreno) as 'Fecha estreno mas antigua' from Cursos


-- 6  Listado con el costo de certificaci�n menos costoso.
	select min(Cursos.CostoCertificacion) as 'Certificacion menos costosa' from Cursos

-- (7)  Listado con el costo total de todos los cursos.
	select sum(Cursos.CostoCurso) as 'Costo total cursos' from Cursos

-- 8  Listado con la suma total de todos los pagos.
	select sum(Pagos.Importe) as 'Suma total pagos' from Pagos

-- 9  Listado con la cantidad de cursos de nivel principiante.
	select count(n.Nombre) as 'Cursos principiante' from
	Cursos as c inner join Niveles as n on n.ID=c.IDNivel
	where n.Nombre like 'principiante'

-- 10  Listado con la suma total de todos los pagos realizados en 2019.
	select sum(p.Importe) as 'Total pagos a�o 2019'
	from Pagos as p
	where year(p.Fecha)= 2019

-- (11)  Listado con la cantidad de usuarios que son instructores.
	select count(distinct ixc.IDUsuario) as 'Cantidad instructores' from Instructores_x_Curso as ixc
	

-- Listado de usuarios distintos de Instructores_x_curso
	

-- 12  Listado con la cantidad de usuarios distintos que se hayan certificado.
	select count(distinct i.IDUsuario) as 'Cantidad usuarios certificados'
	from Certificaciones as c inner join Inscripciones as i on i.ID=c.IDInscripcion

-- (13)  Listado con el nombre del pa�s y la cantidad de usuarios de cada pa�s.
	select p.Nombre, count(dat.ID) from Paises as p left join Datos_Personales as dat
	on p.ID=dat.IDPais
	group by p.Nombre
	order by p.Nombre asc

-- (14)  Listado con el apellido y nombres del usuario y el importe m�s costoso abonado como pago. S�lo listar aquellos que hayan abonado m�s de $7500.
	select dat.Apellidos + ',' + dat.Nombres as 'Nombre y apellido', max(p.Importe) as 'Importe mayor'
	from Datos_Personales as dat inner join Usuarios as u on u.ID=dat.ID
	inner join Inscripciones as i on i.IDUsuario=u.ID
	inner join Pagos as p on p.IDInscripcion=i.ID
	group by dat.Apellidos + ',' + dat.Nombres having max(p.Importe) >7500

-- 15  Listado con el apellido y nombres de usuario y el importe m�s costoso de curso al cual se haya inscripto.
	select dat.Apellidos + ',' + dat.Nombres as 'Apellido y nombre', u.NombreUsuario, max(i.Costo) as 'Costo maximo curso'
	from Datos_Personales as dat inner join Usuarios as u on u.ID=dat.ID
	inner join Inscripciones as i on i.IDUsuario=u.ID
	group by dat.Apellidos + ',' + dat.Nombres, u.NombreUsuario

-- 16  Listado con el nombre del curso, nombre del nivel, cantidad total de clases y duraci�n total del curso en minutos.
	select cur.Nombre, n.Nombre, count(cur.ID) as 'Cantidad Clases', sum(c.Duracion) as 'Duraci�n minutos'
	from Clases as c right join Cursos as cur on c.IDCurso=cur.ID
	left join Niveles as n on n.ID=cur.IDNivel
	group by cur.Nombre, n.Nombre

-- 17  Listado con el nombre del curso y cantidad de contenidos registrados. S�lo listar aquellos cursos que tengan m�s de 10 contenidos registrados.
	select c.Nombre, count(c.ID) as 'Cantidad de contenidos'
	from Cursos as c inner join Clases as cl on cl.IDCurso=c.ID
	inner join contenidos as con on con.IDClase=cl.ID
	group by c.Nombre having count(c.ID) >10

-- 18  Listado con nombre del curso, nombre del idioma y cantidad de tipos de idiomas.
	select c.Nombre, i.Nombre, count(ixc.IDTipo) as 'Cantidad de tipos de idiomas'
	from cursos as c inner join	Idiomas_x_Curso as ixc on c.ID=ixc.IDCurso
	inner join Idiomas as i on i.ID=ixc.IDIdioma
	group by i.Nombre, c.Nombre

-- 19  Listado con el nombre del curso y cantidad de idiomas distintos disponibles.
	select c.Nombre, count(distinct ixc.IDIdioma) as 'Cantidad de tipos de idiomas'
	from cursos as c inner join Idiomas_x_Curso as ixc on ixc.IDCurso=c.ID
	group by c.Nombre

-- 20  Listado de categor�as de curso y cantidad de cursos asociadas a cada categor�a. S�lo mostrar las categor�as con m�s de 5 cursos.
	select c.Nombre, count(cxc.IDCurso) as 'Cursos asociados'
	from Categorias as c left join Categorias_x_Curso as cxc on cxc.IDCategoria=c.ID
	group by c.Nombre
	having count(cxc.IDCurso) >5

-- 21  Listado con tipos de contenido y la cantidad de contenidos asociados a cada tipo. Mostrar aquellos tipos que no hayan registrado contenidos con cantidad 0.
	select t.Nombre, count(c.ID)
	from Contenidos as c right join TiposContenido as t on t.ID=c.IDTipo
	group by t.Nombre

-- 22  Listado con Nombre del curso, nivel, a�o de estreno y el total recaudado en concepto de inscripciones. Listar aquellos cursos sin inscripciones con total igual a $0.
	
	select c.nombre, n.nombre, year(c.Estreno) as 'A�o estreno', sum(case when p.importe is null then 0 else p.Importe end) as 'Total recaudado'
	from Cursos as c left join Niveles as n on n.ID=c.IDNivel
	left join Inscripciones as i on i.IDCurso=c.ID
	left join Pagos as p on p.IDInscripcion=i.ID
	group by c.Nombre, n.Nombre, year(c.Estreno)


	--asi lo quiere el profe
	select c.nombre, n.nombre, year(c.Estreno) as 'A�o estreno', sum(i.Costo) as 'Total recaudado'
	from Cursos as c left join Niveles as n on n.ID=c.IDNivel
	left join Inscripciones as i on i.IDCurso=c.ID
	group by c.Nombre, n.Nombre, year(c.Estreno)

-- 23  Listado con Nombre del curso, costo de cursado y certificaci�n y cantidad de usuarios distintos inscriptos cuyo costo de cursado sea menor a $10000 y cuya cantidad de usuarios inscriptos sea menor a 5. Listar aquellos cursos sin inscripciones con cantidad 0.
	
	--el profe lo tiene distinto, ni idea por qu�.
	select c.nombre, c.costocurso, c.CostoCertificacion, count(distinct i.IDUsuario) as 'Usuarios distintos'
	from Cursos as c left join Inscripciones as i on i.IDCurso=c.ID
	where i.Costo < 10000
	group by c.Nombre, c.costocurso,c.CostoCertificacion having count(distinct i.idusuario)<5

	/*
	select c.nombre, i.IDUsuario, i.Costo
	from Cursos as c left join Inscripciones as i on i.IDCurso=c.ID
	where i.Costo < 10000
	*/

-- 24  Listado con Nombre del curso, fecha de estreno y nombre del nivel del curso que m�s recaud� en concepto de certificaciones.
	select top 1 c.nombre, c.estreno, n.nombre
	from Cursos as c left join Niveles as n on n.ID=c.IDNivel
	inner join Inscripciones as i on i.IDCurso=c.ID
	inner join Certificaciones as cer on cer.IDInscripcion=i.ID
	group by c.nombre, c.estreno, n.nombre
	order by sum(cer.costo) desc

-- 25  Listado con Nombre del idioma del idioma m�s utilizado como subt�tulo.
	
	select top 1 id.Nombre
	from Inscripciones as i inner join Cursos as c on c.ID=i.IDCurso
	inner join Idiomas_x_Curso as ixc on c.ID=ixc.IDCurso
	inner join TiposIdioma as ti on ti.ID=ixc.IDTipo
	inner join Idiomas as id on id.ID=ixc.IDIdioma
	where ti.Nombre like 'subt�tulo'
	group by id.Nombre
	order by count(id.Nombre) desc

-- 26  Listado con Nombre del curso y promedio de puntaje de rese�as apropiadas.
	select c.Nombre, avg(r.Puntaje) as 'Promedio puntaje rese�as'
	from Cursos as c inner join Inscripciones as i on c.ID=i.IDCurso
	inner join Rese�as as r on r.IDInscripcion=i.ID
	where r.Inapropiada=0
	group by c.Nombre

-- 27  Listado con Nombre de usuario y la cantidad de rese�as inapropiadas que registr�.
	select u.NombreUsuario, count(r.inapropiada) as 'Cantidad de rese�as inapropiadas'
	from Usuarios as u left join Inscripciones as i on u.ID=i.IDUsuario
	left join Rese�as as r on r.IDInscripcion=i.ID
	where r.Inapropiada=1 or r.Inapropiada is null
	group by u.NombreUsuario
	order by u.NombreUsuario asc

	/*
	select u.NombreUsuario, sum(case when r.Inapropiada =1 then 1 else 0 end) as 'Cantidad de rese�as inapropiadas'
	from Usuarios as u left join Inscripciones as i on u.ID=i.IDUsuario
	left join Rese�as as r on r.IDInscripcion=i.ID
	group by u.NombreUsuario
	order by u.NombreUsuario asc
	*/

	select u.NombreUsuario, sum(cast(r.inapropiada as int)) as 'Cantidad de rese�as inapropiadas'
	from Usuarios as u left join Inscripciones as i on u.ID=i.IDUsuario
	left join Rese�as as r on r.IDInscripcion=i.ID
	group by u.NombreUsuario
	order by u.NombreUsuario asc


-- 28  Listado con Nombre del curso, nombre y apellidos de usuarios y la cantidad de veces que dicho usuario realiz� dicho curso. No mostrar cursos y usuarios que contabilicen cero.
	select c.Nombre, dat.Nombres+','+dat.Apellidos as 'Nombre y apellido', count(c.Nombre) 'Cantidad de veces que hizo el curso'
	from cursos as c inner join Inscripciones as i on i.IDCurso=c.ID
	inner join Usuarios as u on u.ID=i.IDUsuario
	inner join Datos_Personales as dat on dat.ID=u.ID
	group by dat.Nombres,dat.Apellidos, c.Nombre
	order by dat.Apellidos asc

-- 29  Listado con Apellidos y nombres, mail y duraci�n total en concepto de clases de cursos a los que se haya inscripto. S�lo listar informaci�n de aquellos registros cuya duraci�n total supere los 400 minutos.
	select dat.Apellidos, dat.Nombres, dat.Email, sum(cl.Duracion) as 'Duraci�n total'
	from Datos_Personales as dat inner join Usuarios as u on u.ID=dat.ID
	inner join Inscripciones as i on i.IDUsuario=u.ID
	inner join Cursos as c on c.ID=i.IDCurso
	inner join Clases as cl on cl.IDCurso=c.ID
	group by dat.Apellidos, dat.Nombres, dat.Email
	having sum(cl.Duracion) >400

-- 30  Listado con nombre del curso y recaudaci�n total. La recaudaci�n total consiste en la sumatoria de costos de inscripci�n y de certificaci�n. Listarlos ordenados de mayor a menor por recaudaci�n.
	select c.Nombre, sum(ce.Costo+i.Costo) as 'Recaudaci�n total'
	from Cursos as c inner join Inscripciones as i on i.IDCurso=c.ID
	inner join Certificaciones as ce on ce.IDInscripcion=i.ID
	group by c.Nombre
	order by sum(ce.Costo+i.Costo) desc
