USE GD_UTN

SELECT p1.prod_detalle, p1.prod_precio, SUM(componente.prod_precio * c1.comp_cantidad) AS precio_componentes FROM Producto p1
JOIN Composicion c1 ON p1.prod_codigo = c1.comp_producto
JOIN Producto componente ON c1.comp_componente = componente.prod_codigo
GROUP BY p1.prod_detalle, p1.prod_precio
HAVING COUNT(componente.prod_codigo) > 2
ORDER BY COUNT(componente.prod_codigo) DESC