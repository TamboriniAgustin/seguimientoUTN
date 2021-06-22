USE GD_UTN

SELECT 
	prod_detalle, 
	COUNT(DISTINCT c1.clie_codigo) AS clientes_que_compraron,
	AVG(if1.item_cantidad * if1.item_precio) AS importe_promedio_pagado,
	(SELECT COUNT(DISTINCT stoc_deposito) FROM STOCK WHERE (stoc_producto = p1.prod_codigo) AND (stoc_cantidad > 0)) AS depositos_con_stock,
	(SELECT SUM(stoc_cantidad) FROM STOCK WHERE (stoc_producto = p1.prod_codigo)) AS stock_actual
FROM Producto p1
JOIN Item_Factura if1 ON p1.prod_codigo = if1.item_producto
JOIN Factura f1 ON if1.item_numero = f1.fact_numero
JOIN Cliente c1 ON f1.fact_cliente = c1.clie_codigo
WHERE p1.prod_codigo IN (
							SELECT if2.item_producto FROM Item_Factura if2 
							JOIN Factura f2 ON if2.item_numero = f2.fact_numero 
							WHERE YEAR(f2.fact_fecha) = 2012
						)
GROUP BY p1.prod_codigo, p1.prod_detalle
ORDER BY SUM(if1.item_cantidad * if1.item_precio) DESC