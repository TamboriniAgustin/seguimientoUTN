USE GD_UTN

SELECT 
	DISTINCT YEAR(f1.fact_fecha) AS año,
	p1.prod_codigo,
	p1.prod_detalle,
	COUNT(DISTINCT f1.fact_numero) AS cantidad_facturas,
	COUNT(DISTINCT f1.fact_cliente) AS clientes_distintos,
	(
		SELECT COUNT(DISTINCT c2.comp_producto) FROM Composicion c2
		WHERE c2.comp_componente = p1.prod_codigo
	) AS productos_que_compone,
	(
		SELECT ((SUM(if2.item_cantidad) / (SELECT SUM(if3.item_cantidad) FROM Factura f3 
										   JOIN Item_Factura if3 ON f3.fact_numero = if3.item_numero 
										   WHERE YEAR(f3.fact_fecha) = YEAR(f1.fact_fecha))
				) * 100) 
		FROM Factura f2
		JOIN Item_Factura if2 ON f2.fact_numero = if2.item_numero
		WHERE (YEAR(f2.fact_fecha) = YEAR(f1.fact_fecha)) AND (if2.item_producto = p1.prod_codigo)
		GROUP BY if2.item_producto
	) AS porcentaje_ventas
FROM Factura f1
JOIN Item_Factura if1 ON f1.fact_numero = if1.item_numero
JOIN Producto p1 ON if1.item_producto = p1.prod_codigo
GROUP BY YEAR(f1.fact_fecha), p1.prod_codigo, p1.prod_detalle
ORDER BY YEAR(f1.fact_fecha), porcentaje_ventas DESC