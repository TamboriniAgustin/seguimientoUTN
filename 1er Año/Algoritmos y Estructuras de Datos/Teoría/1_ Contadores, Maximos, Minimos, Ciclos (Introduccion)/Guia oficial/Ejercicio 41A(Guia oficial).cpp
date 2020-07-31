#include <iostream>
using namespace std;

int main()
{
	int vt, vb;
	cout << "Ingrese cuantas cajas de vino blanco le quedan: ";
	cin >> vb;
	cout << "Ingrese cuantas cajas de vino tinto le quedan: ";
	cin >> vt;
	if(vt<vb) cout << "Se pueden armar " << vt << " paquetes de 1 caja de cada uno, pero sobran " << vb-vt << " de vino blanco.";
	else if(vt>vb) cout << "Se pueden armar " << vb << " paquetes de 1 caja de cada uno, pero sobran " << vt-vb << " de vino tinto.";
	if(vt==vb) cout << "Se pueden armar " << vt << " paquetes de 1 caja de cada uno.";
	return 0;
}
