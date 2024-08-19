import Text.Show.Functions
import Data.List(genericLength)
import Text.Read (Lexeme(Number))


-- Funciones que tal vez te pueden servir, tal vez no

-- Main*> :t takeWhile
-- takeWhile :: (a -> Bool) -> [a] -> [a]
-- Main*> takeWhile even [2,4,6,5,6,7,8,9]
-- [2,4,6]

-- Main*> :t genericLength
-- genericLength :: Num i => [a] -> i
-- Main*> genericLength [2,4,6,5,6,7,8,9]
-- 8

-----------
--Punto 1--
-----------
data GuerreroZ = GuerreroZ {
    nombre :: String,
    ki :: Float,
    raza :: Raza,
    fatiga :: Float
} deriving (Show, Eq)

type Ejercicio = GuerreroZ -> GuerreroZ
type Mapper dato estructura = (dato -> dato) -> estructura -> estructura
type Cansancio = Ejercicio -> GuerreroZ -> GuerreroZ
type Criterio a = GuerreroZ -> a

data Raza  = Humanos | Namekianos | Saiyajines deriving (Show, Eq)

gohan = GuerreroZ "Gohan" 10000 Saiyajines 0
-----------
--Punto 1--
-----------
esPoderoso :: GuerreroZ -> Bool 
esPoderoso guerrero = ki guerrero >= 8000 || raza guerrero == Saiyajines

--Ejercicios 
presDeBanca :: Ejercicio
presDeBanca  = aumentarKi 90 . aumentarFatiga 100

aumentarKi :: Float -> GuerreroZ -> GuerreroZ
aumentarKi ki = mapKi (+ki)

mapKi :: Mapper Float GuerreroZ
mapKi mapper guerrero = guerrero {ki = mapper . ki $ guerrero}

aumentarFatiga :: Float -> GuerreroZ -> GuerreroZ
aumentarFatiga fatiga = mapKi (+fatiga) 

mapFatiga :: Mapper Float GuerreroZ
mapFatiga mapper guerrero = guerrero {fatiga = max 0 . mapper . fatiga $ guerrero}


flexionesDeBrazo :: Ejercicio 
flexionesDeBrazo = aumentarFatiga 100

saltosAlCajon :: Float -> Ejercicio
saltosAlCajon centimetros  = aumentarKi seAumentarElKi  . aumentarFatiga seAumentarLaFatiga
    where 
        seAumentarElKi =  centimetros / 10
        seAumentarLaFatiga = centimetros / 5

esExperimentado :: GuerreroZ -> Bool
esExperimentado guerrero = ki guerrero >= 22000

snatch :: Ejercicio 
snatch guerrero 
    | esExperimentado guerrero = mapKi (*1.05) . mapFatiga (*1.10) $ guerrero
    | otherwise                = aumentarFatiga 100 guerrero

--Fatiga 

estaFresco :: Cansancio
estaFresco ejercicio = ejercicio 

estaCansado :: Cansancio
estaCansado ejercicio guerrero = aumentarFatiga ( 4* diferenciaSegun fatiga ejercicio guerrero) . aumentarKi  ( 2 * diferenciaSegun ki ejercicio guerrero) $ guerrero

estaExausto :: Cansancio
estaExausto ejercicio guerrero = mapKi (*0.98) . aumentarFatiga (diferenciaSegun fatiga ejercicio guerrero) $ guerrero

diferenciaSegun :: Criterio Float -> Ejercicio ->  GuerreroZ -> Float
diferenciaSegun criterio ejercicio guerreo = criterio (ejercicio guerreo) -  criterio guerreo 

-----------
--Punto 3--
-----------
realiceUnEjercicio :: Ejercicio -> GuerreroZ -> GuerreroZ
realiceUnEjercicio ejercicio guerrero 
    | condicionDeEjercicio 0.44 guerrero = estaCansado ejercicio guerrero
    | condicionDeEjercicio 0.72 guerrero = estaExausto ejercicio guerrero
    where condicionDeEjercicio numero guerrero = fatiga guerrero > numero * ki guerrero

-----------
--Punto 4--
-----------
ejerciciosInf = ejerciciosInfinitos

ejerciciosInfinitos :: [Ejercicio]
ejerciciosInfinitos = repeat flexionesDeBrazo
--No. ya que en estos tipos de ejerrcicios no hay un tope el cual deje de hacer ejercicios. Aunque el guerreros este cansadisimo
-- Osea que este haciendo ejercicios "esteExausto" va a seguir haciendo esos ejercicios y bajando su ki un 2%
--En el caso que este ejrciciso tendria un tope Por ejemplo hacer ejericicios hasta que llegue a estar exautos si se podria evaluar por lazy Evaluation

-----------
--Punto 5--
-----------
hacerUnaRutina:: [Ejercicio] -> GuerreroZ -> GuerreroZ 
hacerUnaRutina ejercicios guerrero =  foldl queTipoDeDescansosToman guerrero ejercicios

queTipoDeDescansosToman ::  GuerreroZ -> Ejercicio -> GuerreroZ
queTipoDeDescansosToman  guerrero ejercicio
    | nombre guerrero == "Vegeta"   = realiceUnEjercicio ejercicio guerrero
    | nombre guerrero == "Gohan"    = tomarseUnDescanso 5 . realiceUnEjercicio ejercicio $ guerrero
    | nombre guerrero == "Yajirobe" = guerrero

-----------
--Punto 6--
-----------
tomarseUnDescanso  :: Float -> GuerreroZ -> GuerreroZ
tomarseUnDescanso  minutos  = mapFatiga (subtract (sucesion minutos))

sucesion :: Float -> Float 
sucesion minutos = sum takeWhile(minutos ==) [1..]


-----------
--Punto 7--
-----------
cantidadOptimaDeDescanso :: GuerreroZ -> Float
cantidadOptimaDeDescanso guerrero = head  takeWhile condicionDeFatiga [1..]
    where condicionDeFatiga  numero = fatiga (tomarseUnDescanso numero guerrero) == 0