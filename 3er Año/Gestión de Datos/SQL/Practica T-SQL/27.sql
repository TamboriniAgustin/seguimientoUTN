USE GD_UTN

-- Elimino los elementos si ya existían previamente --
GO
	IF EXISTS (SELECT name FROM sysobjects WHERE name='ES_JEFE')
		DROP FUNCTION ES_JEFE
	IF EXISTS (SELECT name FROM sysobjects WHERE name='ES_VENDEDOR')
		DROP FUNCTION ES_VENDEDOR
	IF EXISTS (SELECT name FROM sysobjects WHERE name='DEPOSITOS_EMPLEADO')
		DROP FUNCTION DEPOSITOS_EMPLEADO
	IF EXISTS (SELECT name FROM sysobjects WHERE name='EMPLEADOS_DISPONIBLES')
		DROP FUNCTION EMPLEADOS_DISPONIBLES
	IF EXISTS (SELECT name FROM sysobjects WHERE name='REASIGNAR_ENCARGADOS_DEPOSITO')
		DROP PROCEDURE REASIGNAR_ENCARGADOS_DEPOSITO
GO

-- Creo una  función que me dice si un empleado es jefe --
GO
	CREATE FUNCTION ES_JEFE (@empleado numeric(6, 0))
	RETURNS TINYINT
	AS
	BEGIN
		DECLARE @valor_retorno tinyint

		IF(@empleado IN (SELECT DISTINCT empl_jefe FROM Empleado WHERE empl_jefe IS NOT NULL))
			SET @valor_retorno = 1
		ELSE
			SET @valor_retorno = 0

		RETURN @valor_retorno
	END
GO

-- Creo una función que me dice si un empleado es vendedor --
GO
	CREATE FUNCTION ES_VENDEDOR (@empleado numeric(6, 0))
	RETURNS TINYINT
	AS
	BEGIN
		DECLARE @valor_retorno tinyint

		IF(@empleado IN (SELECT DISTINCT clie_vendedor FROM Cliente WHERE clie_vendedor IS NOT NULL))
			SET @valor_retorno = 1
		ELSE
			SET @valor_retorno = 0

		RETURN @valor_retorno
	END
GO

-- Creo una función que me diga la cantidad de depositos asignados de un empleado determinado --
GO
	CREATE FUNCTION DEPOSITOS_EMPLEADO (@empleado numeric(6, 0))
	RETURNS INT
	AS
	BEGIN
		DECLARE @valor_retorno int

		SET @valor_retorno = (SELECT COUNT(*) FROM DEPOSITO WHERE depo_encargado = @empleado)

		RETURN @valor_retorno
	END
GO

-- Creo una función que me devuelva a los empleados que no son jefes ni tampoco vendedores --
GO
	CREATE FUNCTION EMPLEADOS_DISPONIBLES ()
	RETURNS TABLE
	RETURN (SELECT empl_codigo, dbo.DEPOSITOS_EMPLEADO(empl_codigo) AS depositos_asignados FROM Empleado WHERE (dbo.ES_JEFE(empl_codigo) = 0)  AND (dbo.ES_VENDEDOR(empl_codigo) = 0))
GO

-- Creo el procedimiento para reasignar a los encargados de depósito --
GO
	CREATE PROCEDURE REASIGNAR_ENCARGADOS_DEPOSITO
	AS
	BEGIN
		-- Declaro las variables de utilidad a la hora de recorrer los depósitos actuales --
		DECLARE @codigo_deposito char(2)
		DECLARE @encargado_deposito numeric(6, 0)
		-- Declaro un cursor para recorrer la tabla de depósitos --
		DECLARE CURSOR_DEPOSITO CURSOR FOR (SELECT depo_codigo, depo_encargado FROM DEPOSITO)
		OPEN CURSOR_DEPOSITO
		FETCH NEXT FROM CURSOR_DEPOSITO INTO @codigo_deposito, @encargado_deposito
		WHILE(@@FETCH_STATUS = 0)
			BEGIN
				-- Obtengo el primer empleado disponible para poder ser el nuevo encargado --
				DECLARE @nuevo_encargado numeric(6, 0)
				SET @nuevo_encargado = (SELECT TOP 1 empl_codigo FROM dbo.EMPLEADOS_DISPONIBLES() ORDER BY depositos_asignados ASC)
				-- Reasigno el encargado del depósito en caso de que no sea el primero disponible --
				IF(@encargado_deposito != @nuevo_encargado)
					BEGIN
						UPDATE DEPOSITO SET depo_encargado = @nuevo_encargado WHERE depo_codigo = @codigo_deposito
						PRINT CONCAT('El depósito ', @codigo_deposito, ' ha cambiado al encargado ', @encargado_deposito, ' por el encargado ', @nuevo_encargado)
					END
				-- Paso al siguiente cursor --
				FETCH NEXT FROM CURSOR_DEPOSITO INTO @codigo_deposito, @encargado_deposito
			END
		CLOSE CURSOR_DEPOSITO
		DEALLOCATE CURSOR_DEPOSITO
	END
GO