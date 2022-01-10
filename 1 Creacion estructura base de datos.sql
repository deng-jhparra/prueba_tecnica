/**
 * Recursos Humanos de EDteam
 * Prueba técnica para candidatos a DBA Junior
 * ===========================================
 * 
 * Candidato : Jesus Parra
 *  
**/

-----------------------------------------------------------------------------------------
-- NOTA IMPORTANTE : Este trabajo fue realizado en un sistema de base de datos PostgreSQL
-----------------------------------------------------------------------------------------

-- Creacion de la base de datos tienda
-- Este paso es opcional, para realizar el ejercicio
-- puede hacerso sobre cualquier otra base de datos.
DROP DATABASE IF EXISTS tienda;
CREATE DATABASE tienda;

-- A continaucion la creacion de las tablas y sus atributos
-- Active o ponga en uso la base de datos donde se realizara las siguientes acciones

-- Creacion de la tabla cleintes
DROP TABLE IF EXISTS clientes;
CREATE TABLE clientes (
	id serial PRIMARY KEY,
	identificacion VARCHAR (8) unique not null,
	nombre VARCHAR (40) not null,
    apellido VARCHAR (40) not null,
	correo VARCHAR (320) unique not null,
	direccion VARCHAR (100)
);

-- Creacion de la tabla productos
DROP TABLE IF EXISTS productos;
CREATE TABLE productos (
	id serial PRIMARY KEY,
	nombre VARCHAR (50) unique not null,
	presentacion VARCHAR (40) not null,
	precio numeric CHECK (precio > 0),
	impuesto numeric
);

-- Creacion de la tabla facturacion
DROP TABLE IF EXISTS facturacion;
CREATE TABLE facturacion (
	id serial PRIMARY KEY,
	cliente_id int not null,
	producto_id int not null,
	fecha_facturacion date not null,
	cantidad_vendida int not null,
	CONSTRAINT fk_cliente FOREIGN KEY (cliente_id) REFERENCES clientes(id),
	CONSTRAINT fk_producto FOREIGN KEY (producto_id) REFERENCES productos(id)
);



/** INFORMACION
  Hay un limite de longitud en las direcciones de correo electronico. Ese limite es un maximo de 64 caracteres (octetos) en la "parte local "(antes de la" @ ") y 
  un maximo de 255 caracteres (octetos) en la parte del dominio (despues de la "@") para una longitud total de 320 caracteres. 
  Los sistemas que manejan el correo electronico deben estar preparados para procesar direcciones que son tan largas, aunque rara vez se encuentren ".
  fuente : http://tools.ietf.org/html/rfc3696 (Pagina 6, Seccion 3)
**/


