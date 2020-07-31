USE GD_UTN

SELECT 
	c1.comp_componente AS prod_codigo,
	p1.prod_detalle AS prod_detalle,
	ISNULL(SUM(if1.item_cantidad), 0) AS cantidad_vendida,
	COUNT(DISTINCT if1.item_numero) AS facturas_distintas,
	ISNULL(AVG(if1.item_precio), 0) AS precio_promedio,
	ISNULL(SUM(if1.item_precio), 0) AS total_facturado
FROM Composicion c1
JOIN Producto p1 ON  c1.comp_componente = p1.prod_codigo
LEFT JOIN Item_Factura if1 ON p1.prod_codigo = if1.item_producto
LEFT JOIN Factura f1 ON if1.item_numero = f1.fact_numero
WHERE YEAR(f1.fact_fecha) = 2012 AND c1.comp_producto = (
															SELECT TOP 1 if2.item_producto FROM Factura f2
															JOIN Item_Factura if2 ON f2.fact_numero = if2.item_numero
															WHERE YEAR(f2.fact_fecha) = 2012
															GROUP BY if2.item_producto
															ORDER BY SUM(if2.item_cantidad) DESC
														)
GROUP BY c1.comp_componente, p1.prod_detalle
ORDER BY cantidad_vendida DESC