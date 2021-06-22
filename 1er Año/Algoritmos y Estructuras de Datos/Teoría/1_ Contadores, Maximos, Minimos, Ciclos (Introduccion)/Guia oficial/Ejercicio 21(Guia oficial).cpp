#include <iostream>
using namespace std;

int main()
{
	char conj;
	cout << "Seleccione en que conjunto desea trabajar:\nNegativos=N (< 0)\nPositivos=P(>= 0)\n";
	cin >> conj;
	if(conj=='P' || conj== 'p') //PARA LOS NUMEROS MAYORES O IGUALES QUE 0
	{	
		int N;
		int max, min;
		max = 0;
		min = 0;
		int pmax, pmin;
		pmax = 0;
		pmin = 0;
	
		for(int i=-1; i<=N; i++)
		{
			cout << "Ingrese el valor deseado: ";
			cin >> N;
			if(i==-1)
			{
				max = N;
				min = N;
				pmax = i+2;
				pmin = i+2;
			}
			else if(N>max)
			{
				max = N;
				pmax = i+2;
			}
			else if(N<min)
			{
				min = N;
				pmin = i+2;
			}
		}
		cout << "El maximo es: " << max << "\n";
		cout << "El minimo es: " << min << "\n";
		cout << "La posicion maxima es: " << pmax << "\n";
		cout << "El posicion minima es: " << pmin << "\n";
		return 0;
	}
	else if(conj=='N' || conj== 'n') //PARA LOS NUMEROS MENORES A 0
	{
		int N;
		int max, min;
		max = 0;
		min = 0;
		int pmax, pmin;
		pmax = 0;
		pmin = 0;
	
		for(int i=0; i>=N; i--)
		{
			cout << "Ingrese el valor deseado: ";
			cin >> N;
			if(i==0)
			{
				max = N;
				min = N;
				pmax = i+1;
				pmin = i+1;
			}
			else if(N>max)
			{
				max = N;
				pmax = (i*-1)+1;
			}
			else if(N<min)
			{
				min = N;
				pmin = (i*-1)+1;
			}
		}
		cout << "El maximo es: " << max << "\n";
		cout << "El minimo es: " << min << "\n";
		cout << "La posicion maxima es: " << pmax << "\n";
		cout << "El posicion minima es: " << pmin << "\n";
		return 0;		
	}
	else
	{
		cout << "ERROR, EL CONJUNTO SELECCIONADO NO EXISTE\nINGRESE UNO DE LOS VALORES INDICADOS:\n";	
	}	
}
