USE GD_UTN

SELECT 
	DISTINCT YEAR(f1.fact_fecha) AS año,
	(
		SELECT TOP 1 p2.prod_codigo FROM Producto p2
		JOIN Composicion cp2 ON p2.prod_codigo = cp2.comp_producto
		JOIN Item_Factura if2 ON p2.prod_codigo = if2.item_producto
		JOIN Factura f2 ON if2.item_numero = f2.fact_numero
		WHERE YEAR(f2.fact_fecha) = YEAR(f1.fact_fecha)
		GROUP BY p2.prod_codigo
		ORDER BY SUM(if2.item_cantidad) DESC
	) AS producto_compuesto_mas_vendido,
	(
		SELECT COUNT(*) FROM Producto p2
		JOIN Composicion cp2 ON p2.prod_codigo = cp2.comp_producto
		WHERE p2.prod_codigo = (
									SELECT TOP 1 p3.prod_codigo FROM Producto p3
									JOIN Composicion cp3 ON p3.prod_codigo = cp3.comp_producto
									JOIN Item_Factura if3 ON p3.prod_codigo = if3.item_producto
									JOIN Factura f3 ON if3.item_numero = f3.fact_numero
									WHERE YEAR(f3.fact_fecha) = YEAR(f1.fact_fecha)
									GROUP BY p3.prod_codigo
									ORDER BY SUM(if3.item_cantidad) DESC
							   )
	) AS productos_que_lo_componen_directamente,
	(
		SELECT COUNT(*) FROM Producto p2
		JOIN Item_Factura if2 ON p2.prod_codigo = if2.item_producto
		JOIN Factura f2 ON if2.item_numero = f2.fact_numero
		WHERE p2.prod_codigo = (
									SELECT TOP 1 p3.prod_codigo FROM Producto p3
									JOIN Composicion cp3 ON p3.prod_codigo = cp3.comp_producto
									JOIN Item_Factura if3 ON p3.prod_codigo = if3.item_producto
									JOIN Factura f3 ON if3.item_numero = f3.fact_numero
									WHERE YEAR(f3.fact_fecha) = YEAR(f1.fact_fecha)
									GROUP BY p3.prod_codigo
									ORDER BY SUM(if3.item_cantidad) DESC
							   )
			 AND
			 YEAR(f1.fact_fecha) = YEAR(f2.fact_fecha)
	) AS veces_facturado,
	(
		SELECT TOP 1 c2.clie_codigo FROM Cliente c2
		JOIN Factura f2 ON c2.clie_codigo = f2.fact_cliente
		JOIN Item_Factura if2 ON f2.fact_numero = if2.item_numero
		WHERE if2.item_producto = (
									SELECT TOP 1 p3.prod_codigo FROM Producto p3
									JOIN Composicion cp3 ON p3.prod_codigo = cp3.comp_producto
									JOIN Item_Factura if3 ON p3.prod_codigo = if3.item_producto
									JOIN Factura f3 ON if3.item_numero = f3.fact_numero
									WHERE YEAR(f3.fact_fecha) = YEAR(f1.fact_fecha)
									GROUP BY p3.prod_codigo
									ORDER BY SUM(if3.item_cantidad) DESC
								   )
			   AND
			   YEAR(f1.fact_fecha) = YEAR(f2.fact_fecha)
		GROUP BY c2.clie_codigo, if2.item_producto
		ORDER BY COUNT(*) DESC
	) AS mayor_cliente,
	(
		SELECT 
			((SUM(if2.item_cantidad) / (
										SELECT SUM(if3.item_cantidad) FROM Item_Factura if3
										JOIN Factura f3 ON if3.item_numero = f3.fact_numero
										WHERE YEAR(f3.fact_fecha) = YEAR(f3.fact_fecha)
									  )
			) * 100) 
		FROM Producto p2
		JOIN Item_Factura if2 ON p2.prod_codigo = if2.item_producto
		JOIN Factura f2 ON if2.item_numero = f2.fact_numero
		WHERE p2.prod_codigo = (
									SELECT TOP 1 p3.prod_codigo FROM Producto p3
									JOIN Composicion cp3 ON p3.prod_codigo = cp3.comp_producto
									JOIN Item_Factura if3 ON p3.prod_codigo = if3.item_producto
									JOIN Factura f3 ON if3.item_numero = f3.fact_numero
									WHERE YEAR(f3.fact_fecha) = YEAR(f1.fact_fecha)
									GROUP BY p3.prod_codigo
									ORDER BY SUM(if3.item_cantidad) DESC
							   )
			 AND
			 YEAR(f1.fact_fecha) = YEAR(f2.fact_fecha)
		GROUP BY p2.prod_codigo
	) AS porcentaje_producto_sobre_ventas_totales
FROM Factura f1
ORDER BY porcentaje_producto_sobre_ventas_totales DESC