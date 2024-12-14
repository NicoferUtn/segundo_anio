% Recorridos en GBA:
recorrido(17, gba(sur), mitre).
recorrido(24, gba(sur), belgrano).
recorrido(247, gba(sur), onsari).
recorrido(60, gba(norte), maipu).
recorrido(152, gba(norte), olivos).

% Recorridos en CABA:
recorrido(17, caba, santaFe).
recorrido(152, caba, santaFe).
recorrido(10, caba, santaFe).
recorrido(160, caba, medrano).
recorrido(24, caba, corrientes).

%% Punto 1
sePudenCombinar(UnaLina, OtraLinea):-
    recorrido(UnaLina, _, Calle),
    recorrido(OtraLinea, _, Calle),
    UnaLina \= OtraLinea.


%% Punto 2
perteneA(gba(_), buenosAires).
perteneA(caba, caba).

cruzaGeneralPaz(Linea):-
    recorrido(Linea, caba,_),
    recorrido(Linea, gba(_),_).

juridiccionDe(Linea, nacional):-
    cruzaGeneralPaz(Linea).

juridiccionDe(Linea, provincial(Provincia)):-
    recorrido(Linea, Zona, _),
    perteneA(Zona, Provincia),
    not(cruzaGeneralPaz(Linea)).


%% Punto 3
calleMasTransitada(Calle, Zona):-
    lineasQuePasanPorCalle(Calle, Zona,CantidadMaxima),
    forall((lineasQuePasanPorCalle(OtraCalle, Zona,Cantidad ), OtraCalle \= Calle), CantidadMaxima >= Cantidad).

lineasQuePasanPorCalle(Calle, Zona ,Cantidad):-
    recorrido(_, Zona, Calle),
    findall(Calle, recorrido(_, Zona, Calle), Calles),
    length(Calles, Cantidad).


%% Punto 4
callesDeTransoordos(Calle, Zona):-
    recorrido(_, Zona, Calle),
    sonDeJuridiccionNacional(Zona, Calle),
    lineasQuePasanPorCalle(Calle, Zona, Cantidad),
    Cantidad >= 3.

sonDeJuridiccionNacional(Zona, Calle):-
    forall(recorrido(Lina, Zona, Calle), juridiccionDe(Lina, nacional)).


%% PUnto 5
beneficios(pepito, particulares(gba(oeste))).
beneficios(juanita, boletoEstudiantil).
beneficios(marta, jubilada).
beneficios(marta, particulares(gba(sur))).
beneficios(marta, particulares(gba(caba))).

beneficioAlBoleto(boletoEstudiantil, _,50).
beneficioAlBoleto(particulares(Zona), Linea, 0):-
    recorrido(Linea, Zona, _).
beneficioAlBoleto(jubilada, Linea, ValorConBeneficio):-
    valorNormal(Linea, Valor),
    ValorConBeneficio is Valor / 2.


valorNormal(Linea, 500):-
    juridiccionDe(Lina, nacional).
valorNormal(Lina, 350):-
    juridiccionDe(Lina, provincial(Provincia)),
    Provincia \= buenosAires.

valorNormal(Linea, Valor):-
    juridiccionDe(Linea, provincial(buenosAires)),
    findall(Calle, recorrido(Linea, Calle, _), Calles),
    length(Calles, CantidadCalles),
    plus(Linea, Plus),
    Valor is (25*CantidadCalles) + Plus.

pasaPorDistintasZonas(Linea):-
    recorrido(Linea, gba(Zona), _),
    recorrido(Linea, gba(OtraZona), _),
    Zona \= OtraZona.

plus(Linea, 50):-
    pasaPorDistintasZonas(Linea).
plus(Linea, 0):-
    not(pasaPorDistintasZonas(Linea)).

    


    