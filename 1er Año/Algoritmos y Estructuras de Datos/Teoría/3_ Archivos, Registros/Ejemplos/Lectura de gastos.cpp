#include <iostream>
#include <stdio.h>
#include <string.h>
using namespace std;

struct Datos{
	char fecha[2];
	char hora[6];
	char servicio[20];
	char paga[20];
	int nrocontrol;
	int nrotransacc;
	int importe;
};

int main(){
	Datos D;
	FILE* F = fopen("01-Enero.dat","rb");
		fseek(F, 0, SEEK_SET);
		fread(&D,sizeof(D),1,F);
		while(!feof(F)){
			cout << "Servicio: " << D.servicio << endl;
			fread(&D,sizeof(D),1,F);
		}
		fclose(F);
}
