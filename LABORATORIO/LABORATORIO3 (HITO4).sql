--@accion es sumar: RETORNAR LA SUMA DE LOS 2 NUMEROS

--@accion es restar : RETORNAR LA RESTA DE LOS 2 NUMEROS

--@accion es Multiplicar: RETORNAR LA Multiplicacion DE LOS 2 NUMEROS

--@accion es Dividir: RETORNAR LA Division DE LOS 2 NUMEROS



-- Creamos la funcion

Create function operaciones_con_dos_numeros(@numero1 integer, @numero2 integer, @accion varchar(20))

returns integer as

begin

declare @resultado integer;

if (@accion = 'Sumar')

	set @resultado = @numero1 + @numero2; 

if (@accion = 'Restar')

	set @resultado = @numero1 - @numero2;

if (@accion = 'Multiplicar')

	set @resultado = @numero1 * @numero2;

if (@accion = 'Dividir') 

	set @resultado = @numero1/@numero2;

return (@resultado);  

end;



-- Consulta Realizada a la Funcion creada

select dbo.operaciones_con_dos_numeros(4,8,'Sumar') Suma;

select dbo.operaciones_con_dos_numeros(8,2,'Restar') Resta;

select dbo.operaciones_con_dos_numeros(3,5,'Multiplicar') Multiplicacion;

select dbo.operaciones_con_dos_numeros(10,2,'Dividir') Division;

---------------------------------------------------------------------------------------------------------------------------------------------
--segunda version de operaciones
Create function operaciones_v2(@numero1 integer, @numero2 integer, @accion varchar(20))

returns integer as

begin

	if (@accion = 'Sumar')

		return @numero1 + @numero2; 

	if (@accion = 'Restar')

		return @numero1 - @numero2;

	if (@accion = 'Multiplicar')

		return @numero1 * @numero2;

	if (@accion = 'Dividir') 

		return @numero1/@numero2;

return 1;  

end;

select dbo.operaciones_v2(4,8,'Sumar') Suma;

select dbo.operaciones_v2(8,2,'Restar') Resta;

select dbo.operaciones_v2(3,5,'Multiplicar') Multiplicacion;

select dbo.operaciones_v2(10,2,'Dividir') Division;

----------------------------------------------------------------------------------------------------------
--funciones de agregacion 

 create table escuela(
	id_esc int identity primary key not null,
	nombre varchar(50) not null,
	direccion varchar(30) not null,
	turno varchar(30)
);
INSERT INTO escuela(nombre, direccion, turno) values
 ('san simon','cochabamba','mañana'),
 ('andres bello','el alto','mañana-tarde'),
 ('amor de dios fe y alegria','el alto','mañana-tarde'),
 ('don bosco','la paz','mañana-tarde-noche');

 drop table escuela;
 select * from escuela;

 create table estudiantes(
	id_est int identity primary key not null,
	nombres varchar(20) not null,
	apellidos varchar (20) not null,
	edad int not null,
	fono int not null,
	email varchar(30)not null,
	direccion varchar(40) not null,
	genero varchar(20),
	licencia_conducir bit not null,
	id_esc int not null,
	foreign key (id_esc) references escuela(id_esc)
);
drop table estudiantes;

INSERT INTO estudiantes(nombres, apellidos, edad, fono, email, direccion, genero, licencia_conducir, id_esc) values
 ('Miguel' ,'Gonzales Veliz', 20, 2832115, 'miguel@gmail.com', 'Av. 6 de Agosto', 'masculino', 0, 1),
 ('Sandra' ,'Mavir Uria', 25, 2832116, 'sandra@gmail.com', 'Av. 6 de Agosto', 'femenino', 0, 2),
 ('Joel' ,'Adubiri Mondar', 30, 2832117, 'joel@gmail.com', 'Av. 6 de Agosto', 'masculino', 0, 3),
 ('Andrea' ,'Arias Ballesteros', 21, 2832118, 'andrea@gmail.com', 'Av. 6 de Agosto', 'femenino', 0, 4),
 ('Santos' ,'Montes Valenzuela', 24, 2832119, 'santos@gmail.com', 'Av. 6 de Agosto', 'masculino', 0, 1);

INSERT INTO estudiantes(nombres, apellidos, edad, fono, email, direccion, genero, licencia_conducir, id_esc)
values('pepito' ,'Gonzales Veliz', 20, 2832115, 'miguel@gmail.com', 'Av. 6 de Agosto', 'masculino', 1, 1);

INSERT INTO estudiantes(nombres, apellidos, edad, fono, email, direccion, genero, licencia_conducir, id_esc)
values('ana' ,'Gonzales Veliz', 20, 2832115, 'miguel@gmail.com', 'Av. 6 de Agosto', 'masculino', 0, 3);

select* from estudiantes;
------------------------------------------------------------------------------
--cunatos estudiantes son mayores a 25 años
select count(id_est) as[estudiantes] 
from estudiantes
where edad > 25;

--CREAR UNA FUNCION QUE ME PERMITA SABER LA CANTIDAD DE ESTUDIANTES MAYORES A 25 AÑOS O A CIERTA EDAD.
CREATE FUNCTION mayores_a_cierta_edad(@edad int)
	returns int as
	begin
		declare @response int = 0;

		select @response = count(est.id_est)
		from estudiantes as est
		where est.edad > @edad;
		return 1; 
	end;
select dbo.mayores_a_cierta_edad(25);
--------------------------------------------------------------------------------------------------------------------------------
--cantidades del sexo femenino mayores a 20 del colegio andres bello

select count(est.id_est)
from estudiantes as est
inner join escuela as esc on est.id_esc = esc.id_esc
where est.edad > 20
and est.genero = 'femenino'
and esc.nombre = 'andres bello'

CREATE FUNCTION estudiantesv(@edad int, @genero varchar(20), @escuela varchar(20))
	returns int as
	begin
		declare @response int;

		select @response = count(est.id_est)
		from estudiantes as est
		inner join escuela as esc on esc.id_esc = est.id_esc
		where est.edad > @edad
		and est.genero = @genero
		and esc.nombre = @escuela
		
		return @response; 
	end;
select dbo.estudiantesv(20, 'femenino', 'andres bello');
----------------------------------------------------------------------------------------------------------------------------------------------
--mostrar el ultimo
select max(id_est)
from estudiantes as est

select est.*
from estudiantes as est
where est.id_est = dbo.estudiantesnum();

CREATE FUNCTION estudiantesnum()
	returns int as
	begin
		declare @response int = 0;

		select @response = max(est.id_est)
		from estudiantes as est
		return @response; 
	end;
select dbo.estudiantesnum();

drop function estudiantesnum;

—-----------------------------------------------------------------------------------------


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
