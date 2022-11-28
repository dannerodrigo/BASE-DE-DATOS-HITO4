CREATE DATABASE [hito 4 funciones];
USE [hito 4 funciones];

-- MANEGO DE FUNCIONES
	-- una funcion de agragacion siempre se ejecuta en la clausula select
	-- ademas siempre retorna un unico valor (una fila)
	-- es aplicado a un grupo de registros (a una columna de la tabla)
	-- AVG usa para calcular el promedio de los valores
	-- COUNT se usa para devolber el numero de registros de la seleccion
	-- SUM se usa para devolber la suma de todos los valores
	-- MAX se usa para devolver el más alto de un campo especifico
	-- MIN se usa para devolver el más bajo de un campo especifico

create table estudiantes(
	id_est int identity primary key not null,
	nombres varchar(10) not null,
	apellidos varchar (20) not null,
	edad int not null,
	fono int not null,
	email varchar(20),
	direccion varchar(30) not null,
	genero varchar(10),
	id_esc int identity,
		foreign key references escuela(id_esc)
);

INSERT INTO estudiantes (nombres, apellidos, edad, fono, email, direccion, genero, licencia_conducir)
  VALUES ('Miguel' ,'Gonzales Veliz', 20, 2832115, 'miguel@gmail.com', 'Av. 6 de Agosto', 'masculino', 1);
INSERT INTO estudiantes (nombres, apellidos, edad, fono, email, direccion, genero, licencia_conducir)
  VALUES ('Sandra' ,'Mavir Uria', 25, 2832116, 'sandra@gmail.com', 'Av. 6 de Agosto', 'femenino', 0);
INSERT INTO estudiantes (nombres, apellidos, edad, fono, email, direccion, genero, licencia_conducir)
  VALUES ('Joel' ,'Adubiri Mondar', 30, 2832117, 'joel@gmail.com', 'Av. 6 de Agosto', 'masculino', 1);
INSERT INTO estudiantes (nombres, apellidos, edad, fono, email, direccion, genero, licencia_conducir)
  VALUES ('Andrea' ,'Arias Ballesteros', 21, 2832118, 'andrea@gmail.com', 'Av. 6 de Agosto', 'femenino', 0);
INSERT INTO estudiantes (nombres, apellidos, edad, fono, email, direccion, genero, licencia_conducir)
  VALUES ('Santos' ,'Montes Valenzuela', 24, 2832119, 'santos@gmail.com', 'Av. 6 de Agosto', 'masculino', 1);

select * from estudiantes;
drop table estudiantes;

 -- determinar cuantos estudiantes hay
select count(est.id_est) [nuemro de estudiantes registrados]
from estudiantes as est;

--DETERMINAR LA MINIMAA EDAD DE ESTUDIANTE
select MIN(est.edad) [EDAD MINIMA]
from estudiantes as est;

select MAX(est.edad) [EDAD MAXIMA]
from estudiantes as est;

select AVG(est.edad) [EDAD MINIMA]
from estudiantes as est;

select SUM(est.edad) [EDAD MINIMA]
from estudiantes as est;

--mostrar el numero de estudiantes de genero femenino
select count(id_est) [numero de estudiantes del genero femenino]
from estudiantes as est
where genero = 'femenino';

--agregar un dato a la tabla
alter table estudiantes add licencia_conducir bit not null;
--bit maneja 1,0

--cuantos estudiantes tienen licencia de conducir

select count(id_est) [numero de personas que tienes licencia]
from estudiantes as est
where licencia_conducir = 1;


select AVG(est.edad) []
from estudiantes as est;

--estudiantes que empiezsa con la palabral el y ademas sea del genero masculino
select count(id_est) [numero de estudiantes]
from estudiantes as est
where est.apellidos like '%el%'
and est.genero = 'masculino';


select count(id_est) [numero de estidiantes]
from estudiantes as est
where est.edad between 21 and 29 
	and est.licencia_conducir = 1;

-- el between es para definir un rango

--AGREGAR LA TABLA ESCUELA
create table escuela(
	id_esc int identity primary key not null,
	nombre varchar(10) not null,
	direccion varchar(30) not null,
	turno varchar(10)
);
-- todos los estudiantes forman parte de una escuela

INSERT INTO escuela(nombre, direccion, turno)
values ('santa fe','el alto','mañana')
INSERT INTO escuela(nombre, direccion, turno)
values ('brazil','la paz','tarde')


select * from escuela;
select * from estudiantes;
