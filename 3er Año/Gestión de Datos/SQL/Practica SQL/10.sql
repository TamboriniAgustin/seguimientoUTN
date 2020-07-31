USE GD_UTN

SELECT 
	prod_codigo,
	(
		SELECT TOP 1 fact_cliente FROM Item_Factura
		JOIN Factura ON Item_Factura.item_numero = Factura.fact_numero
		WHERE item_producto = prod_codigo
		GROUP BY fact_cliente
		ORDER BY SUM(item_cantidad) DESC
	) AS cliente_que_mas_compro

FROM Producto	
	WHERE prod_codigo IN (
							SELECT TOP 10 prod_codigo FROM Producto
							JOIN Item_Factura if2 ON Producto.prod_codigo = if2.item_producto
							GROUP BY prod_codigo
							ORDER BY SUM(if2.item_cantidad) DESC
						 )
		OR 
		  prod_codigo IN (
							SELECT TOP 10 prod_codigo FROM Producto
							JOIN Item_Factura if2 ON Producto.prod_codigo = if2.item_producto
							GROUP BY prod_codigo
							ORDER BY SUM(if2.item_cantidad) ASC
						 )