#include <iostream>
using namespace std;

int main()
{
	int rep, vuelo, pasaporte, importe;
	float pasajeros, asientos;
	char destino[50];
	int recaudacion = 0;
	int totalmes = 0;
	int vuelocompleto = 0;
	int seguido = 0;
	int maximo = 0;
	int nrodevuelo = 0;
	cout << "INGRESE LA CANTIDAD DE VUELOS QUE VA A REGISTRAR POR ESTE MES: ";
	cin >> rep;	
	for(int i=1; i<=rep; i++)
	{
		recaudacion = 0;
		nrodevuelo++;
		cout << "Ingrese el numero de vuelo: ";
		cin >> vuelo;
		if(vuelo<1000 || vuelo>9999)
		{
			for(int i=1;i<10;)
			{
				cout << "ERROR! EL VUELO DEBE ESTAR ENTRE 1000 Y 9999\n";
				cin >> vuelo;
				if(vuelo>=1000 && vuelo <=9999)
				{
					i=10;
				}
			}
		}
		cout << "Ingrese el destino del vuelo: ";
		cin >> destino;
		cout << "Cantidad de asientos: ";
		cin >> asientos;
		cout << "Cuantos pasajeros viajaron?: ";
		cin >> pasajeros;
		if(pasajeros>asientos || pasajeros<=0)
		{
			for(int i=1;i<10;)
			{
				cout << "ERROR! LA CANTIDAD DE PASAJEROS NO PUEDE SUPERAR LA CANTIDAD DE ASIENTOS NI PUEDE SER NULA\n";
				cin >> pasajeros;
				if(pasajeros<=asientos && pasajeros>0)
				{
					i=10;
				}
			}
		}
		for(int i=1;i<=pasajeros;i++)
		{
			cout << "Bien! Ahora ingrese el pasaporte del pasajero: ";
			cin >> pasaporte;
			if(pasaporte<10000000 || pasaporte>99999999)
			{
				for(int i=1;i<10;)
				{
					cout << "ERROR! EL PASAPORTE DEBE ESTAR ENTRE 10000000 Y 99999999\n";
					cin >> pasaporte;
					if(pasaporte>=10000000 && vuelo <=99999999)
					{
						i=10;
					}
				}
			}
			cout << "Bien, ahora ingrese cuanto pago el pasajero por el pasaje (USD): ";
			cin >> importe;
			recaudacion = recaudacion+importe;
			totalmes = totalmes+importe;
			cout << "----------------------------------------------------------\nPasaporte: " << pasaporte << "\t Importe en USD: " << importe << "\n----------------------------------------------------------\n";
		}
		cout << "----------------------------------------------------------\nNumero de Vuelo: " << vuelo << "\t Destino: " << destino << "\nTotal recaudado: " << recaudacion << " $\n";
		if(pasajeros==asientos)
		{
			vuelocompleto++;
			if(vuelocompleto>1)
			{
				seguido++;
			}
			cout << "Cantidad de asientos libres: 0%\tCantidad de asientos ocupados: 100%\n----------------------------------------------------------\n";
		}
		if(pasajeros!=asientos)
		{
			vuelocompleto = 0;
			float oper = pasajeros/asientos;
			cout << "Cantidad de asientos libres: " << 100-(oper*100)<< "%\t";
			cout << "Cantidad de asientos ocupados: " << oper*100 << "%\n----------------------------------------------------------\n";
		}
		if(nrodevuelo==1)
		{
			maximo = importe;
			maximo = vuelo;
		}
		if(nrodevuelo>1)
		{
			if(importe>maximo)
			{
				maximo = importe;
				maximo = vuelo;
			}
		}	
	}
	cout << "El total recaudado por los vuelos de este mes fue de " << totalmes << "$\n";
	cout << "Se han llenado " << seguido << " vuelos de forma consecutiva\n";
	cout << "El vuelo que mas dinero recaudo en todo el mes fue el " << maximo << "\n";
	return 0;
}
