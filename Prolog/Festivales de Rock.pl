% festival(NombreDelFestival, Bandas, Lugar).
% Relaciona el nombre de un festival con la lista de los nombres de bandas que tocan en él y el lugar dónde se realiza.
festival(lollapalooza, [gunsAndRoses, theStrokes, littoNebbia], hipodromoSanIsidro).
festival(lollapalooza, [gunsAndRoses, theStrokes, littoNebbia], movistarArena).
% lugar(nombre, capacidad, precioBase).
% Relaciona un lugar con su capacidad y el precio base que se cobran las entradas ahí.
lugar(hipodromoSanIsidro, 85000, 3000).

% banda(nombre, nacionalidad, popularidad).
% Relaciona una banda con su nacionalidad y su popularidad.
banda(gunsAndRoses, eeuu, 69420).

% entradaVendida(NombreDelFestival, TipoDeEntrada).
% Indica la venta de una entrada de cierto tipo para el festival 
% indicado.
% Los tipos de entrada pueden ser alguno de los siguientes: 
%     - campo
%     - plateaNumerada(Fila)
%     - plateaGeneral(Zona).
entradaVendida(lollapalooza, campo).
entradaVendida(lollapalooza, campo).
entradaVendida(lollapalooza, campo).
entradaVendida(lollapalooza, plateaNumerada(1)).
entradaVendida(lollapalooza, plateaGeneral(zona2)).

% plusZona(Lugar, Zona, Recargo)
% Relacion una zona de un lugar con el recargo que le aplica al precio de las plateas generales.
plusZona(hipodromoSanIsidro, zona2, 1500).

%Ej 1 
itinerante(Festival):-
    festival(Festival, Bandas, Lugar),
    festival(Festival, Bandas, OtroLugar),
    Lugar \= OtroLugar.

%Ej 2
%careta(PesonalFest).

careta(Festival):-
    nombreDelFestival(Festival),
    not(entradaVendida(Festival,campo)).

nombreDelFestival(Festival):-
    festival(Festival, _, _).


%Ej 3 
nacAndPop(Festival):-
    festival(Festival, Bandas,_),
    not(careta(Festival)),
    bandasDeNacAndPop(Bandas).


bandasDeNacAndPop(Bandas):-
    bandasInversibles(Bandas),
    forall(member(Banda, Bandas), (banda(Banda, Nacionalidad, Popularidad), Nacionalidad > argentina, Popularidad > 1000)). 

bandasInversibles(Bandas):- 
    festival(_,Bandas,_).

%Ej 4
sobrevendido(Festival):-
    festival(Festival,_ , Lugar),
    lugar(Lugar,Capacidad, _),
    cantidadDeVentasTotales(Festival,_ ,TotalVendidas),
    Capacidad < TotalVendidas.

cantidadDeVentasTotales(Festival,TipoDeEntrada,TotalVendidas):-
    findall(Entrada, entradaVendida(Festival, TipoDeEntrada), TotalDeEntradas),
    length(TotalDeEntradas, TotalVendidas).

%Ej 5
recuadacionTotal(Festival, Venta):-
    festival(Festival, _, Lugar),
    lugar(Lugar, _, PrecioBase),
    findall(Precio, (entradaVendida(Festival, TipoDeEntrada), precio(TipoDeEntrada, Lugar, PrecioBase ,Precio)), Precios),
    sumlist(Precios, Venta).

precio(campo, Lugar, PresioBase,Precio):-
    Precio is PresioBase.

precio(plateaGeneral(Zona), Lugar, PrecioBase, Precio):-
    plusZona(Lugar,Zona, Agregado),
    Precio is PrecioBase + Agregado.

precio(plateaNumerada(NumeroDePlatea), Lugar, PrecioBase, Precio):-
    NumeroDePlatea > 10,
    Precio is 3 * PrecioBase.

precio(plateaNumerada(NumeroDePlatea), Lugar, PrecioBase, Precio):-
    NumeroDePlatea =< 10,
    Precio is 6 * PrecioBase.

%Ej 6
delMismoPalo(Banda1, Banda2):-
    bandaConQuientesTocaron(Banda1,Banda2).

delMismoPalo(Banda1, Banda2):-
    bandaConQuientesTocaron(Banda1,Banda3),
    banda(Banda1,_,Popularidad1),
    banda(Banda2,_,Popularidad2),
    Popularidad1 > Popularidad2,
    delMismoPalo(Banda3,Banda2).

bandaConQuientesTocaron(Banda1, Banda2):-
    festival(_,Banda,_),
    member(Banda1, Bandas),
    member(Banda2, Bandas),
    Banda1 \= Banda2.







    

