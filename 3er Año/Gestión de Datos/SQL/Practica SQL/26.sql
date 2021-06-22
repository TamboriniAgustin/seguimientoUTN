USE GD_UTN

SELECT 
	CONCAT(e1.empl_nombre, ' ', e1.empl_apellido) AS empleado,
	COUNT(d1.depo_codigo) AS depositos_a_cargo,
	ISNULL(SUM(f1.fact_total + f1.fact_total_impuestos), 0) AS monto_total_facturado_2012,
	ISNULL((SELECT TOP 1 c2.clie_codigo FROM Cliente c2
		    JOIN Factura f2 ON c2.clie_codigo = f2.fact_cliente
		    WHERE (f2.fact_vendedor = e1.empl_codigo) AND (YEAR(f2.fact_fecha) = 2012)
		    GROUP BY c2.clie_codigo
		    ORDER BY COUNT(*) DESC), 
		   '-NO-') AS mejor_cliente,
	ISNULL((SELECT TOP 1 p2.prod_codigo FROM Producto p2
		    JOIN Item_Factura if2 ON p2.prod_codigo = if2.item_producto
			JOIN Factura f2 ON if2.item_numero = f2.fact_numero
		    WHERE (f2.fact_vendedor = e1.empl_codigo) AND (YEAR(f2.fact_fecha) = 2012)
		    GROUP BY p2.prod_codigo
		    ORDER BY SUM(if2.item_cantidad) DESC), 
		   '-NO-') AS producto_mas_vendido,
	ISNULL((SELECT ((COUNT(*) * 100) / (SELECT COUNT(*) FROM Factura f3 WHERE YEAR(f3.fact_fecha) = 2012))
            FROM Factura f2
	        WHERE (f2.fact_vendedor = e1.empl_codigo) AND (YEAR(f2.fact_fecha) = 2012))
			, 0) AS porcentaje_ventas_2012
FROM Empleado e1
LEFT JOIN DEPOSITO d1 ON e1.empl_codigo = d1.depo_encargado
LEFT JOIN Factura f1 ON (e1.empl_codigo = f1.fact_vendedor) AND (YEAR(f1.fact_fecha) = 2012)
GROUP BY e1.empl_codigo, e1.empl_nombre, e1.empl_apellido
ORDER BY porcentaje_ventas_2012 DESC