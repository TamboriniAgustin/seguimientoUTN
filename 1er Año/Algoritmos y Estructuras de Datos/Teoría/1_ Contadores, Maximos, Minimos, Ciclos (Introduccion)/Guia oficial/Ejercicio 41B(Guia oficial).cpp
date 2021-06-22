#include <iostream>
using namespace std;

int main()
{
	int dia, mes, year; 
	char sex;
	dia = 1;
	int mesO = 0;
	int operacion[3];
	int ymV = 0;
	int prim = 0;
	int nper = 0;
	int mayor = 0;
	cout << "Para finalizar el programa, ingrese dia de nacimiento = 'Parar'\n-----------------------------\n";
	while(dia!=0)
	{
		cout << "Ingrese el dia de nacimiento del ciudadano: ";
		cin >> dia;
		cout << "Ahora ingrese el mes en que nacio: ";
		cin >> mes;
		cout << "Ahora ingrese el año: ";
		cin >> year;
		cout << "Por ultimo, se pide indicar el sexo de la persona. 'H'= Hombre || 'M'= Mujer: ";
		cin >> sex;
		if(sex!='H' && sex!='h' && sex!='M' && sex!='m')
		{
			cout << "INGRESE EL SEXO INDICADO!: ";
			cin >> sex;
		}
		if(mes<1 && mes>12)
		{
			cout << "NO EXISTE ESE MES, INGRESE UNO ENTRE 1 Y 12!\n";
			cin >> mes;
		}
		if(year<0)
		{
			cout << "ESTE PROGRAMA SOLO TRABAJA CON AÑOS DEL 0 EN ADELANTE!\n";
			cin >> year;
		}
		if(mes==1 && dia>31 && dia<1)
		{
			cout << "ESTE MES SOLO TIENE 31 DIAS!\n";
			cin >> dia;
		}
		if(mes==2)
		{
			if(year%4==0 && year%100!=0 || year%400==0)
			{
				if(dia<1 && dia>29)
				{
					cout << "ESTE MES TIENE 29 DIAS ESTE AÑO.\n";
					cin >> dia;
				}
				else
				{
					cout << "ESTE MES TIENE 28 DIAS ESTE AÑO.\n";
					cin >> dia;
				}	
			}
		}
		if(mes==3 && dia>31 && dia<1)
		{
			cout << "ESTE MES SOLO TIENE 31 DIAS!\n";
			cin >> dia;
		}
		if(mes==4 && dia>30 && dia<1)
		{
			cout << "ESTE MES SOLO TIENE 30 DIAS!\n";
			cin >> dia;
		}
		if(mes==5 && dia>31 && dia<1)
		{
			cout << "ESTE MES SOLO TIENE 31 DIAS!\n";
			cin >> dia;
		}
		if(mes==6 && dia>30 && dia<1)
		{
			cout << "ESTE MES SOLO TIENE 30 DIAS!\n";
			cin >> dia;
		}
		if(mes==7 && dia>31 && dia<1)
		{
			cout << "ESTE MES SOLO TIENE 31 DIAS!\n";
			cin >> dia;
		}
		if(mes==8 && dia>31 && dia<1)
		{
			cout << "ESTE MES SOLO TIENE 31 DIAS!\n";
			cin >> dia;
		}
		if(mes==9 && dia>30 && dia<1)
		{
			cout << "ESTE MES SOLO TIENE 30 DIAS!\n";
			cin >> dia;
		}
		if(mes==10 && dia>31 && dia<1)
		{
			cout << "ESTE MES SOLO TIENE 31 DIAS!\n";
			cin >> dia;
		}
		if(mes==11 && dia>30 && dia<1)
		{
			cout << "ESTE MES SOLO TIENE 30 DIAS!\n";
			cin >> dia;
		}
		if(mes==12 && dia>31 && dia<1)
		{
			cout << "ESTE MES SOLO TIENE 31 DIAS!\n";
			cin >> dia;
		}
		if(mes==10)
		{
			mesO++;	
		}
		operacion[1] = year*10000;
		operacion[2] = mes*100;
		operacion[3] = dia*1;
		int ototal = operacion[1] + operacion[2] + operacion[3];
		cout << "Los datos indicados sera representada como: " << ototal << " \n";
		if(ototal<19900709 && ototal!=0)
		{
			ymV++;
		}
		if(ototal>=19820921 && ototal<19821221)
		{
			prim++;
		}
		nper++;
		if(nper==1)
		{
			ototal = mayor;
			mayor = sex;
		}
		if(ototal>mayor && ototal!=0)
		{
			ototal = mayor;
			mayor = sex;
		}
	}
	cout << "-----------------------------------------------------\n";
	cout << "El total de nacimientos en el mes de Octubre fue de: " << mesO << " personas\n";
	cout << "El total de nacimientos antes del 9 de Julio de 1990 fue de : " << ymV-1 << " personas\n";
	cout << "El total de nacimientos durante la primavera de 1982 fue de : " << prim << " personas\n";
	cout << "La persona de mayor edad es de sexo: " << sex << "\n";
	cout << "El total de personas censadas fue de: " << nper-1 << "\n";
	cout << "-----------------------------------------------------\n";
	return 0;
}
