% TP Lógico
% Desarrollado por ...

% *********************************************************************
% PREDICADOS
% *********************************************************************

% Ejercicio 1
partido(rojo).
partido(azul).
partido(amarillo).

provincia(buenosAires).
provincia(chaco).
provincia(tierraDelFuego).
provincia(sanLuis).
provincia(neuquen).
provincia(santaFe).
provincia(cordoba).
provincia(chubut).
provincia(formosa).
provincia(tucuman).
provincia(salta).
provincia(santaCruz).
provincia(laPampa).
provincia(corrientes).
provincia(misiones).

edad(frank, 50).
edad(claire, 52).
edad(garrett, 64).
edad(peter, 26).
edad(jackie, 38).
edad(linda, 30).
edad(catherine, 59).
edad(heather, 50).

candidato(frank, rojo).
candidato(claire, rojo).
candidato(garrett, azul).
candidato(jackie, amarillo).
candidato(linda, azul).
candidato(catherine, rojo).
candidato(seth, amarillo).
candidato(heather, amarillo).

postulaEn(azul, [buenosAires, chaco, tierraDelFuego, sanLuis, neuquen]).
postulaEn(rojo, [buenosAires, santaFe, cordoba, chubut, tierraDelFuego, sanLuis]).
postulaEn(amarillo, [chaco, formosa, tucuman, salta, santaCruz, laPampa, corrientes, misiones, buenosAires]).

habitantes(buenosAires, 15355000).
habitantes(chaco, 1143201).
habitantes(tierraDelFuego, 160720).
habitantes(sanLuis, 489255).
habitantes(neuquen, 637913).
habitantes(santaFe, 3397532).
habitantes(cordoba, 3567654).
habitantes(chubut, 577466).
habitantes(formosa, 527895).
habitantes(tucuman, 1687305).
habitantes(salta, 1333365).
habitantes(santaCruz, 273964).
habitantes(laPampa, 349299).
habitantes(corrientes, 992595).
habitantes(misiones, 1189446).

/*
Aparece el principio de universo cerrado en el caso del partido violeta y en el caso de
Peter. Esto se debe a que todo lo que no sea información para la base de conocimientos
es falso, y solo las cosas que conozco son
verdaderas. Por ejemplo: en el caso de Peter puedo afirmar que es verdadero que tiene 26
años pero no es necesario declarar que no pertenece al partido amarillo, ya que al no
saber a cual pertenece, se considera que no pertenecerá a ninguno. Lo mismo pasa con el
partido violeta, no es necesario declararlo si no tiene ningun candidato que lo represente.
*/

% Ejercicio 2
esPicante(Provincia):-provincia(Provincia),
                      vienenMasDeDosPartidos(Provincia),
                      habitantes(Provincia, Habitantes), 
                      Habitantes > 1000000.

sePostulaEnProvincia(Partido, Provincia):-postulaEn(Partido, Provincias), member(Provincia, Provincias).
vienenMasDeDosPartidos(Provincia):-findall(Partido, sePostulaEnProvincia(Partido, Provincia), Partidos),
                                   length(Partidos, Cantidad),
                                   Cantidad >= 2.

% Ejercicio 3
intencionDeVotoEn(buenosAires, rojo, 20).
intencionDeVotoEn(buenosAires, azul, 40).
intencionDeVotoEn(buenosAires, amarillo, 40).
intencionDeVotoEn(chaco, rojo, 50).
intencionDeVotoEn(chaco, azul, 20).
intencionDeVotoEn(chaco, amarillo, 0).
intencionDeVotoEn(tierraDelFuego, rojo, 40).
intencionDeVotoEn(tierraDelFuego, azul, 20).
intencionDeVotoEn(tierraDelFuego, amarillo, 10).
intencionDeVotoEn(sanLuis, rojo, 50).
intencionDeVotoEn(sanLuis, azul, 20).
intencionDeVotoEn(sanLuis, amarillo, 0).
intencionDeVotoEn(neuquen, rojo, 80).
intencionDeVotoEn(neuquen, azul, 10).
intencionDeVotoEn(neuquen, amarillo, 0).
intencionDeVotoEn(santaFe, rojo, 20).
intencionDeVotoEn(santaFe, azul, 41).
intencionDeVotoEn(santaFe, amarillo, 39).
intencionDeVotoEn(cordoba, rojo, 10).
intencionDeVotoEn(cordoba, azul, 60).
intencionDeVotoEn(cordoba, amarillo, 20).
intencionDeVotoEn(chubut, rojo, 15).
intencionDeVotoEn(chubut, azul, 15).
intencionDeVotoEn(chubut, amarillo, 15).
intencionDeVotoEn(formosa, rojo, 0).
intencionDeVotoEn(formosa, azul, 0).
intencionDeVotoEn(formosa, amarillo, 0).
intencionDeVotoEn(tucuman, rojo, 40).
intencionDeVotoEn(tucuman, azul, 40).
intencionDeVotoEn(tucuman, amarillo, 20).
intencionDeVotoEn(salta, rojo, 30).
intencionDeVotoEn(salta, azul, 60).
intencionDeVotoEn(salta, amarillo, 10).
intencionDeVotoEn(santaCruz, rojo, 10).
intencionDeVotoEn(santaCruz, azul, 20).
intencionDeVotoEn(santaCruz, amarillo, 30).
intencionDeVotoEn(laPampa, rojo, 25).
intencionDeVotoEn(laPampa, azul, 25).
intencionDeVotoEn(laPampa, amarillo, 40).
intencionDeVotoEn(corrientes, rojo, 30).
intencionDeVotoEn(corrientes, azul, 30).
intencionDeVotoEn(corrientes, amarillo, 10).
intencionDeVotoEn(misiones, rojo, 90).
intencionDeVotoEn(misiones, azul, 0).
intencionDeVotoEn(misiones, amarillo, 0).

%***** Caso para cuando el primer candidato pertenece y el segundo no *****%
leGanaA(Candidato1, Candidato2, Provincia):-candidato(Candidato1, Partido1),
                                            sePostulaEnProvincia(Partido1, Provincia),
                                            candidato(Candidato2, Partido2),
                                            not(sePostulaEnProvincia(Partido2, Provincia)).

%***** Caso para cuando ambos pertenecen pero no son del mismo partido *****%
leGanaA(Candidato1, Candidato2, Provincia):-candidato(Candidato1, Partido1),
                                            candidato(Candidato2, Partido2),
                                            sePostulaEnProvincia(Partido1, Provincia),
                                            sePostulaEnProvincia(Partido2, Provincia),
                                            Partido1 \= Partido2,
                                            intencionDeVotoEn(Provincia, Partido1, Cantidad1),
                                            intencionDeVotoEn(Provincia, Partido2, Cantidad2),
                                            Cantidad1 > Cantidad2.

%***** Caso para cuando ambos pertenecen y son del mismo partido *****%
leGanaA(Candidato1, Candidato2, Provincia):-candidato(Candidato1, Partido1),
                                            candidato(Candidato2, Partido2),
                                            sePostulaEnProvincia(Partido1, Provincia),
                                            sePostulaEnProvincia(Partido2, Provincia),
                                            Partido1 == Partido2,
                                            sePostulaEnProvincia(Partido1, Provincia).

% Ejercicio 4
esHegemonico(Partido):-esFavorito(Partido, buenosAires),
                       esFavorito(Partido, cordoba),
                       esFavorito(Partido, santaFe).

esFavorito(Partido, Provincia):-partido(Partido),
                                forall(esOtroPartido(Partido, OtroPartido), menorIntencionDeVoto(Provincia, OtroPartido, Partido)).

esOtroPartido(Partido, OtroPartido):-partido(Partido),
                                     partido(OtroPartido),
                                     Partido\=OtroPartido.

menorIntencionDeVoto(Provincia, Partido1, Partido2):-intencionDeVotoEn(Provincia, Partido1, Votos1),
                                                     intencionDeVotoEn(Provincia, Partido2, Votos2),
                                                     Votos1 =< Votos2.

% Ejercicio 5
promete(garrett, construir([escuela, hospital, universidad, ruta])).
promete(garrett, metaDeInflacion(18)).
promete(garrett, construir([casas, autopistas])).
promete(seth, metaDeInflacion(10)).
promete(claire, nuevosPuestosDeTrabajo(200000)).
promete(claire, nuevosPuestosDeTrabajo(520000)).
promete(claire, nuevosPuestosDeTrabajo(1000000)).
promete(claire, metaDeInflacion(4)).
promete(claire, metaDeInflacion(14)).
promete(frank, metaDeInflacion(3)).
promete(frank, metaDeInflacion(13)).
promete(frank, nuevosPuestosDeTrabajo(10000)).
promete(frank, construir([hospital, universidad])).
promete(frank, construir([plazas, autopistas, extensionSubte, repavimentacionTotal])).

esRealizable(metaDeInflacion(Meta), _):-Meta > 10.
esRealizable(construir(Cosas), _):-length(Cosas, Cantidad),
                                   Cantidad < 3,
                                   not(member(universidad, Cosas)).
esRealizable(nuevosPuestosDeTrabajo(Puestos), Candidato):-edad(Candidato, Edad),
                                                          Tope is Edad * 10000,
                                                          Puestos =< Tope.

esSerio(Candidato):-candidato(Candidato, _),
                    findall(Promesa, (promete(Candidato, Promesa), esRealizable(Promesa, Candidato)), Promesas),
                    length(Promesas, PromesasRealizables),
                    PromesasRealizables >= 3.

% Ejercicio 6
amigo(frank, claire).
amigo(claire, catherine).
amigo(catherine, jackie).
amigo(jackie, garrett).
amigo(jackie, heather).
amigo(seth, heather).

esPanquequeable(Candidato):-amigo(Candidato, Candidato2),
                            candidato(Candidato, Partido),
                            candidato(Candidato2, Partido2),
                            Partido \= Partido2.
esPanquequeable(Candidato):-amigo(Candidato, Candidato2),
                            candidato(Candidato, Partido),
                            candidato(Candidato, Partido2),
                            Partido = Partido2,
                            esPanquequeable(Candidato2).                  
                                           

% *********************************************************************
% TESTS
% *********************************************************************

% Ejercicio 2
:- begin_tests(ejercicio2).
        test(provincia_picante, nondet):-
        esPicante(buenosAires).

        test(provincia_no_picante, fail):-
        esPicante(santaFe).
:- end_tests(ejercicio2).

% Ejercicio 3
:- begin_tests(ejercicio3).
        test(gana_x_superar_a_otro_partido_en_provincia, nondet):-
        leGanaA(frank, garrett, tierraDelFuego).

        test(gana_x_unico_partido_en_provincia, nondet):-
        leGanaA(frank, jackie, santaFe).

        test(pierde_x_no_presentarse_en_Provincia, fail):-
        leGanaA(claire, jackie, misiones).

        test(gana_x_mismo_partido_en_provincia, nondet):-
        leGanaA(frank, claire, tierraDelFuego).

        test(pierde_x_empate_en_votos, fail):-
        leGanaA(heather, linda, buenosAires).
:- end_tests(ejercicio3).

% Ejercicio 4
:- begin_tests(ejercicio4).
        test(partidos_hegemonicos, nondet):-
        esHegemonico(azul).

        test(partidos_no_hegemonicos, fail):-
        esHegemonico(rojo), esHegemonico(amarillo).
:- end_tests(ejercicio4).

/*
Aparecen 2 clases de equivalencia distintas: una de ellas con aquellos partidos que son
hegemonicos y la otra con los que no lo son. Aparece el concepto de negación o 'not' para
representar a aquellos que no son hegemonicos (vamos a decir que son hegemonicos y luego
cambiar su valor de verdad a través del uso del 'not' o a través de la opción de testeo
'fail' que cumple la misma función).
*/

% Ejercicio 5
:- begin_tests(ejercicio5).
        test(candidato_no_serio, nondet):-
        not(esSerio(garret)), not(esSerio(seth)), not(esSerio(frank)).

        test(candidato_serio, nondet):-
        esSerio(claire).
:- end_tests(ejercicio5).

%Ejercicio 6
:- begin_tests(ejercicio6).
        test(candidato_panquequeable_distinto_partido, set(Quienes = [catherine, jackie, frank, claire])):-
        esPanquequeable(Quienes).

        test(candidato_panquequeable_mismo_partido, nondet):-
        esPanquequeable(frank), esPanquequeable(claire).

        test(candidato_no_panquequeable, fail):-
        esPanquequeable(seth), esPanquequeable(garret), esPanquequeable(linda), esPanquequeable(heather).
:- end_tests(ejercicio6).