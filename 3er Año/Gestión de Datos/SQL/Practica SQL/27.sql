USE GD_UTN

SELECT  
	DISTINCT YEAR(f1.fact_fecha) AS año,
	e1.enva_codigo,
	e1.enva_detalle,
	(
		SELECT COUNT(*) FROM Producto p2
		WHERE (p2.prod_envase = e1.enva_codigo)
	) AS productos_con_envase,
	(
		SELECT COUNT(*) FROM Producto p2
		JOIN Item_Factura if2 ON p2.prod_codigo = if2.item_producto
		JOIN Factura f2 ON if2.item_numero = f2.fact_numero
		WHERE (p2.prod_envase = e1.enva_codigo) AND (YEAR(f2.fact_fecha) = YEAR(f1.fact_fecha))
	) AS productos_facturados_con_envase,
	(
		SELECT TOP 1 p2.prod_codigo FROM Producto p2
		JOIN Item_Factura if2 ON p2.prod_codigo = if2.item_producto
		JOIN Factura f2 ON if2.item_numero = f2.fact_numero
		WHERE (p2.prod_envase = e1.enva_codigo) AND (YEAR(f2.fact_fecha) = YEAR(f1.fact_fecha))
		GROUP BY p2.prod_codigo
		ORDER BY SUM(if2.item_cantidad) DESC
	) AS productos_con_envase_mas_vendido,
	(
		SELECT SUM(f2.fact_total + f2.fact_total_impuestos) FROM Producto p2
		JOIN Item_Factura if2 ON p2.prod_codigo = if2.item_producto
		JOIN Factura f2 ON if2.item_numero = f2.fact_numero
		WHERE (p2.prod_envase = e1.enva_codigo) AND (YEAR(f2.fact_fecha) = YEAR(f1.fact_fecha))
		GROUP BY p2.prod_envase
	) AS monto_total_vendido_con_envase,
	(
		SELECT ((COUNT(DISTINCT f2.fact_numero) * 100) / (SELECT COUNT(*) FROM Factura f3 WHERE YEAR(f3.fact_fecha) = YEAR(f1.fact_fecha))) FROM Factura f2
		JOIN Item_Factura if2 ON f2.fact_numero = if2.item_numero
		JOIN Producto p2 ON if2.item_producto = p2.prod_codigo
		WHERE (p2.prod_envase = e1.enva_codigo) AND (YEAR(f2.fact_fecha) = YEAR(f1.fact_fecha))
	) AS porcentaje_ventas_envase
FROM Factura f1
JOIN Item_Factura if1 ON f1.fact_numero = if1.item_numero
JOIN Producto p1 ON p1.prod_codigo = if1.item_producto
JOIN Envases e1 ON p1.prod_envase = e1.enva_codigo
GROUP BY YEAR(f1.fact_fecha), e1.enva_codigo, e1.enva_detalle
ORDER BY YEAR(f1.fact_fecha), porcentaje_ventas_envase DESC