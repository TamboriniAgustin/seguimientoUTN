USE GD_UTN

-- Elimino la función si ya existía previamente --
IF EXISTS (SELECT name FROM sysobjects WHERE name='STOCKHASTAFECHA')
	DROP FUNCTION STOCKHASTAFECHA

-- Creo la función --
GO
CREATE FUNCTION STOCKHASTAFECHA (@producto char(8), @fecha smalldatetime)
RETURNS numeric(12,2)
BEGIN 
	-- Tomo los datos que voy a necesitar para realizar la comparación --
	DECLARE @unidades_vendidas numeric(12,2)
	SELECT @unidades_vendidas = SUM(CASE WHEN @producto = item_producto THEN if1.item_cantidad
								    ELSE CASE WHEN @producto = c1.comp_componente THEN if1.item_cantidad * c1.comp_cantidad
								    ELSE CASE WHEN @producto = c2.comp_componente THEN if1.item_cantidad * c1.comp_cantidad * c2.comp_cantidad 
									END END END)
	FROM Item_Factura if1 
	JOIN Factura f1 ON if1.item_numero = f1.fact_numero
	LEFT JOIN Composicion c1 ON c1.comp_componente = if1.item_producto
	LEFT JOIN Composicion c2 ON c2.comp_componente = c1.comp_producto
	WHERE (f1.fact_fecha <= @fecha) AND (@producto IN (if1.item_producto, c1.comp_componente, c2.comp_componente))
	GROUP BY if1.item_producto

	DECLARE @stock_total numeric(12,2)
	SELECT @stock_total = stk1.stoc_cantidad FROM STOCK stk1
	WHERE stk1.stoc_producto = @producto

	-- Realizo la operación --
	DECLARE @retorno numeric(12,2)
	SET @retorno = @stock_total + @unidades_vendidas

	IF @retorno < 0
		SET @retorno = 0

	RETURN @retorno
END
GO

-- Pruebo la función --
SELECT dbo.STOCKHASTAFECHA(stoc_producto, f1.fact_fecha) AS estado_deposito FROM STOCK stk1
JOIN Item_Factura if1 ON stk1.stoc_producto = if1.item_producto
JOIN Factura f1 ON if1.item_numero = f1.fact_numero
GROUP BY stk1.stoc_producto, f1.fact_fecha