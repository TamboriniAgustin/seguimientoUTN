import PdePreludat
import Library
import Test.Hspec

import Data.List (isPrefixOf)
import Data.List (isPrefixOf, sort)


 ------- Casos de Prueba --------

--Gustos de Helado--
chocolateIntenso :: Helado
chocolateIntenso = Helado {
  gusto = "chocolate intenso",
  temperatura = (-22),
  ingredientes = ["Leche", "Chocolate", "Nesquik"]
}

chocolateIntenso2 :: Helado
chocolateIntenso2 = Helado {
  gusto = "chocolate intenso",
  temperatura = (-10),
  ingredientes = ["Azucar", "Hielo", "Crema"]
}

chocolateIntenso3 :: Helado
chocolateIntenso3 = Helado {
  gusto = "chocolate intenso",
  temperatura = (-2),
  ingredientes = ["Chocolate Amargo", "Crema", "Dulce de Leche"]
}

frutillaAlAgua :: Helado
frutillaAlAgua = Helado{
  gusto = "frutilla al agua",
  temperatura = (-6),
  ingredientes = ["Frutilla", "Agua"]
}

frutillaAlAgua2 :: Helado
frutillaAlAgua2 = Helado{
  gusto = "frutilla al agua",
  temperatura = (-5),
  ingredientes = ["Frutilla", "Agua"]
}

frutillaAlAgua3 :: Helado
frutillaAlAgua3 = Helado{
  gusto = "frutilla al agua",
  temperatura = (-3),
  ingredientes = ["Frutilla", "Agua", "Chispas de Chocolate", "Crema"]
}

frutilla :: Helado
frutilla = Helado{
  gusto = "frutilla",
  temperatura = (-3),
  ingredientes = ["Frutilla", "Leche", "Chispas de Chocolate"]
}

frutilla2 :: Helado
frutilla2 = Helado{
  gusto = "frutilla",
  temperatura = (-2),
  ingredientes = ["Frutilla", "Leche"]
}

frutilla3 :: Helado
frutilla3 = Helado{
  gusto = "frutilla",
  temperatura = (-1),
  ingredientes = ["Frutilla", "Leche"]
}

durazno :: Helado
durazno = Helado{
  gusto = "durazno",
  temperatura = (-2),
  ingredientes = ["Durazno", "Agua", "Azucar"]
}

listaHelados = [
  Helado "pistacho" 2 ["pistacho", "leche", "agua"],
  Helado "frutilla" (-2) ["frutilla", "leche"],
  Helado "dulce de leche" (-1) ["dulce de leche", "agua"],
  Helado "agua" 0 ["agua"]
  ]
  
--Cajones--
cajonBanana :: Cajon
cajonBanana = "Banana"

cajonFrutilla :: Cajon
cajonFrutilla = "Frutilla"

cajonPera :: Cajon
cajonPera = "Pera"

cajonAnana :: Cajon
cajonAnana = "Anana"

--Dispensers--
dispenser4 :: Dispenser
dispenser4 = ("Agua",-4)

  -- *** dispenser5 (definido en Library)

dispenser25 :: Dispenser
dispenser25 = ("Agua", -25)

--Maquinas--
maquinaNeutra :: Maquina
maquinaNeutra helado = heladoNeutro

maquinaAgregadoraAzucar :: Maquina
maquinaAgregadoraAzucar = agregadora "Azucar"

maquinaAgregadoraFrutilla :: Maquina
maquinaAgregadoraFrutilla = agregadora "Frutilla"

maquinaHeladeraEnfria5 :: Maquina
maquinaHeladeraEnfria5 = flip heladera 5

maquinaHeladeraCalienta10 :: Maquina
maquinaHeladeraCalienta10 = flip heladera (-10)

maquinaBatidoraFrutilla5 :: Maquina
maquinaBatidoraFrutilla5 = batidora cajonFrutilla dispenser5

maquinaBatidoraAnana25 :: Maquina
maquinaBatidoraAnana25 = batidora cajonAnana dispenser25

maquinaMixturadoraNeutro :: Maquina
maquinaMixturadoraNeutro = mixturadora heladoNeutro

listaMaquina1 = [maquinaBatidoraFrutilla5, maquinaHeladeraEnfria5, maquinaAgregadoraAzucar]
listaMaquina2 = [maquinaAgregadoraFrutilla, maquinaHeladeraEnfria5, maquinaHeladeraCalienta10,maquinaBatidoraAnana25,maquinaMixturadoraNeutro]

main :: IO ()
main = hspec $ do
  -- FUNCION 2.1 Helados Bien y Mal Preparados
  describe "[Helados Bien y Mal Preparados] Chocolate Intenso" $ do
    it "El sabor chocolate intenso se encuentra a -22°C, está bien preparado" $ do
      (heladoBienPreparado chocolateIntenso) `shouldBe` True

  describe "[Helados Bien y Mal Preparados] Chocolate Intenso 2" $ do
   it "El sabor chocolate intenso se encuentra a -10°C, está bien preparado" $ do
      (heladoBienPreparado chocolateIntenso2) `shouldBe` True

  describe "[Helados Bien y Mal Preparados] Chocolate Intenso 3" $ do
   it "El sabor chocolate intenso se encuentra a -2°C, está mal preparado" $ do
    (heladoBienPreparado chocolateIntenso3) `shouldBe` False
  
  describe "[Helados Bien y Mal Preparados] Frutilla al Agua 1" $ do
   it "El sabor frutilla al agua se encuentra a -6°C, está bien preparado" $ do
    (heladoBienPreparado frutillaAlAgua) `shouldBe` True  

  describe "[Helados Bien y Mal Preparados] Frutilla al Agua 2" $ do
   it "El sabor frutilla al agua se encuentra a -5°C, está bien preparado" $ do
    (heladoBienPreparado frutillaAlAgua2) `shouldBe` True
    
  describe "[Helados Bien y Mal Preparados] Frutilla al Agua 3" $ do
   it "El sabor frutilla al agua se encuentra a -3°C, está mal preparado" $ do
    (heladoBienPreparado frutillaAlAgua3) `shouldBe` False

  describe "[Helados Bien y Mal Preparados] Frutilla 1" $ do
   it "El sabor frutilla se encuentra a -3°C, está bien preparado" $ do
    (heladoBienPreparado frutilla) `shouldBe` True

  describe "[Helados Bien y Mal Preparados] Frutilla 2" $ do
   it "El sabor frutilla se encuentra a -2°C, está bien preparado" $ do
    (heladoBienPreparado frutilla2) `shouldBe` True

  describe "[Helados Bien y Mal Preparados] Frutilla 3" $ do
   it "El sabor frutilla se encuentra a -1°C, está mal preparado" $ do
    (heladoBienPreparado frutilla3) `shouldBe` False
    
  -- FUNCION 2.2.1 Heladera
  describe "[Heladera] Frutilla al Agua (-6°C)" $ do
    it "El sabor frutilla al agua fue enfriado 5°C y ahora se encuentra a -11°C" $ do
     temperatura (heladera frutillaAlAgua 5) `shouldBe` (-11)

  describe "[Heladera] Chocolate Intenso (-2°C)" $ do
   it "El sabor chocolate intenso fue enfriado 8 grados y ahora se encuentra bien preparado" $ do
    heladoBienPreparado (heladera chocolateIntenso3 8) `shouldBe` True

  -- FUNCION 2.2.2 Agregadora
  describe "[Agregadora] Chocolate Intenso (-22°C)" $ do
    it "Al sabor chocolate intenso se le agrego crema, por lo que ahora tiene 4 ingredientes" $ do
      length (ingredientes $ agregadora "Crema" chocolateIntenso) `shouldBe` 4

  describe "[Agregadora] Chocolate Intenso (-22°C)" $ do
   it "El último ingrediente añadido al sabor chocolate intenso es crema" $ do
    (head . reverse . ingredientes $ agregadora "Crema" chocolateIntenso) `shouldBe` "Crema"

  -- FUNCION 2.2.3 Mixturadora
  describe "[Mixturadora] Frutilla al Agua (-6°C) y Durazno" $ do
    it "El gusto resultante de mezclar ambos helados es frutilla al agua y durazno" $ do
      (gusto.mixturadora frutillaAlAgua) durazno `shouldBe` "frutilla al agua y durazno"

  describe "[Mixturadora] Frutilla al Agua (-6°C) y Durazno" $ do
    it "La temperatura del helado es de -6°C" $ do
      (temperatura.mixturadora frutillaAlAgua) durazno `shouldBe` (-6)

  describe "[Mixturadora] Frutilla al Agua (-6°C) y Durazno" $ do  
    it "Los ingredientes de la mezcla son agua, azucar, durazno y frutilla" $ do 
      (sort.ingredientes.mixturadora frutillaAlAgua) durazno `shouldBe` ["Agua", "Azucar", "Durazno", "Frutilla"]
 
  -- FUNCION 2.2.4 Batidora
  describe "[Batidora] Cajon de Banana, Dispenser (-4°C) y Helado Neutro" $ do
    it "El gusto del helado es banana" $ do
      (gusto.batidora cajonBanana dispenser4) heladoNeutro `shouldBe` "Banana"

  describe "[Batidora] Cajon de Banana, Dispenser (-4°C) y Helado Neutro" $ do  
    it "La temperatura del helado es de -4°C" $ do
      (temperatura.batidora cajonBanana dispenser4) heladoNeutro `shouldBe` (-4)
    
  describe "[Batidora] Cajon de Banana, Dispenser (-4°C) y Helado Neutro" $ do  
    it "Los ingredientes del helado ahora son agua y banana" $ do
      (sort.ingredientes.batidora cajonBanana dispenser4) heladoNeutro `shouldBe` ["Agua", "Banana"]

  -- FUNCION 2.2.5 Choripasteadora
  describe "[Choripasteadora] Chocolate Intenso (-22°C)" $ do
    it "El sabor chocolate intenso es exclusivo de la casa" $ do
     (gusto $ choripasteadora chocolateIntenso) `shouldBe` "chocolate intenso de la casa"

  describe "[Choripasteadora] Chocolate Intenso (-22°C)" $ do
   it "Los ingredientes del chocolate intenso de la casa son: Agua, Chocolate, Esencia Artificial, Leche y Nesquik" $ do
    (sort . ingredientes $ choripasteadora chocolateIntenso) `shouldBe` ["Agua", "Chocolate", "Esencia Artificial", "Leche", "Nesquik"]
  
  -- FUNCION 2.2.7 Helado Neutro
  describe "[Helado Neutro] Helado Neutro" $ do
    it "El helado neutro paso a tener un sabor a frutilla" $ do
     (gusto $ transformarHeladoNeutro heladoNeutro) `shouldBe` "Frutilla" 

  describe "[Helado Neutro] Helado Neutro" $ do
    it "La temperatura del helado neutro disminuyo a -10°C tras batirlo con frutilla y ponerlo en la heladera" $ do
      (temperatura $ transformarHeladoNeutro heladoNeutro) `shouldBe` (-10)    

  describe "[Helado Neutro] Helado Neutro" $ do
    it "El helado neutro ahora contiene azucar entre sus ingredientes" $ do
     (elem "Azucar" . ingredientes $ transformarHeladoNeutro heladoNeutro) `shouldBe` True    

  -- FUNCION 2.3 Chocolate infinito
  describe "[Chocolate infinito] Chocolate Infinito" $ do
    it "La temperatura del helado chocolate infinito es de -6°C" $ do
      (temperatura.heladera chocolateInfinito) 2 `shouldBe` (-6)
  
  -- FUNCION 2.4.1 Cinta Transportadora
  describe "[Cinta Transportadora] Helado Neutro - Temperatura Final" $ do
    it "El helado neutro paso a tener una temperatura de -10°C" $ do
     (temperatura $ cintaTransportadora listaMaquina1) `shouldBe` (-10)

  describe "[Cinta Transportadora] Helado Neutro - Ingredientes Finales" $ do
    it "El helado neutro paso a tener los ingredientes Agua, Frutilla y Azucar" $ do
     (sort . ingredientes $ cintaTransportadora listaMaquina1) `shouldBe` ["Agua", "Azucar", "Frutilla"]

  -- FUNCION 2.4.2 Maquinas que preparan bien
  describe "[Maquinas que preparan bien] Frutilla al Agua (-5°C)" $ do
    it "La cantidad de maquinas que preparan bien el helado de frutilla al agua es: 4" $ do
      (length $ maquinasQuePreparanBien frutillaAlAgua2 listaMaquina2) `shouldBe` 4

  describe "[Maquinas que preparan bien] Chocolate Intenso (-2°C)" $ do
    it "La cantidad de maquinas que preparan bien el helado de chocolate intenso es: 1" $ do
      (length $ maquinasQuePreparanBien chocolateIntenso3 listaMaquina2) `shouldBe` 1

  -- FUNCION 2.4.3 Ingrediente Favorito
  describe "[Ingrediente Favorito] Lista de Helados: Pistacho, Frutilla, Dulce de Leche, Agua" $ do
    it "El ingrediente mas utilizado entre todos los helados es: Agua" $ do
      (ingredienteFavorito listaHelados) `shouldBe` "agua"