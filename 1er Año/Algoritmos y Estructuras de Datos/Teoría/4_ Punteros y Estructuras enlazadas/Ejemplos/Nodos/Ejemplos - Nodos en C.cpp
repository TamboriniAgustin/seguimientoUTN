#include <iostream>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
using namespace std;

struct Nodo{
	int info;
	Nodo *sig;	
};

void AgregarPila(Nodo **, int);
void EliminarPila(Nodo **, int *);


int main(){
	//Ejercicio: agregar numeros enteros a la pila hasta que el usuario decida parar, imprimir los elementos introducidos en ella. Eliminar los elementos.
	int N, num;
	Nodo *pila = NULL;
	cout << "Ingrese cuantos numeros desea ingresar: ";
	cin >> N;
	for(int i=0;i<N;i++){
		cout << "Ingrese valor " << i << ": ";
		cin >> num;
		AgregarPila(&pila,num);
	}
	while(pila!=NULL){
		EliminarPila(&pila,&num);
		cout << "Elemento " << num << " eliminado de la pila!" << endl;
	}
	
	system ("pause");
	return 0;
}

void AgregarPila(Nodo **pila, int dato){
	Nodo *nuevo = (Nodo *)malloc(sizeof(Nodo));
	nuevo->info = dato;
	nuevo->sig = *pila;
	*pila = nuevo;
	cout << "El numero entero " << dato << " fue agregado a la pila correctamente!" << endl;
}

void EliminarPila(Nodo **pila, int *dato){
	Nodo *aux = *pila;
	*dato = aux->info;
	*pila = aux->sig;
	free(aux);
}
