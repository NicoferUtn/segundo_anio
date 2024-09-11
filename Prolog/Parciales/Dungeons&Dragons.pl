%Jugador(nombre, clase, caracteristica, cantidadDeOro)

jugador(rin, mago, 20).
jugador(atalanta, mago, 5).
jugador(kelsier, luchador, 50).
jugador(thorfinn, barbaro, 15).

caracteristica(rin, responsable).
caracteristica(rin, pacifica).
caracteristica(atalanta, responsable).
caracteristica(atalanta, fuerte).
caracteristica(kelsier, noble).
caracteristica(thorfinn, agresivo).
caracteristica(thorfinn, fuerte).


hechizos(rin, hechizo(fuego, 20)).
hechizos(rin, hechizo(frio, 30)).
hechizos(atalanta, hechizo(fuego, 30)).
hechizos(kelsier, no).
hechizos(thorfinn, no).


sonCamaradas(Jugador1, Jugador2):-
    jugador(Jugador1, Clase, _),
    jugador(Jugador2, Clase,_),
    Jugador1 \= Jugador2.

esPopular(Caracteristica):-
    caracteristica(Jugador,Caracteristica),
    jugador(Jugador,Clase,_),
    forall((jugador(Jugador,Clase,_), caracteristica(Jugador,CaracteristicaIden)), Caracteristica = CaracteristicaIden).

puedeTenerElPermisoReal(Jugador):-
    jugador(Jugador, _, Oro),
    Oro > 50.

puedeTenerElPermisoReal(kelsier).

generadorDeJugadores(Jugador):-
    jugador(Jugador, _, _).

% Misiones
mision(cruzarLaCalle, barrio, Jugador):-
    generadorDeJugadores(Jugador).

mision(cortarLenia, barrio, Jugador):-
    generadorDeJugadores(Jugador), 
    caracteristica(Jugador, fuerte).

mision(escoltarADiplomatico, aspirante, Jugador):-
    generadorDeJugadores(Jugador), 
    puedeTenerElPermisoReal(Jugador).

mision(escoltarAPrinsesa, heorica, Jugador):-
    generadorDeJugadores(Jugador), 
    caracteristica(Jugador, noble),
    puedeTenerElPermisoReal(Jugador).

mision(pesadillaDeLaCueva, heorica, Jugador):-
    jugador(Jugador, barbaro, _),
    caracteristica(Jugador, agresivo).

mision(pesadillaDeLaCueva, heorica, Jugador):-
    generadorDeJugadores(Jugador),
    hechizos(Jugador, hechizo(fuego, Poder)),
    Poder >= 30.

mision(rosasHeladasMonte,barrio, Jugador):-
    jugador(Jugador, _, Oro),
    Oro >= 20,
    hechizos(Jugador, hechizo(frio, 20)).

mision(rosasHeladasMontania,barrio, Jugador):-
    jugador(Jugador, _, Oro),
    Oro >= 20,hechizos(Jugador, hechizo(frio, 20)).


misionesQuePuedenHacer(Jugador, Mision):-
    mision(Mision, _, Jugador).

misionEsFacil(Mision):-
    mision(Mision,_,_),
    forall(generadorDeJugadores(Jugador), mision(Mision,_,Jugador)).

intento(kelsier, pesadillaDeLaCueva).
intento(kelsier, cortarLenia).
intento(rin, rosasHeladasMontania).
intento(rin, escoltarAPrinsesa).
intento(thorfinn, pesadillaDeLaCueva).
intento(atalanta, cruzarLaCalle).
intento(atalanta, cortarLenia).


resultado(Jugador, Mision, exitoso):-
    intento(Jugador, Mision),
    mision(Mision,_,Jugador).


resultado(Jugador, Mision, Resultado):-
    intento(Jugador, Mision),
    not(mision(Mision, Dificultad, Jugador)),
    resultadoDeMision(Dificultad, Resultado).

resultadoDeMision(heorica, fatal).
resultadoDeMision(aspirante, fallido).
resultadoDeMision(barrio, fallido).

esAfortunado(Jugador):-
    generadorDeJugadores(Jugador),
    forall(intento(Jugador,Mision),resultado(Jugador,Mision,exitoso)).


% Resultado fatal No oro
% barrio 2 || aspirante 15 || heroica 50

murio(Jugador):-
    resultado(Jugador, _, fatal).

recompensaEnOro(Jugador, 0):-
    murio(Jugador).

recompensaEnOro(Jugador, RecompensaTotal):-
    generadorDeJugadores(Jugador),
    not(murio(Jugador)),
    findall(Recompensa, recompensaDeMision(Jugador, _, Recompensa), Recompensas),
    sum_list(Recompensas, RecompensaTotal).

recompensaDeMision(Jugador, Mision, Recompensa):-
    resultado(Jugador, Mision, exitoso),
    oroPorRealizar(Mision, Recompensa).

oroPorRealizar(Mision, Oro):-
    mision(Mision,Caracteristica,_),
    oroSegunCategoria(Categoria, Oro).

oroSegunCategoria(deBarrio, 2).
oroSegunCategoria(aspirante, 15).
oroSegunCategoria(heroica, 50).


masRecompensado(Aventurero):-
    recompensaEnOro(Aventurero, Recompensa),
    forall((recompensaEnOro(OtroAventurero, RecompensaDelOtro),OtroAventurero \= Aventurero),Recompensa > RecompensaDelOtro).