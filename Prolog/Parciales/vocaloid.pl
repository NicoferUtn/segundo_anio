%canta(Cantante, Duracion, Cancion).
canta(megurineLuka, 4, nightFever).
canta(megurineLuka, 5, foreverYoung).
canta(hatsuneMiku, 4, tellYourWorld).
canta(gumi, 4, foreverYoung).
canta(gumi, 5, tellYourWorld).
canta(seeU, 6, novemberRain).
canta(seeU, 5, nightFever).
%Kainto no hace falta modelarlo por universo cerrado.

cantante(Cantante):-
    canta(Cantante, _, _).

%Punto 1
esNovedoso(Cantante):-
    cantante(Cantante),
    tieneMasDeDosCanciones(Cantante),
    duracionDeTodasLasCanciones(Cantante, Total),
    Total > 15.

tieneMasDeDosCanciones(Cantante):-
    canta(Cantante, _, UnaCancion),
    canta(Cantante, _, OtraCancion),
    UnaCancion \= OtraCancion.

duracionDeTodasLasCanciones(Cantante, Total):-
    findall(Tiempo, canta(Cantante, Tiempo, _), TiempoTotales),
    sumlist(TiempoTotales, Total).

%Punto 2
cantanAcelerado(Cantante):-
    cantante(Cantante),
    not((canta(Cantante, Duracion, _), not(Duracion =< 4))).

% Tipos de conciertos Gigante, Mediano, Pequeño.
%concierto(nombre, pais, fama, tipoConcierto)%
concierto(mikuExpo, eeuu, 2000, gigante(2,6)).
concierto(magicalMirai, japon, 3000, gigante(3,10)).
concierto(vocalektVisions, eeuu, 1000, mediano(9)).
concierto(mikuFest, argentina, 100, diminuto(4)).

festival(Festival):-
    concierto(Festival, _, _, _).

puedeTocarEnElFestival(Cantante, Festival):-
    cantante(Cantante),
    concierto(Festival, _, _, Requisitos),
    Cantante \= hatsuneMiku,
    cumpleConLosRequisitos(Cantante, Requisitos).

puedeTocarEnElFestival(hatsuneMiku, Festival):-
    festival(Festival). %Para poder generar todos los festivales.

cumpleConLosRequisitos(Cantante, gigante(Canciones, TiempoMinimo)):-
    cantidadDeCanciones(Cantante, CantidaDeCanciones),
    CantidaDeCanciones >= Canciones,
    duracionDeTodasLasCanciones(Cantante, CantidadMinutos),
    CantidadMinutos > TiempoMinimo.

cumpleConLosRequisitos(Cantante, mediano(TiempoMaximo)):-
    duracionDeTodasLasCanciones(Cantante, CantidadMinutos),
    CantidadMinutos < TiempoMaximo.

cumpleConLosRequisitos(Cantante, diminuto(TiempoMinimo)):-
    canta(Cantante, Tiempo,_),
    Tiempo > TiempoMinimo.

cantidadDeCanciones(Cantante, TotalCanciones):-
    findall(Cancion, canta(Cantante, _, Cancion), Canciones),
    length(Canciones, TotalCanciones).

%Punto 3
quienEsElMasFamoso(Cantante):-
    cantante(Cantante),
    famaDeVocaloids(Cantante, FamaDelCantante),
    forall(famaDeVocaloids(_, Fama), FamaDelCantante > Fama).

famaDeVocaloids(Cantante, Fama):-
    festivalesQuePuedeTocar(Cantante, TotalDeConciertosTocados),
    cantidadDeCanciones(Cantante, TotalDeCanciones),
    Fama is TotalDeCanciones * TotalDeConciertosTocados.

festivalesQuePuedeTocar(Cantante, TotalDeConciertosTocados):-
    findall(UnConcierto, puedeTocarEnElFestival(Cantante, UnConcierto), TotalDeConciertos),
    length(TotalDeConciertos, TotalDeConciertosTocados).

%Punto 4
conoce(megurineLuka, hatsuneMiku).
conoce(megurineLuka, gumi).
conoce(gumi, seeU).
conoce(seeU, kaito).

trabajaSolo(Cantante, Concierto):-
    puedeTocarEnElFestival(Cantante, Concierto),
    not(conocido(Cantante, OtroCantante)),
    puedeTocarEnElFestival(OtroCantante, Cantante).

conocido(Cantante, OtroCantante):-
    conoce(Cantante, OtroCantante).

conocido(Cantante, OtroCantante) :- 
    conoce(Cantante, UnCantante), 
    conocido(UnCantante, OtroCantante).