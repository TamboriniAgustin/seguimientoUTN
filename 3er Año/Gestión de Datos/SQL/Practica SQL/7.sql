USE GD_UTN

SELECT prod_codigo, prod_detalle, MAX(if1.item_precio) AS precio_maximo_venta, MIN(if1.item_precio) AS precio_minimo_venta, STR(((MAX(if1.item_precio) - MIN(if1.item_precio)) / MIN(if1.item_precio)) * 100, 5, 2) AS porcentaje_diferencial FROM Producto
	LEFT JOIN STOCK stk1 ON Producto.prod_codigo = stk1.stoc_producto
	LEFT JOIN Item_Factura if1 ON Producto.prod_codigo = if1.item_producto
	GROUP BY prod_codigo, prod_detalle
	HAVING SUM(stoc_cantidad) > 0