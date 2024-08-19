import Text.Show.Functions
import Data.List(genericLength)

data Autor = Autor {
    nombre :: String,
    obras :: [Obra]
}

data Obra = Obra {
    texto :: String,
    anio :: Int
}

type Verificacion = Obra -> Obra -> Bool

--Punto 1
obra1 = Obra "Había una vez un pato." 1997
obra2 = Obra "¡Habia una vez un pato!" 1996
obra3 = Obra "Mirtha, Susana y Moria." 2010
obra4 = Obra "La semántica funcional del amoblamiento vertebral es riboficiente" 2020
obra5 = Obra "La semántica funcional de Mirtha, Susana y Moria." 2022

--Punto 2
eliminarAcentos :: Obra -> String
eliminarAcentos   = filter elementosRaros . texto 

elementosRaros:: Char -> Bool
elementosRaros letra = letra `notElem` ['A'..'Z'] ++ ['a'..'z']

--Punto 3 a
copiaLiteral :: Verificacion
copiaLiteral obraA obraB =  eliminarAcentos obraA == eliminarAcentos obraB && anioPosterior obraA obraB

anioPosterior :: Verificacion
anioPosterior obraA obraB = anio obraA < anio obraB

--Punto 3 b 
empiezaIgual :: Int -> Verificacion
empiezaIgual cantidadDeLetras obraA obraB = elTextoEsMenorAl obraA obraB && sonIgualesLasPrmeras cantidadDeLetras obraA obraB && anioPosterior obraA obraB

elTextoEsMenorAl :: Verificacion
elTextoEsMenorAl obraA obraB =  length (texto obraA) <= length (texto obraB)

sonIgualesLasPrmeras :: Int -> Verificacion
sonIgualesLasPrmeras cantidadDeLetras obraA obraB = take cantidadDeLetras (texto obraA) == take cantidadDeLetras (texto obraB)


--Punto 3 c
obraInvertida :: Obra -> String
obraInvertida = reverse .texto

cantidadDeLetras :: Obra -> Int
cantidadDeLetras  = length . texto

leAgrandaronIntro :: Verificacion
leAgrandaronIntro obraA obraB = obraInvertida obraA == take (cantidadDeLetras obraA) (obraInvertida obraB) && anioPosterior obraA obraB


--Punto 4
bot1 = [copiaLiteral, elTextoEsMenorAl]
bot2 = [empiezaIgual 10, copiaLiteral]

--Punto 5 
elBotEncuentraElPlagio :: Obra -> Obra -> [Verificacion] -> Bool
elBotEncuentraElPlagio obraA obraB   =  all (aplicarVerificacion obraA obraB)   

aplicarVerificacion :: Obra -> Obra -> Verificacion -> Bool
aplicarVerificacion obraA obraB bot = bot obraA obraB

--Punto 6
autores = [Autor "Jorge" [obra1,obra2], Autor "Mirtha" [obra3,obra4], Autor "Susana" [obra5]]
--Dado un conjunto de autores y un bot, detectar si es una cadena de plagiadores. Es decir, el segundo plagió al primero, el tercero al segundo, y así. Se considera que un autor plagió a otro cuando alguna de sus obras es plagio de alguna de las del otro según el bot.
--[[Obras]]
plafioDiPlagio :: [Autor] -> [Verificacion] -> Bool
plafioDiPlagio autores bot = funcion bot . map obras $ autores

funcion :: [Verificacion] -> [[Obra]] -> Bool
funcion bot [] = True
funcion bot [x] = True
funcion bot (x:y:xs) = funcion' bot x (head y) && funcion bot (tail y : xs)

funcion' :: [Verificacion] -> [Obra] -> Obra -> Bool
funcion' bot [] obraB = False
funcion' bot [x] obraB = elBotEncuentraElPlagio  x obraB bot
funcion' bot (x:y:xs) obraB = elBotEncuentraElPlagio  x obraB bot && funcion' bot (y:xs) obraB



