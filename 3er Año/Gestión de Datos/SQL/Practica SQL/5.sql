USE GD_UTN

SELECT prod_codigo, prod_detalle, SUM(if1.item_cantidad) as vendidos FROM Producto
JOIN Item_Factura if1 ON Producto.prod_codigo = if1.item_producto
JOIN Factura f1 ON if1.item_numero = f1.fact_numero
WHERE YEAR(f1.fact_fecha) = 2012
GROUP BY prod_codigo, prod_detalle
HAVING SUM(if1.item_cantidad) > (
									SELECT SUM(if2.item_cantidad) FROM Item_Factura if2 
									JOIN Factura f2 ON if2.item_numero = f2.fact_numero 
									WHERE YEAR(f2.fact_fecha) = 2011 AND prod_codigo = if2.item_producto 
									GROUP BY if2.item_producto
								)