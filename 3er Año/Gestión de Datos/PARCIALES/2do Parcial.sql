USE GD_UTN

/*
	Realizar una consulta SQL que retorne para los 10 clientes que más compraron en el 2012 y que fueron atendidos por más de 3 
	vendedores distintos:

    - Apellido y Nombre del Cliente.
    - Cantidad de Productos distintos comprados en el 2012.
    - Cantidad de unidades compradas dentro del primer semestre del 2012.

	El resultado deberá mostrar ordenado la cantidad de ventas descendente del 2012 de cada cliente, en caso de igualdad de ventas, 
	ordenar por código de cliente.

	NOTA: No se permite el uso de sub-selects en el FROM ni funciones definidas por el usuario para este punto.
*/
SELECT TOP 10
	c1.clie_codigo AS codigo_cliente,
	c1.clie_razon_social AS nombre_cliente, -- Supongo que APELLIDO y NOMBRE del cliente refiere a la RAZÓN SOCIAL --
	COUNT(DISTINCT if1.item_producto) AS productos_distintos_adquiridos,
	(
		SELECT SUM(if2.item_cantidad) FROM Factura f2
		JOIN Item_Factura if2 ON (f2.fact_numero = if2.item_numero) AND (f2.fact_tipo = if2.item_tipo) AND (f2.fact_sucursal = if2.item_sucursal)
		WHERE (YEAR(f2.fact_fecha) = 2012) AND (MONTH(f2.fact_fecha) BETWEEN 01 AND 06) AND (f2.fact_cliente = c1.clie_codigo)
		GROUP BY f2.fact_cliente
	) AS unidades_adquiridas_primer_semestre
FROM Cliente c1
JOIN Factura f1 ON c1.clie_codigo = f1.fact_cliente
JOIN Item_Factura if1 ON (f1.fact_numero = if1.item_numero) AND (f1.fact_tipo = if1.item_tipo) AND (f1.fact_sucursal = if1.item_sucursal)
WHERE (YEAR(f1.fact_fecha) = 2012)
GROUP BY c1.clie_codigo, c1.clie_razon_social
HAVING (COUNT(DISTINCT f1.fact_vendedor) > 3)
ORDER BY COUNT(DISTINCT f1.fact_numero) DESC, c1.clie_codigo