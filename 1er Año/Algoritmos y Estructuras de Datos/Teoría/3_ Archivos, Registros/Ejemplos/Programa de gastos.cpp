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

void CreaciondeArchivo(int mes){
	Datos D;
	system("cls");
	printf("***Creando/Abriendo el archivo del mes seleccionado, aguarde un momento...\n");
	if(mes==1) FILE* F = fopen("01-Enero.dat","ab");
	else if(mes==2) FILE* F = fopen("02-Febrero.dat","ab"); 
	else if(mes==3) FILE* F = fopen("03-Marzo.dat","ab");
	else if(mes==4) FILE* F = fopen("04-Abril.dat","ab");
	else if(mes==5) FILE* F = fopen("05-Mayo.dat","ab");
	else if(mes==6) FILE* F = fopen("06-Junio.dat","ab");
	else if(mes==7) FILE* F = fopen("07-Julio.dat","ab");
	else if(mes==8) FILE* F = fopen("08-Agosto.dat","ab");
	else if(mes==9) FILE* F = fopen("09-Septiembre.dat","ab");
	else if(mes==10) FILE* F = fopen("10-Octubre.dat","ab");
	else if(mes==11) FILE* F = fopen("11-Noviembre.dat","ab");
	else if(mes==12) FILE* F = fopen("12-Diciembre.dat","ab");
	system("pause");
	system("cls");
}
void GrabaciondeArchivo(int mes){
	Datos D;
	system("cls");
	printf("Servicio: ");
	cin >> D.servicio;
	printf("Nombre de quien lo pague: ");
	cin >> D.paga;
	printf("Numero de control: ");
	cin >> D.nrocontrol;
	printf("Numero de transaccion: ");
	cin >> D.nrotransacc;
	printf("Importe: ");
	cin >> D.importe;
	printf("Fecha: ");
	cin >> D.fecha;
	printf("Hora: ");
	cin >> D.hora;
	system ("cls");
	printf("***Guardando los valores ingresados en el archivo, aguarde un momento...\n");
	system ("pause");
	printf("***Finalizando la operacion...\n");
	if(mes==1){
		FILE* F = fopen("01-Enero.dat","ab");
		fwrite(&D, sizeof(D), 1, F);
	}
	else if(mes==2) FILE* F = fopen("02-Febrero.dat","ab"); 
	else if(mes==3) FILE* F = fopen("03-Marzo.dat","ab");
	else if(mes==4) FILE* F = fopen("04-Abril.dat","ab");
	else if(mes==5) FILE* F = fopen("05-Mayo.dat","ab");
	else if(mes==6) FILE* F = fopen("06-Junio.dat","ab");
	else if(mes==7) FILE* F = fopen("07-Julio.dat","ab");
	else if(mes==8) FILE* F = fopen("08-Agosto.dat","ab");
	else if(mes==9) FILE* F = fopen("09-Septiembre.dat","ab");
	else if(mes==10) FILE* F = fopen("10-Octubre.dat","ab");
	else if(mes==11) FILE* F = fopen("11-Noviembre.dat","ab");
	else if(mes==12) FILE* F = fopen("12-Diciembre.dat","ab");
	system("pause");
	system("cls");
}

int main(){
	Datos D;
	int mes;
	cout << "Bienvenido!\nA continuacion debera ingresar el mes en el que quiere ingresar los datos, debera ingresarlo en formato numerico:\n";
	cin >> mes;
	if (mes<=0 || mes>12){
		for(int i=0;i<10;i++){
			cout << "Error! Debe ingresar un mes existente!\n";
			cin >> mes;
			if(mes>0 && mes<=12) i=11;
		}
	}
	CreaciondeArchivo(mes);
	cout << "*****************************************************************************************************\nBien, el archivo se ha cargado correctamente. Ahora procedera a ingresar los datos correspondientes.\n*****************************************************************************************************\n\n";
	system("pause");
	GrabaciondeArchivo(mes);
	return 0;
}
