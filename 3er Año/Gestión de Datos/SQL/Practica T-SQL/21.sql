USE GD_UTN

-- Elimino los elementos si ya existían previamente --
GO
	IF EXISTS (SELECT name FROM sysobjects WHERE name='FAMILIAS_FACTURA')
		DROP FUNCTION FAMILIAS_FACTURA
	IF EXISTS (SELECT name FROM sysobjects WHERE name='HAY_OTRAS_FAMILIAS')
		DROP FUNCTION HAY_OTRAS_FAMILIAS
	IF EXISTS (SELECT name FROM sysobjects WHERE name='TRIGGER_NUEVO_ITEM_FACTURA')
		DROP TRIGGER TRIGGER_NUEVO_ITEM_FACTURA
	IF EXISTS (SELECT name FROM sysobjects WHERE name='TRIGGER_EDITAR_ITEM_FACTURA')
		DROP TRIGGER TRIGGER_EDITAR_ITEM_FACTURA
GO

-- Genero una función que me facilite las familias de productos vendidos en algún producto --
GO
	CREATE FUNCTION FAMILIAS_FACTURA (@factura char(8))
	RETURNS TABLE
	AS RETURN (SELECT DISTINCT prod_familia FROM Item_Factura JOIN Producto ON Item_Factura.item_producto = Producto.prod_codigo WHERE item_numero = @factura)
GO

-- Analizo si existen facturas distintas a la del producto que busco en una factura --
GO
	CREATE FUNCTION HAY_OTRAS_FAMILIAS (@factura char(8), @familia char(3))
	RETURNS TINYINT
	AS
	BEGIN
		DECLARE @valor_retorno tinyint

		IF((SELECT COUNT(*) FROM dbo.FAMILIAS_FACTURA(@factura) WHERE prod_familia != @familia) = 0)
			SET @valor_retorno = 0
		ELSE
			SET @valor_retorno = 1

		RETURN @valor_retorno
	END
GO

-- Genero los triggers correspondiente --
GO
	CREATE TRIGGER TRIGGER_NUEVO_ITEM_FACTURA ON Item_Factura INSTEAD OF INSERT
	AS
	BEGIN
		-- Declaro los datos a insertar --
		DECLARE @tipo_factura char(1), @sucursal_factura char(4), @numero_factura char(8), @producto char(8), @cantidad decimal(12, 2), @precio decimal(12, 2)
		-- Genero el cursor correspondiente --
		DECLARE CURSOR_NUEVO_ITEM_FACTURA CURSOR FOR
			SELECT item_tipo, item_sucursal, item_numero, item_producto, item_cantidad, item_precio FROM inserted
		-- Abro el cursor --
		OPEN CURSOR_NUEVO_ITEM_FACTURA
		-- Recorro el cursor --
		FETCH NEXT FROM CURSOR_NUEVO_ITEM_FACTURA INTO @tipo_factura, @sucursal_factura, @numero_factura, @producto, @cantidad, @precio
		WHILE (@@FETCH_STATUS = 0)
			BEGIN
				-- Obtengo los datos necesarios del producto ingresado --
				DECLARE @familia_producto char(3)
				SELECT @familia_producto = prod_familia FROM Producto WHERE prod_codigo = @producto
				-- Realizo la lógica del ejercicio --
				IF(dbo.HAY_OTRAS_FAMILIAS(@numero_factura, @familia_producto) = 1)
					BEGIN
						RAISERROR('No se puede añadir el producto %s a la factura %s porque la familia no se corresponde con el resto de productos', 16, 1, @producto, @numero_factura)
					END
				ELSE
					BEGIN
						INSERT INTO Item_Factura(item_tipo, item_sucursal, item_numero, item_producto, item_cantidad, item_precio)
						VALUES(@tipo_factura, @sucursal_factura, @numero_factura, @producto, @cantidad, @precio)
					END
				-- Paso a la siguiente fila --
				FETCH NEXT FROM CURSOR_NUEVO_ITEM_FACTURA INTO @tipo_factura, @sucursal_factura, @numero_factura, @producto, @cantidad, @precio
			END
		-- Cierro y elimino el cursor --
		CLOSE CURSOR_NUEVO_ITEM_FACTURA
		DEALLOCATE CURSOR_NUEVO_ITEM_FACTURA
	END
GO

GO
	CREATE TRIGGER TRIGGER_EDITAR_ITEM_FACTURA ON Item_Factura INSTEAD OF UPDATE
	AS
	BEGIN
		-- Declaro los datos actuales --
		DECLARE @tipo_factura_actual char(1), @sucursal_factura_actual char(4), @numero_factura_actual char(8), @producto_actual char(8), @cantidad_actual decimal(12, 2), @precio_actual decimal(12, 2)
		-- Declaro los datos a insertar --
		DECLARE @tipo_factura char(1), @sucursal_factura char(4), @numero_factura char(8), @producto char(8), @cantidad decimal(12, 2), @precio decimal(12, 2)
		-- Genero los cursores correspondientes --
		DECLARE VALORES_ACTUALES CURSOR FOR
			SELECT item_tipo, item_sucursal, item_numero, item_producto, item_cantidad, item_precio FROM deleted
		DECLARE VALORES_NUEVOS CURSOR FOR
			SELECT item_tipo, item_sucursal, item_numero, item_producto, item_cantidad, item_precio FROM inserted
		-- Declaro dos variables para conocer el estado de cada cursor --
		DECLARE @status_actuales int, @status_nuevos int
		-- Abro los cursores --
		OPEN VALORES_ACTUALES
		OPEN VALORES_NUEVOS
		-- Recorro los cursores --
		FETCH NEXT FROM VALORES_ACTUALES INTO @tipo_factura_actual, @sucursal_factura_actual, @numero_factura_actual, @producto_actual, @cantidad_actual, @precio_actual
		SET @status_actuales = @@FETCH_STATUS
		FETCH NEXT FROM VALORES_NUEVOS INTO @tipo_factura, @sucursal_factura, @numero_factura, @producto, @cantidad, @precio
		SET @status_nuevos = @@FETCH_STATUS
		WHILE ((@status_actuales = 0) AND (@status_nuevos = 0))
			BEGIN
				-- Obtengo los datos necesarios del producto ingresado --
				DECLARE @familia_producto char(3)
				SELECT @familia_producto = prod_familia FROM Producto WHERE prod_codigo = @producto
				-- Realizo la lógica del ejercicio --
				IF(dbo.HAY_OTRAS_FAMILIAS(@numero_factura, @familia_producto) = 1)
					BEGIN
						RAISERROR('No se puede añadir el producto %s a la factura %s porque la familia no se corresponde con el resto de productos', 16, 1, @producto, @numero_factura)
					END
				ELSE
					BEGIN
						UPDATE Item_Factura SET item_tipo = @tipo_factura, item_sucursal = @sucursal_factura, item_numero = @numero_factura, item_producto = @producto, item_cantidad = @cantidad, item_precio = @precio
						WHERE item_tipo = @tipo_factura_actual AND item_sucursal = @sucursal_factura_actual AND item_numero = @numero_factura_actual AND item_producto = @producto
					END
				-- Paso a la siguiente fila de cada cursor --
				FETCH NEXT FROM VALORES_ACTUALES INTO @tipo_factura_actual, @sucursal_factura_actual, @numero_factura_actual, @producto_actual, @cantidad_actual, @precio_actual
				SET @status_actuales = @@FETCH_STATUS
				FETCH NEXT FROM VALORES_NUEVOS INTO @tipo_factura, @sucursal_factura, @numero_factura, @producto, @cantidad, @precio
				SET @status_nuevos = @@FETCH_STATUS
			END
		-- Cierro y elimino los cursores --
		CLOSE VALORES_ACTUALES
		CLOSE VALORES_NUEVOS
		DEALLOCATE VALORES_ACTUALES
		DEALLOCATE VALORES_NUEVOS
	END
GO