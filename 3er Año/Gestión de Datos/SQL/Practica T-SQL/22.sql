USE GD_UTN

-- Elimino los elementos si ya existían previamente --
GO
	IF EXISTS (SELECT name FROM sysobjects WHERE name='PRODUCTOS_RUBRO')
		DROP FUNCTION PRODUCTOS_RUBRO
	IF EXISTS (SELECT name FROM sysobjects WHERE name='RUBROS_CON_ESPACIO')
		DROP FUNCTION RUBROS_CON_ESPACIO
	IF EXISTS (SELECT name FROM sysobjects WHERE name='RECATEGORIZAR_RUBROS')
		DROP PROCEDURE RECATEGORIZAR_RUBROS
	IF EXISTS (SELECT name FROM sysobjects WHERE name='TRIGGER_NUEVO_PRODUCTO')
		DROP TRIGGER TRIGGER_NUEVO_PRODUCTO
	IF EXISTS (SELECT name FROM sysobjects WHERE name='TRIGGER_EDITAR_PRODUCTO')
		DROP TRIGGER TRIGGER_EDITAR_PRODUCTO
GO

-- Creo una funcion que retorna la cantidad de elementos que tiene un rubro --
GO
	CREATE FUNCTION PRODUCTOS_RUBRO (@rubro char(4))
	RETURNS INT
	AS
	BEGIN
		DECLARE @valor_retorno int
		SELECT @valor_retorno = COUNT(DISTINCT prod_codigo) FROM Rubro JOIN Producto ON Rubro.rubr_id = Producto.prod_rubro WHERE rubr_id = @rubro GROUP BY rubr_id, rubr_detalle
		RETURN @valor_retorno
	END
GO

-- Creo una función que retorne los rubros con espacio para insertar productos (menos de 20 productos en este rubro) --
GO
	CREATE FUNCTION RUBROS_CON_ESPACIO ()
	RETURNS TABLE
	RETURN (SELECT * FROM Rubro WHERE dbo.PRODUCTOS_RUBRO(rubr_id) < 20)
GO

-- Creo un procedure que recategorize los rubros actuales --
GO
	CREATE PROCEDURE RECATEGORIZAR_RUBROS
	AS
	BEGIN
		-- Declaro los elementos que voy a necesitar del producto --
		DECLARE @codigo_producto char(8)
		DECLARE @rubro_producto char(4)
		-- Utilizo un cursor para recorrer producto por producto, de forma que iré recategorizando aquellos que sean necesarios --
		DECLARE CURSOR_PRODUCTOS CURSOR FOR SELECT prod_codigo, prod_rubro FROM Producto
		OPEN CURSOR_PRODUCTOS
		FETCH NEXT FROM CURSOR_PRODUCTOS INTO @codigo_producto, @rubro_producto
		WHILE (@@FETCH_STATUS = 0)
			BEGIN
				-- Analizo si el rubro se encuentra lleno --
				IF(dbo.PRODUCTOS_RUBRO(@rubro_producto) > 20)
					BEGIN
						-- Declaro la variable que representará al nuevo rubro del producto --
						DECLARE @rubro_libre char(4)
						-- Si encuentro rubros con espacio, lo asigno al primero que encuentre --
						IF((SELECT COUNT(*) FROM dbo.RUBROS_CON_ESPACIO()) > 0)
							BEGIN
								SET @rubro_libre = (SELECT TOP 1 rubr_id FROM dbo.RUBROS_CON_ESPACIO())
							END
						-- Si ya no hay rubros con espacio, entonces debo crear uno nuevo --
						ELSE
							BEGIN
								-- Creo un nuevo rubro --
								SET @rubro_libre = (SELECT TOP 1 CASE WHEN (rubr_id > 999) THEN rubr_id+1 WHEN (rubr_id > 99) THEN CONCAT('0', rubr_id+1) ELSE CONCAT('00', rubr_id+1) END FROM Rubro ORDER BY rubr_id DESC)
								INSERT INTO Rubro(rubr_id, rubr_detalle) VALUES(@rubro_libre, 'RUBRO REASIGNADO')
							END
						-- Asigno el rubro indicado al producto --
						UPDATE Producto SET prod_rubro = @rubro_libre WHERE prod_codigo = @codigo_producto
					END
				-- Paso al siguiente producto --
				FETCH NEXT FROM CURSOR_PRODUCTOS INTO @codigo_producto, @rubro_producto
			END
		CLOSE CURSOR_PRODUCTOS
		DEALLOCATE CURSOR_PRODUCTOS
	END
GO

-- Creo un trigger que verificará si el producto puede añadirse en ese rubro --
GO
	CREATE TRIGGER TRIGGER_NUEVO_PRODUCTO ON Producto INSTEAD OF INSERT
	AS
	BEGIN
		INSERT INTO Producto
			SELECT * FROM inserted WHERE dbo.PRODUCTOS_RUBRO(prod_rubro) < 20
	END
GO

-- Creo un trigger que al modificar un producto valide la cantidad de productos del rubro --
GO
	CREATE TRIGGER TRIGGER_EDITAR_PRODUCTO ON Producto INSTEAD OF UPDATE
	AS
	BEGIN
		-- Declaro los datos actuales --
		DECLARE @codigo_producto_actual char(8), @detalle_producto_actual char(50), @precio_producto_actual decimal(12, 2), @producto_familia_actual char(3), @producto_rubro_actual char(4), @producto_envase_actual numeric(6, 0)
		-- Declaro los datos a insertar --
		DECLARE @codigo_producto char(8), @detalle_producto char(50), @precio_producto decimal(12, 2), @producto_familia char(3), @producto_rubro char(4), @producto_envase numeric(6, 0)
		-- Genero los cursores correspondientes --
		DECLARE VALORES_ACTUALES CURSOR FOR
			SELECT prod_codigo, prod_detalle, prod_precio, prod_familia, prod_rubro, prod_envase FROM deleted
		DECLARE VALORES_NUEVOS CURSOR FOR
			SELECT prod_codigo, prod_detalle, prod_precio, prod_familia, prod_rubro, prod_envase FROM inserted
		-- Declaro dos variables para conocer el estado de cada cursor --
		DECLARE @status_actuales int, @status_nuevos int
		-- Abro los cursores --
		OPEN VALORES_ACTUALES
		OPEN VALORES_NUEVOS
		-- Recorro los cursores --
		FETCH NEXT FROM VALORES_ACTUALES INTO @codigo_producto_actual, @detalle_producto_actual, @precio_producto_actual, @producto_familia_actual, @producto_rubro_actual, @producto_envase_actual
		SET @status_actuales = @@FETCH_STATUS
		FETCH NEXT FROM VALORES_NUEVOS INTO @codigo_producto, @detalle_producto, @precio_producto, @producto_familia, @producto_rubro, @producto_envase
		SET @status_nuevos = @@FETCH_STATUS
		WHILE ((@status_actuales = 0) AND (@status_nuevos = 0))
			BEGIN
				-- Realizo la lógica del ejercicio --
				IF(dbo.PRODUCTOS_RUBRO(@producto_rubro) >= 20)
					BEGIN
						RAISERROR('No se puede setear el rubro %s al producto %s porque ese rubro ya tiene 20 productos asignados', 16, 1, @producto_rubro, @codigo_producto)
					END
				ELSE
					BEGIN
						UPDATE Producto SET prod_codigo = @codigo_producto, prod_detalle = @detalle_producto, prod_precio = @precio_producto, prod_familia = @producto_familia, prod_rubro = @producto_rubro, prod_envase = @producto_envase
						WHERE prod_codigo = @codigo_producto_actual
					END
				-- Paso a la siguiente fila de cada cursor --
				FETCH NEXT FROM VALORES_ACTUALES INTO @codigo_producto_actual, @detalle_producto_actual, @precio_producto_actual, @producto_familia_actual, @producto_rubro_actual, @producto_envase_actual
				SET @status_actuales = @@FETCH_STATUS
				FETCH NEXT FROM VALORES_NUEVOS INTO @codigo_producto, @detalle_producto, @precio_producto, @producto_familia, @producto_rubro, @producto_envase
				SET @status_nuevos = @@FETCH_STATUS
			END
		-- Cierro y elimino los cursores --
		CLOSE VALORES_ACTUALES
		CLOSE VALORES_NUEVOS
		DEALLOCATE VALORES_ACTUALES
		DEALLOCATE VALORES_NUEVOS
	END
GO