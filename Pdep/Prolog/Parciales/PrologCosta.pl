% Chico < 13 años 

%% Punto 1
%comida (nombre, precio).
comida(hamburguesa, 2000).
comida(panchitosConPapas, 1500).
comida(lomitoCompletos, 2500).
comida(caramielos, 0).

% atracciones(Nombre, tipo (paraQuien))
atracciones(autitosChocadores, tranquilas(chicosYAdultos)).
atracciones(casaEmbrujada, tranquilas(chicosYAdultos)).
atracciones(elLaberinto, tranquilas(chicosYAdultos)).
atracciones(tobogan, tranquilas(chicos)).
atracciones(calesita, tranquilas(chicos)).

atracciones(barcoPirata, intentsas(14)).
atracciones(tazasChinas, intentsas(6)).
atracciones(simnulador3D, intentsas(2)).

atracciones(abismoMortalRecargada, montaniaRusa(3, 134)).
atracciones(paseoPorElBosque, montaniaRusa(0, 45)).

atracciones(elTorpedoSalpicon, acuatica).
atracciones(esperoQueHayasTraidoUnaMudaDeRopa, acuatica).

%visitante(nombre, edad ,dinero)
visitante(eusebio, 80, 3000).
visitante(carmela, 80, 0).

%sentimiento(nombvre, hambre, aburrimiento).
sentimiento(eusebio, 50 , 0).
sentimiento(carmela, 0 , 25).

%gurpuFamiliar(nombre, grupo).
grupoFamiliar(eusebio, viejitos).
grupoFamiliar(carmela, viejitos).

%% Punto 2
bienestarDeUn(Visitante, Estado):-
    sentimiento(Visitante, Habre, Aburrimiento),
    bienestar(Visitante, Estado).


sumaDeBienestar(Visistante, Piso, Tope):-
    sentimiento(Visistante, Hambre, Aburrimiento),
    Total is Hambre + Aburrimiento,
    between(Piso, Tope, Total).

bienestar(Visistante, felicidadPlena):-
    sumaDeBienestar(Visistante, 0, 0).

bienestar(Visistante, podriaEstarMejor):-
    sumaDeBienestar(Visistante, 1, 50).

bienestar(Visistante, necesitaEntretenerse):-
    sumaDeBienestar(Visistante, 51, 99).

bienestar(Visistante, seQuiereIrACasa):- 
    sentimiento(Visistante, Hambre, Aburrimiento),
    Total is Aburrimiento + Habre,
    Total >= 100.

bienestar(Visistante, podriaEstarMejor):-
    not(grupoFamiliar(Visistante, _ )),
    sumaDeBienestar(Visistante, 0, 0).

%% Punto 3
puedeSatifacerElHambre(Grupo, Comida):-
    grupoFamiliar(_ ,Grupo),
    comida(Comida, Precio).
    forall(gurpuFamiliar(Visistante, Grupo),(satisface(Comida, Visistante), puedePagarLaComida(Visistante, Precio))).

esChico(Visistante):-
    visitante(Visistante, Anios, _),
    Anios < 13.

puedePagarLaComida(Visistante, Precio):-
    visitante(Visistante, _, Dinero),
    Dinero >= Precio.

satisface(hamburguesa, Visistante):-
    sentimiento(Visistante, Hambre, _),
    Hambre =< 50.

satisface(panchitoConPapas, Visistante):-
    esChico(Visistante).

satisface(lomitoCompletos, _).

satisface(caramelos, Visitante):-
    comida(Comida, _),
    forall(comida(Comida, Precio), not(puedePagarLaComida(Visistante, Precio))).

%% Punto 4
puedenLloverHamburguesa(Visistante, Atraccion):-
    comida(hamburguesa, Precio),
    puedePagarLaComida(Visistante, Precio),
    atracciones(Atraccion, _),
    esUnaAtraccionPicante(Atraccion, Visitante).

esUnaAtraccionPicante(Atraccion, _):-
    atracciones(Atraccion, intentsas(Coeficiente)),
    Coeficiente > 10.

esUnaAtraccionPicante(Atraccion, Visistante):-
    esPeligrosa(Atraccion, Visistante).

esUnaAtraccionPicante(tobogan,_).

esPeligrosa(Atraccion, Visistante):-
    not(esChico(Visistante)), %Osea es adulto
    not(bienestar(Visistante, necesitaEntretenerse)),
    atracciones(Atraccion, montaniaRusa(UnosGiros,_)),
    forall(atracciones(OtraAtraccion,montaniaRusa(OtrosGiros, _), Atraccion \= OtraAtraccion), UnosGiros >= OtrosGiros).

esPeligrosa(Atraccion, Visistante):-
    not(esChico(Visistante)),
    bienestar(Visistante, necesitaEntretenerse).

esPeligrosa(Atraccion, Visistante):-
    esChico(Visistante),
    atracciones(Atraccion, montaniaRusa(_, Tiempo)),
    Tiempo >= 60.

%% Punto 5
mesDelPuto(Visitante, _, Comida):-
    comida(Comida, Precio),
    puedePagarLaComida(Visistante,Precio).

mesDelPuto(_,_, Atraccion):-
    atracciones(Atraccion, intensas(_)).

mesDelPuto(Mes,_,Atraccion):-
    atracciones(Atraccion, acuaticos),
    member(Mes, [septiembre, octubre, noviembre, diciembre, enero, febrero, marzo]).


mesDelPuto(Visistante, _, Atraccion):-
    not(esPeligrosa(_, Atraccion)).

mesDelPuto(Visistante, _, Atraccion):-
    atracciones(Atraccion, tranquilas(FranjaEtaria)),
    puedeAcceder(Visitante, FranjaEtaria).


puedeAcceder(Visitante, chicos) :-
    esChico(Visitante).

puedeAcceder(Visitante, chicos) :-
    grupoFamiliar(Visistante, Grupo),
    not(esChico(Visitante)),
    hayAlgunChicoEnElGrupo(Grupo).

hayAlgunChicoEnElGrupo(Grupo) :-
    grupoFamiliar(Integrante, Grupo),
    esChico(Integrante).