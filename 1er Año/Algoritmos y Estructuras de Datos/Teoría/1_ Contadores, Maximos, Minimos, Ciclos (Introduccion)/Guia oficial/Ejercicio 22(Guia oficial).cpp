#include <iostream>
using namespace std;

int main()
{
	int stop;
	int pmay = 0;
	int pmen = 0;
	int rep = 1;
	char persona[15];
	int nacimiento;
	int pp = 0;
	cout << "PARA FINALIZAR EL PROGRAMA INGRESE '0' en Nombre\n";
	while(rep!=0)
	{
		pp++;
		cout << "Ingrese el nombre de la persona: ";
		cin >> persona;
		cout << "Ingrese la edad de la persona (Formato: AAAAMMDD): ";
		cin >> nacimiento;
		if(nacimiento<111 || nacimiento>99999999)
		{
			cout << "INGRESA LA EDAD EN EL FORMATO ESTABLECIDO!\n";
			cin >> nacimiento;
		}
		if(pp==1)
		{
			pmay = nacimiento;
			pmen = nacimiento;
		}
		else
		{
			if(pmay<nacimiento)
			{
				pmay = nacimiento;
				pmay = persona[15];
				cout << "Ahora " << persona << " es el mas viejo de todos!";
			}
			if(pmen>nacimiento)
			{
				pmen = nacimiento;
				pmen = persona[15];
				cout << "Ahora " << persona << " es el mas joven de todos!";
			}
		}
		cout << "Desea continuar?\n SI=1\n NO=0\n";
		cin >> stop;
		if(stop==0)
		{
			rep--;
		}
	}
	return 0;
}
