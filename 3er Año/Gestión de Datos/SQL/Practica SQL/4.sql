USE GD_UTN

SELECT prod_codigo, prod_detalle, COUNT(DISTINCT c1.comp_cantidad) as articulos FROM Producto
	LEFT JOIN Composicion c1 ON Producto.prod_codigo = c1.comp_producto
	JOIN STOCK stk1 ON Producto.prod_codigo = stk1.stoc_producto
	GROUP BY prod_codigo, prod_detalle
	HAVING AVG(stk1.stoc_cantidad) > 100