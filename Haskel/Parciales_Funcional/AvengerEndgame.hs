

data SuperHeroe = SuperHeroe {
    nombre :: String,
    vida :: Float,
    planetaOrigen :: String,
    arma :: Artefacto,
    enemigo :: Villano 
} deriving (Show)

data Villano = Villano {
    nombreVillano :: String,
    planteta :: String,
    armaVillana :: Arma
}deriving (Show)

data Artefacto = Artefacto {
    nombreArtefacto :: String,
    danio :: Float
}deriving (Show)

type Arma = SuperHeroe -> SuperHeroe  
type Mapper  dato  estructura = (dato -> dato) -> estructura -> estructura

--SuperHeroes y Villanos
ironMna = SuperHeroe "Tony Strack" 100 "Tierra" (Artefacto "Traje" 12) thanos
thor = SuperHeroe "Thor Odison" 300 "Asgard" (Artefacto "Stormbraker" 0)  loki

thanos = Villano "Thanos" "Titan" guanteDelInfinito
loki = Villano "Loki" "Jotunheim" (cetro 0.80)

--Armas
--Punto 2
guanteDelInfinito :: Arma
guanteDelInfinito  = mapVida (* 0.20) 

mapVida :: Mapper Float SuperHeroe
mapVida mapper superHeroe = superHeroe {vida = mapper . vida $ superHeroe}

cetro :: Float -> Arma 
cetro porcentaje superHeroe 
    | "Tierra" == planetaOrigen superHeroe = romperArtefacto 30 . mapVida (*(1 - porcentaje))  . mapNombre ("manchado" ++) $ superHeroe
    | otherwise                            = mapVida(*(1 - porcentaje))  superHeroe

mapNombre :: Mapper String SuperHeroe 
mapNombre mapper superHeroe = superHeroe {nombre = mapper . nombre $ superHeroe}

romperArtefacto :: Float -> SuperHeroe -> SuperHeroe
romperArtefacto danio  superHero = superHero {arma =  mapDanio (+ danio) . arma $ superHero}

mapDanio :: Mapper Float Artefacto
mapDanio mapper arma = arma {danio =  mapper . danio $ arma }



--Punto 3
esVillanoAntagonista :: Villano -> SuperHeroe -> Bool
esVillanoAntagonista (Villano _ planteta _ ) (SuperHeroe _ _  planetaOrigen _ _) = planetaOrigen == planteta
esVillanoAntagonista (Villano nombreVillano planeta _ )  (SuperHeroe _ _  _ _ (Villano nombreVillanoA planetaA _ )) = nombreVillano == nombreVillanoA && planeta == planetaA

--Punto 4
villanos = [thanos , loki]

atarAlSuperHeroe :: SuperHeroe -> [Villano] -> SuperHeroe
atarAlSuperHeroe   =  foldl atacarAlVillano  

atacarAlVillano :: SuperHeroe -> Villano -> SuperHeroe
atacarAlVillano superHeroe villano 
    | esVillanoAntagonista villano superHeroe = superHeroe
    | otherwise                                = armaVillana villano superHeroe


--Punto 5
superHeroesSobrevivientes :: Villano -> [SuperHeroe]  -> [SuperHeroe]
superHeroesSobrevivientes  villano = filter segunVida . map (armaVillana villano)   
    where segunVida = (<50) . vida

--Punto 6
volverAlHogar :: Villano -> [SuperHeroe] -> [SuperHeroe]
volverAlHogar villano  superHeroe =  aplicarAl villano <$> superHeroe

aplicarAl :: Villano -> SuperHeroe -> SuperHeroe
aplicarAl villano superHero 
    | vida (armaVillana villano superHero) < 30 =  sanarAl superHero 
    | otherwise                                 =  superHero

sanarAl :: SuperHeroe -> SuperHeroe 
sanarAl = renombrarArtefacto  . mapArtefactos (const 0) . mapVida (+30)

mapNombreArtefacto :: Mapper String Artefacto
mapNombreArtefacto mapper artedacto = artedacto {nombreArtefacto = mapper . nombreArtefacto $ artedacto}

renombrarArtefacto :: SuperHeroe -> SuperHeroe
renombrarArtefacto superHero = superHero {arma =  mapNombreArtefacto (filter (`elem` "manchado")) . arma $ superHero}

mapArtefactos :: Mapper Float SuperHeroe
mapArtefactos danio  superHero = superHero {arma =  mapDanio danio . arma $ superHero}

--Punto 7 
elVillanoEsAntagonista :: Villano -> [SuperHeroe] -> Bool
elVillanoEsAntagonista villano = all (\x -> estaMnachado x   &&  esVillanoAntagonista villano x )

estaMnachado :: SuperHeroe -> Bool
estaMnachado = any (`elem` "manchado") . nombreArtefacto . arma

--Punto 8

drStrange = SuperHeroe "Stephen Strange" 60 "Tierra" (Artefacto "Capa Levitacion" 0 ) thanos

clonesDrStrange = clones

clones :: [SuperHeroe]
clones = map (\x -> mapNombre (++show x ) drStrange) [1..]


