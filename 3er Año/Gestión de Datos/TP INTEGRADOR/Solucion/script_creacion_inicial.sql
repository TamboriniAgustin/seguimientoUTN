USE GD1C2020

-- Elimino todos los objetos para poder actualizarlos y evitar errores de colisión --
GO
	-- PROCEDIMIENTOS --
	IF EXISTS (SELECT name FROM sysobjects WHERE name='CREAR_TABLAS')
		DROP PROCEDURE CREAR_TABLAS
	IF EXISTS (SELECT name FROM sysobjects WHERE name='MIGRAR_TABLAS')
		DROP PROCEDURE MIGRAR_TABLAS
	-- FUNCIONES --
	IF EXISTS (SELECT name FROM sysobjects WHERE name='COSTO_OPERACION_ESTADIA')
		DROP FUNCTION COSTO_OPERACION_ESTADIA
	IF EXISTS (SELECT name FROM sysobjects WHERE name='CODIGO_CIUDAD')
		DROP FUNCTION CODIGO_CIUDAD
	-- TRIGGERS --
	IF EXISTS (SELECT name FROM sysobjects WHERE name='TG_INSERTAR_RUTA_AEREA')
		DROP TRIGGER GRUPO2.TG_INSERTAR_RUTA_AEREA
	IF EXISTS (SELECT name FROM sysobjects WHERE name='TG_MODIFICAR_RUTA_AEREA')
		DROP TRIGGER GRUPO2.TG_MODIFICAR_RUTA_AEREA
	-- TABLAS --
	IF EXISTS (SELECT name FROM sysobjects WHERE name='Factura')
		DROP TABLE GRUPO2.Factura
	IF EXISTS (SELECT name FROM sysobjects WHERE name='Operacion_Pasaje')
		DROP TABLE GRUPO2.Operacion_Pasaje
	IF EXISTS (SELECT name FROM sysobjects WHERE name='Operacion_Estadia')
		DROP TABLE GRUPO2.Operacion_Estadia
	IF EXISTS (SELECT name FROM sysobjects WHERE name='Operacion')
		DROP TABLE GRUPO2.Operacion
	IF EXISTS (SELECT name FROM sysobjects WHERE name='Habitacion_Estadia')
		DROP TABLE GRUPO2.Habitacion_Estadia
	IF EXISTS (SELECT name FROM sysobjects WHERE name='Estadia')
		DROP TABLE GRUPO2.Estadia
	IF EXISTS (SELECT name FROM sysobjects WHERE name='Habitacion')
		DROP TABLE GRUPO2.Habitacion
	IF EXISTS (SELECT name FROM sysobjects WHERE name='Tipo_Habitacion')
		DROP TABLE GRUPO2.Tipo_Habitacion
	IF EXISTS (SELECT name FROM sysobjects WHERE name='Hotel')
		DROP TABLE GRUPO2.Hotel
	IF EXISTS (SELECT name FROM sysobjects WHERE name='Pasaje')
		DROP TABLE GRUPO2.Pasaje
	IF EXISTS (SELECT name FROM sysobjects WHERE name='Vuelo')
		DROP TABLE GRUPO2.Vuelo
	IF EXISTS (SELECT name FROM sysobjects WHERE name='Ruta_Aerea')
		DROP TABLE GRUPO2.Ruta_Aerea
	IF EXISTS (SELECT name FROM sysobjects WHERE name='Ciudad')
		DROP TABLE GRUPO2.Ciudad
	IF EXISTS (SELECT name FROM sysobjects WHERE name='Butaca')
		DROP TABLE GRUPO2.Butaca
	IF EXISTS (SELECT name FROM sysobjects WHERE name='Avion')
		DROP TABLE GRUPO2.Avion
	IF EXISTS (SELECT name FROM sysobjects WHERE name='Aerolinea')
		DROP TABLE GRUPO2.Aerolinea
	IF EXISTS (SELECT name FROM sysobjects WHERE name='Usuario')
		DROP TABLE GRUPO2.Usuario
	IF EXISTS (SELECT name FROM sysobjects WHERE name='Sucursal')
		DROP TABLE GRUPO2.Sucursal
	IF EXISTS (SELECT name FROM sysobjects WHERE name='Empresa')
		DROP TABLE GRUPO2.Empresa
	-- SCHEMA --
	IF EXISTS (SELECT name FROM sys.schemas WHERE name='GRUPO2')
		DROP SCHEMA GRUPO2;
GO

-- Creación del Esquema --
GO
	CREATE SCHEMA GRUPO2
GO

-- Creación de Tablas --
GO
	CREATE PROCEDURE CREAR_TABLAS
	AS
	BEGIN
		-- Empresa
		CREATE TABLE GRUPO2.Empresa(
			empresa_razon_social varchar(255) NOT NULL,	
			PRIMARY KEY(empresa_razon_social)
		)

		-- Sucursal
		CREATE TABLE GRUPO2.Sucursal(
			sucursal_mail varchar(255) NOT NULL,
			sucursal_direccion varchar(255) NOT NULL,
			sucursal_telefono decimal(18, 0) NOT NULL,
			PRIMARY KEY(sucursal_direccion),
		);

		-- Usuario
		CREATE TABLE GRUPO2.Usuario(
			usuario_dni decimal(18, 0) NOT NULL,
			usuario_nombre varchar(255) NOT NULL,
			usuario_apellido varchar(255) NOT NULL,
			usuario_mail varchar(255) NOT NULL,
			usuario_telefono decimal(18, 0) NOT NULL,
			PRIMARY KEY(usuario_dni, usuario_nombre, usuario_apellido)
		)

		-- Aerolinea
		CREATE TABLE GRUPO2.Aerolinea(
			aerolinea_nombre varchar(255),
			PRIMARY KEY(aerolinea_nombre),
			FOREIGN KEY(aerolinea_nombre) REFERENCES GRUPO2.Empresa(empresa_razon_social)
		)

		-- Avión
		CREATE TABLE GRUPO2.Avion(
			avion_identificador char(12) NOT NULL,
			avion_aerolinea varchar(255) NOT NULL,
			avion_modelo char(20) NOT NULL,
			PRIMARY KEY(avion_identificador, avion_aerolinea),
			FOREIGN KEY (avion_aerolinea) REFERENCES GRUPO2.Aerolinea(aerolinea_nombre)
		)

		-- Butaca
		CREATE TABLE GRUPO2.Butaca(
			butaca_numero int NOT NULL,
			butaca_avion char(12) NOT NULL,
			butaca_aerolinea varchar(255) NOT NULL,
			butaca_tipo varchar(255) NOT NULL,
			PRIMARY KEY(butaca_numero, butaca_avion, butaca_aerolinea, butaca_tipo),
			FOREIGN KEY (butaca_avion, butaca_aerolinea) REFERENCES GRUPO2.Avion(avion_identificador, avion_aerolinea)
		)

		-- Ciudad
		CREATE TABLE GRUPO2.Ciudad(
			ciudad_id int NOT NULL IDENTITY(1, 1),
			ciudad_nombre varchar(255) NOT NULL UNIQUE,
			PRIMARY KEY(ciudad_id)
		)

		-- Ruta aerea
		CREATE TABLE GRUPO2.Ruta_Aerea(
			ruta_aerea_codigo int NOT NULL,
			ruta_aerea_ciudad_origen int NOT NULL,
			ruta_aerea_ciudad_destino int NOT NULL,
			PRIMARY KEY (ruta_aerea_codigo, ruta_aerea_ciudad_origen, ruta_aerea_ciudad_destino),
			FOREIGN KEY (ruta_aerea_ciudad_origen) REFERENCES GRUPO2.Ciudad(ciudad_id),
			FOREIGN KEY (ruta_aerea_ciudad_destino) REFERENCES GRUPO2.Ciudad(ciudad_id),
			UNIQUE(ruta_aerea_ciudad_origen, ruta_aerea_ciudad_destino)
		)

		-- Vuelo
		CREATE TABLE GRUPO2.Vuelo(
			vuelo_avion char(12) NOT NULL,
			vuelo_aerolinea varchar(255) NOT NULL,
			vuelo_codigo int NOT NULL,
			vuelo_fecha_salida datetime NOT NULL,
			vuelo_fecha_llegada datetime NOT NULL,
			vuelo_ruta_codigo int NOT NULL,
			vuelo_ruta_origen int NOT NULL,
			vuelo_ruta_destino int NOT NULL,
			PRIMARY KEY(vuelo_aerolinea, vuelo_codigo),
			FOREIGN KEY (vuelo_ruta_codigo, vuelo_ruta_origen, vuelo_ruta_destino) REFERENCES GRUPO2.Ruta_Aerea(ruta_aerea_codigo, ruta_aerea_ciudad_origen, ruta_aerea_ciudad_destino),
			FOREIGN KEY (vuelo_avion, vuelo_aerolinea) REFERENCES GRUPO2.Avion(avion_identificador, avion_aerolinea)
		)

		-- Pasaje
		CREATE TABLE GRUPO2.Pasaje(
			pasaje_codigo int NOT NULL,
			pasaje_vuelo int NOT NULL,
			pasaje_avion char(12) NOT NULL,
			pasaje_butaca int NOT NULL,
			pasaje_tipo_butaca varchar(255) NOT NULL,
			pasaje_aerolinea varchar(255) NOT NULL,
			precio decimal(12, 2) NOT NULL,
			PRIMARY KEY(pasaje_codigo, pasaje_vuelo, pasaje_aerolinea),
			FOREIGN KEY (pasaje_aerolinea, pasaje_vuelo) REFERENCES GRUPO2.Vuelo(vuelo_aerolinea, vuelo_codigo),
			FOREIGN KEY (pasaje_butaca, pasaje_avion, pasaje_aerolinea, pasaje_tipo_butaca) REFERENCES GRUPO2.Butaca(butaca_numero, butaca_avion, butaca_aerolinea, butaca_tipo)
		)

		-- Hotel
		CREATE TABLE GRUPO2.Hotel(
			hotel_nombre varchar(255) NOT NULL,
			hotel_calle varchar(255) NOT NULL,
			hotel_numero_calle varchar(255) NOT NULL,
			hotel_estrellas decimal(18, 0) NOT NULL,
			PRIMARY KEY(hotel_nombre, hotel_calle, hotel_numero_calle),
			FOREIGN KEY(hotel_nombre) REFERENCES GRUPO2.Empresa(empresa_razon_social),
		)

		-- Tipo de Habitacion
		CREATE TABLE GRUPO2.Tipo_Habitacion(
			tipo_habitacion_codigo decimal(18, 0) NOT NULL IDENTITY(1, 1),
			tipo_habitacion_descripcion nvarchar(50) NOT NULL UNIQUE,
			PRIMARY KEY(tipo_habitacion_codigo)
		)

		-- Habitacion
		CREATE TABLE GRUPO2.Habitacion(
			habitacion_hotel_nombre varchar(255) NOT NULL,
			habitacion_hotel_calle varchar(255) NOT NULL,
			habitacion_hotel_numero_calle varchar(255) NOT NULL,
			habitacion_numero decimal(18, 0) NOT NULL,
			habitacion_piso decimal(18, 0) NOT NULL,
			habitacion_tipo decimal(18, 0) NOT NULL,
			habitacion_costo decimal(18, 2) NOT NULL,
			PRIMARY KEY(habitacion_hotel_nombre, habitacion_hotel_calle, habitacion_hotel_numero_calle, habitacion_numero, habitacion_piso),
			FOREIGN KEY(habitacion_tipo) REFERENCES GRUPO2.Tipo_Habitacion(tipo_habitacion_codigo),
			FOREIGN KEY(habitacion_hotel_nombre, habitacion_hotel_calle, habitacion_hotel_numero_calle) REFERENCES GRUPO2.Hotel(hotel_nombre, hotel_calle, hotel_numero_calle)
		)

		-- Estadia
		CREATE TABLE GRUPO2.Estadia(
			estadia_codigo decimal(18, 0) NOT NULL IDENTITY(1, 1),
			estadia_hotel_nombre varchar(255) NOT NULL,
			estadia_hotel_calle varchar(255) NOT NULL,
			estadia_hotel_numero_calle varchar(255) NOT NULL,
			estadia_fecha_inicio datetime2(3) NOT NULL,
			estadia_cantidad_noches decimal(18, 0) NOT NULL,
			PRIMARY KEY(estadia_codigo, estadia_hotel_nombre, estadia_hotel_calle, estadia_hotel_numero_calle),
			FOREIGN KEY(estadia_hotel_nombre, estadia_hotel_calle, estadia_hotel_numero_calle) REFERENCES GRUPO2.Hotel(hotel_nombre, hotel_calle, hotel_numero_calle)
		)

		-- Habitacion x Estadia
		CREATE TABLE GRUPO2.Habitacion_Estadia(
			habitacion_estadia_hotel_nombre varchar(255) NOT NULL,
			habitacion_estadia_hotel_calle varchar(255) NOT NULL,
			habitacion_estadia_hotel_numero_calle varchar(255) NOT NULL,
			habitacion_estadia_codigo_estadia decimal(18, 0) NOT NULL,
			habitacion_estadia_piso_habitacion decimal(18, 0) NOT NULL,
			habitacion_estadia_numero_habitacion decimal(18, 0) NOT NULL,
			habitacion_estadia_costo decimal(18, 2) NOT NULL,
			PRIMARY KEY(habitacion_estadia_hotel_nombre, habitacion_estadia_hotel_calle, habitacion_estadia_hotel_numero_calle, habitacion_estadia_codigo_estadia, habitacion_estadia_piso_habitacion, habitacion_estadia_numero_habitacion),
			FOREIGN KEY(habitacion_estadia_codigo_estadia, habitacion_estadia_hotel_nombre, habitacion_estadia_hotel_calle, habitacion_estadia_hotel_numero_calle) REFERENCES GRUPO2.Estadia(estadia_codigo, estadia_hotel_nombre, estadia_hotel_calle, estadia_hotel_numero_calle),
			FOREIGN KEY(habitacion_estadia_hotel_nombre, habitacion_estadia_hotel_calle, habitacion_estadia_hotel_numero_calle, habitacion_estadia_numero_habitacion, habitacion_estadia_piso_habitacion) REFERENCES GRUPO2.Habitacion(habitacion_hotel_nombre, habitacion_hotel_calle, habitacion_hotel_numero_calle, habitacion_numero, habitacion_piso)
		)

		-- Operacion
		CREATE TABLE GRUPO2.Operacion(
			operacion_numero decimal(18, 0) NOT NULL,
			operacion_tipo varchar(6) NOT NULL,
			operacion_fecha datetime NOT NULL
			PRIMARY KEY(operacion_numero, operacion_tipo)
		)

		-- Operacion Estadia
		CREATE TABLE GRUPO2.Operacion_Estadia(
			operacion_estadia_numero decimal(18, 0) NOT NULL,
			operacion_estadia_tipo varchar(6) NOT NULL,
			operacion_estadia_codigo_estadia decimal(18, 0) NOT NULL,
			operacion_estadia_hotel_nombre varchar(255) NOT NULL,
			operacion_estadia_hotel_calle varchar(255) NOT NULL,
			operacion_estadia_hotel_numero_calle varchar(255) NOT NULL,
			PRIMARY KEY(operacion_estadia_numero, operacion_estadia_tipo, operacion_estadia_hotel_nombre, operacion_estadia_hotel_calle, operacion_estadia_hotel_numero_calle, operacion_estadia_codigo_estadia),
			FOREIGN KEY(operacion_estadia_numero, operacion_estadia_tipo) REFERENCES GRUPO2.Operacion(operacion_numero, operacion_tipo),
			FOREIGN KEY(operacion_estadia_codigo_estadia, operacion_estadia_hotel_nombre, operacion_estadia_hotel_calle, operacion_estadia_hotel_numero_calle) REFERENCES GRUPO2.Estadia(estadia_codigo, estadia_hotel_nombre, estadia_hotel_calle, estadia_hotel_numero_calle)
		)

		-- Operacion_Pasaje
		CREATE TABLE GRUPO2.Operacion_Pasaje(
			operacion_pasaje_numero decimal(18, 0) NOT NULL,
			operacion_pasaje_tipo varchar(6) NOT NULL,
			operacion_pasaje_codigo_pasaje int NOT NULL,
			operacion_pasaje_vuelo_pasaje int NOT NULL,
			operacion_pasaje_aerolinea_pasaje varchar(255) NOT NULL,
			operacion_pasaje_costo decimal(12, 0) NOT NULL,
			PRIMARY KEY(operacion_pasaje_numero, operacion_pasaje_tipo, operacion_pasaje_codigo_pasaje, operacion_pasaje_vuelo_pasaje, operacion_pasaje_aerolinea_pasaje),
			FOREIGN KEY(operacion_pasaje_numero, operacion_pasaje_tipo) REFERENCES GRUPO2.Operacion(operacion_numero, operacion_tipo), 
			FOREIGN KEY(operacion_pasaje_codigo_pasaje, operacion_pasaje_vuelo_pasaje, operacion_pasaje_aerolinea_pasaje) REFERENCES GRUPO2.Pasaje(pasaje_codigo, pasaje_vuelo, pasaje_aerolinea)
		)

		-- Factura
		CREATE TABLE GRUPO2.Factura(
			factura_numero decimal(18, 0) NOT NULL,
			factura_numero_operacion decimal(18, 0) NOT NULL,
			factura_tipo_operacion varchar(6) NOT NULL,
			factura_sucursal_direccion varchar(255) NOT NULL,
			factura_fecha datetime NOT NULL,
			factura_costo_final decimal(18, 2) NOT NULL,
			factura_cliente_dni decimal(18, 0) NOT NULL,
			factura_cliente_nombre varchar(255) NOT NULL,
			factura_cliente_apellido varchar(255) NOT NULL,
			PRIMARY KEY(factura_numero, factura_sucursal_direccion),
			FOREIGN KEY(factura_numero_operacion, factura_tipo_operacion) REFERENCES GRUPO2.Operacion(operacion_numero, operacion_tipo),
			FOREIGN KEY(factura_sucursal_direccion) REFERENCES GRUPO2.Sucursal(sucursal_direccion),
			FOREIGN KEY(factura_cliente_dni, factura_cliente_nombre, factura_cliente_apellido) REFERENCES GRUPO2.Usuario(usuario_dni, usuario_nombre, usuario_apellido)
		)
	END
GO

-- Funciones Útiles --
GO
	CREATE FUNCTION COSTO_OPERACION_ESTADIA(@CODIGO_ESTADIA decimal(18, 0), @HOTEL varchar(255), @HOTEL_CALLE varchar(255), @HOTEL_NUMERO_CALLE varchar(255))
	RETURNS decimal(18, 2)
	AS
	BEGIN
		DECLARE @COSTO_FINAL decimal(18, 2)

		SELECT @COSTO_FINAL = SUM(habitacion_estadia_costo) 
		FROM GRUPO2.Habitacion_Estadia
		WHERE habitacion_estadia_codigo_estadia = @CODIGO_ESTADIA
		AND habitacion_estadia_hotel_nombre = @HOTEL
		AND habitacion_estadia_hotel_calle = @HOTEL_CALLE
		AND habitacion_estadia_hotel_numero_calle = @HOTEL_NUMERO_CALLE

		RETURN @COSTO_FINAL
	END
GO

GO
	CREATE FUNCTION CODIGO_CIUDAD (@ciudad varchar(255))
	RETURNS INT
	AS
	BEGIN
		DECLARE @codigo int
			SELECT @codigo = ciudad_id FROM GRUPO2.Ciudad WHERE ciudad_nombre = @ciudad
		
		RETURN @codigo
	END
GO

-- Migración de las Tablas --
GO
	CREATE PROCEDURE MIGRAR_TABLAS
	AS
	BEGIN
		-- Empresas --
		INSERT INTO GRUPO2.Empresa
			SELECT DISTINCT EMPRESA_RAZON_SOCIAL FROM gd_esquema.Maestra
		-- Sucursales --
		INSERT INTO GRUPO2.Sucursal
			SELECT DISTINCT SUCURSAL_MAIL, SUCURSAL_DIR, SUCURSAL_TELEFONO FROM gd_esquema.Maestra 
			WHERE (SUCURSAL_MAIL IS NOT NULL) AND (SUCURSAL_DIR IS NOT NULL) AND (SUCURSAL_TELEFONO IS NOT NULL)
		-- Usuarios/Clientes --
		INSERT INTO GRUPO2.Usuario
			SELECT DISTINCT CLIENTE_DNI, CLIENTE_NOMBRE, CLIENTE_APELLIDO, CLIENTE_MAIL, CLIENTE_TELEFONO FROM gd_esquema.Maestra 
			WHERE (CLIENTE_DNI IS NOT NULL) AND (CLIENTE_NOMBRE IS NOT NULL) AND (CLIENTE_APELLIDO IS NOT NULL) AND (CLIENTE_MAIL IS NOT NULL) AND (CLIENTE_TELEFONO IS NOT NULL)
		-- Aerolineas --
		INSERT INTO GRUPO2.Aerolinea
			SELECT DISTINCT EMPRESA_RAZON_SOCIAL FROM gd_esquema.Maestra WHERE AVION_IDENTIFICADOR IS NOT NULL
		-- Aviones --
		INSERT INTO GRUPO2.Avion(avion_identificador, avion_aerolinea, avion_modelo)
			SELECT DISTINCT AVION_IDENTIFICADOR, EMPRESA_RAZON_SOCIAL, AVION_MODELO FROM gd_esquema.Maestra WHERE AVION_IDENTIFICADOR IS NOT NULL
		-- Butacas --
		INSERT INTO GRUPO2.Butaca(butaca_numero, butaca_avion, butaca_aerolinea, butaca_tipo)
			SELECT BUTACA_NUMERO, AVION_IDENTIFICADOR, EMPRESA_RAZON_SOCIAL, BUTACA_TIPO FROM gd_esquema.Maestra WHERE AVION_IDENTIFICADOR IS NOT NULL GROUP BY BUTACA_NUMERO, AVION_IDENTIFICADOR, EMPRESA_RAZON_SOCIAL, BUTACA_TIPO
		-- Ciudades --
		INSERT INTO GRUPO2.Ciudad(ciudad_nombre)
			(
				(SELECT DISTINCT RUTA_AEREA_CIU_DEST FROM gd_esquema.Maestra WHERE RUTA_AEREA_CIU_DEST IS NOT NULL)
				UNION
				(SELECT DISTINCT RUTA_AEREA_CIU_ORIG FROM gd_esquema.Maestra WHERE RUTA_AEREA_CIU_ORIG IS NOT NULL)
			)
		-- Rutas Aéreas --
		INSERT INTO GRUPO2.Ruta_Aerea(ruta_aerea_codigo, ruta_aerea_ciudad_origen, ruta_aerea_ciudad_destino)
			SELECT DISTINCT RUTA_AEREA_CODIGO, dbo.CODIGO_CIUDAD(RUTA_AEREA_CIU_ORIG), dbo.CODIGO_CIUDAD(RUTA_AEREA_CIU_DEST) FROM gd_esquema.Maestra WHERE RUTA_AEREA_CODIGO IS NOT NULL
		-- Vuelos --
		INSERT INTO GRUPO2.Vuelo(vuelo_avion, vuelo_aerolinea, vuelo_codigo, vuelo_fecha_salida, vuelo_fecha_llegada, vuelo_ruta_codigo, vuelo_ruta_origen, vuelo_ruta_destino)
			SELECT AVION_IDENTIFICADOR, EMPRESA_RAZON_SOCIAL, VUELO_CODIGO, VUELO_FECHA_SALUDA, VUELO_FECHA_LLEGADA, RUTA_AEREA_CODIGO, dbo.CODIGO_CIUDAD(RUTA_AEREA_CIU_ORIG), dbo.CODIGO_CIUDAD(RUTA_AEREA_CIU_DEST) FROM gd_esquema.Maestra WHERE VUELO_CODIGO IS NOT NULL GROUP BY AVION_IDENTIFICADOR, EMPRESA_RAZON_SOCIAL, VUELO_CODIGO, VUELO_FECHA_SALUDA, VUELO_FECHA_LLEGADA, RUTA_AEREA_CODIGO, RUTA_AEREA_CIU_ORIG, RUTA_AEREA_CIU_DEST
		-- Pasajes --
		INSERT INTO GRUPO2.Pasaje(pasaje_codigo, pasaje_vuelo, pasaje_avion, pasaje_butaca, pasaje_tipo_butaca, pasaje_aerolinea, precio)
			SELECT PASAJE_CODIGO, VUELO_CODIGO, AVION_IDENTIFICADOR, BUTACA_NUMERO, BUTACA_TIPO, EMPRESA_RAZON_SOCIAL, PASAJE_PRECIO FROM gd_esquema.Maestra WHERE PASAJE_CODIGO IS NOT NULL GROUP BY PASAJE_CODIGO, VUELO_CODIGO, AVION_IDENTIFICADOR, BUTACA_NUMERO, BUTACA_TIPO, EMPRESA_RAZON_SOCIAL, PASAJE_PRECIO
		-- Hoteles --
		INSERT INTO GRUPO2.Hotel(hotel_nombre, hotel_calle, hotel_numero_calle, hotel_estrellas)
			SELECT DISTINCT EMPRESA_RAZON_SOCIAL, HOTEL_CALLE, HOTEL_NRO_CALLE, HOTEL_CANTIDAD_ESTRELLAS FROM gd_esquema.Maestra
			WHERE (EMPRESA_RAZON_SOCIAL IS NOT NULL) AND (HOTEL_CALLE IS NOT NULL) AND (HOTEL_NRO_CALLE IS NOT NULL) AND (HOTEL_CANTIDAD_ESTRELLAS IS NOT NULL)
		-- Tipos de habitaciones --
		SET IDENTITY_INSERT GRUPO2.Tipo_Habitacion ON;
		INSERT INTO GRUPO2.Tipo_Habitacion(tipo_habitacion_codigo, tipo_habitacion_descripcion)
			SELECT DISTINCT TIPO_HABITACION_CODIGO, TIPO_HABITACION_DESC FROM gd_esquema.Maestra WHERE TIPO_HABITACION_CODIGO IS NOT NULL
		SET IDENTITY_INSERT GRUPO2.Tipo_Habitacion OFF;
		-- Habitaciones --
		INSERT INTO GRUPO2.Habitacion(habitacion_hotel_nombre, habitacion_hotel_calle, habitacion_hotel_numero_calle, habitacion_numero, habitacion_piso, habitacion_tipo, habitacion_costo)
			SELECT DISTINCT EMPRESA_RAZON_SOCIAL, HOTEL_CALLE, HOTEL_NRO_CALLE, HABITACION_NUMERO, HABITACION_PISO, TIPO_HABITACION_CODIGO, HABITACION_PRECIO
			FROM gd_esquema.Maestra 
			WHERE (EMPRESA_RAZON_SOCIAL IS NOT NULL) AND (HOTEL_CALLE IS NOT NULL) AND (HOTEL_NRO_CALLE IS NOT NULL) AND (HABITACION_NUMERO IS NOT NULL) AND (HABITACION_PISO IS NOT NULL) AND (TIPO_HABITACION_CODIGO IS NOT NULL) AND (HABITACION_PRECIO IS NOT NULL)
		-- Estadias --
		SET IDENTITY_INSERT GRUPO2.Estadia ON;
		INSERT INTO GRUPO2.Estadia(estadia_hotel_nombre, estadia_hotel_calle, estadia_hotel_numero_calle, estadia_codigo, estadia_fecha_inicio, estadia_cantidad_noches)
			SELECT DISTINCT EMPRESA_RAZON_SOCIAL, HOTEL_CALLE, HOTEL_NRO_CALLE, ESTADIA_CODIGO, ESTADIA_FECHA_INI, ESTADIA_CANTIDAD_NOCHES
			FROM gd_esquema.Maestra
			WHERE (EMPRESA_RAZON_SOCIAL IS NOT NULL) AND (HOTEL_CALLE IS NOT NULL) AND (HOTEL_NRO_CALLE IS NOT NULL) AND (ESTADIA_CODIGO IS NOT NULL) AND (ESTADIA_FECHA_INI IS NOT NULL) AND (ESTADIA_CANTIDAD_NOCHES IS NOT NULL)
		SET IDENTITY_INSERT GRUPO2.Estadia OFF;
		-- Habitaciones X Estadia --
		INSERT INTO GRUPO2.Habitacion_Estadia(habitacion_estadia_hotel_nombre, habitacion_estadia_hotel_calle, habitacion_estadia_hotel_numero_calle, habitacion_estadia_codigo_estadia, habitacion_estadia_piso_habitacion, habitacion_estadia_numero_habitacion, habitacion_estadia_costo)
			SELECT DISTINCT EMPRESA_RAZON_SOCIAL, HOTEL_CALLE, HOTEL_NRO_CALLE, ESTADIA_CODIGO, HABITACION_PISO, HABITACION_NUMERO, HABITACION_COSTO
			FROM gd_esquema.Maestra
			WHERE (EMPRESA_RAZON_SOCIAL IS NOT NULL) AND (HOTEL_CALLE IS NOT NULL) AND (HOTEL_NRO_CALLE IS NOT NULL) AND (HABITACION_PISO IS NOT NULL) AND (HABITACION_NUMERO IS NOT NULL) AND (HABITACION_COSTO IS NOT NULL)
		-- Operaciones --
		INSERT INTO GRUPO2.Operacion
			SELECT COMPRA_NUMERO, (CASE WHEN FACTURA_NRO IS NOT NULL THEN 'VENTA' ELSE 'COMPRA' END), COMPRA_FECHA
			FROM gd_esquema.Maestra WHERE (COMPRA_NUMERO IS NOT NULL) AND (COMPRA_FECHA IS NOT NULL)
			GROUP BY COMPRA_NUMERO, COMPRA_FECHA, (CASE WHEN FACTURA_NRO IS NOT NULL THEN 'VENTA' ELSE 'COMPRA' END)
		-- Operaciones de Estadias --
		INSERT INTO GRUPO2.Operacion_Estadia(operacion_estadia_numero, operacion_estadia_codigo_estadia, operacion_estadia_hotel_nombre, operacion_estadia_hotel_calle, operacion_estadia_hotel_numero_calle, operacion_estadia_tipo)
			SELECT DISTINCT COMPRA_NUMERO, ESTADIA_CODIGO, EMPRESA_RAZON_SOCIAL, HOTEL_CALLE, HOTEL_NRO_CALLE, (CASE WHEN FACTURA_NRO IS NOT NULL THEN 'VENTA' ELSE 'COMPRA' END)
			FROM gd_esquema.Maestra
			WHERE (COMPRA_NUMERO IS NOT NULL) AND (ESTADIA_CODIGO IS NOT NULL) AND (EMPRESA_RAZON_SOCIAL IS NOT NULL) AND (HOTEL_CALLE IS NOT NULL) AND (HOTEL_NRO_CALLE IS NOT NULL)
			GROUP BY COMPRA_NUMERO, COMPRA_FECHA, (CASE WHEN FACTURA_NRO IS NOT NULL THEN 'VENTA' ELSE 'COMPRA' END), ESTADIA_CODIGO, EMPRESA_RAZON_SOCIAL, HOTEL_CALLE, HOTEL_NRO_CALLE
		-- Operaciones de Pasajes --
		INSERT INTO GRUPO2.Operacion_Pasaje(operacion_pasaje_numero, operacion_pasaje_tipo, operacion_pasaje_codigo_pasaje, operacion_pasaje_vuelo_pasaje, operacion_pasaje_aerolinea_pasaje, operacion_pasaje_costo)
			SELECT COMPRA_NUMERO, (CASE WHEN FACTURA_NRO IS NOT NULL THEN 'VENTA' ELSE 'COMPRA' END), PASAJE_CODIGO, VUELO_CODIGO, EMPRESA_RAZON_SOCIAL, PASAJE_COSTO
			FROM gd_esquema.Maestra WHERE PASAJE_CODIGO IS NOT NULL
			GROUP BY COMPRA_NUMERO, (CASE WHEN FACTURA_NRO IS NOT NULL THEN 'VENTA' ELSE 'COMPRA' END), PASAJE_CODIGO, VUELO_CODIGO, EMPRESA_RAZON_SOCIAL, PASAJE_COSTO
		-- Facturas --
		INSERT INTO GRUPO2.Factura
			SELECT DISTINCT FACTURA_NRO, COMPRA_NUMERO, 'VENTA', SUCURSAL_DIR, FACTURA_FECHA, (PASAJE_COSTO*1.2), CLIENTE_DNI, CLIENTE_NOMBRE, CLIENTE_APELLIDO FROM gd_esquema.Maestra 
			WHERE (COMPRA_NUMERO IS NOT NULL) AND (SUCURSAL_DIR IS NOT NULL) AND (FACTURA_FECHA IS NOT NULL) AND (PASAJE_COSTO IS NOT NULL)
		INSERT INTO GRUPO2.Factura
			SELECT DISTINCT FACTURA_NRO, COMPRA_NUMERO, 'VENTA', SUCURSAL_DIR, FACTURA_FECHA, (dbo.COSTO_OPERACION_ESTADIA(ESTADIA_CODIGO, EMPRESA_RAZON_SOCIAL, HOTEL_CALLE, HOTEL_NRO_CALLE)*1.2), CLIENTE_DNI, CLIENTE_NOMBRE, CLIENTE_APELLIDO FROM gd_esquema.Maestra 
			WHERE (COMPRA_NUMERO IS NOT NULL) AND (SUCURSAL_DIR IS NOT NULL) AND (FACTURA_FECHA IS NOT NULL) AND (HABITACION_COSTO IS NOT NULL)
	END
GO

-- Creo las tablas correspondientes --
EXECUTE CREAR_TABLAS

-- Creo los triggers correspondientes --
GO
	CREATE TRIGGER TG_INSERTAR_RUTA_AEREA ON GRUPO2.Ruta_Aerea INSTEAD OF INSERT
	AS
	BEGIN
		INSERT INTO GRUPO2.Ruta_Aerea(ruta_aerea_codigo, ruta_aerea_ciudad_origen, ruta_aerea_ciudad_destino)
			SELECT ruta_aerea_codigo, ruta_aerea_ciudad_origen, ruta_aerea_ciudad_destino FROM inserted WHERE ruta_aerea_ciudad_origen != ruta_aerea_ciudad_destino
	END
GO

GO
	CREATE TRIGGER TG_MODIFICAR_RUTA_AEREA ON GRUPO2.Ruta_Aerea INSTEAD OF UPDATE
	AS
	BEGIN
		DECLARE @codigo_actual int
		DECLARE @origen_actual int 
		DECLARE @destino_actual int

		DECLARE @codigo_nuevo int
		DECLARE @origen_nuevo int 
		DECLARE @destino_nuevo int
		
		DECLARE CURSOR_NUEVOS_DATOS CURSOR FOR
			SELECT ruta_aerea_codigo, ruta_aerea_ciudad_origen, ruta_aerea_ciudad_destino FROM inserted
		DECLARE CURSOR_DATOS_ANTIGUOS CURSOR FOR
			SELECT ruta_aerea_codigo, ruta_aerea_ciudad_origen, ruta_aerea_ciudad_destino FROM deleted
	
		OPEN CURSOR_NUEVOS_DATOS
		OPEN CURSOR_DATOS_ANTIGUOS

		DECLARE @status_nuevos int
		DECLARE @status_viejos int

		FETCH NEXT FROM CURSOR_NUEVOS_DATOS INTO @codigo_nuevo, @origen_nuevo, @destino_nuevo
		SET @status_nuevos = @@FETCH_STATUS
		FETCH NEXT FROM CURSOR_DATOS_ANTIGUOS INTO @codigo_actual, @origen_actual, @destino_actual
		SET @status_viejos = @@FETCH_STATUS
		WHILE((@status_nuevos = 0) AND (@status_viejos = 0))
			BEGIN
				IF(@destino_nuevo != @origen_nuevo)
					BEGIN
						UPDATE GRUPO2.Ruta_Aerea SET ruta_aerea_codigo = @codigo_nuevo, ruta_aerea_ciudad_origen = @origen_nuevo, ruta_aerea_ciudad_destino = @destino_nuevo
						WHERE (ruta_aerea_codigo = @codigo_actual) AND (ruta_aerea_ciudad_origen = @origen_actual) AND (ruta_aerea_ciudad_destino = @destino_actual)
					END

				FETCH NEXT FROM CURSOR_NUEVOS_DATOS INTO @codigo_nuevo, @origen_nuevo, @destino_nuevo
				SET @status_nuevos = @@FETCH_STATUS
				FETCH NEXT FROM CURSOR_DATOS_ANTIGUOS INTO @codigo_actual, @origen_actual, @destino_actual
				SET @status_viejos = @@FETCH_STATUS
			END

		CLOSE CURSOR_NUEVOS_DATOS
		CLOSE CURSOR_DATOS_ANTIGUOS
		DEALLOCATE CURSOR_NUEVOS_DATOS
		DEALLOCATE CURSOR_DATOS_ANTIGUOS
	END
GO

-- Realizo la migración --
EXECUTE MIGRAR_TABLAS