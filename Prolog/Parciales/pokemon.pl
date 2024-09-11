%Parte 1
%Pokemon(Nombre, Tipo).
pokemon(pikachu, electrico).
pokemon(charizar, fuego).
pokemon(venusaur, planta).
pokemon(blastoise, agua).
pokemon(totodile, agua).
pokemon(snorlax, normal).
pokemon(rayquaza, dragon).
pokemon(rayquaza, volador).

%entrenadores(nombre, poquemons).
entrenadores(ash, pikachu).
entrenadores(ash, charizar).
entrenadores(brock, snorlax).
entrenadores(misty, blastoise).
entrenadores(misty, venusaur).
entrenadores(misty, arceus).

pokemonInversible(Pokemon) :- 
    pokemon(Pokemon, _).

pokemonDeTipoMultiple(Pokemon):-
    pokemon(Pokemon,Tipo),
    pokemon(Pokemon, Tipo1),
    Tipo \= Tipo1.

pokemonEsLegendario(Pokemon):-
    pokemonInversible(Pokemon),
    pokemonDeTipoMultiple(Pokemon),
    not(entrenadores(_, Pokemon)).


pokemonEsMisterioso(Pokemon) :-
    pokemonInversible(Pokemon),
    not((entrenadores(_, Pokemon))).

pokemonEsMisterioso(Pokemon) :-
    pokemon(Pokemon, Tipo),
    forall((pokemon(OtroPokemon, OtroTipo), Pokemon \= OtroPokemon), Tipo \= OtroTipo).


%Parte 2 
%Movimientos Fisicos Espaciales Defensivos 
ataque(pikachu, fisico(mordedura, 95)).
ataque(pikachu, especial(impactrueno, 40, electrico)).
ataque(charizard, especial(garraDragon, 100, dragon)).
ataque(charizard, fisico(mordedura, 95)).
ataque(blastoise, defensivo(proteccion, 10)).
ataque(blastoise, fisico(50)).
ataque(arceus, especial(impactrueno, 40, electrico)).
ataque(arceus, especial(garraDragon, 100, dragon)).
ataque(arceus, defensivo(proteccion, 10)).
ataque(arceus, defensivo(alivio, 100)).

esbasico(Elemento):-
    member(Elemento, [fuego, agua, planta, normal]).


atacar(fisico(_, Danio), Danio).

atacar(defensivo(_, _), 0).

atacar(especial(_, Danio, Elemento), DaniosTotal):-
    esbasico(Elemento),
    DaniosTotal is Danio * 1.5.

atacar(especial(_, Danio, dragon), DaniosTotal):-
    DaniosTotal is Danio * 3.

atacar(especial(_, DaniosTotal, Elemento), DaniosTotal):-
    not(esbasico(Elemento)),
    Elemento \= dragon.



capacidadOfensiva(Pokemon, DaniosTotales):-
    ataque(Pokemon, _),
    findall(DaniosTotal, (ataque(Pokemon, Ataque), atacar(Ataque, DaniosTotal)), Danios),
    sumlist(Danios, DaniosTotales).


esPicante(Entrenador):-
    entrenadores(Entrenador, _),
    forall(entrenadores(Entrenador, Pokemon), (capacidadOfensiva(Pokemon, Capacidad) , Capacidad > 200)).

esPicante(Entrenador):-
    entrenadores(Entrenador, _),
    forall(entrenadores(Entrenador, Pokemon), pokemonEsMisterioso(Pokemon)).


