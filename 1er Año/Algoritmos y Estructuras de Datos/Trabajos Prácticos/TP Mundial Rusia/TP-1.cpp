#include <iostream>
using namespace std;

void criteriosClasificacion(int *, int *);
void ingresarEquipos(string *, string *, string *, string *);
void nombreEquipo(int id,string *, string *, string *, string *);
void partidoEmpatado(int ,int *, int *, int *, int *,int *, int *, int *, int *);
void partidoGanado(int ,int *, int *, int *, int *,int *, int *, int *, int *);
int DifGoles(int glsFav, int glsEnc); //Funcion para calcular la diferencia de gol

int main(int argc, char** argv)
{
	bool inicial=true;
	string idE1,idE2,idE3,idE4;//Variables donde se almacena codigo de equipo.
	int local,visita,glsLocal=0,glsVisita=0;//Variables utilizada para comparar lo resultados de los partidos
	int ptsE1=0, ptsE2=0, ptsE3=0, ptsE4=0;//Variables donde se almacenan los puntos de cada equipo.
	int glsE1=0, glsE2=0, glsE3=0, glsE4=0;//Variables donde se almacenan los goles de cada equipo.
	int primero, segundo; //Variables donde se almacenan el primer y segundo lugar.
	int dif1=0, dif2=0, dif3=0, dif4=0; //Variable donde se almacena los goles que recibe en contra cada equipo
	int crterio1, crterio2;
	criteriosClasificacion(&crterio1, &crterio2);
	ingresarEquipos(&idE1, &idE2, &idE3, &idE4);
	for(int i=1;i<=6;i++) //CAMBIAR EL <=6 SI LO QUIEREN USAR PARA TESTEAR MAS RAPIDO
	{
		cout<<"\n******Partido "<<i<<"******"<<endl;
		cout<<"Equipo: ";
		cin>>local;
		cout<<"Equipo: ";
		cin>>visita;
		if(visita==local)
		{
			for(int i=0;i<10;)
			{
				cout << "ERROR! UN EQUIPO NO PUEDE JUGAR CONTRA SI MISMO!\n INGRESALO NUEVAMENTE: ";
				cin >> visita;
				if(visita!=local && visita >=1 && visita<=4) i=10;
			}
		}
		cout<<"---------------------\n";
		nombreEquipo(local, &idE1, &idE2, &idE3, &idE4);
		cin>>glsLocal;
		if(local==1) glsE1=glsE1+glsLocal; //Suma la cantidad de goles para cada equipo
		else if(local==2) glsE2=glsE2+glsLocal;
		else if(local==3) glsE3=glsE3+glsLocal;
		else if(local==4) glsE4=glsE4+glsLocal;
		nombreEquipo(visita, &idE1, &idE2, &idE3, &idE4);
		cin>>glsVisita;
		if(visita==1) glsE1=glsE1+glsVisita;
		else if(visita==2) glsE2=glsE2+glsVisita;
		else if(visita==3) glsE3=glsE3+glsVisita;
		else if(visita==4) glsE4=glsE4+glsLocal; //Termina la suma de goles
		if(local==1) dif1=dif1+glsVisita; //Almacena goles que recibio el equipo local
		else if(local==2) dif2=dif2+glsVisita;
		else if(local==3) dif3=dif3+glsVisita;
		else if(local==4) dif4=dif4+glsLocal;
		if(visita==1) dif1=dif1+glsLocal;
		else if(visita==2) dif2=dif2+glsLocal;
		else if(visita==3) dif3=dif3+glsLocal;
		else if(visita==4) dif4=dif4+glsLocal; //Fin de almacenamiento
		if(glsLocal==glsVisita)
		{
			partidoEmpatado(local, &ptsE1, &ptsE2, &ptsE3, &ptsE4, &glsE1, &glsE2, &glsE3, &glsE4);
			partidoEmpatado(visita, &ptsE1, &ptsE2, &ptsE3, &ptsE4, &glsE1, &glsE2, &glsE3, &glsE4);
		}
		else
		{
			if(glsLocal>glsVisita) partidoGanado(local, &ptsE1, &ptsE2, &ptsE3, &ptsE4, &glsE1, &glsE2, &glsE3, &glsE4);
			else partidoGanado(visita,  &ptsE1, &ptsE2, &ptsE3, &ptsE4, &glsE1, &glsE2, &glsE3, &glsE4);
		}
	}
	int difG1 = DifGoles(glsE1,dif1);
	int difG2 = DifGoles(glsE2,dif2);
	int difG3 = DifGoles(glsE3,dif3);
	int difG4 = DifGoles(glsE4,dif4);
	nombreEquipo(1, &idE1, &idE2, &idE3, &idE4);
	cout<<ptsE1<<"pts.\t"<< "Goles: "<<glsE1<<"\tDif. de gol: "<<difG1<<endl;
	nombreEquipo(2, &idE1, &idE2, &idE3, &idE4);
	cout<<ptsE2<<"pts.\t"<< "Goles: "<<glsE2<<"\tDif. de gol: "<<difG2<<endl;
	nombreEquipo(3, &idE1, &idE2, &idE3, &idE4);
	cout<<ptsE3<<"pts.\t"<< "Goles: "<<glsE3<<"\tDif. de gol: "<<difG3<<endl;
	nombreEquipo(4, &idE1, &idE2, &idE3, &idE4);
	cout<<ptsE4<<"pts.\t"<< "Goles: "<<glsE4<<"\tDif. de gol: "<<difG4<<endl;
	return 0;
}

DifGoles(int glsFav, int glsEnc)
{
	return glsFav-glsEnc;
}

void criteriosClasificacion(int *x, int *y)
{
	cout<<"Ingrese criterios de clasificacion 3° lugar.\n";
	cout<<"Cantidad de puntos: ";
	cin>>*x;
	cout<<"Cantidad de goles: ";
	cin>>*y; 
}
	
	
void ingresarEquipos(string *E1, string *E2, string *E3, string *E4)
{
	cout<<"\n***********GRUPO F***********\n";
	cout<<"Equipo 1: ";cin>>*E1;
	cout<<"Equipo 2: ";cin>>*E2;
	cout<<"Equipo 3: ";cin>>*E3;
	cout<<"Equipo 4: ";cin>>*E4;
}

void nombreEquipo(int id,string *E1, string *E2, string *E3, string *E4)
{
	switch(id)
	{
		case 1:
			cout<<*E1<<" ";
			break;
		case 2:
			cout<<*E2<<" ";
			break;
		case 3:
			cout<<*E3<<" ";
			break;
		case 4:
			cout<<*E4<<" ";
			break;
	}
}

void partidoEmpatado(int id,int *ptsE1, int *ptsE2, int *ptsE3, int *ptsE4,int *glsE1, int *glsE2, int *glsE3, int *glsE4)
{
	switch(id)
	{
		case 1:
			*ptsE1= *ptsE1+1;
			break;
		case 2:
			*ptsE2= *ptsE2+1;;
			break;
		case 3:
			*ptsE3= *ptsE3+1;;
			break;
		case 4:
			*ptsE4= *ptsE4+1;;
			break;
	}
}

void partidoGanado(int id,int *ptsE1, int *ptsE2, int *ptsE3, int *ptsE4,int *glsE1, int *glsE2, int *glsE3, int *glsE4)
{
	switch(id)
	{
		case 1:
			*ptsE1= *ptsE1+3;
			break;
		case 2:
			*ptsE2= *ptsE2+3;;
			break;
		case 3:
			*ptsE3= *ptsE3+3;;
			break;
		case 4:
			*ptsE4= *ptsE4+3;;
			break;
	}
}

/*
//LOGICA DE CLASIFICACION POR PUNTOS Y GOLES//
	cout<<"---------------------\n";
	
	///Cuando el 1er equipo termina primero///
	
	if(ptsE1>ptsE2 && ptsE1>ptsE3 && ptsE1>ptsE4)
	{
		nombreEquipo(1, &idE1, &idE2, &idE3, &idE4);
		cout << "acabo en el primer puesto y avanza a la siguiente ronda.\n";
		if(ptsE2>ptsE3 && ptsE2>ptsE4) //2DO EQUIPO = 2DO
		{
			nombreEquipo(2, &idE1, &idE2, &idE3, &idE4);
			cout << "acabo en el segundo puesto y avanza a la siguiente ronda.\n";
			if(ptsE3>ptsE4 && ptsE3>crterio1)
			{
				nombreEquipo(3, &idE1, &idE2, &idE3, &idE4);
				cout << "acabo en el tercer puesto y avanza a la siguiente ronda por superar las constantes propuestas.\n";	
			}
			else if(ptsE4>ptsE3 && ptsE4>crterio1)
			{
				nombreEquipo(4, &idE1, &idE2, &idE3, &idE4);
				cout << "acabo en el tercer puesto y avanza a la siguiente ronda por superar las constantes propuestas.\n";	
			}
		}
		else if(ptsE3>ptsE2 && ptsE3>ptsE4) //3ER EQUIPO = 2DO
		{
			nombreEquipo(3, &idE1, &idE2, &idE3, &idE4);
			cout << "acabo en el segundo puesto y avanza a la siguiente ronda.\n";
			if(ptsE2>ptsE4 && ptsE2>crterio1)
			{
				nombreEquipo(2, &idE1, &idE2, &idE3, &idE4);
				cout << "acabo en el tercer puesto y avanza a la siguiente ronda por superar las constantes propuestas.\n";
			}
			else if(ptsE4>ptsE2 && ptsE4>crterio1)
			{
				nombreEquipo(4, &idE1, &idE2, &idE3, &idE4);
				cout << "acabo en el tercer puesto y avanza a la siguiente ronda por superar las constantes propuestas.\n";
			}
		}
		else if(ptsE4>ptsE3 && ptsE4>ptsE2) //4TO EQUIPO = 2DO
		{
			nombreEquipo(4, &idE1, &idE2, &idE3, &idE4);
			cout << "acabo en el segundo puesto y avanza a la siguiente ronda.\n";
			if(ptsE2>ptsE3 && ptsE2>crterio1)
			{
				nombreEquipo(2, &idE1, &idE2, &idE3, &idE4);
				cout << "acabo en el tercer puesto y avanza a la siguiente ronda por superar las constantes propuestas.\n";
			}
			else if(ptsE3>ptsE2 && ptsE3>crterio1)
			{
				nombreEquipo(3, &idE1, &idE2, &idE3, &idE4);
				cout << "acabo en el tercer puesto y avanza a la siguiente ronda por superar las constantes propuestas.\n";
			}
		}
	}
	
	cout<<"---------------------\n";
	
	//----------------------------------------//
*/	
