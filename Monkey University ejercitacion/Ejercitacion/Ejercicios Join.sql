Use MonkeyUniv
-- (1) Listado con nombre de usuario de todos los usuarios y sus respectivos nombres y apellidos.

select u.NombreUsuario, dat.Nombres, dat.Apellidos
from Usuarios as u inner join Datos_Personales as dat on u.ID = dat.ID

-- 2 Listado con apellidos, nombres, fecha de nacimiento y nombre del país de nacimiento. 

select dat.Apellidos, dat.Nombres, dat.Nacimiento, p.Nombre as PaisNacimiento
from Datos_Personales as dat inner join Paises as p on dat.IDPais = p.ID

-- (3) Listado con nombre de usuario, apellidos, nombres, email o celular de todos los usuarios que vivan en una domicilio cuyo nombre contenga el término 'Presidente' o 'General'. NOTA: Si no tiene email, obtener el celular.

select u.NombreUsuario, dat.Apellidos, dat.Nombres, isnull(dat.Email, dat.Celular) as Contacto, dat.Domicilio
from Usuarios as u inner join Datos_Personales as dat on u.ID=dat.ID
where (dat.Domicilio like '%Presidente%') or (dat.Domicilio like '%General%')


-- 4 Listado con nombre de usuario, apellidos, nombres, email o celular o domicilio como 'Información de contacto'.  NOTA: Si no tiene email, obtener el celular y si no posee celular obtener el domicilio.

select u.NombreUsuario, dat.Apellidos, dat.Nombres, isnull(isnull(dat.Email, dat.Celular), dat.Domicilio) as 'Información de contacto'
from Usuarios as u inner join Datos_Personales as dat on u.ID=dat.ID

-- (5) Listado con apellido y nombres, nombre del curso y costo de la inscripción de todos los usuarios inscriptos a cursos.  NOTA: No deben figurar los usuarios que no se inscribieron a ningún curso.

select dat.Apellidos + ',' + dat.Nombres as 'Apellido y Nombre', c.Nombre, i.Costo
from Usuarios as u inner join Datos_Personales as dat on u.ID = dat.ID
inner join Inscripciones as i on i.IDUsuario=u.ID
inner join Cursos as c on c.ID=i.IDCurso
order by 'Apellido y Nombre' asc

-- 6 Listado con nombre de curso, nombre de usuario y mail de todos los inscriptos a cursos que se hayan estrenado en el año 2020.

select c.Nombre, u.NombreUsuario, dat.Email
from Usuarios as u inner join Datos_Personales as dat on u.ID=dat.ID
inner join Inscripciones as i on i.IDUsuario=u.ID
inner join Cursos as c on c.ID=i.IDCurso 
where year(c.Estreno) = 2020

-- 7 Listado con nombre de curso, nombre de usuario, apellidos y nombres, fecha de inscripción, costo de inscripción, fecha de pago e importe de pago. Sólo listar información de aquellos que hayan pagado.

select c.Nombre as 'Nombre de Curso', u.NombreUsuario as 'Nombre de usuario', dat.Apellidos + ',' + dat.Nombres as 'Apellido y nombres', i.Fecha as 'Fecha de inscripción', i.Costo as 'Costo de inscripción', p.Fecha as 'Fecha de pago', p.Importe
from Usuarios as u inner join Datos_Personales as dat on u.ID=dat.ID
inner join Inscripciones as i on u.ID=i.IDUsuario
inner join Cursos as c on c.ID=i.IDCurso
inner join Pagos as p on p.IDInscripcion=i.ID


-- 8 Listado con nombre y apellidos, genero, fecha de nacimiento, mail, nombre del curso y fecha de certificación de todos aquellos usuarios que se hayan certificado.

select dat.Nombres + ',' + dat.Apellidos as 'Nombre y Apellido', dat.Genero, dat.Nacimiento, dat.Email, c.Nombre as 'Nombre del curso', ce.Fecha as 'Fecha certificación' 
from Certificaciones as ce inner join Inscripciones as i on i.ID=ce.IDInscripcion
inner join Cursos as c on c.ID=i.IDCurso
inner join Usuarios as u on u.ID=i.IDUsuario
inner join Datos_Personales as dat on dat.ID=u.ID
order by 'Nombre y Apellido' asc

-- 9 Listado de cursos con nombre, costo de cursado y certificación, costo total (cursado + certificación) con 10% de todos los cursos de nivel Principiante.

select top(10) percent c.Nombre, c.CostoCurso, c.CostoCertificacion, (c.CostoCurso + c.CostoCertificacion) *0.9 as 'Costo total'
from Cursos as c inner join Niveles as n on n.ID=c.IDNivel
where n.Nombre like '%Principiante%'

-- 10 Listado con nombre y apellido y mail de todos los instructores. Sin repetir.

select distinct d.Apellidos + ',' + d.Nombres as 'Apellido y Nombre', d.Email
from Instructores_x_Curso as ins inner join Usuarios as u on u.ID=ins.IDUsuario
inner join Datos_Personales as d on d.ID=u.ID

-- 11 Listado con nombre y apellido de todos los usuarios que hayan cursado algún curso cuya categoría sea 'Historia'.

select distinct dat.Nombres, dat.Apellidos, categ.Nombre
from Datos_Personales as dat inner join Usuarios as u on u.ID=dat.ID
inner join Inscripciones as i on i.IDUsuario=u.ID
inner join Cursos as c on c.ID=i.IDCurso
inner join Categorias_x_Curso as cat on cat.IDCurso=c.ID
inner join Categorias as categ on categ.ID=cat.IDCategoria
where categ.Nombre like '%Historia%'
order by dat.Apellidos

-- (12) Listado con nombre de idioma, código de curso y código de tipo de idioma. Listar todos los idiomas indistintamente si no tiene cursos relacionados.

select id.Nombre as 'Nombre Idioma', ixc.IDCurso as 'Codigo curso', ixc.IDTipo as 'Codigo tipo idioma'
from Idiomas as id left join Idiomas_x_Curso as ixc on id.ID=ixc.IDIdioma


-- 13 Listado con nombre de idioma de todos los idiomas que no tienen cursos relacionados.

select id.Nombre, ixc.IDCurso
from Idiomas as id left join Idiomas_x_Curso as ixc on ixc.IDIdioma=id.ID
where ixc.IDCurso is null

-- 14 Listado con nombres de idioma que figuren como audio de algún curso. Sin repeticiones.

select distinct id.Nombre
from Idiomas as id inner join Idiomas_x_Curso as ixc on id.ID=ixc.IDIdioma
inner join TiposIdioma as ti on ti.ID=ixc.IDTipo
where ti.Nombre like '%audio%'

-- (15) Listado con nombres y apellidos de todos los usuarios y el nombre del país en el que nacieron. Listar todos los países indistintamente si no tiene usuarios relacionados.

select dat.Nombres + dat.Apellidos as 'Nombre y apellido', p.Nombre
from Paises as p left join Datos_Personales as dat on p.ID=dat.IDPais

-- 16 Listado con nombre de curso, fecha de estreno y nombres de usuario de todos los inscriptos. Listar todos los nombres de usuario indistintamente si no se inscribieron a ningún curso.

select u.NombreUsuario, c.Nombre, c.Estreno
from Usuarios as u left join Inscripciones as i on i.IDUsuario=u.ID
left join Cursos as c on i.IDCurso=c.ID
order by u.NombreUsuario asc

-- 17 Listado con nombre de usuario, apellido, nombres, género, fecha de nacimiento y mail de todos los usuarios que no cursaron ningún curso.

select u.NombreUsuario, dat.Apellidos, dat.Nombres, dat.Genero, dat.Nacimiento, dat.Email
from Usuarios as u left join Inscripciones as i on u.ID=i.IDUsuario
left join Datos_Personales as dat on dat.ID=u.ID
where i.IDCurso is null
order by dat.Nombres

-- 18 Listado con nombre y apellido, nombre del curso, puntaje otorgado y texto de la reseña. Sólo de aquellos usuarios que hayan realizado una reseña inapropiada.

select dat.Nombres +' '+ dat.Apellidos as 'Nombre y Apellido', c.Nombre as 'Nombre del curso', r.Puntaje as 'Puntaje otorgado', r.Observaciones
from Datos_Personales as dat inner join Usuarios as u on u.ID=dat.ID
inner join Inscripciones as i on i.IDUsuario=u.ID
inner join Cursos as c on c.ID=i.IDCurso
inner join Reseñas as r on r.IDInscripcion=i.ID
where r.Inapropiada = 1

-- 19 Listado con nombre del curso, costo de cursado, costo de certificación, nombre del idioma y nombre del tipo de idioma de todos los cursos cuya fecha de estreno haya sido antes del año actual. Ordenado por nombre del curso y luego por nombre de tipo de idioma. Ambos ascendentemente.

select c.Nombre, c.CostoCurso, c.CostoCertificacion, id.Nombre, ti.Nombre 
from Cursos as c inner join Idiomas_x_Curso as ixc on ixc.IDCurso=c.ID
inner join TiposIdioma as ti on ti.ID=ixc.IDTipo
inner join Idiomas as id on id.ID=ixc.IDIdioma
where year(c.Estreno)< year(getdate())
order by c.Nombre asc, ti.Nombre asc

-- 20 Listado con nombre del curso y todos los importes de los pagos relacionados.

select c.Nombre, p.Importe
from Cursos as c inner join Inscripciones as i on i.IDCurso=c.ID
inner join Pagos as p on p.IDInscripcion=i.ID
order by c.Nombre asc, p.Importe asc

-- 21 Listado con nombre de curso, costo de cursado y una leyenda que indique "Costoso" si el costo de cursado es mayor a $ 15000, "Accesible" si el costo de cursado está entre $2500 y $15000, "Barato" si el costo está entre $1 y $2499 y "Gratis" si el costo es $0.

select Nombre, CostoCurso,
case when CostoCurso>15000 then 'Costoso'
when CostoCurso between 2500 and 15000 then 'Accesible'
when CostoCurso between 1 and 2499 then 'Barato'
else 'Gratis'
end as 'leyenda' 
from Cursos
order by 'leyenda' asc