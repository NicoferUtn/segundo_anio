import Text.Show.Functions
import Data.List(genericLength)
import Data.ByteString (cons)

data Auto = Auto {
    marca :: String,
    modelo :: String,
    desgaste :: Desgaste, --Se puede usar Tuplas
    velovidadMaxima :: Float,
    tiempo :: Float
} deriving (Show)

data Desgaste = Desgaste {
    ruedas :: Float,
    chasis :: Float
} deriving (Show)

data Carrera = Carrera {
    curvas :: [TramoDePista],
    vueltas :: Int
} deriving (Show)

type SaludDelAuto = Auto -> Bool
type Criterio campo = Desgaste -> campo
type Mapper campo estructura = (campo -> campo) -> estructura -> estructura
type TramoDePista = Auto -> Auto 

--Punto 1

autoFerrari = Auto "Ferrari" "F50" (Desgaste 0 0) 65 2
autoLambo = Auto "Lamborghini" "Diablo" (Desgaste 7 4) 73 2 
autoFiat = Auto "Fiat" "600" (Desgaste 33 27) 44 2


autos = [autoFerrari, autoLambo, autoFiat]
--Punto 2

desgasteDelAuto :: (Fractional b) => Criterio b -> Auto -> b
desgasteDelAuto criterio  = criterio . desgaste 


autoEnBuenEstado :: SaludDelAuto
autoEnBuenEstado unAuto = desgasteDelAuto chasis unAuto < 40 && desgasteDelAuto ruedas unAuto < 60


autoNoDaMas :: SaludDelAuto
autoNoDaMas unAuto  = desgasteDelAuto chasis unAuto > 80  && desgasteDelAuto ruedas unAuto > 80

--Punto 3
hayQueRepara :: Auto -> Auto
hayQueRepara = mapRuedas (const 0) . mapChasis (* 0.15)

mapChasis :: Mapper Float Auto
mapChasis mapper unAuto = unAuto { desgaste = (desgaste unAuto) { chasis = mapper . chasis .desgaste $ unAuto } }


mapRuedas :: Mapper Float Auto
mapRuedas mapper unAuto = unAuto { desgaste = (desgaste unAuto) { ruedas = mapper . ruedas . desgaste $ unAuto } }

--Punto 4 a
tomarCurva :: Float ->  Float -> TramoDePista
tomarCurva angulo longitud  unAuto = mapTiempo (+ (longitud / (velovidadMaxima unAuto / 2))) . mapRuedas (subtract (3 * angulo / longitud)) $ unAuto

mapTiempo :: Mapper Float Auto
mapTiempo maper unAuto  = unAuto {tiempo = maper . tiempo $ unAuto}

curvaPeligrosa =  tomarCurva 60 300
curvaTranka =  tomarCurva 110 550 

--Punto 4 b
irRecto ::  Float -> TramoDePista
irRecto longitud unAuto= mapTiempo (+ (longitud / velovidadMaxima unAuto)) . mapChasis (subtract (1 - (1 / longitud))) $ unAuto

tramoRecto = irRecto 750
tramito = irRecto 280

--Punto 4 c
pasarPorBoxes ::  TramoDePista -> TramoDePista
pasarPorBoxes tramo unAuto
    | autoEnBuenEstado unAuto = tramo  unAuto  
    | otherwise               = hayQueRepara . mapTiempo (+ 10) . tramo $ unAuto

--Punto 4 d 
tramoMojado :: TramoDePista -> TramoDePista
tramoMojado tramo unAuto = mapTiempo (+ tiempoAgregado unAuto (tramo unAuto) / 2) . tramo $ unAuto


tiempoAgregado :: Auto -> Auto -> Float
tiempoAgregado autoOriginal autoModificado = tiempo autoModificado - tiempo autoOriginal

--Punto 4 e 
atravezarRipio :: TramoDePista -> TramoDePista
atravezarRipio tramo unAuto =  mapTiempo (+ tiempoAgregado unAuto ((tramo . tramo )unAuto) *2 ). tramo . tramo $ unAuto

--Punto 4 f 
--Los tramos que tienen alguna obstrucción, además, producen un desgaste en las ruedas de acuerdo a la porción de pista ocupada, siendo 2 puntos de desgaste por cada metro de pista que esté ocupada, producto de la maniobra que se debe realizar al esquivar dicha obstrucción.
atraviezaObstruccion :: Float -> TramoDePista -> TramoDePista
atraviezaObstruccion longitud tramo  = mapRuedas (+ 2 * longitud) . tramo 

--Punto 5 
pasarPorTramos :: TramoDePista -> TramoDePista
pasarPorTramos tramo  = tramo 
--Punto 6 a
superPista = [tramoRecto , curvaTranka, tramoMojado tramito, tramito, atraviezaObstruccion  2 (tomarCurva 80 400), tomarCurva 115 650 , irRecto 970 , atravezarRipio tramito, pasarPorBoxes (irRecto 800)]

--Punto 6 b 
darLaVueltaALaPista :: [TramoDePista] -> [Auto] -> [Auto]
darLaVueltaALaPista pista autos = foldl peganLaVuelta autos pista

peganLaVuelta :: [Auto] -> TramoDePista -> [Auto]
peganLaVuelta autos tramo = map (pasaPorElTramo tramo) autos

pasaPorElTramo :: TramoDePista ->  Auto -> Auto
pasaPorElTramo tramo auto
    | autoNoDaMas auto =  auto     
    | otherwise        = tramo auto 

--Punto 7 b
tourBuenoAires = Carrera superPista 20


--acer que una lista de autos juegue una carrera, teniendo los resultados parciales de cada vuelta, y la eliminación de los autos que no dan más en cada vuelta.
--Punto 7 c
correrCarrera :: Carrera -> [Auto] -> [[Auto]]
correrCarrera carrera  = take (vueltas carrera) . iterate (filter autoNoDaMas . darLaVueltaALaPista (curvas carrera) ) 


             -- iterate :: (a -> a) -> a -> [a]
--correrCarrera carrera autos = replicate (vueltas carrera) (darLaVueltaALaPista (curvas carrera) autos)
--Replicate "Itera" un numero de veces en este caso es vueltas carrera
