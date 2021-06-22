USE GD_UTN

SELECT prod_detalle, MAX(stk1.stoc_cantidad) AS maximo_stock FROM Producto
	JOIN STOCK stk1 ON Producto.prod_codigo = stk1.stoc_producto
	WHERE stk1.stoc_cantidad > 0
	GROUP BY prod_detalle