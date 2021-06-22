package Paleta;

import Color.Color;

import javax.persistence.*;

@Entity
public class Paleta {
    @Id
    @GeneratedValue
    @Column(name = "paleta_codigo")
    int codigo;

    @Column(name = "paleta_nombre")
    String nombre;

    @Column(name = "paleta_grosor")
    double grosor;

    @ManyToOne
    Color color;

    @ManyToOne
    Constructor constructor;

    public Color getColor() {
        return color;
    }
}
