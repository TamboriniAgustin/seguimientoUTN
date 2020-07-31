#include <iostream>
using std::cout;
using std::cin;

int main()
{
int entero;
cout<< "Introduzca un numero entero:\n";
cin >> entero;

int puntoA, puntoB, puntoC;
puntoA = entero/5;
puntoB = entero-(puntoA*5);
puntoC = puntoA/7;

cout << "La 5ta parte es:\t" <<	puntoA << "\n";
cout << "El resto es:\t" <<	puntoB << "\n";
cout << "La 7ma parte del resultado del punto A es:\t" <<	puntoC << "\n";

return 0;	
}
