import Prelude
import Text.Show.Functions

--------------------------- Ejercicio 1 ---------------------------
type Onomatopeya = String
type Intensidad = Int

type Grito = (Onomatopeya, Intensidad, Bool)

energiaDeGrito::Grito->Int
energiaDeGrito grito | mojoLaCama grito = nivelDeTerror grito * ((^2).intensidad)grito
                     | otherwise = ((3*) . nivelDeTerror) grito + intensidad grito

-- Funciones Auxiliares --
mojoLaCama::Grito->Bool
mojoLaCama (_, _, muchoMiedo) = muchoMiedo

onomatopeya::Grito->Onomatopeya
onomatopeya (onomatopeya, _, _) = onomatopeya

intensidad::Grito->Intensidad
intensidad (_, intensidad, _) = intensidad

nivelDeTerror::Grito->Int
nivelDeTerror = length.onomatopeya

--------------------------- Ejercicio 2 ---------------------------
type Nombre = String
type Edad = Int
type Altura = Float

type Chico = (Nombre, Edad, Altura)
type Monstruo = Chico->Grito

sullivan::Monstruo
sullivan (nombre, edad, _) = (obtenerOnomatopeya nombre, div 20 edad, edad<3)

randallBogs::Monstruo
randallBogs (nombre, _, altura) = ("Mamadera", obtenerVocales nombre, altura>=0.8 && altura<=1.2)

chuckNorris::Monstruo
chuckNorris _ = ("ABCDEFGHIJKLMNÑOPQRSTUVWXYZ", 1000, True)

ositoCarinioso::Monstruo
ositoCarinioso (_, edad, _) = ("Uf", edad, False)

-- Funciones Auxiliares --
nombre::Chico->Nombre
nombre (nombre, _, _) = nombre

edad::Chico->Edad
edad (_, edad, _) = edad

altura::Chico->Altura
altura (_, _, altura) = altura

obtenerOnomatopeya::Nombre->Onomatopeya
obtenerOnomatopeya nombreChico = map (\caracter -> 'A') nombreChico ++ "GH"

obtenerVocales::Nombre->Int
obtenerVocales nombreChico = (length . filter (\caracter -> caracter=='A'||caracter=='a'||caracter=='E'||caracter=='e'||caracter=='I'||caracter=='i'||caracter=='O'||caracter=='o'||caracter=='U'||caracter=='u')) nombreChico

--------------------------- Ejercicio 3 ---------------------------
type Funcion = Int->Int

pasarPorListaFunciones::[Funcion]->Int->[Int]
pasarPorListaFunciones lista elemento = map (\funcion -> funcion elemento) lista

--------------------------- Ejercicio 4 ---------------------------
asustarEnEquipo::[Monstruo]->Chico->[Grito]
asustarEnEquipo monstruos chico = map (\monstruo -> monstruo chico) monstruos

--------------------------- Ejercicio 5 ---------------------------
produccionEnergeticaDeGritos::[Monstruo]->[Chico]->Int
produccionEnergeticaDeGritos monstruos chicos = (sum . map energiaDeGrito . asustarCampamento monstruos) chicos

-- Funciones Auxiliares --
asustarCampamento::[Monstruo]->[Chico]->[Grito]
asustarCampamento monstruos chicos = (concat . map (\chico -> asustarEnEquipo monstruos chico)) chicos

--------------------------- Ejercicio 6 ---------------------------
type Duracion = Float

type Risa = (Duracion, Intensidad)

type Comediante = Chico->Risa

capusotto::Chico->Risa
capusotto (_, edad, _) = (2.0*fromIntegral edad, edad*fromIntegral 2)

chaplin::Chico->Risa
chaplin (_, edad, altura) = (altura+fromIntegral edad, edad^1)

produccionEnergeticaDeRisas::[Comediante]->[Chico]->Float
produccionEnergeticaDeRisas comediantes chicos = (sum . map energiaDeRisa . divertirCampamento comediantes) chicos

-- Funciones Auxiliares --
energiaDeRisa::Risa->Float
energiaDeRisa (duracion, intensidad) = duracion ^ fromIntegral intensidad

divertirCampamento::[Comediante]->[Chico]->[Risa]
divertirCampamento comediantes chicos = (concat . map (\chico -> divertirEnEquipo comediantes chico)) chicos

divertirEnEquipo::[Comediante]->Chico->[Risa]
divertirEnEquipo comediantes chico = map (\comediante -> comediante chico) comediantes

--------------------------- Ejercicio 7 ---------------------------