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

struct Nodo{
	Goles info;
	Nodo *sig;	
};

int IngresoFecha();
void GenerarArchivo(Goles);
void InsertarLista(Nodo *&,Goles);
void VerLista(Nodo *, bool);
void EliminarLista(Nodo *&,Goles &);

int main(){
	printf("********** Ejercicio 1 **********\n\n");
	
	int Opcion;
	Goles ptrgol;
	Nodo *lista = NULL;
	int acumids = 0;
	
	system("pause");
	
	do{
		system("cls");
		
		printf("**********\tMENU\t**********\n1_Insertar nuevo gol\n2_Ver lista de goles actual\n3_Generar archivo y eliminar la lista (Fin del programa)\n\nOpcion: ");
		cin >> Opcion;
		
		switch(Opcion){
			case 1:{
				system("cls");
				acumids++;
				printf("Ingrese la informacion del gol: \n");
				printf("ID GOL: %d\n",acumids);
				ptrgol.ID_gol = acumids;
				printf("ID PARTIDO (1-64): ");
				cin >> ptrgol.ID_partido;
				if(ptrgol.ID_partido < 0 || ptrgol.ID_partido > 64){
					for(int i=0;i<1;){
						printf("********** ERROR DE TIPEO **********\nIngrese nuevamente la ID de PARTIDO: ");
						cin >> ptrgol.ID_partido;
						if(ptrgol.ID_partido >= 0 && ptrgol.ID_partido <=64) i++;
					}
				}
				printf("ID EQUIPO (1-32): ");
				cin >> ptrgol.CEquipo;
				if(ptrgol.CEquipo < 0 || ptrgol.CEquipo > 32){
					for(int i=0;i<1;){
						printf("********** ERROR DE TIPEO **********\nIngrese nuevamente la ID de EQUIPO: ");
						cin >> ptrgol.CEquipo;
						if(ptrgol.CEquipo >=0 && ptrgol.CEquipo <=32) i++;
					}
				}
				printf("ANOTADOR (20 caracteres maximo): ");
				cin >> ptrgol.NJugador;
				ptrgol.fecha = IngresoFecha();
				printf("Fecha: %d\n\n",ptrgol.fecha);
				InsertarLista(lista,ptrgol);
				system("pause");
				break;
			}
			case 2:{
				if(lista!=NULL)VerLista(lista,false);
				printf("\n\n");
				system("pause");
				break;
			}
			case 3:{
				if(lista!=NULL){
					VerLista(lista,true);
					printf("*Archivo generado correctamente\n");
					system("pause");
					while(lista!=NULL){ //Liberamos la memoria utilizada para la lista
						EliminarLista(lista,ptrgol);	
					}
					printf("*Memoria liberada correctamente\n");	
				}
				Opcion = 4;
				break;
			}
			default: {
				printf("\n********** ERROR DE TIPEO - OPCION INCORRECTA **********\n\n");
				system("pause");
				break;
			}	
		}

	}
	while(Opcion!=3);
	
	return 0;
}

int IngresoFecha(){
	int year, month, day;
	printf("FECHA:\n\nAño: ");
	cin >> year;
	printf("Mes: ");
	cin >> month;
	if(month<=0 || month>12){
		for(int i=0;i<1;){
			printf("********** ERROR DE TIPEO **********\nIngrese nuevamente el mes: ");
			cin >> month;
			if(month>0 && month<=12) i++;
		}
	}
	printf("Dia: ");
	cin >> day;
	if(day<=0 || day>31){
		for(int i=0;i<1;){
			printf("********** ERROR DE TIPEO **********\nIngrese nuevamente el dia: ");
			cin >> day;
			if(day>0 && day<=31) i++;
		}
	}
	if((month==4 || month==6 || month==9 || month==11) && day>30){
		for(int i=0;i<1;){
			printf("********** ERROR DE TIPEO - ESTE MES TIENE 30 DIAS! **********\nIngrese nuevamente el dia: ");
			cin >> day;
			if(day<=30) i++;
		}
	}
	if(month==2){
		if((year%4==0 && year%100!=0) || year%400==0) //Comprobamos si es año bisiesto
		{
			if(day>29){
				for(int i=0;i<1;){
					printf("********** ERROR DE TIPEO - ESTE MES TIENE 29 DIAS! **********\nIngrese nuevamente el dia: ");
					cin >> day;
					if(day<=29) i++;	
				}
			}	
		}
		else{
			if(day>28){
				for(int i=0;i<1;){
					printf("********** ERROR DE TIPEO - ESTE MES TIENE 28 DIAS! **********\nIngrese nuevamente el dia: ");
					cin >> day;
					if(day<=28) i++;	
				}
			}
		}
	}
	return (year*10000)+(month*100)+(day); //Juntamos todo en formato AAAAMMDD
}

void InsertarLista(Nodo *&listado,Goles Dato){
	Nodo *nuevonodo = new Nodo();
	nuevonodo->info = Dato;
	
	Nodo *aux1 = listado;
	Nodo *aux2;
	
	while((aux1!=NULL) && (aux1->info.CEquipo < Dato.CEquipo)){
		aux2 = aux1;
		aux1 = aux1->sig;			
	}
	
	if(listado == aux1) listado = nuevonodo;
	else aux2->sig = nuevonodo;
	
	nuevonodo->sig = aux1;
	
	printf("\n***** Elemento insertado a la lista correctamente *****\n");
}

void VerLista(Nodo *lista, bool fin){
	system("cls");
	Goles ptrgol;
	Nodo *nuevonodo = new Nodo();
	Nodo *auxnodo = NULL;
	Goles auxnodo2;
	nuevonodo = lista;
	
	while(nuevonodo->sig != NULL){ //Ordenamos los goles que sean del mismo equipo por fecha antes de imprimir o generar el archivo
		auxnodo = nuevonodo->sig;
		
		while(auxnodo != NULL){
		
			if(nuevonodo->info.CEquipo == auxnodo->info.CEquipo){
				
				if(nuevonodo->info.fecha > auxnodo->info.fecha){
					
					auxnodo2 = auxnodo->info;
					auxnodo->info = nuevonodo->info;
					nuevonodo->info = auxnodo2;
					
				}
				
			}
		
			auxnodo = auxnodo->sig;	
		}
		
		nuevonodo = nuevonodo->sig;
	}
	
	nuevonodo = lista; //Reseteamos a nuevonodo para que todos los elementos puedan imprimirse
	
	if(!fin) printf("***** Mostrando elementos de la lista ordenados por ID EQUIPO y FECHA *****\n\n");
	while(nuevonodo!=NULL){
		
		if(!fin) printf("ID GOL: %d - ID PARTIDO: %d - ID EQUIPO: %d - FECHA: %d - ANOTADOR: %s\n",nuevonodo->info.ID_gol,nuevonodo->info.ID_partido,nuevonodo->info.CEquipo,nuevonodo->info.fecha,nuevonodo->info.NJugador);
		
		else{
			ptrgol = nuevonodo->info;
			GenerarArchivo(ptrgol);	
		}
		
		nuevonodo = nuevonodo->sig;
	}
}

void GenerarArchivo(Goles ptrgol){
	FILE* F = fopen("Goles","ab"); //Uso "ab" para que cada vez que llame a la funcion se añada debajo del ultimo registro añadido, para empezar uno nuevo debera borrarse el anterior
	fwrite(&ptrgol,sizeof(ptrgol),1,F);
	fclose(F);
}

void EliminarLista(Nodo *&lista, Goles &Dato){
	Nodo *aux = lista;
	Dato = aux->info;
	lista = aux->sig;
	delete aux;
}
