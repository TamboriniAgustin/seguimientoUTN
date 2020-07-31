USE GD_UTN

-- Elimino los elementos si ya existían previamente --
GO
	IF EXISTS (SELECT name FROM sysobjects WHERE name='PRODUCTOS_VENDIDOS_X_MES')
		DROP FUNCTION PRODUCTOS_VENDIDOS_X_MES
	IF EXISTS (SELECT name FROM sysobjects WHERE name='TOTAL_VENDIDO_X_MES')
		DROP FUNCTION TOTAL_VENDIDO_X_MES
	IF EXISTS (SELECT name FROM sysobjects WHERE name='TRIGGER_NUEVA_FACTURA')
		DROP TRIGGER TRIGGER_NUEVA_FACTURA
GO

-- Creo una función que dada una factura me devuelva los productos distintos vendidos en el mes para un vendedor --
GO
	CREATE FUNCTION PRODUCTOS_VENDIDOS_X_MES (@vendedor numeric(6, 0), @fecha smalldatetime)
	RETURNS INT
	AS
	BEGIN
		DECLARE @valor_retorno int

		SELECT @valor_retorno = COUNT(DISTINCT item_producto) FROM Factura 
		JOIN Item_Factura ON Factura.fact_numero = Item_Factura.item_numero
		WHERE (fact_vendedor = @vendedor) AND (YEAR(fact_fecha) = YEAR(@fecha)) AND (MONTH(fact_fecha) = MONTH(@fecha))

		RETURN @valor_retorno 
	END
GO

-- Creo una función que devuelva el total vendido por un vendedor al mes --
GO
	CREATE FUNCTION TOTAL_VENDIDO_X_MES (@vendedor numeric(6, 0), @fecha smalldatetime)
	RETURNS DECIMAL(12, 2)
	AS
	BEGIN
		DECLARE @valor_retorno decimal(12, 2)

		SELECT @valor_retorno = SUM(fact_total + fact_total_impuestos) FROM Factura 
		WHERE (fact_vendedor = @vendedor) AND (YEAR(fact_fecha) = YEAR(@fecha)) AND (MONTH(fact_fecha) = MONTH(@fecha))

		RETURN @valor_retorno 
	END
GO

-- Creo el trigger requerido para resolver el ejercicio --
GO
	CREATE TRIGGER TRIGGER_NUEVA_FACTURA ON Factura FOR INSERT
	AS
	BEGIN
		DECLARE @codigo_empleado numeric(6, 0)
		DECLARE @total_vendido_mes decimal(12, 2)
		DECLARE @productos_distintos_vendidos_mes int
		DECLARE @nueva_comision decimal(12, 2)
		
		SELECT @codigo_empleado = fact_vendedor, @total_vendido_mes = dbo.TOTAL_VENDIDO_X_MES(fact_vendedor, fact_fecha), @productos_distintos_vendidos_mes = dbo.PRODUCTOS_VENDIDOS_X_MES(fact_vendedor, fact_fecha) FROM inserted
	
		SET @nueva_comision = (@total_vendido_mes * 0.05)
		IF(@productos_distintos_vendidos_mes >= 50)
			BEGIN
				SET @nueva_comision = @nueva_comision + (@total_vendido_mes * 0.03)
			END

		UPDATE Empleado SET empl_comision = @nueva_comision WHERE empl_codigo = @codigo_empleado
	END
GO