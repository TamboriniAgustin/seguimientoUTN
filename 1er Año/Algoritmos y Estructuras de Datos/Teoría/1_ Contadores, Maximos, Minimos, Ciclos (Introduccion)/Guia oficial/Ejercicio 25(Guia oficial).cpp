#include <iostream>
using namespace std;

int main()
{
	int M;
	char color;
	int rep = 1;
	int acum0 = 0; //A
	int nroant = 0;
	int nroant0 = 0;
	int acumN = 0; //B
	int Nseg = 0;
	int Nseg1 = 0;
	int mnro = 0; //C
	int mnroseg = 0;
	int acumnro = 0;
	int acumnro1 = -1;
	int RD = 0; //D
	int ND = 0;
	int RyN = 0;
	int RyNseg = 0;
	int mayor = 0;
	int docena = 0;//E
	int mayorE = 0;
	int docenaseg = 0;
	while(rep!=0)
	{
		cout << "Ingrese el color al que desea apostarle:\n";
		cin >> color;
		if(color!='n' && color!='N' && color!='r' && color!='R')
		{
			for(int i=1;i<10;)
			{
				cout << "ERROR! LOS COLORES SOLO PUEDEN SER NEGRO (N) O ROJO (R).\n";
				cin >> color;
				if(color=='n' || color=='N' || color=='R' || color=='r') i=10;
			}
		}
		if(color=='n' || color=='N')
		{
			acumN++;
			Nseg++;
			ND++;
			if(Nseg>=2)
			{
				Nseg1++;
				RyNseg = 0;
			}
		}
		else 
		{
			Nseg = 0;
		}
		if(color=='r' || color=='R')
		{
			RD++;
			if(RD==2)
			{
				RyNseg = 0;
			}
		}
		if(RD==ND)
		{
			RyN++;
			if(RyN==1)
			{
				RyNseg++;
				mayor = 1;
				if(RyNseg>1)
				{
					if(RyNseg>mayor) mayor = RyNseg;
				}
			}
		}
		else RyN = 0;
		cout << "Ingrese el numero al que desea apostarle:\n";
		cin >> M;
		if(M<0 || M>36)
		{
			for(int i=1;i<10;)
			{
				cout << "ERROR! EL NUMERO PUEDE IR DE 0 A 36.\n";
				cin >> M;
				if(M>=0 && M<=36) i=10;
			}
		}
		if(M<13 || M>24)
		{
			docena++;
			if(docena==2)
			{
				docena = 0;
				docenaseg++;
				mayorE = 1;
				if(docenaseg>1)
				{
					if(docenaseg>mayorE)
					{
						mayorE = docenaseg;
					}
				}
			}
		}
		else docenaseg = 0;
		if(acumnro1==M)
		{
			mnro++;
			if(mnro>=1)
			{
				mnroseg++;
				acumnro = M;
				cout << "El numero " << acumnro << " se ha repetido " << mnroseg << " veces seguidas.\n"; //PUNTO C
			}
		}
		else if(acumnro1!=M)
		{
			mnro=0;
			mnroseg=0;	
		}
		acumnro1 = M;
		if(M==0)
		{
			acum0++;
			nroant0 = nroant;
		}
		int fin;
		cout << "Desea continuar apostando?\n1_SI\n0_NO\n";
		cin >> fin;
		if(fin==0) 
		{
			rep = 0;
		}
		else if (fin!=1 && fin!=0)
		{
			cout << "Ingrese uno de los valores indicados!\n";
			cin >> fin;
		}
		nroant = M;	
		cout << "La cantidad de numeros 0 que han salido: " << acum0 << " y su numero anterior fue el " << nroant0 << "\n"; //PUNTO A
	}
	cout << "La cantidad de colores negro consecutivos han sido: " << Nseg1 << "\n"; //PUNTO B
	cout << "La mayor cantidad de veces que salieron alternados el negro y el rojo fue de " << mayor << "\n"; //PUNTO C
	cout << "La mayor cantidad de veces que se nego la 2da docena fue de " << mayorE << "\n"; //PUNTO E
	return 0;
}
