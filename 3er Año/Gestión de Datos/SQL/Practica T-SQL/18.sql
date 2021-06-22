USE GD_UTN

-- Elimino el trigger en caso de que ya exista --
GO
	IF EXISTS (SELECT name FROM sysobjects WHERE name='TRIGGER_VALIDAR_FACTURA')
		DROP TRIGGER TRIGGER_VALIDAR_FACTURA
GO

-- Genero los triggers correspondientes al ejercicio --
GO
	CREATE TRIGGER TRIGGER_VALIDAR_FACTURA ON Factura INSTEAD OF INSERT
	AS
	BEGIN
		-- Analizo si se cumple que el stock es menor que el stoc maximo y mayor que el stock minimo --
		IF EXISTS(SELECT * FROM inserted JOIN Cliente ON (inserted.fact_total + inserted.fact_total_impuestos) > Cliente.clie_limite_credito)
			BEGIN
				RAISERROR('No se puede realizar la factura ya que el cliente no tiene crédito suficiente', 1, 1)
			END
		ELSE
			BEGIN
				INSERT INTO Factura
					SELECT * FROM inserted
			END
	END
GO