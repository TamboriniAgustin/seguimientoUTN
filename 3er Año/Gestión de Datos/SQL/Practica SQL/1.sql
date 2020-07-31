USE GD_UTN

SELECT clie_codigo, clie_razon_social FROM Cliente WHERE clie_limite_credito >= 1000 ORDER BY clie_codigo