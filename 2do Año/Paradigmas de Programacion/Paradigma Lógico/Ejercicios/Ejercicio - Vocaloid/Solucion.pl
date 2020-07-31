% A) Determinar la base de conocimiento
cantante(megurineLuka, nightFever, 4).
cantante(megurineLuka, foreverYoung, 5).
cantante(hatsuneMiku, tellYourWorld, 4).
cantante(gumi, foreverYoung, 4).
cantante(gumi, tellYourWorld, 5).
cantante(seeU, novemberRain, 6).
cantante(seeU, nightFever, 5).

% 1. Cantante Novedoso
esNovedoso(Cantante):-cantante(Cantante, _, _),
                      sabeAlMenos2Canciones(Cantante),
                      tiempoCantando(Cantante, Tiempo),
                      Tiempo < 15.

sabeAlMenos2Canciones(Cantante):-cantante(Cantante, Cancion1, _),
                                 cantante(Cantante, Cancion2, _),
                                 Cancion1 \= Cancion2.

tiempoCantando(Cantante, TiempoTotal):-cantante(Cantante, _, _),
                                       findall(TiempoCancion, tiempoDeCancion(Cantante, TiempoCancion), Tiempos),
                                       sumlist(Tiempos, TiempoTotal).
                                       
tiempoDeCancion(Cantante, Tiempo):-cantante(Cantante, _, TiempoCancion),
                                   Tiempo is TiempoCancion.


% 2. Cantante Acelerado
esAcelerado(Cantante):-cantante(Cantante, _, _),
                       not((tiempoDeCancion(Cantante, TiempoCancion), TiempoCancion > 4)).


% 1) Determinar los conciertos pertenecientes a la base de conocimiento
concierto(mikuExpo, eeuu, 2000, gigante(2, 6)).
concierto(magicalMirai, japon, 3000, gigante(3, 10)).
concierto(vocalektVisions, eeuu, 1000, mediano(9)).
concierto(mikuFest, argentina, 100, pequenio(1)).

% 2) Vocaloid puede participar del Concierto
puedeParticiparEnConcierto(hatsuneMiku, Concierto):-concierto(Concierto, _, _, _).

puedeParticiparEnConcierto(Cantante, Concierto):-cantante(Cantante, _, _),
                                                 concierto(Concierto, _, _, Requisitos),
                                                 cumpleRequisitos(Cantante, Requisitos).

cumpleRequisitos(Cantante, gigante(CantidadCanciones, TiempoMinimo)):-cantidadCanciones(Cantante, Cantidad),
                                                                      Cantidad >= CantidadCanciones,
                                                                      tiempoCantando(Cantante, TiempoTotal),
                                                                      TiempoTotal >= TiempoMinimo.
                                                                
cumpleRequisitos(Cantante, mediano(DuracionMaxima)):-tiempoCantando(Cantante, Tiempo),
                                                     Tiempo < DuracionMaxima.

cumpleRequisitos(Cantante, pequenio(DuracionMinima)):-cantante(Cantante, _, Duracion),
                                                      Duracion > DuracionMinima.

cantidadCanciones(Cantante, CancionesTotales):-findall(Cancion, cantante(Cantante, Cancion, _), Canciones),
                                               length(Canciones, CancionesTotales).


% 3) Vocaloid más famoso
cantanteMasFamoso(Cantante):-cantante(Cantante, _, _),
                             nivelDeFama(Cantante, FamaCantante),
                             forall(nivelDeFama(_, FamaOtros), FamaCantante >= FamaOtros).

nivelDeFama(Cantante, Fama):-famaDeConciertos(Cantante, FamaConcierto),
                             cantidadCanciones(Cantante, CantidadCanciones),
                             Fama is FamaConcierto * CantidadCanciones.

famaDeConciertos(Cantante, Fama):-cantante(Cantante, _, _),
                                  findall(Fama, (puedeParticiparEnConcierto(Cantante, Concierto), concierto(Concierto, _, Fama, _)), FamasConciertos),
                                  sumlist(FamasConciertos, Fama).


% 4) Conocidos en Concierto
conoce(megurineLuka, hatsuneMiku).
conoce(megurineLuka, gumi).
conoce(gumi, seeU).
conoce(seeU, kaito).

esElUnicoDeSusConocidosEnConcierto(Cantante, Concierto):-puedeParticiparEnConcierto(Cantante, Concierto),
                                                         not((esConocido(Cantante, OtroCantante), puedeParticiparEnConcierto(OtroCantante, Concierto))).

esConocido(Cantante, OtroCantante):-conoce(Cantante, OtroCantante).
esConocido(Cantante, OtroCantante):-conoce(Cantante, UnCantante),
                                    esConocido(UnCantante, OtroCantante).

/* 
    5) No habria que realizar ningun cambio a menos que el nuevo concierto sea de un tipo distinto a grande, mediano
       o chico. En ese caso deberiamos agregar la opción para el nuevo tipo de concierto en "cumpleRequisitos". El
       concepto que facilita esto es el metodo de "Pattern Matching" que nos permite tratar por diferente a cada
       functor que representa un tipo de concierto. 
*/