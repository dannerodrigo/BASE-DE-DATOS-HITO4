CREATE DATABASE defensa_hito4;

USE defensa_hito4;

CREATE TABLE campeonato(
	id_campeonato varchar(25) primary key not null,
	nombre_campeonato varchar(25) not null,
	serie varchar(25) not null
);
insert into campeonato(id_campeonato, nombre_campeonato, serie) values
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

drop table jugador;
drop table equipo;
drop table campeonato;

----------------------------------------------------------------------------------------------------------------------------------------
--mostrar todos los jugadores de la categoria mujeres que juegan en el campeonato unifranz en la sede de el alto

SELECT jug.nombres, jug.apellidos, eq.categoria, ca.nombre_campeonato, ca.serie
FROM jugador AS jug
	INNER JOIN equipo AS eq ON eq.id_equipo = jug.id_equipo
	INNER JOIN campeonato AS ca ON ca.id_campeonato = eq.id_campeonato
WHERE ca.serie = 'El Alto'
and eq.categoria = 'mejeres'
and ca.nombre_campeonato = 'campeonato unifranz';

----------------------------------------------------------------------------------------------------------------------------------------
--determinar cuantos jugadores estan inscritos en el equipo Google
SELECT count(jug.nombres) as jugadores
FROM jugador AS jug
	INNER JOIN equipo AS eq ON eq.id_equipo = jug.id_equipo
WHERE eq.nombre_equipo = 'google'
and eq.categoria = 'varones'
and jug.apellidos like 'M%';

-----------------------------------------------------------------------------------------------------------------------------------------
--
alter function type_client(@num integer)

	returns varchar(100) as
	begin
		declare @credit_number VARCHAR(20);
		if (@num > 50000)
		set @credit_number = 'PLATINIUM'
		if (@num >= 10000 and @num <= 50000)
		set @credit_number = 'GOLD'
		if (@num < 10000)
		set @credit_number = 'SILVER';
		return @credit_number;
	end;

select dbo.type_client(51000) as DBA;
select dbo.type_client(30000) as DBA;
select dbo.type_client(5000) as DBA;
select dbo.type_client(10000) as DBA;

drop function type_client;
------------------------------------------------------------------------------------------------------------------------------------------
create function contar_jug(@sede integer)

	returns int as
	begin
		returns jugado
		SELECT count(jug.id_jugador)
		FROM jugador AS jug
		INNER JOIN equipo AS eq ON eq.id_equipo = jug.id_equipo
		INNER JOIN campeonato AS ca ON ca.id_campeonato = eq.id_campeonato
		where jug.apellidos like 'M%'
		and jug.nombres like 'S%'
		return ;
	end;

select dbo.contar_jug('El Alto') as DBA;
drop function contar_jug;

CREATE FUNCTION  F4_ConcatItems(@edad int, @nombre_eq varchar(20), @sede varchar(10))
	returns varchar(100) as
	begin
		declare @respuesta varchar(100)
		select @respuesta = concat(jug.edad, eq.nombre_equipo, ca.sede)
		from jugador as jug
		INNER JOIN equipo as eq on eq.id_equipo = jug.id_equipo
		INNER JOIN campeonato as ca on ca.id_campeonato = eq.id_campeonato
		where eq.nombre_equipo = @nombre_eq
		and jug.edad > @edad
		and ca.sede = @sede
		return @respuesta;
	end;

	select dbo.F4_ConcatItems(15, 'girls unifranz','El Alto') as DBA;
