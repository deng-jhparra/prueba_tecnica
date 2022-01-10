/**
 * Recursos Humanos de EDteam
 * Prueba técnica para candidatos a DBA Junior
 * ===========================================
 * 
 * Candidato : Jesus Parra
 *  
**/

------------------------------------------
-- Clientes que han comprado más en valor.
------------------------------------------

-- Se considera un cliente que compre por mas de 2500 unidades monetaria

SELECT 
      (SELECT nombre||' '||apellido 
       FROM clientes 
       WHERE id = f.cliente_id)  AS "Cliente", 
      sum(f.cantidad_vendida * (SELECT precio 
                                        FROM productos 
                                        WHERE id=f.producto_id)) AS "Valor/Compra"
FROM facturacion f
GROUP BY "Cliente"
HAVING sum(f.cantidad_vendida * (SELECT precio 
                                        FROM productos 
                                        WHERE id=f.producto_id)) > 2500
ORDER BY 2 DESC

---------------------------------------------
-- Clientes que han comprado más en cantidad.
---------------------------------------------

-- Se considera un cliente que compre por mas de 100 unidades

SELECT 
      (SELECT nombre||' '||apellido 
       FROM clientes 
       WHERE id = f.cliente_id) AS "Cliente", 
      sum(cantidad_vendida) AS "Cantidad Comprada" 
FROM facturacion f
GROUP BY "Cliente"
HAVING sum(cantidad_vendida) > 100
ORDER BY "Cantidad Comprada"  DESC

-----------------------------------
-- Productos más vendidos en valor.
-----------------------------------

-- Se considera un producto mas vendido en valor que supere 3000 unidades monetaria

SELECT 
      (SELECT nombre 
       FROM productos 
       WHERE id=f.producto_id) AS "Producto",
      sum(cantidad_vendida * (SELECT precio 
                                      FROM productos 
                                      WHERE id=f.producto_id)) AS "Valor" 
FROM facturacion f
GROUP BY "Producto"
HAVING sum(cantidad_vendida * (SELECT precio 
                                      FROM productos 
                                      WHERE id=f.producto_id)) > 3000
ORDER BY "Valor" DESC

--------------------------------------
-- Productos más vendidos en cantidad.
--------------------------------------

-- Se considera un producto mas vendido que supere 100 unidades

SELECT 	
      (SELECT nombre 
       FROM productos 
       WHERE id=f.producto_id) AS "Producto", 
      sum(f.cantidad_vendida) AS "Cantidad Vendida" 
FROM facturacion f
GROUP BY f.producto_id
HAVING sum(f.cantidad_vendida) > 150
ORDER BY "Cantidad Vendida" DESC 

-------------------------------------
-- Productos menos vendidos en valor.
-------------------------------------

-- Se considera un producto menos vendido en valor al que se encuentre por debajo de 100 unidades monetaria

SELECT 
      (SELECT nombre 
       FROM productos 
       WHERE id=f.producto_id) AS "Producto",
      sum(cantidad_vendida * (SELECT precio 
                                      FROM productos 
                                      WHERE id=f.producto_id)) AS "Valor" 
FROM facturacion f
GROUP BY "Producto"
HAVING sum(cantidad_vendida * (SELECT precio 
                                      FROM productos 
                                      WHERE id=f.producto_id)) < 50
ORDER BY "Valor" DESC

----------------------------------------
-- Productos menos vendidos en cantidad.
----------------------------------------

-- Se considera un producto menos vendido al que se encuentre por debajo de 10 unidades

SELECT 	
      (SELECT nombre 
       FROM productos 
       WHERE id=f.producto_id) AS "Producto", 
      sum(f.cantidad_vendida) AS "Cantidad Vendida" 
FROM facturacion f
GROUP BY f.producto_id
HAVING sum(f.cantidad_vendida) < 10
ORDER BY "Cantidad Vendida" DESC 

-----------------------------------------
-- Valor de las ventas agrupadas por mes.
-----------------------------------------

-- Se agrego el año para identificar el mes del año correspondiente

SELECT date_part('year',fecha_facturacion::date) AS "Año", 
       date_part('month', fecha_facturacion::date) AS "Mes",
       sum(f.cantidad_vendida * (SELECT precio 
                                         FROM productos 
                                         WHERE id=f.producto_id)) AS "Valor Ventas/Mes"
FROM facturacion f
GROUP BY date_part('year',fecha_facturacion::date),date_part('month', fecha_facturacion::date)
ORDER BY date_part('year',fecha_facturacion::date),date_part('month', fecha_facturacion::date) ASC

----------------------------------------------------
-- Valor de las ventas agrupadas por producto y mes.
----------------------------------------------------

-- Se agrego el año para identificar el mes del año correspondiente

SELECT 
      (SELECT nombre 
       FROM productos 
       WHERE id = f.producto_id) AS "Producto", 
      date_part('year',fecha_facturacion::date) AS "Año", 
      date_part('month', fecha_facturacion::date) AS "Mes", 
      sum(f.cantidad_vendida * (SELECT precio 
                                        FROM productos 
                                        WHERE id=f.producto_id)) AS "Valor Ventas /Mes"
FROM facturacion f
GROUP BY producto_id, date_part('year', fecha_facturacion::date), date_part('month', fecha_facturacion::date)
ORDER BY producto_id, date_part('month', fecha_facturacion::date) ASC


