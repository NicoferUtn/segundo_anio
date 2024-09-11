% Ser chico es menos de 13 años 
% Putno 1

%comidas(comida,precio).
comida(hamburguesa, 2000).
comida(panchitoConPapas, 1500).
comida(lomito, 2500).
comida(caramelos , 0).

%atracciones(NombreAtraccion, intensidad(datos)).
%Para chicos y grandes
atracciones(autitosChocadores, tranquilas(chicosYAdultos)). 
atracciones(casaEmbrujada, tranquilas(chicosYAdultos)).
atracciones(laberinto, tranquilas(chicosYAdultos)).
atracciones(tobogan, tranquilas(chicos)).
atracciones(calesita, tranquilas(chicos)).

atracciones(barcoPirata, intensas(14)).
atracciones(tazasChinas, intensas(6)).
atracciones(simulacion3D, intensas(2)).

atracciones(abismoMortalRecargado, montaniaRusas(3, 134)).
atracciones(paseoPorElBosque, montaniaRusas(0, 45)).

atracciones(elTorpedoSalpicon, acuaticos).
atracciones(esperoQueHayasTraidoUnaMudaDeRopa, acuaticos).

%visitante(nombre, edad ,dinero)
visitante(eusebio, 80, 3000).
visitante(carmela, 80, 0).

%sentimiento(nombvre, hambre, aburrimiento).
sentimineto(eusebio, 50 , 0).
sentimineto(carmela, 0 , 25).

%gurpuFamiliar(nombre, grupo).
grupoFamiliar(eusebio, viejitos).
grupoFamiliar(carmela, viejitos).


%Punto 2
estadoDeBienestar(Visitante, Estado):-
    sentimineto(Visitante, _, _),
    hamburrimiento(Visitante, Estado).

hamburrimiento(Visitante, felicidadPlena):- %La unica suma que da 0 es 0 + 0
    calcularSuma(Visitante, 0, 0, _).
    

hamburrimiento(Visitante, podriaEstarMejor):- %La unica suma que da 0 es 0 + 0
    calcularSuma(Visitante, 0, 0, _),
    not(grupoFamiliar(Visitante,_)).

hamburrimiento(Visitante, podriaEstarMejor):-
    calcularSuma(Visitante, 1, 50, _).

hamburrimiento(Visitante, necesitaEntreternerce):-
    calcularSuma(Visitante, 51, 99, _).

hamburrimiento(Visitante, seQuiereIrACasa):-
    sentimineto(Visitante, Hambre, Aburrimiento),
    Suma is Hambre + Aburrimiento,
    Suma >= 100.

calcularSuma(Visitante, Base, Tope, Suma):-
    sentimineto(Visitante, Hambre, Aburrimiento),
    Suma is Hambre + Aburrimiento,
    between(Base, Tope, Suma).

%Punto 3
% Lógica para llenar las panchitas
llenarLasPanchitas(Grupo, Comida):-
    grupoFamiliar(_, Grupo),
    comida(Comida, Precio),
    forall(grupoFamiliar(Visitante, Grupo), (puedePagarLaComida(Visitante, Precio), queComidaPuedenElegir(Visitante, Comida))).

puedePagarLaComida(Visitante, Precio):-
    visitante(Visitante, _, Dinero),
    Dinero >= Precio.

queComidaPuedenElegir(Visitante, hamburguesa):-
    sentimineto(Visitante , Hambre, _),
    Hambre =< 50.

queComidaPuedenElegir(Visitante, panchitoConPapas):-
    esChico(Visistante).

queComidaPuedenElegir(_, lomito).

queComidaPuedenElegir(_, caramelos).

esChico(Visistante):-
    visitante(Visitante, Edad, _),
    Edad =< 13 .

%Punto 4
puedeAVerLluvidaDeHamburguesas(Visistante, Atraccion):-
    comida(hamburguesa, Precio),
    puedePagarLaComida(Visistante, Precio),
    atracciones(Atraccion, _),
    esUnaAtraccionPicante(Visistante, Atraccion).

esUnaAtraccionPicante(Visistante, Atraccion):-
    atracciones(Atraccion, intensas(NroLanzamientos)),
    NroLanzamientos > 10.

esUnaAtraccionPicante(Visistante, Atraccion):- %Caso Adulto
    not(esChico(Visistante)),
    esPeligrosa(Atraccion).

esUnaAtraccionPicante(Visistante, tobogan).

esPeligrosa(Atraccion):-
    atracciones(Atraccion, montaniaRusas(NroVuelstas, _)),
    forall(atracciones(Atraccion, montaniaRusas(OtroNumeroVueltas,_)), NroVuelstas > OtroNumeroVueltas).

esPeligrosa(Atraccion):-
    atracciones(Atraccion, montaniaRusas(_,Tiempo)),
    Tiempo > 60.


mesDelPuto(Visitante, _, Comida):-
    comida(Comida, Precio),
    puedePagarLaComida(Visistante,Precio).

mesDelPuto(_,_, Atraccion):-
    atracciones(Atraccion, intensas(_)).

mesDelPuto(Mes,_,Atraccion):-
    atracciones(Atraccion, acuaticos),
    member(Mes, [septiembre, octubre, noviembre, diciembre, enero, febrero, marzo]).


mesDelPuto(Visistante, _, Atraccion):-
    not(esPeligrosa(atracciones)).

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





    

    


