herramientasRequeridas(ordenarCuarto, [aspiradora(100), trapeador, plumero]).
herramientasRequeridas(limpiarTecho, [escoba, pala]).
herramientasRequeridas(cortarPasto, [bordedadora]).
herramientasRequeridas(limpiarBanio, [sopapa, trapeador]).
herramientasRequeridas(encerarPisos, [lustradpesora, cera, aspiradora(300)]).

% Ejercicio 1 - Base de Conocimientos %
trabajador(egon).
trabajador(peter).
trabajador(winston).
trabajador(ray).

tieneHerramienta(egon, aspiradora(200)).
tieneHerramienta(egon, trapeador).
tieneHerramienta(peter, trapeador).
tieneHerramienta(winston, varitaDeNeutrones).

% Ejercicio 2 %
sastifaceNecesidad(Trabajador, Herramienta):-tieneHerramienta(Trabajador, Herramienta),
                                          Herramienta \= aspiradora(_).
sastifaceNecesidad(Trabajador, aspiradora(PotenciaRequerida)):-tieneHerramienta(Trabajador, aspiradora(Potencia)),
                                                            Potencia >= PotenciaRequerida.


% Ejercicio 3 %
puedeRealizarTarea(Trabajador, Tarea):-tieneHerramienta(Trabajador, varitaDeNeutrones),
                                    herramientasRequeridas(Tarea, _).
puedeRealizarTarea(Trabajador, Tarea):-persona(Trabajador),
                                    herramientasRequeridas(Tarea, _),
                                    forall(herramientaRequerida(Tarea, Herramienta), sastifaceNecesidad(Trabajador, Herramienta)).

herramientaRequerida(Tarea, Herramienta):-herramientasRequeridas(Tarea, ListaHerramientas),
                                          member(Herramienta, ListaHerramientas).


% Ejercicio 4 %
%tareaPedida(tarea, cliente, metrosCuadrados).
tareaPedida(ordenarCuarto, dana, 20).
tareaPedida(cortarPasto, walter, 50).
tareaPedida(limpiarTecho, walter, 70).
tareaPedida(limpiarBanio, louis, 15).

%precio(tarea, precioPorMetroCuadrado).
precio(ordenarCuarto, 13).
precio(limpiarTecho, 20).
precio(limpiarBanio, 55).
precio(cortarPasto, 10).
precio(encerarPisos, 7).

costoTotal(Cliente, Costo):-tareaPedida(_, Cliente, _),
                            findall(Precio, costoTarea(Cliente, _, Precio), ListaPrecios),
                            sumlist(ListaPrecios, Costo).

costoTarea(Cliente, Tarea, Precio):-tareaPedida(Tarea, Cliente, M2),
                             precio(Tarea, PrecioM2),
                             Precio is M2 * PrecioM2.


% Ejercicio 5 %
aceptaPedido(Trabajador, Cliente):-trabajador(Trabajador),
                                   tareaPedida(_, Cliente, _),
                                   forall(tareaPedida(Tarea, Cliente, _), puedeRealizarTarea(Trabajador, Tarea)),
                                   dispuestoAAceptarPedido(Trabajador, Cliente).

dispuestoAAceptarPedido(ray, Cliente):-not(tareaPedida(limpiarTecho, _, _)).
dispuestoAAceptarPedido(winston, Cliente):-costoTotal(Cliente, Costo),
                                           Costo >= 500.
dispuestoAAceptarPedido(egon, Cliente):-tareaPedida(Tarea, Cliente, _),
                                        not(tareaCompleja(Tarea)).
dispuestoAAceptarPedido(peter, _).

tareaCompleja(limpiarTecho).
tareaCompleja(Tarea):-herramientasRequeridas(Tarea, ListaHerramientas),
                      length(ListaHerramientas, HerramientasNecesarias),
                      HerramientasNecesarias > 2.


% Ejercicio 6 %
% A
herramientasRequeridas(ordenarCuarto, [[aspiradora(100), escoba], trapeador, plumero]).
% B
sastifaceNecesidad(Trabajador, ListaReemplazables):-member(Herramienta, ListaReemplazables),
                                                    sastifaceNecesidad(Trabajador, Herramienta).
% C
/*
    Modificamos el elemento herramientasRequeridas y podemos resolverlo de 2 formas. Simplemente añadiendo la
    misma tarea como otra opcion con la herramienta alternativa (necesitando que en el predicado "puedeRealizarTarea"
    se haga referencia a cada tarea antes del forall) o una solucion más óptima... dentro de la lista, encerrar en
    otra lista a aquellos elementos que sean reemplazables y lo único que habria que modificar es el predicado
    "sastifaceNecesidad" y formar el caso recursivo para cuando el elemento que se toma sea una lista.
*/