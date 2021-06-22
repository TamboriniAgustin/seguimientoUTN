import Prelude
import Text.Show.Functions

type Recurso = String

---------- Ejercicio 1 ------------
-- A --
data Pais = Pais{
    ingresoPerCapita::Float,
    sectorPublico::Int,
    sectorPrivado::Int,
    recursosNaturales::[Recurso],
    deuda::Float
} deriving(Eq, Show)
-- B --
namibia = Pais{
    ingresoPerCapita = 4140,
    sectorPublico = 400000,
    sectorPrivado = 650000,
    recursosNaturales = ["Mineria", "Ecoturismo"],
    deuda = 50000000 
}

---------- Ejercicio 2 ------------
prestarDinero::Float->Pais->Pais
prestarDinero dineroPrestado pais = pais{
    deuda = deuda pais + dineroPrestado * 1.5
}

reducirPuestosDeTrabajo::Int->Pais->Pais
reducirPuestosDeTrabajo cantidadPuestos pais = pais{
    ingresoPerCapita = disminuirIngresoPerCapita cantidadPuestos (ingresoPerCapita pais),
    sectorPublico = sectorPublico pais - cantidadPuestos
}

prestarRecursoAlFMI::Recurso->Pais->Pais
prestarRecursoAlFMI recurso pais = pais{
    recursosNaturales = quitarRecurso recurso (recursosNaturales pais),
    deuda = deuda pais - 2000000
}

establecerBlindaje::Pais->Pais
establecerBlindaje pais = (reducirPuestosDeTrabajo 500 . flip prestarDinero pais . calcularProductoBrutoInterno) pais

-- Funciones Auxiliares --
disminuirIngresoPerCapita::Int->Float->Float
disminuirIngresoPerCapita puestosDisminuidos ingresoActual | puestosDisminuidos > 100 = ingresoActual - ingresoActual * 0.2
                                                           | otherwise = ingresoActual - ingresoActual * 0.15

quitarRecurso::Recurso->[Recurso]->[Recurso]
quitarRecurso recurso listaRecursos = filter (\recursoActual -> recurso /= recursoActual) listaRecursos

calcularProductoBrutoInterno::Pais->Float
calcularProductoBrutoInterno pais = (ingresoPerCapita pais * fromIntegral (sectorPublico pais + sectorPrivado pais)) / 2

---------- Ejercicio 3 ------------
-- A --
type Receta = [Pais->Pais]

receta::Receta
receta = [prestarDinero 200000000, prestarRecursoAlFMI "Mineria"]
-- B --
recetaANamibia::Receta->Pais
recetaANamibia receta = foldl (\pais accion -> accion pais) namibia receta
{- El efecto colateral aparece en cada funcion que es parte de la receta, ya que cada una altera un valor del pais pasado por defecto -}

---------- Ejercicio 4 ------------
-- A --
paisesQueZafan::[Pais]->[Pais]
paisesQueZafan paises = filter (\pais -> elem "Petroleo" (recursosNaturales pais)) paises
-- B --
deudaTotalAFavor::[Pais]->Float
deudaTotalAFavor paises = (sum . map (\pais -> deuda pais)) paises
-- C --
{- 
    Ambos conceptos aparecen dentro del parentesis, ya que a la funcion sum le falta un parametro
    que es una lista, por lo tanto, esta aplicada parcialmente. Por esto, aplicamos composicion a la funcion map,
    a la que tambien le falta el parametro de la lista de paises por lo que aqui tambien se usa aplicacion parcial.
    La lista de paises es pasada como parametro inicial fuera del parentesis. La ventaja de utilizar orden superior
    es que puedo transformar directamente la lista de paises en una lista con las deudas de cada uno y luego 
    sumarlas, sin tener que averiguar la deuda de cada pais por separado, lo que generaria un proceso mas largo.
-}

---------- Ejercicio 5 ------------
-- [Receta] = [[Pais->Pais]]
estaOrdenado::Pais->[Receta]->Bool
estaOrdenado pais [receta] = True
estaOrdenado pais (receta1:receta2:recetasig) = ((calcularProductoBrutoInterno $ aplicarReceta receta1 pais) <= (calcularProductoBrutoInterno $ aplicarReceta receta2 pais)) && estaOrdenado pais (receta2:recetasig)

-- Funciones Auxiliares --
aplicarReceta::Receta->Pais->Pais
aplicarReceta receta paisAAplicar = foldl (\pais accion -> accion pais) paisAAplicar receta

---------- Ejercicio 6 ------------
-- A --
{- 
    En este caso el programa no funcionaria, ya que al acceder a la lista de recursos naturales para ver si 
    un elemento se encuentra allí, estaría evaluando infinitamente. En este caso no podemos aplicar evaluación diferida 
-}
-- B --
{- 
    En este caso el programa funcionaria de igual forma, ya que no accede a la lista de recursos naturales en ningun
    momento. La evaluación diferida puede aplicarse sin ningun problema.
-}