#include <iostream>
using namespace std;

int EdadAGrupoEtario (int edad)
{
	if(edad>0 && edad<=14)
	{
		return 1;
	}
	else if(edad>=22 && edad<=28)
	{
		return 3;
	}
	else if(edad>=36 && edad<=42)
	{
		return 5;
	}
	else if(edad>=50 && edad<=63)
	{
		return 7;
	}
	else if(edad>=15 && edad<=21)
	{
		return 2;
	}
	else if(edad>=29 && edad<=35)
	{
		return 4;
	}
	else if(edad>=43 && edad<=49)
	{
		return 6;
	}
	else if(edad>63)
	{
		return 8;
	}
}

int main()
{
	int edad, result;
	cout << "Ingrese la edad que tienes: ";
	cin >> edad;
	if(edad<=0)
	{
		cout << "La edad debe ser mayor a 0. Ingresela nuevamente: ";
		cin >> edad;	
	}
	result = EdadAGrupoEtario (edad);
	cout << "Perteneces al grupo etario: " << result;
	return 0;
}
