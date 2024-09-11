rata(remy, gusteaus).
rata(emile, bar).
rata(django, pizzeria).

cocina(linguini, ratatouille, 3).
cocina(linguini, sopa, 5).
cocina(colette, salmonAsado, 9).
cocina(horst, ensaladaRusa, 8).

trabajaEn(gusteaus, linguini).
trabajaEn(gusteaus, colette).
trabajaEn(gusteaus, skinner).
trabajaEn(gusteaus, horst).
trabajaEn(cafeDes2Moulins, amelie).

%%% -> Punto 1 <- %%%
inpeccionSatifactoria(Restaurante):-
    trabajaEn(Restaurante, _),
    not(rata(Rata, Restaurante)).

%%% -> Punto 2 <- %%%
chef(Chef, Restaurante):-
    trabajaEn(Restaurante, Chef),
    cocina(Chef, _, _).

%%% -> Punto 3 <- %%%
chefcito(Rata):-
    rata(Rata, Restaurante),
    trabajaEn(Restaurante, linguini).

%%% -> Punto 4 <- %%%
conicaBien(Chef, Plato):-
    cocina(Chef, Plato, Experiencia),
    Experiencia > 7.

conicaBien(remy).

%%% -> Punto 5 <- %%%
encargado(Chef, Plato, Restaurante):-
    quePlatoSeCosina(Chef, Plato, Restaurante, UnaExperiencia),
    forall((quePlatoSeCosina(OtroChef, Plato, Restaurante, OtraExperiencia), Chef \= OtroChef), UnaExperiencia >= OtraExperiencia).

quePlatoSeCosina(Chef, Plato, Restaurante, Experiencia):-
    trabajaEn(Restaurante, Chef),
    cocina(Chef, Plato, Experiencia).

%%% -> Punto 6 <- %%%
plato(ensaladaRusa, entrada([papa, zanahoria, arvejas, huevo, mayonesa])).
plato(bifeDeChorizo, principal(pure, 25)).
plato(frutillasConCrema, postre(265)).

saludable(Plato):-
    plato(Plato, TipoDePlato),
    cuantasCaloriasTiene(TipoDePlato, TotalDeCalorias),
    TotalDeCalorias < 75.


cuantasCaloriasTiene(entrada(Ingredientes), Calorias) :- length(Ingredientes, CantidadIngredientes), Calorias is 15 * CantidadIngredientes.
cuantasCaloriasTiene(postre(Calorias), Calorias).
cuantasCaloriasTiene(principal(ensalada, _), 0).
cuantasCaloriasTiene(principal(pure, MinutoDeCoccion), Calorias) :- sumaDeCalorias(MinutosDeCoccion, 20, Calorias).
cuantasCaloriasTiene(principal(papasFritas, MinutoDeCoccion), Calorias) :- sumaDeCalorias(MinutosDeCoccion, 50, Calorias).

sumaDeCalorias(MinutosDeCoccion, CaloriasDeGuarnicion, CaloriasTotales) :-
    CaloriasTotales is (MinutoDeCoccion * 5) + CaloriasDeGuarnicion.


%%% -> Punto 7 <- %%%
criticaPositiva(Critico, Restaurante):-
    
    
    
