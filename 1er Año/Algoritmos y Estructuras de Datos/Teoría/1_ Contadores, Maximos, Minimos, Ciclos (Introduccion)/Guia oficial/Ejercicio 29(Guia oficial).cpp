#include <iostream>
using namespace std;
	
int main()
{
	int dec;
	cout << "Ingrese un numero decimal entre 1 y 3999: ";
	cin >> dec;
	while(dec>0 && dec<4000)
	{
		if(dec>=3000) { cout << "M"; dec=dec-1000; }
		if(dec>=2000) { cout << "M"; dec=dec-1000; }	
		if(dec>=1000) { cout << "M"; dec=dec-1000; }
		if(dec>=900) { cout << "CM"; dec=dec-900; }
		if(dec>=500) { cout << "D"; dec=dec-500; }
		if(dec>=400) { cout << "CD"; dec=dec-400; }
		if(dec>=300) { cout << "C"; dec=dec-100; }
		if(dec>=200) { cout << "C"; dec=dec-100; }
		if(dec>=100) { cout << "C"; dec=dec-100; }
		if(dec>=90) { cout << "XC"; dec=dec-90; }
		if(dec>=50) { cout << "L"; dec=dec-50; }
		if(dec>=40) { cout << "XL"; dec=dec-40; }
		if(dec>=30) { cout << "X"; dec=dec-10; } 
		if(dec>=20) { cout << "X"; dec=dec-10; } 
		if(dec>=10) { cout << "X"; dec=dec-10; } 
		if(dec>=9) { cout << "IX"; dec=dec-9; }
		if(dec>=5) { cout << "V"; dec=dec-5; }
		if(dec>=4) { cout << "IV"; dec=dec-4; } 
		if(dec>=3) { cout << "III"; dec=dec-3; }
		if(dec>=2) { cout << "II"; dec=dec-2; }
		if(dec>=1) { cout << "I"; dec=dec-1; }
		cout << "\tIngrese un numero decimal: ";
		cin >> dec;
	}
	return 0;	
}	
