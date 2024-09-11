% …jugador(Nombre, Rating, Civilizacion).
jugador(juli, 2200, jemeres).
jugador(aleP, 1600, mongoles).
jugador(feli, 500000, persas).
jugador(aleC, 1723, otomanos).
jugador(ger, 1729, ramanujanos).
jugador(juan, 1515, britones).
jugador(marti, 1342, argentinos).

% …tiene(Nombre, QueTiene).
tiene(aleP, unidad(samurai, 199)).
tiene(aleP, unidad(espadachin, 10)).
tiene(aleP, unidad(granjero, 10)).
tiene(aleP, recurso(800, 300, 100)).
tiene(aleP, edificio(casa, 40)).
tiene(aleP, edificio(castillo, 1)).
tiene(juan, unidad(carreta, 10)).

% militar(Tipo, costo(Madera, Alimento, Oro), Categoria).
militar(espadachin, costo(0, 60, 20), infanteria).
militar(arquero, costo(25, 0, 45), arqueria).
militar(mangudai, costo(55, 0, 65), caballeria).
militar(samurai, costo(0, 60, 30), unica).
militar(keshik, costo(0, 80, 50), unica).
militar(tarcanos, costo(0, 60, 60), unica).
militar(alabardero, costo(25, 35, 0), piquero).

% aldeano(Tipo, produce(Madera, Alimento, Oro)).
aldeano(lenador, produce(23, 0, 0)).
aldeano(granjero, produce(0, 32, 0)).
aldeano(minero, produce(0, 0, 23)).
aldeano(cazador, produce(0, 25, 0)).
aldeano(pescador, produce(0, 23, 0)).
aldeano(alquimista, produce(0, 0, 25)).

% edificio(Edificio, costo(Madera, Alimento, Oro)).
edificio(casa, costo(30, 0, 0)).
edificio(granja, costo(0, 60, 0)).
edificio(herreria, costo(175, 0, 0)).
edificio(castillo, costo(650, 0, 300)).
edificio(maravillaMartinez, costo(10000, 10000, 10000)).


%1) Definir el predicado esUnAfano/2, que nos dice si al jugar el primero contra el segundo, la diferencia de
%rating entre el primero y el segundo es mayor a 500.

    %%%%%%%% Punto 1 %%%%%%%%%
esUnAfano(Nombre1, Nombre2):-
    jugador(Nombre1, Rating1, _),
    jugador(Nombre2, Rating2, _),
    abs(Rating1 - Rating2) > 500.

    %%%%%%%% Punto 2 %%%%%%%%%
esEfectivo(Tipo1, Tipo2):-
    militar(Tipo1, _, Categoria1),
    militar(Tipo2, _, Categoria2),
    puedeGanarle(Categoria1, Categoria2).

puedeGanarle(caballeria, arqueria).
puedeGanarle(arqueria, infanteria).
puedeGanarle(infanteria, piquero).
puedeGanarle(piquero, caballeria).

    %%%%%%%% Punto 3 %%%%%%%%%
alarico(Jugador):-
    tiene(Jugador,_),
    buscadorDeUnidadesMilitares(Jugador, infanteria).

    %%%%%%%% Punto 4 %%%%%%%%%
leonidas(Jugador):-
    tiene(Jugador,_),
    buscadorDeUnidadesMilitares(Jugador, piquero).

buscadorDeUnidadesMilitares(Jugador, UnidadABuscar):-
    forall((tiene(Jugador, unidad(Unidad,_))),(militar(Unidad, _, Categoria), Categoria = UnidadABuscar)).

    %%%%%%%% Punto 5 %%%%%%%%%
nomada(Jugador):-
    tiene(Jugador, _),
    not(tieneCasa(Jugador)).

tieneCasa(Jugador):-
    tiene(Jugador, edificio(_,_)).

    %%%%%%%% Punto 6 %%%%%%%%%
generadorDeUnidades(Unidad):-
    tiene(_, unidad(Unidad,_)).

generadorDeUnidades(Unidad):-
    tiene(_, edificio(Unidad,_)).

cuantoCuesta(Unidad, Costo):-
    generadorDeUnidades(Unidad),
    cuantoCuestaCadaUnidad(Unidad, Costo).

cuantoCuestaCadaUnidad(Unidad, Costo):-
    militar(Unidad, Costo, _).

cuantoCuestaCadaUnidad(Unidad, Costo):-
    edificio(Unidad, Costo).

cuantoCuestaCadaUnidad(Unidad, costo(0, 50, 0)):-
    aldeano(Unidad,_).

cuantoCuestaCadaUnidad(carreta, costo(100, 0, 50)).
cuantoCuestaCadaUnidad(urna, costo(100, 0, 50)).

    %%%%%%%% Punto 7 %%%%%%%%%
produccion(Unidad, Produccion):-
    tiene(_, unidad(Unidad,_)),
    cuandoProduceCadaUnidad(Unidad, Produccion).

cuandoProduceCadaUnidad(Unidad, Produccion):-
    aldeano(Unidad, Produccion).

cuandoProduceCadaUnidad(carreta, produccion(0,0,32)).
cuandoProduceCadaUnidad(urna, produccion(0,0,32)).
cuandoProduceCadaUnidad(keshik, produccion(0,0,10)).


    %%%%%%%% Punto 8 %%%%%%%%%
% produccionTotal()
% 8) Definir el predicado produccionTotal/3 que relaciona a un jugador con su producción total por minuto de
% cierto recurso, que se calcula como la suma de la producción total de todas sus unidades de ese recurso.
% 9) Definir el predicado estaPeleado/2 que se cumple para dos jugadores cuando no es un afano para
% ninguno, tienen la misma cantidad de unidades y la diferencia de valor entre su producción total de
% recursos por minuto es menor a 100 . ¡Pero cuidado! No todos los recursos valen lo mismo: el oro vale 1
% cinco veces su cantidad; la madera, tres veces; y los alimentos, dos veces.
% 10) Definir el predicado avanzaA/2 que relaciona un jugador y una edad si este puede avanzar a ella:
% a) Siempre se puede avanzar a la edad media.
% b) Puede avanzar a edad feudal si tiene al menos 500 unidades de alimento y una casa.
% c) Puede avanzar a edad de los castillos si tiene al menos 800 unidades de alimento y 200 de oro.
% También es necesaria una herrería, un establo o una galería de tiro.
% d) Puede avanzar a edad imperial con 1000 unidades de alimento, 800 de oro, un castillo y una
% universidad.

