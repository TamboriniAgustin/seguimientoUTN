USE GD_UTN

-- Elimino la funci�n si ya exist�a previamente --
IF EXISTS (SELECT name FROM sysobjects WHERE name='EMPLEADOS_A_CARGO')
	DROP FUNCTION EMPLEADOS_A_CARGO

-- Creo la funci�n --
GO
CREATE FUNCTION EMPLEADOS_A_CARGO (@empleado numeric(6))
RETURNS INT
BEGIN 
	-- Tomo variables de inter�s --
	DECLARE @cantidad int
	DECLARE @codigo_empleado numeric(6)
	-- Asigno valores a dichas variables --
	SELECT @codigo_empleado = empl_codigo FROM Empleado WHERE empl_jefe = @empleado
	SELECT @cantidad = ISNULL(SUM(dbo.EMPLEADOS_A_CARGO(empl_codigo) + 1), 0) FROM Empleado WHERE (empl_jefe = @empleado) AND (@codigo_empleado > (SELECT empl_codigo FROM Empleado WHERE empl_codigo = @empleado))
	-- Retorno el valor esperado --
	RETURN @cantidad
END
GO

-- Pruebo la funci�n --
SELECT empl_codigo, dbo.EMPLEADOS_A_CARGO(empl_codigo) AS empleados_a_cargo FROM Empleado