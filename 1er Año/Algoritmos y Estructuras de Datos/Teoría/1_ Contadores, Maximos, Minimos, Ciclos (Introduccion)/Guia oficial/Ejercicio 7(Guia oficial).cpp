#include <iostream>
using std::cout;
using std::cin;

int main()
{
int C1, C2, C3;
cout << "Ingresa el valor del cateto 1:\n";
cin >> C1;
cout << "Ingresa el valor del cateto 2:\n";	
cin >> C2;
cout << "Ingresa el valor del cateto 3:\n";	
cin >> C3;

int suma1, suma2, suma3;
suma1 = C1+C2;
suma2 = C1+C3;
suma3 = C2+C3;

if(suma1>C3)
{
cout << "Si forma un triangulo.";	
}
else if (suma1<C3)
{
cout << "No forma un triangulo.";	
}
else if(suma2>C2)
{
cout << "Si forma un triangulo.";	
}
else if (suma2<C2)
{
cout << "No forma un triangulo.";	
}
else if(suma3>C1)
{
cout << "Si forma un triangulo.";	
}
else if (suma3<C1)
{
cout << "No forma un triangulo.";	
}
else if (suma1==suma2==suma3)
{
cout << "No forma un triangulo.";	
}
return 0;
}
