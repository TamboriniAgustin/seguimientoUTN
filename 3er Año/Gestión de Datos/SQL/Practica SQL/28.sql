USE GD_UTN

SELECT
	YEAR(f1.fact_fecha) AS año,
	e1.empl_codigo,
	CONCAT(e1.empl_nombre, ' ', e1.empl_apellido) AS empl_detalle,
	COUNT(DISTINCT f1.fact_numero) AS facturas_emitidas,
	COUNT(DISTINCT f1.fact_cliente) AS cantidad_clientes,
	(
		SELECT COUNT(DISTINCT p2.prod_codigo) FROM Producto p2
		JOIN Composicion c2 ON p2.prod_codigo = c2.comp_producto
		JOIN Item_Factura if2 ON p2.prod_codigo = if2.item_producto
		JOIN Factura f2 ON (if2.item_numero = f2.fact_numero) AND (YEAR(f2.fact_fecha) = YEAR(f1.fact_fecha))
	) AS productos_facturados_con_composicion,
	(
		SELECT COUNT(DISTINCT p2.prod_codigo) FROM Producto p2
		LEFT JOIN Composicion c2 ON p2.prod_codigo = c2.comp_producto
		JOIN Item_Factura if2 ON p2.prod_codigo = if2.item_producto
		JOIN Factura f2 ON (if2.item_numero = f2.fact_numero) AND (YEAR(f2.fact_fecha) = YEAR(f1.fact_fecha))
		WHERE c2.comp_cantidad IS NULL
	) AS productos_facturados_sin_composicion,
	(
		SELECT SUM(f2.fact_total + f2.fact_total_impuestos) FROM Factura f2
		WHERE (YEAR(f2.fact_fecha) = YEAR(f1.fact_fecha)) AND (f2.fact_vendedor = e1.empl_codigo)
	) AS monto_total_facturado
FROM Factura f1
JOIN Empleado e1 ON f1.fact_vendedor = e1.empl_codigo
GROUP BY YEAR(f1.fact_fecha), e1.empl_codigo, e1.empl_nombre, e1.empl_apellido
ORDER BY año, monto_total_facturado DESC