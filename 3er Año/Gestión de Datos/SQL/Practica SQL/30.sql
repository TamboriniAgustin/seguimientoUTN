USE GD_UTN

SELECT  
	CONCAT(j1.empl_nombre, ' ', j1.empl_apellido) AS nombre_jefe,
	COUNT(DISTINCT e1.empl_codigo) AS empleados,
	SUM(f1.fact_total + f1.fact_total_impuestos) AS ventas_empleados,
	COUNT(DISTINCT f1.fact_numero) AS facturas_empleados,
	(
		SELECT TOP 1 e2.empl_codigo FROM Empleado e2
		JOIN Factura f2 ON e2.empl_codigo = f2.fact_vendedor
		WHERE e2.empl_jefe = j1.empl_codigo
		GROUP BY e2.empl_codigo
		ORDER BY COUNT(DISTINCT f2.fact_numero) DESC
	) AS mejor_empleado
FROM Empleado j1
LEFT JOIN Empleado e1 ON j1.empl_codigo = e1.empl_jefe
LEFT JOIN Factura f1 ON e1.empl_codigo = f1.fact_vendedor
WHERE (j1.empl_codigo IN (SELECT e2.empl_jefe FROM Empleado e2)) AND (YEAR(f1.fact_fecha) = 2012)
GROUP BY j1.empl_codigo, j1.empl_nombre, j1.empl_apellido
HAVING COUNT(DISTINCT f1.fact_numero) > 10
ORDER BY ventas_empleados DESC