#include <iostream>
using namespace std;

int main()
{
	int contenedor = 0;
	int puerto, peso;
	int acump = 0;
	int may = 0;
	int pmay = 0;
	int acumpto[3];
	acumpto[0] = 0;
	acumpto[1] = 0;
	acumpto[2] = 0;
	while(contenedor<100)
	{
		contenedor++;
		cout << "Identificacion del Contenedor: " << contenedor << "\n";
		cout << "Inserte el puerto al que sera transladado (1,2,3): ";
		cin >> puerto;
		switch(puerto)
		{
			case 1: acumpto[0]++;
			break;
			case 2: acumpto[1]++;
			break;
			case 3: acumpto[2]++;
			break;
			default:
			{
				cout << "ERROR! Solo se permiten muelles 1,2 o 3\n";
				cout << "Ingrese nuevamente el valor: ";
				cin >> puerto;		
			}
		}
		cout << "Bien, ahora ingrese el peso del contenedor: ";
		cin >> peso;
		acump = acump + peso;
		if(peso<=0)
		{
			cout << "ERROR! El peso nunca puede ser negativo.\n";
			cout << "Ingrese nuevamente el valor del peso: ";
			cin >> peso;
			acump = acump + peso;
		}
		if(peso>may)
		{
			may = peso;
			pmay = contenedor;
		}
		if(contenedor==1)
		{
			may = peso;
			pmay = contenedor;
		}
	}
	cout << "El peso total que el buque carga es de: " << acump << "kg\n";
	cout << "El contenedor de mayor peso es el numero: " << pmay << "\n";
	cout << "Se enviaron " << acumpto[0] << " contenedores al puerto 1\n";
	cout << "Se enviaron " << acumpto[1] << " contenedores al puerto 2\n";
	cout << "Se enviaron " << acumpto[2] << " contenedores al puerto 3\n";
	return 0;
}
