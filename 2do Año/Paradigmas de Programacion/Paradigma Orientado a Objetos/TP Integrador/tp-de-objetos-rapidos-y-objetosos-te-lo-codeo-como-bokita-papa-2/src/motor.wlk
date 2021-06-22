class Motor {
	const cilindrada //En CM3
	const cilindros
	const rpm
	var presionMedia
	var aceite = 5 //En litros
	var property tipo = new Normal() //Seteo un motor por defecto normal
	
	method aceite() { return aceite }
	method presionMedia() { return presionMedia }
	method potencia() { 
		return ((cilindrada/1000000) * cilindros * presionMedia * (rpm/100)) + self.potenciaExtra()
	}
	
	method potenciaExtra() { return tipo.potenciaExtra() }
	method estaPalmado() { return tipo.estaPalmado(self.potencia(), aceite, presionMedia) }
	method usar(kilometros) { 
		tipo.usar(kilometros)
		self.desgastarComponentes(kilometros)
	}
	method desgastarComponentes(kilometros) {
		aceite = aceite - tipo.desgasteAceite(kilometros)
		presionMedia = presionMedia - tipo.desgastePresionMedia(kilometros)
	}
}

/* TIPOS DE MOTOR */
class Normal{
	method potenciaExtra() { return 0 }
	method estaPalmado(potencia, aceite, presionMedia) = self.estaFundido(aceite, presionMedia) || (potencia < 100)
	method estaFundido(aceite, presionMedia) = (aceite < 1) || (presionMedia == 0)
	method desgasteAceite(kilometros) { return 0.01 * kilometros }
	method desgastePresionMedia(kilometros){ return 10 }
	method usar(kilometros) {  }
}

class VinDiesel inherits Normal{
	var kilometrosRecorridos = 0
	var carrerasDeUso = 0
	
	method carrerasDeUsoPares() = (carrerasDeUso % 2) == 0
	
	override method usar(kilometros){
		kilometrosRecorridos = kilometrosRecorridos + kilometros
		carrerasDeUso = carrerasDeUso + 1
	}
	override method desgasteAceite(kilometros){
		if(self.carrerasDeUsoPares()) return 0.02 * kilometros
		else return 0 
	}
	override method desgastePresionMedia(kilometros){
		if(kilometrosRecorridos > 10000) return 20
		else return 5
	}
}

class Turbo inherits Normal{
	var property presionTurbo
	
	override method potenciaExtra() { return 18 * presionTurbo }	
}

class Wankel inherits Normal{
	var vidaUtilDeSellosApex
	
	method vidaUtilDeSellosApex() { return vidaUtilDeSellosApex }
	override method estaPalmado(potencia, aceite, presionMedia) = super(potencia, aceite, presionMedia) || (vidaUtilDeSellosApex < 50)	
	override method usar(kilometros){
		vidaUtilDeSellosApex = vidaUtilDeSellosApex - (kilometros * 0.1) 
	}
}

class Nitroso inherits Normal{
	var property escuderiaDuenia
	
	override method potenciaExtra(){
		if(escuderiaDuenia.reservaDeNitro() > 0) return 200
		else return super()
	}
	override method usar(kilometros){
		if(escuderiaDuenia.reservaDeNitro() >= 2) escuderiaDuenia.reservaDeNitro(2)
	}
	
}

class Combinado inherits Normal{
	const motoresQueLoIntegran = []
	
	override method potenciaExtra() { return motoresQueLoIntegran.fold(0, {valorInicial, motor => valorInicial + motor.potenciaExtra()}) }
	override method estaPalmado(potencia, aceite, presionMedia) = motoresQueLoIntegran.any({motor => motor.estaPalmado()})
	override method usar(kilometros){
		motoresQueLoIntegran.forEach({motor => motor.usar(kilometros)})
	}
	
	method insertarMotor(motor){
		if(!motoresQueLoIntegran.contains(motor)){
			motoresQueLoIntegran.add(motor)
		}
	}
	method eliminarMotor(motor){
		motoresQueLoIntegran.remove(motor)
	}
}