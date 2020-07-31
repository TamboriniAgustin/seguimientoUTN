USE GD_UTN

SELECT prod_codigo, prod_detalle FROM Producto
JOIN Item_Factura if1 ON Producto.prod_codigo = if1.item_producto
JOIN Factura f1 ON if1.item_numero = f1.fact_numero
WHERE YEAR(f1.fact_fecha) = 2012
GROUP BY prod_codigo, prod_detalle
ORDER BY SUM(if1.item_cantidad)