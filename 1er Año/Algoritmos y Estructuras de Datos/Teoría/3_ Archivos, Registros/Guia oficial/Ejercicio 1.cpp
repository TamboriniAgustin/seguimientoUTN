#include <iostream>
#include <cstdlib>
#include <cstring>
#include <string>
using namespace std;

int main(){
	string Alu;
	string nota[2], legajo, acum=0;
	string promedio=0;
	const char* filepath = "Ejercicio 1 - CURSO";
	FILE *F;
	F = fopen(filepath,"w");
	cout << "Ingrese el legajo de un alumno (8 Caracteres): ";
	cin >> legajo;
	if(legajo<10000000 && legajo>=0){
		for(int i=1;i<10;){
			cout << "ERROR! INGRESE UN LEGAJO DE 8 DIGITOS Y DISTINTO DE 0\n";
			cin >> legajo;
			if(legajo>=10000000 || legajo<0){
				i=10;
			}
		}
	}
	while(legajo>0){
		acum++;
		cout << "Ingrese el nombre del alumno: ";
		cin >> Alu;
		cout << "Ingrese la nota que saco en el primer parcial: ";
		cin >> nota[0];
		if(nota[0]<1 || nota[0]>10){
			for(int i=1;i<10;){
				cout << "ERROR! INGRESE UNA NOTA ENTRE 1 Y 10\n";
				cin >> nota[0];;
				if((nota[0]>=1 && nota[0]<=10)){
					i=10;
				}
			}
		}
		cout << "Ingrese la nota que saco en el segundo parcial: ";
		cin >> nota[1];
		if(nota[1]<1 || nota[1]>10){
			for(int i=1;i<10;){
				cout << "ERROR! INGRESE UNA NOTA ENTRE 1 Y 10\n";
				cin >> nota[1];;
				if((nota[1]>=1 && nota[1]<=10)){
					i=10;
				}
			}
		}
		promedio = (nota[0]+nota[1])/acum;
		//AGREGO LOS DATOS PEDIDOS AL ARCHIVO//
		const char *text = (legajo + " " + promedio).c_str();
		fputs(text, F);
		fwrite(text,1,strlen(text),F);
		fwrite(text,"\n",sizeof(char),1,F);
		//-----------------------------------//
		cout << "Ingrese el legajo de otro alumno: ";
		cin >> legajo;
		if(legajo<10000000 && legajo>=0){
			for(int i=1;i<10;){
				cout << "ERROR! INGRESE UN LEGAJO DE 8 DIGITOS Y DISTINTO DE 0\n";
				cin >> legajo;
				if(legajo>=10000000 || legajo<0){
					i=10;
				}
			}
		}
	}
	fclose(F);
	return 0;
}
