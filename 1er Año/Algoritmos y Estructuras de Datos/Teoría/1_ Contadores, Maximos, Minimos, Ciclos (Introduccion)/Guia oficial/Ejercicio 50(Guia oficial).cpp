#include <iostream>
#include<stdlib.h>
using namespace std;

float Hora(int hr,int min) //PUNTO A
{
	hr = 60*hr;
	float oper = hr+min;
	return oper;
}

float Servicio(float costo,float mfree,float exced,float min) //PUNTO B
{
	if(min<=mfree) 
	{
		return costo;
	}
	float sobr=min-mfree;
	if(min>mfree) 
	{
		cout << "Minutos libres: " << mfree << "---\t";
		cout << "El cliente excedio " << sobr << " minutos\n";
	}
	float oper=costo+(exced*sobr);
	float iva = (oper*21)/100; 
	return oper+iva;
}

int MExcedentes(int mfree, int min) //EXTRA PUNTO B
{
	int sobr=min-mfree;
	if(min<=mfree) 
	{
		return 0;
	}
	if(min>mfree) 
	{
		return sobr;
	}	
}

int main()
{
	int c=1;
	int p=0;
	int nro, hr, min, exceso;
	//----FACTURA MAS CARA----//
	float FMC=0;
	string nombreFMC, apellidoFMC;
	//------------------------//
	//----MAYOR CANTIDAD DE M. EXCEDIDOS----//
	int ME=0;
	int nroME=0;
	string nombreME, apellidoME;
	//--------------------------------------//
	//MONTO TOTAL//
	float totalrecaudado = 0;
	//----------//
	//MENOR CANTIDAD DE MINUTOS EN EL MES//
	int turno=0;
	string nombreturno;
	int orden=0;
	int gorden=0;
	int gexceso=0;
	//-----------------------------------//
	string nombre, apellido, direccion;
	char tipo;
	for(int i=1;i<=3;i++)
	{
		FMC=0;
		ME=0;
		orden=0;
		cout << "--------------------------------------------\n";
		if(i==1) cout << "Turno Mañana\n";
		else if(i==2) cout << "Turno Tarde\n";
		else if(i==3) cout << "Turno Noche\n";
		cout << "--------------------------------------------\n\n\n";
		cout << "Ingrese el numero telefonico del cliente (Ingrese 0 si desea pasar de turno): ";
		cin >> nro;
		while(c!=0 && nro!=0)
		{
			p=0;
			if(nro==0) c=0;
			if(nro!=0 && nro<100000000 || nro!=0 && nro>999999999)
			{
				for(int i=1;i<10;)
				{
					cout << "ERROR! EL NUMERO DEBE CONTENER 9 DIGITOS.\n";
					cin	>> nro;
					if(nro>=100000000 && nro <=999999999)
					{
						i=10;
					}
				}
			}
			while(nro!=0 && p>=0)
			{
				cout << "Ingrese el nombre del abonado al que corresponde el telefono (nombre y separado el apellido): ";
				cin >> nombre >> apellido;
				cout << "Ingrese la direccion donde vive(sin espacios): ";
				cin >> direccion;
				cout << "Ingrese la cantidad de horas que ha utilizado el servicio durante el mes (Formato HHMM)\nIngrese las horas y los minutos separados por espacio: ";
				cin >> hr >> min;
				if(hr<0 || min<0)
				{
					for(int i=1;i<10;)
					{
						cout << "Error de digitos, represente el tiempo en HHMM (Horas-Minutos)\nIngrese las horas y los minutos separados por espacio\n";
						cin >> hr >> min;
						if(hr>=0 && min>=0)
						{
							i=10;
						}
					}
				}
				cout << "Ingrese el tipo de abono que posee el usuario (A,B,C,D,E): ";
				cin >> tipo;
				if(tipo!='A' && tipo!='B' && tipo!='C' && tipo!='D' && tipo!='E')
				{
					for(int i=1;i<10;)
					{
						cout << "Error de digitos, ingrese uno de los valores indicados: ";
						cin >> tipo;
						if(tipo=='A' || tipo=='B' || tipo=='C' || tipo=='D' || tipo=='E')
						{
							i=10;
						}
					}
				}
				float costo= 0;
				float lmin = 0;
				float cext = 0;
				if(tipo=='A')
				{
					costo = 70;
					lmin = 300;
					cext = 0.09;
				}
				else if(tipo=='B')
				{
					costo = 55;
					lmin = 200;
					cext = 0.15;
				}
				else if(tipo=='C')
				{
					costo = 40;
					lmin = 100;
					cext = 0.09;
				}
				else if(tipo=='D')
				{
					costo = 28;
					lmin = 60;
					cext = 0.29;
				}
				else if(tipo=='E')
				{
					costo = 19;
					lmin = 40;
					cext = 0.37;
				}
				cout << "--------------------------------------------\nNombre del abonado: " << nombre << " " << apellido << "\tDireccion: " << direccion << "\n";
				exceso = Hora(hr,min);
				float montot = Servicio(costo,lmin,cext,exceso);
				cout << "Monto total a pagar: " << montot << "$\n--------------------------------------------\n\n\n";
				totalrecaudado = totalrecaudado+montot;
				if(montot>=FMC)
				{
					FMC = montot;
					nombreFMC = nombre;
					apellidoFMC = apellido;
				}
				int texcedido = MExcedentes(lmin,exceso);
				if(texcedido>=ME)
				{
					ME = texcedido;
					nroME = nro;
					nombreME = nombre;
					apellidoME = apellido;
				}
				p=-1;
			}
			orden++;
			if(orden==1 && i==1)
			{
				gorden = 1;
				turno = i;
				gexceso = exceso;
			}
			else if(orden>1)
			{
				if(exceso<gexceso)
				{
					gexceso = exceso;
					turno = i;
					gorden = orden;
				}
			}
			cout << "Ingrese el numero telefonico del cliente: ";
			cin >> nro;
		}
		cout << "--------------------------------------------\n";
		if(i==1)
		{
			cout << "La factura mas cara pagada fue de: " << FMC << "$-----Usuario: " << apellidoFMC << ", " << nombreFMC << "\n\n";
			cout << "El mayor exceso al limite de minutos libres fue de " << ME << " minutos del telefono: " << nroME << "-----Usuario: " << apellidoME << ", " << nombreME << "\n";
		}
		else if(i==2)
		{
			cout << "La factura mas cara pagada fue de: " << FMC << "$-----Usuario: " << apellidoFMC << ", " << nombreFMC << "\n\n";
			cout << "El mayor exceso al limite de minutos libres fue de " << ME << " minutos del telefono: " << nroME << "-----Usuario: " << apellidoME << ", " << nombreME << "\n";
		}
		else if(i==3)
		{
			cout << "La factura mas cara pagada fue de: " << FMC << "$-----Usuario: " << apellidoFMC << ", " << nombreFMC << "\n\n";
			cout << "El mayor exceso al limite de minutos libres fue de " << ME << " minutos del telefono: " << nroME << "-----Usuario: " << apellidoME << ", " << nombreME << "\n";
		}
		cout << "--------------------------------------------\n\n\n";
	}
	cout << "--------------------------------------------\n";
	cout << "El total recaudado en los 3 turnos fue de: " << totalrecaudado << "$\n\n";
	if(turno==1) cout << "El usuario que menos minutos utilizo se encuentra en el orden: " << gorden << " del turno MAÑANA\n";
	else if(turno==2) cout << "El usuario que menos minutos utilizo se encuentra en el orden: " << gorden << " del turno TARDE\n";
	else if(turno==3)cout << "El usuario que menos minutos utilizo se encuentra en el orden: " << gorden << " del turno NOCHE\n";
	cout << "--------------------------------------------\n\n\n";					
	return 0;
}
