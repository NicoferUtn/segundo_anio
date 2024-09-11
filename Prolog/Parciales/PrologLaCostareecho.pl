% Chicos <= 13 años

%comida(Comida, Costo).
comida(hamburguesas, 2000).
comida(panchitoConPapas, 1500).
comida(lomitoCompleto, 2500).
comida(caramelos , 0).

%atracciones -> Tranquilas
atraccion(autitosChocadores, tranquilas(chicosYAdultos)).
atraccion(casaEmbrujada, tranquilas(chicosYAdultos)).
atraccion(laberinto, tranquilas(chicosYAdultos)).
atraccion(tobogan, tranquilas(chicosYAdultos)).
atraccion(calesita, tranquilas(chicosYAdultos)).

%atracciones -> Intensas
atraccion(barcoPirata, intensas(14)).
atraccion(tazasChinas, intensas(6)).
atraccion(simulador3D, intensas(2)).

%atracciones -> Montañas Rusas
atraccion(abismoMortalRecargada, montaniaRusa(3, 134)).
atraccion(paseoPorElBosque, montaniaRusa(0, 45)).

%atracciones -> acuaticas [Septiembre - Marzo].
atraccion(elTorpedoSalpicon, acuaticas).
atraccion(esperoQueHayasTraidoUnaMudaDeRopa, acuaticas).

%Familias -> Nombre Dinero Edad GrupoFamiliar Aburrimiento
%visitante(Nombre, Edad, Dinero).
visitante(eusebio, 80, 3000).
visitante(carmela, 80, 0).
visitante(hola, 10, 0).

%sentimiento(Nombre, Hambre, Aburrimiento).
sentimiento(eusebio, 0, 0).
sentimiento(carmela, 0, 25).
sentimiento(hola, 0, 0).

%grupoFamiliar(Nombre, GrupoFamiliar).
grupoFamiliar(eusebio, viejitos).
grupoFamiliar(carmela, viejitos).

visitantes(Visitante):-
    visitante(Visitante, _, _).

%%% -> Punto 2 <- %%%
felicidadPlena(Visitante, EstadoDeFelicidad):-
    visitantes(Visitante),
    esQueEstadoDeFelicidadEsta(Visitante, EstadoDeFelicidad).

sumaDeEstados(Visitante, Piso, Tope):-
    sentimiento(Visitante, Hambre, Aburrimiento),
    Total is Hambre + Aburrimiento,
    between(Piso, Tope, Total).

esQueEstadoDeFelicidadEsta(Visitante, felicidadPlena):-
    sumaDeEstados(Visitante, 0, 0).

esQueEstadoDeFelicidadEsta(Visitante, podriaEstarMejor):-
    sumaDeEstados(Visitante, 1, 50).

esQueEstadoDeFelicidadEsta(Visitante, necesitaEntreternerce):-
    sumaDeEstados(Visitante, 51, 99).

esQueEstadoDeFelicidadEsta(Visitante, seQuiereIrACasa):-
    sentimiento(Visitante, Hambre, Aburrimiento),
    Total is Hambre + Aburrimiento,
    Total >= 100.

esQueEstadoDeFelicidadEsta(Visitante, podriaEstarMejor):-
    not(grupoFamiliar(Visitante,_)),
    sumaDeEstados(Visitante, 0, 0).

%%% -> Punto 3 <- %%%
puedeSatifacerLaComida(Visitante, Comida):-
    visitantes(Visitante),
    teLlenaLAComida(Visitante, Comida).

esMenor(Visitante):-
    visitante(Visitante, Edad, _),  
    Edad =< 13.

teLlenaLAComida(Visitante, hamburguesas):-
    sentimiento(Visitante, Hambre, _),
    Hambre =< 50.

teLlenaLAComida(Visitante, panchitoConPapas):-
    esMenor(Visitante).

teLlenaLAComida(_, laberinto).

%%% -> Punto 4  <- %%%
elVisitantePuedeComrpar(Visitante, hamburguesas):-
    visitante(Visitante, _, Dinero),
    comida(hamburguesas, Costo),
    Dinero >= Costo.

esPeligrosa(Visitante, montaniaRusa(Giros, _)):-
    not(esMenor(Visitante)),
    atraccion(_, montaniaRusa(Giros, _)),
    not(esQueEstadoDeFelicidadEsta(Visitante, necesitaEntreternerce)),
    forall((atraccion(_, montaniaRusa(OtroGiros, _))), Giros >= OtroGiros).

esPeligrosa(Visitante, montaniaRusa(Giros, _)):-
    not(esMenor(Visitante)),
    atraccion(_, montaniaRusa(Giros, _)),
    esQueEstadoDeFelicidadEsta(Visitante, necesitaEntreternerce).

esPeligrosa(Visitante, montaniaRusa(_, Tiempo)):-
    esMenor(Visitante),
    Tiempo >= 60.

esAdultoMiedoso(Visitante):-
    not(esMenor(Visitante)),
    not(esQueEstadoDeFelicidadEsta(Visitante, necesitaEntretenerse)).

puedenLloverHamburguesas(Visitante, Atraccion):-
    elVisitantePuedeComrpar(Visitante, hamburguesas),
    laAtraccionEsValidaParaLluvia(Visitante, Atraccion).

laAtraccionEsValidaParaLluvia(_, Atraccion):-
    atraccion(Atraccion, intensas(CoeficienteDeLanzamiento)),
    CoeficienteDeLanzamiento > 10.

laAtraccionEsValidaParaLluvia(Visitante, Atraccion):-
    atraccion(Atraccion, CaracteristicasDeLaMontania),
    esPeligrosa(Visitante, CaracteristicasDeLaMontania).

laAtraccionEsValidaParaLluvia(_, tobogan).

%%% -> Punto 5  <- %%%
mesDelPuto(Visitante, _, Comida):-
    comida(Comida, Precio),
    elVisitantePuedeComrpar(Visistante,Precio).

mesDelPuto(_,_, Atraccion):-
    atraccion(Atraccion, intensas(_)).

mesDelPuto(Mes,_,Atraccion):-
    atraccion(Atraccion, acuaticos),
    member(Mes, [septiembre, octubre, noviembre, diciembre, enero, febrero, marzo]).


mesDelPuto(Visistante, _, Atraccion):-
    not(esPeligrosa(_, Atraccion)).

mesDelPuto(Visistante, _, Atraccion):-
    atraccion(Atraccion, tranquilas(FranjaEtaria)),
    puedeAcceder(Visitante, FranjaEtaria).


puedeAcceder(Visitante, chicos) :-
    esMenor(Visitante).

puedeAcceder(Visitante, chicos) :-
    grupoFamiliar(Visistante, Grupo),
    not(esMenor(Visitante)),
    hayAlgunChicoEnElGrupo(Grupo).



hayAlgunChicoEnElGrupo(Grupo) :-
    grupoFamiliar(Integrante, Grupo),
    esChico(Integrante).


