#include <iostream>
using namespace std;

int main()
{
	float valores;
	int rep = 1;
	int a=0;
	int b=0;
	int c=0;
	int d=0;
	cout << "PARA DETENER EL PROGRAMA INGRESE 0.\n";
	while(rep!=0)
	{
		cout << "Ingrese el sueldo del empleado: ";
		cin >> valores;
		if(valores==0)
		{
			rep = 0;
		}
		if(valores<1520)
		{
			a++;
		}
		if(valores>=1520 && valores<2780)
		{
			b++;
		}
		if(valores>=2780 && valores <5999)
		{
			c++;
		}
		if(valores>=5999)
		{
			d++;
		}
	}
	cout << a-1 << " empleados ganan menos de $1520\n";
	cout << b << " empleados ganan entre $1520 y $2780\n";
	cout << c << " empleados ganan entre $2780 y $5999\n";
	cout << d << " empleados ganan mas de $5999";
	return 0;
}
