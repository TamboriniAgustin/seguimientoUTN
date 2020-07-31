#include <iostream>
using namespace std;

float CalcularPorcentajeDiferencia(int a, int b)
{
	float c1 = (b-a)*100;
	return c1/(a+b);
}

int main()
{
	float n1, n2;
	cout << "Ingrese el primer valor: ";
	cin >> n1;
	cout << "Ingrese el segundo valor: ";
	cin >> n2;
	float resultado;
	resultado = CalcularPorcentajeDiferencia(n1,n2);
	cout << "El porcentaje de la diferencia de los valores es: " << resultado;
	return 0;
}
