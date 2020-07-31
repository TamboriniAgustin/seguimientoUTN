#include <iostream>

using std::cout;
using std::cin;

int main()
{
int numero1;
int numero2;

cout << "Introduzca el Valor 1:\n";
cin >> numero1;
cout << "Introduzca el Valor 2:\n";
cin >> numero2;

int suma, resta, multiplicacion;
suma = numero1+numero2;
resta = numero1-numero2;
multiplicacion = numero1*numero2;

int operacion;
cout << "Introduzca la operacion que desea realizar:\n";
cout << "Suma = 1\n";
cout << "Resta = 2\n";
cout << "Multiplicacion = 3\n";
cin >> operacion;

if(operacion==1)
{
cout << "La respuesta es:\t" << suma;	
}
else if(operacion==2)
{
cout << "La respuesta es:\t" << resta;		
}	
else if(operacion==3)
{
cout << "La respuesta es:\t" << multiplicacion;		
}
else if(operacion==!3 & operacion==!2 & operacion==!1)
{
cout << "ERROR DE VARIABLE";	
}
return 0;	
}
