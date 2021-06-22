#include <iostream>
using std::cout;
using std::cin;

int main()
{
	int numero;
	int suma;
	suma = 0;
	int sumap;
	sumap = 0;
	float promedio;
	int contador;
	contador = 0;
	int fuera;
	fuera = 0;
	int j = 50;
	
	for(int i=0; i<50; i++)
	{
		cout << "Ingrese un numero:\n";
		cin >> numero;
		if(numero>100)
		{
			sumap = sumap+numero;
			contador++;
		}
		else if(numero<=-10)
		{
			suma = suma+numero;
		}
		else
		{
			cout << "Este numero no concreta ni una operacion.\n";
			fuera++;
		}
		j = j-1;
		cout << "Faltan ingresar\t:" << j << " numeros.\n";
	}
	if(contador==0)
	{
		promedio = 0;
		cout << "No hay numeros mayores a 100, por lo tanto, no hay promedio.\n";
		cout << "La suma de los numeros menores a -10 es: " << suma << "\n";
		cout << "Ingreso " << fuera << " numeros que no cumplen ni una funcion.\n";
	}
	else
	{
	promedio = sumap/contador;
	cout << "El promedio de los numeros mayores a 100 es: " << promedio << "\n";
	cout << "La suma de los numeros menores a -10 es: " << suma << "\n";
	cout << "Ingreso " << fuera << " numeros que no cumplen ni una funcion.\n";
	}
	return 0;
}
