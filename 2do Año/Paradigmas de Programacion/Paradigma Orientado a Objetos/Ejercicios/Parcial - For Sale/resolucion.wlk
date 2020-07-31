/* INMOBILIARIA */
object inmobiliaria {
	var property porcentajePorVenta = 1.5
	const empleados = #{}
	
	//PUNTO 2
	method mejorEmpleado(criterio){
		return empleados.max({empleado => criterio.obtenerMejor(empleado)})
	}
}

class Empleado {
	const property nombre
	const reservas = #{}
	const operacionesCerradas = #{}
	
	method reservasRealizadas() = reservas.size()
	method operacionesCerradas() = operacionesCerradas.size()
	method comisionesObtenidas() = operacionesCerradas.sum({operacion => operacion.comision()})
	//PUNTO 3
	method zonasEnLasQueOpero() = operacionesCerradas.map({operacion => operacion.zonaDelInmueble()})
	method operoEnZona(zona) = self.zonasEnLasQueOpero().contains(zona)
	method operoEnLaMismaZonaQue(empleado) = self.zonasEnLasQueOpero().any({zona => empleado.operoEnZona(zona)})
	method reservo(operacion) = reservas.contains(operacion)
	method concretoOperacionesReservadasPor(empleado) = operacionesCerradas.any({operacion => empleado.reservo(operacion)})
	method tendraProblemasCon(empleado) = self.operoEnLaMismaZonaQue(empleado) && (self.concretoOperacionesReservadasPor(empleado) || empleado.concretoOperacionesReservadasPor(self))
	//PUNTO 4
	method realizarReserva(operacion, cliente){
		operacion.reservar(cliente)
		reservas.add(operacion)
	}
	method concretarOperacion(operacion, cliente){
		operacion.concretar(cliente)
		operacionesCerradas.add(operacion)
	}
}

class Cliente {
	const property nombre
}

/* CRITERIOS PARA PONDERAR A LOS MEJORES EMPLEADOS */
object cantidadDeReservas{
	method obtenerMejor(empleado){
		return empleado.reservasRealizadas()
	}
}

object operacionesConcretadas{
	method obtenerMejor(empleado){
		return empleado.operacionesCerradas()
	}
}

object comisionesObtenidas{
	method obtenerMejor(empleado){
		return empleado.comisionesObtenidas()
	}
}

/* INMUEBLES */
class Inmueble {
	const tamanio
	const ambientes
	const zona
	
	method valor() = zona.valor()
	method puedeVenderse() = true
}

class Casa inherits Inmueble {
	var precio
	
	override method valor() = super() + precio
}

class PH inherits Inmueble {
	method valorPorMetroCuadrado() = tamanio * 14000
	override method valor() = super() + 500000.max(self.valorPorMetroCuadrado())
}

class Departamento inherits Inmueble {
	override method valor() = super() + (ambientes * 350000)
}

//PUNTO 5
class Local inherits Casa {
	const tipo
	
	override method valor() = super() + tipo.valor(precio)
	override method puedeVenderse() = false
}

/* TIPOS DE LOCALES */
object galpon {
	method valor(valorLocal) = valorLocal / 2
}

class DeCalle {
	const montoFijo
	
	method valor(valorLocal) = valorLocal + montoFijo
}

/* ZONAS */
class Zona {
	var property valor
}

/* OPERACIONES */
class Operacion {
	const inmueble
	var estado = operacionDisponible
	
	method estado(nuevo_estado){
		estado = nuevo_estado
	}
	method reservar(cliente){
		estado.reservar(self, cliente)
	}
	method concretar(){
		estado.concretar(self)
	}
	method zonaDelInmueble(){
		return inmueble.zona()
	}
	//PUNTO 1
	method comision() = 0
}

class Alquiler inherits Operacion {
	const mesesDeContrato
	
	override method comision() = (mesesDeContrato * inmueble.valor()) / 50000
}

class Venta inherits Operacion {
	method porcentajeDeComision() = 1 + (inmobiliaria.porcentajePorVenta()/100)
	override method comision() = inmueble.valor() * self.porcentajeDeComision()
	override method reservar(cliente){
		if(inmueble.puedeVenderse()) estado.reservar(self, cliente)
		else throw new Exception(message = "El inmueble seleccionado no está apto para venderse")
	}
	override method concretar(){
		if(inmueble.puedeVenderse()) estado.concretar(self)
		else throw new Exception(message = "El inmueble seleccionado no está apto para venderse")
	}
}

/* ESTADO DE OPERACIONES */
class EstadoDeOperacion {
	method reservar(operacion, cliente) {}
	method concretar(operacion, cliente) {
		operacion.estado(new OperacionConcretada(clienteQueConcreto = cliente))
	}
}

object operacionDisponible inherits EstadoDeOperacion {
	override method reservar(operacion, cliente){
		operacion.estado(new OperacionReservada(clienteQueReservo = cliente))
	}
}

class OperacionReservada inherits EstadoDeOperacion {
	const property clienteQueReservo
	
	override method reservar(operacion, cliente){
		throw new Exception(message = "Esta operación ya ha sido reservada por otro cliente")
	}
	override method concretar(operacion, cliente){
		if(clienteQueReservo == cliente) super(operacion, cliente)
		else throw new Exception(message = "Esta operación se encuentra reservada para otro cliente")
	}
}

class OperacionConcretada inherits EstadoDeOperacion {
	const property clienteQueConcreto
	
	override method reservar(operacion, cliente){
		throw new Exception(message = "Esta operación ya se ha cerrado")
	}
	override method concretar(operacion, cliente){
		throw new Exception(message = "Esta operación ya se ha cerrado")
	}
}