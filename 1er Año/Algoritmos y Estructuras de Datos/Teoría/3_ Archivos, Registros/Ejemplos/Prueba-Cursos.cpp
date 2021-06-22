#include <iostream>
#include <fstream>
#include <string.h>
#include <cstdlib>
using namespace std;

struct Curso{
	char Especialidad[25];
	char Codigo[5];
	int Alumnos;
};

int main(){
	Curso C;
	int eleccion;
	cout << "Ingrese opcion 1 para crear el archivo y 2 para leerlo\n";
	cin >> eleccion;
	if(eleccion==1){
	ofstream cursos;
	cursos.open("prueba-cursos.txt");
	int i;
	cout << "¿Cuantos cursos desea anotar?\n";
	cin >> i;
	system("cls");
	for(int j=1;j<=i;j++){
		cout << "Ingrese la especialidad del curso " << j << ": ";
		cin >> C.Especialidad;
		cout << "Ingrese el codigo: ";
		cin >> C.Codigo;
		cout << "Ingrese la cantidad de alumnos del curso: ";
		cin >> C.Alumnos;
		system("cls");
		cursos << "Curso " << j << endl;
		cursos << "Especialidad: " << C.Especialidad << "\t\t";
		cursos << "Codigo: " << C.Codigo << "\t\t";
		cursos << "Alumnos: " << C.Alumnos << "\n\n";
	}
	cursos.close();
	}
	else{
	ifstream cursos;
	cursos.open("prueba-cursos.txt");
	string linea;
	printf("\n****************************************\n");
	while(!cursos.eof()){
		getline(cursos,linea);
		cout << linea << endl;
	}
	printf("\n****************************************\n");
	cursos.close();	
	}
}
