#include <iostream>
using namespace std;

int MCD(int a, int b)
{
	int resul, rest;
	resul = a/b;
	rest = a-(b*resul);
	if(rest==0)
	{
		return b;
	}
	else
	{
		int restart = MCD(b,rest);
	}
}

int main()
{
	int n1,n2;
	cout << "Introduzca un numero entero: ";
	cin >> n1;
	cout << "Introduzca otro numero entero: ";
	cin >> n2;
	int resultado = MCD(n1,n2);
	cout << "El Maximo Comun Divisor de " << n1 << " y " << n2 << " es " << resultado << "\n";
	cout << "(Si el resto es diferente de 0, entonces se reemplaza A por B y B por el resto para sacar el resultado)";
	return 0;
}
