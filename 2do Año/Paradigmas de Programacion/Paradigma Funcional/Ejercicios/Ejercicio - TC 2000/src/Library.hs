module Library where
  import PdePreludat
  import Data.List(isPrefixOf, sortBy)

-- Dada la siguiente informacion de las carreras de TC disputadas en el año...
  type Corredor = String
  type Puntos = Float
  type Posicion = (Corredor, Puntos)

  data Carrera = Carrera {
    lugar :: String,
    fecha :: (Int, Int),
    posiciones :: [Posicion]
  }

  viedma = Carrera "Viedma" (10, 2) [ ("Ardusso", 45), ("Ortelli", 42), ("Werner", 39) ]
  neuquen = Carrera "Neuquen" (3, 3) [ ("Aguirre", 47), ("Urcera", 42), ("Werner", 38.5)]
  concepcionUruguay = Carrera "Concepcion del Uruguay" (31, 3) [ ("Benvenuti", 45), ("De Benedictis", 42), ("Ardusso", 38.5)]
  sanLuis = Carrera "San Luis" (14, 4) [ ("Mangoni", 45), ("Urcera", 44), ("Mazzacane", 39)]
  rosario = Carrera "Rosario" (5, 5) [ ("Rossi", 47), ("Ponce de Leon", 42), ("Ledesma", 38.5) ]

  corredores :: [Corredor]
  corredores = [
    "Ardusso",
    "Ortelli",
    "Werner",
    "Benvenuti",
    "Aguirre",
    "Urcera",
    "De Benedictis",
    "Mangoni",
    "Mazzacane",
    "Rossi",
    "Ponce de Leon",
    "Ledesma"
    ]

  carreras :: [Carrera]
  carreras = [
    viedma,
    neuquen,
    concepcionUruguay,
    sanLuis,
    rosario
    ]

-- Se pide que arme la tabla de posiciones indicando
-- Corredor, Puntos obtenidos
-- Ordenandolo de mayor a menor

-- 1) Sumar puntos por corredor (pasar por cada carrera)
-- 2) Ordenarlos
  tablaPosiciones :: [Carrera]->[Posicion]
  tablaPosiciones carreras = (sortBy (\tupla1 tupla2 -> if(snd tupla1 > snd tupla2) then LT else GT) . map (\corredor -> (corredor, puntosObtenidos carreras corredor))) corredores

  puntosObtenidos :: [Carrera]->Corredor->Float
  puntosObtenidos carreras corredor = foldl (\total carrera -> total + buscarPuntosCarrera corredor carrera) 0.0 carreras

  buscarPuntosCarrera :: Corredor->Carrera->Float
  buscarPuntosCarrera corredor carrera = (tomarPuntos . filter ((== corredor) . fst) . posiciones) carrera

  tomarPuntos :: [Posicion]->Float
  tomarPuntos [] = 0
  tomarPuntos ((_, puntos):_) = puntos                                   