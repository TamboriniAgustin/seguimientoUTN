USE GD_UTN

SELECT  
	DISTINCT YEAR(fact_fecha) AS año,
	e1.empl_codigo,
	CONCAT(e1.empl_nombre, ' ', e1.empl_apellido) AS empl_detalle,
	COUNT(DISTINCT f1.fact_numero) AS ventas,
	COUNT(DISTINCT f1.fact_cliente) AS cantidad_clientes,
	(
		SELECT COUNT(*) FROM Item_Factura if2
		JOIN Factura f2 ON if2.item_numero = f2.fact_numero
		WHERE (f2.fact_vendedor = e1.empl_codigo) AND (YEAR(f2.fact_fecha) = YEAR(f1.fact_fecha)) 
												  AND if2.item_producto IN (
																				SELECT prod_codigo FROM Producto p3
																				JOIN Composicion c3 ON p3.prod_codigo = c3.comp_producto
																				GROUP BY p3.prod_codigo
																		   )
	) AS productos_compuestos_vendidos,
	(
		SELECT COUNT(*) FROM Item_Factura if2
		JOIN Factura f2 ON if2.item_numero = f2.fact_numero
		WHERE (f2.fact_vendedor = e1.empl_codigo) AND (YEAR(f2.fact_fecha) = YEAR(f1.fact_fecha)) 
												  AND if2.item_producto NOT IN (
																					SELECT prod_codigo FROM Producto p3
																					JOIN Composicion c3 ON p3.prod_codigo = c3.comp_producto
																					GROUP BY p3.prod_codigo
																			    )
	) AS productos_no_compuestos_vendidos,
	COUNT(DISTINCT if1.item_producto) AS productos_distintos_vendidos,
	SUM(f1.fact_total + f1.fact_total_impuestos) AS monto_total_vendido
FROM Factura f1
JOIN Empleado e1 ON f1.fact_vendedor = e1.empl_codigo
JOIN Item_Factura if1 ON f1.fact_numero = if1.item_numero
GROUP BY YEAR(f1.fact_fecha), e1.empl_codigo, e1.empl_nombre, e1.empl_apellido
ORDER BY YEAR(f1.fact_fecha), productos_distintos_vendidos DESC