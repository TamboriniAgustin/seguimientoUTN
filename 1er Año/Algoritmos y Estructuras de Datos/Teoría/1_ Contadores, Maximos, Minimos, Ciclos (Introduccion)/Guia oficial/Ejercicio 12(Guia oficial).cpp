#include <iostream>
using namespace std;

int main()
{
int naturales;
naturales = 0;
int sumatoria = 0;

while(naturales<100)
{
naturales++;	
cout << "\n" << naturales << "\n";
sumatoria+=naturales;	
}

cout << "La sumatoria es igual a\t" << sumatoria;	
return 0;	
}
