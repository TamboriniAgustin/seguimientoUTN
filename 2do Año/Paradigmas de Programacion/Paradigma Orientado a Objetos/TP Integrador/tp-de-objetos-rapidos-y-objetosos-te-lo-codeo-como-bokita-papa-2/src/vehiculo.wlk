import motor.*
import rueda.*
import piloto.*
import escuderia.*
import pista.*

class Vehiculo {
	const property peso //En kilogramos
	const property escuderia
	var property motor
	var property cubiertas = []
	
	method tiempoDePista(pista) { return 8 * pista.largoPorVuelta() * (self.peso() / motor.potencia()) }
	method motorFuncionando() = !motor.estaPalmado()
	method cubiertasOptimas() { return cubiertas.filter({rueda => rueda.estaOptima()}).size() }
	method funciona() = self.motorFuncionando() && self.cubiertasOptimas() > 2
	method escuderia() { return escuderia.nombre() }
}