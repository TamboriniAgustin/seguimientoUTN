USE GD_UTN

-- Elimino la funci�n si ya exist�a previamente --
IF EXISTS (SELECT name FROM sysobjects WHERE name='ESTADODEPOSITO')
	DROP FUNCTION ESTADODEPOSITO

-- Creo la funci�n --
GO
CREATE FUNCTION ESTADODEPOSITO (@producto char(8), @deposito char(2))
RETURNS CHAR(60)
BEGIN 
	-- Tomo los datos que voy a necesitar para realizar la comparaci�n --
	DECLARE @cantidad numeric(12,2)
	DECLARE @maximo numeric(12,2)
	SELECT @cantidad = stoc_cantidad, @maximo = stoc_stock_maximo FROM STOCK
	WHERE stoc_producto = @producto AND stoc_deposito = @deposito
	-- Realizo la comparaci�n --
	DECLARE @retorno char(60)
	IF(@cantidad > @maximo) 
		SET @retorno = 'DEPOSITO COMPLETO'
	ELSE 
		SET @retorno = CONCAT('OCUPACION DEL DEPOSITO ', @deposito, ':', ISNULL(STR(((@cantidad/@maximo)*100), 12, 2), 0), '%')
	-- Retorno el valor solicitado --
	RETURN @retorno
END
GO

-- Pruebo la funci�n --
SELECT dbo.ESTADODEPOSITO(stoc_producto, stoc_deposito) AS estado_deposito FROM STOCK