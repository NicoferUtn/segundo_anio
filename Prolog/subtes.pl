linea(a,[plazaMayo,peru,lima,congreso,miserere,rioJaneiro,primeraJunta,nazca]).
linea(b,[alem,pellegrini,callao,pueyrredonB,gardel,medrano,malabia,lacroze,losIncas,urquiza]).
linea(c,[retiro,diagNorte,avMayo,independenciaC,plazaC]).
linea(d,[catedral,nueveJulio,medicina,pueyrredonD,plazaItalia,carranza,congresoTucuman]).
linea(e,[bolivar,independenciaE,pichincha,jujuy,boedo,varela,virreyes]).
linea(h,[lasHeras,santaFe,corrientes,once,venezuela,humberto1ro,inclan,caseros]).

combinacion([lima, avMayo]). % A C
combinacion([once, miserere]). % H A
combinacion([pellegrini, diagNorte, nueveJulio]). % B C D
combinacion([independenciaC, independenciaE]). % C E
combinacion([jujuy, humberto1ro]). % E H
combinacion([santaFe, pueyrredonD]). % H D
combinacion([corrientes, pueyrredonB]). % H B

% ?- nth1(X,[a,b,c,d,e],d).
% ?- nth1(4,[a,b,c,d,e],X).
% ?- nth1(Orden,[a,b,c,d,e],Elem).
% ?- nth1(X,[a,b,c,d,e],j).
% ?- nth1(22,[a,b,c,d,e],X).

%nth1(Posicion, Estaciones, Estacion).


%Ej 1 
estaEn(Linea,Estacion):-
    linea(Linea, Estaciones),
    member(Estacion, Estaciones).

%Ej 2
distintas(Distancia, UnaEstacio, OtraEstacion):-
    mismaLinea(UnaEstacio, OtraEstacion),
    posicion(UnaEstacion, Posicion1),
    posicion(OtraEstacion, Posicion2),
    DistanciaEntreEstaciones is Posicion2 - Posicion1,
    abs(DistanciaEntreEstaciones, Distancia).


posicion(Estacion, Posicion):-
    estaEn(Linea, Estacion),
    linea(Linea, Estaciones),
    nth1(Posicion, Estacion, Estacion).


mismaLinea(UnaEstacio, OtraEstacion):-
    estaEn(Linea, UnaEstacio),
    estaEn(Linea, OtraEstacion).

%Ej 3
mismaAltura(Estacion1, Estacion2):-
    posicion(Estacion1, Posicion1),
    posicion(Estacion2, Posicion2),
    not(mismaLinea(Estacion1,Estacion2)),
    Posicion1 = Posicion2.


%Ej 4 
%Caso de que ambas pertenezcan a la misma linea 
viejaFacil(Estacion1, Estacion2):-
    estaEn(Linea, Estacion1),
    estaEn(Linea, Estacion2).

%Caso de que se necesite hacer combinaciones 
viejaFacil(Estacion1, Estacion2):-
    estaEnCombinacion(Estacion1, Combinacion1),
    estaEnCombinacion(Estacion2, Combinacion2),
    combinacion(Combinacion),
    member(Combinacion1, Combinacion),
    member(Combinacion2, Combinacion).


estaEnCombinacion(Estacion, Combinacion):-
    estaEn(Linea, Estacion),
    linea(Linea, Estaciones),
    member(Combinacion, Estaciones).




    
    



