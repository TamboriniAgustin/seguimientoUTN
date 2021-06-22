USE GD_UTN

SELECT 
	r1.rubr_id, 
	MONTH(f1.fact_fecha) AS mes,
	(
		SELECT COUNT(DISTINCT p2.prod_rubro) FROM Factura f2
		JOIN Item_Factura if2 ON f2.fact_numero = if2.item_numero
		JOIN Producto p2 ON if2.item_producto = p2.prod_codigo
		WHERE (YEAR(f2.fact_fecha) = 2011) AND (MONTH(f2.fact_fecha) = MONTH(f1.fact_fecha)) AND (p2.prod_rubro != r1.rubr_id)
	) AS facturas_mal_realizadas
FROM Rubro r1
JOIN Producto p1 ON r1.rubr_id = p1.prod_rubro
JOIN Item_Factura if1 ON p1.prod_codigo = if1.item_producto
JOIN Factura f1 ON if1.item_numero = f1.fact_numero
WHERE YEAR(f1.fact_fecha) = 2011
GROUP BY r1.rubr_id, MONTH(f1.fact_fecha)
ORDER BY r1.rubr_id, MONTH(f1.fact_fecha)