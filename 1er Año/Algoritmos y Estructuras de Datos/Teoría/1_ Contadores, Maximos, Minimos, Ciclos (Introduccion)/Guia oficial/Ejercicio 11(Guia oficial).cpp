#include <iostream>
using std::cout;
using std::cin;

int main()
{
int edad;
cout << "Ingresa tu edad:\n";
cin >> edad;

if(edad<=12)
{
cout << "Eres un menor.";	
}	
else if(edad>12 & edad<=18)
{
cout << "Eres un cadete.";	
}
else if(edad>18 & edad<=26)
{
cout << "Eres un juvenil.";	
}
else
{
cout << "Eres mayor.";	
}
return 0;	
}
