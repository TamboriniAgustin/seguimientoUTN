package Color;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
public class Color {
    @Id
    String codigo;

    @Column
    String descripcion;
}
