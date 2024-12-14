%  Gbra zona sur || norte || oeste || este

% Recorridos en GBA:
recorrido(17, gba(sur), mitre).
recorrido(24, gba(sur), belgrano).
recorrido(247, gba(sur), onsari).
recorrido(60, gba(norte), maipu).
recorrido(152 , gba(norte), olivos).

% Recorridos en CABA:
recorrido(17, caba, santaFe).
recorrido(152, caba, santaFe).
recorrido(10, caba, santaFe).
recorrido(160, caba, medrano).
recorrido(24, caba, corrientes).

linea(Linea):-
    recorrido(Linea, _, _).

% Punto 1
puedenCombinarce(UnaLinea, OtraLinea) :-
    recorrido(UnaLinea, Zona, Calle),
    recorrido(OtraLinea, Zona, Calle),
    UnaLinea \= OtraLinea.

% Punto 2
cruzaGralPaz(Linea):-
    recorrido(Linea, caba, _),
    recorrido(Linea, gba(_), _).

perteneceA(caba, caba).
perteneceA(gba(_), buenosAires).

jurisdiccion(Linea, nacional):-
    cruzaGralPaz(Linea).

jurisdiccion(Linea, provincial(Provincia)):-
    recorrido(Linea, Zona, _),
    perteneceA(Zona, Provincia),
    not(cruzaGralPaz(Linea)).

% Punto 3
calleMasTransitada(Calle, Zona):- 
    lineasQuePasanPor(UnaCantidad, Calle, Zona),
    forall((recorrido(_, Zona, OtraCalle), OtraCalle \= Calle , lineasQuePasanPor(OtraCantidad, OtraCalle, Zona)), UnaCantidad >= OtraCantidad).
    

lineasQuePasanPor(UnaCantidad, Calle, Zona):-
    recorrido(_, Zona, Calle),
    findall(Calle, recorrido(_, Zona, Calle) , CalleTotales),
    length(CalleTotales, UnaCantidad).
    
% Punto 4
callesDeJuridiccionNacional(Calle, Zona):-
    recorrido(_, Zona, Calle),
    forall((recorrido(Linea, Zona, Calle), jurisdiccion(Linea, nacional)), lineasQuePasanPor(Cantidad, Calle, Zona)),
    Cantidad >= 3.
    
% Punto 5
pasaPorDistintasZonas(Linea):-
    recorrido(Linea, gba(Zona), _),
    recorrido(Linea, gba(OtraZona), _),
    Zona \= OtraZona.

plus(Linea, 50):-
    pasaPorDistintasZonas(Linea).
plus(Linea, 0):-
    not(pasaPorDistintasZonas(Linea)).

valorNormal(Linea, 500):-
    jurisdiccion(Linea, nacional).
valorNormal(Linea, 350):-
    jurisdiccion(Linea, provincial(caba)).
valorNormal(Linea, Valor):-
    jurisdiccion(Linea, provincial(buenosAires)),
    findall(Calle, recorrido(Linea, Calle, _), Calles),
    length(Calles, CantidadCalles),
    plus(Linea, Plus),
    Valor is (25*CantidadCalles) + Plus.

beneficiario(pepito, personalCasaParticular(gba(oeste))).
beneficiario(juanita, estudiantil).
beneficiario(marta, jubilado).
beneficiario(marta, personalCasaParticular(caba)).
beneficiario(marta, personalCasaParticular(gba(sur))).

beneficio(estudiantil, _, 50).
beneficio(personalCasaParticular(Zona), Linea, 0):-
    recorrido(Linea, Zona, _).

beneficio(jubilado, Linea, ValorConBeneficio):-
    valorNormal(Linea, ValorNormal),
    ValorConBeneficio is ValorNormal.

posiblesBeneficios(Persona, Linea, ValorConBeneficio):-
    beneficiario(Persona, Beneficio),
    beneficio(Beneficio, Linea, ValorConBeneficio).

costo(Persona, Linea, CostoFinal):-
    beneficiario(Persona, _),
    recorrido(Linea, _, _),
    posiblesBeneficios(Persona, Linea, CostoFinal),
    forall((posiblesBeneficios(Persona, Linea, OtroValorBeneficiado), OtroValorBeneficiado \= CostoFinal), CostoFinal < OtroValorBeneficiado).

costo(Persona, Linea, ValorNormal):-
   persona(Persona),
   valorNormal(Linea, ValorNormal),
   not(beneficiario(Persona, _)).
   
persona(pepito).
persona(juanita).
persona(tito).
persona(marta).


    