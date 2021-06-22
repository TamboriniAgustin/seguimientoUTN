#include <iostream>
#include <conio.h>
#include <stdio.h>
using namespace std;

int main()
{
	int cvocalA=0;
	int cvocalE=0;
	int cvocalI=0;
	int cvocalO=0;
	int cvocalU=0;
	int cpalabra=1;
	int cletras=0;
	int tletras=0;
	char palabra[200];
	cout << "Ingrese su texto (Finaliza con un . -- 200char.): "; gets(palabra);
	for(int i=0;i<=200;i++)
	{
		switch(palabra[i])
		{
			case 'a': 
			{
				cvocalA=cvocalA+1;
				cletras++;
			}
				break;
			case 'A': 
			{
				cvocalA=cvocalA+1;
				cletras++;
			}
				break;
			case 'b': cletras++;
				break;
			case 'B': cletras++;
				break;
			case 'c': cletras++;
				break;
			case 'C': cletras++;
				break;
			case 'd': cletras++;
				break;
			case 'D': cletras++;
				break;					
			case 'e':
			{
				cvocalE=cvocalE+1;
				cletras++;
			}
				break;
			case 'E':
			{
				cvocalE=cvocalE+1;
				cletras++;
			}	
				break;
			case 'f': cletras++;
				break;
			case 'F': cletras++;
				break;
			case 'g': cletras++;
				break;
			case 'G': cletras++;
				break;
			case 'h': cletras++;
				break;
			case 'H': cletras++;
				break;				
			case 'i':
			{
				cvocalI=cvocalI+1;
				cletras++;
			}	
				break;
			case 'I':
			{
				cvocalI=cvocalI+1;
				cletras++;
			}	
				break;
			case 'j': cletras++;
				break;
			case 'J': cletras++;
				break;
			case 'k': cletras++;
				break;
			case 'K': cletras++;
				break;
			case 'l': cletras++;
				break;
			case 'L': cletras++;
				break;
			case 'm': cletras++;
				break;
			case 'M': cletras++;
				break;
			case 'n': cletras++;
				break;
			case 'N': cletras++;
				break;
			case 'ñ': cletras++;
				break;
			case 'Ñ': cletras++;
				break;						
			case 'o':
			{
				cvocalO=cvocalO+1;
				cletras++;
			}	
				break;
			case 'O':
			{
				cvocalO=cvocalO+1;
				cletras++;
			}	
				break;
			case 'p': cletras++;
				break;
			case 'P': cletras++;
				break;
			case 'q': cletras++;
				break;
			case 'Q': cletras++;
				break;
			case 'r': cletras++;
				break;
			case 'R': cletras++;
				break;
			case 's': cletras++;
				break;
			case 'S': cletras++;
				break;	
			case 't': cletras++;
				break;
			case 'T': cletras++;
				break;			
			case 'u':
			{
				cvocalU=cvocalU+1;
				cletras++;
			}
				break;
			case 'U': 
			{
				cvocalU=cvocalU+1;
				cletras++;	
			}
				break;
			case 'x': cletras++;
				break;
			case 'X': cletras++;
				break;
			case 'y': cletras++;
				break;
			case 'Y': cletras++;
				break;
			case 'z': cletras++;
				break;
			case 'Z': cletras++;
				break;			
			case ' ': 
			{
				cpalabra++;
				cletras=0;
			}
				break;
			case '.': i=200;
				break;												
		}
		if(cpalabra==1)
		{
			tletras=cletras;
		}
		if(cpalabra>1)
		{
			if(cletras>tletras) tletras=cletras;
		}
	}
	cout << "-----------------------------------------------------\nLa vocal A aparecio " << cvocalA << " veces.\n";
	cout << "La vocal E aparecio " << cvocalE << " veces.\n";
	cout << "La vocal I aparecio " << cvocalI << " veces.\n";
	cout << "La vocal O aparecio " << cvocalO << " veces.\n";
	cout << "La vocal U aparecio " << cvocalU << " veces.\n-----------------------------------------------------\n";
	cout << "La oracion posee una cantidad de " << cpalabra << " palabras.\n";
	cout << "La palabra con mas larga tuvo: " << tletras << " letras.\n-----------------------------------------------------\n";
	return 0;
}
