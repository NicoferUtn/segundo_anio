%% cantar(Cantante, Cancion, Duracion).
cantar(megurineLuka, nightFever , 4).
cantar(megurineLuka, foreverYoung  , 5).
cantar(hatsuneMiku, tellYourWorld , 4).
cantar(gami, foreverYoung , 4).
cantar(gami, tellYourWorld , 5).
cantar(seeU, novemberRain, 6).
cantar(seeU, nightFever , 5).
% Kaito no va en la base de conocimientos por universo cerrado

%% Punto 1
esNovedoso(Cantante):-
    tieneDosCancionesDistintas(Cantante).
    duracionDeTodasLasCanciones(Cantante, Tiempo),
    Tiempo =< 15.

tieneDosCancionesDistintas(Cantante):-
    cantar(Cantante, UnaCancion, _),
    cantar(Cantante, OtraCancion, _),
    UnaCancion \= OtraCancion.

duracionDeTodasLasCanciones(Cantante, Tiempo):-
    findall(Duracion, cantar(Cantante, _, Duracion), Duraciones),
    sumlist(Duraciones, Tiempo).

%% Punto 2
todasSusCancionesDuranMenosDe(Cantante):-
    cantar(Cantante, _,_),
    not((cantar(Cantante, _, Duracion), not(Duracion =< 4))).
    
    
% Concierto(Nombre, Pais, CantidadFama, TipoConcierto())
% Concierto(Nombre, Pais, CantidadFama, gignate(minimoCanciones, DuracionMinima)).
concierto(mikuExpo, eeuu, 2000, gigante(2,6)).
concierto(magicalMirai, japon, 3000, gigante(3,10)).
concierto(vocalektVisions, eeuu, 1000, mediano(9)).
concierto(mikuFest, argentina, 100, diminuto(4)).

cantidaDeCanciones(Cantante, Cantidad) :- 
    findall(Cancion, cantar(Cantante, Cancion, _), Canciones),
    length(Canciones, Cantidad).
        

cumpleLosRequerimientosPara(_, hatsuneMiku).

cumpleLosRequerimientosPara(Concierto, Cantante):-
    concierto(Concierto, _, _, Condiciones),
    cantar(Cantante,_,_),
    Cantante \= hatsuneMiku,
    cumpleLosRequisitos(Cantante, Condiciones).

cumpleLosRequisitos(Cantante, gigante(MinimoCanciones, DuracionMinima)):-
    duracionDeTodasLasCanciones(Cantante, Duracion),
    Duracion > DuracionMinima.
    cantidaDeCanciones(Cantante, Cantidad),
    Cantidad > MinimoCanciones.

cumpleLosRequisitos(Cantante, mediano(MinutosMaximos)):-
    duracionDeTodasLasCanciones(Cantante, Tiempo),
    Tiempo < MinutosMaximos.

cumpleLosRequisitos(Cantante, diminuto(MinutosMinimos)):-
    cantar(Cantante, _, Duracion),
    Duracion >= MinutosMinimos.

famaDelVocaloid(Cantante, FamaTotal):-
    cantar(Cantante, _, _),
    findall(Fama,(cumpleLosRequerimientosPara(Concierto,Cantante), concierto(Concierto, _, Fama, _)),FamaAcumulada),
    sumlist(FamaAcumulada, FamaTotal).
    

conoce(megurineLuka , hatsuneMiku).
conoce(megurineLuka, gumi).
conoce(gumi, seeU).
conoce(seeU, kaito).

trabajaSolo(Cantante, Concierto):-
    cumpleLosRequisitos(Cantante, Concierto),
    not(conoceAAlguen(Cantante, OtroCantante)),
    cumpleLosRequisitos(OtroCantante, Concierto).

conoceAAlguen(Cantante, OtroCantante):-
    conoce(Cantante, OtroCantante).

conoceAAlguen(Cantante, OtroCantante):-
    conoce(Cantante, UnCantante),
    conoce(UnCantante, OtroCantante).