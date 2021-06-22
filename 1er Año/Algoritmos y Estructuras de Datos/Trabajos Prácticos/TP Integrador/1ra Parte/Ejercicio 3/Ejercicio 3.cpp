#include <iostream>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
using namespace std;

#define EQUIPOS 32
#define CRITERIOS 3

struct Sorteo{
	int Bolillero;
	char NEquipo[20];
	char Confederacion[10];
};

void GrabarGrupoAenArray();
void GrabarGrupoBenArray();
void GrabarGrupoCenArray();
void GrabarGrupoDenArray();
void GrabarGrupoEenArray();
void GrabarGrupoFenArray();
void GrabarGrupoGenArray();
void GrabarGrupoHenArray();
void OrdenxGrupo();
void OrdenxEquipo();
void OrdenxConfederacion();
void OrdenxGrpyConf();
void OrdenxTodo();

string Array[EQUIPOS][CRITERIOS]; //Definimos un array de 32 equipos, con los 3 criterios a imprimir - Criterio 0 = Nombre / 1 = Grupo / 2 = Confederacion
int cont = 0;

int main(){
	GrabarGrupoAenArray();
	GrabarGrupoBenArray();
	GrabarGrupoCenArray();
	GrabarGrupoDenArray();
	GrabarGrupoEenArray();
	GrabarGrupoFenArray();
	GrabarGrupoGenArray();
	GrabarGrupoHenArray();
	int forma;
	cout << "Elija la forma en que desea ordenar los equipos: " << endl;
	printf("1_ Por Grupo\n2_ Por Nombre de Equipo(A-Z)\n3_ Por Confederacion (A-Z)\n4_ Por Grupo y por Confederacion\n5_ Por Grupo, Confederacion y Nombre de Equipo\n");
	cin >> forma;
	switch(forma){
		case 1: OrdenxGrupo();
			break;				
		case 2: OrdenxEquipo();
			break;		
		case 3: OrdenxConfederacion();
			break;
		case 4:	OrdenxGrpyConf();
			break;
		case 5: OrdenxTodo();
			break;		
		default:{
			for(int i=0;i<10;){
				printf("ERROR! Ingrese correctamente una de las opciones sugeridas\n");
				cin >> forma;
				switch(forma){
					case 1: { i=15; OrdenxGrupo(); break; }
					case 2: { i=15; OrdenxEquipo(); break; }
					case 3: { i=15; OrdenxConfederacion(); break; }
					case 4: { i=15; OrdenxGrpyConf(); break; }
					case 5: { i=15; OrdenxTodo(); break; }
				}
			}
			break;
		}		
	}
	return 0;
}

void GrabarGrupoAenArray(){
	Sorteo sort;
	FILE* F = fopen("GrupoA.txt","rb");
	fread(&sort,sizeof(sort),1,F);
	while(!feof(F)){
		Array[cont][0] = sort.NEquipo;
		Array[cont][1] = "A";
		Array[cont][2] = sort.Confederacion;
		cont++;
		fread(&sort,sizeof(sort),1,F);
	}
}

void GrabarGrupoBenArray(){
	Sorteo sort;
	FILE* F = fopen("GrupoB.txt","rb");
	fread(&sort,sizeof(sort),1,F);
	while(!feof(F)){
		Array[cont][0] = sort.NEquipo;
		Array[cont][1] = "B";
		Array[cont][2] = sort.Confederacion;
		cont++;
		fread(&sort,sizeof(sort),1,F);
	}
}

void GrabarGrupoCenArray(){
	Sorteo sort;
	FILE* F = fopen("GrupoC.txt","rb");
	fread(&sort,sizeof(sort),1,F);
	while(!feof(F)){
		Array[cont][0] = sort.NEquipo;
		Array[cont][1] = "C";
		Array[cont][2] = sort.Confederacion;
		cont++;
		fread(&sort,sizeof(sort),1,F);
	}
}

void GrabarGrupoDenArray(){
	Sorteo sort;
	FILE* F = fopen("GrupoD.txt","rb");
	fread(&sort,sizeof(sort),1,F);
	while(!feof(F)){
		Array[cont][0] = sort.NEquipo;
		Array[cont][1] = "D";
		Array[cont][2] = sort.Confederacion;
		cont++;
		fread(&sort,sizeof(sort),1,F);
	}
}

void GrabarGrupoEenArray(){
	Sorteo sort;
	FILE* F = fopen("GrupoE.txt","rb");
	fread(&sort,sizeof(sort),1,F);
	while(!feof(F)){
		Array[cont][0] = sort.NEquipo;
		Array[cont][1] = "E";
		Array[cont][2] = sort.Confederacion;
		cont++;
		fread(&sort,sizeof(sort),1,F);
	}
}

void GrabarGrupoFenArray(){
	Sorteo sort;
	FILE* F = fopen("GrupoF.txt","rb");
	fread(&sort,sizeof(sort),1,F);
	while(!feof(F)){
		Array[cont][0] = sort.NEquipo;
		Array[cont][1] = "F";
		Array[cont][2] = sort.Confederacion;
		cont++;
		fread(&sort,sizeof(sort),1,F);
	}
}

void GrabarGrupoGenArray(){
	Sorteo sort;
	FILE* F = fopen("GrupoG.txt","rb");
	fread(&sort,sizeof(sort),1,F);
	while(!feof(F)){
		Array[cont][0] = sort.NEquipo;
		Array[cont][1] = "G";
		Array[cont][2] = sort.Confederacion;
		cont++;
		fread(&sort,sizeof(sort),1,F);
	}
}

void GrabarGrupoHenArray(){
	Sorteo sort;
	FILE* F = fopen("GrupoH.txt","rb");
	fread(&sort,sizeof(sort),1,F);
	while(!feof(F)){
		Array[cont][0] = sort.NEquipo;
		Array[cont][1] = "H";
		Array[cont][2] = sort.Confederacion;
		cont++;
		fread(&sort,sizeof(sort),1,F);
	}
}

void OrdenxGrupo(){ //No hace falta acomodar nada, ya que abrimimos los archivos por orden, por lo tanto el grupo ya queda
	system("cls");
	printf("Grupo\t|\tSeleccion\t|\tConfederacion\n\n");
	for(int i=0; i<EQUIPOS; i++){
		cout << Array[i][1] << " --- " << Array[i][0] << " --- " << Array[i][2] << endl;
	}
}

void OrdenxEquipo(){
	system("cls");
	printf("Equipo\t|\tConfederacion\t|\tGrupo\n\n");
	char Nombre[EQUIPOS][20], Confederacion[EQUIPOS][10], Grupo[EQUIPOS][10]; //Almacenamos el nombre en formato char para poder comparar
	char Ntemporal[20],Ctemporal[10], Gtemporal[10]; //Una variable para almacenar los datos de forma temporal
	for(int i=0; i<EQUIPOS; i++){
		strcpy(Nombre[i], Array[i][0].c_str());
		strcpy(Confederacion[i], Array[i][2].c_str());
		strcpy(Grupo[i], Array[i][1].c_str());
	}
	for(int i=0;i<EQUIPOS;i++){
		for(int j=0;j<=EQUIPOS;j++){
			if(strcmp(Nombre[i],Nombre[j])<0){ //El <0 representa de menor a mayor (A a Z)
				strcpy(Ntemporal,Nombre[i]); 
				strcpy(Ctemporal,Confederacion[i]);
				strcpy(Gtemporal, Grupo[i]);
				strcpy(Nombre[i],Nombre[j]); 
				strcpy(Confederacion[i],Confederacion[j]);
				strcpy(Grupo[i],Grupo[j]);
				strcpy(Nombre[j],Ntemporal); 
				strcpy(Confederacion[j],Ctemporal);
				strcpy(Grupo[j],Gtemporal); 			//Utilizamos la regla de la cadena para ir ordenando los equipos segun su orden alfabetico
			}
		}
	}
	for(int i=0; i<EQUIPOS; i++){
		cout << Nombre[i] << " --- " << Confederacion[i] << " --- " << Grupo[i] << endl;
	}
}

void OrdenxConfederacion(){
	system("cls");
	printf("Confederacion\t|\tEquipo\t|\tGrupo\n\n");
	char Nombre[EQUIPOS][20], Confederacion[EQUIPOS][10], Grupo[EQUIPOS][10]; //Almacenamos el nombre en formato char para poder comparar
	char Ntemporal[20],Ctemporal[10], Gtemporal[10]; //Una variable para almacenar los datos de forma temporal
	for(int i=0; i<EQUIPOS; i++){
		strcpy(Nombre[i], Array[i][0].c_str());
		strcpy(Confederacion[i], Array[i][2].c_str());
		strcpy(Grupo[i], Array[i][1].c_str());
	}
	for(int i=0;i<EQUIPOS;i++){
		for(int j=0;j<=EQUIPOS;j++){
			if(strcmp(Confederacion[i],Confederacion[j])<0){ //El <0 representa de menor a mayor (A a Z)
				strcpy(Ntemporal,Nombre[i]); 
				strcpy(Ctemporal,Confederacion[i]);
				strcpy(Gtemporal, Grupo[i]);
				strcpy(Nombre[i],Nombre[j]); 
				strcpy(Confederacion[i],Confederacion[j]);
				strcpy(Grupo[i],Grupo[j]);
				strcpy(Nombre[j],Ntemporal); 
				strcpy(Confederacion[j],Ctemporal);
				strcpy(Grupo[j],Gtemporal); 			//Utilizamos la regla de la cadena para ir ordenando los equipos segun su orden alfabetico
			}
		}
	}
	for(int i=0; i<EQUIPOS; i++){
		cout << Confederacion[i] << " --- " << Nombre[i] << " --- " << Grupo[i] << endl;
	}
}

void OrdenxGrpyConf(){
	system("cls");
	printf("Grupo\t|\tConfederacion\t|\tEquipo\n\n");
	char Nombre[EQUIPOS][20], Confederacion[EQUIPOS][10], Grupo[EQUIPOS][10]; //Almacenamos el nombre en formato char para poder comparar
	char Ntemporal[20],Ctemporal[10], Gtemporal[10]; //Una variable para almacenar los datos de forma temporal
	for(int i=0; i<EQUIPOS; i++){
		strcpy(Nombre[i], Array[i][0].c_str());
		strcpy(Confederacion[i], Array[i][2].c_str());
		strcpy(Grupo[i], Array[i][1].c_str());
	}
	for(int i=0;i<EQUIPOS;i++){ 
		for(int j=0;j<=EQUIPOS;j++){
			if(strcmp(Grupo[i],Grupo[j])<0){ //El <0 representa de menor a mayor (A a Z)
				strcpy(Ntemporal,Nombre[i]); 
				strcpy(Ctemporal,Confederacion[i]);
				strcpy(Gtemporal, Grupo[i]);
				strcpy(Nombre[i],Nombre[j]); 
				strcpy(Confederacion[i],Confederacion[j]);
				strcpy(Grupo[i],Grupo[j]);
				strcpy(Nombre[j],Ntemporal); 
				strcpy(Confederacion[j],Ctemporal);
				strcpy(Grupo[j],Gtemporal); 			//Ordenamos primero los grupos
			}
		}
	}
	for(int i=0;i<4;i++){ //Ordenamos la confederacion para los grupo A
		for(int j=0;j<4;j++){
			if(strcmp(Confederacion[i],Confederacion[j])<0){ //El <0 representa de menor a mayor (A a Z)
				strcpy(Ntemporal,Nombre[i]); 
				strcpy(Ctemporal,Confederacion[i]);
				strcpy(Gtemporal, Grupo[i]);
				strcpy(Nombre[i],Nombre[j]); 
				strcpy(Confederacion[i],Confederacion[j]);
				strcpy(Grupo[i],Grupo[j]);
				strcpy(Nombre[j],Ntemporal); 
				strcpy(Confederacion[j],Ctemporal);
				strcpy(Grupo[j],Gtemporal);
			}
		}
	}
	for(int i=4;i<8;i++){ //Ordenamos la confederacion para los grupo B
		for(int j=4;j<8;j++){
			if(strcmp(Confederacion[i],Confederacion[j])<0){ //El <0 representa de menor a mayor (A a Z)
				strcpy(Ntemporal,Nombre[i]); 
				strcpy(Ctemporal,Confederacion[i]);
				strcpy(Gtemporal, Grupo[i]);
				strcpy(Nombre[i],Nombre[j]); 
				strcpy(Confederacion[i],Confederacion[j]);
				strcpy(Grupo[i],Grupo[j]);
				strcpy(Nombre[j],Ntemporal); 
				strcpy(Confederacion[j],Ctemporal);
				strcpy(Grupo[j],Gtemporal);
			}
		}
	}
	for(int i=8;i<12;i++){ //Ordenamos la confederacion para los grupo C
		for(int j=8;j<12;j++){
			if(strcmp(Confederacion[i],Confederacion[j])<0){ //El <0 representa de menor a mayor (A a Z)
				strcpy(Ntemporal,Nombre[i]); 
				strcpy(Ctemporal,Confederacion[i]);
				strcpy(Gtemporal, Grupo[i]);
				strcpy(Nombre[i],Nombre[j]); 
				strcpy(Confederacion[i],Confederacion[j]);
				strcpy(Grupo[i],Grupo[j]);
				strcpy(Nombre[j],Ntemporal); 
				strcpy(Confederacion[j],Ctemporal);
				strcpy(Grupo[j],Gtemporal);
			}
		}
	}
	for(int i=12;i<16;i++){ //Ordenamos la confederacion para los grupo D
		for(int j=12;j<16;j++){
			if(strcmp(Confederacion[i],Confederacion[j])<0){ //El <0 representa de menor a mayor (A a Z)
				strcpy(Ntemporal,Nombre[i]); 
				strcpy(Ctemporal,Confederacion[i]);
				strcpy(Gtemporal, Grupo[i]);
				strcpy(Nombre[i],Nombre[j]); 
				strcpy(Confederacion[i],Confederacion[j]);
				strcpy(Grupo[i],Grupo[j]);
				strcpy(Nombre[j],Ntemporal); 
				strcpy(Confederacion[j],Ctemporal);
				strcpy(Grupo[j],Gtemporal);
			}
		}
	}
	for(int i=16;i<20;i++){ //Ordenamos la confederacion para los grupo E
		for(int j=16;j<20;j++){
			if(strcmp(Confederacion[i],Confederacion[j])<0){ //El <0 representa de menor a mayor (A a Z)
				strcpy(Ntemporal,Nombre[i]); 
				strcpy(Ctemporal,Confederacion[i]);
				strcpy(Gtemporal, Grupo[i]);
				strcpy(Nombre[i],Nombre[j]); 
				strcpy(Confederacion[i],Confederacion[j]);
				strcpy(Grupo[i],Grupo[j]);
				strcpy(Nombre[j],Ntemporal); 
				strcpy(Confederacion[j],Ctemporal);
				strcpy(Grupo[j],Gtemporal);
			}
		}
	}
	for(int i=20;i<24;i++){ //Ordenamos la confederacion para los grupo F
		for(int j=20;j<24;j++){
			if(strcmp(Confederacion[i],Confederacion[j])<0){ //El <0 representa de menor a mayor (A a Z)
				strcpy(Ntemporal,Nombre[i]); 
				strcpy(Ctemporal,Confederacion[i]);
				strcpy(Gtemporal, Grupo[i]);
				strcpy(Nombre[i],Nombre[j]); 
				strcpy(Confederacion[i],Confederacion[j]);
				strcpy(Grupo[i],Grupo[j]);
				strcpy(Nombre[j],Ntemporal); 
				strcpy(Confederacion[j],Ctemporal);
				strcpy(Grupo[j],Gtemporal);
			}
		}
	}
	for(int i=24;i<28;i++){ //Ordenamos la confederacion para los grupo G
		for(int j=24;j<28;j++){
			if(strcmp(Confederacion[i],Confederacion[j])<0){ //El <0 representa de menor a mayor (A a Z)
				strcpy(Ntemporal,Nombre[i]); 
				strcpy(Ctemporal,Confederacion[i]);
				strcpy(Gtemporal, Grupo[i]);
				strcpy(Nombre[i],Nombre[j]); 
				strcpy(Confederacion[i],Confederacion[j]);
				strcpy(Grupo[i],Grupo[j]);
				strcpy(Nombre[j],Ntemporal); 
				strcpy(Confederacion[j],Ctemporal);
				strcpy(Grupo[j],Gtemporal);
			}
		}
	}
	for(int i=28;i<32;i++){ //Ordenamos la confederacion para los grupo H
		for(int j=28;j<32;j++){
			if(strcmp(Confederacion[i],Confederacion[j])<0){ //El <0 representa de menor a mayor (A a Z)
				strcpy(Ntemporal,Nombre[i]); 
				strcpy(Ctemporal,Confederacion[i]);
				strcpy(Gtemporal, Grupo[i]);
				strcpy(Nombre[i],Nombre[j]); 
				strcpy(Confederacion[i],Confederacion[j]);
				strcpy(Grupo[i],Grupo[j]);
				strcpy(Nombre[j],Ntemporal); 
				strcpy(Confederacion[j],Ctemporal);
				strcpy(Grupo[j],Gtemporal);
			}
		}
	}
	for(int i=0; i<EQUIPOS; i++){
		cout << Grupo[i] << " --- " << Confederacion[i] << " --- " << Nombre[i] << endl;
	}
}

void OrdenxTodo(){
	system("cls");
	printf("Grupo\t|\tConfederacion\t|\tEquipo\n\n");
	char Nombre[EQUIPOS][20], Confederacion[EQUIPOS][10], Grupo[EQUIPOS][10]; //Almacenamos el nombre en formato char para poder comparar
	char Ntemporal[20],Ctemporal[10], Gtemporal[10]; //Una variable para almacenar los datos de forma temporal
	for(int i=0; i<EQUIPOS; i++){
		strcpy(Nombre[i], Array[i][0].c_str());
		strcpy(Confederacion[i], Array[i][2].c_str());
		strcpy(Grupo[i], Array[i][1].c_str());
	}
	for(int i=0;i<EQUIPOS;i++){ //Orden por grupo 
		for(int j=0;j<=EQUIPOS;j++){
			if(strcmp(Grupo[i],Grupo[j])<0){ //El <0 representa de menor a mayor (A a Z)
				strcpy(Ntemporal,Nombre[i]); 
				strcpy(Ctemporal,Confederacion[i]);
				strcpy(Gtemporal, Grupo[i]);
				strcpy(Nombre[i],Nombre[j]); 
				strcpy(Confederacion[i],Confederacion[j]);
				strcpy(Grupo[i],Grupo[j]);
				strcpy(Nombre[j],Ntemporal); 
				strcpy(Confederacion[j],Ctemporal);
				strcpy(Grupo[j],Gtemporal);
			}
		}
	}
	
	for(int i=0;i<4;i++){ //Ordenamos la confederacion para los grupo A
		for(int j=0;j<4;j++){
			if(strcmp(Confederacion[i],Confederacion[j])<0){ //El <0 representa de menor a mayor (A a Z)
				strcpy(Ntemporal,Nombre[i]); 
				strcpy(Ctemporal,Confederacion[i]);
				strcpy(Gtemporal, Grupo[i]);
				strcpy(Nombre[i],Nombre[j]); 
				strcpy(Confederacion[i],Confederacion[j]);
				strcpy(Grupo[i],Grupo[j]);
				strcpy(Nombre[j],Ntemporal); 
				strcpy(Confederacion[j],Ctemporal);
				strcpy(Grupo[j],Gtemporal);
			}
			if(Confederacion[j][0]=='U'){ //Utilizamos la U, ya que la UEFA es la unica que pueda repetirse en el grupo
				if(strcmp(Nombre[i],Nombre[j])<0){ //El <0 representa de menor a mayor (A a Z)
					strcpy(Ntemporal,Nombre[i]); 
					strcpy(Ctemporal,Confederacion[i]);
					strcpy(Gtemporal, Grupo[i]);
					strcpy(Nombre[i],Nombre[j]); 
					strcpy(Confederacion[i],Confederacion[j]);
					strcpy(Grupo[i],Grupo[j]);
					strcpy(Nombre[j],Ntemporal); 
					strcpy(Confederacion[j],Ctemporal);
					strcpy(Grupo[j],Gtemporal); //Actualizamos los equipos de la UEFA
				}
			}
		}
	}
	for(int i=4;i<8;i++){ //Ordenamos la confederacion para los grupo B
		for(int j=4;j<8;j++){
			if(strcmp(Confederacion[i],Confederacion[j])<0){ //El <0 representa de menor a mayor (A a Z)
				strcpy(Ntemporal,Nombre[i]); 
				strcpy(Ctemporal,Confederacion[i]);
				strcpy(Gtemporal, Grupo[i]);
				strcpy(Nombre[i],Nombre[j]); 
				strcpy(Confederacion[i],Confederacion[j]);
				strcpy(Grupo[i],Grupo[j]);
				strcpy(Nombre[j],Ntemporal); 
				strcpy(Confederacion[j],Ctemporal);
				strcpy(Grupo[j],Gtemporal);
			}
			if(Confederacion[j][0]=='U'){ //Utilizamos la U, ya que la UEFA es la unica que pueda repetirse en el grupo
				if(strcmp(Nombre[i],Nombre[j])<0){ //El <0 representa de menor a mayor (A a Z)
					strcpy(Ntemporal,Nombre[i]); 
					strcpy(Ctemporal,Confederacion[i]);
					strcpy(Gtemporal, Grupo[i]);
					strcpy(Nombre[i],Nombre[j]); 
					strcpy(Confederacion[i],Confederacion[j]);
					strcpy(Grupo[i],Grupo[j]);
					strcpy(Nombre[j],Ntemporal); 
					strcpy(Confederacion[j],Ctemporal);
					strcpy(Grupo[j],Gtemporal); //Actualizamos los equipos de la UEFA
				}
			}
		}
	}
	for(int i=8;i<12;i++){ //Ordenamos la confederacion para los grupo C
		for(int j=8;j<12;j++){
			if(strcmp(Confederacion[i],Confederacion[j])<0){ //El <0 representa de menor a mayor (A a Z)
				strcpy(Ntemporal,Nombre[i]); 
				strcpy(Ctemporal,Confederacion[i]);
				strcpy(Gtemporal, Grupo[i]);
				strcpy(Nombre[i],Nombre[j]); 
				strcpy(Confederacion[i],Confederacion[j]);
				strcpy(Grupo[i],Grupo[j]);
				strcpy(Nombre[j],Ntemporal); 
				strcpy(Confederacion[j],Ctemporal);
				strcpy(Grupo[j],Gtemporal);
			}
			if(Confederacion[j][0]=='U'){ //Utilizamos la U, ya que la UEFA es la unica que pueda repetirse en el grupo
				if(strcmp(Nombre[i],Nombre[j])<0){ //El <0 representa de menor a mayor (A a Z)
					strcpy(Ntemporal,Nombre[i]); 
					strcpy(Ctemporal,Confederacion[i]);
					strcpy(Gtemporal, Grupo[i]);
					strcpy(Nombre[i],Nombre[j]); 
					strcpy(Confederacion[i],Confederacion[j]);
					strcpy(Grupo[i],Grupo[j]);
					strcpy(Nombre[j],Ntemporal); 
					strcpy(Confederacion[j],Ctemporal);
					strcpy(Grupo[j],Gtemporal); //Actualizamos los equipos de la UEFA
				}
			}
		}
	}
	for(int i=12;i<16;i++){ //Ordenamos la confederacion para los grupo D
		for(int j=12;j<16;j++){
			if(strcmp(Confederacion[i],Confederacion[j])<0){ //El <0 representa de menor a mayor (A a Z)
				strcpy(Ntemporal,Nombre[i]); 
				strcpy(Ctemporal,Confederacion[i]);
				strcpy(Gtemporal, Grupo[i]);
				strcpy(Nombre[i],Nombre[j]); 
				strcpy(Confederacion[i],Confederacion[j]);
				strcpy(Grupo[i],Grupo[j]);
				strcpy(Nombre[j],Ntemporal); 
				strcpy(Confederacion[j],Ctemporal);
				strcpy(Grupo[j],Gtemporal);
			}
			if(Confederacion[j][0]=='U'){ //Utilizamos la U, ya que la UEFA es la unica que pueda repetirse en el grupo
				if(strcmp(Nombre[i],Nombre[j])<0){ //El <0 representa de menor a mayor (A a Z)
					strcpy(Ntemporal,Nombre[i]); 
					strcpy(Ctemporal,Confederacion[i]);
					strcpy(Gtemporal, Grupo[i]);
					strcpy(Nombre[i],Nombre[j]); 
					strcpy(Confederacion[i],Confederacion[j]);
					strcpy(Grupo[i],Grupo[j]);
					strcpy(Nombre[j],Ntemporal); 
					strcpy(Confederacion[j],Ctemporal);
					strcpy(Grupo[j],Gtemporal); //Actualizamos los equipos de la UEFA
				}
			}
		}
	}
	for(int i=16;i<20;i++){ //Ordenamos la confederacion para los grupo E
		for(int j=16;j<20;j++){
			if(strcmp(Confederacion[i],Confederacion[j])<0){ //El <0 representa de menor a mayor (A a Z)
				strcpy(Ntemporal,Nombre[i]); 
				strcpy(Ctemporal,Confederacion[i]);
				strcpy(Gtemporal, Grupo[i]);
				strcpy(Nombre[i],Nombre[j]); 
				strcpy(Confederacion[i],Confederacion[j]);
				strcpy(Grupo[i],Grupo[j]);
				strcpy(Nombre[j],Ntemporal); 
				strcpy(Confederacion[j],Ctemporal);
				strcpy(Grupo[j],Gtemporal);
			}
			if(Confederacion[j][0]=='U'){ //Utilizamos la U, ya que la UEFA es la unica que pueda repetirse en el grupo
				if(strcmp(Nombre[i],Nombre[j])<0){ //El <0 representa de menor a mayor (A a Z)
					strcpy(Ntemporal,Nombre[i]); 
					strcpy(Ctemporal,Confederacion[i]);
					strcpy(Gtemporal, Grupo[i]);
					strcpy(Nombre[i],Nombre[j]); 
					strcpy(Confederacion[i],Confederacion[j]);
					strcpy(Grupo[i],Grupo[j]);
					strcpy(Nombre[j],Ntemporal); 
					strcpy(Confederacion[j],Ctemporal);
					strcpy(Grupo[j],Gtemporal); //Actualizamos los equipos de la UEFA
				}
			}
		}
	}
	for(int i=20;i<24;i++){ //Ordenamos la confederacion para los grupo F
		for(int j=20;j<24;j++){
			if(strcmp(Confederacion[i],Confederacion[j])<0){ //El <0 representa de menor a mayor (A a Z)
				strcpy(Ntemporal,Nombre[i]); 
				strcpy(Ctemporal,Confederacion[i]);
				strcpy(Gtemporal, Grupo[i]);
				strcpy(Nombre[i],Nombre[j]); 
				strcpy(Confederacion[i],Confederacion[j]);
				strcpy(Grupo[i],Grupo[j]);
				strcpy(Nombre[j],Ntemporal); 
				strcpy(Confederacion[j],Ctemporal);
				strcpy(Grupo[j],Gtemporal);
			}
			if(Confederacion[j][0]=='U'){ //Utilizamos la U, ya que la UEFA es la unica que pueda repetirse en el grupo
				if(strcmp(Nombre[i],Nombre[j])<0){ //El <0 representa de menor a mayor (A a Z)
					strcpy(Ntemporal,Nombre[i]); 
					strcpy(Ctemporal,Confederacion[i]);
					strcpy(Gtemporal, Grupo[i]);
					strcpy(Nombre[i],Nombre[j]); 
					strcpy(Confederacion[i],Confederacion[j]);
					strcpy(Grupo[i],Grupo[j]);
					strcpy(Nombre[j],Ntemporal); 
					strcpy(Confederacion[j],Ctemporal);
					strcpy(Grupo[j],Gtemporal); //Actualizamos los equipos de la UEFA
				}
			}
		}
	}
	for(int i=24;i<28;i++){ //Ordenamos la confederacion para los grupo G
		for(int j=24;j<28;j++){
			if(strcmp(Confederacion[i],Confederacion[j])<0){ //El <0 representa de menor a mayor (A a Z)
				strcpy(Ntemporal,Nombre[i]); 
				strcpy(Ctemporal,Confederacion[i]);
				strcpy(Gtemporal, Grupo[i]);
				strcpy(Nombre[i],Nombre[j]); 
				strcpy(Confederacion[i],Confederacion[j]);
				strcpy(Grupo[i],Grupo[j]);
				strcpy(Nombre[j],Ntemporal); 
				strcpy(Confederacion[j],Ctemporal);
				strcpy(Grupo[j],Gtemporal);
			}
			if(Confederacion[j][0]=='U'){ //Utilizamos la U, ya que la UEFA es la unica que pueda repetirse en el grupo
				if(strcmp(Nombre[i],Nombre[j])<0){ //El <0 representa de menor a mayor (A a Z)
					strcpy(Ntemporal,Nombre[i]); 
					strcpy(Ctemporal,Confederacion[i]);
					strcpy(Gtemporal, Grupo[i]);
					strcpy(Nombre[i],Nombre[j]); 
					strcpy(Confederacion[i],Confederacion[j]);
					strcpy(Grupo[i],Grupo[j]);
					strcpy(Nombre[j],Ntemporal); 
					strcpy(Confederacion[j],Ctemporal);
					strcpy(Grupo[j],Gtemporal); //Actualizamos los equipos de la UEFA
				}
			}
		}
	}
	for(int i=28;i<32;i++){ //Ordenamos la confederacion para los grupo H
		for(int j=28;j<32;j++){
			if(strcmp(Confederacion[i],Confederacion[j])<0){ //El <0 representa de menor a mayor (A a Z)
				strcpy(Ntemporal,Nombre[i]); 
				strcpy(Ctemporal,Confederacion[i]);
				strcpy(Gtemporal, Grupo[i]);
				strcpy(Nombre[i],Nombre[j]); 
				strcpy(Confederacion[i],Confederacion[j]);
				strcpy(Grupo[i],Grupo[j]);
				strcpy(Nombre[j],Ntemporal); 
				strcpy(Confederacion[j],Ctemporal);
				strcpy(Grupo[j],Gtemporal);
			}
			if(Confederacion[j][0]=='U'){ //Utilizamos la U, ya que la UEFA es la unica que pueda repetirse en el grupo
				if(strcmp(Nombre[i],Nombre[j])<0){ //El <0 representa de menor a mayor (A a Z)
					strcpy(Ntemporal,Nombre[i]); 
					strcpy(Ctemporal,Confederacion[i]);
					strcpy(Gtemporal, Grupo[i]);
					strcpy(Nombre[i],Nombre[j]); 
					strcpy(Confederacion[i],Confederacion[j]);
					strcpy(Grupo[i],Grupo[j]);
					strcpy(Nombre[j],Ntemporal); 
					strcpy(Confederacion[j],Ctemporal);
					strcpy(Grupo[j],Gtemporal); //Actualizamos los equipos de la UEFA
				}
			}
		}
	}
	
	
	for(int i=0; i<EQUIPOS; i++){ //Imprimimos
		cout << Grupo[i] << " --- " << Confederacion[i] << " --- " << Nombre[i] << endl;
	}
}	
