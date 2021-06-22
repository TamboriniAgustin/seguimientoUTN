#include <iostream>
using std::cout;
using std::cin;

int main()
{
int L1,L2,L3;
cout << "Introduzca el cateto 1:\n";
cin >> L1;
cout << "Introduzca el cateto 2:\n";
cin >> L2;
cout << "Introduzca el cateto 3:\n";
cin >> L3;

if(L1==L2 & L1==L3 & L2==L3)
{
cout << "El triangulo formado es EQUILATERO.";	
}
else if(L1==L2 & L1!=L3 & L2!=L3)
{
cout << "El triangulo formado es ISOCELES.";	
}
else if(L1!=L2 & L1==L3 & L2!=L3)
{
cout << "El triangulo formado es ISOCELES.";	
}
else if(L1!=L2 & L1!=L3 & L2==L3)
{
cout << "El triangulo formado es ISOCELES.";	
}
else if(L1!=L2 & L1!=L3 & L2!=L3)
{
cout << "El triangulo formado es ESCALENO.";	
}
return 0;
}
