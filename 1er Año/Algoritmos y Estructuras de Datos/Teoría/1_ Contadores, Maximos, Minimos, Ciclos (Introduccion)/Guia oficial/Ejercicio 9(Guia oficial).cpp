#include <iostream>
using std::cout;
using std::cin;

int main()
{
int ano, mes;
cout << "Introduzca el año:\n";
cin >> ano;
cout << "Introduzca el mes:\n";
cin >> mes;

switch(mes)
{
case 1: cout << "Enero tiene 31 dias ese año.";
break;
case 2: if(ano%4==0 && ano%100!=0 || ano%400==0)
		{
		cout << "Febrero tiene 29 dias ese año.";	
		}
		else
		{
		cout << "Febrero tiene 28 dias ese año.";	
		}
break;
case 3: cout << "Marzo tiene 31 dias ese año.";
break;
case 4: cout << "Abril tiene 30 dias ese año.";
break;
case 5: cout << "Mayo tiene 31 dias ese año.";
break;
case 6: cout << "Junio tiene 30 dias ese año.";
break;
case 7: cout << "Julio tiene 31 dias ese año.";
break;
case 8: cout << "Agosto tiene 31 dias ese año.";
break;
case 9: cout << "Septiembre tiene 30 dias ese año.";
break;
case 10: cout << "Octubre tiene 31 dias ese año.";
break;
case 11: cout << "Noviembre tiene 30 dias ese año.";
break;
case 12: cout << "Diciembre tiene 31 dias ese año.";
break;
default: cout << "Error, mes inexistente en nuestro calendario.";
break; 	
}	
return 0;	
}
