integrante(sophieTrio, sophie, violin).
integrante(sophieTrio, santi, guitarra).
integrante(vientosDelEste, lisa, saxo).
integrante(vientosDelEste, santi, voz).
integrante(vientosDelEste, santi, guitarra).
integrante(jazzmin, santi, bateria).

nivelQueTiene(sophie, violin, 5).
nivelQueTiene(santi, guitarra, 2).
nivelQueTiene(santi, voz, 3).
nivelQueTiene(santi, bateria, 4).
nivelQueTiene(lisa, saxo, 4).
nivelQueTiene(lore, violin, 4).
nivelQueTiene(luis, trompeta, 1).
nivelQueTiene(luis, contrabajo, 4).

instrumento(violin, melodico(cuerdas)).
instrumento(guitarra, armonico).
instrumento(bateria, ritmico).
instrumento(saxo, melodico(viento)).
instrumento(trompeta, melodico(viento)).
instrumento(contrabajo, armonico).
instrumento(bajo, armonico).
instrumento(piano, armonico).
instrumento(pandereta, ritmico).
instrumento(voz, melodico(vocal)).

%% Punto 1
tieneBuenaBase(Grupo):-
    integrante(Grupo,_, _),
    enLaBandaToca(Grupo, ritmico),
    enLaBandaToca(Grupo, armonico).

enLaBandaToca(Grupo, TipoDeInstrumento):-
    integrante(Grupo,_, UnInstrumento),
    instrumento(UnInstrumento, TipoDeInstrumento).

%% Punto 2
seDestaca(Integrante, Banda):-
    nivelConElQueToca(Banda, Integrante, NivelMaximo),
    forall((nivelConElQueToca(Banda, OtraIntegrante,Nivel), Integrante \= OtraIntegrante), NivelMaximo >= Nivel + 2).

nivelConElQueToca(Banda, Integrante, Nivel):-
    integrante(Banda, Integrante, UnInstrumento),
    nivelConElQueToca(Unintegrante, UnInstrumento, Nivel).

%% Punto 3
grupo(vientosDelEste, bigBand).
grupo(sophieTrio, formacionParticular([contrabajo, guitarra, violin])).
grupo(jazzmin, formacionParticular([bateria, bajo, trompeta, piano, guitarra])).

%% Punto 4 
hayCupo(Banda, Instrumento):-
    grupo(Banda, bigBand),
    instrumento(Instrumento, melodico(viento)).

hayCupo(Banda, Instrumento):-
    grupo(Banda, TipoDeBanda),
    forall(integrante(Banda, _, OtroInstrumento), Instrumento \= OtroInstrumento),
    elInstrumentoSirve(Instrumento, TipoDeBanda).

elInstrumentoSirve(Instrumento, formacionParticular(Instrumentos)):-
    member(Instrumento, Instrumentos).

elInstrumentoSirve(Instrumento, bigBand):-
    member(Instrumento, [bateria, bajo, piano]).


%% Punto 5
puedeIncorpararse(Persona, Instrumento, Grupo):-
    hayCupo(Grupo, Instrumento),
    nivelQueTiene(Persona, Instrumento, Nivel),
    not(integrante(Grupo, Persona, Instrumento)),
    grupo(Grupo, TipoDeGrupo),
    puedeEntrarSegunElNivel(NivelEsperado, TipoDeGrupo),
    Nivel >= NivelEsperado.


puedeEntrarSegunElNivel(1, bigBand).

puedeEntrarSegunElNivel(Nivel, formacionParticular(Instrumentos)):-
    length(Instrumentos, CantidadInstrumentos),
    Nivel is 7 - CantidadInstrumentos.


%Punto 6
seQuedoEnBanda(Persona):-
    nivelQueTiene(Persona,Instrumento,_),
    not(hayCupo(Persona, Instrumento)),
    not(integrante(_, Persona, Instrumento)).


%Punto 7
puedeTocar(Banda):-
    grupo(Banda, TipoDeBanda),
    cumpleNecesiDesMinimas(Banda, TipoDeBanda).

cumpleNecesiDesMinimas(Banda, bigBand):-
    tieneBuenaBase(Banda),
    findall(Viento, (integrante(Banda, _, Instrumento), instrumento(Instrumento, melodico(viento)) ), TodosLosVientos),
    length(TodosLosVientos, Cantidad),
    Cantidad >= 5.

cumpleNecesiDesMinimas(Banda, formacionParticular(Instrumentos)):-
    forall(member(Instrumento, Instrumentos), integrante(Banda, _, Instrumento)).


