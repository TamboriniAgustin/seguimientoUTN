#include <iostream>
using namespace std;

int main()
{
	int may = 0;
	int valor = 0;
	int val;
	int pval = 0;
	while(valor<10)
	{
		valor++;
		pval++;
		cout << "Ingrese un valor: ";
		cin >> val;
		if(pval==1)
		{
			may = val;
		}
		if(may<val)
		{
			may = val;
		}
	}
	cout << "El mayor valor fue " << may;
	return 0;
}
