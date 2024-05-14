
/*1. Cantidad de productos vendidos*/
SELECT COUNT(*) AS total_productos_vendidos
FROM ventas
;


/*2. Qué número de referencias únicas se han vendido*/
SELECT COUNT(DISTINCT id_producto) AS productos_unicos_vendidos
FROM ventas
;


/*3. Promedio de unidades vendidas por referencia/producto*/
SELECT COUNT(*)/COUNT(DISTINCT id_producto) AS total_productos_vendidos
FROM ventas
;

SELECT AVG(unidades_vendidas) AS promedio_unidades_por_producto
FROM
(
	SELECT id_producto, COUNT(id_producto) AS unidades_vendidas
	FROM ventas
	GROUP BY id_producto
) AS unidades_vendidas_por_producto
;


/*4. Lista de productos con precios superior a los 700 euros*/
SELECT *
FROM productos
WHERE precio >= 700
;


/*5. Lista de vendedores con edades menores a los 30 años*/
SELECT *
FROM vendedores
WHERE fecha_nac >= '1993/05/13'
;
SELECT id_vendedor, nombre, apellido, TIMESTAMPDIFF(YEAR, fecha_nac, CURDATE()) AS edad
FROM vendedores 
WHERE TIMESTAMPDIFF(YEAR, fecha_nac, CURDATE()) < 30
;



/*6. Lista de vendedores por provincia (Con nombre y apellido)*/
SELECT v.nombre, v.apellido, o.descripcion AS provincia
FROM oficina AS o
LEFT JOIN vendedores AS v 
on o.id_oficina = v.id_oficina
;

SELECT nombre, apellido, descripcion as provincia
FROM oficina o
INNER JOIN vendedores  v
on o.id_oficina = v.id_oficina
;	

   SELECT nombre, apellido, descripcion as provincia
FROM vendedores v
RIGHT JOIN oficina o
on o.id_oficina = v.id_oficina
;

SELECT nombre, apellido, descripcion as provincia
FROM oficina AS o
LEFT JOIN vendedores AS v
on o.id_oficina = v.id_oficina
WHERE v.id_oficina IS NOT NULL
;	


/*7. Lista de oficinas que no tienen vendedores asignados (Considerar todas las oficinas)*/
SELECT *
FROM oficina
LEFT JOIN vendedores
ON oficina.id_oficina = vendedores.id_oficina
WHERE id_vendedor IS NULL
ORDER BY oficina.id_oficina
;


/*8. Lista de oficinas y vendedores con la cantidad vendida por vendedor (Considerar todas las oficinas)*/
SELECT v.id_vendedor,v.nombre, v.apellido, o.descripcion as provincia, COUNT(id_venta) AS cantidad_vendida
FROM oficina AS o 
LEFT JOIN vendedores AS v 
ON o.id_oficina = v.id_oficina
LEFT JOIN ventas as vt
ON vt.id_vendedor = v.id_vendedor
GROUP BY 
	v.id_vendedor, v.nombre, v.apellido, o.descripcion
;


/*9. Ingresos de ventas entre el 15 de enero al 15 de febrero*/
SELECT SUM(precio)
FROM productos
JOIN (
	SELECT id_producto
	FROM ventas
	WHERE FECHA BETWEEN STR_TO_DATE('2020-01-15','%Y-%m-%d') AND STR_TO_DATE('2020-02-15','%Y-%m-%d')
) AS subset_fecha
ON productos.id_producto = subset_fecha.id_producto
;

/* Ingresos de ventas entre el 15 de enero al 15 de febrero
 Utilizando una cláusula WITH
*/

WITH ingresos AS (
	SELECT SUM(p.precio) AS ingresos, vt.id_producto, vt.fecha
	FROM ventas vt
	LEFT JOIN productos p
	on vt.id_producto = p.id_producto
	WHERE vt.fecha BETWEEN '2020-01-15' AND '2020-02-15'
	GROUP BY vt.id_producto, p.precio, vt.fecha
)
SELECT sum(ingresos) AS ingresos_eur
FROM ingresos i
;


/*10. Lista de productos vendidos (Con su descripción, precio, cantidad vendidas e ingresos)*/
SELECT p.descripcion, p.precio, COUNT(id_venta) AS cantidad_vendidas, SUM(p.precio) as ingresos
FROM productos AS p
INNER JOIN ventas AS v
	on p.id_producto = v.id_producto
WHERE v.fecha BETWEEN '2020-01-15' AND '2020-02-15'
GROUP BY p.id_producto, p.precio, p.descripcion
;

SELECT 'Rango del 15 enero al 15 de febrero' AS rango_temporal, SUM(precio) AS ingresos_eur, SUM(p.precio)*1.12 AS ingresos_usd
FROM ventas as vt
LEFT JOIN productos as p
	on vt.id_producto = p.id_producto
WHERE FECHA BETWEEN '2020-01-15' AND '2020-02-15'

UNION

SELECT 'Antes del 15 enero' AS rango_temporal, SUM(precio) AS ingresos_eur, SUM(p.precio)*1.12 AS ingresos_usd
FROM ventas as vt
LEFT JOIN productos as p
	on vt.id_producto = p.id_producto
WHERE FECHA < '2020-01-15'
;


/*11. Ranking de mejores vendedores (criterio: por cantidad de productos vendidos)*/
SELECT v.id_vendedor, v.nombre, v.apellido, COUNT(vt.id_venta) AS cantidad_vendida
FROM vendedores v
LEFT JOIN ventas vt
on v.id_vendedor = vt.id_vendedor 
GROUP BY v.id_vendedor, v.nombre, v.apellido
ORDER BY cantidad_vendida DESC
LIMIT 0, 3
;


/* Ranking de los peores vendedores (criterio: por cantidad de productos vendidos)*/
SELECT v.id_vendedor, v.nombre, v.apellido, COUNT(vt.id_venta) AS cantidad_vendida
FROM vendedores v
LEFT JOIN ventas vt
on v.id_vendedor = vt.id_vendedor
GROUP BY v.id_vendedor, v.nombre, v.apellido
ORDER BY cantidad_vendida ASC
LIMIT 0, 3
;


/*Vendedores que NO han vendido absolutamente nada*/
SELECT v.id_vendedor, v.nombre, v.apellido, COUNT(vt.id_venta) AS cantidad_vendida
FROM vendedores v
LEFT JOIN ventas vt
on v.id_vendedor = vt.id_vendedor
GROUP BY v.id_vendedor, v.nombre, v.apellido
HAVING cantidad_vendida = 0
ORDER BY cantidad_vendida ASC
;


/*12. Ranking de mejores clientes (criterio: por ingresos que obtiene la empresa)*/
SELECT c.id_cliente, CONCAT(c.nombre, ' ', c.apellido) AS cliente, sum(p.precio) AS ingresos_euros
FROM clientes c
LEFT JOIN ventas v
on c.id_cliente = v.id_cliente
LEFT JOIN productos p
	on v.id_producto = p.id_producto
GROUP BY c.id_cliente, c.nombre, c.apellido
ORDER BY ingresos_euros DESC
;

/*Ranking de mejores clientes (criterio: por ingresos que obtiene la empresa)
 utilizando una cláusula WITH*/

WITH ingresos AS (
	SELECT c.id_cliente, CONCAT(c.nombre, ' ', c.apellido) AS cliente, COUNT(v.id_venta)*p.precio AS ingresos_euros
	FROM clientes c
	LEFT JOIN ventas v
    on c.id_cliente = v.id_cliente
	LEFT JOIN productos p
        on v.id_producto = p.id_producto
	GROUP BY c.id_cliente, c.nombre, c.apellido, p.precio
)
SELECT id_cliente, cliente, SUM(ingresos_euros) AS ingresos_totales
FROM ingresos
GROUP BY id_cliente, cliente
ORDER BY ingresos_totales DESC
;


/*13. Ranking de mejores clientes que tengan como vendedor la oficina de Barcelona (criterio: por ingresos que obtiene la empresa)
 Clientes que hayan comprado en Barcelona*/
SELECT c.id_cliente, CONCAT(c.nombre, ' ', c.apellido) AS cliente, sum(p.precio) AS ingresos_euros
FROM clientes c
LEFT JOIN ventas v
USING (id_cliente)
LEFT JOIN productos p
USING (id_producto)
WHERE c.id_cliente IN (
	SELECT DISTINCT c.id_cliente
	FROM clientes as c
	INNER JOIN ventas as vt
	USING (id_cliente)
	INNER JOIN vendedores as v
	USING (id_vendedor)
	INNER JOIN oficina as o
	USING (id_oficina)
	WHERE o.descripcion = 'Barcelona'
	ORDER BY c.id_cliente
)
GROUP BY c.id_cliente, c.nombre, c.apellido
ORDER BY ingresos_euros DESC
;
