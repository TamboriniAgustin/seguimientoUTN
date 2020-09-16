package Paleta;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

@Entity
public class Constructor {
    @Id
    @GeneratedValue
    @Column(name = "constructor_codigo")
    int codigo;

    @Column(name = "constructor_nombre")
    String nombre;

    @Column(name = "constructor_domicilio")
    String domicilio;
}
