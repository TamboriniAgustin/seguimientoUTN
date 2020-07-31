#include <iostream>
using namespace std;

string Tendencia(int A, int B)
{
	int resta = B-A;
	float porc5A = 0.05*A;
	float porc2A = 0.02*A;
	if(resta<0) return "Decreciente";
	else if(resta<porc5A && resta>=porc2A) return "Leve Ascenso";
	else if(resta<porc2A && resta >= 0) return "Estable";
	else return "En ascenso";
}

int main()
{
	int a,b;
	cout << "Ingrese 2 valores A y B: ";
	cin >> a >> b;
	string resp = Tendencia(a,b);
	cout << "La tendencia de ambos valores es: " << resp << "\n";
	return 0;
}
