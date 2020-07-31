USE GD_UTN

-- Elimino los elementos si ya existían previamente --
GO
	IF EXISTS (SELECT name FROM sysobjects WHERE name='ES_PRODUCTO_COMPUESTO')
		DROP FUNCTION ES_PRODUCTO_COMPUESTO
	IF EXISTS (SELECT name FROM sysobjects WHERE name='PRODUCTOS_QUE_COMPONE')
		DROP FUNCTION PRODUCTOS_QUE_COMPONE
	IF EXISTS (SELECT name FROM sysobjects WHERE name='TG_NUEVA_COMPOSICION')
		DROP TRIGGER TG_NUEVA_COMPOSICION
	IF EXISTS (SELECT name FROM sysobjects WHERE name='TG_EDITAR_COMPOSICION')
		DROP TRIGGER TG_EDITAR_COMPOSICION
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

-- Creo una función que me retorne los productos compuestos por un producto --
GO
	CREATE FUNCTION PRODUCTOS_QUE_COMPONE (@producto char(8))
	RETURNS TABLE
	RETURN (SELECT comp_componente FROM Composicion WHERE comp_producto = @producto)
GO

-- Creo los triggers necesarios para que se cumpla la regla --
GO
	CREATE TRIGGER TG_NUEVA_COMPOSICION ON Composicion INSTEAD OF INSERT
	AS
	BEGIN
		INSERT INTO Composicion
			SELECT * FROM inserted WHERE (comp_producto NOT IN (SELECT * FROM dbo.PRODUCTOS_QUE_COMPONE(comp_componente)))
	END
GO

GO
	CREATE TRIGGER TG_EDITAR_COMPOSICION ON Composicion INSTEAD OF UPDATE
	AS
	BEGIN
		-- Declaro los datos actuales --
		DECLARE @producto_actual char(8)
		-- Declaro los datos a insertar --
		DECLARE @producto char(2), @producto_compuesto char(8), @cantidad decimal(12, 2)
		-- Genero los cursores correspondientes --
		DECLARE VALORES_ACTUALES CURSOR FOR
			SELECT comp_producto FROM deleted
		DECLARE VALORES_NUEVOS CURSOR FOR
			SELECT comp_producto, comp_componente, comp_cantidad FROM inserted
		-- Declaro dos variables para conocer el estado de cada cursor --
		DECLARE @status_actuales int, @status_nuevos int
		-- Abro los cursores --
		OPEN VALORES_ACTUALES
		OPEN VALORES_NUEVOS
		-- Recorro los cursores --
		FETCH NEXT FROM VALORES_ACTUALES INTO @producto_actual
		SET @status_actuales = @@FETCH_STATUS
		FETCH NEXT FROM VALORES_NUEVOS INTO @producto, @producto_compuesto, @cantidad
		SET @status_nuevos = @@FETCH_STATUS
		WHILE ((@status_actuales = 0) AND (@status_nuevos = 0))
			BEGIN
				-- Realizo la lógica del ejercicio --
				IF(@producto IN (SELECT * FROM dbo.PRODUCTOS_QUE_COMPONE(@producto_compuesto)))
					BEGIN
						RAISERROR('No es posible realizar esta composición, porque el producto %s está incluido en los productos compuestos de %s', 16, 1, @producto, @producto_compuesto)
					END
				ELSE
					BEGIN
						UPDATE Composicion SET comp_producto = @producto, comp_componente = @producto_compuesto, comp_cantidad = @cantidad
						WHERE comp_producto = @producto_actual
					END
				-- Paso a la siguiente fila de cada cursor --
				FETCH NEXT FROM VALORES_ACTUALES INTO @producto_actual
				SET @status_actuales = @@FETCH_STATUS
				FETCH NEXT FROM VALORES_NUEVOS INTO @producto, @producto_compuesto, @cantidad
				SET @status_nuevos = @@FETCH_STATUS
			END
		-- Cierro y elimino los cursores --
		CLOSE VALORES_ACTUALES
		CLOSE VALORES_NUEVOS
		DEALLOCATE VALORES_ACTUALES
		DEALLOCATE VALORES_NUEVOS
	END
GO