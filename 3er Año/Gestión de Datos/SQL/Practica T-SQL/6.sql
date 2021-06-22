USE GD_UTN

-- Elimino el procedimiento en caso de que ya exista --
GO
	IF EXISTS (SELECT name FROM sysobjects WHERE name='AJUSTAR_COMBOS')
		DROP PROCEDURE AJUSTAR_COMBOS
GO

-- Creo el procedimiento --
GO
	CREATE PROCEDURE AJUSTAR_COMBOS (@producto char(8), @factura char(8))
	AS
	BEGIN
		-- Verifico que el producto esté en la factura --
		IF (@producto IN (SELECT item_producto FROM Item_Factura WHERE item_numero = @factura))
			-- Verifico que los componentes del producto estén en la factura --
			DECLARE @componentes_del_producto int
			SELECT @componentes_del_producto = COUNT(*) FROM Composicion WHERE comp_producto = @producto

			DECLARE @componentes_en_factura int
			SELECT @componentes_en_factura = COUNT(DISTINCT item_producto) FROM Item_Factura 
			JOIN Composicion ON (Item_Factura.item_producto = Composicion.comp_componente) AND (Composicion.comp_producto = @producto)
			WHERE item_numero = @factura

			IF (@componentes_del_producto = @componentes_en_factura)
				-- Corrijo las filas --
				BEGIN
					DECLARE @sucursal char(4)
					DECLARE @tipo_factura char(1)
					SELECT @sucursal = fact_sucursal, @tipo_factura = fact_tipo FROM Factura WHERE fact_numero = @factura

					DECLARE @cantidad int
					SELECT @cantidad = MIN(item_cantidad/comp_cantidad) FROM Item_Factura
					JOIN Composicion ON Item_Factura.item_producto = Composicion.comp_componente
					WHERE (item_numero = @factura) AND (comp_producto = @producto)

					DECLARE @precio decimal(12, 2)
					SELECT @precio = (prod_precio * @cantidad) FROM Producto WHERE prod_codigo = @producto

					-- Si puedo armar al menos un combo, hago los cambios necesarios --
					IF (@cantidad > 0)
						DELETE FROM Item_Factura 
						WHERE (item_producto IN (SELECT comp_componente FROM Composicion WHERE comp_producto = @producto)) AND (item_numero = @factura)
				
						INSERT INTO Item_Factura (item_numero, item_tipo, item_sucursal, item_producto, item_cantidad, item_precio) 
						VALUES (@factura, @sucursal, @tipo_factura, @producto, @cantidad, @precio)
				END
	END
GO

-- Pruebo el procedimiento --
EXEC dbo.AJUSTAR_COMBOS '00001000', '00068710' 