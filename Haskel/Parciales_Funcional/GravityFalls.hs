import Text.Show.Functions
import Data.List (genericLength)
import System.Win32 (FileAttributeOrFlag)

data Persona = Persona {
    edad :: Int,
    items :: [String],
    experiencia :: Float,
    criaturas :: [Criatura]
}

data Criatura = Criatura {
    peligrosidad :: Float,
    puedeSuperarla :: Persona -> Bool
}

type Mapper  dato estructura = (dato -> dato) -> estructura -> estructura

--Punto 1
siempredentrasMoustro :: Persona -> Bool
siempredentrasMoustro _ = False 

siempredentras :: Criatura
siempredentras = Criatura 0  siempredentrasMoustro 

gnomos :: Int -> Criatura
gnomos num = Criatura (2^num) (any ("soplador de hojas" ==) . items)

fantasmas :: Float -> (Persona -> Bool) -> Criatura
fantasmas num criterio = Criatura (20* num) criterio 


--Punto 2 
matarACriaturas :: Persona -> Criatura -> Persona
matarACriaturas persona criatura  
    | puedeSuperarla criatura persona = mapExperiencia (+ peligrosidad criatura) persona 
    |  otherwise                      = mapExperiencia (+1) persona

mapExperiencia :: Mapper Float Persona
mapExperiencia mapper persona = persona {experiencia = mapper . experiencia $ persona}


--Punto 3
condicion :: Persona -> Bool
condicion persona = edad persona > 13 && any ("traje de obeja" ==)  (items persona)

muchasCriaturas = [siempredentras, gnomos 10, fantasmas 3 condicion]

matarAMucasCriaturas :: [Criatura] -> Persona -> Persona
matarAMucasCriaturas criaturas persona =  foldl matarACriaturas persona criaturas



