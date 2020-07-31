USE GD_UTN

-- Elimino los elementos si ya existían previamente --
GO
	IF EXISTS (SELECT name FROM sysobjects WHERE name='ES_COMPUESTO_POR_PRODUCTOS_DISTINTOS')
		DROP FUNCTION ES_COMPUESTO_POR_PRODUCTOS_DISTINTOS
	IF EXISTS (SELECT name FROM sysobjects WHERE name='TIENE_PRODUCTO_CON_COMPONENTES_DIFERENTES')
		DROP FUNCTION TIENE_PRODUCTO_CON_COMPONENTES_DIFERENTES
	IF EXISTS (SELECT name FROM sysobjects WHERE name='TRIGGER_NUEVA_COMPRA')
		DROP TRIGGER TRIGGER_NUEVA_COMPRA
GO

-- Creo una función que detecta si un producto es composición de otro --
GO
	CREATE FUNCTION ES_COMPUESTO_POR_PRODUCTOS_DISTINTOS (@producto char(8))
	RETURNS TINYINT
	AS
	BEGIN
		DECLARE @valor_retorno tinyint

		IF((SELECT COUNT(*) FROM Composicion WHERE comp_componente = @producto) > 1)
			SET @valor_retorno = 1
		ELSE
			SET @valor_retorno = 0

		RETURN @valor_retorno
	END
GO

-- Creo una función que detecta si algún producto de una factura es compuesto por otro --
GO
	CREATE FUNCTION TIENE_PRODUCTO_CON_COMPONENTES_DIFERENTES (@factura char(8))
	RETURNS TINYINT
	AS
	BEGIN
		DECLARE @valor_retorno tinyint

		IF((SELECT COUNT(*) FROM Factura JOIN Item_Factura ON Factura.fact_numero = Item_Factura.item_numero WHERE (dbo.ES_COMPUESTO_POR_PRODUCTOS_DISTINTOS(item_producto) = 1) AND (fact_numero = @factura)) > 0)
			SET @valor_retorno = 1
		ELSE
			SET @valor_retorno = 0

		RETURN @valor_retorno
	END
GO

-- Genero el trigger a la hora de registrar una factura (asumo que una factura no se puede modificar, por lo que no hago un trigger para UPDATE) --
GO
	CREATE TRIGGER TRIGGER_NUEVA_COMPRA ON Factura INSTEAD OF INSERT
	AS
	BEGIN
		-- Declaro variables de interés --
		DECLARE @factura_tipo char(1), @factura_sucursal char(4), @factura_numero char(8), @factura_fecha smalldatetime, @factura_vendedor numeric(6, 0), @factura_total decimal(12, 2), @factura_impuestos decimal(12, 2), @factura_cliente char(6)
		-- Declaro un cursor, ya que para hacer visible el error necesitaré analizar uno por uno --
		DECLARE CURSOR_FACTURA CURSOR FOR (SELECT fact_tipo, fact_sucursal, fact_numero, fact_fecha, fact_vendedor, fact_total, fact_total_impuestos, fact_cliente FROM inserted)
		OPEN CURSOR_FACTURA
		FETCH NEXT FROM CURSOR_FACTURA INTO @factura_tipo, @factura_sucursal, @factura_numero, @factura_fecha, @factura_vendedor, @factura_total, @factura_impuestos, @factura_cliente
		WHILE(@@FETCH_STATUS = 0)
			BEGIN
				-- Si el producto no es compuesto de algun otro producto, lo inserto --
				IF(dbo.TIENE_PRODUCTO_CON_COMPONENTES_DIFERENTES(@factura_numero) = 0)
					BEGIN
						INSERT INTO Factura (fact_tipo, fact_numero, fact_sucursal, fact_fecha, fact_vendedor, fact_total, fact_total_impuestos, fact_cliente) 
						VALUES(@factura_tipo, @factura_numero, @factura_sucursal, @factura_sucursal, @factura_fecha, @factura_total, @factura_impuestos, @factura_cliente)
					END
				-- Si la factura tiene algun producto componente, lanzo el error --
				ELSE
					BEGIN
						RAISERROR('La factura %s no pudo grabarse debido a que contiene un producto que es componente de más de un producto', 16, 1, @factura_numero)
					END
				-- Paso a la siguiente factura insertada --
				FETCH NEXT FROM CURSOR_FACTURA INTO @factura_tipo, @factura_sucursal, @factura_numero, @factura_fecha, @factura_vendedor, @factura_total, @factura_impuestos, @factura_cliente
			END
		CLOSE CURSOR_FACTURA
		DEALLOCATE CURSOR_FACTURA
	END
GO