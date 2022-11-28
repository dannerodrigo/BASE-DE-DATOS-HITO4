CREATE DATABASE UNIFRANZITOS;
USE UNIFRANZITOS;

CREATE TABLE campeonato(
	id_campeonato varchar(25) primary key not null,
	nombre_campeonato varchar(25) not null,
	sede varchar(25) not null
);
insert into campeonato(id_campeonato, nombre_campeonato, sede) values
('camp-111','campeonato unifranz','El Alto'),
('camp-222','campeonato unifranz','<Cochabamba');

CREATE TABLE equipo(
	id_equipo varchar(10) primary key not null,
	nombre_equipo varchar(20) not null,
	categoria varchar(10) not null,
	id_campeonato varchar(10) not null
);

insert into equipo(id_equipo, nombre_equipo, categoria, id_campeonato) values
('equ-111','google','varones','camp-111'),
('equ-222','484 not null','varones','camp-111'),
('equ-333','girls unifranz','mejeres','camp-111');

CREATE TABLE jugador(
	id_jugador varchar(10) primary key not null,
	nombres varchar(10) not null,
	apellidos varchar(10) not null,
	ci varchar(15)not null,
	edad int not null,
	id_equipo varchar(10)not null
);

insert into jugador(id_jugador, nombres, apellidos, ci, edad, id_equipo) values
('jug-111','Carlos','Villa','8997811LP',19,'equ-222'),
('jug-222','Pedro','Salas','8997822LP',20,'equ-222'),
('jug-333','Saul','Araj','8997833LP',21,'equ-222'),
('jug-444','Sandra','Solis','8997844LP',20,'equ-333'),
('jug-555','Ana','Mica','8997855LP',23,'equ-333');

SELECT * FROM campeonato;
SELECT * FROM equipo;
SELECT * FROM jugador;

-- DETERMINAR CUANTOS JUGADORES ESTAN INSCRITOS CAMPEONATO UNIFRANZ
SELECT COUNT(jug.nombres) as jugadores
from jugador as jug
	INNER JOIN equipo as eq on eq.id_equipo = jug.id_equipo
	INNER JOIN campeonato as ca on ca.id_campeonato = eq.id_campeonato
where ca.id_campeonato = 'camp-111';

CREATE FUNCTION  F1_CantidadJugadores(@jugadores varchar(20))
	returns int as
	begin
		declare @respuesta int
		select @respuesta = count(jug.nombres)
		from jugador as jug
		INNER JOIN equipo as eq on eq.id_equipo = jug.id_equipo
		INNER JOIN campeonato as ca on ca.id_campeonato = eq.id_campeonato
		where ca.id_campeonato = @jugadores
		return @respuesta;
	end;

	select dbo.F1_CantidadJugadores('camp-111') as DBA;

--CREAR UNA FUNCION QUE NOS PERMITA CONTAR CUANTOS JUGADORES ESTAN INSCRITOS EN LA CATEGORIA MUJERES O VARONES

CREATE FUNCTION  F2_CantidadJugadoresParam(@jugadores varchar(20))
	returns int as
	begin
		declare @respuesta int
		select @respuesta = count(jug.nombres)
		from jugador as jug
		INNER JOIN equipo as eq on eq.id_equipo = jug.id_equipo
		where eq.categoria = @jugadores
		return @respuesta;
	end;

	select dbo.F2_CantidadJugadoresParam('varones') as DBA;
drop function F2_CantidadJugadoresParam;

SELECT COUNT(jug.nombres) as jugadores
from jugador as jug
	INNER JOIN equipo as eq on eq.id_equipo = jug.id_equipo
where eq.categoria = 'varones';

--Crear una función que obtenga el promedio de las edades mayores a una cierta edad.

SELECT COUNT(jug.nombres) as jugadores
from jugador as jug
	INNER JOIN equipo as eq on eq.id_equipo = jug.id_equipo
where eq.categoria = 'mejeres'
and jug.edad > 15;

CREATE FUNCTION  F3_PromedioEdades(@jugadores varchar(20), @edad integer)
	returns int as
	begin
		declare @respuesta int
		select @respuesta = count(jug.nombres)
		from jugador as jug
		INNER JOIN equipo as eq on eq.id_equipo = jug.id_equipo
		where eq.categoria = @jugadores
		and jug.edad > @edad
		return @respuesta;
	end;

	select dbo.F3_PromedioEdades('mejeres', 15) as DBA;

--Crear una función que permita concatenar 3 parámetros.

CREATE FUNCTION  F4_ConcatItems(@edad int, @nombre_eq varchar(20), @sede varchar(10))

	returns varchar(100) as
	begin
		declare @respuesta varchar (20)
		select @respuesta = concat(jug.edad, eq.nombre_equipo, ca.sede)
		from jugador as jug
		INNER JOIN equipo as eq on eq.id_equipo = jug.id_equipo
		INNER JOIN campeonato as ca on ca.id_campeonato = eq.id_campeonato
		where eq.nombre_equipo = @nombre_eq
		and jug.edad > @edad
		and ca.sede = @sede
		return @respuesta;
	end;

	select dbo.F4_ConcatItems(15, 'girls unifranz', 'El Alto') as DBA;

-- Generar la serie fibonacci.	

declare @n1 int = 0, @n2 int = 1,@n3 int, @con int = 0
print 0
print 1
while(@con < 6)
begin
	set @n3 =  @n1 + @n2
	print @n3
	set @n1 = @n2
	set @n2 = @n3
set @con = @con + 1
end



CREATE FUNCTION  fibonnaci(@n int)

	returns int as
	begin
		declare @n1 int = 0, @n2 int = 1,@n3 int, @con int = 0
		print 0
		print 1
		while(@con < @n)
			begin
				set @n3 =  @n1 + @n2
				print @n3
				set @n1 = @n2
				set @n2 = @n3
			set @con = @con + 1
			end
		return @n3
	end;

	select dbo.fibonnaci(5) as DBA;
	drop function fibonnaci;
