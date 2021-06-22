class Pista {
	const property nombre
	const property pilotosInscriptos = #{}
	var property largoPorVuelta
	var property cantidadDeCurvas
	var property cantidadDeVueltas = 20 //Seteo 20 por defecto

	method nombrePar() = nombre.length() % 2 == 0
	method tiempoDeCarrera(piloto) { return piloto.tiempoTotalDePista(self) * self.largoTotal() }
	method largoTotal() { return cantidadDeVueltas * largoPorVuelta }
	method nombreDeParticipantes() { return pilotosInscriptos.map({piloto => piloto.nombre()}) }
	method vehiculosDeParticipantes() { return pilotosInscriptos.map({piloto => piloto.vehiculo()}) }
	method ruedasDeVehiculosDeParticipantes() { return self.vehiculosDeParticipantes().map({vehiculo => vehiculo.cubiertas()}) }
	method pilotosOrdenadosPorTiempo() { return pilotosInscriptos.sortedBy({piloto1, piloto2 => self.tiempoDeCarrera(piloto1) < self.tiempoDeCarrera(piloto2)}) }
	method terminaronJoya() { return pilotosInscriptos.filter({piloto => piloto.vehiculo().funciona()}).map({piloto => piloto.nombre()}) }
	method carreraSinProblemas() = self.nombreDeParticipantes() == self.terminaronJoya()
	method autoMasPotente() { return self.vehiculosDeParticipantes().max({vehiculo => vehiculo.motor().potencia()}) }
	method podio() { return self.pilotosOrdenadosPorTiempo().take(3) }
	
	method inscribirPiloto(piloto){
		if(piloto.puedeInscribirse()) pilotosInscriptos.add(piloto)
		else piloto.rechazadoPor()
	}
	method desgastarMotorVehiculos() {
		self.vehiculosDeParticipantes().forEach({vehiculo => vehiculo.motor().usar(self.largoTotal())})
	}
	method desgastarRuedasVehiculos() {
		self.ruedasDeVehiculosDeParticipantes().forEach({ruedas => ruedas.forEach({rueda => rueda.usar(self.largoTotal())})})
	}
	method correr(){
		self.desgastarMotorVehiculos()
		self.desgastarRuedasVehiculos()
	}
}