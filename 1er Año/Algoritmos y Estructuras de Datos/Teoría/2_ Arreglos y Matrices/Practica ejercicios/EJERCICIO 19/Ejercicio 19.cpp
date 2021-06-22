#include <iostream>
using namespace std;

int main(){
	int MATRIZA[30][20], M, N, tobj = 0;
	float prom;
	printf("Introduzca un valor M menor a 30: ");
	cin >> M;
	if(M>30 || M<0){
		for(int i=0;i<1;){
			printf("\nERROR! Valor menor a 30 y mayor que 0 por favor!\n");
			cin >> M;
			if(M<30 && M>0){ i++; }
		}
	}
	system("cls");
	printf("Introduzca un valor N menor a 20: ");
	cin >> N;
	if(N>20 || N<0){
		for(int i=0;i<1;){
			printf("\nERROR! Valor menor a 20 y mayor que 0 por favor!\n");
			cin >> N;
			if(N<20 && N>0){ i++; }
		}
	}
	system("cls");
	for(int i=0;i<M;i++){ //Fila
		for(int j=0;j<N;j++){ //Columna
			printf("Ingrese los valores por fila y columna de cada parte del vector: ");
			cin >> MATRIZA[i][j];
		}
		system("cls");
	}
	for(int i=0;i<M;i++){
		for(int j=0;j<N;j++){
			printf("Valor de la columna %d de la fila %d: %d\n",j,i,MATRIZA[i][j]); //PUNTO A
			prom+=MATRIZA[i][j];
			tobj++;
		}
		printf("\n\n");
	}
	prom=prom/tobj;
	printf("El promedio de todos los valores de la matriz es de: %f\n\n",prom); //PUNTO B
	int VECSUMCOL[30][20] = { {0},{0} };
	for(int i=0;i<M;i++){
		for(int j=0;j<N;j++){
			printf("Ingrese un valor para la fila %d y columna %d: ",i,j);
			cin >> VECSUMCOL[i][j];
			VECSUMCOL[i][j]+=MATRIZA[i][j];
			printf("Valor de la columna %d de la fila %d sumada con la homologa de MATRIZA: %d\n",j,i,VECSUMCOL[i][j]); //PUNTO C
		}
		printf("\n\n");
	}
	int VECMAXFIL[30] = {0}, mayorfila=0;
	for(int i=0;i<M;i++){
		for(int j=0;j<N;j++){
			if(mayorfila<=MATRIZA[i][j]) mayorfila=MATRIZA[i][j];
		}
		VECMAXFIL[i] = mayorfila;
		mayorfila = 0;
		printf("*** El mayor valor de la fila %d fue %d ***\n",i,VECMAXFIL[i]); //PUNTO D
	}
	return 0;
}
