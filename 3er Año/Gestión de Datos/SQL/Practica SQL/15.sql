USE GD_UTN

SELECT 
	p1.prod_codigo AS PROD1,
	p1.prod_detalle AS DETALLE1,
	p2.prod_codigo AS PROD2,
	p2.prod_detalle AS DETALLE2,
	COUNT(*) AS VECES
FROM (Producto p1 JOIN Item_Factura if1 ON if1.item_producto=p1.prod_codigo)
JOIN (Producto p2 JOIN Item_Factura if2 ON if2.item_producto=p2.prod_codigo) ON (p1.prod_codigo != p2.prod_codigo) AND (if1.item_numero = if2.item_numero)
GROUP BY p1.prod_codigo, p1.prod_detalle, p2.prod_codigo, p2.prod_detalle
HAVING COUNT(*) > 500
ORDER BY VECES DESC