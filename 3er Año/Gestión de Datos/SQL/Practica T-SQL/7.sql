USE GD_UTN

-- Elimino el procedimiento y la tabla en caso de que ya existan --
GO
	IF EXISTS (SELECT name FROM sysobjects WHERE name='VENTAS')
		DROP TABLE VENTAS
	IF EXISTS (SELECT name FROM sysobjects WHERE name='LLENAR_VENTAS')
		DROP PROCEDURE LLENAR_VENTAS
GO

-- Creo la tabla --
GO
	CREATE TABLE VENTAS 
	(vent_codigo char(8) NULL, vent_detalle char(50) NULL, vent_movimientos int NULL, vent_precio decimal(12, 2) NULL, vent_renglon int PRIMARY KEY IDENTITY(1, 1), vent_ganancia decimal(12, 2) NULL)
GO

-- Creo el procedimiento --
GO
	CREATE PROCEDURE LLENAR_VENTAS (@fecha1 smalldatetime, @fecha2 smalldatetime)
	AS
	BEGIN
		-- Obtengo la fecha mayor y la fecha menor --
		DECLARE @fecha_mayor smalldatetime
		DECLARE @fecha_menor smalldatetime
		IF (@fecha1 > @fecha2)
			BEGIN
				SET @fecha_mayor = @fecha1
				SET @fecha_menor = @fecha2
			END
		ELSE 
			BEGIN
				SET @fecha_mayor = @fecha1
				SET @fecha_menor = @fecha2
			END
		
		-- Recorro los artículos que vamos a ingresar generando un cursor, ya que tendremos que iterar los elementos --
		DECLARE cursor_articulos CURSOR LOCAL FORWARD_ONLY FAST_FORWARD
		FOR
		SELECT prod_codigo, prod_detalle, SUM(item_cantidad), AVG(item_precio), SUM(item_cantidad * item_precio) FROM Producto
		LEFT JOIN Item_Factura ON Producto.prod_codigo = Item_Factura.item_producto
		JOIN Factura ON Item_Factura.item_numero = Factura.fact_numero
		WHERE fact_fecha BETWEEN @fecha_menor AND @fecha_mayor
		GROUP BY prod_codigo, prod_detalle

		-- Genero las variables sobre las que voy a almacenar los valores de cada recorrido del cursor --
		DECLARE @codigo char(8), @detalle char(50), @movimientos int, @precio decimal(12, 2), @ganancia decimal(12, 2)

		-- Abro el cursor generado sobre la consulta realizada --
		OPEN cursor_articulos
		FETCH NEXT FROM cursor_articulos INTO @codigo, @detalle, @movimientos, @precio, @ganancia
		WHILE (@@FETCH_STATUS = 0)
			BEGIN
				INSERT INTO VENTAS (vent_codigo, vent_detalle, vent_movimientos, vent_precio, vent_ganancia)
				VALUES (@codigo, @detalle, @movimientos, @precio, @ganancia)

				FETCH NEXT FROM cursor_articulos INTO @codigo, @detalle, @movimientos, @precio, @ganancia
			END
		CLOSE cursor_articulos
		DEALLOCATE cursor_articulos
	END
GO