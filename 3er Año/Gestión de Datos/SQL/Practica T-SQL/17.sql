USE GD_UTN

-- Elimino el trigger en caso de que ya exista --
GO
	IF EXISTS (SELECT name FROM sysobjects WHERE name='TRIGGER_VALIDAR_REPOSICION_STOCK_INSERT')
		DROP TRIGGER TRIGGER_VALIDAR_REPOSICION_STOCK_INSERT
	IF EXISTS (SELECT name FROM sysobjects WHERE name='TRIGGER_VALIDAR_REPOSICION_STOCK_UPDATE')
		DROP TRIGGER TRIGGER_VALIDAR_REPOSICION_STOCK_UPDATE
GO

-- Genero los triggers correspondientes al ejercicio --
GO
	CREATE TRIGGER TRIGGER_VALIDAR_REPOSICION_STOCK_INSERT ON Stock INSTEAD OF INSERT
	AS
	BEGIN
		-- Analizo si se cumple que el stock es menor que el stoc maximo y mayor que el stock minimo --
		IF EXISTS(SELECT * FROM inserted WHERE (stoc_cantidad < stoc_punto_reposicion) OR (stoc_cantidad > stoc_stock_maximo))
			BEGIN
				RAISERROR('El STOCK del producto debe encontrarse entre el STOCK DEL PUNTO DE REPOSICIÓN y el STOCK MÁXIMO', 1, 1)
			END
		ELSE
			BEGIN
				INSERT INTO STOCK
					SELECT * FROM inserted
			END
	END
GO

GO
	CREATE TRIGGER TRIGGER_VALIDAR_REPOSICION_STOCK_UPDATE ON Stock INSTEAD OF UPDATE
	AS
	BEGIN
		-- Analizo si se cumple que el stock es menor que el stoc maximo y mayor que el stock minimo --
		IF EXISTS(SELECT * FROM inserted WHERE (stoc_cantidad < stoc_punto_reposicion) OR (stoc_cantidad > stoc_stock_maximo))
			BEGIN
				RAISERROR('El STOCK del producto debe encontrarse entre el STOCK DEL PUNTO DE REPOSICIÓN y el STOCK MÁXIMO', 1, 1)
			END
		ELSE
			BEGIN
				-- Tomo las variables de la actualización --
				DECLARE @cantidad decimal(12, 2), @deposito char(2), @detalle char(100), @producto char(8), @proxima_reposicion smalldatetime,
				        @punto_reposicion decimal(12, 2), @stock_maximo decimal(12, 2)
				-- Asigno valor a las variables --
				SELECT @cantidad = stoc_cantidad, @deposito = stoc_deposito, @detalle = stoc_detalle, @producto = stoc_producto, @proxima_reposicion = stoc_proxima_reposicion, @punto_reposicion = stoc_punto_reposicion, @stock_maximo = stoc_stock_maximo FROM inserted
				-- Realizo la actualización --
				UPDATE STOCK SET stoc_cantidad = @cantidad, stoc_deposito = @deposito, stoc_detalle = @detalle, stoc_proxima_reposicion = @proxima_reposicion, stoc_punto_reposicion = @punto_reposicion, stoc_stock_maximo = @stock_maximo WHERE stoc_producto = @producto
			END
	END
GO