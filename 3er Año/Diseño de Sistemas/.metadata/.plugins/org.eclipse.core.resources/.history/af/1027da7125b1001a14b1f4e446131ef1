package Compra;

import Moneda.Moneda;
import Moneda.CodigoMoneda;
import Repositorios.RepositorioDeMonedas.RepositorioDeMonedas;

public class RepositorioDeMonedasMock implements RepositorioDeMonedas {
	String estado = "";
	
	@Override
    public Moneda getMoneda(CodigoMoneda codigoMoneda) {
        if(estado.isEmpty()) return null;
        else return new Moneda(CodigoMoneda.ARS, "Peso Argentino");
    }
	
	public void setEstado(String estado) {
		this.estado = estado;
	}
}