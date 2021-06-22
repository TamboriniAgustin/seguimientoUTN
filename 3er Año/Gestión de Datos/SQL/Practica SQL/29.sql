USE GD_UTN

SELECT 
	p1.prod_codigo, 
	p1.prod_detalle, 
	SUM(if1.item_cantidad) AS cantidad_vendida,
	COUNT(DISTINCT f1.fact_numero) AS cantidad_facturas,
	SUM(f1.fact_total + f1.fact_total_impuestos) AS monto_total_facturado
FROM Producto p1
JOIN Item_Factura if1 ON p1.prod_codigo = if1.item_producto
JOIN Factura f1 ON if1.item_numero = f1.fact_numero
WHERE (YEAR(f1.fact_fecha) = 2011) AND (p1.prod_familia IN (
																SELECT fam2.fami_id FROM Familia fam2
																JOIN Producto p2 ON fam2.fami_id = p2.prod_familia
																GROUP BY fam2.fami_id
																HAVING COUNT(p2.prod_codigo) > 20											
															)
									    )
GROUP BY p1.prod_codigo, p1.prod_detalle
ORDER BY cantidad_vendida DESC