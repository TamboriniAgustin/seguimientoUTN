USE GD_UTN

IF EXISTS (SELECT name FROM sysobjects WHERE name='ARREGLAR_COMISION')
	DROP PROCEDURE ARREGLAR_COMISION

GO
	CREATE PROCEDURE ARREGLAR_COMISION(@mejor_vendedor int OUTPUT)
	AS
	BEGIN
		-- Obtengo el �ltimo a�o de facturaci�n --
		DECLARE @ultimo_a�o int
		SET @ultimo_a�o = (SELECT MAX(YEAR(fact_fecha)) FROM Factura)
		-- Realizo la operaci�n para actualizar las comisiones --
		UPDATE Empleado SET empl_comision = ISNULL((SELECT SUM(fact_total) FROM Factura WHERE (fact_vendedor = empl_codigo) AND (fact_fecha = @ultimo_a�o)), 0)
		-- Retorno al mayor vendedor de todos --
		SET @mejor_vendedor = (SELECT TOP 1 empl_codigo FROM Empleado ORDER BY empl_comision DESC)
		PRINT 'El mejor vendedor del a�o fue: ' + STR(@mejor_vendedor)
	END
GO

-- Pruebo el procedimiento --
EXEC dbo.ARREGLAR_COMISION @mejor_vendedor = 0