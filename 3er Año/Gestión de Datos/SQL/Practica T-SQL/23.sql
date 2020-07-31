USE GD_UTN

-- Elimino los elementos si ya existían previamente --
GO
	IF EXISTS (SELECT name FROM sysobjects WHERE name='ES_PRODUCTO_COMPUESTO')
		DROP FUNCTION ES_PRODUCTO_COMPUESTO
	IF EXISTS (SELECT name FROM sysobjects WHERE name='PRODUCTOS_COMPUESTOS')
		DROP FUNCTION PRODUCTOS_COMPUESTOS
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

-- Creo una función que retorna los productos compuestos de una factura --
GO
	CREATE FUNCTION PRODUCTOS_COMPUESTOS (@factura char(8))
	RETURNS INT
	AS
	BEGIN
		-- Genero la variable que voy a retornar --
		DECLARE @valor_retorno tinyint
		-- Asigno valor a la variable --
		SET @valor_retorno = (SELECT COUNT(DISTINCT item_producto) FROM Factura JOIN Item_Factura ON Factura.fact_numero = Item_Factura.item_numero WHERE (dbo.ES_PRODUCTO_COMPUESTO(item_producto) = 1) AND (fact_numero = @factura))
		-- Retorno el valor esperado --
		RETURN @valor_retorno
	END
GO

-- Creo un trigger al insertar una nueva factura --
GO
	CREATE TRIGGER TRIGGER_NUEVA_COMPRA ON Factura INSTEAD OF INSERT
	AS
	BEGIN
		INSERT INTO Factura
			SELECT * FROM inserted WHERE dbo.PRODUCTOS_COMPUESTOS(fact_numero) <= 2
	END
GO