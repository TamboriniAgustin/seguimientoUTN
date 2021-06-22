USE GD_UTN

SELECT	
	DISTINCT YEAR(f1.fact_fecha) AS año,
	(
		SELECT TOP 1 p2.prod_familia FROM Factura f2
		JOIN Item_Factura if2 ON f2.fact_numero = if2.item_numero
		JOIN Producto p2 ON if2.item_producto = p2.prod_codigo
		WHERE YEAR(f2.fact_fecha) = YEAR(f1.fact_fecha)
		GROUP BY p2.prod_familia
		ORDER BY SUM(if2.item_cantidad) DESC
	) AS familia_mas_vendida,
	(
		SELECT COUNT(DISTINCT r2.rubr_id) FROM Rubro r2
		JOIN Producto p2 ON r2.rubr_id = p2.prod_rubro
		JOIN Familia f2 ON p2.prod_familia = f2.fami_id
		WHERE f2.fami_id = (
								SELECT TOP 1 p3.prod_familia FROM Factura f3
								JOIN Item_Factura if3 ON f3.fact_numero = if3.item_numero
								JOIN Producto p3 ON if3.item_producto = p3.prod_codigo
								WHERE YEAR(f3.fact_fecha) = YEAR(f1.fact_fecha)
								GROUP BY p3.prod_familia
								ORDER BY SUM(if3.item_cantidad) DESC
						   )
	) AS rubros_familia,
	(
		SELECT (CASE WHEN SUM(c2.comp_cantidad) > 0 THEN COUNT(*) ELSE 0 END) FROM Producto p2
		LEFT JOIN Composicion c2 ON p2.prod_codigo = c2.comp_producto
		WHERE p2.prod_codigo = (
									SELECT TOP 1 p3.prod_codigo FROM Producto p3
									JOIN Familia f3 ON p3.prod_familia = f3.fami_id
									JOIN Item_Factura if3 ON p3.prod_codigo = if3.item_producto
									JOIN Factura fc3 ON if3.item_numero = fc3.fact_numero
									WHERE f3.fami_id = (
															SELECT TOP 1 p4.prod_familia FROM Factura f4
															JOIN Item_Factura if4 ON f4.fact_numero = if4.item_numero
															JOIN Producto p4 ON if4.item_producto = p4.prod_codigo
															WHERE YEAR(f4.fact_fecha) = YEAR(f1.fact_fecha)
															GROUP BY p4.prod_familia
															ORDER BY SUM(if4.item_cantidad) DESC
													   )
									     AND
										 YEAR(fc3.fact_fecha) = YEAR(f1.fact_fecha)
									GROUP BY p3.prod_codigo
									ORDER BY COUNT(DISTINCT fc3.fact_numero) DESC
							   )
		GROUP BY p2.prod_codigo
	) AS productos_que_componen_al_mas_vendido_de_la_familia,
	(
		SELECT COUNT(DISTINCT fc2.fact_numero) FROM Factura fc2
		JOIN Item_Factura if2 ON fc2.fact_numero = if2.item_numero
		JOIN Producto p2 ON if2.item_producto = p2.prod_codigo
		WHERE (YEAR(fc2.fact_fecha) = YEAR(f1.fact_fecha)) AND p2.prod_familia = (
																					SELECT TOP 1 p3.prod_familia FROM Factura f3
																					JOIN Item_Factura if3 ON f3.fact_numero = if3.item_numero
																					JOIN Producto p3 ON if3.item_producto = p3.prod_codigo
																					WHERE YEAR(f3.fact_fecha) = YEAR(f1.fact_fecha)
																					GROUP BY p3.prod_familia
																					ORDER BY SUM(if3.item_cantidad) DESC
		                                                                         )
	) AS facturas_familia,
	(
		SELECT TOP 1 c2.clie_codigo FROM Cliente c2 
		JOIN Factura fc2 ON c2.clie_codigo = fc2.fact_cliente
		JOIN Item_Factura if2 ON fc2.fact_numero = if2.item_numero
		JOIN Producto p2 ON if2.item_producto = p2.prod_codigo
		WHERE (YEAR(fc2.fact_fecha) = YEAR(f1.fact_fecha)) AND p2.prod_familia = (
																					SELECT TOP 1 p3.prod_familia FROM Factura f3
																					JOIN Item_Factura if3 ON f3.fact_numero = if3.item_numero
																					JOIN Producto p3 ON if3.item_producto = p3.prod_codigo
																					WHERE YEAR(f3.fact_fecha) = YEAR(f1.fact_fecha)
																					GROUP BY p3.prod_familia
																					ORDER BY SUM(if3.item_cantidad) DESC
		                                                                         )
		GROUP BY c2.clie_codigo
		ORDER BY COUNT(fc2.fact_numero) DESC
	) AS mejor_cliente,
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
		WHERE p2.prod_familia = (
									SELECT TOP 1 p3.prod_familia FROM Factura f3
									JOIN Item_Factura if3 ON f3.fact_numero = if3.item_numero
									JOIN Producto p3 ON if3.item_producto = p3.prod_codigo
									WHERE YEAR(f3.fact_fecha) = YEAR(f1.fact_fecha)
									GROUP BY p3.prod_familia
									ORDER BY SUM(if3.item_cantidad) DESC
							   )
			 AND
			 YEAR(f1.fact_fecha) = YEAR(f2.fact_fecha)
		GROUP BY p2.prod_familia
	) AS porcentaje_ventas_familia_respecto_ventas_totales
FROM Factura f1
ORDER BY porcentaje_ventas_familia_respecto_ventas_totales DESC, familia_mas_vendida DESC