USE GD_UTN

-- Elimino el trigger en caso de que ya exista --
GO
	IF EXISTS (SELECT name FROM sysobjects WHERE name='TRIGGER_MODIFICACION_PRODUCTO_COMPUESTO')
		DROP TRIGGER TRIGGER_MODIFICACION_PRODUCTO_COMPUESTO
GO

-- Genero el trigger correspondiente --
GO
	CREATE TRIGGER TRIGGER_MODIFICACION_PRODUCTO_COMPUESTO ON Item_Factura FOR UPDATE
	AS
	BEGIN
		-- Creo variables de interés para utilizar luego --
		DECLARE @componente char(8)
		DECLARE @cantidad decimal(12, 2)
		-- Defino el cursor que voy a utilizar con las tablas INSERTED y DELETED --
		DECLARE CURSOR_COMPONENTE CURSOR FOR
			SELECT c.comp_componente, ((i.item_cantidad - d.item_cantidad) * c.comp_cantidad) FROM Composicion c
			JOIN inserted i ON c.comp_componente = i.item_producto
			JOIN deleted d ON c.comp_componente = d.item_producto
			WHERE i.item_cantidad != d.item_cantidad
		-- Abro el cursor para recorrer la tabla obtenida y así modificar los productos que tenga que modificar --
		OPEN CURSOR_COMPONENTE
		FETCH NEXT FROM CURSOR_COMPONENTE INTO @componente, @cantidad
		WHILE @@FETCH_STATUS = 0
			BEGIN
				-- Actualizo los correspondientes --
				UPDATE STOCK SET stoc_cantidad = stoc_cantidad - @cantidad
				WHERE stoc_producto = @componente
				-- Paso a la siguiente fila --
				FETCH NEXT FROM CURSOR_COMPONENTE INTO @componente, @cantidad
			END
		-- Cierro el cursor y lo elimino de memoria --
		CLOSE CURSOR_COMPONENTE
		DEALLOCATE CURSOR_COMPONENTE
	END
GO