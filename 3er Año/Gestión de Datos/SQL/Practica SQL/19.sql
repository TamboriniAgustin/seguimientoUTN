USE GD_UTN

SELECT 
	p1.prod_codigo, 
	p1.prod_detalle, 
	p1.prod_familia, 
	fam1.fami_detalle,
	(
		SELECT TOP 1 fami_id FROM Familia
		JOIN Producto p2 ON Familia.fami_id = p2.prod_familia
		WHERE (SUBSTRING(p2.prod_detalle, 0, 6) = SUBSTRING(p1.prod_detalle, 0, 6))
		GROUP BY fami_id
		ORDER BY COUNT(*) DESC, fami_id ASC
	) AS codigo_familia_recomendada,
	(
		SELECT TOP 1 fami_detalle FROM Familia
		JOIN Producto p2 ON Familia.fami_id = p2.prod_familia
		WHERE (SUBSTRING(p2.prod_detalle, 0, 6) = SUBSTRING(p1.prod_detalle, 0, 6))
		GROUP BY fami_id, fami_detalle
		ORDER BY COUNT(*) DESC, fami_id ASC
	) AS detalle_familia_recomendada
FROM Producto p1
LEFT JOIN Familia fam1 ON p1.prod_familia = fam1.fami_id
WHERE p1.prod_familia != (
							SELECT TOP 1 fami_id FROM Familia
							JOIN Producto p2 ON Familia.fami_id = p2.prod_familia
							WHERE (SUBSTRING(p2.prod_detalle, 0, 6) = SUBSTRING(p1.prod_detalle, 0, 6))
							GROUP BY fami_id
							ORDER BY COUNT(*) DESC, fami_id ASC
						 )
GROUP BY p1.prod_codigo, p1.prod_detalle, p1.prod_familia, fam1.fami_detalle
ORDER BY p1.prod_detalle ASC