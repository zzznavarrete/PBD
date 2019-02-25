-- ///////////////////////////////////////////////////////////////////////////
-- eliminación de tablas
--drop table detalle_ventas cascade constraints;
--drop table ventas cascade constraints;
--drop table productos cascade constraints;
--drop table clientes cascade constraints;
--drop table empleados cascade constraints;
--drop table cargos cascade constraints;

-- ///////////////////////////////////////////////////////////////////////////
-- tabla cargos
create table cargos (
  cargo_id number(5) not null primary key
  , nombre varchar2(20) not null
);

-- ///////////////////////////////////////////////////////////////////////////
-- tabla empleados
create table empleados (
  empleado_id number(5) not null primary key
  , nombre varchar2(20) not null
  , appaterno varchar2(20) not null
  , apmaterno varchar2(20) not null
  , fecha_contrato date not null
  , sueldo_base number(7) not null
  , cargo_id number(5) not null
);

alter table empleados
  add constraint fk_cargo_empleado foreign key(cargo_id)
    references cargos(cargo_id);
    
-- ///////////////////////////////////////////////////////////////////////////
-- tabla clientes
create table clientes (
  cliente_id number(5) not null primary key
  , nombre varchar2(20) not null
  , appaterno varchar2(20) not null
  , apmaterno varchar2(20) not null
  , sexo CHAR(1) not null
  , fecha_nacimiento date
  , estado_civil varchar(20)
);

-- ///////////////////////////////////////////////////////////////////////////
-- tabla ventas
create table ventas (
  venta_id number(5) not null primary key
  , vendedor_id number(5) not null
  , cliente_id number(5) not null
  , fecha date not null
  , tipo_documento varchar(10) not null
  , numero_documento number(5) not null
);

alter table ventas
  add constraint fk_venta_vendedor foreign key(vendedor_id)
    references empleados(empleado_id);
    
alter table ventas
  add constraint fk_venta_cliente foreign key(cliente_id)
    references clientes(cliente_id);

-- ///////////////////////////////////////////////////////////////////////////
-- tabla productos
create table productos(
  producto_id number(5) not null primary key
  , nombre varchar2(20) not null
  , precio number(10) not null
  , descripcion varchar(100)
);

-- ///////////////////////////////////////////////////////////////////////////
-- tabla detalle_ventas
create table detalle_ventas(
  venta_id number(5) not null
  , producto_id number(5) not null
  , cantidad number(5) not null
  , precio_unitario number(10) not null
  , descuento number(5,2) not null 
);

alter table detalle_ventas
  add constraint fk_detalle_venta foreign key(venta_id)
    references ventas(venta_id);
    
alter table detalle_ventas
  add constraint fk_detalle_venta_producto foreign key(producto_id)
    references productos(producto_id);
    
alter table detalle_ventas
  add constraint pk_detalle_ventas primary key(venta_id, producto_id);
  
-- #############################################################################

insert into cargos(cargo_id, nombre) values(1, 'vendedor');
insert into cargos(cargo_id, nombre) values(2, 'cajero');
insert into cargos(cargo_id, nombre) values(3, 'encargado despacho');
insert into cargos(cargo_id, nombre) values(4, 'bodeguero');
insert into cargos(cargo_id, nombre) values(5, 'mueblista');

select * from cargos;

-- #############################################################################

insert into empleados(empleado_id, nombre, appaterno, apmaterno, fecha_contrato
    , sueldo_base, cargo_id)
  values(1, 'Fabián',  'Cerda', 'Contreras', TO_DATE('03-10-2002','DD-MM-YYYY')
    , 300000, 5);
insert into empleados(empleado_id, nombre, appaterno, apmaterno, fecha_contrato
    , sueldo_base, cargo_id)
  values(2, 'Ricardo',  'Lunari', 'Pérez', TO_DATE('01-02-2000','DD-MM-YYYY')
    , 300000, 5);
insert into empleados(empleado_id, nombre, appaterno, apmaterno, fecha_contrato
    , sueldo_base, cargo_id)
  values(3, 'Juan',  'Lorca', 'Rebolledo', TO_DATE('01-02-2010','DD-MM-YYYY')
    , 251000, 4);
insert into empleados(empleado_id, nombre, appaterno, apmaterno, fecha_contrato
    , sueldo_base, cargo_id)
  values(4, 'Lorena',  'Jaque', 'Mate', TO_DATE('15-02-2000','DD-MM-YYYY')
    , 251000, 1);
insert into empleados(empleado_id, nombre, appaterno, apmaterno, fecha_contrato
    , sueldo_base, cargo_id)
  values(5, 'Ramiro',  'Mendoza', 'Escalieri', TO_DATE('01-12-2010','DD-MM-YYYY')
    , 280000, 3);
insert into empleados(empleado_id, nombre, appaterno, apmaterno, fecha_contrato
    , sueldo_base, cargo_id)
  values(6, 'Alejandra',  'Luna', 'Ochoa', TO_DATE('13-06-2010','DD-MM-YYYY')
    , 251000, 1);
insert into empleados(empleado_id, nombre, appaterno, apmaterno, fecha_contrato
    , sueldo_base, cargo_id)
  values(7, 'Romina',  'Pulgar', 'Soto', TO_DATE('10-08-2012','DD-MM-YYYY')
    , 251000, 1);
    
select * from EMPLEADOS;

-- #############################################################################

insert into clientes(cliente_id, nombre, appaterno, apmaterno, fecha_nacimiento
    , estado_civil, sexo)
  values(1, 'Alejandro', 'Vásquez', 'Soto', null
    , null, 'M' );
insert into clientes(cliente_id, nombre, appaterno, apmaterno, fecha_nacimiento
    , estado_civil, sexo)
  values(2, 'Gonzalo', 'Soto', 'Soto', TO_DATE('22-06-1980','DD-MM-YYYY')
    , 'casado', 'M' );
insert into clientes(cliente_id, nombre, appaterno, apmaterno, fecha_nacimiento
    , estado_civil, sexo)
  values(3, 'Carlos', 'Paredes', 'Paredes', TO_DATE('30-08-1965','DD-MM-YYYY')
    , 'casado', 'M' );
insert into clientes(cliente_id, nombre, appaterno, apmaterno, fecha_nacimiento
    , estado_civil, sexo)
  values(4, 'Francisco', 'Herbias', 'Le-Roy', TO_DATE('15-11-1970','DD-MM-YYYY')
    , 'casado', 'M' );
insert into clientes(cliente_id, nombre, appaterno, apmaterno, fecha_nacimiento
    , estado_civil, sexo)
  values(5, 'Margarita', 'Barraza', 'Hermosilla', TO_DATE('01-03-1975','DD-MM-YYYY')
    , 'casado', 'F' );
    
select * from CLIENTES;

-- #############################################################################

insert into productos(producto_id, nombre, precio, descripcion)
  values(1, 'Mesa de Centro', 550000, 'Mesa centro de madera raulí 2.0x1.5 mts');
insert into productos(producto_id, nombre, precio, descripcion)
  values(2, 'Bar color chocolate', 459000, 'Bar color chocolate madera, puertas de corredera');
insert into productos(producto_id, nombre, precio, descripcion)
  values(3, 'Comedor circular', 789000, 'Comedor con cubierta de vidrio circular. 6 sillas con tapiz a elección');
insert into productos(producto_id, nombre, precio, descripcion)
  values(4, 'Cava de madera', 419000, 'Cava de madera hecha en raulí capacidad para 105 vinos');
insert into productos(producto_id, nombre, precio, descripcion)
  values(5, 'Mueble Rack Modular', 280000, 'Rack de madera de raulí color miel, 2 cajones y tamaño personalizado');
  
select * from PRODUCTOS;

-- #############################################################################

insert into ventas(venta_id, vendedor_id, cliente_id, tipo_documento, numero_documento, fecha)
  values(1, 4, 1, 'boleta', 1000, TO_DATE('01-03-2016','DD-MM-YYYY'));
  
insert into detalle_ventas(venta_id, producto_id, cantidad, precio_unitario, descuento)
  values(1, 1, 1, 550000, 0.00);
insert into detalle_ventas(venta_id, producto_id, cantidad, precio_unitario, descuento)
  values(1, 5, 2, 280000, 0.05);
-- -----------------------------------------------------------------------------  
insert into ventas(venta_id, vendedor_id, cliente_id, tipo_documento, numero_documento, fecha)
  values(2, 7, 3, 'boleta', 1001, TO_DATE('02-03-2016','DD-MM-YYYY'));
  
insert into detalle_ventas(venta_id, producto_id, cantidad, precio_unitario, descuento)
  values(2, 2, 1, 459000, 0.05);
insert into detalle_ventas(venta_id, producto_id, cantidad, precio_unitario, descuento)
  values(2, 3, 2, 789000, 0.05);
insert into detalle_ventas(venta_id, producto_id, cantidad, precio_unitario, descuento)
  values(2, 4, 2, 419000, 0.05);
-- -----------------------------------------------------------------------------  
insert into ventas(venta_id, vendedor_id, cliente_id, tipo_documento, numero_documento, fecha)
  values(3, 7, 5, 'factura', 1002, TO_DATE('02-03-2016','DD-MM-YYYY'));
  
insert into detalle_ventas(venta_id, producto_id, cantidad, precio_unitario, descuento)
  values(3, 5, 2, 280000, 0.10);
-- -----------------------------------------------------------------------------  
insert into ventas(venta_id, vendedor_id, cliente_id, tipo_documento, numero_documento, fecha)
  values(4, 4, 4, 'boleta', 1003, TO_DATE('03-03-2016','DD-MM-YYYY'));
  
insert into detalle_ventas(venta_id, producto_id, cantidad, precio_unitario, descuento)
  values(4, 2, 1, 459000, 0.02);
-- -----------------------------------------------------------------------------  
insert into ventas(venta_id, vendedor_id, cliente_id, tipo_documento, numero_documento, fecha)
  values(5, 7, 2, 'boleta', 1004, TO_DATE('05-04-2016','DD-MM-YYYY'));
  
insert into detalle_ventas(venta_id, producto_id, cantidad, precio_unitario, descuento)
  values(5, 2, 1, 459000, 0.02);
-- -----------------------------------------------------------------------------  

select * from ventas;
select * from detalle_ventas;

-- #############################################################################