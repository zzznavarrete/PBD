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
--03
DECLARE
  v_comision NUMBER (8,2) := 0.05;
  v_porcino number; --base imponible
  CURSOR c_cursor IS
    SELECT
      e.nombre nombre, e.appaterno apellido, e.sueldo_base sueldo, c.nombre cargo
      from empleados e join cargos c on(e.CARGO_ID = c.CARGO_ID);
BEGIN
  v_porcino := 0;
  FOR temp in c_cursor
    LOOP
    v_porcino := temp.sueldo+(temp.sueldo*0.05);
      dbms_output.put_line('El '|| temp.cargo ||' '|| temp.apellido || ' ' || temp.nombre);
      
    END LOOP;
END;



