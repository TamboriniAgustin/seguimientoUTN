#include <iostream>
#include <stdio.h>
#include <string.h>
#include <cstdlib>
#include <time.h>
using namespace std;

struct Vuelos{
	int Codigo;
	int Pasajes;
};

struct Compradores{
	int Codigo;
	int PasajesSolicitados;
	int DNI;
	char Nombre[20];
	char Apellido[20];
};

int Dar6Digitos(int *Codigo){
	while(*Codigo<100000){
		*Codigo=(*Codigo)*10;
	}
}

int Dar8Digitos(int *DNI){
	while(*DNI<10000000){
		*DNI=(*DNI)*10;
	}
}

void GenerarArchivo2(int Codigo[]){
	system("cls");
	srand(time(0));
	Compradores Comp;
	FILE* F = fopen("COMPRADORES.dat","wb");
	for(int i=0;i<5;i++){
		Comp.Codigo = Codigo[i];
		printf("CODIGO: %d\n",Comp.Codigo);
		printf("Introduzca nombre y apellido del comprador: ");
		cin >> Comp.Nombre >> Comp.Apellido;
		Comp.DNI = 1+rand()%99999;
		if(Comp.DNI<10000000) Dar8Digitos(&Comp.DNI);
		Comp.PasajesSolicitados = 1+rand()%999;
		printf("PASAJES SOLICITADOS: %d\n", Comp.PasajesSolicitados);
		fwrite(&Comp,sizeof(Comp),1,F);
	}
	fclose(F);
}

void GenerarCompradores(){
	system("cls");
	Vuelos V;
	int Codigos[500], acum=0;
	FILE* F = fopen("VUELOS.dat","rb");
	fread(&V,sizeof(V),1,F);
	while(!feof(F)){
		Codigos[acum] = V.Codigo;
		printf("Cant Pasajes: %d\n",V.Pasajes);
		fread(&V,sizeof(V),1,F);
		acum++;
	}
	system("pause");
	fclose(F);
	GenerarArchivo2(Codigos);
}

void GenerarArchivo(){
	system("cls");
	Vuelos V;
	FILE* F = fopen("VUELOS.dat","wb");
	for(int i=0;i<500;i++){
		V.Codigo = rand()%99999;
		if(V.Codigo<100000) Dar6Digitos(&V.Codigo);
		V.Pasajes = 1+rand()%999;
		printf("Codigo de Vuelo %d - Cantidad de Pasajes: %d\n",V.Codigo,V.Pasajes);
		fwrite(&V,sizeof(V),1,F);
	}
	fclose(F);
}

void LeerArchivo(){
	system("cls");
	int acum=0;
	Vuelos V;
	Vuelos Vuelo[500];
	FILE* F = fopen("VUELOS.dat","rb");
	fread(&V,sizeof(V),1,F);
	while(!feof(F)){
		Vuelo[acum].Codigo = V.Codigo;
		Vuelo[acum].Pasajes = V.Pasajes;
		fread(&V,sizeof(V),1,F);
		acum++;
	}
	fclose(F);
	acum = 0;
	Compradores C;
	Compradores Comp[10];
	FILE* J = fopen("COMPRADORES.dat","rb");
	fread(&C,sizeof(C),1,J);
	while(!feof(J)){
		Comp[acum].Codigo = C.Codigo;
		Comp[acum].DNI = C.DNI;
		Comp[acum].PasajesSolicitados = C.PasajesSolicitados;
		strcpy(Comp[acum].Nombre,C.Nombre);
		strcpy(Comp[acum].Apellido,C.Apellido);
		fread(&C,sizeof(C),1,J);
		acum++;
	}
	fclose(J);
	///////ACA COMENZAMOS EL EJERCICIO/////////
	int actpasajes = 0, pasajesnv = 0, pasajesvend = 0;
	for(int i=0;i<500;i++){
		for(int j=0;j<5;j++){
			if(Comp[j].Codigo==Vuelo[i].Codigo){
				if(Comp[j].PasajesSolicitados<=Vuelo[i].Pasajes){
					actpasajes = Vuelo[i].Pasajes-Comp[j].PasajesSolicitados;
					pasajesvend = Comp[j].PasajesSolicitados;
					printf("\nDNI: %d - Nombre: %s %s - Pasajes Vendidos: %d - Codigo de Vuelo: %d\n",Comp[j].DNI,Comp[j].Apellido,Comp[j].Nombre,pasajesvend,Comp[j].Codigo);
				}
				else{
					printf("\n No se pudo realizar la venta!\n");
					pasajesnv = Comp[j].PasajesSolicitados;
					actpasajes = Vuelo[i].Pasajes;	
				}
				printf("*Actualizacion de vuelo*\nCodigo: %d - Pasajes Libres: %d - Pasajes No Vendidos: %d\n",Vuelo[i].Codigo,actpasajes,pasajesnv);
			}
		}
		actpasajes=0;
		pasajesnv=0;
		pasajesvend=0;
	}
}

int main(){
	int opcion;
	printf("Seleccione la opcion que desee:\n\n1_Generar Archivo\n2_Generar Compradores\n3_Leer Archivo\n\n");
	cin >> opcion;
	if(opcion==1) GenerarArchivo();
	else if(opcion==2) GenerarCompradores();
	else if(opcion==3) LeerArchivo();
	return 0;
}
