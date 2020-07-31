#include <iostream>
#include <cstdlib>

using std::cout;
using std::cin;

int main()
{
int numero1;
int numero2;

cout << "Introduzca el valor 1:\n";
cin >> numero1;

cout << "Introduzca el valor 2:\n";
cin >> numero2;

if(numero1>numero2)
{
cout << "El valor\t" << numero1 << "\tes mayor que el valor\t" << numero2 << "\n";	
}
else if(numero1<numero2)
{
cout << "El valor\t" << numero1 << "\tes menor que el valor\t" << numero2 << "\n";	
}
else if(numero1==numero2)
{
cout << "El valor\t" << numero1 << "\tes igual al valor\t" << numero2 << "\n";	
}
system("PAUSE");
return 0;	
}
