--01
DECLARE
  cursor c_cursor IS
 SELECT
  v.numero_documento as numdoc, to_char(sum(d.precio_unitario*d.cantidad)-sum(( d.precio_unitario*d.cantidad)*d.DESCUENTO),'$999G999G999') as costo,
  TO_CHAR(ROUND(((sum(d.precio_unitario*d.cantidad)-sum(( d.precio_unitario*d.cantidad)*d.DESCUENTO))*0.19)), '$999G999G999') as IVA,
  TO_CHAR((ROUND(((sum(d.precio_unitario*d.cantidad)-sum(( d.precio_unitario*d.cantidad)*d.DESCUENTO))*0.19))+sum(d.precio_unitario*d.cantidad)-sum(( d.precio_unitario*d.cantidad)*d.DESCUENTO)), '$999G999G999') as total
  from ventas v join detalle_ventas d on(v.venta_id = d.venta_id)
  group by v.NUMERO_DOCUMENTO
  order by v.numero_documento asc;
BEGIN
  FOR temp in c_cursor
    LOOP
    dbms_output.put_line('La venta con Num Docto: '|| temp.numdoc||' tuvo el sgte detalle:');
    dbms_output.put_line('Neto:       '||temp.costo);
    dbms_output.put_line('IVA:      '||temp.iva);
    dbms_output.put_line('TOTAL:      '||(temp.total));
    dbms_output.put_line('------------------------------------');
    END LOOP;
END;

--02
DECLARE
  v_comision NUMERIC (8,2) := 0.05;
  v_ventas NUMERIC (8,2) := 0;
  cursor c_cursor IS
    SELECT
      e.nombre nombre, e.appaterno apellido, sum(d.precio_unitario*d.cantidad) ventas
      from empleados e full outer join ventas v on(e.EMPLEADO_ID = v.VENDEDOR_ID)
      full outer join detalle_ventas d on(d.VENTA_ID = v.VENTA_ID)
       where e.CARGO_ID = 1
      group by e.nombre , e.appaterno;
BEGIN
   FOR temp in c_cursor 
      
        LOOP
            IF temp.ventas IS NULL THEN
            temp.ventas := 0;
            v_comision :=0;
            END IF;
              dbms_output.put_line('El vendedor '|| temp.nombre || ' ' || temp.apellido|| ':' );
              dbms_output.put_line('Ventas: '|| to_char(temp.ventas ,'$999G999G999'));
              dbms_output.put_line('Comision: '|| to_char(temp.ventas*v_comision ,'$999G999G999'));
        END LOOP;
END;

--03
DECLARE
  v_comision NUMBER (8,2) := 0.05;
  v_bImponible number; --base imponible
  v_afp number (8,2) :=0;
  v_salud number (8,2) := 0;
  v_descuentos number (8,2) :=0;
  v_liquido number (8,2) :=0;
  CURSOR c_cursor IS
    SELECT
      e.nombre nombre, e.appaterno apellido, e.sueldo_base sueldo, c.nombre cargo, e.CARGO_ID cargoID, sum(d.precio_unitario*d.cantidad) ventas
      from empleados e join cargos c on(e.CARGO_ID = c.CARGO_ID)
      full outer join ventas v on(v.VENDEDOR_ID = e.EMPLEADO_ID)
      full outer join detalle_ventas d on(d.VENTA_ID = v.VENTA_ID)
      group by e.nombre , e.appaterno , e.sueldo_base , c.nombre , e.CARGO_ID ;
BEGIN
v_bImponible :=0;

  FOR temp in c_cursor
    LOOP
       IF temp.cargoID = 1 AND temp.ventas IS NOT NULL THEN
         v_bImponible := (temp.sueldo+(temp.sueldo*v_comision));
         v_comision := (temp.sueldo*0.05);
         
       ELSIF temp.cargoID = 1 and temp.ventas IS NULL THEN
       v_bImponible := temp.sueldo;
       v_comision:=0;
       ELSE 
          v_bImponible := temp.sueldo;
          v_comision := 0;
       END IF;
          
          v_afp := (temp.sueldo+v_comision)*0.1;
          v_salud := (temp.sueldo+v_comision)*0.07;
          v_descuentos := v_afp+v_salud;
          v_liquido := ((temp.sueldo+v_comision)-v_descuentos);
          
          dbms_output.put_line('El '|| temp.cargo ||' '|| temp.apellido || ' ' || temp.nombre);
          dbms_output.put_line('Sueldo base: '|| to_char(temp.sueldo,'$999G999G999'));
          dbms_output.put_line('Comisión :'|| to_char(v_comision,'$999G999G999'));
          dbms_output.put_line('--------------');
          dbms_output.put_line('SUELDO IMPONIBLE: '|| to_char((temp.sueldo+v_comision), '$999G999G999')) ;
          dbms_output.put_line('AFP: '|| to_char(v_afp,'$999G999G999'));
          dbms_output.put_line('Salud: '|| to_char(v_salud,'$999G999G999'));
          dbms_output.put_line('--------------');
          dbms_output.put_line('Descuentos: '||to_char(v_descuentos,'$999G999G999') );
          dbms_output.put_line('SUELDO LIQUIDO: '||to_char(v_liquido,'$999G999G999') );
          dbms_output.put_line('//////////////////////////////////');
          dbms_output.put_line('//////////////////////////////////');
          
    END LOOP;
END;




