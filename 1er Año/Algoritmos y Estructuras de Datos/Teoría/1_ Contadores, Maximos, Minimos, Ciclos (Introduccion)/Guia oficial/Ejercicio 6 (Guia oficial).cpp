#include <iostream>
using std::cout;
using std::cin;

int main()
{
int ano1, mes1, dia1;

cout << "Seleccione el dia de la primera fecha:\n";
cin >> dia1;
cout << "Seleccione el mes de la primera fecha:\n";
cin >> mes1;
cout << "Seleccione el año de la primera fecha:\n";
cin >> ano1;

int fecha1;
int operacion1;
int operacion2;
int operacion3;
operacion1 = ano1*10000;
operacion2 = mes1*100;
operacion3 = dia1*10;
fecha1 = operacion1 + operacion2 + operacion3;
cout << "La primera fecha establecida es:\t" << fecha1 << "\n";

int ano2, mes2, dia2;

cout << "Seleccione el dia de la segunda fecha:\n";
cin >> dia2;
cout << "Seleccione el mes de la segunda fecha:\n";
cin >> mes2;
cout << "Seleccione el año de la segunda fecha:\n";
cin >> ano2;

int fecha2;
int operacion4, operacion5, operacion6;
operacion4 = ano2*10000;
operacion5 = mes2*100;
operacion6 = dia2*10;
fecha2 = operacion4 + operacion5 + operacion6;
cout << "La segunda fecha establecida es:\t" << fecha2 << "\n";

if(fecha1>fecha2)
{
cout << "Le fecha mas reciente es la fecha 2:\n";
cout << "Dia:\t" << dia2 << "\n";
cout << "Mes:\t" << mes2 << "\n";
cout << "Año:\t" << ano2 << "\n";	
}
else if(fecha1<fecha2)
{
cout << "Le fecha mas reciente es la fecha 1:\n";
cout << "Dia:\t" << dia1 << "\n";
cout << "Mes:\t" << mes1 << "\n";
cout << "Año:\t" << ano1 << "\n";	
}
else if(fecha1==fecha2)
{
cout << "Has introducido la misma fecha!";	
}	
return 0;	
}
