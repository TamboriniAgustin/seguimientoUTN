#include <iostream>
using namespace std;

struct GranPremio{
	int clasificacion;
	int puesto;
	char piloto[20];
	char escuderia[20];
	bool abandono;
	char motivo[10];
};

void OrdenarxMinimos(int vec[]);
void OrdenarxBurbuja(int vec[]);
void OrdenarxBurbujaOptimizado(int vec[]);
void BusquedaBinariaV(int vec[],int dato);
void BusquedaBinariaA(int dato);
void CorteControl();

int main(){
	int opcion;
	int vec[12] = {76,42,890,45,12,55,1,56,9,76,567,134};
	printf("Seleccione que desea utilizar: \n\t1_Ordenamiento por minimos\n\t2_Ordenamiento por burbuja\n\t3_Ordenamiento por burbuja optimizado\n\t4_Busqueda binaria en vector\n\t5_Busqueda binaria en archivo\n\t6_Corte Control\n");
	cin >> opcion;
	if(opcion==1) OrdenarxMinimos(vec);
	else if(opcion==2) OrdenarxBurbuja(vec);
	else if(opcion==3) OrdenarxBurbujaOptimizado(vec);
	else if(opcion==4) BusquedaBinariaV(vec,444);
	else if(opcion==5) BusquedaBinariaA(18);
	else if(opcion==6) CorteControl();
	return 0;
}

void OrdenarxMinimos(int vec[]){
	int min=0, minpos=0, aux=0;
	for(int pos=0;pos<=11;pos++){
		min = vec[pos];
		minpos = pos;
		for(int i=pos;i<=11;i++){
			if(vec[i]<min){
				min = vec[i];
				minpos = i;
			}
		}
		aux = vec[pos];
		vec[pos] = vec[minpos];
		vec[minpos] = aux;
	}
	for(int i=0;i<12;i++){
		printf("\n* %d *\n",vec[i]);
	}
}

void OrdenarxBurbuja(int vec[]){
	int aux=0;
	for(int pos=0;pos<=11;pos++){
		for(int i=0;i<=11-pos;i++){
			if(vec[i]>vec[i+1]){
				aux = vec[i];
				vec[i] = vec[i+1];
				vec[i+1] = aux;
			}
		}
	}
	for(int i=0;i<12;i++){
		printf("\n* %d *\n",vec[i]);
	}
}

void OrdenarxBurbujaOptimizado(int vec[]){
	int pos=0, aux=0;
	bool ordenado;
	do{
		ordenado=true;
		for(int i=pos;i<5-pos;i++){
			if(vec[i]>vec[i+1]){
				aux = vec[i];
				vec[i] = vec[i+1];
				vec[i+1] = aux;
				ordenado=false;
			}
			pos++;
		}
	}
	while(!ordenado);
	for(int i=0;i<12;i++){
		printf("\n* %d *\n",vec[i]);
	}
}

void BusquedaBinariaV(int vec[],int dato){
	int aux=0, px=0;
	for(int pos=0;pos<=11;pos++){
		for(int i=0;i<=11-pos;i++){
			if(vec[i]>vec[i+1]){
				aux = vec[i];
				vec[i] = vec[i+1];
				vec[i+1] = aux;
			}
		}
	}
	int inicio = 0;
	int final = 11;
	int medio = (inicio+final)/2;
	while(inicio<=final && vec[medio]!=dato){
		if(vec[medio]>dato) final = medio-1;
		else inicio = medio+1;
		medio = (inicio+final)/2;
	}
	if(inicio>final) px=-1; //No se encontro el elemento
	else px=medio; // Si se encontro
	printf("El elemento %d esta en la posicion %d",dato,px);
}

void BusquedaBinariaA(int dato){
	GranPremio GP;
	FILE* F = fopen("PracticaArch","rb");
	/*TAMAÑO DEL ARCHIVO*/
	fseek(F,0,SEEK_SET);
	long TI = ftell(F);
	fseek(F,0,SEEK_END);
	long TF = ftell(F);
	fseek(F,0,SEEK_SET);
	long T = TF/sizeof(GP);
	/*BUSQUEDA BINARIA*/
	int pos = -1;
	int inicio = 0;
	int final = T;
	int medio = (inicio+final)/2;
	while(inicio<=final && pos==-1){
		fseek(F,sizeof(GP)*(medio-1),SEEK_SET);
		fread(&GP,sizeof(GP),1,F);
		if(dato==GP.puesto) pos = medio;
		else if(dato>GP.puesto) inicio = medio+1;
		else if(dato<GP.puesto) final = medio-1;
		medio = (inicio+final)/2;
	}
	fclose(F);
	printf("El elemento %d esta en la posicion %d",dato,pos);
}

void CorteControl(){
	GranPremio GP;
	int anterior=0;
	FILE* F = fopen("PruebaArch2","rb");
	fread(&GP,sizeof(GP),1,F);
	while(!feof(F)){
		anterior = GP.clasificacion; //clasificacion es la clave de identificacion en este caso
		while(!feof(F) && anterior==GP.clasificacion){
			//acciones
			fread(&GP,sizeof(GP),1,F);
		}
	}
	fclose(F);
}
