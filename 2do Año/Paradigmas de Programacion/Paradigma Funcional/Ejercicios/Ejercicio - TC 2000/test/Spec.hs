import PdePreludat
import Library
import Test.Hspec

import Data.List (isPrefixOf)
import Data.List (isPrefixOf, sortBy)

main :: IO ()
main = hspec $ do
  -- FUNCION 2.1 Helados Bien y Mal Preparados
  describe "[Campeonato de TC 2000] Temporada 2018" $ do
    it "El campeon de la temporada 2018 fue Urcera, con 86.0 puntos" $ do
      (head $ tablaPosiciones carreras) `shouldBe` ("Urcera", 86.0)