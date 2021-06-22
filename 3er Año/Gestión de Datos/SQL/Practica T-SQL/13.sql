USE GD_UTN

-- Elimino los elementos si ya existían previamente --
GO
	IF EXISTS (SELECT name FROM sysobjects WHERE name='SALARIO_EMPLEADOS')
		DROP FUNCTION SALARIO_EMPLEADOS
	IF EXISTS (SELECT name FROM sysobjects WHERE name='TRIGGER_INSERTAR_JEFE')
		DROP TRIGGER TRIGGER_INSERTAR_JEFE
	IF EXISTS (SELECT name FROM sysobjects WHERE name='TRIGGER_ACTUALIZAR_JEFE')
		DROP TRIGGER TRIGGER_ACTUALIZAR_JEFE
GO

-- Creo una función para calcular el salario de los empleados de un determinado jefe --
GO
	CREATE FUNCTION SALARIO_EMPLEADOS (@jefe char(8))
	RETURNS DECIMAL(12, 2)
	AS
	BEGIN
		-- Declaro variables de interés --
		DECLARE @salario_empleados decimal(12, 2)
		-- Asigno valor a las variables --
		SELECT @salario_empleados = ISNULL(SUM(dbo.SALARIO_EMPLEADOS(empl_codigo) + empl_salario), 0) FROM Empleado WHERE empl_jefe = @jefe
		-- Retorno el valor necesario --
		RETURN @salario_empleados
	END
GO

-- Creo un trigger al momento de insertar un nuevo jefe --
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
				-- Obtengo el salario de los empleados actuales del jefe del nuevo empleado y del jefe --
				DECLARE @salario_empleados_jefe decimal(12, 2)
				DECLARE @salario_jefe decimal(12, 2)
				SET @salario_empleados_jefe = dbo.SALARIO_EMPLEADOS(@jefe_empleado)
				SET @salario_jefe = (SELECT empl_salario FROM Empleado WHERE empl_codigo = @jefe_empleado)
				-- Inserto los correspondientes --
				IF (@salario_jefe <= (@salario_empleados_jefe * 0.2))
					INSERT INTO Empleado (empl_codigo, empl_nombre, empl_apellido, empl_nacimiento, empl_ingreso, empl_tareas, empl_salario, empl_comision, empl_jefe, empl_departamento) VALUES (@codigo_empleado, @nombre_empleado, @apellido_empleado, @nacimiento_empleado, @ingreso_empleado, @tareas_empleado, @salario_empleado, @comision_empleado, @jefe_empleado, @departamento_empleado)
				ELSE
					RAISERROR('No se puede insertar el nuevo empleado ya que el Jefe no puede cobrar un 20% más que todos sus empleados juntos', 16, 1) 
				-- Paso a la siguiente fila --
				FETCH NEXT FROM CURSOR_NUEVO_EMPLEADO INTO @codigo_empleado, @nombre_empleado, @apellido_empleado, @nacimiento_empleado, @ingreso_empleado, @tareas_empleado, @salario_empleado, @comision_empleado, @jefe_empleado, @departamento_empleado
			END
		-- Cierro el cursor y libero memoria --
		CLOSE CURSOR_NUEVO_EMPLEADO
		DEALLOCATE CURSOR_NUEVO_EMPLEADO
	END
GO

-- Creo un trigger al momento de actualizar un nuevo jefe --
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
				DECLARE @salario_empleados_jefe decimal(12, 2)
				DECLARE @salario_jefe decimal(12, 2)
				SET @salario_empleados_jefe = dbo.SALARIO_EMPLEADOS(@jefe_empleado)
				SET @salario_jefe = (SELECT empl_salario FROM Empleado WHERE empl_codigo = @jefe_empleado)
				-- Inserto los correspondientes --
				IF (@salario_jefe <= (@salario_empleados_jefe * 0.2))
					UPDATE Empleado SET empl_codigo = @codigo_empleado, empl_nombre = @nombre_empleado, empl_apellido = @apellido_empleado, empl_nacimiento = @nacimiento_empleado, empl_ingreso = @ingreso_empleado, empl_tareas = @tareas_empleado, empl_salario = @salario_empleado, empl_comision = @comision_empleado, empl_jefe = @jefe_empleado, empl_departamento = @departamento_empleado
				ELSE
					RAISERROR('No se puede actualizar al empleado ya que el nuevo Jefe no puede cobrar un 20% más que todos sus empleados juntos', 16, 1) 
				-- Paso a la siguiente fila --
				FETCH NEXT FROM CURSOR_EDITAR_EMPLEADO INTO @codigo_empleado, @nombre_empleado, @apellido_empleado, @nacimiento_empleado, @ingreso_empleado, @tareas_empleado, @salario_empleado, @comision_empleado, @jefe_empleado, @departamento_empleado
			END
		-- Cierro el cursor y libero memoria --
		CLOSE CURSOR_EDITAR_EMPLEADO
		DEALLOCATE CURSOR_EDITAR_EMPLEADO
	END
GO