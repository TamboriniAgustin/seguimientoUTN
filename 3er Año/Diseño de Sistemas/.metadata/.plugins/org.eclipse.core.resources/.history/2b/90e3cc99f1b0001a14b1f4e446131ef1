package Compra;
import Moneda.CodigoMoneda;
import Proveedor.Proveedor;
import org.junit.Before;
import org.junit.Test;

import Entidad.EntidadBase;
import Entidad.EntidadJuridica;
import Entidad.OrganizacionSectorSocial;
import MedioDePago.PagoEnEfectivo;

import static org.junit.Assert.assertEquals;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.ArrayList;

public class TestCompra {
    private ArrayList<EntidadBase> entidadesBase = new ArrayList<>();
    private EntidadJuridica entidad = new OrganizacionSectorSocial("Entidad de Prueba", "Entidad Real", "1222222224", "Avenida 123", 845, entidadesBase);
    private Proveedor proveedor = new Proveedor(22222222, 1222222224, "Juan", "Perez", "Razon Social", null);
    private PagoEnEfectivo medioDePago = new PagoEnEfectivo();
    private Compra compra;

    @Before
    public void init() {

        compra = new Compra(new RepositorioDeMonedasMock(), entidad, proveedor,  LocalDate.now(), medioDePago, CodigoMoneda.ARS, 2, null);
        compra.agregarItem(new Item("Item 1", 1, BigDecimal.valueOf(50.0)));
        compra.agregarItem(new Item("Item 1", 1, BigDecimal.valueOf(40.5)));
        compra.agregarItem(new Item("Item 1", 1, BigDecimal.valueOf(9.5)));
    }

    @Test
    public void obtenerValorTotalDeUnaCompra() {
        assertEquals(compra.getValorTotal(),BigDecimal.valueOf(100.0));
    }
}
