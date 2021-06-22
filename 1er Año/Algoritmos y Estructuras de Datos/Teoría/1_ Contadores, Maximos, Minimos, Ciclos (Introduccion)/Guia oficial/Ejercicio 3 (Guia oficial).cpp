#include <iostream>
using std::cout;
using std::cin;

int main()
{
int numero;
cout << "Introduzca su numero en formato (AAAAMMDD):\n";
cin >> numero;

int ano;
ano = numero/10000;
int mes;
mes = (numero/100)-(ano*100);
int dia;
dia = numero-(ano*10000)-(mes*100);
 	
cout << "El dia es:\t" << dia << "\n";
cout << "El mes es:\t" << mes << "\n"; 
cout << "El año es:\t" << ano << "\n"; 
	
return 0;	
}
