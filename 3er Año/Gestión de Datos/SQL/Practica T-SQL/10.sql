USE GD_UTN

-- Elimino el trigger en caso de que ya exista --
GO
	IF EXISTS (SELECT name FROM sysobjects WHERE name='TRIGGER_ELIMINAR_PRODUCTO')
		DROP TRIGGER TRIGGER_ELIMINAR_PRODUCTO
GO

-- Genero el trigger correspondiente --
GO
	CREATE TRIGGER TRIGGER_ELIMINAR_PRODUCTO ON Producto INSTEAD OF DELETE
	AS
	BEGIN
		-- Creo variables de interés para utilizar luego --
		DECLARE @producto char(8)
		-- Defino el cursor que voy a utilizar con las tablas INSERTED y DELETED --
		DECLARE CURSOR_PRODUCTO CURSOR FOR
			SELECT d.prod_codigo FROM deleted d
		-- Abro el cursor para recorrer la tabla obtenida y así eliminar los productos que tenga que eliminar --
		OPEN CURSOR_PRODUCTO
		FETCH NEXT FROM CURSOR_PRODUCTO INTO @producto
		WHILE @@FETCH_STATUS = 0
			BEGIN
				-- Obtengo el stock del producto actual --
				DECLARE @stock_producto decimal(12, 2)
				SELECT @stock_producto = SUM(stoc_cantidad) FROM STOCK WHERE stoc_producto = @producto GROUP BY stoc_producto
				-- Elimino los correspondientes --
				IF (@stock_producto <= 0)
					DELETE FROM Producto WHERE prod_codigo = @producto
				ELSE
					RAISERROR('No se puede eliminar el producto %s ya que aún tiene stock', 16, 1, @producto) 
				-- Paso a la siguiente fila --
				FETCH NEXT FROM CURSOR_PRODUCTO INTO @producto
			END
		-- Cierro el cursor y libero memoria --
		CLOSE CURSOR_PRODUCTO
		DEALLOCATE CURSOR_PRODUCTO
	END
GO