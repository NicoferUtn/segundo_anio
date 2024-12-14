% Acá va el código


%%% -> Registros <- %%%
persona(personaA, 18, heterosexual).
persona(personaB, 87, homosexual).
persona(personaC, 31, pansexual). 

pretendientes(personaA, rangoDeEdades(18, 53)).
pretendientes(personaB, rangoDeEdades(58, 100)).
pretendientes(personaC, rangoDeEdades(18, 37)).

generosQueLeInteresan(personaA, heterosexual).
generosQueLeInteresan(personaA, homosexual).
generosQueLeInteresan(personaA, pansexual).
generosQueLeInteresan(personaA, bisexual).
generosQueLeInteresan(personaB, homosexual).
generosQueLeInteresan(personaB, bisexual).
generosQueLeInteresan(personaC, pansexual).
generosQueLeInteresan(personaC, heterosexual).

gustos(personaA, [cocinar, jugarALaPlay, cantar, leer, escribir]).
gustos(personaB, [dormir]).
gustos(personaC, [cocinar, jugarAlFutbol, habalr, leer, escribir]).

queleDisgustan(personaA, [lavar, limpiar, dormir, jugarALaPC, jugarAHandball]).
queleDisgustan(personaB, [lavar, limpiar, dormir, jugarALaPC, jugarAHandball]).
queleDisgustan(personaC, [lavar, limpiar, dormir, jugarALaPC, jugarAHandball]).


%EstaPersonaPuedeEstarEnLaAPP
unaPersona(Persona):-
    persona(Persona, _, _).

cumpleLosGustosYDisgustoNecesarios(Gustos):-
    length(Gustos, CantidadDeGustos),
    CantidadDeGustos >= 5.

esMayorDeEdad(Persona):-
    persona(Persona, Edad, _),
    Edad >= 18.

estaPersonaCumpleLosRequisitosParaLaAPP(Persona):-
    gustos(Persona, Gustos),
    cumpleLosGustosYDisgustoNecesarios(Gustos),
    queleDisgustan(Persona, CantidadDeDisgustos),
    cumpleLosGustosYDisgustoNecesarios(CantidadDeDisgustos),
    esMayorDeEdad(Persona),
    generosQueLeInteresan(Persona, _),
    pretendientes(Persona, rangoDeEdades(_, _)).

%%% -> Analisis <- %%%
almaLibre(Persona):-
    unaPersona(Persona),
    forall((persona(OtraPersona, _, Genero), Persona \= OtraPersona), generosQueLeInteresan(Persona, Genero)).


cualeEsElRangoDeEdades(Persona, Rango):-
    pretendientes(Persona, rangoDeEdades(EdadMinima, EdadMaxima)),
    Rango is EdadMaxima - EdadMinima.


aceptaPretendientesEnUnragoDe30(Persona):-
    cualeEsElRangoDeEdades(Persona, RangoDeEdades),
    RangoDeEdades =< 30.


quiereLaHerencia(Persona):-
    cualeEsElRangoDeEdades(Persona, RangoDeEdades),
    RangoDeEdades > 30.

entraEnElRangoEtario(Edad, Pretendientes):-
    pretendientes(Pretendientes, rangoDeEdades(EdadMinima, EdadMaxima)),
    between(EdadMinima, EdadMaxima, Edad).

esIndesiable(Persona):-
    unaPersona(Persona),
    not(pretenedientes(Persona, _)).

%%% -> Matches <- %%%
tieneUnGustosEnComun(UnaPersona, OtraPersona):-
    gustos(UnaPersona, GustosDeUnaPersona),
    member(UnGusto, GustosDeUnaPersona),
    gustos(OtraPersona, OtrosGustos),
    member(UnGusto, OtrosGustos).
    
pretenedientes(Persona, Pretendientes):-
    persona(Persona, Edad, Genero),
    entraEnElRangoEtario(Edad, Pretendientes),
    tieneUnGustosEnComun(Persona, Pretendientes),
    tieneUnGustosEnComun(Pretendientes, Persona),
    generosQueLeInteresan(Pretendientes, Genero),
    Persona \= Pretendientes.


hayMach(UnaPersona, OtraPersona):-
    pretenedientes(UnaPersona, OtraPersona),
    pretenedientes(OtraPersona, UnaPersona).

sonPretenedientesPeroNoHayMach(UnaPersona, OtraPersona):-
    pretendientes(UnaPersona, OtraPersona),
    not(hayMach(UnaPersona, OtraPersona)).


trianguloAmoroso(PrimeraPersona, SeguandaPersona, TerceraPersona):-
    sonPretenedientesPeroNoHayMach(PrimeraPersona, SeguandaPersona),
    sonPretenedientesPeroNoHayMach(SeguandaPersona, TerceraPersona),
    sonPretenedientesPeroNoHayMach(TerceraPersona, PrimeraPersona).

unoParaElOtro(UnaPersona, OtraPersona):-
    hayMach(UnaPersona, OtraPersona),
    forall((gustos(UnaPersona, Gustos), member(UnGusto, Gustos)), (queleDisgustan(OtraPersona, Disgustos), member(UnGusto, Disgustos))).
    
%%% -> Mensajes <- %%%
indiceDeAmor(personaA, personaB, 0).
indiceDeAmor(personaA, personaB, 10).
indiceDeAmor(personaA, personaB, 10).
indiceDeAmor(personaB, personaA, 1).
indiceDeAmor(personaB, personaC, 5).
indiceDeAmor(personaA, personC, 20).

cantidadDeIndiceDeAmor(UnaPersona, OtraPersona, SumaTotal):-
    findall(UnIndiceDeAmor, indiceDeAmor(UnaPersona, OtraPersona, UnIndiceDeAmor), TodosLosIndicesDeAmor),
    sumlist(TodosLosIndicesDeAmor, SumaTotal).

cualEsElIndiceDeAmor(UnaPersona, OtraPersona, IndiceDeAmor):-
    indiceDeAmor(UnaPersona, OtraPersona, _),
    cantidadDeIndiceDeAmor(UnaPersona, OtraPersona, IndiceDeAmor).

tieneDesbalanceElPromedio(CantidadTotalDeIndiceDeAmor, UnIndice, OtroIndice):-
    promedioDeIndice(UnIndice, CantidadTotalDeIndiceDeAmor, UnPromedio),
    promedioDeIndice(OtroIndice, CantidadTotalDeIndiceDeAmor, OtroPromedio),
    tieneDesbalance(UnPromedio, OtroPromedio),
    tieneDesbalance(OtroPromedio, UnPromedio).

promedioDeIndice(UnaCantidadDeIndiceDeAmor, CantidadTotalDeIndiceDeAmor, Promedio):-
    Promedio is UnaCantidadDeIndiceDeAmor / CantidadTotalDeIndiceDeAmor.

tieneDesbalance(UnPromedio, OtroPromedio):-
    UnPromedio > (2 * OtroPromedio).


desbalance(UnaPersona, OtraPersona):-
    cualEsElIndiceDeAmor(UnaPersona, OtraPersona, UnIndiceDeAmor),
    cualEsElIndiceDeAmor(OtraPersona, UnaPersona, OtroIndiceDeAmor),
    CantidadTotalDeIndiceDeAmor is UnIndiceDeAmor + OtroIndiceDeAmor,
    tieneDesbalanceElPromedio(CantidadTotalDeIndiceDeAmor, UnIndiceDeAmor, OtroIndiceDeAmor).

estaGhosteado(UnaPersona, OtraPersona):-
    indiceDeAmor(UnaPersona, OtraPersona, _),
    not(indiceDeAmor(OtraPersona, UnaPersona, _)).

%%% Nicolas Feranandez Ruoff