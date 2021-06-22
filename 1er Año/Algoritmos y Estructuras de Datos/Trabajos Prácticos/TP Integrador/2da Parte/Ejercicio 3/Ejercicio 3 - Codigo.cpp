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

struct GEquipos{
	int equipo;
	int goles;
};

struct Nodo{
	GEquipos info;
	Nodo *derecha;
	Nodo *izquierda;	
};

void LeerArchivo();
long CantidadRegistros(FILE *,int);

void CrearMenu(GEquipos []);

void OrdenarEquiposxGol(GEquipos []);

Nodo *CrearNodo(GEquipos);
void InsertarArbol(Nodo *&, GEquipos);
void MostrarArbol(Nodo *&, int);
void RecorrerArbolINORDER(Nodo *&);

int main(){
	printf("********** Ejercicio 3 **********\n\n");
	 
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
	printf("*Tamaño del registro: %d ...\n\n",cantgoles);
	system("pause");
	
	GEquipos InfoEquipo[32];
	for(int i=0;i<32;i++){
		InfoEquipo[i].equipo = i+1; //Asignamos el nombre de equipo a la estructura que utilizaremos como tipo de dato a utilizar en el Arbol Binario de Busqueda
		InfoEquipo[i].goles = 0; //Inicializamos todas las variables en 0 goles al comienzo
	}
	
	fread(&GOL,sizeof(GOL),1,F);
	while(!feof(F)){
		
		switch(GOL.CEquipo){ //Si el codigo de equipo es mencionado, se incrementa 1 gol al correspondiente equipo (IDEM Ejercicio 2)
			case 1: InfoEquipo[0].goles++;
				break;
			case 2: InfoEquipo[1].goles++;
				break;
			case 3: InfoEquipo[2].goles++;
				break;
			case 4: InfoEquipo[3].goles++;
				break;
			case 5: InfoEquipo[4].goles++;
				break;
			case 6: InfoEquipo[5].goles++;
				break;
			case 7: InfoEquipo[6].goles++;
				break;
			case 8: InfoEquipo[7].goles++;
				break;
			case 9: InfoEquipo[8].goles++;
				break;
			case 10: InfoEquipo[9].goles++;
				break;	
			case 11: InfoEquipo[10].goles++;
				break;
			case 12: InfoEquipo[11].goles++;
				break;
			case 13: InfoEquipo[12].goles++;
				break;
			case 14: InfoEquipo[13].goles++;
				break;
			case 15: InfoEquipo[14].goles++;
				break;
			case 16: InfoEquipo[15].goles++;
				break;
			case 17: InfoEquipo[16].goles++;
				break;
			case 18: InfoEquipo[17].goles++;
				break;
			case 19: InfoEquipo[18].goles++;
				break;
			case 20: InfoEquipo[19].goles++;
				break;
			case 21: InfoEquipo[20].goles++;
				break;
			case 22: InfoEquipo[21].goles++;
				break;
			case 23: InfoEquipo[22].goles++;
				break;
			case 24: InfoEquipo[23].goles++;
				break;
			case 25: InfoEquipo[24].goles++;
				break;
			case 26: InfoEquipo[25].goles++;
				break;
			case 27: InfoEquipo[26].goles++;
				break;
			case 28: InfoEquipo[27].goles++;
				break;
			case 29: InfoEquipo[28].goles++;
				break;
			case 30: InfoEquipo[29].goles++;
				break;
			case 31: InfoEquipo[30].goles++;
				break;
			case 32: InfoEquipo[31].goles++;
				break;																															
		}
		
		fread(&GOL,sizeof(GOL),1,F);
	}
	
	fclose(F);
	
	printf("\n*Generando listado de goles por equipo en forma de arbol binario*\n\n");
	system("pause");
	
	CrearMenu(InfoEquipo);
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

void CrearMenu(GEquipos InfoEquipos[]){
	system("cls");
	printf("********************\tGenerar Arbol Binario de Busqueda\t********************\n\n");
	system("pause");
	
	GEquipos aux; //Ordenamos los equipos por mayor cantidad de goles
	aux.equipo = 0;
	aux.goles = 0;
	for(int pos=0;pos<32;pos++){
		for(int i=0;i<31-pos;i++){
			if(InfoEquipos[i].goles<InfoEquipos[i+1].goles){
				aux = InfoEquipos[i];
				InfoEquipos[i] = InfoEquipos[i+1];
				InfoEquipos[i+1] = aux;
			}
		}
	}
	
	Nodo *arbol = NULL;
	for(int i=0; i<32; i++){ //Insertamos los equipos al arbol
		system("cls");
		InsertarArbol(arbol,InfoEquipos[i]);
		printf("Insertando equipo %d, con una cantidad de %d goles al arbol.\n",InfoEquipos[i].equipo,InfoEquipos[i].goles);
		system("pause");
	}
	system("cls");
	MostrarArbol(arbol,0); //Iniciamos el contador en 0
	printf("\nREPRESENTACION DE CADA ELEMENTO ARBOL ---> (EQUIPO/GOLES)\n\n");
	system("pause");
	printf("Recorrido del arbol de forma IN-ORDER:\n");
	RecorrerArbolINORDER(arbol);
	printf("\nREPRESENTACION DE LOS ELEMENTOS ---> (EQUIPO/GOLES)\n");
	system("pause");
}

Nodo *CrearNodo(GEquipos dato){
	Nodo *nuevonodo = new Nodo();
	
	nuevonodo->info = dato;
	nuevonodo->derecha = NULL;
	nuevonodo->izquierda = NULL;
	
	return nuevonodo;
}

void InsertarArbol(Nodo *&arbol, GEquipos dato){
	if(arbol==NULL){ //Si el arbol esta vacio simplemente ingresamos el primer elemento como raiz
		Nodo *nuevonodo = CrearNodo(dato);
		arbol = nuevonodo;
	}
	else{ //Si el arbol ya tiene algun elemento lo ingresamos en base a la teoria de arbol binario de busqueda
		GEquipos ValorRaiz = arbol->info;
		if(dato.goles < ValorRaiz.goles){ //El ejercicio pide ordenamiento por goles
			InsertarArbol(arbol->izquierda,dato); //Inserta el dato en el lado izquierdo
		}
		else{
			InsertarArbol(arbol->derecha,dato); //Inserta el dato en el lado derecho
		}
	}
}

void MostrarArbol(Nodo *&arbol, int contador){
	if(arbol != NULL){
		MostrarArbol(arbol->derecha,contador+1);
		for(int i=0;i<contador;i++){ //Para que pueda verse en forma de arbol o similiar (rotado en forma 
			printf("     ");
		}
		printf("%d/%d\n",arbol->info.equipo,arbol->info.goles);
		MostrarArbol(arbol->izquierda,contador+1);
	}
}

void RecorrerArbolINORDER(Nodo *&arbol){
	if(arbol!=NULL){
		RecorrerArbolINORDER(arbol->izquierda);
		printf("%d/%d\n",arbol->info.equipo,arbol->info.goles);
		RecorrerArbolINORDER(arbol->derecha);
	}
}
