USE GD_UTN

SELECT 
	c1.clie_codigo,
	(
		SELECT ISNULL(COUNT(*), 0) FROM Factura 
		WHERE (fact_cliente = c1.clie_codigo) AND (YEAR(fact_fecha) = (SELECT MAX(YEAR(fact_fecha)) FROM Factura))
	) AS compras_ultimo_año,
	(
		SELECT ISNULL(AVG(fact_total + fact_total_impuestos), 0) FROM Factura 
		WHERE (fact_cliente = c1.clie_codigo) AND (YEAR(fact_fecha) = (SELECT MAX(YEAR(fact_fecha)) FROM Factura))
	) AS promedio_compra_ultimo_año,
	(
		SELECT ISNULL(COUNT(DISTINCT item_producto), 0) FROM Factura
		JOIN Item_Factura on Factura.fact_numero = Item_Factura.item_numero
		WHERE (fact_cliente = c1.clie_codigo) AND (YEAR(fact_fecha) = (SELECT MAX(YEAR(fact_fecha)) FROM Factura))
	) AS productos_diferentes_ultimo_año,
	(
		SELECT ISNULL(MAX(fact_total + fact_total_impuestos), 0) FROM Factura 
		WHERE (fact_cliente = c1.clie_codigo) AND (YEAR(fact_fecha) = (SELECT MAX(YEAR(fact_fecha)) FROM Factura))
	) AS mayor_compra_ultimo_año
FROM Cliente c1
ORDER BY compras_ultimo_año DESC