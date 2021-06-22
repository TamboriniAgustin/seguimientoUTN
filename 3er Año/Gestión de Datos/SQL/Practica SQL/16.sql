USE GD_UTN

SELECT 
	clie_codigo,
	(
		SELECT ISNULL(SUM(CASE WHEN c1.comp_componente IS NULL THEN if1.item_cantidad ELSE if1.item_cantidad * c1.comp_cantidad END), 0) FROM Factura 
		JOIN Item_Factura if1 ON Factura.fact_numero = if1.item_numero
		LEFT JOIN Composicion c1 ON if1.item_producto = c1.comp_producto
		WHERE fact_cliente = clie_codigo AND YEAR(fact_fecha) = 2012
	) AS productos_vendidos_2012,
	(
		SELECT TOP 1 if1.item_producto FROM Factura 
		JOIN Item_Factura if1 ON Factura.fact_numero = if1.item_numero
		LEFT JOIN Composicion c1 ON if1.item_producto = c1.comp_producto
		WHERE fact_cliente = clie_codigo AND YEAR(fact_fecha) = 2012
		ORDER BY if1.item_cantidad DESC, clie_codigo ASC
	) AS producto_mas_vendido_2012, COUNT(*)
FROM Cliente
JOIN Factura f1 ON Cliente.clie_codigo = f1.fact_cliente
GROUP BY clie_codigo, clie_domicilio
HAVING COUNT(*) < ((((
					SELECT TOP 1 COUNT(*) FROM Factura JOIN Item_Factura if1 ON Factura.fact_numero = if1.item_numero
					WHERE YEAR(fact_fecha) = 2012
					GROUP BY if1.item_producto
					ORDER BY COUNT(*) DESC
				  ) * 100) / (SELECT COUNT(*) FROM Factura WHERE YEAR(fact_fecha) = 2012)) / 3)
ORDER BY clie_domicilio ASC							