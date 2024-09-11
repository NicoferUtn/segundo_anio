% guardia(Nombre)
guardia(bennett).
guardia(mendez).
guardia(george).

% prisionero(Nombre, Crimen)
prisionero(piper, narcotrafico([metanfetaminas])).
prisionero(alex, narcotrafico([heroina])).
prisionero(alex, homicidio(george)).
prisionero(red, homicidio(rusoMafioso)).
prisionero(suzanne, robo(450000)).
prisionero(suzanne, robo(250000)).
prisionero(dayanara, narcotrafico([heroina, opio])).
prisionero(dayanara, narcotrafico([metanfetaminas])).

controla(piper, alex).
controla(bennett, dayanara).


%Tipo de crimenes Homicidio Narcotrafico Robo

%Ej1 Dado el predicado controla/2:
controla(Guardia, Otro):- 
    prisioneroInversible(Otro),
    guardia(Guardia),
    not(controla(Otro, Guardia)).

prisioneroInversible(Prisionero) :-
    prisionero(Prisionero,_).

%Ej2 conflictoDeIntereses/2: relaciona a dos personas distintas (ya sean guardias o prisioneros) si no se controlan mutuamente y existe algún tercero al cual ambos controlan.
conflictoDeIntereses(UnaPersona, OtraPersona):-
    not(controla(UnaPersona, OtraPersona)),
    not(controla(OtraPersona, UnaPersona)),
    controla(UnaPersona,Otro),
    controla(OtraPersona, Otro),
    UnaPersona \= OtraPersona.

%Ej 3 peligroso/1: Se cumple para un preso que sólo cometió crímenes graves.
% * Un robo nunca es grave.
% * Un homicidio siempre es grave.
% * Un delito de narcotráfico es grave cuando incluye al menos 5 drogas a la vez, o incluye metanfetaminas.

peligroso(Prisionero):-
    prisioneroInversible(Prisionero),
    forall(prisionero(Prisionero, Crimen), grave(Crimen)).
    
grave(homicidio(_)).

grave(narcotrafico(Drogas)):-
    length(Drogas, TotalDeDrogas),
    TotalDeDrogas >= 5,
    member(metanfetaminas, Drogas).

%Ej 4 ladronDeGuanteBlanco/1: Aplica a un prisionero si sólo cometió robos y todos fueron por más de $100.000.

monto(robo(Monto), Monto).

ladronDeGuanteBlanco(Prisionero):-
    prisioneroInversible(Prisionero),
    not(peligroso(Prisionero)),
    forall(prisionero(Prisionero,Crimen), ((monto(Crimen,Monto)), Monto > 100000)).

%Ej 5 condena/2: Relaciona a un prisionero con la cantidad de años de condena que debe cumplir. Esto se calcula como la suma de los años que le aporte cada crimen cometido, que se obtienen de la siguiente forma:
% * La cantidad de dinero robado dividido 10.000.
% * 7 años por cada homicidio cometido, más 2 años extra si la víctima era un guardia.
% * 2 años por cada droga que haya traficado.

condena(Prisionero, Anios):-
    prisioneroInversible(Prisionero),
    findall(Anio, (prisionero(Prisionero, Crimen), condenaPorCrimenes(Crimen, Anio)), Anios),
    sum_list(Anio, Condena).

condenaPorCrimenes(robo(Montos), Anio):-
    Anios is TotalDeDinero / 10000.

condenaPorCrimenes(homicidio(Nombres), 5):-
    not(guardia(Nombre)).

condenaPorCrimenes(homicidio(Nombres), 7):-
    guardia(Nombre).

condenaPorCrimenes(narcotrafico(Drogas), Anios):-
    length(Drogas, CantidadDeDrogas),
    Anios is CantidadDeDrogas * 2.

%Ej 6 capoDiTutiLiCapi/1: Se dice que un preso es el capo de todos los capos cuando nadie lo controla, pero todas las personas 
%de la cárcel (guardias o prisioneros) son controlados por él, o por alguien a quien él controla (directa o indirectamente).

capoDiTutiLiCapi(Prisionero):-
    prisioneroInversible(Prisionero),
    not(controla(_, Prisionero)),
    forall(persona(Persona), controlaDirectamenteOIndirectamente(Prisionero, Persona)).

persona(Persona):-
    prisionero(Persona, _).

persona(Persona):-
    guardia(Persona).

controlaDirectamenteOIndirectamente(Prisionero, Persona):-
    controla(Prisionero, Persona).

controlaDirectamenteOIndirectamente(Prisionero, Persona):-
    controla(Prisionero, OtraPersona),
    controlaDirectamenteOIndirectamente(OtraPersona, Persona).