#include <iostream>
#include <stdio.h>
#include <cstdlib>
#include <string.h>
#include <time.h>
using namespace std;

struct Trayecto{
	int nrotray;
	int tseg;
};

struct Corredores{
	int corredor;
	int nrotray;
	int tseg;
};

void CrearTrayectos();
void CrearCorredores();
void EjecutarEjercicio();
int Dar3Digitos(int &Corredor){
	while(Corredor<100){
		Corredor = Corredor*10;
	}
}

int main(){
	int opcion;
	printf("Seleccione la opcion que desee:\n1_Crear trayectos\n2_Crear corredores\n3_Visualizar Ejercicio\n\n");
	cin >> opcion;
	switch(opcion){
		case 1: CrearTrayectos();
			break;
		case 2: CrearCorredores();
			break;
		case 3: EjecutarEjercicio();
			break;		
		default:{
			for(int i=0;i<1;){
				printf("ERROR! Ingrese una opcion valida!\n");
				cin >> opcion;
				switch(opcion){
					case 1:{
						CrearTrayectos(); i++;
						break;
					}
					case 2:{
						CrearCorredores(); i++;
						break;
					}
					case 3:{
						EjecutarEjercicio(); i++;
						break;
					}
				}
			}
			break;
		}	
	}
	return 0;
}

void CrearTrayectos(){
	Trayecto T;
	FILE* F = fopen("ASIGNADO","wb");
	srand(time(0));
	for(int i=1;i<=50;i++){
		system("cls");
		T.nrotray = i;
		T.tseg = 1+rand()%9999;
		printf("Trayecto: %d - Segundos: %d\n",T.nrotray,T.tseg);
		fwrite(&T,sizeof(T),1,F);
		system("pause");
	}
	fclose(F);
}

void CrearCorredores(){
	Corredores C;
	int acum = 0;
	FILE* F = fopen("TIEMPO","wb");
	srand(time(0));
	for(int i=1;i<=50;){
		system("cls");
		C.corredor = 1+rand()%999;
		if(C.corredor<100) Dar3Digitos(C.corredor);
		C.nrotray = i;
		C.tseg = 1+rand()%9999;
		printf("Corredor: %d - Trayecto: %d - Tiempo: %d\n",C.corredor,C.nrotray,C.tseg);
		fwrite(&C,sizeof(C),1,F);
		if(acum==3) {
			acum = 0;
			i++;
		}
		acum++;
		system("pause");
	}
}

void EjecutarEjercicio(){
	system("cls");
	Trayecto T, Tray[50];
	int acum = 0;
	FILE* F = fopen("ASIGNADO","rb");
	fread(&T,sizeof(T),1,F);
	while(!feof(F)){
		Tray[acum].nrotray = T.nrotray;
		Tray[acum].tseg = T.tseg;
		fread(&T,sizeof(T),1,F);
		acum++;
	}
	fclose(F);
	acum = 0;
	Corredores C, Corr[150];
	FILE* J = fopen("TIEMPO","rb");
	fread(&C,sizeof(C),1,J);
	while(!feof(J)){
		Corr[acum].corredor = C.corredor;
		Corr[acum].nrotray = C.nrotray;
		Corr[acum].tseg = C.tseg;
		fread(&C,sizeof(C),1,J);
		acum++;
	}
	fclose(J);
	acum = 0;
	////////REALIZAMOS EL EJERCICIO///////
	int mintiempo = 9999, ganador[50] = {0}, abandono[150] = {0};
	for(int i=0;i<150;i++){
		for(int j=0;j<50;j++){		
			if(Corr[i].nrotray==Tray[j].nrotray){
				if(Corr[i].tseg<=Tray[j].tseg){ //Suponemos que abandona la carrera si el tiempo del piloto es mayor que el tiempo del trayecto
					if(mintiempo>=Corr[i].tseg) ganador[j]=Corr[i].corredor;
				}
				else abandono[i]=Corr[i].corredor;
			}
		}
 	}
 	for(int i=0;i<50;i++){
 		if(ganador[i]>0) printf("\n ***** El ganador del trayecto %d fue el corredor %d ***** \n",i+1,ganador[i]);
 		else printf("\n *****El trayecto %d no tuvo ganador debido a que todos abandonaron! ***** \n",i+1);
	}
	for(int i=0;i<50;i++){
		printf("\n\n ***** ABANDONOS DEL TRAYECTO %d ***** \n\n",i+1);
		for(int j=0;j<150;j++){
			if(Corr[j].nrotray==i+1){
				if(Corr[j].corredor==abandono[j]) printf("*Corredor: %d\n",abandono[j]);
			}
		}
	}
}
