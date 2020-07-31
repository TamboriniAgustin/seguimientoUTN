USE GD_UTN

-- Elimino los elementos si ya existían previamente --
GO
	IF EXISTS (SELECT name FROM sysobjects WHERE name='CANTIDAD_COMPRADA_EN_EL_ULTIMO_MES')
		DROP FUNCTION CANTIDAD_COMPRADA_EN_EL_ULTIMO_MES
	IF EXISTS (SELECT name FROM sysobjects WHERE name='TRIGGER_NUEVO_ARTICULO')
		DROP TRIGGER TRIGGER_NUEVO_ARTICULO
GO

-- Creo una función que me devuelva una tabla con los productos comprados por cliente --
GO
	CREATE FUNCTION CANTIDAD_COMPRADA_EN_EL_ULTIMO_MES (@cliente char(6), @producto char(8))
	RETURNS DECIMAL(12, 2)
	AS
	BEGIN
		DECLARE @total_comprado decimal(12, 2)

		SELECT @total_comprado = SUM(item_cantidad) FROM Factura f1
		JOIN Item_Factura if1 ON f1.fact_numero = if1.item_numero
		WHERE (fact_cliente = @cliente) AND (YEAR(fact_fecha) = YEAR(GETDATE())) AND (MONTH(fact_fecha) = MONTH(GETDATE()))
		GROUP BY item_producto

		IF(@total_comprado IS NULL)
			SET @total_comprado = 0

		RETURN @total_comprado
	END
GO

-- Genero el trigger para hacer cumplir la regla de negocio --
GO
	CREATE TRIGGER TRIGGER_NUEVO_ARTICULO ON Item_Factura INSTEAD OF INSERT
	AS
	BEGIN
		-- Declaro las variables necesarias para insertar un item de factura --
		DECLARE @tipo_factura char(1), @sucursal_factura char(4), @numero_factura char(8), @producto char(8), @cantidad decimal(12, 2), @precio decimal(12, 2)
		-- Declaro un cursor para analizar cada elemento insertado --
		DECLARE CURSOR_NUEVO_ARTICULO CURSOR FOR (SELECT item_tipo, item_sucursal, item_numero, item_producto, item_cantidad, item_precio FROM inserted)
		OPEN CURSOR_NUEVO_ARTICULO
		FETCH NEXT FROM CURSOR_NUEVO_ARTICULO INTO @tipo_factura, @sucursal_factura, @numero_factura, @producto, @cantidad, @precio
		WHILE(@@FETCH_STATUS = 0)
			BEGIN
				-- Obtengo el cliente --
				DECLARE @cliente char(6)
				SET @cliente = (SELECT fact_cliente FROM Factura WHERE fact_numero = @numero_factura)
				-- Analizo si la cantidad es mayor que 100  --
				IF((dbo.CANTIDAD_COMPRADA_EN_EL_ULTIMO_MES(@cliente, @producto) + @cantidad) > 100)
					BEGIN
						RAISERROR('Se ha superado el límite máximo de compra de un producto', 1, 16)
					END
				-- Analizo si la cantidad sumada a las cantidades compradas durante el mes del cliente es mayor que 100 --
				ELSE
					BEGIN
						INSERT INTO Item_Factura(item_tipo, item_sucursal, item_numero, item_producto, item_cantidad, item_precio)
						VALUES(@tipo_factura, @sucursal_factura, @numero_factura, @producto, @cantidad, @precio)
					END
				-- Paso al siguiente item --
				FETCH NEXT FROM CURSOR_NUEVO_ARTICULO INTO @tipo_factura, @sucursal_factura, @numero_factura, @producto, @cantidad, @precio
			END
		CLOSE CURSOR_NUEVO_ARTICULO
		DEALLOCATE CURSOR_NUEVO_ARTICULO
	END
GO