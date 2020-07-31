USE GD_UTN

-- Armo un procedimiento para modificar el gerente mejor pago --
IF EXISTS (SELECT name FROM sysobjects WHERE name='ARREGLAR_GERENTE_GENERAL')
	DROP PROCEDURE ARREGLAR_GERENTE_GENERAL

GO
	CREATE PROCEDURE ARREGLAR_GERENTE_GENERAL(@cantidad_empleados_sin_jefe int OUTPUT)
	AS
	BEGIN
		-- Genero variables de interés --
		DECLARE @nuevo_jefe int
		DECLARE @empleados_sin_jefe TABLE(empl_codigo int)
		-- Inserto los empleados que pueden ser gerentes --
		INSERT INTO @empleados_sin_jefe
			SELECT empl_codigo FROM Empleado
			WHERE empl_jefe IS NULL
			ORDER BY empl_salario DESC, empl_ingreso DESC
		-- Seteo la cantidad de empleados sin jefe hasta el momento --
		SET @cantidad_empleados_sin_jefe = (SELECT COUNT(*) FROM @empleados_sin_jefe)
		-- Seteo como nuevo jefe de los que no llegan a ser gerentes generales al gerente general --
		IF (@cantidad_empleados_sin_jefe > 1)
			BEGIN
				SELECT TOP 1 @nuevo_jefe = empl_codigo FROM @empleados_sin_jefe

				UPDATE Empleado SET empl_jefe = @nuevo_jefe WHERE (empl_jefe IS NULL) AND (empl_codigo != @nuevo_jefe)
			END
		
		PRINT 'Cantidad de empleados que no tenían jefe: ' + STR(@cantidad_empleados_sin_jefe) 
	END
GO

-- Pruebo el procedimiento --
EXEC dbo.ARREGLAR_GERENTE_GENERAL @cantidad_empleados_sin_jefe = 0