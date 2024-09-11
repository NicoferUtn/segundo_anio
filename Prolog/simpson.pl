padreDe(abe, abbie).
padreDe(abe, homero).
padreDe(abe, herbert).
padreDe(clancy, marge).
padreDe(clancy, patty).
padreDe(clancy, selma).
padreDe(homero, bart).
padreDe(homero, hugo).
padreDe(homero, lisa).
padreDe(homero, maggie).
madreDe(edwina, abbie).
madreDe(mona, homero).
madreDe(gaby, herbert).
madreDe(jacqueline, marge).
madreDe(jacqueline, patty).
madreDe(jacqueline, selma).
madreDe(marge, bart).
madreDe(marge, hugo).
madreDe(marge, lisa).
madreDe(marge, maggie).
madreDe(selma, ling).


%PadreDe(Padre, Hijo).
%MadreDe(Madre, Hijo).

% tieneHijo/1: Nos dice si un personaje tiene un hijo o hija.
tieneHijo(Personaje):-
    padreDe(Personaje, _).

tieneHijo(Personaje):-
    madreDe(Personaje, _).


% hermanos/2: Relaciona a dos personajes cuando estos comparten madre y padre.
hermanos(UnHermano, OtroHemano):-
    compartenMadre(UnHermano, OtroHemano),
    compartenPadre(UnHermano, OtroHemano).

compartenMadre(UnHermano, OtroHemano):-
    madreDe(Madre ,UnHermano),
    madreDe(Madre, OtroHemano),
    UnHermano \= OtroHemano.

compartenPadre(UnHermano, OtroHemano):-
    padreDe(Padre, UnHermano),
    padreDe(Padre, OtroHemano),
    UnHermano \= OtroHemano.


% medioHermanos/2: Relaciona a dos personajes cuando estos comparten (exclusivamente) madre o padre.
medioHermanos(UnHermano, OtroHemano):-
    compartenMadre(UnHermano,OtroHemano),
    not(compartenPadre(UnHermano,OtroHemano)).

medioHermanos(UnHermano, OtroHemano):-
    compartenPadre(UnHermano,OtroHemano),
    not(compartenMadre(UnHermano,OtroHemano)).

% descendiente/2: Relaciona a dos personajes, en donde uno desciende del otro a través de una cantidad no predeterminada de generaciones. 
descendiente(Progenitor, Decendiente):-
    progenitor(Progenitor, Decendiente).

decendiente(Progenitor,Decendiente):-
    progenitor(Decendiente, OtroDecendiente),
    decendiente(Progenitor, OtroDecendiente).

progenitor(Progenitor,Decendiente):-
    padreDe(Progenitor, Decendiente).

progenitor(Progenitor,Decendiente):-
    madreDe(Progenitor, Decendiente).
