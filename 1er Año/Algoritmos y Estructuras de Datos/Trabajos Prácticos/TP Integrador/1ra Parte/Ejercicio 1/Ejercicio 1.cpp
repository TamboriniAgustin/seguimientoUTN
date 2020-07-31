#include <iostream>
#include <stdio.h>
#include <string.h>
using namespace std;

struct Sorteo{
	int Bolillero;
	char NEquipo[20];
	char Confederacion[10];
};

void Ejercicio1();

int main(){
	Ejercicio1();
	return 0;
}

void Ejercicio1(){
	Sorteo sort;
	FILE* F = fopen("Bolilleros.txt","wb+");
	cout << "************************************************************************************************************************\nBienvenido! A continuacion crearemos un archivo que almacene los 8 bolilleros con los equipos clasificados a Rusia 2018\n************************************************************************************************************************\n\n";
	for(int i=1;i<=4;i++){
		sort.Bolillero = i;
		cout << "Bolillero: " << sort.Bolillero << endl;
		for(int i=1;i<=8;i++){
			cout << "Ingrese el nombre de equipo: ";
			cin >> sort.NEquipo;
			cout << "Ingrese la confederacion a donde pertenece: ";
			cin >> sort.Confederacion;
			fwrite(&sort,sizeof(sort),1,F);
		}
		system("cls");
	}
}
