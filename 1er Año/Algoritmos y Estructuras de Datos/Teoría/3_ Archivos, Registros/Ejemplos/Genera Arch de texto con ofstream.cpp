#include <cstdlib>
#include <iostream>
#include <string.h>
#include <fstream>

using namespace std;

int main(int argc, char *argv[])
{

string Nom, Ape, linea;

ofstream fs;
 fs.open ("d:\\ficheroTexto.txt");

cout << "Ing Nom (punto para cortar): ";
cin >> Nom;

while (Nom != ".")
{
  cout << "Ing Ape: ";
  cin >> Ape;
  fs << Nom << " "<< Ape<<endl;
  cout << "Ing Nom (punto para cortar): ";
  cin >> Nom;
}

fs.close();

ifstream fe;
fe.open ("d:\\ficheroTexto.txt");

while (!fe.eof())
{
   getline(fe, linea);
   cout << linea <<endl;
}
fe.close();

system("PAUSE");
}

