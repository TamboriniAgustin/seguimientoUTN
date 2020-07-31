/* PERSONAS */
class Persona {
	const carrerasQueDeseaEstudiar = #{}
	const carrerasConcluidas = #{}
	const lugaresQueDeseaVisitar = #{}
	const lugaresVisitados = #{}
	const suenios = []
	const sueniosCumplidos = #{}
	const property plataQueDeseaGanar
	var edad
	var hijos = 0
	var felicidonios = 0
	var tipo
	
	method nuevoSuenio(suenio){
		suenios.add(suenio)
	}
	//PUNTO 1
	method sumarFelicidonios(cantidad){
		felicidonios = felicidonios + cantidad
	}
	method quiereEstudiar(carrera) = carrerasQueDeseaEstudiar.contains(carrera)
	method recibirse(carrera){
		carrerasConcluidas.add(carrera)
		carrerasQueDeseaEstudiar.remove(carrera)
	}
	method cantidadDeHijos() = hijos
	method tenerHijos(cantidad){
		hijos = hijos + cantidad
	}
	method viajar(lugar){
		lugaresVisitados.add(lugar)
		lugaresQueDeseaVisitar.remove(lugar)
	}
	method cumplirSuenio(suenio){
		if(suenios.contains(suenio)){
			suenio.cumplirse(self)
			sueniosCumplidos.add(suenio)
			suenios.remove(suenio)
		}
		else throw new SuenioSinInteres()
	}
	//PUNTO 3
	method cumplirSuenioMasPreciado(){
		const suenioElegido = tipo.suenioMasImporante()
		self.cumplirSuenio(suenioElegido)
	}
	//PUNTO 4
	method nivelDeFelicidad() = sueniosCumplidos.sum({suenio => suenio.nivelDeFelicidad()})
	method nivelDeFelicidadPendiente() = suenios.sum({suenio => suenio.nivelDeFelicidad()})
	method esFeliz() = self.nivelDeFelicidad() > self.nivelDeFelicidadPendiente()
	//PUNTO 5
	method sueniosConMasDe100Felicidonios() = suenios.filter({suenio => suenio.nivelDeFelicidad() > 100}).size()
	method sueniosCumplidosConMasDe100Felicidonios() = sueniosCumplidos.filter({suenio => suenio.nivelDeFelicidad() > 100}).size()
	method esAmbiciosa() = (self.sueniosConMasDe100Felicidonios() > 3) || (self.sueniosCumplidosConMasDe100Felicidonios() > 3)
}

/* TIPOS DE PERSONAS */
object realista inherits Persona {
	method suenioMasImportante() = suenios.max({suenio => suenio.nivelDeFelicidad()}) 
}

object alocada inherits Persona {
	method suenioMasImportante() = suenios.anyOne()
}

object obsesivo inherits Persona {
	method suenioMasImportante() = suenios.head()
}

/* SUEÑOS */
class Suenio{
	const property nivelDeFelicidad = 0
	
	method puedeCumplirse(persona) = true
	method cumplirse(persona){ 
		persona.sumarFelicidonios(nivelDeFelicidad)
	}
}

class Recibirse inherits Suenio {
	const carrera
	
	override method puedeCumplirse(persona) = !persona.quiereEstudiar(carrera) || persona.termino(carrera)
	override method cumplirse(persona){
		if(!self.puedeCumplirse(persona)) throw new CarreraInvalida()
		else{
			persona.recibirse(carrera)
			super(persona)
		}
	}
}

class TenerHijo inherits Suenio {
	const cantidad
	
	override method cumplirse(persona){
		persona.tenerHijos(cantidad)
		super(persona)
	}
}

class AdoptarHijo inherits TenerHijo {
	override method puedeCumplirse(persona) = persona.cantidadDeHijos() > 0
	override method cumplirse(persona){
		if(!self.puedeCumplirse(persona)) throw new AdopcionNegada()
		else {
			persona.tenerHijos(cantidad)
			super(persona)
		} 
	}
}

class Viajar inherits Suenio {
	const lugar
	
	override method cumplirse(persona){
		persona.viajar(lugar)
		super(persona)
	}
}

class ConseguirTrabajo inherits Suenio {
	const sueldo
	
	override method puedeCumplirse(persona) = sueldo < persona.plataQueDeseaGanar()
	override method cumplirse(persona){
		if(!self.puedeCumplirse(persona)) throw new TrabajoInsastifactorio()
		else super(persona)
	}
}

//PUNTO 2
class SuenioMultiple inherits Suenio {
	const suenios = #{}
	
	override method puedeCumplirse(persona){
		return suenios.all({suenio => suenio.puedeCumplirse(persona)})
	}
	override method cumplirse(persona){
		if(!self.puedeCumplirse(persona)) throw new NoSeCumplenTodosLosSuenios()
		else suenios.forEach({suenio => persona.cumplirSuenio(suenio)})
	}
}

/* LUGARES */
class Lugar {
	const property nombre
}

/* EXCEPCIONES */
class SuenioSinInteres inherits Exception { }
class CarreraInvalida inherits Exception { }
class TrabajoInsastifactorio inherits Exception { }
class AdopcionNegada inherits Exception { }
class NoSeCumplenTodosLosSuenios inherits Exception { }