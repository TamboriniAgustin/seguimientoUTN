USE GD_UTN

SELECT 
	CONCAT(RIGHT(CONCAT('0000', YEAR(f1.fact_fecha)), 4), RIGHT(CONCAT('00', MONTH(f1.fact_fecha)), 2)) AS PERIODO,
	p1.prod_codigo AS PROD,
	p1.prod_detalle AS DETALLE,
	ISNULL(SUM(if1.item_cantidad), 0) AS CANTIDAD_VENDIDA,
	ISNULL((
		SELECT SUM(if2.item_cantidad) FROM Producto p2
		LEFT JOIN Item_Factura if2 ON p2.prod_codigo = if2.item_producto
		LEFT JOIN Factura f2 ON if2.item_numero = f2.fact_numero
		WHERE (MONTH(f2.fact_fecha) = MONTH(f1.fact_fecha)) AND (YEAR(f2.fact_fecha) = YEAR(f1.fact_fecha) - 1) AND (p2.prod_codigo = p1.prod_codigo)
		GROUP BY prod_codigo, prod_detalle, fact_fecha
	), 0) AS VENTAS_AÑO_ANT,
	COUNT(*) AS CANTIDAD_FACTURAS
FROM Producto p1
LEFT JOIN Item_Factura if1 ON p1.prod_codigo = if1.item_producto
LEFT JOIN Factura f1 ON if1.item_numero = f1.fact_numero
GROUP BY prod_codigo, prod_detalle, fact_fecha
ORDER BY PERIODO, PROD