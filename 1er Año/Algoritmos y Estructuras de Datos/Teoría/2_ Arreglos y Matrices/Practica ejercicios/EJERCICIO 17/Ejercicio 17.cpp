#include <iostream>
#include <stdio.h>
#include <string.h>
#include <cstdlib>
#include <time.h>
using namespace std;

struct Destinos{
	int nrodest;
	float km;
};

struct Viajes{
	char patente[6];
	int nrodest;
	int nrochofer;
};

int Dar3Digitos(int *Destino){
	while(*Destino<100){
		*Destino=(*Destino)*10;
	}
}

void GenerarArchivoD(){
	system("cls");
	Destinos D;
	FILE* F = fopen("DESTINOS.dat","wb");
	srand(time(0));
	float random;
	for(int i=0; i<10; i++){
		D.nrodest = 1+rand()%999;
		if(D.nrodest<100) Dar3Digitos(&D.nrodest);
		random = (1+rand()%999)/1000.000;
		D.km = (1+rand()%999)+random;
		printf("NRO Dest: %d - KMS: %f\n",D.nrodest,D.km);
		fwrite(&D,sizeof(D),1,F);
	}
	fclose(F);
}

void GenerarViajes(int NDest[]){
	system("cls");
	Viajes V;
	FILE* F = fopen("VIAJES.dat","wb");
	int random;
	srand(time(0));
	for(int i=0; i<20; i++){
		printf("Introduzca la patente del camion que realizo el viaje: ");
		cin >> V.patente;
		random = 1+rand()%10;
		V.nrodest = NDest[random];
		V.nrochofer = 1+rand()%150;
		printf("Chofer: %d - Patente: %s - Destino: %d\n",V.nrochofer,V.patente,V.nrodest);
		fwrite(&V,sizeof(V),1,F);
	}
	fclose(F);
}

void GenerarArchivoV(){
	system("cls");
	Destinos D;
	FILE* F = fopen("DESTINOS.dat","rb");
	fread(&D,sizeof(D),1,F);
	int NDest[10], acum=0;
	while(!feof(F)){
		NDest[acum] = D.nrodest;
		fread(&D,sizeof(D),1,F);
		acum++;
	}
	fclose(F);
	GenerarViajes(NDest);
}

void LeerArchivos(){
	system("cls");
	int acum = 0;
	Destinos D[10]; Destinos Dest;
	FILE* F = fopen("DESTINOS.dat","rb");
	fread(&Dest,sizeof(Dest),1,F);
	while(!feof(F)){
		D[acum].nrodest = Dest.nrodest;
		D[acum].km = Dest.km;
		fread(&Dest,sizeof(Dest),1,F);
		acum++;
	}
	fclose(F);
	acum = 0;
	Viajes V[20]; Viajes Viaj;
	FILE* J = fopen("VIAJES.dat","rb");
	fread(&Viaj,sizeof(Viaj),1,J);
	while(!feof(J)){
		V[acum].nrochofer = Viaj.nrochofer;
		V[acum].nrodest = Viaj.nrodest;
		strcpy(V[acum].patente,Viaj.patente);
		fread(&Viaj,sizeof(Viaj),1,J);
		acum++;
	}
	fclose(J);
	///////ACA COMIENZA EL EJERCICIO////////
	int CantDest[10] = {0,0,0,0,0,0,0,0,0,0};
	int MenorKMS=999999999999, MenorChofer, TotalChofer[20]; 
	for(int i=0;i<10;i++){
		for(int j=0;j<20;j++){
			if(D[i].nrodest==V[j].nrodest){
				CantDest[i]++;
				TotalChofer[j] += D[i].km;
				if(TotalChofer[j]<MenorKMS){
					MenorKMS = TotalChofer[j];
					MenorChofer = V[j].nrochofer;
				}
				if(D[i].nrodest==116) printf("La patente del camion que viajo al 116 es: %s\n", V[j].patente);
				else printf("Este camion no viajo al 116!\n"); //PUNTO C	
			}
		}
	}
	for(int i=0;i<10;i++){
		if(CantDest[i]>0) printf("Se viajaron %d veces al destino %d\n",CantDest[i],D[i].nrodest); //PUNTO A
	}
	printf("El chofer con menor cantidad de KMS fue el numero %d\n",MenorChofer); //PUNTO B
}

int main(){
	int opcion;
	printf("Seleccione la opcion que desee:\n\n1_Generar DESTINOS\n2_Generar VIAJES\n3_Leer Archivos\n\n");
	cin >> opcion;
	if(opcion==1) GenerarArchivoD();
	else if(opcion==2) GenerarArchivoV();
	else if(opcion==3) LeerArchivos();
	return 0;
}
