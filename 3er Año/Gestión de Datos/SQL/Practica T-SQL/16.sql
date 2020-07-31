USE GD_UTN

-- Elimino los objetos en caso de que ya existan --
GO
	IF EXISTS (SELECT name FROM sysobjects WHERE name='ES_PRODUCTO_COMPUESTO')
		DROP FUNCTION ES_PRODUCTO_COMPUESTO
	IF EXISTS (SELECT name FROM sysobjects WHERE name='PRODUCTOS_COMPUESTOS')
		DROP FUNCTION PRODUCTOS_COMPUESTOS
	IF EXISTS (SELECT name FROM sysobjects WHERE name='STOCK_PRODUCTO')
		DROP FUNCTION STOCK_PRODUCTO
	IF EXISTS (SELECT name FROM sysobjects WHERE name='QUITAR_STOCK_DEPOSITOS')
		DROP PROCEDURE QUITAR_STOCK_DEPOSITOS
	IF EXISTS (SELECT name FROM sysobjects WHERE name='TRIGGER_ACTUALIZAR_STOCK')
		DROP TRIGGER TRIGGER_ACTUALIZAR_STOCK
GO

-- Genero una función para saber si un producto es compuesto --
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

-- Genero una función para conocer los componentes de un producto --
GO
	CREATE FUNCTION PRODUCTOS_COMPUESTOS (@producto char(8))
	RETURNS TABLE
	AS
	RETURN (SELECT comp_componente, comp_cantidad FROM Composicion WHERE comp_producto = @producto)
GO

-- Genero una función para conocer el stock total de un producto --
GO
	CREATE FUNCTION STOCK_PRODUCTO (@producto char(8))
	RETURNS DECIMAL(12, 2)
	AS
	BEGIN
		-- Genero la variable de retorno --
		DECLARE @stock_producto decimal(12, 2)
		-- Asigno el stock del producto --
		IF (dbo.ES_PRODUCTO_COMPUESTO(@producto) = 1)
			BEGIN
				SET @stock_producto = (
										SELECT TOP 1 (ISNULL((SUM(stoc_cantidad)), 0) / comp_cantidad) FROM Composicion 
										JOIN Producto ON Composicion.comp_componente = Producto.prod_codigo
										LEFT JOIN STOCK ON Producto.prod_codigo = STOCK.stoc_producto
										WHERE comp_producto = @producto
										GROUP BY comp_producto, comp_componente, comp_cantidad
										ORDER BY (ISNULL((SUM(stoc_cantidad)), 0) / comp_cantidad)
									  )
			END
		ELSE
			BEGIN
				SET @stock_producto = (SELECT ISNULL(SUM(stoc_cantidad), 0) FROM Producto LEFT JOIN STOCK ON Producto.prod_codigo = STOCK.stoc_producto WHERE prod_codigo = @producto GROUP BY prod_codigo)
			END
		-- Retorno el stock del producto --
		RETURN @stock_producto
	END
GO

-- Genero una función que reste un determinado stock de un producto, empezando por el deposito que mas stock tiene --
GO
	CREATE PROCEDURE QUITAR_STOCK_DEPOSITOS (@producto char(8), @total_vendido decimal(12, 2))
	AS
	BEGIN
		-- Genero variables a utilizar --
		DECLARE @deposito_con_mas_stock char(2)
		DECLARE @stock_disponible decimal(12, 2)
		-- Genero el recorrido de actualización siempre y cuando siga quedando stock en el total vendido --
		WHILE @total_vendido > 0
			BEGIN
				-- Selecciono el deposito con mayor cantidad de stock actual --
				SELECT TOP 1 @deposito_con_mas_stock = stoc_deposito, @stock_disponible = stoc_cantidad FROM STOCK WHERE stoc_producto = @producto ORDER BY stoc_cantidad DESC
				-- Si el stock del deposito es mayor que el total vendido, simplemente actualizo --
				IF (@stock_disponible > @total_vendido)
					BEGIN
						UPDATE STOCK SET stoc_cantidad = (@stock_disponible - @total_vendido) WHERE (stoc_producto = @producto) AND (stoc_deposito = @deposito_con_mas_stock)
						SET @total_vendido = 0
					END
				-- Si el stock del deposito no alcanza, lo seteo en 0 y espero a la siguiente iteración --
				ELSE
					BEGIN
						UPDATE STOCK SET stoc_cantidad = 0 WHERE (stoc_producto = @producto) AND (stoc_deposito = @deposito_con_mas_stock)
						SET @total_vendido = (@total_vendido - @stock_disponible)
					END
			END
	END
GO

-- Genero el trigger correspondiente --
GO
	CREATE TRIGGER TRIGGER_ACTUALIZAR_STOCK ON Item_Factura FOR INSERT
	AS
	BEGIN
		-- Creo variables de interés para utilizar luego --
		DECLARE @producto char(8)
		DECLARE @total_vendido decimal(12, 2)
		-- Defino el cursor que voy a utilizar con las tablas INSERTED y DELETED --
		DECLARE CURSOR_STOCK CURSOR FOR
			SELECT item_producto, item_cantidad FROM inserted
		-- Abro el cursor para recorrer la tabla obtenida y así modificar los productos que tenga que modificar --
		OPEN CURSOR_STOCK
		FETCH NEXT FROM CURSOR_STOCK INTO @producto, @total_vendido
		WHILE @@FETCH_STATUS = 0
			BEGIN
				-- Si alcanza el stock total del producto para realizar la compra (asi evitar valores negativos), actualizo --
				IF (dbo.STOCK_PRODUCTO(@producto) > 0)
					BEGIN
						-- Si el producto es compuesto, tendré que actualizar el stock de cada producto antes de actualizar el stock del combo --
						IF (dbo.ES_PRODUCTO_COMPUESTO(@producto) = 1)
							BEGIN
								-- Declaro las variables que tendrá cada producto compuesto --
								DECLARE @producto_compuesto char(8)
								DECLARE @cantidad_componentes_producto decimal(12, 2)
								-- Declaro una variable para almacenar la cantidad vendida de cada componente --
								DECLARE @total_vendido_componente decimal(12, 2)
								-- Defino el cursor para los productos que componen el combo --
								DECLARE CURSOR_PRODUCTOS_COMPUESTOS CURSOR FOR 
									SELECT * FROM dbo.PRODUCTOS_COMPUESTOS(@producto)
								-- Abro el cursor para recorrer la tabla obtenida y realizar la operatoria requerida --
								OPEN CURSOR_PRODUCTOS_COMPUESTOS
								FETCH NEXT FROM CURSOR_PRODUCTOS_COMPUESTOS INTO @producto_compuesto, @cantidad_componentes_producto
								WHILE @@FETCH_STATUS = 0
									BEGIN
										-- Obtengo cuanto vendí del componente actual --
										SET @total_vendido_componente = (@total_vendido * @cantidad_componentes_producto)
										-- Actualizo el stock del componente --
										EXECUTE dbo.QUITAR_STOCK_DEPOSITOS @producto_compuesto, @total_vendido_componente
										-- Paso a la siguiente fila --
										FETCH NEXT FROM CURSOR_PRODUCTOS_COMPUESTOS INTO @producto_compuesto, @cantidad_componentes_producto
									END
								-- Cierro el cursor y lo elimino de memoria --
								CLOSE CURSOR_PRODUCTOS_COMPUESTOS
								DEALLOCATE CURSOR_PRODUCTOS_COMPUESTOS
								-- Una vez actualizado el stock de cada componente, actualizo el stock del combo en sí --
								EXECUTE dbo.QUITAR_STOCK_DEPOSITOS @producto, @total_vendido
							END
						-- Si no es compuesto, simplemente actualizo el stock --
						ELSE
							BEGIN
								EXECUTE dbo.QUITAR_STOCK_DEPOSITOS @producto, @total_vendido
							END
					END
				-- De otro modo, lanzo un error y deshago la operación --
				ELSE
					BEGIN
						RAISERROR('No se pudo realizar dicha venta, ya que el stock total del producto o combo %s no es suficiente.', 16, 1, @producto)
						ROLLBACK TRANSACTION
					END
				-- Paso a la siguiente fila --
				FETCH NEXT FROM CURSOR_STOCK INTO @producto, @total_vendido
			END
		-- Cierro el cursor y lo elimino de memoria --
		CLOSE CURSOR_STOCK
		DEALLOCATE CURSOR_STOCK
	END
GO