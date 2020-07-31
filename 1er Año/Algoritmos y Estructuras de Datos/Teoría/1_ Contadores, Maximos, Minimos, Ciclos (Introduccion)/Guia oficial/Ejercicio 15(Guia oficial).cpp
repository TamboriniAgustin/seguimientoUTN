#include <iostream>
using namespace std;

int main()
{
int infraccion = 0;	
int tipo; 
int valor;
valor = 0;
char gravedad;
char motivo[140];
int resultado;

while(infraccion<=20)
{
infraccion++; 
cout << "Seleccione el tipo de infraccion (1,2,3,4):\n";
cin >> tipo;

switch(tipo)
{
  case 1: 
  {
  	cout << "El valor de una multa tipo 1 es de $100\n";
	valor=100;
  }
  break;
  case 2: 
  {
  	cout << "El valor de una multa tipo 2 es de $200\n";
	valor=200;
  }
  break;
  case 3:
  {
  	cout << "El valor de una multa tipo 3 es de $300\n";
	valor=300;
  }	
  break;
  case 4:
  {
  	cout << "El valor de una multa tipo 4 es de $400\n";
	valor=400;
  }	
  break;
     default:
	 { 
	 cout << "Esta infraccion no existe.\n";
	 cout << "Ingrese el valor indicado. (1,2,3,4)\n";
	 cin >> tipo; 
	}
}

cout << "Seleccione el motivo de la infraccion:\n";
cin >> motivo;

cout << "Ingrese la gravedad de la infraccion(l,m,g):\n";
cin >> gravedad;

if(gravedad!='l' && gravedad!='m' && gravedad!='g')
{
	cout << "ERROR: LA GRAVEDAD SELECCIONADA NO EXISTE.\n";
	cout << "Ingrese los valores indicados.(l,m,g)\n";
	cin >> gravedad;	
}

else if(tipo>=3 && gravedad=='g')
{
	cout << "La fabrica esta clausarada.\n";
	cout << "Tendras que pagar una multa de un valor de\t" << valor*5000 << "\t para reabrir la fabrica.\n";
}
else if (gravedad=='l')
{
	cout << "La multa a pagar es de:\t" << valor*10 << "\n";
}
else if (gravedad=='m')
{
	cout << "La multa a pagar es de:\t" << valor*100 << "\n";
}
else if (gravedad=='g')
{
	cout << "La multa a pagar es de:\t" << valor*1000 << "\n";
}
}
return 0;	
}
