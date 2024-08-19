import Data.List (maximumBy, genericLength)
import Distribution.Simple.Program.HcPkg (list)
import Control.Monad (when)



sumaLista :: (Num a, Fractional a) => [a] -> a
sumaLista = sum 

frecuenciaCardiaca ::  (Num a) => [a]
frecuenciaCardiaca = [80, 100, 120, 128, 130, 123, 125] 

promedioDeFrecuenciaCardiaca :: [Float] -> Float
promedioDeFrecuenciaCardiaca x = sumaLista x / fromIntegral (length x)

frecuenciaCardiacaMinuto :: Int -> [Int] -> Int
frecuenciaCardiacaMinuto minuto xs = xs !! div minuto 10 

frecuenciasHastaMomento :: Int -> [Int] -> [Int]
--frecuenciasHastaMomento minuto frecuenciaCardiaca = take (frecuenciaCardiacaMinuto minuto frecuenciaCardiaca) frecuenciaCardiaca PORQUE FALLA
frecuenciasHastaMomento minuto frecuenciaCardiaca = takeWhile (\x -> x <= frecuenciaCardiacaMinuto minuto frecuenciaCardiaca) frecuenciaCardiaca

esCapicua:: [String] -> Bool
esCapicua a = concat a == ( reverse . concat ) a





-- cuandoHabloMasMinutos :: [(String, [Int])] -> String --Hacer con tuplas !!
-- cuandoHabloMasMinutos x 
--     | (sum .snd . head) x > (sum .snd .head .tail)x = "Horario Reducido"
--     | otherwise = "Horario Normal"

-- cuandoHizoMasLlamadas:: [(String, [Int])] -> String
-- cuandoHizoMasLlamadas x
--     | (length .snd . head) x > (length .snd .head .tail)x = "Horario Reducido"
--     | otherwise = "Horario Normal"


    -- | ((sum (tail (head x)) > ((sum ( (tail x)) == (head . head) x
    -- | otherwise == (head .tail) x

--Forma alternativa punto 4

-- duracionLlamadas :: ((String, [Int]),(String, [Int]))
-- duracionLlamadas = (("horarioReducido",[20,10,25,15]),("horarioNormal",[10,5,8,2,9,10]))

-- horarioReducido = fst duracionLlamadas
-- horarioNormal = snd duracionLlamadas

-- maxBy :: (Foldable t, Ord a) => (b -> a) -> t b -> b
-- maxBy = maximumBy . comparing

-- cuandoHizoMasLlamadas:: String
-- cuandoHizoMasLlamadas = fst ( maxBy sum (snd horarioReducido) (snd horarioNormal))



--Ejercicio Extra

esMultiploDeAlguno :: Int -> [Int] -> Bool
esMultiploDeAlguno numero listaNuemeros = numero == product listaNuemeros


listaNota = [[8,6],[7,9,4],[6,2,4],[9,6]] 

promedio :: [Float]
promedio = map funcion listaNota

funcion :: [Float] -> Float
funcion subLista  = sum subLista / fromIntegral (length subLista) 

mejoresNotas = [[8,6],[6,2,6]]

promediosSinAplazos :: [Float]
promediosSinAplazos = map funcion' mejoresNotas

funcion' :: [Float] -> Float
funcion' subLista' = sum (funcion'' subLista') / genericLength (funcion'' subLista')

funcion'' :: [Float] -> [Float]
funcion''  = filter (>4) 

mejoresNotas' = [[8,6,2,4],[7,9,4,5],[6,2,4,2],[9,6,7,10],[8,9,6,10]]

mejoresNotas'' :: [Float]
mejoresNotas'' = map funcion1 mejoresNotas'

funcion1 :: [Float] -> Float
funcion1  = maximum 


aprobo :: [Int] -> Bool
aprobo listanotitas = minimum listanotitas >= 6

listaAprobaron :: [[Int]]
listaAprobaron = [[8,6,2,4],[7,9,6,7],[6,2,4,2],[9,6,7,10]] 

aprobaron :: [[Int]] 
aprobaron  = filter aprobo listaAprobaron 

divisores :: Int -> [Int]
divisores valor = filter divisores' listaValores
    where
        listaValores = [1 .. valor]
        divisores' :: Int -> Bool
        divisores' = (== 0) . mod valor 

exists :: [Int] -> Bool
exists = any even 

hayAlgunNegativo :: [Int] -> Bool
hayAlgunNegativo = any (< 0) 

aplicarFunciones ::  [Int -> Int] -> Int -> [Int]
aplicarFunciones  funciones nro = map ($ nro) funciones

sumaF :: [Int -> Int] -> Int -> Int
sumaF funciones nro = sum (aplicarFunciones funciones nro)


subirHabilidad :: Int -> [Int] -> [Int]
subirHabilidad numero  = map (min 12 .(+numero))

flimitada :: (Int -> Int) -> Int -> Int
flimitada funcion  = max 0. min 12 . funcion 
--Putno a
cambiarHabilidad :: (Int -> Int) -> [Int] -> [Int]
cambiarHabilidad funcion = map (flimitada funcion) 
--Putno b
cambiarHabilidad' :: [Int] -> [Int]
cambiarHabilidad' = map(max 4)

primerosPares :: [Int] -> [Int]
primerosPares = takeWhile even

primerosDivisores :: Int -> [Int] -> [Int]
primerosDivisores nro  = takeWhile ((==0) . mod nro ) 

huboMesMejorDe :: [Int] -> [Int] -> Int -> Bool
huboMesMejorDe lista lista1 nro = any (nro>) lista && any (nro>)lista1

crecimientoAnual :: Int -> Int
crecimientoAnual edad 
    | edad > 0   && edad < 10  = 24 - (edad * 2)
    | edad >= 10 && edad <= 15 = 4
    | edad >= 16 && edad <= 17 = 2
    | edad >= 18 && edad <= 19 = 1
    | otherwise                = 0

crecimientoEntreEdade :: Int -> Int -> Int
crecimientoEntreEdade edad1 edad2 = sum (map crecimientoAnual [edad1..edad2-1])

alturasEnUnAnio :: Int -> [Int] -> [Int]
alturasEnUnAnio edad  = map (+ crecimientoAnual edad)

alturaEnEdades :: Int -> Int -> [Int] -> [Int]
alturaEnEdades altura edad edadmax = map (+ altura) lista
    where
        lista = map(crecimientoEntreEdade edad )  edadmax


lluviasEnero :: [Int]
lluviasEnero = [0,2,5,1,34,2,0,21,0,0,0,5,9,18,4,0]

racha :: [Int] -> [Int]
racha = takeWhile (/= 0)


rachasLluvia :: [Int] -> [[Int]]
rachasLluvia [] = []
rachasLluvia lista
    | null (racha lista) = rachasLluvia (drop (length (takeWhile (== 0) lista)) lista) 
    | otherwise = racha lista : rachasLluvia (drop (length (racha lista)) lista)


