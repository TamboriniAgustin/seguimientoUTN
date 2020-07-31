USE GD_UTN

-- Elimino los elementos si ya existían previamente --
GO
	IF EXISTS (SELECT name FROM sysobjects WHERE name='GERENTE_GENERAL')
		DROP FUNCTION GERENTE_GENERAL
	IF EXISTS (SELECT name FROM sysobjects WHERE name='ANTIGUEDAD_EMPLEADO')
		DROP FUNCTION ANTIGUEDAD_EMPLEADO
	IF EXISTS (SELECT name FROM sysobjects WHERE name='EMPLEADOS_A_CARGO')
		DROP FUNCTION EMPLEADOS_A_CARGO
	IF EXISTS (SELECT name FROM sysobjects WHERE name='EMPLEADOS')
		DROP FUNCTION EMPLEADOS
	IF EXISTS (SELECT name FROM sysobjects WHERE name='TRIGGER_INSERTAR_JEFE')
		DROP TRIGGER TRIGGER_INSERTAR_JEFE
	IF EXISTS (SELECT name FROM sysobjects WHERE name='TRIGGER_ACTUALIZAR_JEFE')
		DROP TRIGGER TRIGGER_ACTUALIZAR_JEFE
GO

-- Creo una función que me devuelve el gerente general actual --
GO
	CREATE FUNCTION GERENTE_GENERAL ()
	RETURNS NUMERIC(6, 0)
	AS
	BEGIN
		-- Genero la variable de retorno --
		DECLARE @gerente_general numeric(6, 0)
		-- Asigno valor a la variable --
		SET @gerente_general = (SELECT empl_codigo FROM Empleado WHERE empl_jefe IS NULL)
		-- Retorno la variable --
		RETURN @gerente_general
	END
GO

-- Creo una función para analizar la antiguedad de un empleado --
GO
	CREATE FUNCTION ANTIGUEDAD_EMPLEADO (@empleado numeric(6, 0))
	RETURNS SMALLDATETIME
	AS
	BEGIN
		-- Genero la variable de retorno --
		DECLARE @antiguedad smalldatetime
		-- Asigno valor a la variable --
		SET @antiguedad = CONVERT(SMALLDATETIME, GETDATE())- (SELECT empl_ingreso FROM Empleado WHERE empl_codigo = @empleado)
		-- Retorno la variable --
		RETURN @antiguedad
	END
GO

-- Creo una función para conocer los empleados a cargo --
GO
	CREATE FUNCTION EMPLEADOS_A_CARGO (@jefe numeric(6, 0))
	RETURNS INT
	AS
	BEGIN
		-- Declaro variables de interés --
		DECLARE @empleados decimal(12, 2)
		-- Asigno valor a las variables --
		SELECT @empleados = ISNULL(SUM(COUNT(*) + dbo.EMPLEADOS_A_CARGO(empl_codigo)), 0) FROM Empleado WHERE empl_jefe = @jefe
		-- Retorno el valor necesario --
		RETURN @empleados
	END
GO

-- Creo una función para conocer los empleados totales --
GO
	CREATE FUNCTION EMPLEADOS ()
	RETURNS INT
	AS
	BEGIN
		-- Declaro variables de interés --
		DECLARE @empleados decimal(12, 2)
		-- Asigno valor a las variables --
		SELECT @empleados = COUNT(*) FROM Empleado
		-- Retorno el valor necesario --
		RETURN @empleados
	END
GO

-- Creo los triggers correspondientes --
GO
	CREATE TRIGGER TRIGGER_INSERTAR_JEFE ON Empleado INSTEAD OF INSERT
	AS
	BEGIN
		-- Creo variables de interés para utilizar luego --
		DECLARE @codigo_empleado numeric(6, 0)
		DECLARE @nombre_empleado char(50)
		DECLARE @apellido_empleado char(50)
		DECLARE @nacimiento_empleado smalldatetime
		DECLARE @ingreso_empleado smalldatetime
		DECLARE @tareas_empleado char(100)
		DECLARE @salario_empleado decimal(12, 2)
		DECLARE @comision_empleado decimal(12, 2)
		DECLARE @jefe_empleado numeric(6, 0)
		DECLARE @departamento_empleado numeric(6, 0)
		-- Defino el cursor que voy a utilizar con las tablas INSERTED y DELETED --
		DECLARE CURSOR_NUEVO_EMPLEADO CURSOR FOR
			SELECT i.empl_codigo, i.empl_nombre, i.empl_apellido, i.empl_nacimiento, i.empl_ingreso, i.empl_tareas, i.empl_salario, i.empl_comision, i.empl_jefe, i.empl_departamento FROM inserted i
		-- Abro el cursor para recorrer la tabla obtenida y así insertar los productos que tenga que insertar --
		OPEN CURSOR_NUEVO_EMPLEADO
		FETCH NEXT FROM CURSOR_NUEVO_EMPLEADO INTO @codigo_empleado, @nombre_empleado, @apellido_empleado, @nacimiento_empleado, @ingreso_empleado, @tareas_empleado, @salario_empleado, @comision_empleado, @jefe_empleado, @departamento_empleado
		WHILE @@FETCH_STATUS = 0
			BEGIN
				-- Obtengo datos de interés --
				DECLARE @antiguedad_jefe smalldatetime
				DECLARE @empleados_a_cargo int
				SET @antiguedad_jefe = dbo.ANTIGUEDAD_EMPLEADO(@jefe_empleado)
				SET @empleados_a_cargo = dbo.EMPLEADOS_A_CARGO(@jefe_empleado)
				-- Inserto los jefes correspondientes --
				IF ((YEAR(@antiguedad_jefe) >= 5) AND ((@empleados_a_cargo <= (dbo.EMPLEADOS() / 2)) OR @jefe_empleado = dbo.GERENTE_GENERAL()))
					INSERT INTO Empleado (empl_codigo, empl_nombre, empl_apellido, empl_nacimiento, empl_ingreso, empl_tareas, empl_salario, empl_comision, empl_jefe, empl_departamento) VALUES (@codigo_empleado, @nombre_empleado, @apellido_empleado, @nacimiento_empleado, @ingreso_empleado, @tareas_empleado, @salario_empleado, @comision_empleado, @jefe_empleado, @departamento_empleado)
				ELSE
					RAISERROR('El jefe debe tener 5 años de antiguedad y puede tener bajo su cargo al 50% de los empleados como mucho (salvo que sea el gerente general)', 16, 1) 
				-- Paso a la siguiente fila --
				FETCH NEXT FROM CURSOR_NUEVO_EMPLEADO INTO @codigo_empleado, @nombre_empleado, @apellido_empleado, @nacimiento_empleado, @ingreso_empleado, @tareas_empleado, @salario_empleado, @comision_empleado, @jefe_empleado, @departamento_empleado
			END
		-- Cierro el cursor y libero memoria --
		CLOSE CURSOR_NUEVO_EMPLEADO
		DEALLOCATE CURSOR_NUEVO_EMPLEADO
	END
GO

GO
	CREATE TRIGGER TRIGGER_ACTUALIZAR_JEFE ON Empleado INSTEAD OF UPDATE
	AS
	BEGIN
		-- Creo variables de interés para utilizar luego --
		DECLARE @codigo_empleado numeric(6, 0)
		DECLARE @nombre_empleado char(50)
		DECLARE @apellido_empleado char(50)
		DECLARE @nacimiento_empleado smalldatetime
		DECLARE @ingreso_empleado smalldatetime
		DECLARE @tareas_empleado char(100)
		DECLARE @salario_empleado decimal(12, 2)
		DECLARE @comision_empleado decimal(12, 2)
		DECLARE @jefe_empleado numeric(6, 0)
		DECLARE @departamento_empleado numeric(6, 0)
		-- Defino el cursor que voy a utilizar con las tablas INSERTED y DELETED --
		DECLARE CURSOR_EDITAR_EMPLEADO CURSOR FOR
			SELECT i.empl_codigo, i.empl_nombre, i.empl_apellido, i.empl_nacimiento, i.empl_ingreso, i.empl_tareas, i.empl_salario, i.empl_comision, i.empl_jefe, i.empl_departamento FROM inserted i
			JOIN deleted d ON d.empl_codigo = i.empl_codigo
			WHERE d.empl_jefe != i.empl_jefe
		-- Abro el cursor para recorrer la tabla obtenida y así insertar los productos que tenga que insertar --
		OPEN CURSOR_EDITAR_EMPLEADO
		FETCH NEXT FROM CURSOR_EDITAR_EMPLEADO INTO @codigo_empleado, @nombre_empleado, @apellido_empleado, @nacimiento_empleado, @ingreso_empleado, @tareas_empleado, @salario_empleado, @comision_empleado, @jefe_empleado, @departamento_empleado
		WHILE @@FETCH_STATUS = 0
			BEGIN
				-- Obtengo el salario de los empleados actuales del jefe del nuevo empleado y del jefe --
				DECLARE @antiguedad_jefe smalldatetime
				DECLARE @empleados_a_cargo int
				SET @antiguedad_jefe = dbo.ANTIGUEDAD_EMPLEADO(@jefe_empleado)
				SET @empleados_a_cargo = dbo.EMPLEADOS_A_CARGO(@jefe_empleado)
				-- Inserto los correspondientes --
				IF ((YEAR(@antiguedad_jefe) >= 5) AND ((@empleados_a_cargo <= (dbo.EMPLEADOS() / 2)) OR @jefe_empleado = dbo.GERENTE_GENERAL()))
					UPDATE Empleado SET empl_codigo = @codigo_empleado, empl_nombre = @nombre_empleado, empl_apellido = @apellido_empleado, empl_nacimiento = @nacimiento_empleado, empl_ingreso = @ingreso_empleado, empl_tareas = @tareas_empleado, empl_salario = @salario_empleado, empl_comision = @comision_empleado, empl_jefe = @jefe_empleado, empl_departamento = @departamento_empleado
				ELSE
					RAISERROR('El jefe debe tener 5 años de antiguedad y puede tener bajo su cargo al 50% de los empleados como mucho (salvo que sea el gerente general)', 16, 1) 
				-- Paso a la siguiente fila --
				FETCH NEXT FROM CURSOR_EDITAR_EMPLEADO INTO @codigo_empleado, @nombre_empleado, @apellido_empleado, @nacimiento_empleado, @ingreso_empleado, @tareas_empleado, @salario_empleado, @comision_empleado, @jefe_empleado, @departamento_empleado
			END
		-- Cierro el cursor y libero memoria --
		CLOSE CURSOR_EDITAR_EMPLEADO
		DEALLOCATE CURSOR_EDITAR_EMPLEADO
	END
GO