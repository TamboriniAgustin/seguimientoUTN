import random
import math
import time
import numpy
from datetime import datetime, timedelta

RED = '\033[91m'
GREEN = '\033[92m'
YELLOW = '\033[93m'
BLUE = '\033[94m'
RESET = '\033[0m'

### C.I. ###

# VARIABLES DE CONTROL
N = 0
H = 0
IPC = 0
VC = 0
M = 0

INS_PETICION = 50000 #cantidad instrucciones promedio por peticion
MEM_PETICION = 10 #cantidad memoria promedio por peticion (KB)

# VARIABLES DE RESULTADO
CVCS = 0
PRF = 0
PCF = 0
PPR = 0

# VARIABLES DE ESTADO
P = 0

# VARIABLES AUXILIARES
T=0
#TF = 24 * 365 * 10 # 10 años de simulación 24 horas al dia
TF = 24*4
FECHA_INICIAL = datetime(2024, 12, 22)
SPRF = 0 #sumatoria
SPCF = 0 #sumatoria
SPPR = 0 #sumatoria
DDOS_FLAG = False
MANTENIMIENTO_ACTIVO = 0
CAP_CPU = 0
CAP_RAM = 0

HV = 9999999999999

while True:
    try:
        ### VARIABLES DE CONTROL ###
        M = int(input("Cantidad de memoria RAM en KB (M): "))
        N = int(input("Cantidad de nucleos (N): "))
        H = int(input("Cantidad de hilos (H): "))
        VC = int(input("Velocidad clock en Hz, NO en Ghz (VC): "))
        IPC = int(input("Cantidad de instrucciones por ciclo (IPC): "))
        CAP_CPU = (N*H*IPC*VC*3600)/(INS_PETICION)
        CAP_RAM = (M/MEM_PETICION)

        break
    except ValueError:
        print("\nError: Solo se permiten numeros enteros.\n")
        continue

# FDP POISSON CON LAMBDA = (3000+1000) / 2 = 2000
def obtener_PH(): #Peticiones por Hora
    LAMBDA = 2000
    FDP = numpy.random.poisson(LAMBDA)
    return FDP 

# 0.08% de probabilidad de recibir ataque DDoS por hora
def ocurrencia_ataque_DDoS():
    global DDOS_FLAG
    probabilidad = numpy.random.rand()

    if (probabilidad < 0.08):
        DDOS_FLAG = True
    else:
        DDOS_FLAG = False

def obtener_hora():
    global T
    return T % 24

def obtener_fecha():
    global T, FECHA_INICIAL
    cant_dias = T // 24
    cant_horas_restantes = obtener_hora()
    fecha_actual = FECHA_INICIAL + timedelta(days=cant_dias, hours=cant_horas_restantes)
    return fecha_actual
    
def es_comienzo_trimestre():
    mes = obtener_fecha().month
    dia = obtener_fecha().day
    
    return (mes == 1 and dia == 1) or (mes == 4 and dia == 1) or (mes == 7 and dia == 1) or (mes == 10 and dia == 1)
    
def es_comienzo_mes():
    dia = obtener_fecha().day
    return dia == 1

def porcentaje_aumento_evento(mes_evento, dia_evento):
    fecha = obtener_fecha()
    evento = datetime(fecha.year, mes_evento, dia_evento)

    if fecha.day == dia_evento and fecha.month == mes_evento:
        return 1.15
    else:
        return 1
    
def porcentaje_aumento_evento_anticipado(mes_evento, dia_evento):
    fecha = obtener_fecha()
    evento = datetime(fecha.year, mes_evento, dia_evento)

    dias_restantes = (evento-fecha).days
    
    if dias_restantes >= 0:
        return 1+0.15*(-dias_restantes+5)
    else:
        return 1
    

def mantenimiento():
    global CAP_CPU, CAP_RAM, MANTENIMIENTO_ACTIVO
    CAP_CPU = CAP_CPU*0.8
    CAP_RAM = CAP_RAM*0.8
    MANTENIMIENTO_ACTIVO = 2
    
def sin_mantenimiento():
    global CAP_CPU, CAP_RAM, MANTENIMIENTO_ACTIVO
    CAP_CPU = CAP_CPU/0.8
    CAP_RAM = CAP_RAM/0.8
    MANTENIMIENTO_ACTIVO = 0

def resultados():
    global T, SPPR, SPCF,SPRF

    if(CVCS!=0):
        PRF = (SPRF * MEM_PETICION) / (CVCS)
        PCF = (SPCF * INS_PETICION) / (CVCS * 3600)
        PPR = SPPR / CVCS
    else:
        PRF = 0
        PCF = 0
        PPR = 0

    print(f"Cantidad de veces capacidad del servidor superada {CVCS}")
    print(f"Promedio de capacidad de RAM faltante (KB): {PRF}")
    print(f"Promedio de capacidad de CPU faltante : {PCF}")
    print(f"Promedio peticiones rechazadas: {PPR}")


def realizar_simulacion():
    global T, P, CAP_CPU, CAP_RAM, CVCS, MANTENIMIENTO_ACTIVO, SPPR, SPCF,SPRF
    while True:
        fecha = obtener_fecha()
        
        ### AVANZO EN EL TIEMPO EN UN DELTA T ###

        print(f"{BLUE}Fecha: {fecha}{RESET}")
        
        T=T+1

        ### GENERO, CALCULO O USO TODO LO QUE ENTRA ###

        ph = obtener_PH() #OK
        
        #PH horas pico #OK
        
        if obtener_hora() in [18, 19, 20, 21, 22]: 
            ph = ph * 3
        
        #PH ante ocurrencia de ataque DDOS

        ocurrencia_ataque_DDoS()

        if (DDOS_FLAG):
            print(f"{YELLOW}DDOS{RESET}")
            ph = ph * 10
            
        #PH ante dia festivo #OK
        
        a1 = porcentaje_aumento_evento_anticipado(11, 20)
        a2 = porcentaje_aumento_evento_anticipado(6, 1)
        a3 = porcentaje_aumento_evento_anticipado(10, 1)
        a4 = porcentaje_aumento_evento_anticipado(12, 24)
        
        a5 = porcentaje_aumento_evento(11, 29)
        a6 = porcentaje_aumento_evento(5, 13)
        a7 = porcentaje_aumento_evento(5, 14)
        a8 = porcentaje_aumento_evento(5, 15)
        a9 = porcentaje_aumento_evento(12, 2)

        ph = ph*a1*a2*a3*a4*a5*a6*a7*a8*a9
        
        #PH ante evento trimestral #OK
        if es_comienzo_trimestre() == True:
            print(f"{BLUE}COMIENZO MES{RESET}")
            ph = ph * 15
        

        ### GENERO, CALCULO O USO TODO LO QUE SALE ###
        
        #mantenimiento activo

        """
        if MANTENIMIENTO_ACTIVO >= 1:
            MANTENIMIENTO_ACTIVO = MANTENIMIENTO_ACTIVO - 1
        else:
            sin_mantenimiento()
            
        #mantenimiento mensual
        
        if es_comienzo_mes() == True:
            mantenimiento()
            
        #mantenimiento por ataque ddos
        
        if MANTENIMIENTO_ACTIVO == 0 and (ph >= 2*CAP_CPU or ph >= 2*CAP_RAM):
            mantenimiento()
        """
        ### MODIFICO VAR DE ESTADO CON TODO LO QUE SALE Y ENTRA ###

        print(f"PH: {ph}")
       
        print(f"CPU: {CAP_CPU}")
        print(f"RAM: {CAP_RAM}")

        P = min(CAP_CPU, CAP_RAM) - ph
        print(f"P: {P}")
        #hay rechazados

        if P<0:
            print(f"{RED}T: {T}{RESET}")
            CVCS = CVCS + 1
            SPPR = SPPR + abs(P)

            if ph>CAP_CPU:
                SPCF += ph - CAP_CPU

            if ph>CAP_RAM:
                SPRF += ph - CAP_RAM
        else:
            print(f"{GREEN}T: {T}{RESET}")
                
        P = 0

        if T < TF:
            continue
        else:
            break

    resultados()


def main():
    print("\n\n### Comenzando simulacion ###\n\n")
    realizar_simulacion()
    print("\nFinalizando simulacion...")


if __name__ == "__main__":
    main()
