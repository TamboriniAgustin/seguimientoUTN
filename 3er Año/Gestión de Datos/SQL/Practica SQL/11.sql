USE GD_UTN

SELECT fami_detalle, COUNT(DISTINCT if1.item_cantidad) as productos_vendidos, SUM(if1.item_cantidad * if1.item_precio) as total_venta FROM Familia fam1
JOIN Producto p1 ON fam1.fami_id = p1.prod_familia
JOIN Item_Factura if1 ON p1.prod_codigo = if1.item_producto
GROUP BY fam1.fami_id, fam1.fami_detalle
HAVING 
	(
		SELECT SUM(if2.item_cantidad * if2.item_precio) FROM Familia fam2
		JOIN Producto p2 ON fam2.fami_id = p2.prod_familia
		JOIN Item_Factura if2 ON p2.prod_codigo = if2.item_producto
		JOIN Factura f1 ON if2.item_numero = f1.fact_numero
		WHERE (YEAR(f1.fact_fecha) = 2012) AND (fam1.fami_id = fam2.fami_id)
		GROUP BY fam2.fami_id, fam2.fami_detalle
	) > 20000
ORDER BY productos_vendidos DESC