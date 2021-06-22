#include <iostream>
using namespace std;

int main()
{
	int M;
	int suma;
	cout << "Inserte un valor: ";
	cin >> M;
	for(int N=0;N<M;)
	{
		suma = suma+3;
		if (suma%5!=0)
		{
			cout << suma << "\n";
			N++;
		}
		system("color 0A");
	} 
	return 0;
}
