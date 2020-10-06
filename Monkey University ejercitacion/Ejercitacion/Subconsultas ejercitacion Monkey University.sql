use MonkeyUniv
-- 1  Listado con apellidos y nombres de los usuarios que no se hayan inscripto a cursos durante el año 2019.

select dat.Nombres, dat.Apellidos from Datos_Personales as dat
where dat.ID not in (select distinct i.IDUsuario from Inscripciones as i where year(i.Fecha) = 2019)

-- 2  Listado con apellidos y nombres de los usuarios que se hayan inscripto a cursos pero no hayan realizado ningún pago.

select distinct dat.Nombres, dat.apellidos
from Datos_Personales as dat inner join
Inscripciones as i on i.IDUsuario=dat.ID
where i.idUsuario not in 
	(select distinct i.IDUsuario 
	from inscripciones as i inner join
	Pagos as p on p.idinscripcion=i.id)


Select distinct dat.Apellidos, dat.Nombres 
From Datos_Personales as DAT, Inscripciones as i
Where i.IDUsuario = dat.ID  
and i.ID  not in (Select distinct p.IDInscripcion From Pagos p)


-- 3  Listado de países que no tengan usuarios relacionados.

select p.Nombre from Paises as p
where p.ID not in (select dat.idpais from Datos_Personales dat)

-- 4  Listado de clases cuya duración sea mayor a la duración promedio.

select nombre, Duracion
from Clases as c
where c.Duracion > (select avg(Duracion) from Clases)

-- 5 Listado de contenidos cuyo tamaño sea mayor al tamaño de todos los contenidos de tipo 'Audio de alta calidad'.
	
select * from Contenidos as c
where c.Tamaño > (select max(c2.Tamaño) from Contenidos as c2
					inner join TiposContenido as t on t.ID=c2.IDTipo 
					where t.Nombre like '%Audio de alta calidad%'
					)

select * from Contenidos as c
where c.Tamaño >all (select c2.Tamaño from Contenidos as c2
					inner join TiposContenido as t on t.ID=c2.IDTipo 
					where t.Nombre like '%Audio de alta calidad%'
					)

-- 6  Listado de contenidos cuyo tamaño sea menor al tamaño de algún contenido de tipo 'Audio de alta calidad'.

select * from Contenidos as c
where c.Tamaño < (select max(c.Tamaño) from Contenidos as c
				inner join TiposContenido as t on t.ID=c.IDTipo
				where t.Nombre like '%Audio de alta calidad')

select * from Contenidos as c
where c.Tamaño <any (select c.Tamaño from Contenidos as c
				inner join TiposContenido as t on t.ID=c.IDTipo
				where t.Nombre like '%Audio de alta calidad')

-- 7  Listado con nombre de país y la cantidad de usuarios de género masculino y la cantidad de usuarios de género femenino que haya registrado.

select p.nombre, 
				(select count(*) from Datos_Personales dat where dat.Genero = 'M' and p.ID=dat.IDPais) as Masculino, 
				(select count(*) from Datos_Personales dat where dat.Genero = 'F' and p.ID=dat.IDPais) as Femenino 
from Paises p

-- 8  Listado con apellidos y nombres de los usuarios y la cantidad de inscripciones realizadas en el 2019 y la cantidad de inscripciones realizadas en el 2020.

select dat.apellidos, dat.nombres,
	(select count(*) from Inscripciones as i where year(i.Fecha)=2019 and i.IDUsuario = dat.ID) as 'Inscripciones 2019',
	(select count(*) from Inscripciones as i where YEAR(i.fecha)=2020 and i.IDUsuario = dat.ID) as 'Inscripciones 2020'
from Datos_Personales dat

-- 9  Listado con nombres de los cursos y la cantidad de idiomas de cada tipo. Es decir, la cantidad de idiomas de audio, la cantidad de subtítulos y la cantidad de texto de video.
	
	select c.nombre,
					(select count(*) from Idiomas_x_Curso IxC, TiposIdioma ti 
					where IxC.IDCurso=c.ID and IxC.IDTipo = ti.ID 
					and ti.Nombre like '%Audio%') 
					as 'Cantidad Audios',

					(select count(*) from Idiomas_x_Curso IxC, TiposIdioma ti
					where IxC.IDCurso=c.ID and IxC.IDTipo=ti.ID 
					and ti.Nombre like '%Subtítulo%') 
					as 'Cantidad Subtítulo',
					
					(select count(*) from Idiomas_x_Curso IxC, TiposIdioma ti
					where IxC.IDCurso=c.ID and IxC.IDTipo=ti.ID 
					and ti.Nombre like '%Texto del video%') 
					as 'Cantidad Texto del Video'
	from Cursos as c


-- 10  Listado con apellidos y nombres de los usuarios, nombre de usuario y cantidad de cursos de nivel 'Principiante' que realizó y cantidad de cursos de nivel 'Avanzado' que realizó.
	
	select dat.apellidos, dat.nombres, u.nombreUsuario,
					(select count(*)
					from (select distinct c.ID, c.IDNivel, i.IDUsuario
								from Cursos c, Inscripciones i, Niveles n
								where c.ID=i.IDCurso and n.ID=c.IDNivel 
								and i.IDUsuario=dat.ID) as Cursos_dist, 
					Niveles n
					where n.ID=Cursos_dist.IDNivel and n.Nombre like '%Principiante%'
					)as 'Cantidad Principiante',
													
					(select count(*)
					from (select distinct c.ID, c.IDNivel, i.IDUsuario
								from Cursos c, Inscripciones i, Niveles n
								where c.ID=i.IDCurso and n.ID=c.IDNivel
								and i.IDUsuario=dat.ID) as Cursos_dist_avanzados,
					Niveles n
					where n.ID=Cursos_dist_avanzados.IDNivel and n.Nombre like '%Avanzado%'
					)as 'Cantidad Avanzado'
	from Datos_Personales dat, Usuarios u
	where dat.ID=u.ID

-- 11  Listado con nombre de los cursos y la recaudación de inscripciones de usuarios de género femenino que se inscribieron y la recaudación de inscripciones de usuarios de género masculino.

select c.nombre as NombreCurso, 
								(select isnull(sum(i.costo),0) 
								from Inscripciones i, Datos_Personales dat
								where dat.ID=i.IDUsuario and dat.Genero like 'F' 
								and I.IDUsuario=c.ID
								) as 'Recaudación Mujeres', 
								
								(select isnull(sum(i.costo),0)
								from Inscripciones i, Datos_Personales dat
								where i.IDUsuario=dat.ID and dat.Genero like 'M' 
								and I.IDUsuario=c.ID
								) as 'Recaudación Varones'
from Cursos c


-- 12  Listado con nombre de país de aquellos que hayan registrado más usuarios de género masculino que de género femenino.

select aux.Pais
from
	(
		select p.nombre as Pais,
			(select count(*) from Datos_Personales dat where p.ID=dat.IDPais and dat.Genero like '%m%') as UsuariosMasculinos,
			(select count (*) from Datos_Personales dat where p.ID=dat.IDPais and dat.Genero like '%f%') as UsuariosFemeninos
		from Paises p
	) as aux
where aux.UsuariosMasculinos > aux.UsuariosFemeninos

-- 13  Listado con nombre de país de aquellos que hayan registrado más usuarios de género masculino que de género femenino pero que haya registrado al menos un usuario de género femenino.

select aux.Nombre
from (select p.nombre,
		(select COUNT(*) from Datos_Personales dat where dat.IDPais = p.ID and dat.Genero like 'F') as cantMujeres, 
		(select count(*) from Datos_Personales dat where dat.IDPais = p.ID and dat.Genero like 'M') as cantVarones
	from paises p) as aux
where aux.cantMujeres < aux.cantVarones and aux.cantMujeres>0

-- 14  Listado de cursos que hayan registrado la misma 
-- cantidad de idiomas de audio que de subtítulos.

select tablaAux.Nombre
from (
		select c.nombre,
			(select count(*) 
			from Idiomas_x_Curso ixc, TiposIdioma ti 
			where ixc.IDTipo = ti.ID and c.ID = ixc.IDCurso 
			and ti.Nombre like '%audio%'
			) as CantAudio,
		
			(select count(*) 
			from Idiomas_x_Curso ixc, TiposIdioma ti
			where ixc.IDTipo=ti.ID and c.ID=ixc.IDCurso
			and ti.Nombre like '%subtítulo%') as CantSubtitulo
		from Cursos as c
	) as tablaAux
where tablaAux.CantAudio=tablaAux.CantSubtitulo

-- 15  Listado de usuarios que hayan realizado más cursos en el año 2018 que en el 2019 y a su vez más cursos en el año 2019 que en el 2020.
select tablaAuxiliar.NomApe
from (
	select dat.nombres + ',' + dat.apellidos as NomApe,
	
		(select distinct count(i.IDCurso)
		from Inscripciones i
		where i.IDUsuario=dat.ID and year(i.Fecha) = 2018
		) as cursos2018,

		(select distinct count(i.IDCurso)
		from Inscripciones i
		where i.IDUsuario=dat.ID and year(i.fecha) = 2019
		) as cursos2019,
	
		(select distinct count(i.IDCurso)
		from Inscripciones i
		where i.IDUsuario=dat.ID and year(i.Fecha) = 2020
		) as cursos2020

	from Datos_Personales dat
	) as tablaAuxiliar
where tablaAuxiliar.cursos2018 > tablaAuxiliar.cursos2019
and tablaAuxiliar.cursos2019 > tablaAuxiliar.cursos2020

-- 16 Listado de apellido y nombres de usuarios que hayan realizado cursos pero nunca se hayan certificado.

--- Resolución luego de entender bien el enunciado: ---
select tablaAux.Apenom
from
	(select dat.apellidos + ' , ' + dat.nombres as Apenom,
			(select count(*) 
			from Inscripciones i
			where i.IDUsuario=dat.ID
			) as cantidadCursos,

			(select count(*)
			from Inscripciones i, Certificaciones cer
			where cer.IDInscripcion=i.ID and i.IDUsuario=dat.ID
			) as Certificaciones
	from Datos_Personales dat
	) as tablaAux
where tablaAux.cantidadCursos>0 and tablaAux.Certificaciones=0


--- Mal resuleto por mi ---
select distinct aux.apeNom
from(
		select i.ID idi, dat.ID, dat.apellidos + ' , ' + dat.nombres as apeNom
		from Datos_Personales dat, Inscripciones i
		where i.IDUsuario=dat.ID and i.ID not in
				(select IDInscripcion from Certificaciones)
	) as aux