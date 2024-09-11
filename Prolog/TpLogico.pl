%Parte 1
    %Punto 1
% jugador(ana, romanos, [herreria,forja,emplumado,laminas]).
% jugador(beto, incas, [herreria,forja]).
% jugador(carola, romanos, [herreria]).
% jugador(dimitri, romanos, [herreria,fundicion]).

%     %Punto 2
% expertoEnMetales(Jugador) :-
%     jugador(Jugador,_,Herramientas),
%     member(herreria, Herramientas),
%     member(forja, Herramientas),
%     member(fundicion, Herramientas).

% expertoEnMetales(Jugador) :-
%     jugador(Jugador, romanos, Tecnologia),
%     member(hermanos, Tecnologia),
%     member(forja,Tecnologia).

%     %Punto 3
% civilizacionEsPopular(Civilizacion):-
%     jugador(_,Civilizacion,_),
%     findall(Jugador, jugador(_,Civilizacion,_), Jugadores),
%     length(Jugadores, CantidadDeJugadores),
%     CantidadDeJugadores > 1.

%     %Punto 4
% alcanceGlobal(Tecnologia):-
%     jugador(_, _, OtrasTecnologias),
%     member(Tecnologia, OtrasTecnologias),
%     forall(jugador(_, _, Tecnologias), perteneceATecnologias(Tecnologia, Tecnologias)).

% perteneceATecnologias(Tecnologia, Tecnologias):-
%     nth1(Lugar, Tecnologias, Tecnologia), 
%     Lugar > 0.

%     %Punto 5
% % civilizacionEsLider(Civilizacion):-
% %     civilizacion(_ , Civilizacion),
% %     findall(Tecnologia, desarrollo(_, Tecnologia), Tecnologias), 
% %     forall(member(Tec, Tecnologias),(civilizacion(Jugador, Civilizacion), desarrollo(Jugador, Tec))). 

% civilizacionEsLider(Civilizacion):-
%     findall(TecnologiasJugador, (jugador(_, Civilizacion, TecnologiasJugador1), member(TecnologiasJugador, TecnologiasJugador1)),TecnologiasDeCivilizacion),
%     forall((jugador(_,OtraCivilizacion,Tecnologias), member(Tec, Tecnologia), Civilizacion \= OtraCivilizacion), perteneceATecnologias(Tec, TecnologiasDeCivilizacion)).

%Parte 1
    %Punto 1
jugador(ana).
jugador(beto).
jugador(carola).
jugador(dimitri).

civilizacion(ana, romanos).
civilizacion(beto, incas).
civilizacion(carola, romanos).
civilizacion(dimitri, romanos).

desarrollo(ana ,herreria).
desarrollo(ana, forja).
desarrollo(ana, fundicion).
desarrollo(ana, laminas).
desarrollo(beto, herreria).
desarrollo(beto, forja).
desarrollo(beto, fundicion).
desarrollo(carola, herreria).
desarrollo(dimitri, herreria).
desarrollo(dimitri, emplumado).


    % Punto 2
expertoEnMetales(Jugador) :-
    jugador(Jugador),
    desarrollo(Jugador, herreria),
    desarrollo(Jugador, forja),
    desarrollo(Jugador, fundicion).

expertoEnMetales(Jugador) :-
    civilizacion(Jugador, romanos),
    desarrollo(Jugador, herreria),
    desarrollo(Jugador, forja).

    % Punto 3
civilizacionEsPopular(Civilizacion):-
    civilizacion(Jugador1, Civilizacion),
    civilizacion(Jugador2, Civilizacion),
    Jugador1 \= Jugador2.


    %Punto 4
alcanceGlobal(Tecnologia):-
    desarrollo(_, Tecnologia),
    forall(jugador(Jugador), desarrollo(Jugador, Tecnologia)).

    %Punto 5
civilizacionEsLider(Civilizacion):-
    civilizacion(_ , Civilizacion),
    findall(Tecnologia, desarrollo(_, Tecnologia), Tecnologias), 
    forall(member(Tec, Tecnologias),(civilizacion(Jugador, Civilizacion), desarrollo(Jugador, Tec))). 

%Parte 2
    %Putno 1
unidad(ana, jinete(caballo)).
unidad(ana, piquetero(1, false)).
unidad(ana, piquetero(2, true)).
unidad(beto, campeon(100)).
unidad(beto, campeon(80)).
unidad(beto, piquetero(1, true)).
unidad(beto, jinete(camello)).
unidad(carola, piquetero(3, false)).
unidad(carola, piquetero(2, true)).
unidad(dimitri, no).

    %Punto 2
masVida(Jugador, Vida):-
    unidad(Jugador, Unidad),
    cantidadDeVida(Unidad, Vida),
    forall((unidad(Jugador, OtraUnidad), cantidadDeVida(OtraUnidad, OtraVida), OtraUnidad \= Unidad), Vida > OtraVida).

cantidadDeVida(jinete(caballo), 90).
cantidadDeVida(jinete(camello), 80).

cantidadDeVida(piquetero(1, false), 50).
cantidadDeVida(piquetero(2, false), 65).
cantidadDeVida(piquetero(3, false), 70).

cantidadDeVida(campeon(Vida), Vida).

cantidadDeVida(piquetero(NivelDeEscudo, true), Vida):-
    cantidadDeVida(piquetero(NivelDeEscudo, false), VidaSinEscudo),
    Vida is VidaSinEscudo * 1.1.

    %Punto 3
enfretarDosUnidades(Unidad1, Unidad2):-
    unidad(_, Unidad1),
    unidad(_, Unidad2),
    ganadorDeEnfrentamiento(Unidad1,Unidad2).

enfretarDosUnidades(Unidad1, Unidad2):-
    unidad(_, Unidad1),
    unidad(_, Unidad2),
    not(ganadorDeEnfrentamiento(Unidad1,Unidad2)),
    cantidadDeVida(Unidad1, Vida1),
    cantidadDeVida(Unidad2, Vida2),
    Vida1 > Vida2. 


ganadorDeEnfrentamiento(jinete(_), campeon(_)).
ganadorDeEnfrentamiento(campeon(_), piquetero(_,_)).
ganadorDeEnfrentamiento(piquetero(_,_), jinete(_)).
ganadorDeEnfrentamiento(jinete(camello), jinete(caballo)).

    %Punto 4
puedeSobrevivirAUnAsedio(Jugador):-
    unidad(Jugador, _),
    cantidadDePiqueteros(Jugador, true, NroConEscudo),
    cantidadDePiqueteros(Jugador, false, NroSinEscudo),
    NroConEscudo > NroSinEscudo.

cantidadDePiqueteros(Jugador, TieneEscudo, NroPiqueteros):-
    findall(_, unidad(Jugador, piquetero(_, TieneEscudo)), TodosPiqueteros), %No me interesa la indormacion de piquetrero entonce _
    length(TodosPiqueteros, NroPiqueteros).

    %Punto 5.A

tecnologias(emplumado, herreria). 
tecnologias(forja, herreria).
tecnologias(laminas, herreria).
tecnologias(punzon, emplumado).
tecnologias(fundicion, forja).
tecnologias(horno,fundicion).
tecnologias(malla,laminas).
tecnologias(placas, malla). 
tecnologias(collera, molino).
tecnologias(arado, collera). 

tecno(herreria). 
tecno(emplumado).
tecno(forja).
tecno(laminas).
tecno(punzon).
tecno(fundicion).
tecno(malla).
tecno(horno).
tecno(placas).
tecno(molino).
tecno(collera).
tecno(arado). 

     
    % B.
puedeDesarrollar(Jugador, Tecnologia):-
    tecno(Tecnologia),
    not(desarrollo(Jugador, Tecnologia)),
    recorerArbol(Tecnologia, Jugador).

recorerArbol(Tecnologia, Jugador):-
    tecnologias(Tecnologia, TecnologiaAnterior),
    desarrollo(Jugador, TecnologiaAnterior),
    recorerArbol(TecnologiaAnterior, Jugador).

recorerArbol(Tecnologia,_):- Tecnologia = herreria.
recorerArbol(Tecnologia,_):- Tecnologia = molino.

