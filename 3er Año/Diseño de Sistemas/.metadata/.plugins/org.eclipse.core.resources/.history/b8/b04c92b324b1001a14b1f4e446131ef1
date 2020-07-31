package Moneda;
import Moneda.CodigoMoneda;
import Compra.RepositorioDeMonedasMock;
import Repositorios.RepositorioDeMonedas.*;
import Usuario.Usuario;

import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;

public class TestRepositorioDeMonedas {
	@Test()
    public void encuentroMonedaEnAPI() {
		RepositorioDeMonedasMock repositorio = new RepositorioDeMonedasMock();
		repositorio.setEstado("encuentraAPI");
		
		Moneda monedaEsperada = new Moneda(CodigoMoneda.ARS, "Peso Argentino");
		Moneda monedaObtenida = repositorio.getMoneda(CodigoMoneda.ARS);
		
		boolean coincideCodigo = monedaEsperada.getCodigo() == monedaObtenida.getCodigo();
		boolean coincideDescripcion = monedaEsperada.getDescripcion() == monedaObtenida.getDescripcion();
		
		Assert.assertTrue(coincideCodigo && coincideDescripcion);
	}
	
	@Test()
	public void noEncuentroMonedaEnAPI() {
		RepositorioDeMonedasMock repositorio = new RepositorioDeMonedasMock();
		
		Assert.assertTrue(repositorio.getMoneda(CodigoMoneda.ARS) == null);
	}
}