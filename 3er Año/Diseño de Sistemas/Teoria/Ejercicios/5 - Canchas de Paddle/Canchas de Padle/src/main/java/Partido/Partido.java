package Partido;

import Cancha.Cancha;
import Color.Color;
import Jugador.Jugador;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

@Entity
public class Partido {
    @Id
    @GeneratedValue
    int codigo;

    @ManyToOne
    Cancha cancha;

    @ManyToOne
    Color color = cancha.getColor();

    @Column(name = "partido_fecha_inicio")
    Date fechaInicio;

    @Column(name = "partido_fecha_fin")
    Date fechaFin;
}