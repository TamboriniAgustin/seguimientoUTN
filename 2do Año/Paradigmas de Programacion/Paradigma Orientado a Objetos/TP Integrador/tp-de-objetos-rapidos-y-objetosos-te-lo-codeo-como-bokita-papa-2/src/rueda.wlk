class Rueda {
	const fechaDeFabricacion //Toma un new Date como entrada
	const fechaActual = new Date()
	var profundidadDeDibujo = 2 //En milimetros
	var kilometrosRecorridos = 0

	method profundidadDeDibujo() { return profundidadDeDibujo }
	
	method calcularAntiguedad(){
		if(fechaActual >= fechaDeFabricacion) return ((fechaActual - fechaDeFabricacion) / 365).truncate(0)
		else throw new Exception(message = "Ups! Parece que esta rueda aún no se ha fabricado")
	}
	method usar(kilometros){
		kilometrosRecorridos = kilometrosRecorridos + kilometros
		self.desgastarComponentes(kilometros)
	}
	method desgastarComponentes(kilometros){
		
	}	
}

class Slik inherits Rueda {
	method estaOptima() = (profundidadDeDibujo.between(1,2)) && (self.calcularAntiguedad() < 3)
	
	override method desgastarComponentes(kilometros){
		profundidadDeDibujo = profundidadDeDibujo - (kilometros * 0.05)
	}
}

class Radial inherits Rueda {
	method estaOptima() = (profundidadDeDibujo > 1.6) && (self.calcularAntiguedad() < 10)
	
	override method desgastarComponentes(kilometros){
		profundidadDeDibujo = profundidadDeDibujo - (kilometros * 0.001)
	}
}

class Nieve inherits Rueda {
	method estaOptima() = true
}