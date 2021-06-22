USE GD_UTN

-- Elimino los elementos si ya existían previamente --
GO
	IF EXISTS (SELECT name FROM sysobjects WHERE name='ZONA_EMPLEADO')
		DROP FUNCTION ZONA_EMPLEADO
	IF EXISTS (SELECT name FROM sysobjects WHERE name='DEPOSITOS_EMPLEADO')
		DROP FUNCTION DEPOSITOS_EMPLEADO
	IF EXISTS (SELECT name FROM sysobjects WHERE name='ENCARGADOS_ZONA')
		DROP FUNCTION ENCARGADOS_ZONA
	IF EXISTS (SELECT name FROM sysobjects WHERE name='REORGANIZAR_ENCARGADOS')
		DROP PROCEDURE REORGANIZAR_ENCARGADOS
	IF EXISTS (SELECT name FROM sysobjects WHERE name='TRIGGER_NUEVO_DEPOSITO')
		DROP TRIGGER TRIGGER_NUEVO_DEPOSITO
	IF EXISTS (SELECT name FROM sysobjects WHERE name='TRIGGER_EDITAR_DEPOSITO')
		DROP TRIGGER TRIGGER_EDITAR_DEPOSITO
GO

-- Creo una funcion que me permita conocer la zona del departamento del empleado --
GO
	CREATE FUNCTION ZONA_EMPLEADO (@empleado numeric(6, 0))
	RETURNS CHAR(3)
	AS
	BEGIN
		DECLARE @valor_retorno char(3)

		SELECT @valor_retorno = depa_zona FROM Empleado JOIN Departamento ON Empleado.empl_departamento = Departamento.depa_codigo WHERE empl_codigo = @empleado

		RETURN @valor_retorno
	END
GO

-- Creo una función que me permita conocer cuantos depositos tienen de encargado a un empleado --
GO
	CREATE FUNCTION DEPOSITOS_EMPLEADO (@empleado numeric(6, 0))
	RETURNS INT
	AS
	BEGIN
		DECLARE @valor_retorno int

		SELECT @valor_retorno = COUNT(*) FROM DEPOSITO WHERE (depo_encargado = @empleado) AND (depo_zona = dbo.ZONA_EMPLEADO(@empleado))

		RETURN @valor_retorno
	END
GO

-- Creo una función que me devuelva a los encargados de una determinada zona --
GO
	CREATE FUNCTION ENCARGADOS_ZONA (@zona char(3))
	RETURNS TABLE
	RETURN (SELECT * FROM Empleado WHERE dbo.ZONA_EMPLEADO(empl_codigo) = @zona)
GO

-- Creo un procedimiento que reorganize a los encargados --
GO
	CREATE PROCEDURE REORGANIZAR_ENCARGADOS
	AS
	BEGIN
		-- Declaro las variables que me interesan del depósito --
		DECLARE @codigo_deposito char(2)
		DECLARE @encargado_deposito numeric(6, 0)
		DECLARE @zona_deposito char(3)
		-- Genero un cursor para recorrer los depósitos y así verificar aquellos que requieran una reorganización --
		DECLARE CURSOR_DEPOSITO CURSOR FOR SELECT depo_codigo, depo_encargado, depo_zona FROM DEPOSITO
		OPEN CURSOR_DEPOSITO
		FETCH NEXT FROM CURSOR_DEPOSITO INTO @codigo_deposito, @encargado_deposito, @zona_deposito
		WHILE(@@FETCH_STATUS = 0)
			BEGIN
				-- Si la zona del depósito es distinta a la zona del departamento en el que trabaja el empleado tendré que reasignar --
				IF(@zona_deposito != dbo.ZONA_EMPLEADO(@encargado_deposito))
					BEGIN
						-- Establezco al nuevo encargado del deposito --
						DECLARE @nuevo_encargado numeric(6, 0)
						SELECT TOP 1 @nuevo_encargado = empl_codigo FROM dbo.ENCARGADOS_ZONA(@zona_deposito) ORDER BY dbo.DEPOSITOS_EMPLEADO(empl_codigo) ASC
						-- Actualizo al encargado --
						UPDATE DEPOSITO SET depo_encargado = @nuevo_encargado WHERE depo_codigo = @codigo_deposito
					END
				-- Paso al siguiente depósito --
				FETCH NEXT FROM CURSOR_DEPOSITO INTO @codigo_deposito, @encargado_deposito, @zona_deposito
			END
		CLOSE CURSOR_DEPOSITO
		DEALLOCATE CURSOR_DEPOSITO
	END
GO

-- Creo los triggers necesarios para que no puedan añadirse encargados que no cumplan la regla de negocio --
GO
	CREATE TRIGGER TRIGGER_NUEVO_DEPOSITO ON DEPOSITO INSTEAD OF INSERT
	AS
	BEGIN
		INSERT INTO DEPOSITO
			SELECT * FROM inserted WHERE depo_encargado IN (SELECT empl_codigo FROM dbo.ENCARGADOS_ZONA(depo_zona))
	END
GO

GO
	CREATE TRIGGER TRIGGER_EDITAR_DEPOSITO ON DEPOSITO INSTEAD OF UPDATE
	AS
	BEGIN
		-- Declaro los datos actuales --
		DECLARE @codigo_deposito_actual char(2)
		-- Declaro los datos a insertar --
		DECLARE @codigo_deposito char(2), @detalle_deposito char(50), @domicilio_deposito char(50), @telefono_deposito char(50), @encargado_deposito numeric(6, 0), @zona_deposito char(3)
		-- Genero los cursores correspondientes --
		DECLARE VALORES_ACTUALES CURSOR FOR
			SELECT depo_codigo FROM deleted
		DECLARE VALORES_NUEVOS CURSOR FOR
			SELECT depo_codigo, depo_detalle, depo_domicilio, depo_telefono, depo_encargado, depo_zona FROM inserted
		-- Declaro dos variables para conocer el estado de cada cursor --
		DECLARE @status_actuales int, @status_nuevos int
		-- Abro los cursores --
		OPEN VALORES_ACTUALES
		OPEN VALORES_NUEVOS
		-- Recorro los cursores --
		FETCH NEXT FROM VALORES_ACTUALES INTO @codigo_deposito_actual
		SET @status_actuales = @@FETCH_STATUS
		FETCH NEXT FROM VALORES_NUEVOS INTO @codigo_deposito, @detalle_deposito, @domicilio_deposito, @telefono_deposito, @encargado_deposito, @zona_deposito
		SET @status_nuevos = @@FETCH_STATUS
		WHILE ((@status_actuales = 0) AND (@status_nuevos = 0))
			BEGIN
				-- Realizo la lógica del ejercicio --
				IF(@encargado_deposito NOT IN (SELECT empl_codigo FROM dbo.ENCARGADOS_ZONA(@zona_deposito)))
					BEGIN
						RAISERROR('No puede actualizarse el depósito %s porque su encargado no pertenece a la misma zona', 16, 1, @codigo_deposito)
					END
				ELSE
					BEGIN
						UPDATE DEPOSITO SET depo_codigo = @codigo_deposito, depo_detalle = @detalle_deposito, depo_domicilio = @domicilio_deposito, depo_telefono = @telefono_deposito, depo_encargado = @encargado_deposito, depo_zona = @zona_deposito
						WHERE depo_codigo = @codigo_deposito_actual
					END
				-- Paso a la siguiente fila de cada cursor --
				FETCH NEXT FROM VALORES_ACTUALES INTO @codigo_deposito_actual
				SET @status_actuales = @@FETCH_STATUS
				FETCH NEXT FROM VALORES_NUEVOS INTO @codigo_deposito, @detalle_deposito, @domicilio_deposito, @telefono_deposito, @encargado_deposito, @zona_deposito
				SET @status_nuevos = @@FETCH_STATUS
			END
		-- Cierro y elimino los cursores --
		CLOSE VALORES_ACTUALES
		CLOSE VALORES_NUEVOS
		DEALLOCATE VALORES_ACTUALES
		DEALLOCATE VALORES_NUEVOS
	END
GO