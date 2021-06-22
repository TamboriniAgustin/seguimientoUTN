USE GD_UTN

-- Creo la tabla que el ejercicio indica --
IF OBJECT_ID('Fact_table', 'U') IS NOT NULL 
	DROP TABLE Fact_table

GO
	CREATE TABLE Fact_table (anio char(4) NOT NULL, mes char(2) NOT NULL, familia char(3) NOT NULL, rubro char(4) NOT NULL, zona char(3) NOT NULL, cliente char(6) NOT NULL, producto char(8) NOT NULL, cantidad decimal(12,2), monto decimal(12,2))
	ALTER TABLE Fact_table
	ADD CONSTRAINT pk_Fact_table_ID PRIMARY KEY (anio, mes, familia, rubro, zona, cliente, producto)
GO

-- Pruebo la tabla --
SELECT * FROM Fact_table

-- Creo el procedimiento para resolver el ejercicio --
IF EXISTS (SELECT name FROM sysobjects WHERE name='COMPLETAR_TABLA')
	DROP PROCEDURE COMPLETAR_TABLA

GO
	CREATE PROCEDURE COMPLETAR_TABLA
	AS
	BEGIN
		INSERT INTO Fact_table
			SELECT 
				YEAR(f1.fact_fecha), 
				RIGHT('0' + CONVERT(varchar(2), MONTH(f1.fact_fecha)), 2),
				p1.prod_familia,
				p1.prod_rubro,
				d1.depa_zona,
				f1.fact_cliente,
				p1.prod_codigo,
				SUM(if1.item_cantidad),
				SUM(if1.item_precio)
			FROM Factura f1
			JOIN Item_Factura if1 ON f1.fact_numero = if1.item_numero
			JOIN Producto p1 ON if1.item_producto = p1.prod_codigo
			JOIN Empleado e1 ON f1.fact_vendedor = e1.empl_codigo
			JOIN Departamento d1 ON e1.empl_departamento = d1.depa_codigo
			GROUP BY YEAR(f1.fact_fecha), RIGHT('0' + CONVERT(varchar(2), MONTH(f1.fact_fecha)), 2), p1.prod_familia, p1.prod_rubro, d1.depa_zona, f1.fact_cliente, p1.prod_codigo
	END
GO

-- Pruebo el procedimiento --
EXEC dbo.COMPLETAR_TABLA
SELECT * FROM Fact_table