USE GD_UTN

-- Elimino los elementos si ya existían previamente --
GO
	IF EXISTS (SELECT name FROM sysobjects WHERE name='FACTURAS_ADQUIRIDAS')
		DROP FUNCTION FACTURAS_ADQUIRIDAS
	IF EXISTS (SELECT name FROM sysobjects WHERE name='VENDEDOR_FAVORITO')
		DROP FUNCTION VENDEDOR_FAVORITO
	IF EXISTS (SELECT name FROM sysobjects WHERE name='REASIGNAR_VENDEDORES_CLIENTE')
		DROP PROCEDURE REASIGNAR_VENDEDORES_CLIENTE
GO

-- Creo una función que me dice las facturas que adquirió un cliente --
GO
	CREATE FUNCTION FACTURAS_ADQUIRIDAS (@cliente char(6))
	RETURNS INT
	AS
	BEGIN
		DECLARE @valor_retorno tinyint

		SET @valor_retorno = (SELECT COUNT(*) FROM Factura WHERE fact_cliente = @cliente)

		RETURN @valor_retorno
	END
GO

-- Creo una función que me dice cual es el vendedor favorito de un cliente --
GO
	CREATE FUNCTION VENDEDOR_FAVORITO (@cliente char(6))
	RETURNS numeric(6, 0)
	AS
	BEGIN
		DECLARE @vendedor numeric(6, 0)
		-- Si el cliente compró alguna vez selecciono al vendedor que más le ha vendido --
		IF(dbo.FACTURAS_ADQUIRIDAS(@cliente) > 0)
			BEGIN
				SET @vendedor = (SELECT TOP 1 fact_vendedor FROM Factura WHERE (fact_cliente = @cliente) GROUP BY fact_vendedor ORDER BY COUNT(DISTINCT fact_numero) DESC)
			END
		-- Si el cliente no compró anteriormente selecciono al vendedor con mayor cantidad de ventas realizadas --
		ELSE
			BEGIN
				SET @vendedor = (SELECT TOP 1 fact_vendedor FROM Factura GROUP BY fact_vendedor ORDER BY SUM(fact_total + fact_total_impuestos) DESC)
			END

		RETURN @vendedor
	END
GO

-- Creo el procedimiento para reasignar a los vendedores de los clientes --
GO
	CREATE PROCEDURE REASIGNAR_VENDEDORES_CLIENTE
	AS
	BEGIN
		-- Declaro las variables de utilidad a la hora de recorrer los depósitos actuales --
		DECLARE @codigo_cliente char(6)
		DECLARE @vendedor_cliente numeric(6, 0)
		-- Declaro un cursor para recorrer la tabla de clientes --
		DECLARE CURSOR_CLIENTE CURSOR FOR (SELECT clie_codigo, clie_vendedor FROM Cliente)
		OPEN CURSOR_CLIENTE
		FETCH NEXT FROM CURSOR_CLIENTE INTO @codigo_cliente, @vendedor_cliente
		WHILE(@@FETCH_STATUS = 0)
			BEGIN
				-- Obtengo al nuevo vendedor del cliente --
				DECLARE @nuevo_vendedor numeric(6, 0)
				SET @nuevo_vendedor = dbo.VENDEDOR_FAVORITO(@codigo_cliente)
				-- Reasigno el vendedor del cliente en caso de que no sea el favorito --
				IF((@vendedor_cliente != @nuevo_vendedor) OR (@vendedor_cliente IS NULL))
					BEGIN
						UPDATE Cliente SET clie_vendedor = @nuevo_vendedor WHERE clie_codigo = @codigo_cliente
						PRINT CONCAT('El cliente ', @codigo_cliente, ' ha cambiado al vendedor ', @vendedor_cliente, ' por el nuevo vendedor ', @nuevo_vendedor)
					END
				-- Paso al siguiente cursor --
				FETCH NEXT FROM CURSOR_CLIENTE INTO @codigo_cliente, @vendedor_cliente
			END
		CLOSE CURSOR_CLIENTE
		DEALLOCATE CURSOR_CLIENTE
	END
GO