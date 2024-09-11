
%%% -> Base de Conocimientos <- %%%

empleado(juani, desarrollador(senior)).
empleado(emi, devOps).
empleado(lucas, desarrollador(junior)).
empleado(tomi, desarrollador(semiSenior)).
empleado(dante, desarrollador(semiSenior)).
empleado(manu, administradoresdeBBDD).
empleado(gus, administradoresdeBBDD).

tareaAsignadas(comoalumnoquieroprogramarenHaskellconlospies, lucas).
tareaAsignadas(comodocentequieroactualizaraWollokTS, juani).
tareaAsignadas(reescribirLinuxenProlog, emi).
tareaAsignadas(paricales, gus).
tareaAsignadas(comoalumnoquierorendirelparcialdefuncional, tomi).
tareaAsignadas(comoalumnoquierorendirelparcialdelogico, lucas).
tareaAsignadas(comodocentequeirocambiarelTP4delogico, dante).
tareaAsignadas(pensarconsignasparaeldesafiocafeconleche, juani).
tareaAsignadas(comodocentequieroternerunrepositorioparalosdesafiso, emi).

tarea(comoalumnoquieroprogramarenHaskellconlospies, enProceso ,historiadeusuario(5)).
tarea(comodocentequieroactualizaraWollokTS, terminada, historiadeusuario(3)).
tarea(chatGPTsepresentoarendirunparcial,paraHacer, bug).
tarea(reescribirLinuxenProlog, paraHacer, spike(infrastrucutra)).
tarea(paricales, enProceso, epica).
tarea(comoalumnoquierorendirelparcialdefuncional, terminada, historiadeusuario(4)).
tarea(comoalumnoquierorendirelparcialdelogico, enProceso, bug).
tarea(comoalumnoquierorendirelparcialdeobjetos, paraHacer, historiadeusuario(6)).
tarea(elegirundominioparaelparcialdeobjetos, paraHacer, spike(bibliotecas)).
tarea(estudiarellibrogamma, paraHacer, spike(bibliotecas)).
tarea(comodocentequeirocambiarelTP4delogico, enProceso, historiadeusuario(2)).
tarea(pensarconsignasparaeldesafiocafeconleche, enProceso, spike(bibliotecas)).
tarea(comodocentequieroternerunrepositorioparalosdesafiso, paraHacer, historiadeusuario(1)).


%%% -> Parte 1 <- %%%
paraHacer(Tarea):-
    tarea(Tarea, _, _),
    not(tareaAsignadas(Tarea, _)).

dificultadPorTarea(Empleado, Tarea, Dificultad):-
    empleado(Empleado, Rango),
    tareaAsignadas(Tarea, Empleado),
    tarea(Tarea, _, Caracterisitas),
    queDificultadTieneLatarea(Caracterisitas, Rango, Dificultad).

%Caso historiaDeUsuario
queDificultadTieneLatarea(historiadeusuario(Tiempo), _, facil):- between(1, 3, Tiempo).
queDificultadTieneLatarea(historiadeusuario(4), _, normal).
queDificultadTieneLatarea(historiadeusuario(Tiempo), _, dificil):- Tiempo >= 5.

%Caso bug
queDificultadTieneLatarea(bug, desarrollador(senior), normal).
queDificultadTieneLatarea(bug, desarrollador(TipoDeDesarrollador), dificil):- TipoDeDesarrollador \= senior.

%Caso spike
queDificultadTieneLatarea(Caracterisitas, Rango, dificil):-
    not(dificultadCasoSpike(Caracterisitas, Rango)).

queDificultadTieneLatarea(Caracterisitas, Rango, facil):-
    dificultadCasoSpike(Caracterisitas, Rango).

dificultadCasoSpike(spike(infrastrucutra), devOps).
dificultadCasoSpike(spike(bibliotecas), desarrollador(_)).
dificultadCasoSpike(spike(triggers), administradoresdeBBDD).

%Caso epica 
queDificultadTieneLatarea(epica,_, dificil).



puedeTomarUnaTarea(Empleado, Tarea):-
    paraHacer(Tarea),
    empleado(Empleado, _),
    not(dificultadPorTarea(Empleado, Tarea, dificil)).

%%% -> Parte 2 <- %%%
squad(hooligans, juani).
squad(hooligans, emi).
squad(hooligans, tomi).
squad(isotopos, dante).
squad(isotopos, manu).
squad(cools, lucas).
squad(cools, gus).

puntoTotales(Squad, Puntos):-
    squad(Squad, Empleado),
    findall(Horas, horasPorTarea(Empleadod, Horas), TotalDeHoras),
    sumlist(TotalDeHoras, Puntos).

horasPorTarea(Empleado, Horas):-
    tareaAsignadas(Tarea, Empleado), 
    tarea(Tarea,_ ,historiaDeUsuario(Horas)).

tieneTrabajo(Esquad):-
    squad(Squad, _),
    forall(squad(Squad, Empleado), tareaAsignadas(_, Empleado)).

elMasLaburador(Squad) :-
    puntoTotales(Squad, PuntajeMaximo),
    forall(squad(OtraSquad, _), menorPuntaje(OtraSquad, PuntajeMaximo)).

menorPuntaje(OtraSquad, PuntajeMaximo) :-
    puntoTotales(OtraSquad, OtroPuntaje),
    OtroPuntaje =< PuntajeMaximo.

%%% -> Parte 3 <- %%%
subtareaDe(parciales, comoAlumnoQuieroRendirElParcialDeFuncional).
subtareaDe(parciales, comoAlumnoQuieroRendirElParcialDeLogico).
subtareaDe(parciales, comoAlumnoQuieroRendirElParcialDeObjetos).
subtareaDe(comoAlumnoQuieroRendirElParcialDeObjetos, elegirUnDominioParaElParcialDeObjetos).
subtareaDe(comoAlumnoQuieroRendirElParcialDeObjetos, estudiarElLibroGamma).
subtareaDe(pensarConsignasParaElDesafioCafeConLeche, comoDocenteQuieroTenerUnRepoParaDesafios).

    
numeroDeSubtareasDe(TareaMadre, TotalDeSubtareas) :-
    tarea(TareaMadre, _, _),
    findall(Subtarea, tareaMadreDe(TareaMadre, Subtarea), Subtareas),
    length(Subtareas, TotalDeSubtareas).

tareaMadreDe(Tarea, Subtarea) :-
    subtareaDe(Tarea, Subtarea).

tareaMadreDe(Tarea, Subtarea) :-
    subtareaDe(Tarea, OtraSubtarea),
    tareaMadreDe(OtraSubtarea, Subtarea).