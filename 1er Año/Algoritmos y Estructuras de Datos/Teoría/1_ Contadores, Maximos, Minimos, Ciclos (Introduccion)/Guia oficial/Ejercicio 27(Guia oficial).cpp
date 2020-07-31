#include <iostream>
using namespace std;

int main()
{
	int contador = 0;
	char resultado, nequipo[150];
	while(contador>=0)
	{
		int victorias = 0;
		int empates = 0;
		cout << "Introduzca el nombre de su equipo (todo junto): ";
		cin >> nequipo;
		contador++;
		cout << "El numero de identificacion de tu equipo es: " << contador << "\n";
		int partidos;
		cout << "----------Cuantos partidos ha jugado su equipo?----------\n";
		cin >> partidos;
		int cont2=0;
		for(int b=0;b<partidos;b++)
		{
			cont2++;
			cout << "Ahora introduzca el resultado del partido " << cont2 << ":\n";
			cout << "Si ha ganado introduzca [G]\nSi ha perdido introduzca [P]\nSi ha empatado introduzca [E]\n";
			cin >> resultado;
			if(resultado!='g' && resultado!='G' && resultado !='p' && resultado !='P' && resultado!='e' && resultado!='E')
			{
				cout << "ERROR, ESTE RESULTADO NO ES VALIDO\n";
				cout << "Ingrese los valores indicados.(G,E,P)\n";
				cin >> resultado;
			}
			if(resultado=='g' || resultado=='G')
			{
				victorias = victorias+3;
			}
			if(resultado=='e' || resultado=='E')
			{
				empates = empates+1;
			}
		}
		cout << "---------------------------------------------\nEl equipo " << nequipo << " ha sumado " << victorias+empates << " puntos.\n---------------------------------------------\n"; 
	}
	return 0;
}
