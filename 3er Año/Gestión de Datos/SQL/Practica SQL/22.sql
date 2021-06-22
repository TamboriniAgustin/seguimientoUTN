USE GD_UTN

(
	SELECT 
		r1.rubr_detalle, 
		1 AS trimestre, 
		COUNT(f1.fact_numero) AS facturas_emitidas, 
		(
			SELECT COUNT(DISTINCT p2.prod_codigo) FROM Producto p2
			JOIN Item_Factura if2 ON p2.prod_codigo = if2.item_producto
			JOIN Factura f2 ON if2.item_numero = f2.fact_numero
			WHERE (p2.prod_rubro = r1.rubr_id) AND (MONTH(f2.fact_fecha) BETWEEN 1 AND 3)
		) AS productos_diferentes_vendidos 
	FROM Rubro r1
	LEFT JOIN Producto p1 ON r1.rubr_id = p1.prod_rubro
	JOIN Item_Factura if1 ON p1.prod_codigo = if1.item_producto
	JOIN Factura f1 ON if1.item_numero = f1.fact_numero
	WHERE MONTH(f1.fact_fecha) BETWEEN 1 AND 3 
	GROUP BY r1.rubr_id, r1.rubr_detalle
	HAVING COUNT(f1.fact_numero) > 100

	UNION

	SELECT 
		r1.rubr_detalle, 
		2 AS trimestre, 
		COUNT(f1.fact_numero) AS facturas_emitidas, 
		(
			SELECT COUNT(DISTINCT p2.prod_codigo) FROM Producto p2
			JOIN Item_Factura if2 ON p2.prod_codigo = if2.item_producto
			JOIN Factura f2 ON if2.item_numero = f2.fact_numero
			WHERE (p2.prod_rubro = r1.rubr_id) AND (MONTH(f2.fact_fecha) BETWEEN 4 AND 6)
		) AS productos_diferentes_vendidos 
	FROM Rubro r1
	LEFT JOIN Producto p1 ON r1.rubr_id = p1.prod_rubro
	JOIN Item_Factura if1 ON p1.prod_codigo = if1.item_producto
	JOIN Factura f1 ON if1.item_numero = f1.fact_numero
	WHERE MONTH(f1.fact_fecha) BETWEEN 4 AND 6 
	GROUP BY r1.rubr_id, r1.rubr_detalle
	HAVING COUNT(f1.fact_numero) > 100

	UNION

	SELECT 
		r1.rubr_detalle, 
		3 AS trimestre, 
		COUNT(f1.fact_numero) AS facturas_emitidas, 
		(
			SELECT COUNT(DISTINCT p2.prod_codigo) FROM Producto p2
			JOIN Item_Factura if2 ON p2.prod_codigo = if2.item_producto
			JOIN Factura f2 ON if2.item_numero = f2.fact_numero
			WHERE (p2.prod_rubro = r1.rubr_id) AND (MONTH(f2.fact_fecha) BETWEEN 7 AND 9)
		) AS productos_diferentes_vendidos 
	FROM Rubro r1
	LEFT JOIN Producto p1 ON r1.rubr_id = p1.prod_rubro
	JOIN Item_Factura if1 ON p1.prod_codigo = if1.item_producto
	JOIN Factura f1 ON if1.item_numero = f1.fact_numero
	WHERE MONTH(f1.fact_fecha) BETWEEN 7 AND 9 
	GROUP BY r1.rubr_id, r1.rubr_detalle
	HAVING COUNT(f1.fact_numero) > 100

	UNION

	SELECT 
		r1.rubr_detalle, 
		4 AS trimestre, 
		COUNT(f1.fact_numero) AS facturas_emitidas, 
		(
			SELECT COUNT(DISTINCT p2.prod_codigo) FROM Producto p2
			JOIN Item_Factura if2 ON p2.prod_codigo = if2.item_producto
			JOIN Factura f2 ON if2.item_numero = f2.fact_numero
			WHERE (p2.prod_rubro = r1.rubr_id) AND (MONTH(f2.fact_fecha) BETWEEN 10 AND 12)
		) AS productos_diferentes_vendidos 
	FROM Rubro r1
	LEFT JOIN Producto p1 ON r1.rubr_id = p1.prod_rubro
	JOIN Item_Factura if1 ON p1.prod_codigo = if1.item_producto
	JOIN Factura f1 ON if1.item_numero = f1.fact_numero
	WHERE MONTH(f1.fact_fecha) BETWEEN 10 AND 12 
	GROUP BY r1.rubr_id, r1.rubr_detalle
	HAVING COUNT(f1.fact_numero) > 100
)
ORDER BY rubr_detalle, facturas_emitidas DESC