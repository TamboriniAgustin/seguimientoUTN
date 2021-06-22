USE GD_UTN

-- Elimino los elementos si ya existían previamente --
GO
	IF EXISTS (SELECT name FROM sysobjects WHERE name='PRECIO_COMPONENTES')
		DROP FUNCTION PRECIO_COMPONENTES
	IF EXISTS (SELECT name FROM sysobjects WHERE name='PRECIO_PRODUCTO')
		DROP FUNCTION PRECIO_PRODUCTO
GO

-- Creo una función para verificar si un producto es compuesto --
GO
	CREATE FUNCTION PRECIO_COMPONENTES (@producto char(8))
	RETURNS DECIMAL(12, 2)
	AS
	BEGIN
		-- Genero la variable que voy a retornar --
		DECLARE @valor_retorno decimal(12, 2)
		-- Asigno valor a la variable --
		SET @valor_retorno = (
								SELECT ISNULL(SUM((prod_precio * comp_cantidad) + dbo.PRECIO_COMPONENTES(prod_codigo)), 0) FROM Composicion
								JOIN Producto ON Composicion.comp_componente = Producto.prod_codigo
								WHERE comp_producto = @producto
							 )
		-- Retorno el valor esperado --
		RETURN @valor_retorno
	END
GO

-- Creo la función que representará al objeto principal --
GO
	CREATE FUNCTION PRECIO_PRODUCTO (@producto char(8))
	RETURNS DECIMAL(12, 2)
	AS
	BEGIN
		-- Genero la variable a retornar --
		DECLARE @precio_producto decimal(12, 2)
		-- Asigno valor a la variable --
		SELECT @precio_producto = (prod_precio + dbo.PRECIO_COMPONENTES(prod_codigo)) FROM Producto WHERE prod_codigo = @producto
		-- Retorno el valor del producto --
		RETURN @precio_producto
	END
GO