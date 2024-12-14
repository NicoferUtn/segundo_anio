%Jugador(Nombre, Items, Hambre)
jugador(stuart, [piedra, piedra, piedra, piedra, piedra, piedra, piedra, piedra], 3).
jugador(tim, [madera, madera, madera, madera, madera, pan, carbon, carbon, carbon, pollo, pollo], 8).
jugador(steve, [madera, carbon, carbon, diamante, panceta, panceta, panceta], 2).

%lugar(Lugar, Quienes, nivelDeOscuridad).
lugar(playa, [stuart, tim], 2).
lugar(mina, [steve], 8).
lugar(bosque, [], 6).

%Comestible(comida).
comestible(pan).
comestible(panceta).
comestible(pollo).
comestible(pescado).

%% Parte 1

%% Punto A
tieneItem(Jugador, Item):-
    jugador(Jugador, Items, _),
    member(Item, Items).
    
%% Punto B
seProcupaPorSuSalud(Jugador):-
    jugador(Jugador,Items, _),
    member(Item, Items),
    comestible(Item).

%% Punto C
cantidaDelItem(Jugador, Item, Cantidad):-
    tieneItem(_, Item), % Genero los items 1que tiene los jugadores
    jugador(Jugador, Items, _),
    findall(Item, (jugador(Jugador, Items, _), member(Item, Items)), ListaItemas),
    length(ListaItemas, Cantidad).

%% Punto D
tieneMasDe(Jugador, Item):-
    cantidaDelItem(Jugador, Item, CantidadMaxima),
    forall((cantidaDelItem(OtroJugador, Item, Cantida), OtroJugador \= Jugador), CantidadMaxima > Cantida).
    
%% Parte 2

%% Punto A
hayMonstruos(Lugar):-
    lugar(Lugar, _ , NivelDeOscuridad),
    NivelDeOscuridad > 6.

%% Punto B
estaHambriento(Jugador):-
    jugador(Jugador, _, Hambre),
    Hambre < 4.

correPeligro(Jugador):- %% Tiene hambre
    estaHambriento(Jugador).

correPeligro(Jugador):- %% Esta en lugar con monstruos
    jugador(Jugador, _, _),
    hayMonstruos(Lugar),
        lugar(Lugar, JugadoresEnLugar, _),
    member(Jugador, JugadoresEnLugar).

%% Punto C
nivelDePeligrosidad(Lugar, Peligrosidad):-
    lugar(Lugar, Jugadores, _),
    not(hayMonstruos(Lugar)),
    findall(_,(member(Jugador,Jugadores), estaHambriento(Jugador)), JugadoresHambrientos),
    length(JugadoresHambrientos, Sum),
    length(Jugadores, Int),
    Peligrosidad is Sum / Int * 100.

nivelDePeligrosidad(Lugar, 100):-
    hayMonstruos(Lugar).

nivelDePeligrosidad(Lugar, 100):-
    lugar(Lugar, Jugadores, _),
    length(Jugadores, 0).
    

%% Punto 3
item(horno, [itemSimple(piedra, 8) ]).
item(placaDeMadera, [ itemSimple(madera, 1) ]).
item(palo, [ itemCompuesto(placaDeMadera, 1) ]).
item(antorcha, [ itemCompuesto(palo, 1), itemSimple(carbon, 1) ]).

puedeConstruir(Jugador, ItemACraftear):-
    jugador(Jugador, Items, _),
    item(ItemACraftear, _),
    forall((item(ItemACraftear, ItemNecesarios), member(ItemNecesarios,IemParaCarfeo)), elJugadortieneEl(ItemACraftear, Jugador)).


elJugadortieneEl(itemSimple(Item, Cantidad), Jugador):-
    jugador(Jugador,_,_),
    cantidaDelItem(Jugador, Item, Cantidad).


%% Punto 4
%% Punto A
%Teorico == PAJA
    