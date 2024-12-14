herramientasRequeridas(ordenarCuarto, [aspiradora(100), trapeador, plumero]).
herramientasRequeridas(limpiarTecho, [escoba, pala]).
herramientasRequeridas(cortarPasto, [bordedadora]).
herramientasRequeridas(limpiarBanio, [sopapa, trapeador]).
herramientasRequeridas(encerarPisos, [lustradpesora, cera, aspiradora(300)]).

%% -> Punto 1 <- %%
herramienta(egom, aspiradora(200)).
herramienta(egom, trapeador).
herramienta(peter, trapeador).
herramienta(winston, varitaDeNeutrones).

%% -> Punto 2 <- %%
tieneUna(Herramienta, Persona):-
    Herramienta \= aspiradora(_),
    herramienta(Persona, Herramienta).

tieneUna(aspiradora(PotenciaMinima), Persona):-
    herramienta(Persona, aspiradora(Potencia)),
    Potencia >= PotenciaMinima.

tieneUna(Herramienta, Persona):- %% Agregado Para el punto 6
    herramientasIguales(Herramienta, OtraHerramienta),
    herramienta(Persona, OtraHerramienta).

%% -> Punto 3 <- %%
puedeHacerUnaTarea(Persona, Tarea):-
    herramienta(Persona, _),
    herramientasRequeridas(Tarea, _),
    forall((herramientasRequeridas(Tarea, HerramientaRequeridas), member(Herramienta, HerramientaRequeridas)),tieneUna(Herramienta, Persona)).


puedeHacerUnaTarea(Persona, _):-
    herramienta(Persona, varitaDeNeutrones).

%% -> Punto 4 <- %%
% tareaPedida(Cliente, TareaPedida, MetrosCuadrados).
tareaPedida(pepe, limpiarTecho, 100).
% precio(tarea, precioPorMetro).
precio(limpiarTecho, 2).

%% -> Punto 5 <- %%
% tareasQueHaceptan(Persona, Tarea).
tareasQueHaceptan(ray, Tarea):-
    tareaPedida(_, Tarea, _),
    Tarea \= limpiarTecho.

tareasQueHaceptan(winston, Tarea):-
    tareaPedida(_, Tarea, MetrosCuadrados),
    precio(Tarea, PrecioPorMetro),
    Total is MetrosCuadrados * PrecioPorMetro,
    500 < Total.

tareasQueHaceptan(egon, Tarea):-
    tareaPedida(_, Tarea, _),
    not(tareaEsCompleja(Tarea)).

tareasQueHaceptan(peter,_).

tareaEsCompleja(limpiarTecho).

tareaEsCompleja(Tarea):-
    Tarea \= limpiarTecho,
    herramienta(Tarea, HerramientaRequeridas),
    length(HerramientaRequeridas, Cantidad),
    Cantidad > 2.


%% -> Punto 6 <- %% 
% herramientasIguales(UnaHerramienta, OtraHerramientad).
herramientasIguales(aspiradora(100), escoba).



    
    
