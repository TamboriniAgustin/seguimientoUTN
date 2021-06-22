object estiloDeModa {
	var property estilo = cabulero
}

class Piloto {
	const property nombre
	var estiloDeConduccion
	var property vehiculo
	
	method tiempoDePista(pista) { return estiloDeConduccion.tiempoDePista(pista) }
	method tiempoTotalDePista(pista) { return self.tiempoDePista(pista) + self.vehiculo().tiempoDePista(pista) }
	method puedeInscribirse() = vehiculo.funciona()
	
	method rechazadoPor(){
		if(vehiculo.motor().aceite() < 1) throw new Exception(message = "El motor de tu vehiculo esta fundido! Revisa que tu nivel de aceite sea mayor a 1L")
		else if(vehiculo.motor().presionMedia() < 1) throw new Exception(message = "El motor de tu vehiculo esta fundido! Revisa que tu presion media sea mayor a 0")
		else if(vehiculo.motor().potencia() < 100) throw new Exception(message = "La potencia de tu motor es muy baja! Asegurate de que tenga al menos 100HP")
		else if(vehiculo.cubiertasOptimas() <= 2) throw new Exception(message = "Tu vehiculo debe contener al menos 3 cubiertas optimas para poder competir!")
		else if(vehiculo.motor().tipo().vidaUtilDeSellosApex() < 50) throw new Exception(message = "La vida util de los sellos Apex de tu motor tiene un porcentaje menor al 50%")
	}
}

/* TIPOS DE CONDUCCION */
object cabulero {
	method tiempoDePista(pista){
		if (pista.nombrePar()) return pista.largoPorVuelta() * 10	
		else return pista.largoPorVuelta() * 9	
	}
}

class Audaz {
	var tiempoDeCurva
	
	method tiempoDePista(pista){ return tiempoDeCurva * pista.cantidadDeCurvas() * pista.largoPorVuelta() }
}

class Virtuoso {
	var nivelDeVirtuosismo
	
	method tiempoDePista(pista){ return (pista.largoPorVuelta() * 30) / nivelDeVirtuosismo }
}

object seguidor {
	method tiempoDePista(pista){ return estiloDeModa.estilo().tiempoDePista(pista) }
}