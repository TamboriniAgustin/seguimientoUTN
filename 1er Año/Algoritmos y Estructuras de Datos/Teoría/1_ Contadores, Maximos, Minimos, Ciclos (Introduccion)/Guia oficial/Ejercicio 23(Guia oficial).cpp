#include <iostream>
using namespace std;

int main()
{
	int rep = 1;
	float valor;
	float pmaxn = -999999999;
	float pminp = 999999999;
	float pinter = 27;
	float sumap = 0; //ACUMULADOR PARA SUMAR EL PROMEDIO DE LOS NUMEROS
	float contador = 0; //CONTADOR PARA LUEGO DIVIDIR POR LA CANTIDAD DE NUMEROS SUMADOS
	while(rep!=0)
	{		
		cout << "Ingrese un valor perteneciente al conjunto distinto de 0.\n";
		cout << "Recuerde que si ingresa el valor 0 el programa terminara.\n";
		cin >> valor;
		sumap = sumap+valor;
		contador++;
		if(valor>pmaxn && valor<0)
		{
			pmaxn = valor;
		}
		if(valor<pminp && valor>0)
		{
			pminp = valor;
		}
		if(valor>=-17.3 && valor<=26.9 && valor<pinter)
		{
			pinter = valor;
		}
		if(valor==0)
		{
			rep = 0;
		}
	}
	if(contador==0)
	{
		cout << "No has ingresado valores, por lo tanto, no es posible realizar nada.";
	}
	else
	{
		cout << "El valor maximo negativo es: " << pmaxn << "\n";
		cout << "El valor minimo positivo es: " << pminp << "\n";
		cout << "El valor minimo dentro del rango de -17.3 y 26.9 es: " << pinter << "\n";
		cout << "El promedio de todos los valores es igual a: " << sumap/contador << "\n";	
	}
	return 0;
}
