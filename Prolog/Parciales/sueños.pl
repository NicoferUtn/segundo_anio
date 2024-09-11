
%Punto 1
cree(gabriel, campanita).
cree(gabriel, magoDeOz).
cree(gabriel, cavenaghi).
cree(juan, conejoDePascia).
cree(macarena, losReyesMagos).
cree(macarena, elMagoCapria).
cree(macarena, campanita).

% No va por universo cerrado
% cree(diego, _).

%Tipos de sueños -> cantnatte(Cantidad de discos) || -> Furbolista(Equipo) || -> loteria(Nuemros Apostados).

suenio(gabriel, ganarLaLoteria([5,9])).
suenio(gabriel, furbolista(arsenal)).
suenio(juan, cantante(100000)).
suenio(macarena , cantante(10000)).

persona(Persona):-
    cree(Persona,_).

%Punto 2
esAmbisiosa(Persona):-
    persona(Persona),
    findall(Dificultad, (suenio(Persona, Suenio), dificultadPorSunio(Suenio, Dificultad)), Dificultades),
    sumlist(Dificultades, DificultadTotal),
    DificultadTotal > 20.

dificultadPorSunio(cantante(NumeroDeDiscos), 6):-
    NumeroDeDiscos > 500000.

dificultadPorSunio(cantante(NumeroDeDiscos), 4):-
    NumeroDeDiscos =< 500000.

dificultadPorSunio(ganarLaLoteria(CantidadDeNumeros), Dificultad):-
    length(CantidadDeNumeros, CuantosNumeros),
    Dificultad is CuantosNumeros * 10.

dificultadPorSunio(furbolista(Nombre), 16):-
    esUnEquipoGrande(Nombre).

dificultadPorSunio(furbolista(Nombre), 3):-
    not(esUnEquipoGrande(Nombre)).

esUnEquipoGrande(arsenal).
esUnEquipoGrande(aldosivi).

%Punto 3
tieneQuimica(Persona, campanita):-
    cree(Persona, campanita),
    suenio(Persona, Suenio),
    dificultadPorSunio(Suenio, Dificultad),
    Dificultad < 5.

tieneQuimica(Persona, Personaje):-
    cree(Persona, Personaje),
    Persona \= campanita,
    suenio(Persona, Suenio),
    esUnSuenioPuro(Suenio),
    not(esAmbisiosa(Persona)).


esUnSuenioPuro(furbolista(_)).

esUnSuenioPuro(cantante(Nuemros)):-
    Nuemros =< 200000.

%Punto 4
amguis(campanita, losReyesMagos).
amguis(campanita, conejoDePascia).
amguis(conejoDePascia, cavenaghi).

enfermo(campanita).
enfermo(losReyesMagos).
enfermo(conejoDePascia).

alegra(Persona, Personaje):-
    cree(Persona, Personaje).

alegra(Persona, Personaje):-
    tieneQuimica(Persona, Personaje),
    cumpleCaracteristicasDeAlegria(Personaje).

cumpleCaracteristicasDeAlegria(Personaje):-
    not(enfermo(Personaje)).

cumpleCaracteristicasDeAlegria(Personaje):-
    amguis(Personaje, OtroPersonaje),
    cumpleCaracteristicasDeAlegria(OtroPersonaje).







    


    
    

    
    