% receta(Plato, Duración, Ingredientes)
receta(empanadaDeCarneFrita, 20, [harina, carne, cebolla, picante, aceite]).
receta(empanadaDeCarneAlHorno, 20, [harina, carne, cebolla, picante]).
receta(lomoALaWellington, 125, [lomo, hojaldre, huevo, mostaza]).
receta(pastaTrufada, 40, [spaghetti, crema, trufa]).
receta(souffleDeQueso, 35, [harina, manteca, leche, queso]).
receta(tiramisu, 30, [vainillas, cafe, mascarpone]).
receta(rabas, 20, [calamar, harina, sal]).
receta(parrilladaDelMar, 40, [salmon, langostinos, mejillones]).
receta(sushi, 30, [arroz, salmon, sesamo, algaNori]).
receta(hamburguesa, 15, [carne, pan, cheddar, huevo, panceta, trufa]).
receta(padThai, 40, [fideos, langostinos, vegetales]).

% elabora(Chef, Plato)
elabora(guille, empanadaDeCarneFrita).
elabora(guille, empanadaDeCarneAlHorno).
elabora(vale, rabas).
elabora(vale, tiramisu).
elabora(vale, parrilladaDelMar).
elabora(ale, hamburguesa).
elabora(lu, sushi).
elabora(mar, padThai).

% cocinaEn(Restaurante, Chef)
cocinaEn(pinpun, guille).
cocinaEn(laPececita, vale).
cocinaEn(laParolacha, vale).
cocinaEn(sushiRock, lu).
cocinaEn(olakease, lu).
cocinaEn(guendis, ale).
cocinaEn(cantin, mar).

% tieneEstilo(Restaurante, Estilo)
tieneEstilo(pinpun, bodegon(parqueChas, 6000)).
tieneEstilo(laPececita, bodegon(palermo, 20000)).
tieneEstilo(laParolacha, italiano(15)).
tieneEstilo(sushiRock, oriental(japon)).
tieneEstilo(olakease, oriental(japon)).
tieneEstilo(cantin, oriental(tailandia)).
tieneEstilo(cajaTaco, mexicano([habanero, rocoto])).
tieneEstilo(guendis, comidaRapida(5)).


% italiano(CantidadDePastas)
% oriental(País)
% bodegon(Barrio, PrecioPromedio)
% mexicano(VariedadDeAjies)
% comidaRapida(cantidadDeCombos)

chef(Chef):-
    cocinaEn(_,Chef).

% Punto 1
plato(Plato):-
    elabora(_,Plato).

esCrack(Chef) :-
    chef(Chef),
    trabajaEn2restaurantes(Chef).

trabajaEn2restaurantes(Chef):-
    elabora(Chef, UnPlato),
    elabora(Chef, OtroPlato),
    UnPlato \= OtroPlato.

trabajaEn2restaurantes(Chef):-
    cocinaEn(Chef, padThai).

% Punto 2
esOtaku(Chef):-
    chef(Chef),
    forall(cocinaEn(Restaurante, Chef), tieneEstilo(Restaurante, oriental(japon))).

% Punto 3
esTop(Plato):-
    plato(Plato),
    forall(elabora(Chef, Plato), esCrack(Chef)).

% Punto 4
esDificil(PLato):-
    plato(Plato),
    duracionDeMasDe2HorasOUsaTrufaOEsSouffleDeQueso(Plato).

duracionDeMasDe2HorasOUsaTrufaOEsSouffleDeQueso(Plato):-
    receta(Plato, Tiempo,_),
    Tiempo >= 120.

duracionDeMasDe2HorasOUsaTrufaOEsSouffleDeQueso(Plato):-
    receta(Plato, _, Ingredientes),
    member(Ingredientes, trufa).

duracionDeMasDe2HorasOUsaTrufaOEsSouffleDeQueso(souffleDeQueso).

% Punto 5
seMereceLaMichelin(Restaurante):-
    esRestaurante(Restaurante),
    tieneUnChefCrack(Restaurante),
    tieneEstilo(Restaurante, Estilo),
    tieneEstiloMichelinero(Estilo).

esRestaurante(Restaurante):-
    tieneEstilo(Restaurante,_).

tieneUnChefCrack(Restaurante):-
    cocinaEn(Restaurante, Chef),
    esCrack(Chef).

tieneEstiloMichelinero(oriental(tailandia)).

tieneEstiloMichelinero(bodegon(palermo,_)).

tieneEstiloMichelinero(italiano(CantidadDePastas)):-
    CantidadDePastas > 5.

tieneEstiloMichelinero(mexicano(VariedadDeAjies)):-
    member(habanero,VariedadDeAjies),
    member(rocoto,VariedadDeAjies).


% Punto 6
tieneMayorRepertorio(UnRestaurante, OtroRestaurante):-
    esRestaurante(UnRestaurante),
    esRestaurante(OtroRestaurante),
    quienCosinaMas(UnRestaurante, OtroRestaurante).

quienCosinaMas(UnRestaurante, OtroNumeroVueltas):-
    cantidadPlatos(UnRestaurante, UnaCantidadDePlatos),
    cantidadPlatos(OtroRestaurante, OtraCantidadDePlatos),
    UnaCantidadDePlatos > OtraCantidadDePlatos.

cantidadPlatos(Restaurante, CantidadDePlatos):-
    cocinaEn(Restaurante,Chef),
    findall(Plato,elabora(Chef,Plato),ListaDePlatos),
    length(ListaDePlatos,CantidadDePlatos).

% Punto 7
calificacionGastronomica(Restaurante,Calificacion):-
    esRestaurante(Restaurante),
    cantidadPlatos(Restaurante,CantidadDePlatos),
    Calificacion is CantidadDePlatos *5.

