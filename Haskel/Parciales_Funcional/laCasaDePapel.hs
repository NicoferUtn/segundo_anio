import Text.Show.Functions
import Data.List(genericLength)

data Ladron = Ladron {
    nombre :: String, 
    habilidades :: [Habilidad],
    armas :: [Arma]
}
data Rehen = Rehen {
    nombreRehen :: String,
    complot :: Float,
    miedo :: Int,
    plan :: [Plan]
}

type Arma = Rehen -> Rehen
type Mapper campo struct  = (campo -> campo) -> struct -> struct
type Habilidad = String

type Plan = Rehen -> Rehen -> Ladron -> Ladron


--Modelado de armas
pistola :: Float -> Arma
pistola calibre  rehen = reducirElComplot  (5* calibre)  . aumentarMiedo (3* length (nombreRehen rehen)) $ rehen

aumentarMiedo :: Int -> Rehen -> Rehen
aumentarMiedo miedo = mapMiedo (+ miedo)

mapMiedo :: Mapper Int Rehen
mapMiedo mapper rehen = rehen {miedo = mapper . miedo $ rehen}

reducirElComplot :: Float -> Rehen -> Rehen 
reducirElComplot complot = mapComplot (subtract complot)

aumentarComplot :: Float -> Rehen -> Rehen
aumentarComplot complot = mapComplot (+ complot)

mapComplot :: Mapper Float Rehen 
mapComplot mapper rehen = rehen {complot = mapper . complot $ rehen}

ametralladora :: Int  -> Arma
ametralladora balas rehen = reducirElComplot  (0.5 * complot rehen)  . aumentarMiedo balas $ rehen

--Modelado de ladrones 
disparonAlTecho :: Arma -> Rehen -> Rehen
disparonAlTecho arma = arma . aumentarMiedo 10

hacerceElMalo :: Rehen -> Ladron  -> Rehen
hacerceElMalo  rehen ladron 
    | "Berlin" == nombre ladron = aumentarMiedo (sumaDeLetras (habilidades ladron)) rehen
    | "Rio"    == nombre ladron = aumentarComplot 20 rehen 
    | otherwise                 = aumentarMiedo 10 rehen

sumaDeLetras :: [Habilidad] -> Int 
sumaDeLetras  = sum . map length 

atacarAlLadron :: Plan
atacarAlLadron rehen1 rehen2  = eliminarArmasPor (cantidadDeLetas rehen2) 

cantidadDeLetas :: Rehen -> Int
cantidadDeLetas  = div 10 . length . nombreRehen

eliminarArmasPor :: Int -> Ladron -> Ladron
eliminarArmasPor cantidad  = mapArmas (drop cantidad) 

mapArmas :: Mapper [Arma] Ladron
mapArmas mapper ladron = ladron {armas = mapper . armas $ ladron}

esconderse :: Plan
esconderse rehen1 rehen2 ladron = eliminarArmasPor (cantidadDeHabilidades ladron) ladron

cantidadDeHabilidades :: Ladron -> Int
cantidadDeHabilidades  = div 3 . length . habilidades


--Punto 1 
tokio = Ladron "Tokio" ["Trabajo psicologico", "Entar en moto"] [pistola 9, pistola 9, ametralladora 30]
profesor = Ladron "Profesor" ["disfrazarse de linyera", "disfrazarse de payaso", "“estar siempre un pasoadelante"] []

pablo = Rehen "Pablo" 40 30 [esconderse]
arturito = Rehen "arturito" 70 50 [esconderse, atacarAlLadron]


--Punto 2
esInteligente :: Ladron -> Bool
esInteligente = (<= 2) . cantidadDeHabilidades

--Punto 3
agregarArma :: Arma -> Ladron -> Ladron
agregarArma nuevaArma = mapArmas (nuevaArma :) 

--Punto 4 No esta bien pero no entiendo la consiga 
intimidarARehen :: Ladron -> Rehen -> Rehen
intimidarARehen =  flip hacerceElMalo 

--Punto 5 




