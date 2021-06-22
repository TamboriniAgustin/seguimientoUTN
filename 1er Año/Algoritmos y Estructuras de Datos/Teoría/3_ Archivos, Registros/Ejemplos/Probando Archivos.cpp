#include <iostream>
#include <string.h>
#include <stdio.h>
using namespace std;

int main()
{
	int alumnos;
	char nombre[20];
	char legajo[8];
	FILE* prueba = fopen("prueba.txt","w+");
	fseek(prueba,0,SEEK_SET); //Ubico el archivo al inicio
	fputs("Alumno        Legajo\n", prueba);
	int pos = ftell(prueba);
	cout << "Cuantos alumnos desea ingresar?\n";
	cin >> alumnos;
	for(int i=1;i<=alumnos;i++){
		cout << "*****Alumno " << i << "*****\n";
		cout << "Ingrese el nombre del alumno: ";
		cin >> nombre;
		cout << "Ingrese el legajo del alumno: ";
		cin >> legajo;
		printf("*****Posicion actual del archivo en: %d*****\n\n", ftell(prueba)); //Imprime la posicion del archivo actual
		fputs(nombre, prueba);
		fputs("        ",prueba);
		fputs(legajo, prueba);
		fputs("\n", prueba);
	}
	return 0;
}
