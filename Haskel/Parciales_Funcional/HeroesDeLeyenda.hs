import Text.Show.Functions
import Data.List(genericLength)

data Heroe = Heroe {
    epiteto :: String,
    reconocimiento :: Int,
    artefactos :: [Artefacto],
    tareas :: [Tareas]
} deriving (Show)

data Artefacto = Artefacto {
    nombre :: String,
    rareza :: Int
}deriving (Show)

data Bestia = Bestia{
    nombreBestia :: String,
    devilidad :: Devilidad
}deriving (Show)

type Devilidad = Heroe -> Bool
type Mapper campo estructura   = (campo -> campo) -> estructura -> estructura
type Tareas = Heroe -> Heroe

--Bestias 
leonDeNemea :: Bestia
leonDeNemea = Bestia "matar al león de Nemea" devilidadDeNemea

devilidadDeNemea :: Devilidad
devilidadDeNemea  = (>= 20) . length . epiteto 

--Heroes
heracles :: Heroe
heracles = Heroe "Guardián del Olimpo" 700 [fierroEnLaAntiguaGrecia, elRempalagoDeZeus] []

--Artefactos
fierroEnLaAntiguaGrecia :: Artefacto
fierroEnLaAntiguaGrecia = Artefacto "fierro en la antigua Grecia" 100
lanzaDelOlimpo :: Artefacto
lanzaDelOlimpo = Artefacto "Lanza Del Olimpo" 100
xiphos :: Artefacto
xiphos         = Artefacto  "xiphos " 50
elRempalagoDeZeus :: Artefacto
elRempalagoDeZeus = Artefacto " El Rempalago de Zeus" 500


pasarALaHistoria :: Heroe -> Heroe
pasarALaHistoria heroe 
    | reconocimiento heroe >= 1000 = mapEpiteto ("El mitico"++) heroe 
    | reconocimiento heroe >= 500  = agregarArtefacto lanzaDelOlimpo . agregarAlEpiteto "El magnifico"  $ heroe
    | reconocimiento heroe >= 100  = agregarArtefacto  xiphos . agregarAlEpiteto "Hoplita"  $ heroe

agregarAlEpiteto :: String -> Heroe -> Heroe
agregarAlEpiteto comienzo = mapEpiteto (comienzo ++)

agregarArtefacto :: Artefacto -> Heroe -> Heroe
agregarArtefacto unArtefacto = mapArtefactos (unArtefacto :)

mapArtefactos :: Mapper [Artefacto] Heroe
mapArtefactos mapper heroe = heroe {artefactos =  mapper . artefactos $ heroe}

mapEpiteto :: Mapper String Heroe 
mapEpiteto mapper heroe = heroe {epiteto = mapper . epiteto $ heroe}

mapReconocimiento :: Mapper Int Heroe
mapReconocimiento mapper heroe = heroe {reconocimiento = mapper . reconocimiento $ heroe}


encontrarUnArtefacto :: Artefacto -> Tareas
encontrarUnArtefacto artefacto =  mapArtefactos (artefacto :) . mapReconocimiento (+rareza artefacto)

escalarElOlimpo :: Tareas
escalarElOlimpo  = agregarArtefacto elRempalagoDeZeus . filtrarArtefactosComunes . triplicarRarezaDeArtefactos . agregarReconocimiento 500

filtrarArtefactosComunes :: Heroe -> Heroe
filtrarArtefactosComunes  = mapArtefactos (filter((< 1000) . rareza))

triplicarRarezaDeArtefactos :: Heroe -> Heroe
triplicarRarezaDeArtefactos  = mapArtefactos (map (mapRarezas (*3)))

mapRarezas :: Mapper Int Artefacto
mapRarezas mapper artefacto = artefacto {rareza = mapper . rareza $ artefacto}

agregarReconocimiento :: Int -> Heroe -> Heroe
agregarReconocimiento reconocimiento = mapReconocimiento (+reconocimiento)

ayudarACurzarLaCalle :: Int -> Tareas
ayudarACurzarLaCalle cuadras  = agregarAlEpiteto ( "Gros" ++ replicate cuadras 'o')

matarUnaBestia :: Bestia -> Heroe -> Heroe
matarUnaBestia bestia heroe 
    |  devilidad bestia heroe = agregarAlEpiteto ("El asesino de la " ++ nombreBestia bestia) heroe
    |  otherwise              = agregarAlEpiteto "El cobarde" heroe

hacerUnaTarea :: Heroe -> Tareas -> Heroe
hacerUnaTarea heroe tarea = tarea heroe 

valortotalrarezas :: Heroe -> Int
valortotalrarezas = sum . map rareza . artefactos

presumir :: Heroe -> Heroe -> (Heroe, Heroe)
presumir heroe1 heroe2 
    | reconocimiento heroe1 > reconocimiento heroe2 = (heroe1, heroe2)
    | reconocimiento heroe1 < reconocimiento heroe2 = (heroe2, heroe1)
    | valortotalrarezas heroe1 > valortotalrarezas heroe2 = (heroe1, heroe2)
    | valortotalrarezas heroe1 < valortotalrarezas heroe2 = (heroe2, heroe1)
    | otherwise = presumir (hacerTodasLasTareas heroe1 heroe2) (hacerTodasLasTareas heroe2 heroe1) 

hacerTodasLasTareas :: Heroe -> Heroe -> Heroe --Tengo que agregar las tareas
hacerTodasLasTareas heroe1 heroe2 = foldl  hacerUnaTarea heroe1 (tareas heroe2)



