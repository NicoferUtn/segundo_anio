--Punto 1
esMultiploDeTres :: Int -> Bool
esMultiploDeTres x = (mod x 3) == 0

--Punto 2
esMultiploDedos :: Int -> Int -> Bool
esMultiploDedos x y = (mod x y) == 0

--Punto 3
cubo :: Int -> Int
cubo x = x*x*x

--Punto 4
area :: Int -> Int -> Int
area base altura = (base*altura)

--Punto 5
esBisiesto :: Int -> Bool
esBisiesto anio = mod anio 400 == 0 || mod anio 4 == 0  && mod anio 100 /= 0 

--Punto 6
celsiusToFahr :: Float -> Float
celsiusToFahr c =  c * 9/5 + 32

--Punto 7
fahrToCelsius :: Float -> Float
fahrToCelsius  f = (f - 32) * 5/9

--Punto 8
haceFrio :: Float -> Bool
haceFrio f =  fahrToCelsius f < 8

--Punto 9
-- m.c.m.(a, b) = {a * b} / {m.c.d.(a, b)} 
mcm :: Int -> Int -> Int
mcm x y = (x * y) `div`gcd x y

--Punto 10
-- Punto "A"
dispersion :: Int -> Int -> Int -> Int 
dispersion x y z = max(max x y)z - min(min x y)z 

-- Punto "B"
tipodia :: Int -> Int -> Int -> String
tipodia x y z  
    | dispersion x y z <= 30 = "Es un dia parejo."
    | dispersion x y z < 60  = "Es un dia normal."
    | otherwise              = "Es un dia locos."

--Punto 11
--Punto A
pesoPino :: Int -> Int
pesoPino x 
    | x < 300 = x*3 
    | x > 300 = 300*3 + (x - 300)*2 

-- Punto B
esPesoUtil :: Int -> Bool
esPesoUtil x = x <= 1000 && 400 <= x

-- Punto C
sirvePino :: Int -> Bool
sirvePino  = esPesoUtil.pesoPino 

--Punto 12 
esCuadradoPerfecto :: Int -> Bool
esCuadradoPerfecto n 
    | n == 0 = True
    | otherwise = auxiliar n 0 1 
 
 
auxiliar :: Int -> Int -> Int -> Bool
auxiliar n cuadrado suma
    | cuadrado == n = True
    | cuadrado > n = False
    | otherwise = auxiliar n (cuadrado + suma) (suma + 2)

