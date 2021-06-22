/** EJERCICIO - ¿QUÉ ME PONGO? - Diseño de Sistemas - Agustín Tamborini **/
package OpcionA;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Objects;
import java.util.Set;

//Sugerencias
class Sugerencia {
	String institucion;
	Prenda prenda_superior;
	Prenda prenda_inferior;
	Prenda calzado;
	
	Sugerencia(String institucion, Prenda superior, Prenda inferior, Prenda calzado){
		this.institucion = institucion;
		this.prenda_superior = superior;
		this.prenda_inferior = inferior;
		this.calzado = calzado;
	}
	
	String verInstitucion(){
		return "Sugerencia de " + this.institucion;
	}
	List<Prenda> verUniforme(){
		List<Prenda> prendas = Arrays.asList(prenda_superior, prenda_inferior, calzado);
		return prendas;
	}
}

//Atuendos
class Atuendo {
	ArrayList <Prenda> prendas = new ArrayList<>();
	
	public void agregarPrenda(Prenda prenda) {
		if(prenda.esValida()){
			prendas.add(prenda);
		}
		else {
			throw new RuntimeException("La prenda aún no ha sido guardada correctamente");
		}
	}
	void removerPrenda (Prenda prenda) {
		prendas.remove(prenda);
	}
}

//Uniformes
class Uniforme extends Atuendo {
	List <Categoria> prendas_validas = Arrays.asList(Categoria.SUPERIOR, Categoria.INFERIOR, Categoria.CALZADO);
	
	public void agregarPrenda(Prenda prenda){
		if(this.tiene(prenda.categoria()) || !prendas_validas.contains(prenda.categoria())){
			throw new RuntimeException("Ya se ha añadido una prenda de esta categoría al uniforme");
		}
		else{
			super.agregarPrenda(prenda);
		}
	}
	boolean tiene(Categoria categoria){
		return prendas.stream().anyMatch(prenda -> categoria.equals(prenda.categoria()));
	}
}

//Prendas
class Prenda {
	TipoDePrenda tipo;
	Material material;
	Color color_principal;
	Color color_secundario;
	
	Prenda(TipoDePrenda tipo){
		this.tipo = tipo;
	}
	
	void setMaterial(Material material){
		if(tipo.esCompatibleCon(material)){
			this.material = material;
		}
		else {
			throw new RuntimeException("El material no es compatible con el tipo de prenda creado previamente");
		}
	}
	void setColorPrincipal(Color color){
		this.color_principal = color;
	}
	void setColorSecundario(Color color){
		this.color_secundario = color;
	}
	private boolean tieneMaterialAsignado(){
		return Objects.nonNull(material);
	}
	private boolean tieneColorAsignado(){
		return Objects.nonNull(color_principal);
	}
	boolean esValida(){
		return this.tieneMaterialAsignado() && this.tieneColorAsignado();
	}
	Categoria categoria(){
		return this.tipo.categoria;
	}
}

//Tipos de prenda
class TipoDePrenda {
	Categoria categoria;
	Set <Material> materiales_compatibles = new HashSet<>();
	
	TipoDePrenda(Categoria categoria){
		this.categoria = categoria;
	}
	
	void nuevoMaterialCompatible(Material material){
		materiales_compatibles.add(material);
	}
	boolean esCompatibleCon(Material material){
		return materiales_compatibles.contains(material);
	}
}

//Categorías de prenda
enum Categoria {
	ACCESORIO, CALZADO, SUPERIOR, INFERIOR
}

//Materiales
class Material {
	Trama trama = Trama.LISA;
	
	void setTrama(Trama trama){
		this.trama = trama;
	}
}

//Tramas de Materiales
enum Trama {
	LISA, RAYADA, CON_LUNARES, A_CUADROS, ESTAMPADO
}

//Colores
class Color {
	int r;
	int g;
	int b;
	double a;
	
	Color(int red, int green, int blue, double alpha){
		r = red;
		g = green;
		b = blue;
		a = alpha;
	}
}