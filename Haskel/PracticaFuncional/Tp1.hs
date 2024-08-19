data Sustancia = Elemento {
    nombre :: String,
    simboloQuimico :: String,
    numAtomico :: Int,
    especie :: Especie

}| Compuesto{
    nombre :: String,
    simboloQuimico :: String,
    componentes :: [Componete],
    especie :: Especie

}deriving (Show)

data Componete = Componete {
    sustancia :: Sustancia,
    numeroAtomico :: Int
}deriving (Show)

data Especie = Metal | NoMetal | Halogeno | GasNotable deriving (Show)

--Punto 1
hidrogeno :: Sustancia
hidrogeno = Elemento "Hidrogeno" "H" 1 NoMetal

oxigeno :: Sustancia
oxigeno = Elemento "Oxigeno" "O" 8 NoMetal 

agua :: Sustancia
agua = Compuesto "Agua" "H2O" [Componete hidrogeno 2,Componete oxigeno 1] NoMetal

--Punto 2
conductores :: Sustancia -> Bool
conductores (Sustancia _ _ _ _ Metal) = True
conductores (Elemento _ _ _ GasNotable) = True
conductores (Compuesto _ _ _ Halogeno) = True
conductores _ = False


--Punto 3
nombreDeUnion :: String -> String
nombreDeUnion nomComp = reverse (dropWhile (`notElem`"aeiouAEIOU")(reverse nomComp)) ++ "uro"

--Puto 4
combinar :: String -> String -> String
combinar elem1 elem2 = nombreDeUnion elem1 ++ " de " ++ elem2 

--Punto 5
mezcla :: Sustancia-> Sustancia -> Sustancia
mezcla elemento1 elemento2 = Compuesto (combinar  (nombre elemento1) (nombre elemento2) ) (simboloQuimico elemento1 ++ simboloQuimico elemento2)  [Componete elemento1 1, Componete elemento2 1] NoMetal

--Punto 6
type SimboloQuimico = String
formula :: Sustancia -> SimboloQuimico
formula (Elemento _ unSimboloQuimico _ _) = unSimboloQuimico --Devolvemos si es elemento
formula unCompuesto = concatMap representacion . componentes $ unCompuesto

representacion :: Componete -> SimboloQuimico
representacion (Componete sustancia 1) = formula sustancia
representacion (Componete sustancia numeroAtomico) = formula sustancia ++ show numeroAtomico

