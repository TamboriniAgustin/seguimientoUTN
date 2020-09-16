package Partido;

import Color.Color;
import Jugador.Jugador;
import Paleta.Paleta;

import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;

@Entity
public class Partidos_Jugador {
    @EmbeddedId
    @ManyToOne
    Partido partido;

    @EmbeddedId
    @ManyToOne
    Jugador jugador;

    @ManyToOne
    Paleta paletaUtilizada = jugador.getPaleta();

    @ManyToOne
    Color colorPaleta = paletaUtilizada.getColor();
}
