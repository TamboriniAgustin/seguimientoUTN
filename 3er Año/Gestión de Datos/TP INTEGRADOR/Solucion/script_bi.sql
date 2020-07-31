USE GD1C2020

-- Elimino todos los objetos para poder actualizarlos y evitar errores de colisión --
GO
	-- TABLAS DE HECHOS --
	IF EXISTS (SELECT name FROM sysobjects WHERE name='Hecho_Sucursal_Venta_Pasaje')
		DROP TABLE GRUPO2.Hecho_Sucursal_Venta_Pasaje
	IF EXISTS (SELECT name FROM sysobjects WHERE name='Hecho_Sucursal_Venta_Estadia')
		DROP TABLE GRUPO2.Hecho_Sucursal_Venta_Estadia
	IF EXISTS (SELECT name FROM sysobjects WHERE name='Hecho_Cliente_Pasaje')
		DROP TABLE GRUPO2.Hecho_Cliente_Pasaje
	IF EXISTS (SELECT name FROM sysobjects WHERE name='Hecho_Cliente_Estadia')
		DROP TABLE GRUPO2.Hecho_Cliente_Estadia
	IF EXISTS (SELECT name FROM sysobjects WHERE name='Hecho_Venta_Pasaje')
		DROP TABLE GRUPO2.Hecho_Venta_Pasaje
	IF EXISTS (SELECT name FROM sysobjects WHERE name='Hecho_Vuelos_X_Ruta')
		DROP TABLE GRUPO2.Hecho_Vuelos_X_Ruta
	IF EXISTS (SELECT name FROM sysobjects WHERE name='Hecho_Venta_Estadia')
		DROP TABLE GRUPO2.Hecho_Venta_Estadia
	-- TABLAS DE DIMENSIONES --
	IF EXISTS (SELECT name FROM sysobjects WHERE name='Dimension_Tiempo')
		DROP TABLE GRUPO2.Dimension_Tiempo
	IF EXISTS (SELECT name FROM sysobjects WHERE name='Dimension_Provedor')
		DROP TABLE GRUPO2.Dimension_Provedor
	IF EXISTS (SELECT name FROM sysobjects WHERE name='Dimension_Sucursal')
		DROP TABLE GRUPO2.Dimension_Sucursal
	IF EXISTS (SELECT name FROM sysobjects WHERE name='Dimension_Cliente')
		DROP TABLE GRUPO2.Dimension_Cliente
	IF EXISTS (SELECT name FROM sysobjects WHERE name='Dimension_Ciudad')
		DROP TABLE GRUPO2.Dimension_Ciudad
	IF EXISTS (SELECT name FROM sysobjects WHERE name='Dimension_Ruta_Aerea')
		DROP TABLE GRUPO2.Dimension_Ruta_Aerea
	IF EXISTS (SELECT name FROM sysobjects WHERE name='Dimension_Tipo_Habitacion')
		DROP TABLE GRUPO2.Dimension_Tipo_Habitacion
	IF EXISTS (SELECT name FROM sysobjects WHERE name='Dimension_Avion')
		DROP TABLE GRUPO2.Dimension_Avion
	IF EXISTS (SELECT name FROM sysobjects WHERE name='Dimension_Tipo_Pasaje')
		DROP TABLE GRUPO2.Dimension_Tipo_Pasaje
	-- PROCEDIMIENTOS --
	IF EXISTS (SELECT name FROM sysobjects WHERE name='CREAR_TABLAS_BI')
		DROP PROCEDURE CREAR_TABLAS_BI
	IF EXISTS (SELECT name FROM sysobjects WHERE name='LLENAR_DIMENSIONES')
		DROP PROCEDURE LLENAR_DIMENSIONES
	IF EXISTS (SELECT name FROM sysobjects WHERE name='LLENAR_HECHOS')
		DROP PROCEDURE LLENAR_HECHOS
	-- FUNCIONES --
	IF EXISTS (SELECT name FROM sysobjects WHERE name='TRIMESTRE')
		DROP FUNCTION TRIMESTRE
	IF EXISTS (SELECT name FROM sysobjects WHERE name='ID_DIMENSION_TIEMPO')
		DROP FUNCTION ID_DIMENSION_TIEMPO
	IF EXISTS (SELECT name FROM sysobjects WHERE name='ID_DIMENSION_PROVEDOR')
		DROP FUNCTION ID_DIMENSION_PROVEDOR
	IF EXISTS (SELECT name FROM sysobjects WHERE name='ID_DIMENSION_CLIENTE')
		DROP FUNCTION ID_DIMENSION_CLIENTE
	IF EXISTS (SELECT name FROM sysobjects WHERE name='ID_DIMENSION_CIUDAD')
		DROP FUNCTION ID_DIMENSION_CIUDAD
	IF EXISTS (SELECT name FROM sysobjects WHERE name='ID_DIMENSION_RUTA')
		DROP FUNCTION ID_DIMENSION_RUTA
	IF EXISTS (SELECT name FROM sysobjects WHERE name='ID_DIMENSION_TIPO_HABITACION')
		DROP FUNCTION ID_DIMENSION_TIPO_HABITACION
	IF EXISTS (SELECT name FROM sysobjects WHERE name='ID_DIMENSION_TIPO_PASAJE')
		DROP FUNCTION ID_DIMENSION_TIPO_PASAJE
	IF EXISTS (SELECT name FROM sysobjects WHERE name='ID_DIMENSION_AVION')
		DROP FUNCTION ID_DIMENSION_AVION
GO

-- Creación de Tablas --
GO
	CREATE PROCEDURE CREAR_TABLAS_BI
	AS
	BEGIN
		-- Dimensiones --
		CREATE TABLE GRUPO2.Dimension_Tiempo(
			tiempo_id INT NOT NULL IDENTITY(1,1),
			tiempo_anio INT NOT NULL,
			tiempo_mes INT NOT NULL,
			tiempo_trimestre INT NOT NULL,
			PRIMARY KEY(tiempo_id)
		)

		CREATE TABLE GRUPO2.Dimension_Provedor(
			provedor_id INT NOT NULL IDENTITY(1,1),
			provedor_razon_social VARCHAR(255) NOT NULL,	
			provedor_tipo VARCHAR(10) NOT NULL
			PRIMARY KEY(provedor_id)
		)

		CREATE TABLE GRUPO2.Dimension_Sucursal(
			sucursal_id INT NOT NULL IDENTITY(1,1),
			sucursal_mail VARCHAR(255) NOT NULL,
			sucursal_direccion VARCHAR(255) NOT NULL,
			sucursal_telefono DECIMAL(18, 0) NOT NULL
		)

		CREATE TABLE GRUPO2.Dimension_Cliente(
			cliente_id INT NOT NULL IDENTITY(1,1),
			cliente_dni DECIMAL(18, 0) NOT NULL,
			cliente_nombre VARCHAR(255) NOT NULL,
			cliente_apellido VARCHAR(255) NOT NULL,
			cliente_mail VARCHAR(255) NOT NULL,
			cliente_telefono DECIMAL(18, 0) NOT NULL,
			PRIMARY KEY(cliente_id)
		)

		CREATE TABLE GRUPO2.Dimension_Ruta_Aerea(
			ruta_aerea_id INT NOT NULL IDENTITY(1,1),
			ruta_aerea_ciudad_origen VARCHAR(255) NOT NULL,
			ruta_aerea_ciudad_destino VARCHAR(255) NOT NULL,
			PRIMARY KEY (ruta_aerea_id)
		)

		CREATE TABLE GRUPO2.Dimension_Tipo_Habitacion(
			tipo_habitacion_id INT NOT NULL IDENTITY(1, 1),
			tipo_habitacion_descripcion VARCHAR(50) NOT NULL UNIQUE,
			PRIMARY KEY(tipo_habitacion_id)
		)

		CREATE TABLE GRUPO2.Dimension_Avion(
			avion_id INT NOT NULL IDENTITY(1,1),
			avion_aerolinea VARCHAR(255) NOT NULL,
			avion_modelo VARCHAR(20) NOT NULL,
			PRIMARY KEY(avion_id)
		)

		CREATE TABLE GRUPO2.Dimension_Tipo_Pasaje(
			tipo_pasaje_id INT NOT NULL IDENTITY(1,1),
			tipo_pasaje_descripcion VARCHAR(255) NOT NULL,
			PRIMARY KEY(tipo_pasaje_id)
		)

		-- Hechos --
		CREATE TABLE GRUPO2.Hecho_Sucursal_Venta_Pasaje(
			sucursal_id INT NOT NULL,
			sucursal_tiempo_id INT NOT NULL,
			sucursal_tipo_pasaje_id INT NOT NULL,
			sucursal_total_vendido INT NOT NULL,
			sucursal_total_facturado DECIMAL(12, 2) NOT NULL,
		)

		CREATE TABLE GRUPO2.Hecho_Sucursal_Venta_Estadia(
			sucursal_id INT NOT NULL,
			sucursal_tiempo_id INT NOT NULL,
			sucursal_tipo_habitacion_id INT NOT NULL,
			sucursal_total_vendido INT NOT NULL,
			sucursal_total_facturado DECIMAL(12, 2) NOT NULL,
		)

		CREATE TABLE GRUPO2.Hecho_Cliente_Pasaje(
			cliente_id INT NOT NULL,
			cliente_tipo_pasaje_id INT NOT NULL,
			cliente_pasajes_comprados INT NOT NULL,
			cliente_total_gastado DECIMAL(12, 2) NOT NULL,
			PRIMARY KEY(cliente_id, cliente_tipo_pasaje_id),
			FOREIGN KEY(cliente_tipo_pasaje_id) REFERENCES GRUPO2.Dimension_Tipo_Pasaje(tipo_pasaje_id)
		)

		CREATE TABLE GRUPO2.Hecho_Cliente_Estadia(
			cliente_id INT NOT NULL,
			cliente_tipo_habitacion_id INT NOT NULL,
			cliente_habitaciones_compradas INT NOT NULL,
			cliente_total_gastado DECIMAL(12, 2) NOT NULL,
			PRIMARY KEY(cliente_id, cliente_tipo_habitacion_id),
			FOREIGN KEY(cliente_tipo_habitacion_id) REFERENCES GRUPO2.Dimension_Tipo_Habitacion(tipo_habitacion_id)
		)

		CREATE TABLE GRUPO2.Hecho_Venta_Pasaje(
			vuelo_tiempo INT NOT NULL,
			vuelo_avion INT NOT NULL,
			vuelo_ruta INT NOT NULL,
			vuelo_tipo_pasaje INT NOT NULL,
			vuelo_cantidad_pasajes_vendidos INT NOT NULL,
			vuelo_precio_promedio_venta DECIMAL(12, 2) NOT NULL,
			PRIMARY KEY(vuelo_tiempo, vuelo_avion, vuelo_ruta, vuelo_tipo_pasaje),
			FOREIGN KEY(vuelo_tiempo) REFERENCES GRUPO2.Dimension_Tiempo(tiempo_id),
			FOREIGN KEY(vuelo_avion) REFERENCES GRUPO2.Dimension_Avion(avion_id),
			FOREIGN KEY(vuelo_ruta) REFERENCES GRUPO2.Dimension_Ruta_Aerea(ruta_aerea_id),
			FOREIGN KEY(vuelo_tipo_pasaje) REFERENCES GRUPO2.Dimension_Tipo_Pasaje(tipo_pasaje_id)
		)

		CREATE TABLE GRUPO2.Hecho_Vuelos_X_Ruta(
			vuelos_ruta_avion INT NOT NULL,
			vuelos_ruta INT NOT NULL,
			vuelos_ruta_cantidad_vuelos INT NOT NULL,
			PRIMARY KEY(vuelos_ruta_avion, vuelos_ruta),
			FOREIGN KEY(vuelos_ruta_avion) REFERENCES GRUPO2.Dimension_Avion(avion_id),
			FOREIGN KEY(vuelos_ruta) REFERENCES GRUPO2.Dimension_Ruta_Aerea(ruta_aerea_id)
		)

		CREATE TABLE GRUPO2.Hecho_Venta_Estadia(
			venta_estadia_tiempo INT NOT NULL,
			venta_estadia_provedor INT NOT NULL,
			venta_estadia_tipo_habitacion INT NOT NULL,
			venta_estadia_habitaciones_vendidas DECIMAL(12, 2) NOT NULL,
			venta_estadia_precio_venta_promedio DECIMAL(12, 2) NOT NULL,
			PRIMARY KEY(venta_estadia_tiempo, venta_estadia_provedor, venta_estadia_tipo_habitacion),
			FOREIGN KEY(venta_estadia_tiempo) REFERENCES GRUPO2.Dimension_Tiempo(tiempo_id),
			FOREIGN KEY(venta_estadia_provedor) REFERENCES GRUPO2.Dimension_Provedor(provedor_id),
			FOREIGN KEY(venta_estadia_tipo_habitacion) REFERENCES GRUPO2.Dimension_Tipo_Habitacion(tipo_habitacion_id),
		)
	END
GO

-- Funciones Útiles --
GO
	CREATE FUNCTION TRIMESTRE(@fecha datetime)
	RETURNS INT
	BEGIN
		RETURN case when month(@fecha) <=3 then 1 when month(@fecha) <=6 then 2 when month(@fecha) <= 9 then 3 else 4 end
	END
GO

GO
	CREATE FUNCTION ID_DIMENSION_TIEMPO(@fecha datetime)
	RETURNS INT
	BEGIN
		RETURN (SELECT tiempo_id FROM GRUPO2.Dimension_Tiempo WHERE tiempo_anio = YEAR(@fecha) and tiempo_mes = MONTH(@fecha) and tiempo_trimestre = dbo.TRIMESTRE(@fecha))
	END
GO

GO
	CREATE FUNCTION ID_DIMENSION_PROVEDOR(@razon_social varchar(255), @tipo varchar(10))
	RETURNS INT
	BEGIN
		RETURN (SELECT provedor_id FROM GRUPO2.Dimension_Provedor WHERE provedor_razon_social = @razon_social and provedor_tipo = @tipo)
	END
GO

GO
	CREATE FUNCTION ID_DIMENSION_CLIENTE(@dni decimal(18, 0), @nombre varchar(255), @apellido varchar(255))
	RETURNS INT
	BEGIN
		RETURN (SELECT cliente_id FROM GRUPO2.Dimension_Cliente WHERE cliente_dni = @dni and cliente_nombre = @nombre and cliente_apellido = @apellido)
	END
GO

GO
	CREATE FUNCTION ID_DIMENSION_RUTA(@origen varchar(255), @destino varchar(255))
	RETURNS INT
	BEGIN
		RETURN (SELECT ruta_aerea_id FROM GRUPO2.Dimension_Ruta_Aerea WHERE ruta_aerea_ciudad_origen = @origen and ruta_aerea_ciudad_destino = @destino)
	END
GO

GO
	CREATE FUNCTION ID_DIMENSION_TIPO_HABITACION(@descripcion nvarchar(50))
	RETURNS INT
	BEGIN
		RETURN (SELECT tipo_habitacion_id FROM GRUPO2.Dimension_Tipo_Habitacion WHERE tipo_habitacion_descripcion = @descripcion)
	END
GO

GO
	CREATE FUNCTION ID_DIMENSION_AVION(@aerolinea varchar(255), @modelo char(20))
	RETURNS INT
	BEGIN
		RETURN (SELECT avion_id FROM GRUPO2.Dimension_Avion WHERE avion_aerolinea = @aerolinea and avion_modelo = @modelo)
	END
GO

GO
	CREATE FUNCTION ID_DIMENSION_TIPO_PASAJE(@descripcion varchar(255))
	RETURNS INT
	BEGIN
		RETURN (SELECT tipo_pasaje_id FROM GRUPO2.Dimension_Tipo_Pasaje WHERE tipo_pasaje_descripcion = @descripcion)
	END
GO

-- Llenado de las dimensiones --
GO
	CREATE PROCEDURE LLENAR_DIMENSIONES
	AS
	BEGIN
		-- Tiempo --
		INSERT INTO GRUPO2.Dimension_Tiempo(tiempo_anio, tiempo_mes, tiempo_trimestre)
			(SELECT DISTINCT YEAR(operacion_fecha), MONTH(operacion_fecha), dbo.TRIMESTRE(operacion_fecha) FROM GRUPO2.Operacion)
			UNION
			(SELECT DISTINCT YEAR(factura_fecha), MONTH(factura_fecha), dbo.TRIMESTRE(factura_fecha) FROM GRUPO2.Factura)
			UNION
			(SELECT DISTINCT YEAR(vuelo_fecha_salida), MONTH(vuelo_fecha_salida), dbo.TRIMESTRE(vuelo_fecha_salida) FROM GRUPO2.Vuelo)
			UNION
			(SELECT DISTINCT YEAR(vuelo_fecha_llegada), MONTH(vuelo_fecha_llegada), dbo.TRIMESTRE(vuelo_fecha_llegada) FROM GRUPO2.Vuelo)
			UNION
			(SELECT DISTINCT YEAR(estadia_fecha_inicio), MONTH(estadia_fecha_inicio), dbo.TRIMESTRE(estadia_fecha_inicio) FROM GRUPO2.Estadia)
		-- Proveedor --
		INSERT INTO GRUPO2.Dimension_Provedor(provedor_razon_social, provedor_tipo)
			(SELECT aerolinea_nombre, 'AEROLINEA' FROM GRUPO2.Aerolinea)
			UNION
			(SELECT hotel_nombre, 'HOTEL' FROM GRUPO2.Hotel)
		-- Sucursal --
		INSERT INTO GRUPO2.Dimension_Sucursal(sucursal_mail, sucursal_direccion, sucursal_telefono)
			SELECT DISTINCT sucursal_mail, sucursal_direccion, sucursal_telefono FROM GRUPO2.Sucursal
		-- Cliente --
		INSERT INTO GRUPO2.Dimension_Cliente(cliente_dni, cliente_nombre, cliente_apellido, cliente_mail, cliente_telefono)
			SELECT usuario_dni, usuario_nombre, usuario_apellido, usuario_mail, usuario_telefono FROM GRUPO2.Usuario
		-- Ruta Aérea --
		INSERT INTO GRUPO2.Dimension_Ruta_Aerea(ruta_aerea_ciudad_origen, ruta_aerea_ciudad_destino)
			SELECT DISTINCT C2.ciudad_nombre, C1.ciudad_nombre FROM GRUPO2.Ruta_Aerea JOIN GRUPO2.Ciudad C1 ON C1.ciudad_id = ruta_aerea_ciudad_destino JOIN GRUPO2.Ciudad C2 ON C2.ciudad_id = ruta_aerea_ciudad_origen
		-- Tipo de Habitación --
		INSERT INTO GRUPO2.Dimension_Tipo_Habitacion(tipo_habitacion_descripcion)
			SELECT DISTINCT tipo_habitacion_descripcion FROM GRUPO2.Tipo_Habitacion	
		-- Avión --
		INSERT INTO GRUPO2.Dimension_Avion(avion_aerolinea, avion_modelo)
			SELECT DISTINCT avion_aerolinea, avion_modelo FROM GRUPO2.Avion
		-- Tipo de Pasaje --
		INSERT INTO GRUPO2.Dimension_Tipo_Pasaje(tipo_pasaje_descripcion)
			SELECT DISTINCT butaca_tipo FROM GRUPO2.Butaca	
	END
GO

-- Creo las tablas y lleno las dimensiones --
EXECUTE CREAR_TABLAS_BI
EXECUTE LLENAR_DIMENSIONES

-- Llenado de los hechos --
GO
	CREATE PROCEDURE LLENAR_HECHOS
	AS
	BEGIN
		-- Cantidad de ventas de pasajes por sucursal en un determinado mes
		INSERT INTO GRUPO2.Hecho_Sucursal_Venta_Pasaje
			SELECT 
				ds1.sucursal_id,
				dt1.tiempo_id,
				dbo.ID_DIMENSION_TIPO_PASAJE(p1.pasaje_tipo_butaca),
				COUNT(*),
				SUM(f1.factura_costo_final)
			FROM GRUPO2.Dimension_Sucursal ds1
			CROSS JOIN GRUPO2.Dimension_Tiempo dt1
			JOIN GRUPO2.Factura f1 ON (ds1.sucursal_direccion = f1.factura_sucursal_direccion) AND (YEAR(f1.factura_fecha) = dt1.tiempo_anio) AND (MONTH(f1.factura_fecha) = dt1.tiempo_mes)
			JOIN GRUPO2.Operacion_Pasaje op1 ON (f1.factura_numero_operacion = op1.operacion_pasaje_numero) AND (f1.factura_tipo_operacion = op1.operacion_pasaje_tipo)
			JOIN GRUPO2.Pasaje p1 ON op1.operacion_pasaje_codigo_pasaje = p1.pasaje_codigo
			GROUP BY ds1.sucursal_id, dt1.tiempo_id, p1.pasaje_tipo_butaca

		-- Cantidad de ventas de estadias por sucursal en un determinado mes
		INSERT INTO GRUPO2.Hecho_Sucursal_Venta_Estadia
			SELECT 
				ds1.sucursal_id,
				dt1.tiempo_id,
				dbo.ID_DIMENSION_TIPO_HABITACION(th1.tipo_habitacion_descripcion),
				COUNT(*),
				SUM(f1.factura_costo_final)
			FROM GRUPO2.Dimension_Sucursal ds1
			CROSS JOIN GRUPO2.Dimension_Tiempo dt1
			JOIN GRUPO2.Factura f1 ON (ds1.sucursal_direccion = f1.factura_sucursal_direccion) AND (YEAR(f1.factura_fecha) = dt1.tiempo_anio) AND (MONTH(f1.factura_fecha) = dt1.tiempo_mes)
			JOIN GRUPO2.Operacion_Estadia oe1 ON (oe1.operacion_estadia_numero = f1.factura_numero_operacion) AND (oe1.operacion_estadia_tipo = f1.factura_tipo_operacion)
			JOIN GRUPO2.Habitacion_Estadia he1 ON oe1.operacion_estadia_codigo_estadia = he1.habitacion_estadia_codigo_estadia
			JOIN GRUPO2.Habitacion h1 ON (he1.habitacion_estadia_numero_habitacion = h1.habitacion_numero) AND (he1.habitacion_estadia_piso_habitacion = h1.habitacion_piso)
			JOIN GRUPO2.Tipo_Habitacion th1 ON th1.tipo_habitacion_codigo = h1.habitacion_tipo
			GROUP BY ds1.sucursal_id, dt1.tiempo_id, th1.tipo_habitacion_descripcion

		-- Cantidad de ventas de pasajes por cliente
		INSERT INTO GRUPO2.Hecho_Cliente_Pasaje
			SELECT 
				c1.cliente_id,
				dbo.ID_DIMENSION_TIPO_PASAJE(p1.pasaje_tipo_butaca),
				COUNT(*),
				SUM(op1.operacion_pasaje_costo)
			FROM GRUPO2.Dimension_Cliente c1
			JOIN GRUPO2.Factura f1 ON (f1.factura_cliente_dni = c1.cliente_dni) AND (f1.factura_cliente_nombre = c1.cliente_nombre) AND (f1.factura_cliente_apellido = c1.cliente_apellido)
			JOIN GRUPO2.Operacion o1 ON (f1.factura_numero_operacion = o1.operacion_numero) AND (f1.factura_tipo_operacion = o1.operacion_tipo)
			JOIN GRUPO2.Operacion_Pasaje op1 ON (o1.operacion_numero = op1.operacion_pasaje_numero) AND (o1.operacion_tipo = op1.operacion_pasaje_tipo)
			JOIN GRUPO2.Pasaje p1 ON op1.operacion_pasaje_codigo_pasaje = p1.pasaje_codigo
			GROUP BY c1.cliente_id, c1.cliente_dni, c1.cliente_nombre, c1.cliente_apellido, p1.pasaje_tipo_butaca

		-- Cantidad de ventas de habitaciones por cliente
		INSERT INTO GRUPO2.Hecho_Cliente_Estadia
				SELECT 
					c1.cliente_id,
					dbo.ID_DIMENSION_TIPO_HABITACION(th1.tipo_habitacion_descripcion),
					COUNT(*),
					SUM(h1.habitacion_costo)
				FROM GRUPO2.Dimension_Cliente c1
				JOIN GRUPO2.Factura f1 ON (f1.factura_cliente_dni = c1.cliente_dni) AND (f1.factura_cliente_nombre = c1.cliente_nombre) AND (f1.factura_cliente_apellido = c1.cliente_apellido)
				JOIN GRUPO2.Operacion o1 ON (f1.factura_numero_operacion = o1.operacion_numero) AND (f1.factura_tipo_operacion = o1.operacion_tipo)
				JOIN GRUPO2.Operacion_Estadia oe1 ON (o1.operacion_numero = oe1.operacion_estadia_numero) AND (o1.operacion_tipo = oe1.operacion_estadia_tipo)
				JOIN GRUPO2.Habitacion_Estadia he1 ON he1.habitacion_estadia_codigo_estadia = oe1.operacion_estadia_codigo_estadia
				JOIN GRUPO2.Habitacion h1 ON (he1.habitacion_estadia_numero_habitacion = h1.habitacion_numero) AND (he1.habitacion_estadia_piso_habitacion = h1.habitacion_piso)
				JOIN GRUPO2.Tipo_Habitacion th1 ON h1.habitacion_tipo = th1.tipo_habitacion_codigo
				GROUP BY c1.cliente_id, c1.cliente_dni, c1.cliente_nombre, c1.cliente_apellido, th1.tipo_habitacion_descripcion

		-- Cantidad de ventas de pasaje por ruta aérea de cada aerolínea
		INSERT INTO GRUPO2.Hecho_Venta_Pasaje(vuelo_tiempo, vuelo_avion, vuelo_ruta, vuelo_tipo_pasaje, vuelo_cantidad_pasajes_vendidos, vuelo_precio_promedio_venta)
			(
				SELECT 
					dbo.ID_DIMENSION_TIEMPO(vuelo_fecha_salida) AS tiempo, 
					dbo.ID_DIMENSION_AVION(pasaje_aerolinea, avion_modelo) AS avion, 
					dbo.ID_DIMENSION_RUTA(C1.ciudad_nombre, C2.ciudad_nombre) AS ruta, 
					dbo.ID_DIMENSION_TIPO_PASAJE(pasaje_tipo_butaca) AS tipo_pasaje, 
					COUNT(*) AS pasajes_vendidos, 
					AVG(operacion_pasaje_costo) AS precio_promedio
				FROM GRUPO2.Operacion_Pasaje 
				LEFT JOIN GRUPO2.Pasaje ON (operacion_pasaje_codigo_pasaje + operacion_pasaje_vuelo_pasaje = pasaje_codigo + pasaje_vuelo) AND (operacion_pasaje_aerolinea_pasaje = pasaje_aerolinea)
				LEFT JOIN GRUPO2.Vuelo ON (pasaje_aerolinea = vuelo_aerolinea) AND (pasaje_vuelo = vuelo_codigo)
				LEFT JOIN GRUPO2.Avion ON (vuelo_avion = avion_identificador) AND (vuelo_aerolinea = avion_aerolinea)
				LEFT JOIN GRUPO2.Ciudad C1 ON vuelo_ruta_origen = C1.ciudad_id
				LEFT JOIN GRUPO2.Ciudad C2 ON vuelo_ruta_destino = C2.ciudad_id
				WHERE operacion_pasaje_tipo = 'VENTA'
				GROUP BY dbo.ID_DIMENSION_TIEMPO(vuelo_fecha_salida), avion_modelo, pasaje_aerolinea, C1.ciudad_nombre, C2.ciudad_nombre, pasaje_tipo_butaca
			)

		-- Cantidad de vuelos por ruta de cada aerolínea
		INSERT INTO GRUPO2.Hecho_Vuelos_X_Ruta(vuelos_ruta_avion, vuelos_ruta, vuelos_ruta_cantidad_vuelos)
			SELECT dbo.ID_DIMENSION_AVION(vuelo_aerolinea, avion_modelo) as avion, dbo.ID_DIMENSION_RUTA(C1.ciudad_nombre, C2.ciudad_nombre) as ruta, COUNT(*) as cantidad_vuelos
			FROM GRUPO2.Vuelo
			LEFT JOIN GRUPO2.Avion ON (vuelo_avion = avion_identificador) AND (vuelo_aerolinea = avion_aerolinea)
			LEFT JOIN GRUPO2.Ciudad C1 ON vuelo_ruta_origen = C1.ciudad_id
			LEFT JOIN GRUPO2.Ciudad C2 ON vuelo_ruta_destino = C2.ciudad_id
			GROUP BY avion_modelo, vuelo_aerolinea, C1.ciudad_nombre, C2.ciudad_nombre

		-- Cantidad de ventas por habitación de cada hotel
		INSERT INTO GRUPO2.Hecho_Venta_Estadia
			SELECT 
				dbo.ID_DIMENSION_TIEMPO(o1.operacion_fecha), 
				dbo.ID_DIMENSION_PROVEDOR(oe1.operacion_estadia_hotel_nombre, 'HOTEL'), 
				dbo.ID_DIMENSION_TIPO_HABITACION(tipo_habitacion_descripcion),
				COUNT(*),
				AVG(habitacion_estadia_costo)
			FROM GRUPO2.Operacion_Estadia oe1
			JOIN GRUPO2.Operacion o1 ON (oe1.operacion_estadia_numero = o1.operacion_numero) AND (oe1.operacion_estadia_tipo = o1.operacion_tipo) 
			JOIN GRUPO2.Hotel h1 ON (oe1.operacion_estadia_hotel_nombre = h1.hotel_nombre) AND (oe1.operacion_estadia_hotel_calle = h1.hotel_calle) AND (oe1.operacion_estadia_hotel_numero_calle = h1.hotel_numero_calle)
			JOIN GRUPO2.Habitacion_Estadia he1 ON he1.habitacion_estadia_codigo_estadia = oe1.operacion_estadia_codigo_estadia
			JOIN GRUPO2.Habitacion hab1 ON (he1.habitacion_estadia_hotel_nombre = h1.hotel_nombre) AND (he1.habitacion_estadia_hotel_calle = h1.hotel_calle) AND (he1.habitacion_estadia_hotel_numero_calle = h1.hotel_numero_calle) AND (hab1.habitacion_numero = he1.habitacion_estadia_numero_habitacion) AND (hab1.habitacion_piso = he1.habitacion_estadia_piso_habitacion)
			JOIN GRUPO2.Tipo_Habitacion th1 ON hab1.habitacion_tipo = th1.tipo_habitacion_codigo
			GROUP BY dbo.ID_DIMENSION_TIEMPO(operacion_fecha), operacion_estadia_hotel_nombre, tipo_habitacion_descripcion
	END
GO

-- Lleno los hechos --
EXECUTE LLENAR_HECHOS