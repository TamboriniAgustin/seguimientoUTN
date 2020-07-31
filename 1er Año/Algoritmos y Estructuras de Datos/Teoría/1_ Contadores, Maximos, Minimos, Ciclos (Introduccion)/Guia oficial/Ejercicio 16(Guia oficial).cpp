#include <iostream>
using namespace std;

int main()
{
	int rep = 0;
	int valor;
	int acum = 0;
while(acum>=0)
{	acum++;
	cout << "Ingrese un valor:\n";
	cin >> valor;
	
	if(valor>=0)
	{
		cout << "El valor ingresado es " << valor << "\n";
		rep++;
		cout << "Es el valor numero: " << rep << "\n";
	}
	else
	{
		cout << "El valor ingresado no sera tomado en cuenta\n";
	}
}
	return 0;
}
