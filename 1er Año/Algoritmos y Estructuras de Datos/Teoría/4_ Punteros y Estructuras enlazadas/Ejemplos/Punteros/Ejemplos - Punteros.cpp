#include <iostream>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
using namespace std;

struct Alumno{
	char nombre[10];
	int edad;
	float promedio;
};

int main(){
	//PUNTEROS
	int a = 20;
	int *p;
	p = &a;
	cout << "El valor de a es: " << *p << " y la direccion de memoria es: " << p << endl;
	system("pause");
	//Ejercicio: comprobar si un numero es par o impar y señalar la posicion de memoria donde se esta guardando el numero con punteros
	system("cls");
	int nro, *pnro;
	cout << "Ingrese un numero: ";
	cin >> nro;
	pnro = &nro;
	if(*pnro % 2 == 0) cout << "El numero ingresado es par!" << endl;
	else cout << "El numero ingresado es impar!" << endl;
	cout << "La posicion de memoria del numero es " << pnro << endl;
	system("pause");
	//Ejercicio: comprobar si un numero es primo o no y señalar la posicion de memoria donde se esta guardando el numero con punteros
	system("cls");
	int num2, *pnro2, acum;
	cout << "Ingrese un numero: ";
	cin >> num2;
	pnro2 = &num2;
	for(int i=1;i<=*pnro2;i++){
		if(*pnro2%i==0) acum++;
	}
	if(acum==2) cout << "El numero es primo!" << endl;
	else cout << "El numero no es primo!" << endl;
	cout << "La posicion de memoria es " << pnro2 << endl;
	system("pause");
																
	//PUNTEROS CON ARRAYS
	system("cls");
	int num3[] = {2,4,7,3,1};
	int *pnum3;
	pnum3 = num3;
	for(int i=0;i<5;i++){
		cout << "Elemento: " << *pnum3++ << endl;
		cout << "Posicion: " << pnum3 << endl;
	}
	system("pause");
	//Ejercicio: rellenar un array de 10 numeros, posteriormente utilizando punteros indicar los numeros pares y su posicion en memoria
	system("cls");
	int array[10] = {1,5,6,4,9,4,12,101,543,1000};
	int *parray;
	parray = array;
	for(int i=0; i<10; i++){
		if(*parray % 2 == 0) cout << "El numero " << *parray << " es par! - Posicion de memoria: " << parray << endl;
		*parray++;
	}
	system("pause");
	//Ejercicio: rellenar un array con n numeros, posteriormente utilizando punteros imprimir el menor de todos
	system("cls");
	int array2[3] = {65,102,-4};
	int *parray2;
	int marray2 = 0;
	parray2 = array2;
	for(int i=0; i<3; i++){
		if(i==0) marray2 = *parray2;
		else{
			if(*parray2<marray2) marray2 = *parray2;
		}
		*parray2++;
	}
	cout << "El menor elemento es: " << marray2 << endl;
	system("pause");
	
	//PUNTEROS DINAMICOS EN VARIABLES SIMPLES
	system("cls");
	int din0, *pdin0;
	cout << "Ingrese el valor de la variable: " << endl;
	cin >> din0;
	pdin0 = new int;
	*pdin0 = din0;
	delete pdin0;
	system("pause");
	
	//PUNTEROS DINAMICOS EN ARREGLOS
	system("cls");
	int din, *pdin;
	cout << "Ingrese el tamaño del array: " << endl;
	cin >> din;
	pdin = new int[din];
	for(int i=0; i<din; i++){
		cout << "Ingrese valor: " << endl;
		cin >> pdin[i];
	}
	for(int i=0; i<din; i++){
		cout << "Valor de " << i << ": " << pdin[i] << endl;
	}
	delete [] pdin; //Liberamos el espacio dinamico creado
	system("pause");															
	//Ejercicio: Pedir al usuario N numeros, almacenarlos en un arreglo dinamico. Posteriormente ordenar los numeros en orden ascendente y mostrarlos en pantalla
	system("cls");
	int tnumN, *Npt, acumN;
	cout << "Ingrese el tamaño del array: " << endl;
	cin >> tnumN;
	Npt = new int[tnumN];
	for(int i=0;i<tnumN;i++){
		cout << "Ingresa el valor " << i << ": ";
		cin >> *(Npt+i);
	}
	for(int i=0;i<tnumN;i++){
		for(int j=0;j<tnumN-1;j++){
			if(*(Npt+j)>*(Npt+j+1)){
				acumN = *(Npt+j);
				*(Npt+j) = *(Npt+j+1);
				*(Npt+j+1) = acumN;
			}
		}
	}
	for(int i=0;i<tnumN;i++){
		cout << *(Npt+i)<< endl;
	}
	delete [] Npt;
	system("pause");
	//Ejercicio: Pedir un nombre al usuario y devolver la cantidad de vocales que tiene. Usar Punteros
	system("cls");
	char nombre[10];
	int vocales=0;
	cout << "Ingrese nombre de usuario: ";
	cin >> nombre;
	strupr(nombre); //Transforma a mayuscula para hacer mas facil hallar
	char *ptrn;
	ptrn = &nombre[0];
	while(*ptrn){
		switch(*ptrn){
			case 'A': vocales++;
				break;
			case 'E': vocales++;
				break;
			case 'I': vocales++;
				break;
			case 'O': vocales++;
				break;
			case 'U': vocales++;
				break;				
		}
		ptrn++;
	}
	cout << "El numero de vocales es de " << vocales << endl;
	system("pause");
	//Ejercicio: realizar un programa que calcule la suma de 2 matrices dinamicas. Utilize punteros. Imprima la matriz transpuesta.
	system("cls");
	int **ptrM1, **ptrM2, filas, columnas;
	cout << "Ingrese el numero de filas de la matriz: "; //Matriz 1
	cin >> filas;
	cout << "Ingrese el numero de columnas de la matriz: ";
	cin >> columnas;
	ptrM1 = new int*[filas];
	for(int i=0;i<filas;i++){
		ptrM1[i] = new int[columnas];
	}
	cout << "Ingrese los valores de la primera matriz: \n";
	for(int i=0;i<filas;i++){
		for(int j=0;j<columnas;j++){
			cout << "Valor [" << i << "] [" << j << "]: ";
			cin >> *(*(ptrM1+i)+j);
		}
	}
	ptrM2 = new int*[filas]; //Matriz 2
	for(int i=0;i<filas;i++){
		ptrM2[i] = new int[columnas];
	}
	cout << "Ingrese los valores de la segunda matriz: \n";
	for(int i=0;i<filas;i++){
		for(int j=0;j<columnas;j++){
			cout << "Valor [" << i << "] [" << j << "]: ";
			cin >> *(*(ptrM2+i)+j);
		}
	}
	for(int i=0;i<filas;i++){ //Realiza la suma
		for(int j=0;j<columnas;j++){
			*(*(ptrM1+i)+j) += *(*(ptrM2+i)+j);
		}
	}
	cout << "La suma de matrices representa a la matriz\n";
	for(int i=0;i<filas;i++){
		for(int j=0;j<columnas;j++){
			cout << *(*(ptrM1+i)+j);
		}
		cout << endl;
	}
	cout << "La transpuesta de la matriz\n";
	for(int i=0;i<filas;i++){
		for(int j=0;j<columnas;j++){
			cout << *(*(ptrM1+j)+i);
		}
		cout << endl;
	}
	for(int i=0;i<filas;i++){ //Libero memoria
		delete [] ptrM1[i];
		delete [] ptrM2[i];
	}
	delete [] ptrM1;
	delete [] ptrM2;
	system("pause");
	//Ejercicio: Realizar una estructura llamada alumnos con campos: nombre edad y promedio. Pedir los datos de 3 alumnos y calcular cual tiene mayor promedio. Usar punteros.
	system("cls");
	Alumno notas[3], *ptrAlu = notas;
	char Alu[10];
	float mayorprom = 0;
	for(int i=0;i<3;i++){
		cout << "Alumno " << i << ":" << endl;
		cout << "\tIngrese su nombre: ";
		cin >> (ptrAlu+i)->nombre;
		cout << "\tIngrese su edad: ";
		cin >> (ptrAlu+i)->edad;
		cout << "\tIngrese su promedio: ";
		cin >> (ptrAlu+i)->promedio;
		if(mayorprom<=(ptrAlu+i)->promedio) {
			mayorprom = (ptrAlu+i)->promedio;
			strcpy(Alu,(ptrAlu+i)->nombre);	
		}
	}
	cout << "El mayor promedio de los 3 es: " << Alu << " con promedio " << mayorprom << endl;
	system("pause");
	return 0;
}
