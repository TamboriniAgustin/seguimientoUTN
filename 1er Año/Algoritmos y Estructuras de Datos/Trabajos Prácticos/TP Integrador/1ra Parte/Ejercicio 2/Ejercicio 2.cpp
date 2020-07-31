#include <iostream>
#include <stdio.h>
#include <string.h>
using namespace std;

struct Sorteo{
	int Bolillero;
	char NEquipo[20];
	char Confederacion[10];
};

void InicializarVariables();
void Repetido(int Bolillero, char NEQ[20], char CEQ[10]);
void LlenarGrupoA(int Bolillero, char NEQ[20], char CEQ[10]);
void LlenarGrupoB(int Bolillero, char NEQ[20], char CEQ[10]);
void LlenarGrupoC(int Bolillero, char NEQ[20], char CEQ[10]);
void LlenarGrupoD(int Bolillero, char NEQ[20], char CEQ[10]);
void LlenarGrupoE(int Bolillero, char NEQ[20], char CEQ[10]);
void LlenarGrupoF(int Bolillero, char NEQ[20], char CEQ[10]);
void LlenarGrupoG(int Bolillero, char NEQ[20], char CEQ[10]);
void LlenarGrupoH(int Bolillero, char NEQ[20], char CEQ[10]);

//Variables Globales
int UEFAa = 0, CONMEBOLa = 0, CAFa = 0, AFCa = 0, CONCACAFa = 0,
	UEFAb = 0, CONMEBOLb = 0, CAFb = 0, AFCb = 0, CONCACAFb = 0,
	UEFAc = 0, CONMEBOLc = 0, CAFc = 0, AFCc = 0, CONCACAFc = 0,
	UEFAd = 0, CONMEBOLd = 0, CAFd = 0, AFCd = 0, CONCACAFd = 0,
	UEFAe = 0, CONMEBOLe = 0, CAFe = 0, AFCe = 0, CONCACAFe = 0,
	UEFAf = 0, CONMEBOLf = 0, CAFf = 0, AFCf = 0, CONCACAFf = 0,
	UEFAg = 0, CONMEBOLg = 0, CAFg = 0, AFCg = 0, CONCACAFg = 0,
	UEFAh = 0, CONMEBOLh = 0, CAFh = 0, AFCh = 0, CONCACAFh = 0;

int Cabecera[8], Segundo[8], Tercero[8], Ultimo[8]; //Representa los cabecera de serie

int main(){
	printf("*Sortear la Fase de Grupos*\n");
	system("pause");
	Sorteo sort;
	FILE* F = fopen("Bolilleros.txt","rb+");
	InicializarVariables();
	string Confed, Equip;
	fread(&sort,sizeof(sort),1,F); 	
	while(!feof(F)){
		Confed = sort.Confederacion; //Asigno a la variable la actual confederacion
		Equip = sort.NEquipo; //Asigno a la variable el pais actual
		if(sort.Bolillero==1){ //Sorteamos el bolillero 1, acomodando a los equipo cabecera
			if(Cabecera[0]==0 && Equip=="Rusia"){
				LlenarGrupoA(sort.Bolillero,sort.NEquipo,sort.Confederacion);
				Cabecera[0]++;
				if(Confed=="UEFA") UEFAa++;
				if(Confed=="CONMEBOL") CONMEBOLa++;
			}
			else if(Cabecera[1]==0 && Equip=="Alemania"){
				LlenarGrupoB(sort.Bolillero,sort.NEquipo,sort.Confederacion);
				Cabecera[1]++;
				if(Confed=="UEFA") UEFAb++;
				if(Confed=="CONMEBOL") CONMEBOLb++;
			}
			else if(Cabecera[2]==0 && Equip=="Brasil"){
				LlenarGrupoC(sort.Bolillero,sort.NEquipo,sort.Confederacion);
				Cabecera[2]++;
				if(Confed=="UEFA") UEFAc++;
				if(Confed=="CONMEBOL") CONMEBOLc++;
			}
			else if(Cabecera[3]==0 && Equip=="Portugal"){
				LlenarGrupoD(sort.Bolillero,sort.NEquipo,sort.Confederacion);
				Cabecera[3]++;
				if(Confed=="UEFA") UEFAd++;
				if(Confed=="CONMEBOL") CONMEBOLd++;
			}
			else if(Cabecera[4]==0 && Equip=="Argentina"){
				LlenarGrupoE(sort.Bolillero,sort.NEquipo,sort.Confederacion);
				Cabecera[4]++;
				if(Confed=="UEFA") UEFAe++;
				if(Confed=="CONMEBOL") CONMEBOLe++;
			}
			else if(Cabecera[5]==0 && Equip=="Belgica"){
				LlenarGrupoF(sort.Bolillero,sort.NEquipo,sort.Confederacion);
				Cabecera[5]++;
				if(Confed=="UEFA") UEFAf++;
				if(Confed=="CONMEBOL") CONMEBOLf++;
			}
			else if(Cabecera[6]==0 && Equip=="Polonia"){
				LlenarGrupoG(sort.Bolillero,sort.NEquipo,sort.Confederacion);
				Cabecera[6]++;
				if(Confed=="UEFA") UEFAg++;
				if(Confed=="CONMEBOL") CONMEBOLg++;
			}
			else if(Cabecera[7]==0 && Equip=="Francia"){
				LlenarGrupoH(sort.Bolillero,sort.NEquipo,sort.Confederacion);
				Cabecera[7]++;
				if(Confed=="UEFA") UEFAh++;
				if(Confed=="CONMEBOL") CONMEBOLh++;
			}
		}
		if(sort.Bolillero==2){ //Sorteamos el bolillero 2
			if(Segundo[0]==0){
				LlenarGrupoA(sort.Bolillero,sort.NEquipo,sort.Confederacion);
				Segundo[0]++;
				if(Confed=="UEFA") UEFAa++;
				if(Confed=="CONMEBOL") CONMEBOLa++;
				if(Confed=="CONCACAF") CONCACAFa++;
			}
			else if(Segundo[1]==0){
				LlenarGrupoB(sort.Bolillero,sort.NEquipo,sort.Confederacion);
				Segundo[1]++;
				if(Confed=="UEFA") UEFAb++;
				if(Confed=="CONMEBOL") CONMEBOLb++;
				if(Confed=="CONCACAF") CONCACAFb++;
			}
			else if(Segundo[2]==0){
				if(Confed=="UEFA") { UEFAc++; LlenarGrupoC(sort.Bolillero,sort.NEquipo,sort.Confederacion); Segundo[2]++; }
				else if(Confed=="CONCACAF") { CONCACAFc++; LlenarGrupoC(sort.Bolillero,sort.NEquipo,sort.Confederacion); Segundo[2]++; }
				else if(Confed=="CONMEBOL" && CONMEBOLc<1) { CONMEBOLc++; LlenarGrupoC(sort.Bolillero,sort.NEquipo,sort.Confederacion); Segundo[2]++; }
				else Repetido(sort.Bolillero,sort.NEquipo,sort.Confederacion);
			}
			else if(Segundo[3]==0){
				LlenarGrupoD(sort.Bolillero,sort.NEquipo,sort.Confederacion);
				Segundo[3]++;
				if(Confed=="UEFA") UEFAd++;
				if(Confed=="CONMEBOL") CONMEBOLd++;
				if(Confed=="CONCACAF") CONCACAFd++;
			}
			else if(Segundo[4]==0){
				if(Confed=="UEFA") { UEFAe++; LlenarGrupoE(sort.Bolillero,sort.NEquipo,sort.Confederacion); Segundo[4]++; }
				else if(Confed=="CONCACAF") { CONCACAFe++; LlenarGrupoE(sort.Bolillero,sort.NEquipo,sort.Confederacion); Segundo[4]++; }
				else if(Confed=="CONMEBOL" && CONMEBOLe<1) { CONMEBOLe++; LlenarGrupoE(sort.Bolillero,sort.NEquipo,sort.Confederacion); Segundo[4]++; }
				else Repetido(sort.Bolillero,sort.NEquipo,sort.Confederacion);
			}
			else if(Segundo[5]==0){
				LlenarGrupoF(sort.Bolillero,sort.NEquipo,sort.Confederacion);
				Segundo[5]++;
				if(Confed=="UEFA") UEFAf++;
				if(Confed=="CONMEBOL") CONMEBOLf++;
				if(Confed=="CONCACAF") CONCACAFf++;
			}
			else if(Segundo[6]==0){
				LlenarGrupoG(sort.Bolillero,sort.NEquipo,sort.Confederacion);
				Segundo[6]++;
				if(Confed=="UEFA") UEFAg++;
				if(Confed=="CONMEBOL") CONMEBOLg++;
				if(Confed=="CONCACAF") CONCACAFg++;
			}
			else if(Segundo[7]==0){
				LlenarGrupoH(sort.Bolillero,sort.NEquipo,sort.Confederacion);
				Segundo[7]++;
				if(Confed=="UEFA") UEFAh++;
				if(Confed=="CONMEBOL") CONMEBOLh++;
				if(Confed=="CONCACAF") CONCACAFh++;
			}
		}
		if(sort.Bolillero==3){ //Sorteamos el bolillero 3
			if(Tercero[0]==0){
				if(Confed=="UEFA" && UEFAa<2){
					LlenarGrupoA(sort.Bolillero,sort.NEquipo,sort.Confederacion);
					Tercero[0]++;
					UEFAb++;
				}
				else if(Confed=="CONCACAF" && CONCACAFa<1){
					LlenarGrupoA(sort.Bolillero,sort.NEquipo,sort.Confederacion);
					Tercero[0]++;
					CONCACAFb++;
				}
				else if(Confed=="CAF" && CAFa<1){
					LlenarGrupoA(sort.Bolillero,sort.NEquipo,sort.Confederacion);
					Tercero[0]++;
					CAFb++;
				}
				else if(Confed=="AFC" && AFCa<1){
					LlenarGrupoA(sort.Bolillero,sort.NEquipo,sort.Confederacion);
					Tercero[0]++;
					AFCb++;
				}
				else Repetido(sort.Bolillero,sort.NEquipo,sort.Confederacion);
			}
			else if(Tercero[1]==0){
				if(Confed=="UEFA" && UEFAb<2){
					LlenarGrupoB(sort.Bolillero,sort.NEquipo,sort.Confederacion);
					Tercero[1]++;
					UEFAb++;
				}
				else if(Confed=="CONCACAF" && CONCACAFb<1){
					LlenarGrupoB(sort.Bolillero,sort.NEquipo,sort.Confederacion);
					Tercero[1]++;
					CONCACAFb++;
				}
				else if(Confed=="CAF" && CAFb<1){
					LlenarGrupoB(sort.Bolillero,sort.NEquipo,sort.Confederacion);
					Tercero[1]++;
					CAFb++;
				}
				else if(Confed=="AFC" && AFCb<1){
					LlenarGrupoB(sort.Bolillero,sort.NEquipo,sort.Confederacion);
					Tercero[1]++;
					AFCb++;
				}
				else Repetido(sort.Bolillero,sort.NEquipo,sort.Confederacion);
			}
			else if(Tercero[2]==0){
				if(Confed=="UEFA" && UEFAc<2){
					LlenarGrupoC(sort.Bolillero,sort.NEquipo,sort.Confederacion);
					Tercero[2]++;
					UEFAc++;
				}
				else if(Confed=="CONCACAF" && CONCACAFc<1){
					LlenarGrupoC(sort.Bolillero,sort.NEquipo,sort.Confederacion);
					Tercero[2]++;
					CONCACAFc++;
				}
				else if(Confed=="CAF" && CAFc<1){
					LlenarGrupoC(sort.Bolillero,sort.NEquipo,sort.Confederacion);
					Tercero[2]++;
					CAFc++;
				}
				else if(Confed=="AFC" && AFCc<1){
					LlenarGrupoC(sort.Bolillero,sort.NEquipo,sort.Confederacion);
					Tercero[2]++;
					AFCc++;
				}
				else Repetido(sort.Bolillero,sort.NEquipo,sort.Confederacion);
			}
			else if(Tercero[3]==0){
				if(Confed=="UEFA" && UEFAd<2){
					LlenarGrupoD(sort.Bolillero,sort.NEquipo,sort.Confederacion);
					Tercero[3]++;
					UEFAd++;
				}
				else if(Confed=="CONCACAF" && CONCACAFd<1){
					LlenarGrupoD(sort.Bolillero,sort.NEquipo,sort.Confederacion);
					Tercero[3]++;
					CONCACAFd++;
				}
				else if(Confed=="CAF" && CAFd<1){
					LlenarGrupoD(sort.Bolillero,sort.NEquipo,sort.Confederacion);
					Tercero[3]++;
					CAFd++;
				}
				else if(Confed=="AFC" && AFCd<1){
					LlenarGrupoD(sort.Bolillero,sort.NEquipo,sort.Confederacion);
					Tercero[3]++;
					AFCd++;
				}
				else Repetido(sort.Bolillero,sort.NEquipo,sort.Confederacion);
			}
			else if(Tercero[4]==0){
				if(Confed=="UEFA" && UEFAe<2){
					LlenarGrupoE(sort.Bolillero,sort.NEquipo,sort.Confederacion);
					Tercero[4]++;
					UEFAe++;
				}
				else if(Confed=="CONCACAF" && CONCACAFe<1){
					LlenarGrupoE(sort.Bolillero,sort.NEquipo,sort.Confederacion);
					Tercero[4]++;
					CONCACAFe++;
				}
				else if(Confed=="CAF" && CAFe<1){
					LlenarGrupoE(sort.Bolillero,sort.NEquipo,sort.Confederacion);
					Tercero[4]++;
					CAFe++;
				}
				else if(Confed=="AFC" && AFCe<1){
					LlenarGrupoE(sort.Bolillero,sort.NEquipo,sort.Confederacion);
					Tercero[4]++;
					AFCe++;
				}
				else Repetido(sort.Bolillero,sort.NEquipo,sort.Confederacion);
			}
			else if(Tercero[5]==0){
				if(Confed=="UEFA" && UEFAf<2){
					LlenarGrupoF(sort.Bolillero,sort.NEquipo,sort.Confederacion);
					Tercero[5]++;
					UEFAf++;
				}
				else if(Confed=="CONCACAF" && CONCACAFf<1){
					LlenarGrupoF(sort.Bolillero,sort.NEquipo,sort.Confederacion);
					Tercero[5]++;
					CONCACAFf++;
				}
				else if(Confed=="CAF" && CAFf<1){
					LlenarGrupoF(sort.Bolillero,sort.NEquipo,sort.Confederacion);
					Tercero[5]++;
					CAFf++;
				}
				else if(Confed=="AFC" && AFCf<1){
					LlenarGrupoF(sort.Bolillero,sort.NEquipo,sort.Confederacion);
					Tercero[5]++;
					AFCf++;
				}
				else Repetido(sort.Bolillero,sort.NEquipo,sort.Confederacion);
			}
			else if(Tercero[6]==0){
				if(Confed=="UEFA" && UEFAg<2){
					LlenarGrupoG(sort.Bolillero,sort.NEquipo,sort.Confederacion);
					Tercero[6]++;
					UEFAg++;
				}
				else if(Confed=="CONCACAF" && CONCACAFg<1){
					LlenarGrupoG(sort.Bolillero,sort.NEquipo,sort.Confederacion);
					Tercero[6]++;
					CONCACAFg++;
				}
				else if(Confed=="CAF" && CAFg<1){
					LlenarGrupoG(sort.Bolillero,sort.NEquipo,sort.Confederacion);
					Tercero[6]++;
					CAFg++;
				}
				else if(Confed=="AFC" && AFCg<1){
					LlenarGrupoG(sort.Bolillero,sort.NEquipo,sort.Confederacion);
					Tercero[6]++;
					AFCg++;
				}
				else Repetido(sort.Bolillero,sort.NEquipo,sort.Confederacion);
			}
			else if(Tercero[7]==0){
				if(Confed=="UEFA" && UEFAh<2){
					LlenarGrupoH(sort.Bolillero,sort.NEquipo,sort.Confederacion);
					Tercero[7]++;
					UEFAh++;
				}
				else if(Confed=="CONCACAF" && CONCACAFh<1){
					LlenarGrupoH(sort.Bolillero,sort.NEquipo,sort.Confederacion);
					Tercero[7]++;
					CONCACAFh++;
				}
				else if(Confed=="CAF" && CAFh<1){
					LlenarGrupoH(sort.Bolillero,sort.NEquipo,sort.Confederacion);
					Tercero[7]++;
					CAFh++;
				}
				else if(Confed=="AFC" && AFCh<1){
					LlenarGrupoH(sort.Bolillero,sort.NEquipo,sort.Confederacion);
					Tercero[7]++;
					AFCh++;
				}
				else Repetido(sort.Bolillero,sort.NEquipo,sort.Confederacion);
			}
		}
		if(sort.Bolillero==4){ //Sorteamos el bolillero 4
			if(Ultimo[0]==0){
				if(Confed=="UEFA" && UEFAa<2){
					LlenarGrupoA(sort.Bolillero,sort.NEquipo,sort.Confederacion);
					Ultimo[0]++;
					UEFAa++;
				}
				else if(Confed=="CAF" && CAFa<1){
					LlenarGrupoA(sort.Bolillero,sort.NEquipo,sort.Confederacion);
					Ultimo[0]++;
					CAFa++;
				}
				else if(Confed=="AFC" && AFCa<1){
					LlenarGrupoA(sort.Bolillero,sort.NEquipo,sort.Confederacion);
					Ultimo[0]++;
					AFCa++;
				}
				else if(Confed=="CONCACAF" && CONCACAFa<1){
					LlenarGrupoA(sort.Bolillero,sort.NEquipo,sort.Confederacion);
					Ultimo[0]++;
					CONCACAFa++;
				}
				else Repetido(sort.Bolillero,sort.NEquipo,sort.Confederacion);
			}
			else if(Ultimo[1]==0){
				if(Confed=="UEFA" && UEFAb<2){
					LlenarGrupoB(sort.Bolillero,sort.NEquipo,sort.Confederacion);
					Ultimo[1]++;
					UEFAb++;
				}
				else if(Confed=="CAF" && CAFb<1){
					LlenarGrupoB(sort.Bolillero,sort.NEquipo,sort.Confederacion);
					Ultimo[1]++;
					CAFb++;
				}
				else if(Confed=="AFC" && AFCb<1){
					LlenarGrupoB(sort.Bolillero,sort.NEquipo,sort.Confederacion);
					Ultimo[1]++;
					AFCb++;
				}
				else if(Confed=="CONCACAF" && CONCACAFb<1){
					LlenarGrupoB(sort.Bolillero,sort.NEquipo,sort.Confederacion);
					Ultimo[1]++;
					CONCACAFb++;
				}
				else Repetido(sort.Bolillero,sort.NEquipo,sort.Confederacion);
			}
			else if(Ultimo[2]==0){
				if(Confed=="UEFA" && UEFAc<2){
					LlenarGrupoC(sort.Bolillero,sort.NEquipo,sort.Confederacion);
					Ultimo[2]++;
					UEFAc++;
				}
				else if(Confed=="CAF" && CAFc<1){
					LlenarGrupoC(sort.Bolillero,sort.NEquipo,sort.Confederacion);
					Ultimo[2]++;
					CAFc++;
				}
				else if(Confed=="AFC" && AFCc<1){
					LlenarGrupoC(sort.Bolillero,sort.NEquipo,sort.Confederacion);
					Ultimo[2]++;
					AFCc++;
				}
				else if(Confed=="CONCACAF" && CONCACAFc<1){
					LlenarGrupoC(sort.Bolillero,sort.NEquipo,sort.Confederacion);
					Ultimo[2]++;
					CONCACAFc++;
				}
				else Repetido(sort.Bolillero,sort.NEquipo,sort.Confederacion);
			}
			else if(Ultimo[3]==0){
				if(Confed=="UEFA" && UEFAd<2){
					LlenarGrupoD(sort.Bolillero,sort.NEquipo,sort.Confederacion);
					Ultimo[3]++;
					UEFAd++;
				}
				else if(Confed=="CAF" && CAFd<1){
					LlenarGrupoD(sort.Bolillero,sort.NEquipo,sort.Confederacion);
					Ultimo[3]++;
					CAFd++;
				}
				else if(Confed=="AFC" && AFCd<1){
					LlenarGrupoD(sort.Bolillero,sort.NEquipo,sort.Confederacion);
					Ultimo[3]++;
					AFCd++;
				}
				else if(Confed=="CONCACAF" && CONCACAFd<1){
					LlenarGrupoD(sort.Bolillero,sort.NEquipo,sort.Confederacion);
					Ultimo[3]++;
					CONCACAFd++;
				}
				else Repetido(sort.Bolillero,sort.NEquipo,sort.Confederacion);
			}
			else if(Ultimo[4]==0){
				if(Confed=="UEFA" && UEFAe<2){
					LlenarGrupoE(sort.Bolillero,sort.NEquipo,sort.Confederacion);
					Ultimo[4]++;
					UEFAe++;
				}
				else if(Confed=="CAF" && CAFe<1){
					LlenarGrupoE(sort.Bolillero,sort.NEquipo,sort.Confederacion);
					Ultimo[4]++;
					CAFe++;
				}
				else if(Confed=="AFC" && AFCe<1){
					LlenarGrupoE(sort.Bolillero,sort.NEquipo,sort.Confederacion);
					Ultimo[4]++;
					AFCe++;
				}
				else if(Confed=="CONCACAF" && CONCACAFe<1){
					LlenarGrupoE(sort.Bolillero,sort.NEquipo,sort.Confederacion);
					Ultimo[4]++;
					CONCACAFe++;
				}
				else Repetido(sort.Bolillero,sort.NEquipo,sort.Confederacion);
			}
			else if(Ultimo[5]==0){
				if(Confed=="UEFA" && UEFAf<2){
					LlenarGrupoF(sort.Bolillero,sort.NEquipo,sort.Confederacion);
					Ultimo[5]++;
					UEFAf++;
				}
				else if(Confed=="CAF" && CAFf<1){
					LlenarGrupoF(sort.Bolillero,sort.NEquipo,sort.Confederacion);
					Ultimo[5]++;
					CAFf++;
				}
				else if(Confed=="AFC" && AFCf<1){
					LlenarGrupoF(sort.Bolillero,sort.NEquipo,sort.Confederacion);
					Ultimo[5]++;
					AFCf++;
				}
				else if(Confed=="CONCACAF" && CONCACAFf<1){
					LlenarGrupoF(sort.Bolillero,sort.NEquipo,sort.Confederacion);
					Ultimo[5]++;
					CONCACAFf++;
				}
				else Repetido(sort.Bolillero,sort.NEquipo,sort.Confederacion);
			}
			else if(Ultimo[6]==0){
				if(Confed=="UEFA" && UEFAg<2){
					LlenarGrupoG(sort.Bolillero,sort.NEquipo,sort.Confederacion);
					Ultimo[6]++;
					UEFAg++;
				}
				else if(Confed=="CAF" && CAFg<1){
					LlenarGrupoG(sort.Bolillero,sort.NEquipo,sort.Confederacion);
					Ultimo[6]++;
					CAFg++;
				}
				else if(Confed=="AFC" && AFCg<1){
					LlenarGrupoG(sort.Bolillero,sort.NEquipo,sort.Confederacion);
					Ultimo[6]++;
					AFCg++;
				}
				else if(Confed=="CONCACAF" && CONCACAFg<1){
					LlenarGrupoG(sort.Bolillero,sort.NEquipo,sort.Confederacion);
					Ultimo[6]++;
					CONCACAFg++;
				}
				else Repetido(sort.Bolillero,sort.NEquipo,sort.Confederacion);
			}
			else if(Ultimo[7]==0){
				if(Confed=="UEFA" && UEFAh<2){
					LlenarGrupoH(sort.Bolillero,sort.NEquipo,sort.Confederacion);
					Ultimo[7]++;
					UEFAh++;
				}
				else if(Confed=="CAF" && CAFh<1){
					LlenarGrupoH(sort.Bolillero,sort.NEquipo,sort.Confederacion);
					Ultimo[7]++;
					CAFh++;
				}
				else if(Confed=="AFC" && AFCh<1){
					LlenarGrupoH(sort.Bolillero,sort.NEquipo,sort.Confederacion);
					Ultimo[7]++;
					AFCh++;
				}
				else if(Confed=="CONCACAF" && CONCACAFh<1){
					LlenarGrupoH(sort.Bolillero,sort.NEquipo,sort.Confederacion);
					Ultimo[7]++;
					CONCACAFh++;
				}
				else Repetido(sort.Bolillero,sort.NEquipo,sort.Confederacion);
			}
		}
		fread(&sort,sizeof(sort),1,F);
	}
	return 0;
}

void InicializarVariables(){
	for(int i=0;i<=7;i++){ //Porque son 8 grupos
		Cabecera[i] = 0;
		Segundo[i] = 0;
		Tercero[i] = 0;
		Ultimo[i] = 0;
	}
}

void Repetido(int Bolillero, char NEQ[20], char CEQ[10]){
	string Confed = CEQ;
	string EquipIngresado = "";
	if(Bolillero==2){
		if(Segundo[0]==0){
			if(Confed=="UEFA" && UEFAa<2 && EquipIngresado!=NEQ) { UEFAa++; LlenarGrupoA(Bolillero,NEQ,CEQ); EquipIngresado=NEQ; Segundo[0]++; }
			else if(Confed=="CONMEBOL" && CONMEBOLa<1 && EquipIngresado!=NEQ) { CONMEBOLa++; LlenarGrupoA(Bolillero,NEQ,CEQ); EquipIngresado=NEQ; Segundo[0]++; }
			else if(Confed=="CONCACAF" && CONCACAFa<1 && EquipIngresado!=NEQ) { CONCACAFa++; LlenarGrupoA(Bolillero,NEQ,CEQ); EquipIngresado=NEQ; Segundo[0]++; }
		}
		if(Segundo[1]==0){
			if(Confed=="UEFA" && UEFAb<2 && EquipIngresado!=NEQ) { UEFAb++; LlenarGrupoB(Bolillero,NEQ,CEQ); EquipIngresado=NEQ; Segundo[1]++; }
			else if(Confed=="CONMEBOL" && CONMEBOLb<1 && EquipIngresado!=NEQ) { CONMEBOLb++; LlenarGrupoB(Bolillero,NEQ,CEQ); EquipIngresado=NEQ; Segundo[1]++; }
			else if(Confed=="CONCACAF" && CONCACAFb<1 && EquipIngresado!=NEQ) { CONCACAFb++; LlenarGrupoB(Bolillero,NEQ,CEQ); EquipIngresado=NEQ; Segundo[1]++; }
		}
		if(Segundo[2]==0){
			if(Confed=="UEFA" && UEFAc<2 && EquipIngresado!=NEQ) { UEFAc++; LlenarGrupoC(Bolillero,NEQ,CEQ); EquipIngresado=NEQ; Segundo[2]++; }
			else if(Confed=="CONCACAF" && CONCACAFc<1 && EquipIngresado!=NEQ) { CONCACAFc++; LlenarGrupoC(Bolillero,NEQ,CEQ); EquipIngresado=NEQ; Segundo[2]++; }
		}
		if(Segundo[3]==0){
			if(Confed=="UEFA" && UEFAd<2 && EquipIngresado!=NEQ) { UEFAd++; LlenarGrupoD(Bolillero,NEQ,CEQ); EquipIngresado=NEQ; Segundo[3]++; }
			else if(Confed=="CONMEBOL" && CONMEBOLd<1 && EquipIngresado!=NEQ) { CONMEBOLd++; LlenarGrupoD(Bolillero,NEQ,CEQ); EquipIngresado=NEQ; Segundo[3]++; }
			else if(Confed=="CONCACAF" && CONCACAFd<1 && EquipIngresado!=NEQ) { CONCACAFd++; LlenarGrupoD(Bolillero,NEQ,CEQ); EquipIngresado=NEQ; Segundo[3]++; }
		}
		if(Segundo[5]==0){
			if(Confed=="UEFA" && UEFAe<2 && EquipIngresado!=NEQ) { UEFAe++; LlenarGrupoE(Bolillero,NEQ,CEQ); EquipIngresado=NEQ; Segundo[4]++; }
			else if(Confed=="CONCACAF" && CONCACAFe<1 && EquipIngresado!=NEQ) { CONCACAFe++; LlenarGrupoE(Bolillero,NEQ,CEQ); EquipIngresado=NEQ; Segundo[4]++; }
		}
		if(Segundo[6]==0){
			if(Confed=="UEFA" && UEFAf<2 && EquipIngresado!=NEQ) { UEFAf++; LlenarGrupoF(Bolillero,NEQ,CEQ); EquipIngresado=NEQ; Segundo[5]++; }
			else if(Confed=="CONMEBOL" && CONMEBOLf>1 && EquipIngresado!=NEQ) { CONMEBOLf++; LlenarGrupoF(Bolillero,NEQ,CEQ); EquipIngresado=NEQ; Segundo[5]++; }
			else if(Confed=="CONCACAF" && CONCACAFf<1 && EquipIngresado!=NEQ) { CONCACAFf++; LlenarGrupoF(Bolillero,NEQ,CEQ); EquipIngresado=NEQ; Segundo[5]++; }
		}
		if(Segundo[7]==0){
			if(Confed=="UEFA" && UEFAg<2 && EquipIngresado!=NEQ) { UEFAg++; LlenarGrupoG(Bolillero,NEQ,CEQ); EquipIngresado=NEQ; Segundo[6]++; }
			else if(Confed=="CONMEBOL" && CONMEBOLg<1 && EquipIngresado!=NEQ) { CONMEBOLg++; LlenarGrupoG(Bolillero,NEQ,CEQ); EquipIngresado=NEQ; Segundo[6]++; }
			else if(Confed=="CONCACAF" && CONCACAFg<1 && EquipIngresado!=NEQ) { CONCACAFg++; LlenarGrupoG(Bolillero,NEQ,CEQ); EquipIngresado=NEQ; Segundo[6]++; }
		}
		if(Segundo[8]==0){
			if(Confed=="UEFA" && UEFAh<2 && EquipIngresado!=NEQ) { UEFAh++; LlenarGrupoH(Bolillero,NEQ,CEQ); EquipIngresado=NEQ; Segundo[7]++; }
			else if(Confed=="CONMEBOL" && CONMEBOLh<1 && EquipIngresado!=NEQ) { CONMEBOLh++; LlenarGrupoH(Bolillero,NEQ,CEQ); EquipIngresado=NEQ; Segundo[7]++; }
			else if(Confed=="CONCACAF" && CONCACAFh<1 && EquipIngresado!=NEQ) { CONCACAFh++; LlenarGrupoH(Bolillero,NEQ,CEQ); EquipIngresado=NEQ; Segundo[7]++; }
		}
	}
	if(Bolillero==3){
		if(Tercero[0]==0){
			if(Confed=="UEFA" && UEFAa<2 && EquipIngresado!=NEQ) { UEFAa++; LlenarGrupoA(Bolillero,NEQ,CEQ); EquipIngresado=NEQ; Tercero[0]++; }
			else if(Confed=="CAF" && CAFa<1 && EquipIngresado!=NEQ) { CAFa++; LlenarGrupoA(Bolillero,NEQ,CEQ); EquipIngresado=NEQ; Tercero[0]++; }
			else if(Confed=="AFC" && AFCa<1 && EquipIngresado!=NEQ) { AFCa++; LlenarGrupoA(Bolillero,NEQ,CEQ); EquipIngresado=NEQ; Tercero[0]++; }
			else if(Confed=="CONCACAF" && CONCACAFa<1 && EquipIngresado!=NEQ) { CONCACAFa++; LlenarGrupoA(Bolillero,NEQ,CEQ); EquipIngresado=NEQ; Tercero[0]++; }
		}
		if(Tercero[1]==0){
			if(Confed=="UEFA" && UEFAb<2 && EquipIngresado!=NEQ) { UEFAb++; LlenarGrupoB(Bolillero,NEQ,CEQ); EquipIngresado=NEQ; Tercero[1]++; }
			else if(Confed=="CAF" && CAFb<1 && EquipIngresado!=NEQ) { CAFb++; LlenarGrupoB(Bolillero,NEQ,CEQ); EquipIngresado=NEQ; Tercero[1]++; }
			else if(Confed=="AFC" && AFCb<1 && EquipIngresado!=NEQ) { AFCb++; LlenarGrupoB(Bolillero,NEQ,CEQ); EquipIngresado=NEQ; Tercero[1]++; }
			else if(Confed=="CONCACAF" && CONCACAFb<1 && EquipIngresado!=NEQ) { CONCACAFb++; LlenarGrupoB(Bolillero,NEQ,CEQ); EquipIngresado=NEQ; Tercero[1]++; }
		}
		if(Tercero[2]==0){
			if(Confed=="UEFA" && UEFAc<2 && EquipIngresado!=NEQ) { UEFAc++; LlenarGrupoC(Bolillero,NEQ,CEQ); EquipIngresado=NEQ; Tercero[2]++; }
			else if(Confed=="CAF" && CAFc<1 && EquipIngresado!=NEQ) { CAFc++; LlenarGrupoC(Bolillero,NEQ,CEQ); EquipIngresado=NEQ; Tercero[2]++; }
			else if(Confed=="AFC" && AFCc<1 && EquipIngresado!=NEQ) { AFCc++; LlenarGrupoC(Bolillero,NEQ,CEQ); EquipIngresado=NEQ; Tercero[2]++; }
			else if(Confed=="CONCACAF" && CONCACAFc<1 && EquipIngresado!=NEQ) { CONCACAFc++; LlenarGrupoC(Bolillero,NEQ,CEQ); EquipIngresado=NEQ; Tercero[2]++; }
		}
		if(Tercero[3]==0){
			if(Confed=="UEFA" && UEFAd<2 && EquipIngresado!=NEQ) { UEFAd++; LlenarGrupoD(Bolillero,NEQ,CEQ); EquipIngresado=NEQ; Tercero[3]++; }
			else if(Confed=="CAF" && CAFd<1 && EquipIngresado!=NEQ) { CAFd++; LlenarGrupoD(Bolillero,NEQ,CEQ); EquipIngresado=NEQ; Tercero[3]++; }
			else if(Confed=="AFC" && AFCd<1 && EquipIngresado!=NEQ) { AFCd++; LlenarGrupoD(Bolillero,NEQ,CEQ); EquipIngresado=NEQ; Tercero[3]++; }
			else if(Confed=="CONCACAF" && CONCACAFd<1 && EquipIngresado!=NEQ) { CONCACAFd++; LlenarGrupoD(Bolillero,NEQ,CEQ); EquipIngresado=NEQ; Tercero[3]++; }
		}
		if(Tercero[4]==0){
			if(Confed=="UEFA" && UEFAe<2 && EquipIngresado!=NEQ) { UEFAe++; LlenarGrupoE(Bolillero,NEQ,CEQ); EquipIngresado=NEQ; Tercero[4]++; }
			else if(Confed=="CAF" && CAFe<1 && EquipIngresado!=NEQ) { CAFe++; LlenarGrupoE(Bolillero,NEQ,CEQ); EquipIngresado=NEQ; Tercero[4]++; }
			else if(Confed=="AFC" && AFCe<1 && EquipIngresado!=NEQ) { AFCe++; LlenarGrupoE(Bolillero,NEQ,CEQ); EquipIngresado=NEQ; Tercero[4]++; }
			else if(Confed=="CONCACAF" && CONCACAFe<1 && EquipIngresado!=NEQ) { CONCACAFe++; LlenarGrupoE(Bolillero,NEQ,CEQ); EquipIngresado=NEQ; Tercero[4]++; }
		}
		if(Tercero[5]==0){
			if(Confed=="UEFA" && UEFAf<2 && EquipIngresado!=NEQ) { UEFAf++; LlenarGrupoF(Bolillero,NEQ,CEQ); EquipIngresado=NEQ; Tercero[5]++; }
			else if(Confed=="CAF" && CAFf<1 && EquipIngresado!=NEQ) { CAFf++; LlenarGrupoF(Bolillero,NEQ,CEQ); EquipIngresado=NEQ; Tercero[5]++; }
			else if(Confed=="AFC" && AFCf<1 && EquipIngresado!=NEQ) { AFCf++; LlenarGrupoF(Bolillero,NEQ,CEQ); EquipIngresado=NEQ; Tercero[5]++; }
			else if(Confed=="CONCACAF" && CONCACAFf<1 && EquipIngresado!=NEQ) { CONCACAFf++; LlenarGrupoF(Bolillero,NEQ,CEQ); EquipIngresado=NEQ; Tercero[5]++; }
		}
		if(Tercero[6]==0){
			if(Confed=="UEFA" && UEFAg<2 && EquipIngresado!=NEQ) { UEFAg++; LlenarGrupoG(Bolillero,NEQ,CEQ); EquipIngresado=NEQ; Tercero[6]++; }
			else if(Confed=="CAF" && CAFg<1 && EquipIngresado!=NEQ) { CAFg++; LlenarGrupoG(Bolillero,NEQ,CEQ); EquipIngresado=NEQ; Tercero[6]++; }
			else if(Confed=="AFC" && AFCg<1 && EquipIngresado!=NEQ) { AFCg++; LlenarGrupoG(Bolillero,NEQ,CEQ); EquipIngresado=NEQ; Tercero[6]++; }
			else if(Confed=="CONCACAF" && CONCACAFg<1 && EquipIngresado!=NEQ) { CONCACAFg++; LlenarGrupoG(Bolillero,NEQ,CEQ); EquipIngresado=NEQ; Tercero[6]++; }
		}
		if(Tercero[7]==0){
			if(Confed=="UEFA" && UEFAh<2 && EquipIngresado!=NEQ) { UEFAh++; LlenarGrupoH(Bolillero,NEQ,CEQ); EquipIngresado=NEQ; Tercero[7]++; }
			else if(Confed=="CAF" && CAFh<1 && EquipIngresado!=NEQ) { CAFh++; LlenarGrupoH(Bolillero,NEQ,CEQ); EquipIngresado=NEQ; Tercero[7]++; }
			else if(Confed=="AFC" && AFCh<1 && EquipIngresado!=NEQ) { AFCh++; LlenarGrupoH(Bolillero,NEQ,CEQ); EquipIngresado=NEQ; Tercero[7]++; }
			else if(Confed=="CONCACAF" && CONCACAFh<1 && EquipIngresado!=NEQ) { CONCACAFh++; LlenarGrupoH(Bolillero,NEQ,CEQ); EquipIngresado=NEQ; Tercero[7]++; }
		}
	}
	if(Bolillero==4){
		if(Ultimo[0]==0){
			if(Confed=="UEFA" && UEFAa<2 && EquipIngresado!=NEQ) { UEFAa++; LlenarGrupoA(Bolillero,NEQ,CEQ); EquipIngresado=NEQ; Ultimo[0]++; }
			else if(Confed=="CAF" && CAFa<1 && EquipIngresado!=NEQ) { CAFa++; LlenarGrupoA(Bolillero,NEQ,CEQ); EquipIngresado=NEQ; Ultimo[0]++; }
			else if(Confed=="AFC" && AFCa<1 && EquipIngresado!=NEQ) { AFCa++; LlenarGrupoA(Bolillero,NEQ,CEQ); EquipIngresado=NEQ; Ultimo[0]++; }
			else if(Confed=="CONCACAF" && CONCACAFa<1 && EquipIngresado!=NEQ) { CONCACAFa++; LlenarGrupoA(Bolillero,NEQ,CEQ); EquipIngresado=NEQ; Ultimo[0]++; }
		}
		if(Ultimo[1]==0){
			if(Confed=="UEFA" && UEFAb<2 && EquipIngresado!=NEQ) { UEFAb++; LlenarGrupoB(Bolillero,NEQ,CEQ); EquipIngresado=NEQ; Ultimo[1]++; }
			else if(Confed=="CAF" && CAFb<1 && EquipIngresado!=NEQ) { CAFb++; LlenarGrupoB(Bolillero,NEQ,CEQ); EquipIngresado=NEQ; Ultimo[1]++; }
			else if(Confed=="AFC" && AFCb<1 && EquipIngresado!=NEQ) { AFCb++; LlenarGrupoB(Bolillero,NEQ,CEQ); EquipIngresado=NEQ; Ultimo[1]++; }
			else if(Confed=="CONCACAF" && CONCACAFb<1 && EquipIngresado!=NEQ) { CONCACAFb++; LlenarGrupoB(Bolillero,NEQ,CEQ); EquipIngresado=NEQ; Ultimo[1]++; }
		}
		if(Ultimo[2]==0){
			if(Confed=="UEFA" && UEFAc<2 && EquipIngresado!=NEQ) { UEFAc++; LlenarGrupoC(Bolillero,NEQ,CEQ); EquipIngresado=NEQ; Ultimo[2]++; }
			else if(Confed=="CAF" && CAFc<1 && EquipIngresado!=NEQ) { CAFc++; LlenarGrupoC(Bolillero,NEQ,CEQ); EquipIngresado=NEQ; Ultimo[2]++; }
			else if(Confed=="AFC" && AFCc<1 && EquipIngresado!=NEQ) { AFCc++; LlenarGrupoC(Bolillero,NEQ,CEQ); EquipIngresado=NEQ; Ultimo[2]++; }
			else if(Confed=="CONCACAF" && CONCACAFc<1 && EquipIngresado!=NEQ) { CONCACAFc++; LlenarGrupoC(Bolillero,NEQ,CEQ); EquipIngresado=NEQ; Ultimo[2]++; }
		}
		if(Ultimo[3]==0){
			if(Confed=="UEFA" && UEFAd<2 && EquipIngresado!=NEQ) { UEFAd++; LlenarGrupoD(Bolillero,NEQ,CEQ); EquipIngresado=NEQ; Ultimo[3]++; }
			else if(Confed=="CAF" && CAFd<1 && EquipIngresado!=NEQ) { CAFd++; LlenarGrupoD(Bolillero,NEQ,CEQ); EquipIngresado=NEQ; Ultimo[3]++; }
			else if(Confed=="AFC" && AFCd<1 && EquipIngresado!=NEQ) { AFCd++; LlenarGrupoD(Bolillero,NEQ,CEQ); EquipIngresado=NEQ; Ultimo[3]++; }
			else if(Confed=="CONCACAF" && CONCACAFd<1 && EquipIngresado!=NEQ) { CONCACAFd++; LlenarGrupoD(Bolillero,NEQ,CEQ); EquipIngresado=NEQ; Ultimo[3]++; }
		}
		if(Ultimo[4]==0){
			if(Confed=="UEFA" && UEFAe<2 && EquipIngresado!=NEQ) { UEFAe++; LlenarGrupoE(Bolillero,NEQ,CEQ); EquipIngresado=NEQ; Ultimo[4]++; }
			else if(Confed=="CAF" && CAFe<1 && EquipIngresado!=NEQ) { CAFe++; LlenarGrupoE(Bolillero,NEQ,CEQ); EquipIngresado=NEQ; Ultimo[4]++; }
			else if(Confed=="AFC" && AFCe<1 && EquipIngresado!=NEQ) { AFCe++; LlenarGrupoE(Bolillero,NEQ,CEQ); EquipIngresado=NEQ; Ultimo[4]++; }
			else if(Confed=="CONCACAF" && CONCACAFe<1 && EquipIngresado!=NEQ) { CONCACAFe++; LlenarGrupoE(Bolillero,NEQ,CEQ); EquipIngresado=NEQ; Ultimo[4]++; }
		}
		if(Ultimo[5]==0){
			if(Confed=="UEFA" && UEFAf<2 && EquipIngresado!=NEQ) { UEFAf++; LlenarGrupoF(Bolillero,NEQ,CEQ); EquipIngresado=NEQ; Ultimo[5]++; }
			else if(Confed=="CAF" && CAFf<1 && EquipIngresado!=NEQ) { CAFf++; LlenarGrupoF(Bolillero,NEQ,CEQ); EquipIngresado=NEQ; Ultimo[5]++; }
			else if(Confed=="AFC" && AFCf<1 && EquipIngresado!=NEQ) { AFCf++; LlenarGrupoF(Bolillero,NEQ,CEQ); EquipIngresado=NEQ; Ultimo[5]++; }
			else if(Confed=="CONCACAF" && CONCACAFf<1 && EquipIngresado!=NEQ) { CONCACAFf++; LlenarGrupoF(Bolillero,NEQ,CEQ); EquipIngresado=NEQ; Ultimo[5]++; }
		}
		if(Ultimo[6]==0){
			if(Confed=="UEFA" && UEFAg<2 && EquipIngresado!=NEQ) { UEFAg++; LlenarGrupoG(Bolillero,NEQ,CEQ); EquipIngresado=NEQ; Ultimo[6]++; }
			else if(Confed=="CAF" && CAFg<1 && EquipIngresado!=NEQ) { CAFg++; LlenarGrupoG(Bolillero,NEQ,CEQ); EquipIngresado=NEQ; Ultimo[6]++; }
			else if(Confed=="AFC" && AFCg<1 && EquipIngresado!=NEQ) { AFCg++; LlenarGrupoG(Bolillero,NEQ,CEQ); EquipIngresado=NEQ; Ultimo[6]++; }
			else if(Confed=="CONCACAF" && CONCACAFg<1 && EquipIngresado!=NEQ) { CONCACAFg++; LlenarGrupoG(Bolillero,NEQ,CEQ); EquipIngresado=NEQ; Ultimo[6]++; }
		}
		if(Ultimo[7]==0){
			if(Confed=="UEFA" && UEFAh<2 && EquipIngresado!=NEQ) { UEFAh++; LlenarGrupoH(Bolillero,NEQ,CEQ); EquipIngresado=NEQ; Ultimo[7]++; }
			else if(Confed=="CAF" && CAFh<1 && EquipIngresado!=NEQ) { CAFh++; LlenarGrupoH(Bolillero,NEQ,CEQ); EquipIngresado=NEQ; Ultimo[7]++; }
			else if(Confed=="AFC" && AFCh<1 && EquipIngresado!=NEQ) { AFCh++; LlenarGrupoH(Bolillero,NEQ,CEQ); EquipIngresado=NEQ; Ultimo[7]++; }
			else if(Confed=="CONCACAF" && CONCACAFh<1 && EquipIngresado!=NEQ) { CONCACAFh++; LlenarGrupoH(Bolillero,NEQ,CEQ); EquipIngresado=NEQ; Ultimo[7]++; }
		}
	}
}

void LlenarGrupoA(int Bolillero, char NEQ[20], char CEQ[10]){
	Sorteo GA;
	FILE* GRPA = fopen("GrupoA.txt","ab+");
	GA.Bolillero = Bolillero;
	strcpy(GA.NEquipo,NEQ);
	strcpy(GA.Confederacion,CEQ);
	fwrite(&GA,sizeof(GA),1,GRPA);
	printf("*%s ira al Grupo A...\n", GA.NEquipo);
}

void LlenarGrupoB(int Bolillero, char NEQ[20], char CEQ[10]){
	Sorteo GA;
	FILE* GRPA = fopen("GrupoB.txt","ab+");
	GA.Bolillero = Bolillero;
	strcpy(GA.NEquipo,NEQ);
	strcpy(GA.Confederacion,CEQ);
	fwrite(&GA,sizeof(GA),1,GRPA);
	printf("*%s ira al Grupo B...\n", GA.NEquipo);
}

void LlenarGrupoC(int Bolillero, char NEQ[20], char CEQ[10]){
	Sorteo GA;
	FILE* GRPA = fopen("GrupoC.txt","ab+");
	GA.Bolillero = Bolillero;
	strcpy(GA.NEquipo,NEQ);
	strcpy(GA.Confederacion,CEQ);
	fwrite(&GA,sizeof(GA),1,GRPA);
	printf("*%s ira al Grupo C...\n", GA.NEquipo);
}

void LlenarGrupoD(int Bolillero, char NEQ[20], char CEQ[10]){
	Sorteo GA;
	FILE* GRPA = fopen("GrupoD.txt","ab+");
	GA.Bolillero = Bolillero;
	strcpy(GA.NEquipo,NEQ);
	strcpy(GA.Confederacion,CEQ);
	fwrite(&GA,sizeof(GA),1,GRPA);
	printf("*%s ira al Grupo D...\n", GA.NEquipo);
}

void LlenarGrupoE(int Bolillero, char NEQ[20], char CEQ[10]){
	Sorteo GA;
	FILE* GRPA = fopen("GrupoE.txt","ab+");
	GA.Bolillero = Bolillero;
	strcpy(GA.NEquipo,NEQ);
	strcpy(GA.Confederacion,CEQ);
	fwrite(&GA,sizeof(GA),1,GRPA);
	printf("*%s ira al Grupo E...\n", GA.NEquipo);
}

void LlenarGrupoF(int Bolillero, char NEQ[20], char CEQ[10]){
	Sorteo GA;
	FILE* GRPA = fopen("GrupoF.txt","ab+");
	GA.Bolillero = Bolillero;
	strcpy(GA.NEquipo,NEQ);
	strcpy(GA.Confederacion,CEQ);
	fwrite(&GA,sizeof(GA),1,GRPA);
	printf("*%s ira al Grupo F...\n", GA.NEquipo);
}

void LlenarGrupoG(int Bolillero, char NEQ[20], char CEQ[10]){
	Sorteo GA;
	FILE* GRPA = fopen("GrupoG.txt","ab+");
	GA.Bolillero = Bolillero;
	strcpy(GA.NEquipo,NEQ);
	strcpy(GA.Confederacion,CEQ);
	fwrite(&GA,sizeof(GA),1,GRPA);
	printf("*%s ira al Grupo G...\n", GA.NEquipo);
}

void LlenarGrupoH(int Bolillero, char NEQ[20], char CEQ[10]){
	Sorteo GA;
	FILE* GRPA = fopen("GrupoH.txt","ab+");
	GA.Bolillero = Bolillero;
	strcpy(GA.NEquipo,NEQ);
	strcpy(GA.Confederacion,CEQ);
	fwrite(&GA,sizeof(GA),1,GRPA);
	printf("*%s ira al Grupo H...\n", GA.NEquipo);
}
