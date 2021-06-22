#include <iostream>
using namespace std;

int main()
{
	int ent;
	int lote = 0;
	int lotemax = 0;
	float sumap = 0;
	float divp = 0;
	int pmin = 0;
	int pmax = 0;
	int pmaxT = 0;
	int posMax = 0;
	cout << "Ingrese un valor de tipo entero: ";
	cin >> ent;
	while(ent>=0)
	{
		sumap = sumap+ent;
		divp++;
		pmin = ent;
		pmax = ent;
		int contpos = 0;
		while(ent>0)
		{
			cout << "Ingrese un valor de tipo entero: ";
			cin >> ent;
			contpos++;
			sumap = sumap+ent;
			if(ent!=0)
			{
				divp++;	
			}
			if(ent<pmin && ent!=0)
			{
				pmin = ent;
			}
			if(ent>pmax)
			{
				pmax=ent;
			}
		}
		float prom = sumap/divp;
		cout << "El promedio de los valores del sublote es: " << prom << "\n"; //PUNTO A
		cout << "El valor minimo del sublote es: " << pmin << "\n"; //PUNTO D
		if(ent>=0)
		{
			sumap = 0;
			divp = 0;
			lote++;
			cout << "Finalizo el sublote " << lote << ", ingrese otro valor: ";
			cin >> ent;
			if(lote==1) 
			{
				pmaxT = pmax;
				lotemax = 1;
				posMax = contpos;
			}
			if(lote>1)
			{
				if(pmax > pmaxT)
				{
					pmaxT = pmax;
					lotemax = lote;
					posMax = contpos;
				}
			}
		}
		else if(ent<0)
		{
			sumap = 0;
			divp = 0;
			lote++;
			if(lote==1) 
			{
				pmaxT = pmax;
				lotemax = 1;
				posMax = contpos;
			}
			if(lote>1)
			{
				if(pmax > pmaxT)
				{
					pmaxT = pmax;
					lotemax = lote;
					posMax = contpos;
				}
			}
		}
	}
	cout << "El total de sublotes ingresados fue de: " << lote << "\n"; //PUNTO B
	cout << "El mayor valor de todos es " << pmaxT << " [Lote: " << lotemax << "]" << "[Posicion en el lote: " << posMax << "]";
	return 0;
}
