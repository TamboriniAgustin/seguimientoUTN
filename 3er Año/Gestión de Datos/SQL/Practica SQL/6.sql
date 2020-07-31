USE GD_UTN

SELECT rubr_id, rubr_detalle, COUNT(DISTINCT p1.prod_detalle) as cantidad_productos, SUM(stk1.stoc_cantidad) as stock FROM Rubro
	LEFT JOIN Producto p1 ON Rubro.rubr_id = p1.prod_rubro
	LEFT JOIN STOCK stk1 ON p1.prod_codigo = stk1.stoc_producto
	GROUP BY rubr_id, rubr_detalle
	HAVING SUM(stk1.stoc_cantidad) > (
										SELECT SUM(stk2.stoc_cantidad) AS stock FROM Producto
										JOIN STOCK stk2 ON Producto.prod_codigo = stk2.stoc_producto
										WHERE prod_codigo = '00000000' AND stk2.stoc_deposito = 00
										GROUP BY prod_codigo, stk2.stoc_deposito
									 )