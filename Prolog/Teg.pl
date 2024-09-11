% Se cumple para los jugadores.
jugador(Jugador).
% Ejemplo:
% jugador(rojo).

% Relaciona un país con el continente en el que está ubicado,
ubicadoEn(Pais, Continente).
% Ejemplo:
% ubicadoEn(argentina, américaDelSur).

% Relaciona dos jugadores si son aliados.
aliados(UnJugador, OtroJugador).
% Ejemplo:
% aliados(rojo, amarillo).

% Relaciona un jugador con un país en el que tiene ejércitos.
ocupa(Jugador, Pais).
% Ejemplo:
% ocupa(rojo, argentina).

% Relaciona dos países si son limitrofes.
limitrofes(UnPais, OtroPais).
% Ejemplo:
% limitrofes(argentina, brasil).


%Ej 1 tienePresenciaEn/2: Relaciona un jugador con un continente del cual ocupa, al menos, un país.
tienePresenciaEn(Jugador, Continente):- 
    ocupa(Jugador, Pais),
    ubicadoEn(Pais, Continente).


%Ej 2 puedenAtacarse/2: Relaciona dos jugadores si uno ocupa al menos un país limítrofe a algún país ocupado por el otro.
puedenAtacarse(UnJugador, OtroJugador):-
    ocupa(UnJugadorJugador, Pais),
    ocupa(OtroJugador, OtroPaís),
    limitrofes(Pais, OtroPaís). 
    %Los paises no pueden ser los mismos ya que cada uno pertence a un jugador

%Ej 3 sinTensiones/2: Relaciona dos jugadores que, o bien no pueden atacarse, o son aliados.
sinTensiones(UnJugador, OtroJugador):-
    jugador(UnJugador),
    jugador(OtroJugador),
    not(puedenAtacarse(UnJugador, OtroJugador)).

sinTensiones(UnJugador, OtroJugador):-
    aliados(UnJugador, OtroJugador).

%Ej 4 perdió/1: Se cumple para un jugador que no ocupa ningún país.
perdio(UnJugador):-
    jugador(UnJugador),
    not(ocupa(UnJugador, _)).

%Ej 5 controla/2: Relaciona un jugador con un continente si ocupa todos los países del mismo.
controla(UnJugador, Continente):-
    jugador(UnJugador),
    ubicadoEn(_ , Continente),   
    forall(ubicadoEn(Pais, Continente), ocupa(UnJugador, Pais)).


%Ej 6 reñido/1: Se cumple para los continentes donde todos los jugadores ocupan algún país.
renido(Continente):- 
    ubicadoEn(_, Continente),
    forall(jugador(UnJugador), tienePresenciaEn(UnJugador, Continente)). 

%Ej 7 atrincherado/1: Se cumple para los jugadores que ocupan países en un único continente.
atrincherado(UnJugador):-
    jugador(UnJugador),
    ubicadoEn(_, Continente),
    forall(ocupa(UnJugador, Pais), ubicadoEn(Pais, Continente)).

%Ej 8 puedeConquistar/2: Relaciona un jugador con un continente si no lo controla, pero todos los países del continente que le 
% falta ocupar son limítrofes a alguno que sí ocupa y pertenecen a alguien que no es su aliado.
puedeConquistar(UnJugador, Continente):-
    jugador(UnJugador),
    continente(Continente),
    not(controla(UnJugador, Continente)),
    forall((ubicadoEn(Pais, Continente) , not(ocupa(Jugador, Pais))), cumpleCaracteristicasDeInvacion(UnJugador,Pais)).


cumpleCaracteristicasDeInvacion(UnJugador, Pais):-
    limitrofes(Pais, OtroPais),
    ocupa(OtroJugador, OtroPais),
    not(aliados(UnJugador, OtroJugador)),
    Jugador \= OtroJugador.


continente(Continente):-
    ubicadoEn(_, Continente).

    
        


    


