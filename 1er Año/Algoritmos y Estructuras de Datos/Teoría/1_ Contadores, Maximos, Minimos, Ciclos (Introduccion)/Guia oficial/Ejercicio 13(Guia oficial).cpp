#include <iostream>
using std::cout;
using std::cin;

int main()
{
int N;
int M;

cout << "Introduce un numero natural:\n";
cin >> N;
cout << "Introduce otro numero natural:\n";
cin >> M;

int producto;

if(N>0 && M>0)
{
	producto = 0;	
	for(int i=0; i<M; ++i)
	{
		producto = producto+N;
	}
	cout << "El producto por sumas sucesivas es:\t" << producto;
}
else
{
cout << "El valor debe ser un numero natural.";	
}
return 0;
}

