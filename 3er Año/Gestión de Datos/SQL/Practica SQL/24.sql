SELECT p1.prod_codigo, p1.prod_detalle, SUM(if1.item_cantidad) AS unidades_facturadas FROM Producto p1
JOIN Composicion c1 ON p1.prod_codigo = c1.comp_producto
JOIN Item_Factura if1 ON p1.prod_codigo = if1.item_producto
JOIN Factura f1 ON if1.item_numero = f1.fact_numero
WHERE f1.fact_vendedor IN (
							SELECT TOP 2 em2.empl_codigo FROM Empleado em2
							ORDER BY em2.empl_comision DESC
						  )
GROUP BY p1.prod_codigo, p1.prod_detalle
HAVING COUNT(f1.fact_numero) > 5
ORDER BY unidades_facturadas DESC