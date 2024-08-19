import Text.Show.Functions
import Data.List(genericLength)

-- 14 : 20
data Chofer = Chofer {
    nombre :: String,
    kilometods :: Int,
    viajes :: [Viaje],
    condicionParaUnViaje :: CondicionParaViaje
}

data Viaje = Viaje {
    fecha :: Int,
    cliente :: Cliente,
    costoDelViaje :: Int 
}

data Cliente = Cliente {
    nombreCliente :: String,
    direccion :: Zona
}

type CondicionParaViaje = Viaje -> Bool
type Zona = String

--Punto 2
tomarCualqueirViaje :: CondicionParaViaje
tomarCualqueirViaje  = const True  

costoDeViajeMayorA :: CondicionParaViaje
costoDeViajeMayorA  = (< 200) . costoDelViaje

tieneMasLetras :: Int -> CondicionParaViaje
tieneMasLetras letras = (< letras) . cantidadDeLetras . cliente

cantidadDeLetras :: Cliente -> Int 
cantidadDeLetras = length . nombreCliente

noTienQueVivirEn :: Zona -> CondicionParaViaje
noTienQueVivirEn zona = (/= zona) . direccion . cliente

--Punto 3
lucas = Cliente "Lucas" "Victoria"

daniel = Chofer "Daniel" 23500 [Viaje 20042017 lucas 150] (noTienQueVivirEn "Olivos") 

alejandra = Chofer "Alejandra" 180000 [] tomarCualqueirViaje


--Punto 4
puedeTomarElViaje :: Chofer -> Viaje ->   Bool
puedeTomarElViaje   = condicionParaUnViaje 

--Punto 5
liquidacionDeChoferes :: Chofer -> Int
liquidacionDeChoferes = sum . map costoDelViaje . viajes

--Punto 6 
tomarEseViaje :: Viaje -> [Chofer] -> [Chofer]
tomarEseViaje viaje = filter (flip puedeTomarElViaje viaje) 

type Criterio a = Chofer -> a 

menosCantidadDeViajes :: (Ord a) => Criterio a -> [Chofer] -> Chofer
menosCantidadDeViajes _ [chofer1] = chofer1
menosCantidadDeViajes criterio (chofer1:chofer2:choferes) 
    | criterio chofer1  > criterio chofer2 = menosCantidadDeViajes criterio (chofer2:choferes)
    | otherwise                = menosCantidadDeViajes criterio (chofer1:choferes) 


elejimosAlQueTengaMenosViajes :: Viaje -> [Chofer] -> Chofer
elejimosAlQueTengaMenosViajes viaje =  menosCantidadDeViajes (length . viajes) . filter (flip puedeTomarElViaje viaje)

