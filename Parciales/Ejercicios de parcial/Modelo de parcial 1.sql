use database MODELOPARCIAL2_PUNTO2

-- Ejercicio 1

select top 1 with ties pa.apellido, pa.nombre, e.especie, pe.peso
from PARTICIPANTES pa, ESPECIES e, PESCA pe
where pa.IDPARTICIPANTE=pe.IDPARTICIPANTE and pe.IDESPECIE = e.IDESPECIE
order by pe.PESO desc


-- Ejercicio 2
select pa.apellido, pa.NOMBRE
from PARTICIPANTES pa
where pa.IDPARTICIPANTE not in 
(select pe.IDPARTICIPANTE
from PESCA pe, ESPECIES e
where e.IDESPECIE=pe.IDESPECIE
and e.ESPECIE like '%bagre%')

-- Ejercicio 3
select *
from(
	select pa.nombre, pa.apellido,
		(select avg(pe.peso)
		from PESCA pe
		where pe.IDESPECIE is not null and pe.IDPARTICIPANTE=pa.IDPARTICIPANTE) as pesoPromedio
	from  PARTICIPANTES pa
	) as aux
where aux.pesoPromedio>30

-- de Chivi
select distinct  par.nombre, par.apellido, avg(p.peso) as prom
from PARTICIPANTES as par
join PESCA as p on par.IDPARTICIPANTE = p.IDPARTICIPANTE
where p.IDESPECIE is not null
group by par.nombre, par.apellido
having avg(p.peso) >30

-- de Cristian
Select PAR.APELLIDO, PAR.NOMBRE, avg(P.PESO) 'Promedio kgs'
From PARTICIPANTES PAR
Inner Join PESCA P on PAR.IDPARTICIPANTE = P.IDPARTICIPANTE
where p.IDESPECIE is not null
Group by PAR.APELLIDO, PAR.NOMBRE
Having avg(P.PESO) > 30
Order by 1

-- Ejercicio 4
select es.especie,
	(select count(*)
	from PESCA pe
	where (datepart(hour, pe.FECHA_HORA) >= 21 or datepart(hour, pe.FECHA_HORA) <=5)
	and pe.IDESPECIE=es.IDESPECIE
	) as cantPescada
from ESPECIES es


-- Ejercicio 5

select par.APELLIDO, par.NOMBRE,
	(select count (*) 
	from PESCA pe
	where pe.IDESPECIE is not null
	and pe.IDPARTICIPANTE=par.IDPARTICIPANTE
	) as cantidadDescartados,
	(select count (*) 
	from PESCA pe
	where pe.IDESPECIE is null
	and pe.IDPARTICIPANTE=par.IDPARTICIPANTE
	) as cantidadNoDescartados
from PARTICIPANTES par

-- Ejercicio 6
--  apellido y nombre y nombre de la especie de cada pez q haya capturado
-- el pescador. si algun epecie de pez no ha sido pescado entonces debera aparecer en el lista
-- pero  sin datos del pescador.
-- listado ordenado por nombre de especie de manere creciendo
-- la combinacion apellido, nombre y nombre de la especie debe aparecer
--solo una vez en el listado

--Así lo hizo Chivi:

select distinct par.apellido + ', ' + par.nombre as Apellido_Nombre, e.especie
from PARTICIPANTES as par
 join PESCA as p on par.IDPARTICIPANTE = p.IDPARTICIPANTE
right join ESPECIES as e on e.IDESPECIE = p.IDESPECIE
order by e.ESPECIE asc

--Mi resolución:

select distinct es.ESPECIE, isnull(par.APELLIDO,''), isnull(par.NOMBRE,'') 
from PARTICIPANTES par 
inner join PESCA pe on par.IDPARTICIPANTE=pe.IDPARTICIPANTE
right join ESPECIES es on es.IDESPECIE=pe.IDESPECIE
order by es.ESPECIE asc

-- Resolución de Chris:

Select distinct isnull(PAR.Apellido, '-') 'Apellido', isnull(PAR.Nombre, '-') 'Nombre', E.Especie
From PARTICIPANTES PAR
Right Join PESCA P on PAR.IDPARTICIPANTE = P.IDPARTICIPANTE
Right Join ESPECIES E on P.IDESPECIE = E.IDESPECIE
Order by E.ESPECIE asc

-- De las personas de mas de 40 años, 
-- el nombre, cantidad de peces pescados de cada especie
-- sin tener en cuenta los peces de menos de 5 kg, y la cantidad de peces descartados


		select par.NOMBRE as nombre, count(*) as cantidadPescada, es.ESPECIE
		from PARTICIPANTES par inner join PESCA pe
		on par.IDPARTICIPANTE=pe.IDPARTICIPANTE
		left join ESPECIES es on es.IDESPECIE=pe.IDESPECIE
		where year(getdate())-year(par.FECHA_NACIMIENTO)>39 and pe.PESO>5
		group by par.NOMBRE, es.ESPECIE
		order by par.NOMBRE asc

		select part.NOMBRE, count(*) as pecesDescartados, 'Descartados'
		from PESCA pe, PARTICIPANTES part
		where pe.IDESPECIE is null
		and pe.IDPARTICIPANTE=part.IDPARTICIPANTE
		group by part.NOMBRE

select *
from PARTICIPANTES par inner join PESCA pe
on par.IDPARTICIPANTE=pe.IDPARTICIPANTE
inner join ESPECIES es on es.IDESPECIE=pe.IDESPECIE