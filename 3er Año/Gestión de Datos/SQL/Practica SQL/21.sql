USE GD_UTN

SELECT 
	DISTINCT YEAR(fact_fecha) AS año,
	(
		SELECT COUNT(*) FROM Cliente c1
		WHERE c1.clie_codigo IN (
									SELECT DISTINCT c1.clie_codigo FROM Cliente c1
									JOIN Factura f2 ON c1.clie_codigo = f2.fact_cliente
									JOIN Item_Factura if2 ON f2.fact_numero = if2.item_numero
									WHERE YEAR(f1.fact_fecha) = YEAR(f2.fact_fecha)
									GROUP BY c1.clie_codigo, f2.fact_numero, f2.fact_total, f2.fact_total_impuestos
									HAVING ((f2.fact_total - f2.fact_total_impuestos)-SUM(if2.item_precio * if2.item_cantidad)) > 1
								)
	) AS clientes_mal_facturados,
	(
		SELECT COUNT(*) FROM Factura
		WHERE fact_numero IN (
									SELECT f2.fact_numero FROM Factura f2
									JOIN Item_Factura if1 ON f2.fact_numero = if1.item_numero
									WHERE YEAR(f1.fact_fecha) = YEAR(f2.fact_fecha)
									GROUP BY f2.fact_numero, f2.fact_total, f2.fact_total_impuestos
									HAVING ((f2.fact_total - f2.fact_total_impuestos)-SUM(if1.item_precio * if1.item_cantidad)) > 1
								)
	) AS facturas_mal_realizadas
FROM Factura f1