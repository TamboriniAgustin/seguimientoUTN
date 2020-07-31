USE GD_UTN

-- Elimino el procedimiento y la tabla en caso de que ya existan --
GO
	IF EXISTS (SELECT name FROM sysobjects WHERE name='DIFERENCIAS')
		DROP TABLE DIFERENCIAS
	IF EXISTS (SELECT name FROM sysobjects WHERE name='LLENAR_DIFERENCIAS')
		DROP PROCEDURE LLENAR_DIFERENCIAS
	IF EXISTS (SELECT name FROM sysobjects WHERE name='PRECIO_COMPUESTO')
		DROP FUNCTION PRECIO_COMPUESTO
GO

-- Creo la tabla --
GO
	CREATE TABLE DIFERENCIAS 
	(dif_codigo char(8) NULL, dif_detalle char(50) NULL, dif_cantidad int NULL, dif_precio_generado decimal(12, 2) NULL, dif_precio_facturado decimal(12, 2) NULL)
GO

-- Creo una función auxiliar para calcular el precio compuesto de un producto --
GO
	CREATE FUNCTION PRECIO_COMPUESTO (@producto char(8))
	RETURNS decimal(12, 2)
	AS
	BEGIN
		DECLARE @precio decimal(12,2)

		SELECT @precio = SUM(comp_cantidad * dbo.precio_compuesto(comp_componente)) FROM Composicion
		WHERE comp_producto = @producto

		IF @precio IS NULL
		SET @precio = (SELECT prod_precio FROM Producto WHERE prod_codigo = @producto)
		
		RETURN @precio
	END
GO

-- Creo el procedimiento --
GO
	CREATE PROCEDURE LLENAR_DIFERENCIAS
	AS
	BEGIN
		-- Recorro los artículos que vamos a ingresar generando un cursor, ya que tendremos que iterar los elementos --
		DECLARE cursor_articulos CURSOR LOCAL FORWARD_ONLY FAST_FORWARD
		FOR
		SELECT prod_codigo, prod_detalle, COUNT(*), dbo.PRECIO_COMPUESTO(prod_codigo), prod_precio FROM Producto
		JOIN Composicion ON Producto.prod_codigo = Composicion.comp_producto
		GROUP BY prod_codigo, prod_detalle, prod_precio

		-- Genero las variables sobre las que voy a almacenar los valores de cada recorrido del cursor --
		DECLARE @codigo char(8), @detalle char(50), @cantidad int, @precio_compuesto decimal(12, 2), @precio_facturacion decimal(12, 2)

		-- Abro el cursor generado sobre la consulta realizada --
		OPEN cursor_articulos
		FETCH NEXT FROM cursor_articulos INTO @codigo, @detalle, @cantidad, @precio_compuesto, @precio_facturacion
		WHILE (@@FETCH_STATUS = 0)
			BEGIN
				INSERT INTO DIFERENCIAS(dif_codigo, dif_detalle, dif_cantidad, dif_precio_generado, dif_precio_facturado)
				VALUES (@codigo, @detalle, @cantidad, @precio_compuesto, @precio_facturacion)

				FETCH NEXT FROM cursor_articulos INTO @codigo, @detalle, @cantidad, @precio_compuesto, @precio_facturacion
			END
		CLOSE cursor_articulos
		DEALLOCATE cursor_articulos
	END
GO