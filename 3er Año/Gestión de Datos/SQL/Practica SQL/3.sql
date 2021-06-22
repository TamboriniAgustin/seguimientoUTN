USE GD_UTN

SELECT prod_codigo, prod_detalle, SUM(stk1.stoc_cantidad) as stock_total FROM Producto
	JOIN STOCK stk1 ON Producto.prod_codigo = stk1.stoc_producto
	GROUP BY prod_codigo, prod_detalle
	ORDER BY prod_detalle ASC