USE GD_UTN

/*
	Agregar el/los objetos necesarios para que se permita mantener la siguiente restricción:
	Nunca un jefe va a poder tener más de 20 personas a cargo y menos de 1.
	Nota: Considerar solo 1 nivel de la relación empleado-jefe.
*/
GO
	-- Para evitar colisiones, elimino los objetos --
	IF EXISTS (SELECT name FROM sysobjects WHERE name='EMPLEADOS_BAJO_CARGO')
		DROP FUNCTION EMPLEADOS_BAJO_CARGO
	IF EXISTS (SELECT name FROM sysobjects WHERE name='CUMPLE_CONDICION_JEFE')
		DROP FUNCTION CUMPLE_CONDICION_JEFE
	IF EXISTS (SELECT name FROM sysobjects WHERE name='TG_NUEVO_EMPLEADO')
		DROP TRIGGER TG_NUEVO_EMPLEADO
	IF EXISTS (SELECT name FROM sysobjects WHERE name='TG_EDITAR_EMPLEADO')
		DROP TRIGGER TG_EDITAR_EMPLEADO
GO

GO
	-- Función que retorna la cantidad de empleados a cargo de un determinado empleado --
	CREATE FUNCTION EMPLEADOS_BAJO_CARGO (@empleado numeric(6, 0))
	RETURNS INT
	AS
	BEGIN
		DECLARE @cantidad_empleados int
		SET @cantidad_empleados = (SELECT COUNT(*) FROM Empleado WHERE empl_jefe = @empleado)
		RETURN @cantidad_empleados
	END
GO

GO
	-- Función que retorna la cantidad de empleados a cargo de un determinado empleado --
	CREATE FUNCTION CUMPLE_CONDICION_JEFE (@empleado numeric(6, 0))
	RETURNS TINYINT
	AS
	BEGIN
		DECLARE @valor_retorno tinyint
		
		IF((dbo.EMPLEADOS_BAJO_CARGO(@empleado) > 0) AND (dbo.EMPLEADOS_BAJO_CARGO(@empleado) <= 20))
			SET @valor_retorno = 1
		ELSE
			SET @valor_retorno = 0

		RETURN @valor_retorno
	END
GO

GO
	-- Genero un trigger para realizar la validación cuando se inserte un nuevo empleado --
	CREATE TRIGGER TG_NUEVO_EMPLEADO ON Empleado INSTEAD OF INSERT
	AS
	BEGIN
		-- Inserto únicamente los valores cuyos jefes cumplen las condiciones, el resto simplemente lo dejo de lado --
		INSERT INTO Empleado(empl_codigo, empl_nombre, empl_apellido, empl_nacimiento, empl_ingreso, empl_tareas, empl_salario, empl_comision, empl_jefe, empl_departamento)
			(
				SELECT i.empl_codigo, i.empl_nombre, i.empl_apellido, i.empl_nacimiento, i.empl_ingreso, i.empl_tareas, i.empl_salario, i.empl_comision, i.empl_jefe, i.empl_departamento 
				FROM inserted i 
				WHERE dbo.CUMPLE_CONDICION_JEFE(i.empl_codigo) = 1
			)
	END
GO

GO
	-- Genero un trigger para realizar la validación cuando se modifique un empleado existente --
	CREATE TRIGGER TG_EDITAR_EMPLEADO ON Empleado INSTEAD OF UPDATE
	AS
	BEGIN
		-- Declaro variables que voy a utilizar con el cursor --
		DECLARE @codigo_anterior numeric(6, 0)
		DECLARE @codigo_nuevo numeric(6, 0)
		DECLARE @nombre_nuevo char(50)
		DECLARE @apellido_nuevo char(50)
		DECLARE @nacimiento_nuevo smalldatetime
		DECLARE @ingreso_nuevo smalldatetime
		DECLARE @tareas_nuevas char(100)
		DECLARE @salario_nuevo decimal(12, 2)
		DECLARE @comision_nueva decimal(12, 2)
		DECLARE @jefe_nuevo numeric(6, 0)
		DECLARE @departamento_nuevo numeric(6, 0)
		-- Declaro un cursor que recorrerá todos los elementos que hayan sido modificados (y que cumplan las condiciones) --
		DECLARE CURSOR_EMPLEADO CURSOR FOR
			(
				SELECT d.empl_codigo, i.empl_codigo, i.empl_nombre, i.empl_apellido, i.empl_nacimiento, i.empl_ingreso, i.empl_tareas, i.empl_salario, i.empl_comision, i.empl_jefe, i.empl_departamento FROM inserted i
				JOIN deleted d ON (i.empl_jefe != d.empl_jefe) -- Analizo únicamente los que cambien el jefe, sino no me interesan --
				WHERE dbo.CUMPLE_CONDICION_JEFE(i.empl_codigo) = 1
			)
		-- Recorro el cursor --
		OPEN CURSOR_EMPLEADO
		FETCH NEXT FROM CURSOR_EMPLEADO INTO @codigo_anterior, @codigo_nuevo, @nombre_nuevo, @apellido_nuevo, @nacimiento_nuevo, @ingreso_nuevo, @tareas_nuevas, @salario_nuevo, @comision_nueva, @jefe_nuevo, @departamento_nuevo
		WHILE(@@FETCH_STATUS = 0)
			BEGIN
				-- Analizo si el nuevo jefe cumple la condición y en ese caso, actualizo --
				IF(dbo.CUMPLE_CONDICION_JEFE(@jefe_nuevo) = 1)
					BEGIN
						UPDATE Empleado SET empl_codigo = @codigo_nuevo, empl_nombre = @nombre_nuevo, empl_apellido = @apellido_nuevo, empl_nacimiento = @nacimiento_nuevo, empl_ingreso = @ingreso_nuevo, empl_tareas = @tareas_nuevas, empl_salario = @salario_nuevo, empl_comision = @comision_nueva, empl_jefe = @jefe_nuevo, empl_departamento = @departamento_nuevo
						WHERE empl_codigo = @codigo_anterior
					END
				-- Paso al siguiente elemento --
				FETCH NEXT FROM CURSOR_EMPLEADO INTO @codigo_anterior, @codigo_nuevo, @nombre_nuevo, @apellido_nuevo, @nacimiento_nuevo, @ingreso_nuevo, @tareas_nuevas, @salario_nuevo, @comision_nueva, @jefe_nuevo, @departamento_nuevo
			END
		-- Cierro y elimino el cursor --
		CLOSE CURSOR_EMPLEADO
		DEALLOCATE CURSOR_EMPLEADO
	END
GO