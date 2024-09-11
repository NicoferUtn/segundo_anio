% Definiciones de juegos
juego(losSims, rol(1000000, 0)).
juego(rompecabezas, puzzle(8, dificil)).
juego(tuMama, puzzle(10,facil)).
juego(rainbowSixSiege, accion).

% Precios de juegos
precio(losSims, 12000).
precio(rompecabezas, 5000).
precio(rainbowSixSiege, 21000).
precio(tuMama,100000000).
precio(ageOfEmpires,8967).

% Descuentos en juegos
estasEnDescuento(rainbowSixSiege, 50).
estasEnDescuento(ageOfEmpires,10).

% Definición de jugadores y compras
jugador(nico, rainbowSixSiege, regalo(mati)).
jugador(mati, tuMama, regalo(nico)).
jugador(mati, ageOfEmpires, regalo(mati)).
jugador(leo, rainbowSixSiege, paraMi).

% Predicado para obtener juegos
juegos(Juego):-
    juego(Juego,_).

% Predicado para calcular el precio de un juego
cuantoSale(Juego,Precio):-
    juegos(Juego),    
    tieneDescuento(Juego, Precio).

tieneDescuento(Juego, Precio):-
    precio(Juego, Precio),
    not(estasEnDescuento(Juego,_)).

tieneDescuento(Juego, PrecioFinal):-
    precio(Juego, Precio),
    estasEnDescuento(Juego, Porcentaje),
    PrecioFinal is Precio * (1 - Porcentaje / 100).

% Predicado para verificar si un juego tiene buen descuento
tineUnBuenDescuento(Juego):-
    juegos(Juego),
    estasEnDescuento(Juego, Porcentaje),
    between(50, 100, Porcentaje).
    
% Definición de popularidad de juegos
esPopular(Juego):-
    juego(Juego, Caracteristicas),
    cumpleLasCaracteristicas(Caracteristicas).

cumpleLasCaracteristicas(accion).
cumpleLasCaracteristicas(puzzle(_, facil)).
cumpleLasCaracteristicas(puzzle(25, _)).

% Definición de jugadores y descuentos
jugador(Jugador):-
    jugador(Jugador,_,_).

adictoALosDescuentos(Jugador):-
    jugador(Jugador),
    forall(jugador(Jugador, Juego,_), tineUnBuenDescuento(Juego)).

% Fanático de un género
fanatico(Jugador, Genero):-
    jugador(Juegador, Juego,_),
    jugador(Juegador, OtroJuego, _),    
    juego(Juego, Genero),       
    juego(OtroJuego, Genero),
    Juego \= OtroJuego.

% Definición de jugadores monotemáticos
monotematico(Jugador,Genero):-
    jugador(Jugador),
    forall(jugador(Jugador,Juego,_),juego(Juego,Genero)).

% Verificar si son buenos amigos
buenosAmigos(UnJugador,OtroJugador):-
    elRegaloEsPopular(UnJugador,OtroJugador),
    elRegaloEsPopular(OtroJugador, UnJugador).

elRegaloEsPopular(UnJugador,OtroJugador):-
    jugador(UnJugador,Juego,regalo(OtroJugador)),
    esPopular(Juego).

% Predicado para calcular el gasto de un jugador




cuentoGasta(Jugador, TipoDeCompra,PrecioGastado):-
    TipoDeCompra \= ambas,
    precioGastadoTotal(Jugador, PrecioGastado, TipoDeCompra).

cuentoGasta(Jugador, ambas, PrecioGastado) :-
    precioGastadoTotal(Jugador, PrecioParaMi, paraMi),
    precioGastadoTotal(Jugador, PrecioRegalo, regalo(_)),
    PrecioGastado is PrecioParaMi + PrecioRegalo.

% Predicado para calcular el precio total gastado por tipo de compra
precioGastadoTotal(Jugador, Precio, TipoDeCompra) :-
    findall(PrecioJuego, (jugador(Jugador, Juego, TipoDeCompra), cuantoSale(Juego, PrecioJuego)), ListaPrecios),
    sumlist(ListaPrecios, Precio).