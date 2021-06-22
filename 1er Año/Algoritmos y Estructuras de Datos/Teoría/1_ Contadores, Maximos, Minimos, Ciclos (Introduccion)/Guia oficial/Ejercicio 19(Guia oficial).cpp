#include <iostream>
using namespace std;

int main()
{
	//PUNTO 16
	int valor;
	cout << "Punto 16 (Finaliza con un numero negativo)\n";
	for(int i=0;i>=0;)
	{	
		cout << "Ingrese un valor:\n";
		cin >> valor;
		if(valor>=0)
		{
			i++;
			cout << "El valor ingresado es " << valor << "\n";
			cout << "Es el valor numero: " << i+1 << "\n";
		}	
		else
		{
			cout << "El valor ingresado no sera tomado en cuenta\n\n\n";
			i=-1;
		}
	}
	
	//PUNTO 17
	float valores;
	int a=0;
	int b=0;
	int c=0;
	int d=0;
	cout << "Punto 17 (Finaliza con el numero 0)\n";
	for(int i=1;i!=0;)
	{
		cout << "Ingrese el sueldo del empleado: ";
		cin >> valores;
		if(valores<=0)
		{
			i = 0;
		}
		else if(valores<1520)
		{
			a++;
		}
		else if(valores>=1520 && valores<2780)
		{
			b++;
		}
		else if(valores>=2780 && valores <5999)
		{
			c++;
		}
		else if(valores>=5999)
		{
			d++;
		}
	}
	cout << a << " empleados ganan menos de $1520\n";
	cout << b << " empleados ganan entre $1520 y $2780\n";
	cout << c << " empleados ganan entre $2780 y $5999\n";
	cout << d << " empleados ganan mas de $5999\n\n\n";
	
	//PUNTO 18
	int M;
	int suma;
	int rep=0;
	cout << "Punto 18\n";
	cout << "Inserte un valor: ";
	cin >> M;
	while(rep<M)
	{
		suma = suma+3;
		if (suma%5!=0)
		{
			cout << suma << "\n";
			rep++;
		}
	} 
	return 0;
}
