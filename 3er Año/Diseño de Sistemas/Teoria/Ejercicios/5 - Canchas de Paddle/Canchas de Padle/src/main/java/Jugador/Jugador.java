package Jugador;

import Paleta.Paleta;

import javax.persistence.*;
import java.util.Date;

@Entity
public class Jugador {
    @Id
    @GeneratedValue
    @Column(name = "jugador_id")
    int id;

    @Column(name = "jugador_nombre")
    String nombre;

    @Column(name = "jugador_apellido")
    String apellido;

    @Column(name = "jugador_domicilio")
    String domicilio;

    @Column(name = "jugador_fecha_de_nacimiento")
    Date fechaNacimiento;

    @OneToOne
    Paleta paleta;

    public Paleta getPaleta() {
        return paleta;
    }
}
