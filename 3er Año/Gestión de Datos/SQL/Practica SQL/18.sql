USE GD_UTN

SELECT 
	rubr_detalle AS DETALLE_RUBRO,
	ISNULL(SUM(f1.fact_total + f1.fact_total_impuestos), 0) AS VENTAS,
	(
		SELECT TOP 1 p2.prod_codigo FROM Producto p2
		JOIN Item_Factura f2 ON p2.prod_codigo = f2.item_producto
		WHERE p2.prod_rubro = r1.rubr_id
		GROUP BY p2.prod_codigo
		ORDER BY SUM(f2.item_cantidad) DESC
	) AS PROD1,
	(
		SELECT TOP 1 p2.prod_codigo FROM Producto p2
		JOIN Item_Factura f2 ON p2.prod_codigo = f2.item_producto
		WHERE p2.prod_rubro = r1.rubr_id
		GROUP BY p2.prod_codigo
		HAVING p2.prod_codigo != (
									SELECT TOP 1 p3.prod_codigo FROM Producto p3
									JOIN Item_Factura f3 ON p3.prod_codigo = f3.item_producto
									WHERE p3.prod_rubro = r1.rubr_id
									GROUP BY p3.prod_codigo
									ORDER BY SUM(f3.item_cantidad) DESC
								  )
		ORDER BY SUM(f2.item_cantidad) DESC
	) AS PROD2,
	ISNULL((
		SELECT TOP 1 c1.clie_codigo FROM Cliente c1
		JOIN Factura f4 ON c1.clie_codigo = f4.fact_cliente
		JOIN Item_Factura if2 ON f4.fact_numero = if2.item_numero
		JOIN Producto p4 ON if2.item_producto = p4.prod_codigo
		WHERE (p4.prod_rubro = r1.rubr_id) AND (f4.fact_fecha > DATEADD(DAY, -30, (SELECT MAX(fact_fecha) FROM Factura)))
		GROUP BY c1.clie_codigo
		ORDER BY SUM(if2.item_cantidad) DESC
	), '-') AS CLIENTE
FROM Rubro r1
LEFT JOIN Producto p1 ON r1.rubr_id = p1.prod_rubro
JOIN Item_Factura if1 ON p1.prod_codigo = if1.item_producto
JOIN Factura f1 ON if1.item_numero = f1.fact_numero
GROUP BY r1.rubr_id, r1.rubr_detalle
ORDER BY COUNT(DISTINCT p1.prod_codigo) DESC