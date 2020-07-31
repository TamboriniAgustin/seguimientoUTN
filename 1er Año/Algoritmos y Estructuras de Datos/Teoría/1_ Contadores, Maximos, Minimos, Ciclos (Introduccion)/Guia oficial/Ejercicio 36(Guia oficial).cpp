#include <iostream>
using namespace std;

int simplificacion(int num, int den)
{
	if(den==1) return num/den;
	else
	{
		int b=2;
		while(b<=num)
		{
			if(num%b==0 && den%b==0)
			{
				den=den/b;
				num=num/b;
			}
			else
			{
				b++;
			} 
		}
		return num/den;
	}
}

int main()
{
	int num, den;
	cout << "Ingrese el numerador: ";
	cin >> num;
	cout << "Ingrese el denominador ";
	cin >> den;
	if(num<=0 || den<=0)
	{
		cout << "ERROR! SOLO VALORES NATURALES. INGRESE NUEVAMENTE EL NUMERADOR Y SEGUIDO EL DENOMINADOR\n";
		cin >> num >> den;
	}
	float result = simplificacion(num,den);
	cout << "La simplificacion es: " << result;
	if(result == 0)
	{
		cout << "\nLa fraccion se mantiene igual! NO PUEDE SIMPLIFICARSE";
	}
	return 0;
}
