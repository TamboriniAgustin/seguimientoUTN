#include <iostream>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
using namespace std;

struct Goles{
	int ID_gol;
	int CEquipo;
	int fecha;
	char NJugador[20];
	int ID_partido;
};

struct ListaGoles{
	char jugador[20];
	int fecha;
	int cantidadgoles;
	int equipo;
};

struct Nodo{
	ListaGoles info;
	Nodo *sig;
};

void LeerArchivo();
long CantidadRegistros(FILE *,int);

void CrearMenu(Goles [], int[],int [], long);

void ListadoEquiposyGoles(int [], int []);

void ListadoGoleadoresxFecha(Goles [], long);
void CrearListadoxFecha(Nodo *&, ListaGoles);
void MostrarListadoxFecha(Nodo *);

void ListadoGoleadoresMundial(Goles [], long);
void CrearListadoMundial(Nodo *&, ListaGoles);
void MostrarListadoMundial(Nodo *);

void LimpiarListados(Nodo *&, ListaGoles &);

int main(){
	printf("********** Ejercicio 2 **********\n\n");
	 
	system("pause"); 
	system("cls");
	
	LeerArchivo();
	return 0;
}

void LeerArchivo(){
	Goles GOL;
	
	printf("**********\tRealizando lectura del archivo\t**********\n\n");
	system("pause");
	
	FILE *F = fopen("Goles","rb");
	
	long cantgoles = CantidadRegistros(F,sizeof(GOL)); //Obtenemos la cantidad de goles que se anotaron
	printf("*Tamaño del registro: %d - Generando vector de %d posiciones...\n\n",cantgoles,cantgoles);
	system("pause");
	
	Goles GOLES[cantgoles]; //Definimos un vector estatico del tamaño de la cantidad de goles anotados que contendra la informacion de cada uno
	int Equipo[32] = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32}; //Un vector que almacene el codigo de equipo correspondiente (1er punto)
	int GolEquipo[32] = {0}; //Un vector de tipo entero que permita acumular cuantos goles anoto cada uno de los equipos (1er punto)
	int i=0;
	
	fread(&GOL,sizeof(GOL),1,F);
	while(!feof(F)){
		GOLES[i] = GOL;
		
		switch(GOL.CEquipo){
			case 1: GolEquipo[0]++;
				break;
			case 2: GolEquipo[1]++;
				break;
			case 3: GolEquipo[2]++;
				break;
			case 4: GolEquipo[3]++;
				break;
			case 5: GolEquipo[4]++;
				break;
			case 6: GolEquipo[5]++;
				break;
			case 7: GolEquipo[6]++;
				break;
			case 8: GolEquipo[7]++;
				break;
			case 9: GolEquipo[8]++;
				break;
			case 10: GolEquipo[9]++;
				break;	
			case 11: GolEquipo[10]++;
				break;
			case 12: GolEquipo[11]++;
				break;
			case 13: GolEquipo[12]++;
				break;
			case 14: GolEquipo[13]++;
				break;
			case 15: GolEquipo[14]++;
				break;
			case 16: GolEquipo[15]++;
				break;
			case 17: GolEquipo[16]++;
				break;
			case 18: GolEquipo[17]++;
				break;
			case 19: GolEquipo[18]++;
				break;
			case 20: GolEquipo[19]++;
				break;
			case 21: GolEquipo[20]++;
				break;
			case 22: GolEquipo[21]++;
				break;
			case 23: GolEquipo[22]++;
				break;
			case 24: GolEquipo[23]++;
				break;
			case 25: GolEquipo[24]++;
				break;
			case 26: GolEquipo[25]++;
				break;
			case 27: GolEquipo[26]++;
				break;
			case 28: GolEquipo[27]++;
				break;
			case 29: GolEquipo[28]++;
				break;
			case 30: GolEquipo[29]++;
				break;
			case 31: GolEquipo[30]++;
				break;
			case 32: GolEquipo[31]++;
				break;																															
		}
		
		i++;
		fread(&GOL,sizeof(GOL),1,F);
	}
	
	fclose(F);
	CrearMenu(GOLES, Equipo, GolEquipo, cantgoles);
	
}

long CantidadRegistros(FILE *F,int tam){
	fseek(F,0,SEEK_SET);
	long TI = ftell(F);
	fseek(F,0,SEEK_END);
	long TF = ftell(F);
	fseek(F,0,SEEK_SET);
	long T = TF/tam;
	return T;
}

void CrearMenu(Goles DatoGol[], int Equipo[], int GolEquipo[], long cantgoles){
	int opcion;
	
	do{
		system("cls");
		printf("********************\tMENU\t********************");
		printf("\n1_Listado de equipos y sus goles\n2_Listado de goleadores por fecha\n3_Listado de goleadores del mundial\n4_Cerrar el programa\n\n");
		cin >> opcion;
		
		if(opcion==1) ListadoEquiposyGoles(Equipo,GolEquipo);
		else if(opcion==2) ListadoGoleadoresxFecha(DatoGol,cantgoles);
		else if(opcion==3) ListadoGoleadoresMundial(DatoGol,cantgoles);
	}
	while(opcion!=4);
}

void ListadoEquiposyGoles(int Equipo[], int GolEquipo[]){
	system("cls");
	
	int aux1=0, aux2=0;
	
	for(int pos=0;pos<32;pos++){
		for(int i=0;i<32-pos;i++){
			if(GolEquipo[i]<GolEquipo[i+1]){
				aux1 = Equipo[i];
				aux2 = GolEquipo[i];
				Equipo[i] = Equipo[i+1];
				GolEquipo[i] = GolEquipo[i+1];
				Equipo[i+1] = aux1;
				GolEquipo[i+1] = aux2;
			}
		}
	} //No ordenamos como listado ya que en este caso no es necesario hacerlo con estructuras dinamicas, si lo haremos para el 2do punto.
	for(int i=0;i<32;i++){
		printf("*El equipo %d convirtio %d goles en el mundial.\n",Equipo[i],GolEquipo[i]);
	}
	
	printf("\n");
	system("pause");
}

void ListadoGoleadoresxFecha(Goles DatoGol[], long cantgoles){
	system("cls");
	
	Goles aux[cantgoles];
	for(int i=0;i<cantgoles;i++){
		aux[i] = DatoGol[i];
	}
	
	int goljug = 1; //Una variable que almacene la cantidad de goles por jugador temporalmente
	ListaGoles infofecha; //Una variable de tipo ListaGoles para ingresar los datos al Nodo
	Nodo *listafecha = NULL;
	
	for(int i=0;i<cantgoles;i++){ //Realizamos un for que recorra la cantidad de goles que posee el archivo leido previamente
		for(int j=i+1;j<cantgoles;j++){ //Realizamos otro for para comparar cada uno de los goles y quedarnos con los que tienen fechas iguales
			if((DatoGol[i].fecha == DatoGol[j].fecha) && (DatoGol[i].fecha != 0)){
				if(strcmp(DatoGol[i].NJugador,DatoGol[j].NJugador)==0){
					goljug++;
					DatoGol[j].fecha = 0; //Seteamos la fecha en 0 para que no se vuelva a repetir el jugador cuando avanze en 'i'
				}
			}
		}
		if(DatoGol[i].fecha != 0) {
			infofecha.fecha = DatoGol[i].fecha;
			strcpy(infofecha.jugador,DatoGol[i].NJugador);
			infofecha.cantidadgoles = goljug;
			infofecha.equipo = DatoGol[i].CEquipo;
			CrearListadoxFecha(listafecha,infofecha);	
		}
		goljug = 1; //Reseteamos la variable para el proximo jugador
	}
	
	MostrarListadoxFecha(listafecha);
	while(listafecha!=NULL){
		LimpiarListados(listafecha,infofecha);
	}
	
	for(int i=0;i<cantgoles;i++){
		DatoGol[i] = aux[i];
	}
	
	printf("\n");
	system("pause");
}

void CrearListadoxFecha(Nodo *&lista, ListaGoles dato){
	Nodo *nuevonodo = new Nodo();
	nuevonodo->info = dato;
	
	Nodo *aux1 = lista;
	Nodo *aux2;
	
	while((aux1 != NULL) && (aux1->info.fecha < dato.fecha)){
		aux2 = aux1;
		aux1 = aux1->sig;
	}
	
	if(lista==aux1) lista = nuevonodo;
	else aux2->sig = nuevonodo;
	
	nuevonodo->sig = aux1;
}

void MostrarListadoxFecha(Nodo *lista){
	Nodo *nuevonodo = new Nodo();
	Nodo *auxnodo = NULL;
	ListaGoles auxnodo2;
	int aux = 0;
	nuevonodo = lista;
	printf("Fecha\t\t\tEquipo\t\t   Jugador\t\t   Goles\n");

	while(nuevonodo->sig != NULL){
		auxnodo = nuevonodo->sig;
		
		while(auxnodo != NULL){
		
			if(nuevonodo->info.fecha == auxnodo->info.fecha){
				
				if(nuevonodo->info.cantidadgoles < auxnodo->info.cantidadgoles){
					
					auxnodo2 = auxnodo->info;
					auxnodo->info = nuevonodo->info;
					nuevonodo->info = auxnodo2;
					
				}
				
			}
		
			auxnodo = auxnodo->sig;	
		}
		
		nuevonodo = nuevonodo->sig;
	}

	nuevonodo = lista; //Para volver a comenzar y leerlos de manera ordenada
	
	while(nuevonodo!=NULL){
		if(nuevonodo->info.fecha!=aux) printf("\n\n");
		printf("%d --------------- %d --------------- %s --------------- %d\n",nuevonodo->info.fecha,nuevonodo->info.equipo,nuevonodo->info.jugador,nuevonodo->info.cantidadgoles);
		aux = nuevonodo->info.fecha;
		nuevonodo = nuevonodo->sig;
	}
}

void ListadoGoleadoresMundial(Goles DatoGol[], long cantgoles){
	system("cls");
	
	Goles aux[cantgoles];
	for(int i=0;i<cantgoles;i++){
		aux[i] = DatoGol[i];
	}
	
	int goljug = 1; //Una variable que almacene la cantidad de goles por jugador temporalmente
	ListaGoles infojug; //Una variable de tipo ListaGoles para ingresar los datos al Nodo
	Nodo *listamundial = NULL;
	
	for(int i=0;i<cantgoles;i++){ //Realizamos un for que recorra la cantidad de goles que posee el archivo leido previamente
		for(int j=i+1;j<cantgoles;j++){ //Realizamos otro for para analizar todos los jugadores con el mismo nombre y sumar los goles que realizo
			if(strcmp(DatoGol[i].NJugador,DatoGol[j].NJugador)==0){
				goljug++;
				strcpy(DatoGol[j].NJugador,"Nada"); //Seteamos el nombre de jugador en NULL en la posicion que ya fue contada para que no se repita al avanzar en 'i'
			}
		}
		if(strcmp(DatoGol[i].NJugador,"Nada")!=0) {
			infojug.fecha = 0; //Seteamos este dato en 0 ya que no sera necesario en el listado
			strcpy(infojug.jugador,DatoGol[i].NJugador);
			infojug.cantidadgoles = goljug;
			infojug.equipo = DatoGol[i].CEquipo;
			CrearListadoMundial(listamundial,infojug);	
		}
		goljug = 1; //Reseteamos la variable para el proximo jugador
	}
	
	MostrarListadoMundial(listamundial);
	while(listamundial!=NULL){
		LimpiarListados(listamundial,infojug);
	}
	
	for(int i=0;i<cantgoles;i++){
		DatoGol[i] = aux[i];
	}
	
	printf("\n");
	system("pause");
}

void CrearListadoMundial(Nodo *&lista, ListaGoles dato){
	Nodo *nuevonodo = new Nodo();
	nuevonodo->info = dato;
	
	Nodo *aux1 = lista;
	Nodo *aux2;
	
	while((aux1 != NULL) && (aux1->info.cantidadgoles > dato.cantidadgoles)){
		aux2 = aux1;
		aux1 = aux1->sig;	
	}
	
	if(lista==aux1) lista = nuevonodo;
	else aux2->sig = nuevonodo;
	
	nuevonodo->sig = aux1; 
}

void MostrarListadoMundial(Nodo *lista){
	Nodo *nuevonodo = new Nodo();
	nuevonodo = lista;
	printf("Jugador\t\t   Equipo\t\t   Goles\n");
	while(nuevonodo!=NULL){
		printf("%s --------------- %d --------------- %d\n",nuevonodo->info.jugador,nuevonodo->info.equipo,nuevonodo->info.cantidadgoles);
		nuevonodo = nuevonodo->sig;
	}
}

void LimpiarListados(Nodo *&lista, ListaGoles &dato){
	Nodo *nuevonodo = lista;
	dato = nuevonodo->info;
	lista = nuevonodo->sig;
	delete nuevonodo;
}
