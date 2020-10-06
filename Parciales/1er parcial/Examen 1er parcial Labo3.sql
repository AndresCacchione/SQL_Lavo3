use PARCIAL1
-- Apellido y nombres de los pacientes cuyo 
-- promedio de duraci�n de turnos 
-- de 'Cardiologia' sea mayor a 70 minutos.

select p.apellido, p.nombre
from PACIENTES p inner join TURNOS t
on t.IDPACIENTE=p.IDPACIENTE
inner join MEDICOS m
on m.IDMEDICO=t.IDMEDICO inner join
ESPECIALIDADES esp 
on esp.IDESPECIALIDAD=m.IDESPECIALIDAD
where esp.NOMBRE like '%Cardiologia%'
group by p.APELLIDO, p.NOMBRE
having avg(t.DURACION) > 70

-- Los apellidos y nombres de los m�dicos (sin repetir) 
-- que hayan demorado en alguno de sus turnos menos 
-- de la duraci�n promedio de turnos.

select distinct m.apellido, m.nombre
from MEDICOS m
where (select avg(duracion) from TURNOS) >any
	(select t.DURACION
	from TURNOS t
	where t.IDMEDICO=m.IDMEDICO)

-- Por cada obra social, la cantidad de pacientes
-- de g�nero masculino y la cantidad de pacientes 
-- de g�nero femenino.

select o.nombre, 
	(select count (*)
	from PACIENTES p
	where p.IDOBRASOCIAL=o.IDOBRASOCIAL
	and p.SEXO like 'M'
	) as PacientesMasculinos,

	(select count (*)
	from PACIENTES p
	where p.IDOBRASOCIAL=o.IDOBRASOCIAL
	and p.SEXO like 'F'
	) as PacientesFemeninos
from OBRAS_SOCIALES o

-- Los pacientes que se hayan atendido 
-- m�s veces en el a�o 2000 que en el a�o 2001 
-- y a su vez m�s veces en el a�o 2001 que en a�o 2002.

select aux.Apenom
from
	(
		select p.apellido + ',' + p.nombre as Apenom,
			(select count(*)
			from TURNOS t
			where t.IDPACIENTE=p.IDPACIENTE
			and datepart(year,t.FECHAHORA)=2000
			) as atenciones2000,

			(select count(*)
			from TURNOS t
			where t.IDPACIENTE=p.IDPACIENTE
			and datepart(year,t.FECHAHORA)=2001
			) as atenciones2001,

			(select count(*)
			from TURNOS t
			where t.IDPACIENTE=p.IDPACIENTE
			and datepart(year,t.FECHAHORA)=2002
			) as atenciones2002
		from PACIENTES p
	) as aux
where aux.atenciones2000>aux.atenciones2001
and aux.atenciones2001>aux.atenciones2002






---------- Ayuda a un compa�ero-------
--4 La cantidad de pacientes que se hayan atendido m�s del doble de veces en turnos 
-- del primer semestre que en turnos del segundo semestre. Indistantemente del a�o.


select aux.Apenom
from
	(
		select p.apellido + ',' + p.nombre as Apenom,
			(select count(*)
			from TURNOS t
			where t.IDPACIENTE=p.IDPACIENTE
			and datepart(MONTH,t.FECHAHORA)<=6
			) as atenciones1,

			(select count(*)
			from TURNOS t
			where t.IDPACIENTE=p.IDPACIENTE
			and datepart(MONTH,t.FECHAHORA) > 6
			) as atenciones2
		from PACIENTES p
	) as aux
where aux.atenciones1 > (aux.atenciones2*2)
