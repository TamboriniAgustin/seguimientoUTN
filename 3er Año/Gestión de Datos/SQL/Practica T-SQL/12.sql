USE GD_UTN

-- Elimino el trigger en caso de que ya exista --
GO
	IF EXISTS (SELECT name FROM sysobjects WHERE name='TRIGGER_CONTROLAR_COMPOSICION')
		DROP TRIGGER TRIGGER_CONTROLAR_COMPOSICION
GO

-- Genero el trigger correspondiente --
GO
	CREATE TRIGGER TRIGGER_CONTROLAR_COMPOSICION ON Composicion INSTEAD OF INSERT
	AS
	BEGIN
		-- Creo variables de interés para utilizar luego --
		DECLARE @producto char(8)
		DECLARE @componente char(8)
		DECLARE @cantidad decimal(12, 2)
		-- Defino el cursor que voy a utilizar con las tablas INSERTED y DELETED --
		DECLARE CURSOR_COMPOSICION CURSOR FOR
			SELECT i.comp_producto, i.comp_componente, i.comp_cantidad FROM inserted i
		-- Abro el cursor para recorrer la tabla obtenida y así insertar los productos que tenga que insertar --
		OPEN CURSOR_COMPOSICION
		FETCH NEXT FROM CURSOR_COMPOSICION INTO @producto, @componente, @cantidad
		WHILE @@FETCH_STATUS = 0
			BEGIN
				-- Elimino los correspondientes --
				IF (@producto != @componente)
					INSERT INTO Composicion (comp_producto, comp_componente, comp_cantidad) VALUES (@producto, @componente, @cantidad)
				ELSE
					RAISERROR('No se puede insertar el producto compuesto %s a sí mismo', 16, 1, @componente) 
				-- Paso a la siguiente fila --
				FETCH NEXT FROM CURSOR_COMPOSICION INTO @producto, @componente, @cantidad
			END
		-- Cierro el cursor y libero memoria --
		CLOSE CURSOR_COMPOSICION
		DEALLOCATE CURSOR_COMPOSICION
	END
GO