
%jockeys(Nombre, Cm, Kg).
jockeys(valdivieso, 155, 52).
jockeys(leguisamo, 161, 49).
jockeys(lezcano, 149, 50).
jockeys(baratucci, 153, 55).
jockeys(falero, 157, 52).

%caballo(NombreCaballo).
caballo(botafogo).
caballo(oldMan).
caballo(energica).
caballo(matBoy).

%No va por universo cerrado ya que este no quiero a ningun jockey
% caballo(yatasto).

%representa(Jockey, ClanQueRepresenta).
representa(valdivieso, elTute).
representa(falero, elTute).
representa(lezcano, lasHormigas).
representa(baratucci, elCharabon).
representa(leguisamo, elCharabon).

% gano(Caballo, PremioGanado).
gano(botafogo, granPremioNacional).
gano(botafogo, granPremioRepublica).
gano(oldMan, granPremioRepublica).
gano(oldMan, campeonatoPalermoOro).
gano(matBoy, granPremioCriadores).


jockey(Jockeys):-
    jockeys(Jockeys,_,_).

caballeria(Caballeria):-
    representa(_, Caballeria).

preferencias(botafogo, Jockeys):-
    jockeys(Jockeys,_,Peso),
    Peso < 52.
preferencias(botafogo, baratucci).

preferencias(oldMan, Jockeys):-
    jockey(Jockeys),
    atom_length(Jockeys, CantidadDeLetras),
    CantidadDeLetras > 7.

preferencias(energica, Jockey):-
    jockey(Jockey),
    not(preferencias(botafogo,Jockey)).
    
    

preferencias(matBoy, Jockeys):-
    jockeys(Jockeys, Altura, _),
    Altura >= 170.

%Punto 2
poaraMiParaVos(Caballo):-
    caballo(Caballo),
    preferencias(Caballo, UnJockey),
    preferencias(Caballo, OtroJockey),
    UnJockey \= OtroJockey.


%Punto 3
noSeLlamaAmor(Caballo, Caballeria):-
    caballo(Caballo),
    caballeria(Caballeria),
    not((representa(Jockey, Caballeria), preferencias(Caballo, Jockey))).

%Punto 4
piolines(Jockey):-
    jockey(Jockey),
    forall(caballosImportantes(Caballo), preferencias(Caballo, Jockey)).

caballosImportantes(Caballo):-
    gano(Caballo,granPremioNacional).

caballosImportantes(Caballo):- 
    gano(Caballo, granPremioRepublica).

%Punto 5
%No se entiende nada -> La resolucion es con listas Asique no lo hago 


%Punto 6
%No se entiende nada -> La resolucion es con listas Asique no lo hago 

    








    





