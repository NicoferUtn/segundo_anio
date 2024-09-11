
mago(harry, mestiza, corajudo).
mago(harry, mestiza, amistoso).
mago(harry, mestiza, orgulloso).
mago(harry, mestiza, inteligente).

%mago(harry, mestiza, caracterisitcas(corajudo, amistoso, orgulloso, inteligente)).

mago(draco, pura, inteligente).
mago(draco, pura, orgulloso).
mago(draco, mestiza, amistoso).

%mago(draco, pura, caracterisitcas(inteligente, orgulloso)).

mago(hermione, impura, inteligente).
mago(hermione, impura, orgulloso).
mago(hermione, impura, responsable).

%mago(hermione, impura, caracterisitcas(inteligente, orgulloso, responsable)).

odio(harry, slytherin).
odio(draco, hufflepuff).

%casa(Nombre, caracterisitcas(Tipo))
casa(gryffindor, corajudo).
casa(slytherin, orgulloso).
casa(slytherin, inteligente).
casa(ravenclaw, inteligente).
casa(ravenclaw, responsable).
casa(hufflepuff, amistoso).

magoInversible(Mago):-
    mago(Mago,_,_).

casaInversible(Casa):-
    casa(Casa, _).


esImpuro(Mago):-
    mago(Mago, impura, _).

%Punto 1
permiteCasa(Mago, Casa):-
    magoInversible(Mago),
    not(esImpuro(Mago)),
    casaInversible(Casa).

permiteCasa(Mago, Casa):-
    magoInversible(Mago),
    casaInversible(Casa),
    Casa \= slytherin.


%Punto 2
caracterApropiado(Mago, Casa):-
    magoInversible(Mago),
    casaInversible(Casa),
    cumpleParaEntrarACasa(Mago, Casa).


cumpleParaEntrarACasa(Mago, Casa):-
    forall(casa(Casa, Caracterisitca), mago(Mago, _, Caracterisitca)).


%Putno 3
quiereQuedarEnLaCasa(Mago, Casa):-
    caracterApropiado(Mago, Casa),
    not(odio(Mago, Casa)).

quiereQuedarEnLaCasa(hermione, gryffindor).

%Punto 4
cadenaDeAmistad(Magos):-
    magoInversible(Mago),
    findall(Mago, mago(Mago,_, amistoso), Magos).


