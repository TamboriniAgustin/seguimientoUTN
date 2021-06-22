module Library where
  import PdePreludat
  import Data.List(isPrefixOf, sort)
  
  --Tipos de Datos--
  type Ingrediente = String
  type Cajon = Ingrediente
  type Dispenser = (Ingrediente,Int)
  
  data Helado = Helado {
     gusto :: String,
     temperatura :: Int,
     ingredientes :: [Ingrediente]
  } deriving (Show)
  
  -- =============================================================================
  
  -- FUNCION 2.1 Helados bien y mal preparados
  heladoBienPreparado :: Helado->Bool
  heladoBienPreparado helado | ((<=(-10)).temperatura) helado && (empiezaConChocolate.gusto) helado = True
                             | ((<=(-5)).temperatura) helado && (tieneAgua.ingredientes) helado = True
                             | (cantidadIngredientesNeg.ingredientes) helado >= temperatura helado && (not.empiezaConChocolate.gusto) helado = True
                             | otherwise = False  
  
                          ------------Funciones Adicionales------------                             
  empiezaConChocolate :: String->Bool
  empiezaConChocolate  = ((== "chocolate").take 9)

  cantidadIngredientesNeg :: [Ingrediente]->Int
  cantidadIngredientesNeg ingredientes =  -(length ingredientes)

  -- FUNCION 2.2.1 Heladera
  heladera :: Helado->Int->Helado
  heladera (Helado gusto temperatura ingredientes) grados = Helado gusto (temperatura-grados) ingredientes                                           

  -- FUNCION 2.2.2 Agregadora
  agregadora :: String->Helado->Helado
  agregadora nuevoIngrediente (Helado gusto temperatura ingredientes) = Helado gusto temperatura (cabezaStringAlFondo ((:) nuevoIngrediente ingredientes))

                          ------------Funciones Adicionales------------  
  cabezaStringAlFondo :: [String]->[String]
  cabezaStringAlFondo lista = (drop 1 lista) ++ (take 1 lista)

  -- FUNCION 2.2.3 Mixturadora
  mixturadora :: Helado -> Helado -> Helado
  mixturadora helado1 helado2 = Helado {
    gusto = (gusto helado1) ++ " y " ++ (gusto helado2),
    temperatura = min (temperatura helado1) (temperatura helado2),
    ingredientes = (sinRepetidos.(++) (ingredientes helado1)) (ingredientes helado2)
  }

  -- FUNCION 2.2.4 Batidora
  batidora :: Cajon -> Dispenser -> Helado -> Helado
  batidora cajon dispenser helado = Helado{
    gusto = cajon,
    temperatura = snd dispenser,
    ingredientes = (words.concatCajonDispenser cajon) dispenser
  }
  
                          ------------Funciones Adicionales------------
  concatCajonDispenser :: Cajon->Dispenser->String
  concatCajonDispenser cajon dispenser = cajon ++ " " ++ (fst dispenser)

  -- FUNCION 2.2.5 Choripasteadora
  choripasteadora :: Helado->Helado
  choripasteadora helado = Helado{
    gusto = gusto helado ++ " de la casa",
    temperatura = temperatura helado,
    ingredientes = insertarEsenciaYAgua $ ingredientes helado
  }
  
                          ------------Funciones Adicionales------------
  insertarEsenciaYAgua :: [Ingrediente]->[Ingrediente]
  insertarEsenciaYAgua ingrediente | tieneAgua ingrediente && tieneEsenciaArtificial ingrediente = ingrediente
                                   | not (tieneEsenciaArtificial ingrediente) && tieneAgua ingrediente = cabezaStringAlFondo ((:) "Esencia Artificial" ingrediente)
                                   | not (tieneAgua ingrediente) && tieneEsenciaArtificial ingrediente = cabezaStringAlFondo ((:) "Agua" ingrediente)
                                   | otherwise = (cabezaStringAlFondo . (:) "Esencia Artificial" . cabezaStringAlFondo . (:) "Agua") ingrediente
  
  tieneEsenciaArtificial :: [Ingrediente]->Bool
  tieneEsenciaArtificial = (elem "Esencia Artificial")                                
                              
  -- FUNCION 2.2.6 Tipo Maquina
  type Maquina = Helado -> Helado 

  -- FUNCION 2.2.7 Helado Neutro
  dispenser5 :: Dispenser
  dispenser5 = ("Agua", -5)
  
  heladoNeutro :: Helado
  heladoNeutro = Helado {
    gusto = "",
    temperatura = (0),
    ingredientes = []
  }
  
  transformarHeladoNeutro :: Helado->Helado
  transformarHeladoNeutro helado = (agregadora "Azucar" . flip heladera 5 . batidora "Frutilla" dispenser5) helado
  -- ** EXPLICACION DEL PUNTO ** --
  -- Aparece el concepto de aplicación parcial con el fin de permitir la composición entre las funciones:
  -- Tanto las funciones batidora, heladera y agregadora requieren utilizar al parametro "helado"
  -- Por eso, aplicamos parcialmente los demas parametros (independientes de cada funcion) y fuera del parentesis utilizamos el parametro "helado" que se utilizara en cada funcion compuesta dentro de los mismos
  ---------------------------------

  -- FUNCION 2.3 Chocolate infinito
  chocolateInfinito :: Helado
  chocolateInfinito = Helado {
    gusto = "chocolate infinito",
    temperatura = (-4),
    ingredientes = ["Azucar", "Leche"] ++ (repeat "chocolate")
  }

  -- FUNCION 2.4.1 Cinta Transportadora
  cintaTransportadora :: [Maquina]->Helado
  cintaTransportadora maquinas = foldl (\heladoNeutro maquina -> maquina heladoNeutro) heladoNeutro maquinas 
  -- ** EXPLICACION DEL PUNTO ** --
  -- En este caso, la aplicación parcial aparece en la definición de cada máquina
  -- A cada una de estas le falta un parámetro por pasar, que será el helado que entrara en la maquina para recibir una modificacion
  ---------------------------------

  -- FUNCION 2.4.2 Maquinas que preparan bien
  maquinasQuePreparanBien :: Helado -> [Maquina] -> [Maquina]
  maquinasQuePreparanBien helado maquinas = filter (\maquina -> heladoBienPreparado $ maquina helado) maquinas

  -- FUNCION 2.4.3 Ingrediente Favorito (BONUS)
  type CantidadIngrediente = (Int, Ingrediente)

  ingredienteFavorito :: [Helado]->Ingrediente
  ingredienteFavorito helados = (ingredienteMasUtilizado.sumarIngrediente.crearTupla.obtenerListaIngredientes) helados

                          ------------Funciones Adicionales------------
  obtenerListaIngredientes :: [Helado] -> [Ingrediente]
  obtenerListaIngredientes helados = (concat.map (sinRepetidos.ingredientes)) helados

  crearTupla :: [Ingrediente]->[CantidadIngrediente]
  crearTupla ingredientes = map (\ingrediente -> (0, ingrediente)) ingredientes
  
  sumarIngrediente :: [CantidadIngrediente]->[CantidadIngrediente]
  sumarIngrediente tuplas = map (\tupla -> (sacarCantidad tupla tuplas, snd tupla)) tuplas 

  sacarCantidad :: CantidadIngrediente->[CantidadIngrediente]->Int
  sacarCantidad tupla listaTuplas = fst $ foldl (\tuplaNormal tuplaLista -> if (snd tuplaNormal == snd tuplaLista) then (fst tuplaNormal + 1, snd tuplaNormal) else (fst tuplaNormal, snd tuplaNormal)) tupla listaTuplas 

  ingredienteMasUtilizado :: [CantidadIngrediente]->Ingrediente
  ingredienteMasUtilizado listaTuplas = (snd.foldl max (1,"Misma Cantidad de Ingredientes")) listaTuplas

  -- =============================================================================

--------- FUNCIONES GLOBALES (Aquellas que utilizamos en mas de 1 ejercicio) ---------
  tieneAgua :: [Ingrediente]->Bool
  tieneAgua = (elem "Agua")

  sinRepetidos :: [Ingrediente] -> [Ingrediente]
  sinRepetidos [x] = [x]
  sinRepetidos (ingrediente:ingredientes) | (not.elem ingrediente) ingredientes = ingrediente : sinRepetidos ingredientes
                                          | otherwise = sinRepetidos ingredientes                                   