USE GD_UTN

SELECT 
	em1.empl_codigo,
	CONCAT(em1.empl_nombre, ' ', em1.empl_apellido) AS empl_nombre_apellido,
	YEAR(em1.empl_ingreso) AS empl_año_ingreso,
	ISNULL(CASE WHEN (COUNT(*) > 50)
				THEN (
						SELECT COUNT(*) FROM Empleado em2 
						LEFT JOIN Factura f2 ON em2.empl_codigo = f2.fact_vendedor 
						WHERE em1.empl_codigo = em2.empl_codigo AND YEAR(f2.fact_fecha) = 2011 AND f2.fact_total > 100
						GROUP BY em2.empl_codigo
					 )
				ELSE (
						SELECT COUNT(*) FROM Empleado em3
						JOIN Empleado em4 ON em3.empl_codigo = em4.empl_jefe
						LEFT JOIN Factura f3 ON em4.empl_codigo = f3.fact_vendedor 
						WHERE em1.empl_codigo = em3.empl_codigo AND YEAR(f3.fact_fecha) = 2011
						GROUP BY em4.empl_codigo
				     )
			END, 
	0) AS puntaje_2011,
	ISNULL(CASE WHEN (COUNT(*) > 50)
				THEN (
						SELECT COUNT(*) FROM Empleado em2 
						LEFT JOIN Factura f2 ON em2.empl_codigo = f2.fact_vendedor 
						WHERE em1.empl_codigo = em2.empl_codigo AND YEAR(f2.fact_fecha) = 2012 AND f2.fact_total > 100
						GROUP BY em2.empl_codigo
					 )
				ELSE (
						SELECT COUNT(*) FROM Empleado em3
						JOIN Empleado em4 ON em3.empl_codigo = em4.empl_jefe
						LEFT JOIN Factura f3 ON em4.empl_codigo = f3.fact_vendedor 
						WHERE em1.empl_codigo = em3.empl_codigo AND YEAR(f3.fact_fecha) = 2012
						GROUP BY em4.empl_codigo
				     )
			END, 
	0) AS puntaje_2012
FROM Empleado em1
LEFT JOIN Factura f1 ON em1.empl_codigo = f1.fact_vendedor
GROUP BY em1.empl_codigo, em1.empl_nombre, em1.empl_apellido, em1.empl_ingreso