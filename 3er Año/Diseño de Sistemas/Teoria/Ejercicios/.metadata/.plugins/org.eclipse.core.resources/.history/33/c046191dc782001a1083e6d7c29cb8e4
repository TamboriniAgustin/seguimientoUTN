/** EJERCICIO - ¿QUÉ ME PONGO? - Diseño de Sistemas - Agustín Tamborini **/
package OpcionA;
import java.util.ArrayList;

class CorrerPrograma {
	public static void main(String[] args) {

	}
}

//Atuendos
class Atuendo {
	ArrayList <Prenda> prendas = new ArrayList<>();
	
	void agregarPrenda(Prenda prenda) {
		prendas.add(prenda);
	}
	void removerPrenda (Prenda prenda) {
		prendas.remove(prenda);
	}
}


//Prendas
class Prenda {
	TipoDePrenda tipo;
	Material material;
	Color color_principal;
	Color color_secundario;
	
	Prenda(TipoDePrenda tipo, Material material, Color color_principal){
		this.tipo = tipo;
		this.material = material;
		this.color_principal = color_principal;
	}
	
	void agregarColorSecundario(Color color) {
		this.color_secundario = color;
	}
}

//Tipos de prenda
abstract class TipoDePrenda {
	Categoria categoria;
	
	TipoDePrenda(Categoria categoria){
		this.categoria = categoria;
	}
	
	Categoria categoria() {
		return categoria;
	}
}

//Categorías de prenda
enum Categoria {
	ACCESORIO, CALZADO, SUPERIOR, INFERIOR
}

//Materiales
enum Material {
	ALGODON, CUERO
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