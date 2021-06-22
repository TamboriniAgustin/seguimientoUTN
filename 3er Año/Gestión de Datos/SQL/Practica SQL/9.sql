USE GD_UTN

SELECT 
		empl_jefe AS codigo_jefe, 
		empl_codigo AS codigo_empleado, 
		empl_apellido+SPACE(3)+empl_nombre AS nombre,
		(SELECT COUNT(*) FROM DEPOSITO WHERE depo_encargado = empl_jefe) AS depositos_jefe,
		(SELECT COUNT(*) FROM DEPOSITO WHERE depo_encargado = empl_codigo) AS depositos_empleado
FROM Empleado 
	WHERE empl_jefe > 0