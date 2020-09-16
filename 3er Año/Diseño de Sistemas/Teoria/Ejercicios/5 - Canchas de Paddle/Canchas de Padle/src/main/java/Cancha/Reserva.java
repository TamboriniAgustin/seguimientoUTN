package Cancha;

import Jugador.Jugador;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import java.util.Date;

@Entity
public class Reserva {
    @Id
    @ManyToOne
    Cancha cancha;

    @ManyToOne
    Jugador jugador;

    @Column(name = "reserva_fecha_inicio")
    Date fechaInicio;

    @Column(name = "reserva_fecha_fin")
    Date fechaFin;
}