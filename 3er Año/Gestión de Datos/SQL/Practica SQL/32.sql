USE GD_UTN

SELECT  
	fam1.fami_id AS fam1_cod,
	fam1.fami_detalle AS fam1_detalle,
	fam2.fami_id AS fam2_cod,
	fam2.fami_detalle AS fam2_detalle,
	COUNT(DISTINCT f1.fact_numero) AS cantidad_facturas,
	SUM(f1.fact_total + f1.fact_total_impuestos) AS total_vendido
FROM Familia fam1
JOIN Familia fam2 ON fam1.fami_id != fam2.fami_id
JOIN Producto p1 ON fam1.fami_id = p1.prod_familia 
JOIN Producto p2 ON fam2.fami_id = p2.prod_familia
JOIN Item_Factura if1 ON p1.prod_codigo = if1.item_producto
JOIN Item_Factura if2 ON p2.prod_codigo = if2.item_producto
JOIN Factura f1 ON (if1.item_numero = f1.fact_numero) AND (if2.item_numero = f1.fact_numero)
GROUP BY fam1.fami_id, fam1.fami_detalle, fam2.fami_id, fam2.fami_detalle
HAVING COUNT(DISTINCT f1.fact_numero) > 10
ORDER BY total_vendido DESC
