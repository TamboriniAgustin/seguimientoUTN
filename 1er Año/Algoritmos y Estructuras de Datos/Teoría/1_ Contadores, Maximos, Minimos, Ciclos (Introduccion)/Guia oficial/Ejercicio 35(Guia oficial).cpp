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
	int ent, fact, fin; 
	int com;
	int m3=0;
	int m5=0;
	int m3y5=0;
	while(com==0)
	{
		cout << "Ingrese un valor entero: ";
		cin >> ent;
		fact = factorial(ent);
		cout << "El factorial de este numero es: " << fact << "\n";
		if(ent%3==0) m3++;
		cout << "Cantidad de multiplos de 3 actualmente: " << m3 << "\n";
		if(ent%5==0) m5++;
		cout << "Cantidad de multiplos de 5 actualmente: " << m5 << "\n";
		if(ent%3==0 && ent%5==0) m3y5++;
		cout << "Cantidad de multiplos de 3 y 5 a la vez actualemnte: " << m3y5 << "\n";
		cout << "DESEA CONTINUAR CON OTRO ENTERO?\n0_NO\n1_SI\n";
		cin >> fin;
		if(fin==0) com=1;
	}
	return 0;
}
