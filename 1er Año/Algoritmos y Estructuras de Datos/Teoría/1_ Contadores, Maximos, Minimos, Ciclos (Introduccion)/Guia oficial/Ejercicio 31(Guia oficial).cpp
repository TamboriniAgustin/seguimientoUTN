#include <iostream>
using namespace std;

int main()
{
	int CI, edad;
	int rep=0;
	int analf=0;
	int MI=0;
	int PV=0;
	float sumapP = 0;
	float promedioP = 0;
	float sumapT = 0;
	float promedioT = 0;
	int estnc = 0;
	int fem=0;
	int masc=0;
	char dom[50], viv, N[10], A[10], sex, est, comp;
	char PC[50];
	cout << "AVISO! SI INGRESA 0 EN LA CANTIDAD DE PERSONAS EL PROGRAMA FINALIZARA\n";
	cout << "Bienvenido!, ingrese la cantidad de personas que viven en esta vivienda: ";
	cin >> CI;
	while(CI!=0)
	{
		if(PV==0)
		{
			MI=CI;
		}
		promedioP = 0;
		sumapP = 0;
		promedioT=promedioT+CI;
		cout << "Ingrese el tipo de vivienda (D_Depto || C_Casa): ";
		cin >> viv;
		cout << "Ingrese el domicilio: ";
		cin >> dom;
		if(CI>MI && viv=='D')
		{
			MI=CI;
			MI=dom[50];
			cout << "------------ACTUALIZACION------------\n";
			cout << "El domicilio de la familia que vive en departamento con mayor cantidad de integrantes es: " << dom << "\n"; //C
			cout << "-------------------------------------\n";
		}
		while(rep!=CI)
		{
			rep++;
			PV++;
			promedioP=CI;
			cout << "Bien, ahora ingrese el nombre y apellido de los integrantes(Ingrese ENTER luego del nombre,recien ahi ingrese apellido): ";
			cin >> N >> A;
			cout << "Ingrese la edad del integrante: ";
			cin >> edad;
			if(edad<0)
			{
				cout << "ERROR! La edad no puede ser menor a 0 años\n";
				cin >> edad;
			}
			sumapP = sumapP+edad;
			sumapT = sumapT+edad;
			cout << "De que genero es el integrante? M_Masculino - F_Femenino\n";
			cin >> sex;
			if(sex!='M' && sex!='F')
			{
				cout << "ERROR! Ingrese uno de los generos indicados: ";
				cin >> sex;
			}
			cout << "Posee estudios? N_No - P_Primario - S_Secundario - T_Terciario - U_Universitario\n";
			cin >> est;
			if(est!='P' && est!='S' && est!='T' && est!='U' && est!='N')
			{
				cout << "ERROR! Ingrese uno de los valores indicados: ";
				cin >> est;
			}
			if(est!='N')
			{
				cout << "Estan completos? C_Si - I_No\n";
				cin >> comp;
				if(comp!='C' && comp!='I')
				{
					cout << "ERROR! Ingrese uno de los valores ingresados: ";
					cin >> comp;
				}
			}
			if(est=='P' && comp=='C') cout << "--------------------------------\n" << N << " " << A << ", de " << edad << " años " << "(" << sex << ")" << " completo los estudios primarios.\n" << "--------------------------------\n"; //A
			if(est=='S' || est=='T' || est=='U') cout << "--------------------------------\n" << N << " " << A << ", de " << edad << " años " << "(" << sex << ")" << " completo los estudios primarios.\n" << "--------------------------------\n"; //A
			if(edad>10 && est=='N') analf++;
			if(est!='N' && comp=='I') estnc++;
			if(sex=='M') masc++;
			if(sex=='F') fem++;
		}
		cout << "------------------------------------------\n" << "La edad promedio de la familia es de " << sumapP/promedioP << "\n------------------------------------------\n"; //D
		rep=0;
		cout << "Ingrese la cantidad de integrantes de la familia: ";
		cin >> CI;
	}
	cout << "-----------------------------------------------\n"; 
	cout << "La cantidad de analfabetos en la ciudad es de: " << analf << "\n"; //B
	cout << "La edad promedio de la ciudad es de: " << sumapT/promedioT << "\n"; //D
	cout << "La cantidad de personas con estudios incompletos es de: " << estnc << "\n"; //E
	cout << "La cantidad de personas masculinas es de: " << (100*masc)/promedioT << "%\n"; //F
	cout << "La cantidad de personas femeninas es de: " << (100*fem)/promedioT << "%\n"; //F
	cout << "-----------------------------------------------\n"; 
	return 0;
}
