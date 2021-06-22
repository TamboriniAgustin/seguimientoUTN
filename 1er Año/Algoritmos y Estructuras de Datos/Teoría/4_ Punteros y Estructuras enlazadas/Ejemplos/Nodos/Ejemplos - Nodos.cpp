#include <iostream>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
using namespace std;

struct Nodo{
	int info;
	Nodo *sig;	
};

void AgregarPila(Nodo *&, int);
void EliminarPila(Nodo *&, int &);

void AgregarCola(Nodo *&,Nodo *&,int);
void EliminarCola(Nodo *&,Nodo *&,int &);

int main(){
	//Ejercicio: agregar numeros enteros a la pila hasta que el usuario decida parar, imprimir los elementos introducidos en ella. Eliminar los elementos.
	int N, num;
	Nodo *pila = NULL;
	cout << "Ingrese cuantos numeros desea ingresar: ";
	cin >> N;
	for(int i=0;i<N;i++){
		cout << "Ingrese valor " << i << ": ";
		cin >> num;
		AgregarPila(pila,num);
	}
	while(pila!=NULL){
		EliminarPila(pila,num);
		cout << "Elemento " << num << " eliminado de la pila!" << endl;
	}
	//Ejercicio: crear menu que tenga las opciones 1_Crear un numero para una cola/2_Mostrar los elementos de la cola/3_Salir
	Nodo *frentecola = NULL;
	Nodo *fincola = NULL;
	int opcion, dato;
	do{
		printf("\t\t***** MENU *****\n1_ Insertar dato en la cola\n2_ Mostrar los elementos de la cola\n3_Salir\n\n ");
		cin >> opcion;
		if(opcion==1){
			system("cls");
			printf("Ingrese un dato: ");
			cin >> dato;
			AgregarCola(frentecola,fincola,dato);
		}
		else if(opcion==2){
			system("cls");
			printf("Elementos de la cola:\n");
			while(frentecola!=NULL){
				EliminarCola(frentecola,fincola,dato);
				if(frentecola!=NULL) printf("%d\n",dato);
			}
		}
	}
	while(opcion!=3);
	return 0;
}

void AgregarPila(Nodo *&pila, int dato){
	Nodo *nuevo = new Nodo();
	nuevo->info = dato;
	nuevo->sig = pila;
	pila = nuevo;
	cout << "El numero entero " << dato << " fue agregado a la pila correctamente!" << endl;
}

void EliminarPila(Nodo *&pila, int &dato){
	Nodo *aux = pila;
	dato = aux->info;
	pila = aux->sig;
	delete aux;
}

void AgregarCola(Nodo *&frentecola, Nodo *&fincola, int dato){
	Nodo *nuevonodo = new Nodo();
	nuevonodo->info = dato;
	if(frentecola==NULL) frentecola = nuevonodo;
	else fincola->sig = nuevonodo;
	fincola = nuevonodo;
	printf("\n***** Elemento insertado a la cola *****\n");
}

void EliminarCola(Nodo *&frentecola, Nodo *&fincola, int &dato){
	dato = frentecola->info;
	Nodo *aux = frentecola;
	if(frentecola==fincola){
		frentecola = NULL;
		fincola = NULL;
	}
	else frentecola = frentecola->sig;
	delete aux;
}
