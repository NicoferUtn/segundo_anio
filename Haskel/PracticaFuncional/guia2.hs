import Text.Parsec.Token (GenTokenParser(squares))
--Punto 1
siguiente :: (Num a) => a -> a
siguiente x = x + 1

--Punto 2
mitad :: (Fractional a) => a -> a
mitad x = x / 2
 
--Punto 3
inversa :: (Fractional a) => a -> a
inversa x = 1 / x

--Punto 4
triple :: (Num a) => a -> a
triple x = 3*x

--Punto 5
esNumeroPositivo :: (Ord a, Num a) => a -> Bool --preguntar porque los negativos van en (-1) en cosola
esNumeroPositivo x = 0 <= x    

--Punto 6
esMultiploDe :: Int -> Int -> Bool
esMultiploDe x  =  (== 0) . mod x  

--Punto 7 
esBisiesto :: Int -> Bool
esBisiesto x =  (not . esMultiploDe x) 100 && (esMultiploDe x 400 || esMultiploDe x 4)

--Punto 8
inversaraiz :: Float -> Float
inversaraiz x = 1 / sqrt x

--Punto 9 
incrementMCuadradoN :: Int -> Int -> Int 
incrementMCuadradoN m n =  m ^ n + 2

-- Punto 10
esResultadoPar   :: Int -> Int -> Bool
esResultadoPar m n = (==0) . mod (m^n) $ 2
