--import Lib.hs
------- Por ahora el import Lib no anda
import Text.Show.Functions
import Data.List(genericLength)

--Yo extraño mi ciudad, las luces de mi ciudad...” decía la canción. Es el momento
--de modelar las ciudades del pintoresco país de Haskellandia, de las que nos interesa
--conocer su nombre, el año de fundación, las atracciones principales (como “Obelisco”,
--Pan de Azúcar”, “El Gorosito”, etc.) y su costo de vida.


-- Estructura Ciudad
data Ciudad = Ciudad {
    nombre :: String,
    añoFundacion :: Integer,
    atracciones :: [Atraccion],
    costoDeVida :: Float
}deriving (Show)

-- Estructura Anio
data Año = Año {
     año :: Integer,
     eventos :: [Evento]
}deriving (Show)

type Atraccion = String

type Evento = Ciudad -> Ciudad
--Ciudades ejemplo

azul = Ciudad "Azul" 1832 ["Teatro Español" , "Parque Municipal Sarmiento" , "Cstanera Cacique Catriel"] 190
caletaOlivia = Ciudad "Caleta Olivia" 1901 ["El Gorosito" , "Faro Costanera"] 120
baradero = Ciudad "Baradero" 1615 ["Parque del Este" , "Museo Alejandro Barbich"] 150
nullish = Ciudad "Nullish" 1800 [] 140

año2015 = Año 2015 []
año2021 = Año 2021 [ciudadEnCrisis , agregarNuevaAtraccion"playa"]
año2022 = Año 2022 [ciudadEnCrisis , ciudadARemodelar 5, ciudadAReevaluar 7]
año2023 = Año 2023 [agregarNuevaAtraccion "Parque", ciudadARemodelar 20 ,  ciudadARemodelar 10]

años = [año2021 , año2022 , año2023]

------------------------------------
-- Punto 1 -- Valor de una ciudad --
------------------------------------ 

valorDeUnaCiudad :: Ciudad -> Float
valorDeUnaCiudad (Ciudad nombre añoFundacion atracciones costoDeVida)
    | añoFundacion < 1800 = fromIntegral (5 * (1800 - añoFundacion))
    | null atracciones = 2 * costoDeVida
    | otherwise =  3 * costoDeVida

------------------------------------    
-- Punto 2 -- Atracciones Copadas --
------------------------------------

esVocal :: Char -> Bool
esVocal letra =  letra `elem` "aeiouAEIOU"
 
algunaAtraccionCopada :: Ciudad -> Bool
algunaAtraccionCopada ciudad = any atraccionCopada (atracciones ciudad)

atraccionCopada :: String -> Bool
atraccionCopada (x:_) = esVocal x
atraccionCopada _ = False

-------------------------------
-- Punto 2.1 --Ciudad Sobria --
-------------------------------

esCiudadSobria :: Int -> Ciudad -> Bool
esCiudadSobria cantidadLetras unaCiudad = all (tieneMasLetras cantidadLetras) (atracciones unaCiudad)

tieneMasLetras :: Int -> String -> Bool
tieneMasLetras cantidadLetras = ( > cantidadLetras) . length 

-----------------------------------------
-- Punto 2.2 -- Ciudad con nombre raro --
-----------------------------------------

ciudadNombreRaro :: Ciudad -> Bool
ciudadNombreRaro = (<5) . genericLength . nombre

------------------------
-- Punto 3 -- Eventos --
------------------------

agregarNuevaAtraccion :: Atraccion -> Ciudad -> Ciudad
agregarNuevaAtraccion nuevaAtraccion = modificarCostoDeVida (* 1.20) . modificarAtracciones (nuevaAtraccion :)

-- Usamos descartarUltimaAtraccion, que encapsula reverse's y un drop (antes habíamos usado un init, pero rompía con una lista de atracciones vacía)
ciudadEnCrisis :: Ciudad -> Ciudad
ciudadEnCrisis = modificarCostoDeVida (*0.90) . modificarAtracciones (descartarUltimaAtraccion) 


ciudadARemodelar :: Float -> Ciudad -> Ciudad
ciudadARemodelar porcentajeCostoDeVida = modificarCostoDeVida (* transformarPorcentaje porcentajeCostoDeVida) . modificarNombre 


ciudadAReevaluar :: Int -> Ciudad -> Ciudad
ciudadAReevaluar cantidadLetras unaCiudad 
    | esCiudadSobria cantidadLetras unaCiudad = modificarCostoDeVida (* 1.10) unaCiudad 
    | otherwise = modificarCostoDeVida (subtract 3) unaCiudad



--------------------------Funciones Auxiliares----------------------------------------

modificarCostoDeVida :: (Float -> Float) -> Ciudad -> Ciudad
modificarCostoDeVida modificador unaCiudad = unaCiudad {costoDeVida = modificador (costoDeVida unaCiudad)}

modificarNombre :: Ciudad -> Ciudad
modificarNombre unaCiudad = unaCiudad {nombre = "New " ++ nombre unaCiudad}

modificarAtracciones :: ([Atraccion] -> [Atraccion]) -> Ciudad -> Ciudad
modificarAtracciones modificador unaCiudad = unaCiudad {atracciones = modificador (atracciones unaCiudad)}

transformarPorcentaje :: Float -> Float
transformarPorcentaje porcentajeCostoDeVida = porcentajeCostoDeVida / 100 + 1

descartarUltimaAtraccion :: [Atraccion] -> [Atraccion]
descartarUltimaAtraccion = reverse . (drop 1) . reverse

------------------------------------------------------------------------------------------------

-------------
-- Punto 4 --
-------------

detonarCiudad :: Ciudad -> Ciudad
detonarCiudad = ciudadAReevaluar 5 . ciudadEnCrisis . ciudadARemodelar 10 . agregarNuevaAtraccion "Atraccionnro1"
{-Para que una ciudad pase por estos cambios se puede llamar por la consola de ghci
"detonarCiudad <Ciudad>" donde <Ciudad> es el la ciudad a la que se le quieren aplicar
estas funciones 
Tambien es posible escribir directamente "ciudadAReevaluar <x> . ciudadEnCrisis . ciudadARemodelar <y> . agregarNuevaAtraccion <z> $ <ciudad>"
Con <x> un Int, <y> un Float, <z> un String y <ciudad> la ciudad en cuestion
Ademas, es posible utilizar la función del punto 5 pasarPorListaDeEventos para, en lugar
de componer funciones, hacer una lista de las mismas de la siguiente manera
"pasarPorListaDeEventos [ciudadAReevaluar <x>, ciudadEnCrisis, ciudadARemodelar <y>, agregarNuevaAtraccion <z>] <ciudad>"-}
detonarCiudadPersonalizada :: Int -> Float -> String -> Ciudad -> Ciudad
detonarCiudadPersonalizada critReevaluacion tasaRemodelacion nombreAtraccion = ciudadAReevaluar critReevaluacion . ciudadEnCrisis  . ciudadARemodelar tasaRemodelacion. agregarNuevaAtraccion nombreAtraccion 
{-O tambien se puede llamar esta funcion "detonarCiudadPersonalizada" para elegir las variables x, y, z anteriores mas facilmente
utilizando "detonarCiudadPersonalizada <x> <y> <z> <ciudad>"-}

---------------
-- PUNTO 5.1 --
---------------

--Aplica todos los eventos de un año a una ciudad
ciudadLuegoDeAños :: Año -> Ciudad -> Ciudad
ciudadLuegoDeAños unAño = pasarPorEventos (eventos unAño)

--Separa la lista de evento de un año para luego aplicarlas a una ciudad
pasarPorEventos :: [Evento] -> Ciudad -> Ciudad
pasarPorEventos = flip $ foldl aplicarEvento 

--Aplica un evento a una ciudad
aplicarEvento :: Ciudad -> Evento -> Ciudad
aplicarEvento unaCiudad unEvento = unEvento unaCiudad

---------------
-- PUNTO 5.2 --
---------------

-- Un criterio es una función que toma una Ciudad y devuelve un elemento ordenable/comparable
type Criterio a = Ciudad -> a

--Devuelve si una Ciudad, luego de aplicarle un evento, aumento en cierto criterio de comparacion
terminaMejorSegun :: (Ord a) => Criterio a -> Ciudad -> Evento -> Bool
terminaMejorSegun criterioComparacion unaCiudad unEvento = criterioComparacion (unEvento unaCiudad) > criterioComparacion unaCiudad

---------------
-- PUNTO 5.3 --
---------------

--Dado un año y una ciudad, aplica todos los eventos del año que incrementan el costo de vida a la ciudad
aSubirCostoDeVida :: Año -> Ciudad -> Ciudad
aSubirCostoDeVida unAño = transformarUnaCiudad unAño (terminaMejorSegun costoDeVida) 

---------------
-- PUNTO 5.4 --
---------------

--Dado un año y una ciudad, aplica todos los eventos del año que reducen el costo de vida a la ciudad o lo mantienen igual
aBajarCostoDeVida :: Año -> Ciudad -> Ciudad
aBajarCostoDeVida unAño = transformarUnaCiudad unAño hayQueBajar 

---------------
-- PUNTO 5.5 --  
---------------

--Dado un año y una ciudad, aplica todos los eventos del año que incrementan el valor de la ciudad
aSubirValorDeCiudad :: Año -> Ciudad -> Ciudad
aSubirValorDeCiudad unAño = transformarUnaCiudad unAño (terminaMejorSegun valorDeUnaCiudad)

--------------------------Funciones para no repetir lógica----------------------------------------
--Dado una condicion aplicable a un evento y un año, devuelve una lista de eventos de ese año que cumplan esa condicion
filtrarSegun :: (Evento -> Bool) -> Año -> [Evento]
filtrarSegun condicionDeEvento unAño = filter condicionDeEvento (eventos unAño)

--Dado un año, una condicion aplicada a un evento y una ciudad, devuelve la ciudad con todos los eventos del año aplicados los cuales cumplan la condicion
transformarUnaCiudad :: Año -> (Ciudad -> Evento -> Bool) -> Ciudad -> Ciudad
transformarUnaCiudad unAño condicionDeEvento unaCiudad = pasarPorEventos (filtrarSegun (condicionDeEvento unaCiudad) unAño) unaCiudad 

--Indica si, dado una ciudad y un evento, el evento reduce o mantiene igual el costo de vida
hayQueBajar :: Ciudad -> Evento -> Bool
hayQueBajar unaCiudad unEvento = not (terminaMejorSegun costoDeVida unaCiudad unEvento)
--------------------------Funciones para no repetir lógica----------------------------------------





--                   Otra alternativa de solucion para el Punto 5
{-

--------------------------Funciones Generales--------------------------
pasarPorListaDeEventos :: [Ciudad -> Ciudad] -> Ciudad -> Ciudad
pasarPorListaDeEventos = flip $ foldl (\ciudad evento -> evento ciudad)

aplicarEventosFiltrados :: (Evento -> Bool) -> LosAniosPasan -> Ciudad -> Ciudad
aplicarEventosFiltrados filtro unAnio =  pasarPorListaDeEventos eventosFiltrados
    where
        eventosFiltrados = filter filtro (eventos unAnio)
--------------------------Funciones Generales--------------------------

-- Punto 5.1
pasarPorAnio :: LosAniosPasan -> Ciudad -> Ciudad
pasarPorAnio anio = pasarPorListaDeEventos (eventos anio)

-- Punto 5.2
data Criterio = CostoDeVida | Atracciones

algoMejor :: Criterio -> Ciudad -> (Ciudad -> Ciudad) -> Bool
algoMejor CostoDeVida ciudad evento = costoDeVida ciudad < (costoDeVida . evento) ciudad
algoMejor Atracciones ciudad  evento = (genericLength . atracciones) ciudad < (genericLength . atracciones . evento) ciudad

-- Punto 5.3

eventoAumentaCostoDeVida :: Ciudad -> Evento -> Bool
eventoAumentaCostoDeVida ciudad evento = costoDeVida ciudad < costoDeVida (evento ciudad) 

costoDeVidaQueSuba :: LosAniosPasan -> Ciudad -> Ciudad
costoDeVidaQueSuba unAnio ciudad = aplicarEventosFiltrados (eventoAumentaCostoDeVida ciudad) unAnio ciudad


-- Punto 5.4

costoDeVidaQueBaje :: LosAniosPasan -> Ciudad -> Ciudad
costoDeVidaQueBaje unAnio ciudad = aplicarEventosFiltrados (not . eventoAumentaCostoDeVida ciudad) unAnio ciudad 

-- Punto 5.5    

valorQueSuba :: LosAniosPasan -> Ciudad -> Ciudad
valorQueSuba unAnio ciudad = aplicarEventosFiltrados (eventoAumentaValorCiudad ciudad) unAnio ciudad

eventoAumentaValorCiudad :: Ciudad -> Evento -> Bool
eventoAumentaValorCiudad ciudad evento = valorDeUnaCiudad ciudad < valorDeUnaCiudad (evento ciudad)

-}
--                     Fin de otra alternativa de solucion




---------------------------
-- 6.1 Eventos ordenados --
---------------------------

--Dado un año y una ciudad, devuelve si el efecto de los eventos del año sobre el costo de vida va aumentando
eventosEstanOrdenados :: Año -> Ciudad -> Bool  
eventosEstanOrdenados unAño unaCiudad = algoEstaOrdenado (aplicarEvento unaCiudad) (eventos unAño)

-----------------------------
-- 6.2  Ciudades ordenadas --
-----------------------------

--Dado un evento y una lista de ciudades, devuelve si tras aplicar el evento sobre todas 
--las ciudades, estas quedan ordenadas ascendentemente por costo de vida
ciudadesEstanOrdenadas :: Evento -> [Ciudad] -> Bool
ciudadesEstanOrdenadas unEvento ciudades = algoEstaOrdenado (flip aplicarEvento unEvento) ciudades

------------------------
-- 6.3 Años ordenados --
------------------------

--Dada una lista de años y una ciudad, devuelve si los años estan ordenados ascendentemente
--por el efecto que tienen sobre el costo de vida de la ciudad
añosEstanOrdenados :: [Año] -> Ciudad -> Bool
añosEstanOrdenados años unaCiudad = algoEstaOrdenado (flip ciudadLuegoDeAños unaCiudad) años



--------------------------Funciones para no repetir lógica----------------------------------------

--Devuelve si una lista de objetos ordenables esta ordenada, siempre que no este vacia
esCreciente :: (Num a, Ord a) => [a] -> Bool
esCreciente [] = False
esCreciente [_] = True
esCreciente (x1:x2:xs) = x1 < x2 && esCreciente (x2:xs)


--Dada una lista y una funcion que genere ciudades con cada elemento de la lista, devuelve si el costo
--de vida de las ciudades generadas esta ordenado ascendentemente
algoEstaOrdenado :: (a -> Ciudad ) -> [a] -> Bool 
algoEstaOrdenado laTransformacion elTransformado = esCreciente (map (costoDeVida . laTransformacion) elTransformado)

--------------------------Funciones para no repetir lógica----------------------------------------

--Punto 7
año2024 :: Año
año2024 = Año 2024 (ciudadEnCrisis : ciudadAReevaluar 7  : eventosInfinitos)
                        -2.9            10%                     1% 
sanGuemes = Ciudad "Sanguemes" 1234 ["holadwdwdqdww"] 29  

eventosInfinitos :: [Evento]
eventosInfinitos  = map ciudadARemodelar [1..]



{- 
¿Puede haber un resultado posible para la función del punto 6.1 (eventos ordenados) para el
año2024?

Si, es posible, puesto que atravesar una crisis siempre reduce el costo
de vida en un 10% mientras que reevaluar puede aumentar el costo de vida
en un 10% o reducirlo en 3 unidades. Si al realizar la reevaluación, se 
da el caso donde se resta el costo de vida y los 3 puntos restados representan
una disminución mayor que la causada por el 10%, es decir, el costo de vida
es menor a 30 y hay una atraccion con menos de 7 letras, la función devolverá
False y se detendrá en su primera comparación por la Lazy Evaluation.
Al mismo tiempo, suponiendo que le reevaluación sea un exito, se dará un aumento
del costo de vida de un 10%, claramente menor al que sigue que será de 1%, por lo
que devolvera False en la segunda comparación por Lazy Evaluation.
Si se diera que el costo de vida es mayor a 30 y la reevaluación fracase, sin embargo
el costo de vida comenzará reduciendose mas de 3 puntos. Luego se reducira justo
3 puntos y luego aumentará gradualmente hasta el infinito, por lo que nunca
dejará de evaluar, dado que todas las comparaciones serán verdaderas.
Eventualmente el programa se quedará sin memoria y el proceso se dará por
finalizado sin ninguna respuesta.


Si, es posible. Atravesar una crisis siempre reduce el costo de vida en un 10%; luego, reevaluar puede aumentarlo en un 10% o disminuirlo en 3 unidades
dependiendo la cantidad de letras que tengan las posibles atracciones de la ciudad evaluada. Por último, remodelar SIEMPRE aumentará el costo de vida
de uno en uno porcentualmente. Dado este panorama, existen 3 posibles casos:

1. Si, al realizar la reevaluación, se da el caso en que el costo de vida se reduce y los 3 puntos restados representan una 
   disminución mayor que la causada por el 10% (es decir, si el costo de vida es menor a 30 y hay una atracción con menos de 7 letras), 
   la función devolverá False y se detendrá en su primera comparación debido a la evaluación perezosa (Lazy Evaluation).
2. Luego, suponiendo que le reevaluación sea un exito, se dará un aumento del 10%, claramente menor al que sigue, 
   que será de 1%, lo cual conllevaría a devolver False en la segunda comparación por Lazy Evaluation.
3. Si se diera el caso en que el costo de vida es mayor a 30 y la reevaluación fracase, el costo de vida 
   comenzará reduciéndose más de 3 puntos. Posteriormente, se reducirá exactamente en 3 puntos
   y luego aumentará gradualmente hasta el infinito. Debido a esto, la función nunca dejará de evaluar, 
   ya que todas las comparaciones serán verdaderas. Eventualmente, el programa se quedará sin memoria y el proceso finalizará sin ninguna respuesta.
 -}

discoRayado :: [Ciudad]
discoRayado = azul : nullish : ciudadesInfinitas

ciudadesInfinitas :: [Ciudad]
ciudadesInfinitas = cycle [caletaOlivia, baradero]

{-¿Puede haber un resultado posible para la función del punto 6.2 (ciudades ordenadas) para la
lista “discorayado”?

Si, es indudable que en algun punto, al ciclar las ciudades 
caletaOlivia y baradero, aplicandoles siempre el mismo evento 
a ambas, una va a presentar menor o igual costo de vida que la otra.
Por lo tanto, en ese punto, al utilizar Haskell (lazy evaluation), se dejara
de buscar nuevas ciudades en la lista infinita y se devolverá False 
-}

laHistoriaSinFin :: [Año]
laHistoriaSinFin = año2021 : año2022 : añosInfinitos

añosInfinitos :: [Año]
añosInfinitos = repeat año2023

{- Definir una lista de años “la historia sin fin” que comience con 2021, 2022 y continúe con infinitos 2023.

Dado que la función en el punto 6.3 está definida para evaluar si el costo de vida tras un año es menor que el costo de vida tras el año siguiente, 
sin utilizar "menor o igual", al llegar al punto donde se repite el año 2023, el costo de vida de una ciudad al pasar por 2023 será igual al de 
la misma ciudad al pasar por el mismo año. Esto resultará en False, y dado que False es el elemento absorbente del operador AND y 
Haskell utiliza evaluación perezosa (Lazy Evaluation), no se evaluará el resto de la lista, sino que se devolverá False.
-}