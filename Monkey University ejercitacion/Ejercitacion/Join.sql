Use MonkeyUniv
go
-- (1) Listado con nombre de usuario de todos los usuarios y sus respectivos nombres y apellidos.

select dat.Nombres, dat.Apellidos, u.NombreUsuario 
from Usuarios as u inner join Datos_Personales as dat
on u.ID = dat.ID

-- 2 Listado con apellidos, nombres, fecha de nacimiento y nombre del pa�s de nacimiento. 

select dat.Apellidos, dat.Nombres, dat.Nacimiento as FechaNacimiento, p.Nombre as Pais
from Datos_Personales as dat inner join Paises as p
on dat.IDPais = p.ID

-- (3) Listado con nombre de usuario, apellidos, nombres, email o celular de todos los usuarios que vivan en una domicilio cuyo nombre contenga el t�rmino 'Presidente' o 'General'. NOTA: Si no tiene email, obtener el celular.
select * from Datos_Personales where Nombres like '%Andres%'

select u.NombreUsuario, dat.Apellidos, dat.Nombres, isnull(dat.Email, dat.celular) as Contacto
from Usuarios as u inner join Datos_Personales as dat
on u.ID = dat.ID
where (dat.Domicilio like '%Presidente%') or (dat.Domicilio like '%General%')

-- 4 Listado con nombre de usuario, apellidos, nombres, email o celular o domicilio como 'Informaci�n de contacto'.  NOTA: Si no tiene email, obtener el celular y si no posee celular obtener el domicilio.

select u.NombreUsuario, dat.Apellidos, dat.Nombres, isnull(isnull(dat.Email, dat.Celular), dat.Domicilio) as Contacto
from Usuarios as u inner join Datos_Personales dat
on u.ID = dat.ID

-- (5) Listado con apellido y nombres, nombre del curso y costo de la inscripci�n de todos los usuarios inscriptos a cursos.  NOTA: No deben figurar los usuarios que no se inscribieron a ning�n curso.

select dat.Apellidos, dat.Nombres, c.Nombre, i.Costo
from Datos_Personales as dat inner join Usuarios as u on dat.ID = u.ID
inner join Inscripciones as i on i.IDUsuario = u.ID
inner join Cursos as c on c.ID = i.IDCurso

-- 6 Listado con nombre de curso, nombre de usuario y mail de todos los inscriptos a cursos que se hayan estrenado en el a�o 2020.

select c.Nombre, u.NombreUsuario, dat.Email
from Datos_Personales as dat inner join Usuarios as u on u.ID = dat.ID
inner join Inscripciones as i on i.IDUsuario = u.ID
inner join Cursos as c on c.ID = i.IDCurso
where year(c.Estreno) = 2020

-- 7 Listado con nombre de curso, nombre de usuario, apellidos y nombres, fecha de inscripci�n, costo de inscripci�n, fecha de pago e importe de pago. S�lo listar informaci�n de aquellos que hayan pagado.

select c.Nombre as NombreCurso, u.NombreUsuario, dat.Apellidos + ',' + dat.Nombres as NombreYApellido, i.Fecha as FechaInscripcion, i.Costo, p.Fecha as FechaPago, p.Importe as ImportePago
from Pagos as p inner join Inscripciones as i on i.ID = p.IDInscripcion
inner join Cursos as c on c.ID=i.IDCurso
inner join Usuarios as u on u.ID=i.IDUsuario
inner join Datos_Personales as dat on dat.ID=u.ID

-- 8 Listado con nombre y apellidos, genero, fecha de nacimiento, mail, nombre del curso y fecha de certificaci�n de todos aquellos usuarios que se hayan certificado.



-- 9 Listado de cursos con nombre, costo de cursado y certificaci�n, costo total (cursado + certificaci�n) con 10% de todos los cursos de nivel Principiante.

-- 10 Listado con nombre y apellido y mail de todos los instructores. Sin repetir.

-- 11 Listado con nombre y apellido de todos los usuarios que hayan cursado alg�n curso cuya categor�a sea 'Historia'.

-- (12) Listado con nombre de idioma, c�digo de curso y c�digo de tipo de idioma. Listar todos los idiomas indistintamente si no tiene cursos relacionados.


-- 13 Listado con nombre de idioma de todos los idiomas que no tienen cursos relacionados.

-- 14 Listado con nombres de idioma que figuren como audio de alg�n curso. Sin repeticiones.

-- (15) Listado con nombres y apellidos de todos los usuarios y el nombre del pa�s en el que nacieron. Listar todos los pa�ses indistintamente si no tiene usuarios relacionados.


-- 16 Listado con nombre de curso, fecha de estreno y nombres de usuario de todos los inscriptos. Listar todos los nombres de usuario indistintamente si no se inscribieron a ning�n curso.

-- 17 Listado con nombre de usuario, apellido, nombres, g�nero, fecha de nacimiento y mail de todos los usuarios que no cursaron ning�n curso.

-- 18 Listado con nombre y apellido, nombre del curso, puntaje otorgado y texto de la rese�a. S�lo de aquellos usuarios que hayan realizado una rese�a inapropiada.

-- 19 Listado con nombre del curso, costo de cursado, costo de certificaci�n, nombre del idioma y nombre del tipo de idioma de todos los cursos cuya fecha de estreno haya sido antes del a�o actual. Ordenado por nombre del curso y luego por nombre de tipo de idioma. Ambos ascendentemente.

-- 20 Listado con nombre del curso y todos los importes de los pagos relacionados.

-- 21 Listado con nombre de curso, costo de cursado y una leyenda que indique "Costoso" si el costo de cursado es mayor a $ 15000, "Accesible" si el costo de cursado est� entre $2500 y $15000, "Barato" si el costo est� entre $1 y $2499 y "Gratis" si el costo es $0.
