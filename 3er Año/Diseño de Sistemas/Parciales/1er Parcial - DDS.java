/*
    1_ Poder crear salas de cada tipo (especificando su límite de participantes y su anfitrión) y 
    criterio de asignación (si corresponde), iniciarlas y finalizarlas.
*/

Sala conferencia = new Conferencia(anfitrion, limiteParcitipantes);
Sala aulaUnica = new AulaUnica(anfitrion, limiteParcitipantes);
Sala aulaPartida = new AulaPartida(anfitrion, limiteParcitipantes);
aulaPartida.agregarAula(conferencia);
aulaPartida.agregarParticipante(juan);
aulaPartida.agregarParticipante(agustin);
aulaPartida.sacarParticipante(juan);
aulaPartida.agregarAula(aulaUnica);
aulaPartida.setearCriterioAsignacion(criterio);
conferencia.iniciar();
conferencia.finalizar();

//Salas
abstract class Sala{
    Usuario anfitrion;
    int limiteParcitipantes;
    List<Usuario> participantes; //Podría convenir diseñarla como conjunto para evitar la validación de no agregar a un usuario dos veces
    Datetime fechaInicio
    Datetima fechaFin
    Chat chat; //Se genera automáticamente en el constructor
    Conexion conexionVideo; //Se genera automáticamente en el constructor (para video y pantalla)
    Conexion conexionPantalla; //Se genera automáticamente en el constructor (para video y pantalla)

    void iniciar(){
        fechaInicio = getDate(NOW());
        habilitarConexiones();
        habilitarChat();
    }
    void finalizar(){
        //Realizo una validación para verificar que haya sido inicializada anteriormente, sino, lanzo una excepción
        fechaFin = getDate(NOW());
        finalizarChat();
    }

    void habilitarChat(){
        chat.incorporarSinModeracion(anfitrion);
    }
    void habilitarConexiones(){
        conexionPantalla.habilitarPantallaCompartida(anfitrion);
        conexionVideo.habilitarVideo(anfitrion);
    }
    void finalizarChat(){
        chat.finalizar();
    }
    void finalizarConexiones(){
        conexionVideo.destruir();
        conexionPantalla.destruir();
    }

    
}

class Conferencia extends Sala{
    @override 
    void habilitarChat(){
        this.super()
        participantes.foreach(participante -> chat.incorporarConModeracion(participante));
    }
}

class AulaUnica extends Sala{
    @override 
    void habilitarChat(){
        this.super()
        participantes.foreach(participante -> chat.incorporarSinModeracion(participante));
    }
    @override habilitarConexiones(){
        this.super()
        participantes.foreach(participante -> conexionPantalla.habilitarPantallaCompartida(participante));
        participantes.foreach(participante -> conexionVideo.habilitarVideo(participante));
    }
}

class AulaPartida extends Sala{
    CriterioConfiguracion criterio;
    List<AulaUnica> aulasDisponibles;
    
    void setearCriterioAsignacion(CriterioConfiguracion criterioDeConfiguracion){
        criterio = criterioDeConfiguracion;
    }
}

//Criterios
interface CriterioConfiguracion{
    void asignarSala(Usuario usuario, List<Sala> salas);
}
class AsignacionPorOrdenAlfabetico implements CriterioConfiguracion{

}
class DistribucionPrefijada implements CriterioConfiguracion{

}

//Usuarios
class Usuario{

}

/* 
    2_ Poder agregar participantes a una sala, asegurándose de que no supere el límite de participantes 
    establecido para la sala, con la configuración adecuada de video, pantalla y chat y que se distribuyan 
    según los criterios de asignación (si aplica).
*/

Usuario juan = new Usuario();
Usuario agustin = new Usuario();
conferencia.agregarParticipante(juan);
conferencia.agregarParticipante(agustin);
conferencia.sacarParticipante(juan);

//Salas
abstract class Sala{
    abstract void conectarAlChatA(Usuario usuario){}
    abstract void conectarVideoDe(Usuario usuario){}
    abstract void conectarPantallaDe(Usuario usuario){}

    void agregarParticipante(Usuario usuario){
        if(this.tieneCupo()){
            participantes.add(usuario);
            //Si la sala ya esta iniciada, voy a tener que conectar únicamente a este usuario
            if(this.yaInicio()){
                this.conectarAlChatA(usuario);
                this.conectarVideoDe(usuario);
                this.conectarPantallaDe(usuario);
            }
        }
        //Sino lanzo una excepción
    }
    void sacarParticipante(Usuario usuario){
        participantes.remove(usuario);
        //En este caso no los saco individualmente, por más que se vayan la conexión será destruida cuando se finalize la sala
    }

    boolean tieneCupo(){
        return limiteParcitipantes <= participante.size();
    }
    boolean yaInicio(){
        return fechaInicio.isNotNull();
    }
    boolean yaFinalizo(){
        return fechaFin.isNotNull();
    }
}

class Conferencia extends Sala{
    @override 
    void conectarAlChatA(Usuario usuario){
        chat.incorporarConModeracion(usuario);
    }
}
class AulaUnica extends Sala{
    @override 
    void conectarAlChatA(Usuario usuario){
        chat.incorporarSinModeracion(usuario);
    }
    @override 
    void conectarPantallaDe(Usuario usuario){
        conexionPantalla.habilitarPantallaCompartida(usuario);
    }
    @override conectarVideoDe(Usuario usuario){
        conexionVideo.habilitarVideo(usuario);
    }
}
class AulaPartida extends Sala{
    @override
    void agregarParticipante(Usuario usuario){
        //Se supone que no será necesario registrar al usuario en esta sala, ya que a través de esta ingresará a otra (por eso no va el this.super())
        criterio.asignarSala(usuario, aulasDisponibles);
    }
}

/* 
    3_ Poder calcular el costo incurrido hasta el momento actual de una sala, y el costo final de la misma 
    (en caso de estar finalizada).
*/

conferencia.calcularCosto();
conferencia.calcularCostoFinal();

//Salas
abstract class Sala{
    double costoPorMinuto;

    double calcularCostoActual(){
        Datetime fechaActual = getDate(NOW());
        return fechaActual.obtenerCantidadMinutosRespectoA(fechaInicio) * costoPorMinuto;
    }
    double calcularCostoFinal(){
        return fechaFin.obtenerCantidadMinutosRespectoA(fechaInicio) * costoPorMinuto;
    }
}

/* 
    4_ Programar salas para un determinado día y horario. ¡Cuidado! No todas las salas están calendarizadas, 
    y debe seguir siendo posible iniciarlas y finalizarlas manualmente; calendarizar y crear salas deben ser 
    operaciones independientes.
*/

//Salas
abstract class Sala{
    boolean estaCalanderizada;

    void setearFechaInicio(Datetime fecha){
        //Valido que sea superior en media hora al momento actual
        fechaInicio = fecha;
    }
    void setearFechaFin(Datetime fecha){
        //Valido que exista una fecha de inicio seteada anteriormente y sea superior a esta
        fechaFin = fecha;
    }
}

//Repositorio de Salas
class RepositorioSalas{
    List<Salas> salas;

    List<Salas> getSalas(){
        return salas;
    }
}

//Organizador de Salas
class OrganizadorSalas{
    RepositorioSalas repositorioDeSalas;

    void iniciarSalas(){
        repositorioDeSalas.getSalas().filter(sala -> sala.estaCalanderizada()).foreach(sala -> sala.iniciar());
    }
    void finalizarSalas(){
        repositorioDeSalas.getSalas().filter(sala -> sala.estaCalanderizada()).foreach(sala -> sala.finalizar());
    }
}