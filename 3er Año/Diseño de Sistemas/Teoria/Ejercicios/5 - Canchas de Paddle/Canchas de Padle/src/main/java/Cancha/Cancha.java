package Cancha;

import Color.Color;

import javax.persistence.*;

@Entity
public class Cancha {
    @Id
    @GeneratedValue
    @Column(name = "cancha_id")
    int id;

    @Column(name = "cancha_nombre")
    String nombre;

    @ManyToOne
    Color color;

    @Column(name = "cancha_esta_iluminada")
    boolean tieneIluminacion;

    @Column(name = "cancha_telefono")
    String telefono;

    public Color getColor() {
        return color;
    }
}
