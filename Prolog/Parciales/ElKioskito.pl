atiende(dodain, lunes, 9, 15).
atiende(dodain, miercoles, 9, 15).
atiende(dodain, viernes, 9, 15).

atiende(lucas, martes, 10, 20).

atiende(juanC, sabado, 18, 22).
atiende(juanC, domingo, 18, 22).

atiende(juanFdS, jueves, 10, 20).
atiende(juanFdS, viernes, 12, 20).

atiende(leoC, lunes, 14, 18).
atiende(leoC, miercoles, 14, 18).

atiende(martu, miercoles, 23, 24).


%atiende(Nombre, Dia, HorarioEntrada, HorarioSalida).
%Punto 1 
atiende(vale, Dia, HoraInicio, HoraFin) :-
    atiende(dodain, Dia, HoraInicio, HoraFin).

atiende(vale, Dia, HoraInicio, HoraFin) :-
    atiende(juanC, Dia, HoraInicio, HoraFin).

atiende(maiu, martes, 0, 8).
atiende(maiu, miercoles, 0, 8).

persona(Persona):-
    atiende(Persona,_,_,_).

%Punto 2 
%Como hacer para que en la cosnola no me muestre todos los casos o es lo mismo ? 
%Esto pasa cuando hago si preguntamos qué días a las 10 atiende vale, nos debe decir los lunes, miércoles y viernes.
%Para que solo aparezca lune smiercoles y viernes
quienAtiendeElKiosco(Persona ,Dia, Hora):-
    atiende(Persona, Dia, HoraInicio, HorarioSalida),
    between(HoraInicio, HorarioSalida, Hora). %Guia de lenguajes

%Punto 3
foreverAlone(Persona, Dia, Horario):-
    persona(Persona),
    not((quienAtiendeElKiosco(OtraPersona, Dia, Horario), not(Persona = OtraPersona))).

%Punto 4
posibilidadesAtencion(Dia, Personas):-
    atiende(Persona, Dia, _, _),
    %¿En la respuesta usa distinct como hago para safar de eso?
    findall(Persona, quienAtiendeElKiosco(Persona, Dia, _), PersonasPosibles), 
    combinar(PersonasPosibles, Personas).
  
  combinar([], []).
  combinar([Persona|PersonasPosibles], [Persona|Personas]):-
    combinar(PersonasPosibles, Personas).

  combinar([_|PersonasPosibles], Personas):-
    combinar(PersonasPosibles, Personas).

%Punto 5
venta(dodain, fecha(10, 8), [golosinas(1200), cigarrillos(jockey), golosinas(50)]).
venta(dodain, fecha(12, 8), [bebidas(si, 8), bebidas(no, 1), golosinas(10)]).
venta(martu, fecha(12, 8), [golosinas(1000), cigarrillos([chesterfield, colorado, parisiennes])]).
venta(lucas, fecha(11, 8), [golosinas(600)]).
venta(lucas, fecha(18, 8), [bebidas(no, 2), cigarrillos([derby])]).

esSuertuda(Persona):-
    venta(Persona, _, _),
    forall(venta(Persona,_,[Venta|_]),queVende(Venta)).

queVende(golosinas(Precio)):-
    Precio > 100.

queVende(cigarrillos(Marcas)) :-
    length(Marcas, CantidadDeMarcas),
    CantidadDeMarcas > 2.

queVende(bebidas(_, Cantidad)):-
    Cantidad > 5.

    


