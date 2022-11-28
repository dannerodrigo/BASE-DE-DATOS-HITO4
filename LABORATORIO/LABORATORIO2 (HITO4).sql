CREATE DATABASE LAB2;
 USE LAB2;
------------------------------------------------------------------
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
-----------------------------------------------------------------
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

-----------------------------------------------------------------------------------------------------------------------
--determinar cuantos estudianates tienes licencia de conducir 

select count(licencia_conducir) as[estudiantes con licencia] 
from estudiantes
where licencia_conducir = 1;
------------------------------------------------------------------
--cuntos estudiantes menores a 20 no tienen licencia

select count(licencia_conducir) as[estudiantes] 
from estudiantes
where licencia_conducir = 0
and edad < 20 ;
-------------------------------------------------------------------
-- estudiantes son del a escuela 
select count(nombres) as[estudiantes] 
from escuela as esc
inner join estudiantes as est on est.id_esc = esc.id_esc
where esc.nombre = 'amor de dios fe y alegria'
------------------------------------------------------------------
--estudiantes froman parte de las escuelas tienes los 2 horarios
select count(turno) as[estudiantes] 
from escuela as esc
inner join estudiantes as est on est.id_esc = esc.id_esc
where turno = 'mañana-tarde';
---------------------------------------------------------------------------
--estudiantes mayores a 25 estan en escuelas que esten en el turno trade
select count(turno) as[estudiantes] 
from escuela as esc
inner join estudiantes as est on est.id_esc = esc.id_esc
where esc.turno like'%tarde'
and est.edad < 25;



--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- como crear nuestras propias funciones

create function retorna_nombre_materia() --creamos la funcion
	RETURNS VARCHAR (20) AS 
	BEGIN
		RETURN 'BASE DE DATOS I'
	END;

SELECT dbo.retorna_nombre_materia() as DBA;


-- como declarar variables ---------------------------------------------------------------------------------------------
create function retorna_nombre_materia_v2()

	returns varchar(20) as 
	begin
		declare @nombre varchar(25);     --declaramos una ueva variable
		set @nombre = 'base de datos 1'; -- le damos un valor a la variable
		return @nombre;
	end

SELECT dbo.retorna_nombre_materia_v2() as DBA;


-- como alterar funciones----------------------------------------------------------------------------------------------
alter function retorna_nombre_materia_v2()

	returns varchar(20) as 
	begin
		declare @nombre varchar(25);     --declaramos una ueva variable
		set @nombre = 'base de datos 2'; -- le damos un valor a la variable
		return @nombre;
	end;

SELECT dbo.retorna_nombre_materia_v2() as DBA;


--como se reciben paramatros en una funcion-------------------------------------------------------------------------------------------
create function retorna_nombre_materia_v3(@nombreMateria varchar(25)) --entre parentecis esta el nombre de la variable recibida

	returns varchar(25) as 
	begin
		declare @nombre varchar(25);
		set @nombre = @nombreMateria;
		return @nombre;
	end;

SELECT dbo.retorna_nombre_materia_v3('base_de_datos') as DBA; --le enviamos los nuevos parametros

--ejersicios

--crear una funcion que no recive parametros debe sumar dos numeros---------------------------------------------------------------

create function suma()

	returns varchar(20) as 
	begin
		declare @n1 int;
		declare @n2 int;  --declaramos una ueva variable
		set @n1 = 11;
		set @n2 = 11;-- le damos un valor a la variable
		return @n1 + @n2;
	end

SELECT dbo.suma() as DBA;

--sumar tres numeros------------------------------------------------------------------------------------------------------
create function suma_de_parmetros(@p1 int, @p2 int, @p3 int)

	returns int as
	begin
		declare @res int;
		set @res = @p1 + @p2 + @p3;
		return @res
	end;

SELECT dbo.suma_de_parmetros(1, 3, 4) as DBA;

drop function suma_de_parmetros;

-- si me llega restar se resta pero si me llega sumar se su
