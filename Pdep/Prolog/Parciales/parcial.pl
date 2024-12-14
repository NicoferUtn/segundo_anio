% persona(Nombre, edad, generoQueIdentifica).
persona(a,18,hetero).
% genero (Nombre, GeneroQueLeAtrae, EdadMinima, EdadMaxima).
genero(a, hetero, 18, 22).
% gustos(Nombre, [Gustos]).
gustos(a, [a,b,c,d,e]).
% disgustos(Nombre, [Disgustos])
disgustos(a,[f,g,h,i,j]).

tieneAlMenosCinco(Lista):-
    length(Lista, Cantidad),
    Cantidad >= 5.
    

esMenor(Persona):-
    persona(Persona,Anios,_),
    Anios < 18.

perfilIncompleto(Persona):-
    not(persona(Persona, _, _)),
    not(genero(Persona, _, _, _)),
    gustos(Persona, Gustos),
    not(tieneAlMenosCinco(Gustos)),
    disgustos(persona, Disgustos),
    not(tieneAlMenosCinco(Disgustos)).

%% -> Analisis <- %%

almaLibre(Persona):-
    genero(Persona, _,_,_),
    forall(genero(_,OtroGenero, _, _), genero(Persona, OtroGenero, _, _)).
    
aceptaPretendientes(Persona):-
    genero(Persona, _, EdadMinima, EdadMaxima),
    Edad is EdadMaxima - EdadMinima,
    Edad >= 30.

quiereLaHerencia(Persona):-
    persona(Persona, Edad, _),
    genero(Persona, _, EdadMinima,_),
    Edad + 30 =< EdadMinima.

esIndesiable(Persona):-
    persona(Persona, Edad, _),
    not(perteneceAlRangoEtarioDeAlguien(Edad, OtraPersona)).

perteneceAlRangoEtarioDeAlguien(Edad, OtraPersona):-
    genero(OtraPersona, _, EdadMinima, EdadMaxima).
    between(EdadMinima, EdadMaxima, Edad).

%% -> Matches <- %%
esPretedndiente(UnaPersona, Pretendiente):-
    persona(UnaPersona, Edad, Genero),
    perteneceAlRangoEtarioDeAlguien(Edad, Pretendiente),
    genero(Pretendiente, UnaPersona, _, _),
    tieneUnGustoEnComun(UnaPersona, Pretendiente),
    UnaPersona \= Pretendiente.

tieneUnGustoEnComun(UnaPersona, Pretendiente):-
    tieneUnGusto(UnaPersona, Gusto),
    tieneUnGusto(Pretendiente, Gusto).

tieneUnGusto(UnaPersona, Gusto):-
    gustos(UnaPersona, Gustos),
    member(Gustos, UnGusto).

hayMach(UnaPersona, Pretendiente):-
    esPretedndiente(UnaPersona, Pretendiente),
    esPretedndiente(Pretendiente, UnaPersona).

sonPretenedientesPeroNoHayMach(UnaPersona, OtraPersona):-
    esPretedndiente(UnaPersona, OtraPersona),
    not(hayMach(UnaPersona, OtraPersona)).

trianguloAmoroso(Persona1, Persona2, Persona3):-
    sonPretenedientesPeroNoHayMach(Persona1, Persona2),
    sonPretenedientesPeroNoHayMach(Persona2, Persona3),
    sonPretenedientesPeroNoHayMach(Persona3, Persona1).

sonElUnoParaElOtro(UnaPersona, OtraPersona):-
    hayMach(UnaPersona, OtraPersona),
    not(forall((gustos(UnaPersona, Gustos), member(Gustos, Gusto)), (disgustos(OtraPersona, Disgustos), member(Disgustos, Gustos)))).
    
%% -> Mensaje <- %%
indiceDeAmor(a, b, 0).
indiceDeAmor(a, b, 10).
indiceDeAmor(a, b, 10).
indiceDeAmor(b, a, 1).
indiceDeAmor(b, c, 5).
indiceDeAmor(a, c, 10).

sumaDeIndiceDeAmor(Persona, OtraPersona,Cantidad):-
    findall(Amor, indiceDeAmor(Persona, OtraPersona, Amor), ListaDeAmores),
    length(ListaDeAmores, CantidadDeMensajes),
    sumlist(ListaDeAmores, SumatoriaDeAmor),
    Cantidad is SumaDeIndiceDeAmor / CantidadDeMensajes.
    
    
desbalance(UnaPersona, OtraPersona):-
    sumaDeIndiceDeAmor(UnaPersona,OtraPersona, Cantidad),
    sumaDeIndiceDeAmor(OtraPersona, UnaPersona, OtraCantidad),
    Cantidad >= 2 * OtraCantidad.

ghosteado(UnaPersona, OtraPersona):-
    indiceDeAmor(UnaPersona, OtraPersona, _),
    not(indiceDeAmor(OtraPersona, UnaPersona, _)).
    
    
