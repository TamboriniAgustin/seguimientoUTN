USE GD_UTN

-- Elimino los elementos si ya existían previamente --
GO
	IF EXISTS (SELECT name FROM sysobjects WHERE name='ES_PRODUCTO_COMPUESTO')
		DROP FUNCTION ES_PRODUCTO_COMPUESTO
	IF EXISTS (SELECT name FROM sysobjects WHERE name='PRECIO_COMPONENTES')
		DROP FUNCTION PRECIO_COMPONENTES
	IF EXISTS (SELECT name FROM sysobjects WHERE name='TRIGGER_NUEVA_COMPRA')
		DROP TRIGGER TRIGGER_NUEVA_COMPRA
GO

-- Creo una función para verificar si un producto es compuesto --
GO
	CREATE FUNCTION ES_PRODUCTO_COMPUESTO (@producto char(8))
	RETURNS TINYINT
	AS
	BEGIN
		-- Genero la variable que voy a retornar --
		DECLARE @valor_retorno tinyint
		-- Asigno valor a la variable --
		IF (@producto IN (SELECT DISTINCT comp_producto FROM Composicion)) 
			SET @valor_retorno = 1
		ELSE
			SET @valor_retorno = 0
		-- Retorno el valor esperado --
		RETURN @valor_retorno
	END
GO

-- Creo una función que me permita obtener el precio de los componentes de un producto --
GO
	CREATE FUNCTION PRECIO_COMPONENTES (@producto char(8))
	RETURNS DECIMAL(12, 2)
	AS
	BEGIN
		-- Genero la variable donde almaceno el precio de los componentes --
		DECLARE @precio_componentes decimal(12, 2)
		-- Asigno valor a la variable --
		SET @precio_componentes = (
									SELECT ISNULL(SUM(prod_precio), 0) FROM Composicion
									JOIN Producto ON Composicion.comp_componente = Producto.prod_codigo
									WHERE comp_producto = @producto
								  )
		-- Retorno el precio --
		RETURN @precio_componentes
	END
GO

-- Genero un trigger a la hora de sumar un producto a la compra de un cliente --
GO	
	CREATE TRIGGER TRIGGER_NUEVA_COMPRA ON Item_Factura INSTEAD OF INSERT
	AS
	BEGIN
		-- Creo las variables que voy a utilizar --
		DECLARE @tipo_factura char(1)
		DECLARE @sucursal_factura char(4)
		DECLARE @numero_factura char(8)
		DECLARE @codigo_producto char(8)
		DECLARE @cantidad_unidades decimal(12, 2)
		DECLARE @precio_producto decimal(12, 2)
		-- Creo el cursor a utilizar obteniendo los valores de la tabla INSERTED y DELETED --
		DECLARE CURSOR_COMPRA CURSOR FOR
			SELECT i.item_tipo, i.item_sucursal, i.item_numero, i.item_producto, i.item_cantidad, i.item_precio FROM inserted i
		-- Recorro el cursor para analizar cada una de las inserciones por separado --
		OPEN CURSOR_COMPRA
		FETCH NEXT FROM CURSOR_COMPRA INTO @tipo_factura, @sucursal_factura, @numero_factura, @codigo_producto, @cantidad_unidades, @precio_producto
		WHILE (@@FETCH_STATUS = 0)
			BEGIN
				-- Obtengo al cliente que hizo la compra y la fecha en que se realizó --
				DECLARE @cliente char(6)
				DECLARE @fecha smalldatetime
				SELECT @cliente = fact_cliente, @fecha = fact_fecha FROM Factura WHERE (fact_numero = @numero_factura) AND (fact_tipo = @tipo_factura) AND (fact_sucursal = @sucursal_factura)
				-- Realizo la lógica del ejercicio --
				IF (dbo.ES_PRODUCTO_COMPUESTO(@codigo_producto) = 1)
					BEGIN
						-- Si el precio es mayor o igual a la mitad del precio de los componentes del producto, inserto y muestro en pantalla --
						IF(@precio_producto >= (dbo.PRECIO_COMPONENTES(@codigo_producto) / 2))
							BEGIN
								INSERT INTO Item_Factura (item_tipo, item_numero, item_sucursal, item_producto, item_cantidad, item_precio) VALUES(@tipo_factura, @numero_factura, @sucursal_factura, @precio_producto, @cantidad_unidades, @precio_producto)
								PRINT('Fecha de compra: ', @fecha, '\nCliente: ', @cliente, '\nProducto: ', @codigo_producto, 'Precio: ', @precio_producto)
								PRINT('\n\n-------------------------------------------------------------------------------------\n\n')
							END
						-- De otro modo muestro un error --
						ELSE
							BEGIN
								RAISERROR('No puede insertarse un producto cuyo precio sea menor que la mitad de la suma del precio de sus componentes', 16, 1) 
							END
					END
				ELSE
					-- Si no es un producto compuesto simplemente lo inserto --
					BEGIN
						INSERT INTO Item_Factura (item_tipo, item_numero, item_sucursal, item_producto, item_cantidad, item_precio) VALUES(@tipo_factura, @numero_factura, @sucursal_factura, @precio_producto, @cantidad_unidades, @precio_producto)
					END
				-- Paso a la siguiente fila del cursor --
				FETCH NEXT FROM CURSOR_COMPRA INTO @tipo_factura, @sucursal_factura, @numero_factura, @codigo_producto, @cantidad_unidades, @precio_producto
			END
		CLOSE CURSOR_COMPRA
		DEALLOCATE CURSOR_COMPRA
	END
GO