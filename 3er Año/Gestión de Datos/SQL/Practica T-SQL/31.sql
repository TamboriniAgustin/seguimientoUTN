USE GD_UTN

-- Elimino los elementos si ya existían previamente --
GO
	IF EXISTS (SELECT name FROM sysobjects WHERE name='GERENTE_GENERAL')
		DROP FUNCTION GERENTE_GENERAL
	IF EXISTS (SELECT name FROM sysobjects WHERE name='EMPLEADOS')
		DROP FUNCTION EMPLEADOS
	IF EXISTS (SELECT name FROM sysobjects WHERE name='JEFES_POSIBLES')
		DROP FUNCTION JEFES_POSIBLES
	IF EXISTS (SELECT name FROM sysobjects WHERE name='TG_NUEVO_EMPLEADO')
		DROP TRIGGER TG_NUEVO_EMPLEADO
	IF EXISTS (SELECT name FROM sysobjects WHERE name='TG_EDITAR_EMPLEADO')
		DROP TRIGGER TG_EDITAR_EMPLEADO
GO

-- Creo una función que retorna al gerente general --
GO
	CREATE FUNCTION GERENTE_GENERAL()
	RETURNS INT
	AS
	BEGIN
		DECLARE @valor_retorno int
		SELECT @valor_retorno = empl_codigo FROM Empleado WHERE empl_jefe IS NULL
		RETURN @valor_retorno
	END
GO

-- Creo una función que retorna la cantidad de empleados (directos + indirectos) --
GO
	CREATE FUNCTION EMPLEADOS (@jefe numeric(6, 0))
	RETURNS INT
	AS
	BEGIN
		DECLARE @empleados_directos int
		SET @empleados_directos = (SELECT COUNT(DISTINCT empl_codigo) FROM Empleado WHERE empl_jefe = @jefe)

		DECLARE @empleados int
		SELECT @empleados = ISNULL(@empleados_directos + SUM(dbo.EMPLEADOS(empl_codigo)), 0) FROM Empleado WHERE empl_jefe = @jefe
		RETURN @empleados
	END
GO

-- Creo una función que retorne una tabla con los posibles jefes --
GO
	CREATE FUNCTION JEFES_POSIBLES()
	RETURNS TABLE
	RETURN (SELECT empl_codigo FROM Empleado WHERE (dbo.EMPLEADOS(empl_codigo) < 20) AND (empl_codigo != dbo.GERENTE_GENERAL()))
GO

-- Creo los dos triggers correspondientes para hacer cumplir la regla --
GO
	CREATE TRIGGER TG_NUEVO_EMPLEADO ON Empleado FOR INSERT
	AS
	BEGIN
		-- Tomo los valores de interes del empleado insertado --
		DECLARE @empleado numeric(6, 0)
			SET @empleado = (SELECT empl_codigo FROM inserted)
		DECLARE @jefe numeric(6, 0)
			SET @jefe = (SELECT empl_jefe FROM inserted)
		-- Si el jefe tiene más de 20 empleados, tendré que reasignarlo --
		IF(dbo.EMPLEADOS(@jefe) >= 20)
			BEGIN
				-- Si encuentro algún jefe posible, lo asigno --
				DECLARE @nuevo_jefe numeric(6, 0)
				SET @nuevo_jefe = (SELECT TOP 1 empl_codigo FROM dbo.JEFES_POSIBLES())
				-- Si no hay ningún jefe posible, le asigno el gerente general --
				IF(@nuevo_jefe IS NULL)
					SET @nuevo_jefe = dbo.GERENTE_GENERAL()
				-- Realizo los cambios necesarios --
				UPDATE Empleado SET empl_jefe = @nuevo_jefe WHERE empl_codigo = @empleado
			END
	END
GO

GO
	CREATE TRIGGER TG_EDITAR_EMPLEADO ON Empleado FOR UPDATE
	AS
	BEGIN
		-- Tomo los valores de interes del empleado insertado --
		DECLARE @empleado numeric(6, 0)
		DECLARE @jefe numeric(6, 0)
		-- Declaro un cursor, ya que tendré que analizar cada uno de los empleados que se actualizaron --
		DECLARE CURSOR_EMPLEADOS CURSOR FOR (SELECT empl_codigo, empl_jefe FROM inserted)
		OPEN CURSOR_EMPLEADOS
		FETCH NEXT FROM CURSOR_EMPLEADOS INTO @empleado, @jefe
		WHILE(@@FETCH_STATUS = 0)
			BEGIN
				-- Si el jefe tiene más de 20 empleados, tendré que reasignarlo --
				IF(dbo.EMPLEADOS(@jefe) >= 20)
					BEGIN
						-- Si encuentro algún jefe posible, lo asigno --
						DECLARE @nuevo_jefe numeric(6, 0)
						SET @nuevo_jefe = (SELECT TOP 1 empl_codigo FROM dbo.JEFES_POSIBLES())
						-- Si no hay ningún jefe posible, le asigno el gerente general --
						IF(@nuevo_jefe IS NULL)
							SET @nuevo_jefe = dbo.GERENTE_GENERAL()
						-- Realizo los cambios necesarios --
						UPDATE Empleado SET empl_jefe = @nuevo_jefe WHERE empl_codigo = @empleado
					END
				-- Paso al siguiente empleado --
				FETCH NEXT FROM CURSOR_EMPLEADOS INTO @empleado, @jefe
			END
		CLOSE CURSOR_EMPLEADOS
		DEALLOCATE CURSOR_EMPLEADOS
	END
GO