#include <iostream>
using namespace std;

int factorial(int a)
{
	float factorial=1;
	for(float b=1; b<=a; b++)
	{
		factorial=b*factorial;
	}
	return factorial;
}

int main()
{
	int nro;
	cout << "Ingrese un numero: ";
	cin >> nro;
	if(nro<=0)
	{
		cout << "ERROR! Debe ser un numero entero positivo!\n";
		cin >> nro;
	}
	float result;
	result = factorial(nro);
	cout << "El factorial de tal numero es: " << result << "\n";
	return 0;
}
