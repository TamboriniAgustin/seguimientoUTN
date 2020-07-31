#include <iostream>
using namespace std;

int main()
{
	int punto;
	cout << "Ingrese para que punto desea trabajar el programa: 1-2-3-4-5\n";
	cout << "1: 167 valores enteros\n2: N valores, donde N sea leido previamente\n3: Si un valor es igual al anterior, finaliza\n4: Idem (2) y tambien finaliza si los 0 suman 4\n5: Idem(4) y si el promedio de los positivos es mayor a 6, tambien finaliza\n";
	cin >> punto;
	if(punto!=1 && punto!=2 && punto!=3 && punto!=4 && punto!=5)
	{
		for(int i=0;i<=0;i++)
		{
			cout << "ERROR! INGRESE UNO DE LOS PUNTOS INDICADOS: ";
			cin >> punto;
			if(punto<1 || punto>5)
			{
				i=-1;
			}
		}
	}
	int ent;
	int cont0=0;
	float sumaprom=0;
	float divprom=0;
	int sumaneg=0;
	switch(punto)
	{
		case 1:
		{
			for(int i=0;i<167;i++)
			{
				cout << "Inserte el numero entero que desea utilizar: ";
				cin >> ent;
				if(ent==0)
				{
					cont0++;
				}
				if(ent>0)
				{
					sumaprom = sumaprom+ent;
					divprom++;
				}
				if(ent<0)
				{
					sumaneg = sumaneg+ent;
				}
			}
			system("color 0A");
			cout << "La cantidad de 0 ha sido de " << cont0 << "\n";
			cout << "El promedio de los numeros positivos ha sido de " << sumaprom/divprom << "\n";
			cout << "La suma de los numeros negativos ha sido de " << sumaneg << "\n";
			return 0;		
		}
		case 2:
		{
			int N;
			cout << "Introduzca la cantidad de numeros enteros que desea utilizar: ";
			cin >> N;
			for(int i=0;i<N;i++)
			{
				cout << "Inserte el numero entero que desea utilizar: ";
				cin >> ent;
				if(ent==0)
				{
					cont0++;
				}
				if(ent>0)
				{
					sumaprom = sumaprom+ent;
					divprom++;
				}
				if(ent<0)
				{
					sumaneg = sumaneg+ent;
				}
			}
			system("color 0B");
			cout << "La cantidad de 0 ha sido de " << cont0 << "\n";
			cout << "El promedio de los numeros positivos ha sido de " << sumaprom/divprom << "\n";
			cout << "La suma de los numeros negativos ha sido de " << sumaneg << "\n";
			return 0;		
		}
		case 3:
		{
			int pmay;
			int pvez;
			for(int i=0;i>-3;i++)
			{
				pvez++;
				cout << "Inserte el numero entero que desea utilizar: ";
				cin >> ent;
				if(pvez==1)
				{
					pmay = ent;
				}
				if(pvez>1)
				{
					if(ent>pmay || ent<pmay)
					{
						pmay = ent;
					}
					else i=-5;
				}
				if(ent==0)
				{
					cont0++;
				}
				if(ent>0)
				{
					sumaprom = sumaprom+ent;
					divprom++;
				}
				if(ent<0)
				{
					sumaneg = sumaneg+ent;
				}
			}
			system("color 0C");
			cout << "La cantidad de 0 ha sido de " << cont0 << "\n";
			cout << "El promedio de los numeros positivos ha sido de " << sumaprom/divprom << "\n";
			cout << "La suma de los numeros negativos ha sido de " << sumaneg << "\n";
			return 0;
		}
		case 4:
		{
			int N;
			cout << "Introduzca la cantidad de numeros enteros que desea utilizar: ";
			cin >> N;
			for(int i=0;i<N;i++)
			{
				cout << "Inserte el numero entero que desea utilizar: ";
				cin >> ent;
				if(ent==0)
				{
					cont0++;
					if(cont0==4)
					{
						i=N;
					}
				}
				if(ent>0)
				{
					sumaprom = sumaprom+ent;
					divprom++;
				}
				if(ent<0)
				{
					sumaneg = sumaneg+ent;
				}
			}
			system("color 0D");
			cout << "La cantidad de 0 ha sido de " << cont0 << "\n";
			cout << "El promedio de los numeros positivos ha sido de " << sumaprom/divprom << "\n";
			cout << "La suma de los numeros negativos ha sido de " << sumaneg << "\n";
			return 0;		
		}
		case 5:
		{
			int N;
			cout << "Introduzca la cantidad de numeros enteros que desea utilizar: ";
			cin >> N;
			for(int i=0;i<N;i++)
			{
				cout << "Inserte el numero entero que desea utilizar: ";
				cin >> ent;
				if(ent==0)
				{
					cont0++;
					if(cont0==4)
					{
						i=N;
					}
				}
				if(ent>0)
				{
					sumaprom = sumaprom+ent;
					divprom++;
					if(sumaprom/divprom>6)
					{
						i=N;
					}
				}
				if(ent<0)
				{
					sumaneg = sumaneg+ent;
				}
			}
			system("color 0E");
			cout << "La cantidad de 0 ha sido de " << cont0 << "\n";
			cout << "El promedio de los numeros positivos ha sido de " << sumaprom/divprom << "\n";
			cout << "La suma de los numeros negativos ha sido de " << sumaneg << "\n";
			return 0;		
		}		
	}
	return 0;
}
