#include <iostream>
using std::cout;
using std::cin;

int main()
{
int ano;
int mes;
int dia;

cout<< "Introduce el año:\n";
cin >> ano;
cout << "Introduce el mes:\n";
cin >> mes;
cout << "Introduce el dia:\n";
cin >> dia;

int operacion1;
operacion1 = ano*10000;
int operacion2;
operacion2 = mes*100;
int operacion3;
operacion3 = dia*1;

cout << "Todo junto es igual a:\n";
cout << operacion1 + operacion2 + operacion3;
	
return 0;	
}
