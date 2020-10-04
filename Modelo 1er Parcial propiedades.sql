--Ejercicio 1:

--Rehacer usando group by

select ve.apellido, ve.nombre,
		(select count (*)
		from propiedades prop, tipos_propiedades tp
		where prop.IDtipo = tp.ID
		and ve.dni = prop.dni
		) as CantProp
from vecinos ve

--Ejercicio 2:

select *
from vecinos ve
where ve.dni not in
	(select distinct prop.dni
	from propiedades prop, tipo_propiedades tp
	where prop.idtipo = tp.id
	and tp.tipo like 'casa'
	and prop.superficie_construida > 80
	)

-- Ejercicio 3:

select ve.apellidos, ve.nombres,
	
	(select count (*)
	from propiedades prop
	where prop.dni=ve.dni
	and (prop.superficie_construida =0 or prop.superficie_construida is null)
	) as cantidadSinSuperficieConstr,
	
	(
	select count (*)
	from propiedades prop
	where prop.dni=ve.dni
	and (prop.superficie_construida > 0)
	) as cantidadConSuperficieConstr

from vecinos ve

-- Ejercicio 4:

--Rehacer usando gruop by y having

select *
from(
		select tp.tipo,
			(select avg(prop.valor)
			from propiedades prop 
			where prop.idtipo=tp.id
			) as valorPromedio
		from
		tipos_propiedades tp
	) as aux
where aux.valorPromedio > 900000

-- Ejercicio 5:

--Rehacer usando group by

select ve.apellidos + ',' + ve.nombres as Apenom,
		(select isnull(sum(prop.valor),0)
		from propiedades prop
		where ve.dni=prop.dni
		) as TotalAcumulado
from vecinos ve
