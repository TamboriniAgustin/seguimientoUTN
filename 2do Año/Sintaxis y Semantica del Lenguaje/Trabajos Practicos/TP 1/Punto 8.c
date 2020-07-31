#include <stdio.h>

void introduccion();
void automata(int [][2], char []);
int averiguarColumna(char);

int main(){
	/*Genero la matriz del automata*/
	int tablaTransicion[27][2] = {
		{1, 4}, //Estado 125 (Inicial) - 0
		{2, 5}, //Estado 120 - 1
		{3, 6}, //Estado 115 - 2
		{4, 7}, //Estado 110 - 3
        {5, 8}, //Estado 105 - 4
        {6, 9}, //Estado 100 - 5
		{7, 10}, //Estado 95 - 6
		{8, 11}, //Estado 90 - 7
		{9, 12}, //Estado 85 - 8
        {10, 13}, //Estado 80 - 9
        {11, 14}, //Estado 75 - 10
		{12, 15}, //Estado 70 - 11
		{13, 16}, //Estado 65 - 12
		{14, 17}, //Estado 60 - 13
        {15, 18}, //Estado 55 - 14
        {16, 19}, //Estado 50 - 15
		{17, 20}, //Estado 45 - 16
		{18, 21}, //Estado 40 - 17
		{19, 22}, //Estado 35 - 18
        {20, 23}, //Estado 30 - 19
        {21, 24}, //Estado 25 - 20
		{22, 25}, //Estado 20 - 21
		{23, 26}, //Estado 15 - 22
		{24, 26}, //Estado 10 - 23
        {25, 26}, //Estado 5 - 24
        {26, 26}, //Estado 0 (Final) - 25
        {26, 26} //Estado 1000 (Rechazo) - 26
	};

    introduccion();

    system("cls");
    /*Ingreso la palabra que pasara por el automata*/
    char cadena[100];
	printf("Ingrese la combinacion de monedas que desee (Solo mayusculas): ");
	scanf("%s", cadena);

	automata(tablaTransicion, cadena);

    system("pause");
	return 0;
}

void introduccion(){
    printf("********** Maquina de Refrescos **********\n");
    printf("El automata reconocera solamente monedas de 5 y 20 centavos\n");
    printf("Las mismas estaran representadas por los caracteres 'C' de Cinco y 'V' de Veinte\n\n");
    system("pause");
}

void automata(int tabla[][2], char palabra[]){
    int estado = 0;
    int contador = 0;
    while(palabra[contador]!=0 && estado!=26){
        estado = tabla[estado][averiguarColumna(palabra[contador])]; //Averiguamos dependiendo el caracter de la palabra a que columna se dirige en la Tabla de Transicion
        contador++;
    }
    //Averiguo cual fue el ultimo estado y asigno si cumple con que este sea un estado final o no//
    if(estado!=25) printf("\nLa combinacion '%s' no es exactamente 125, por lo que sus monedas seran devueltas.\n\n", palabra);
    else printf("\nLa combinacion '%s' es exactamente 125, disfrute su bebida!\n\n", palabra);
}

int averiguarColumna(char caracter){
    if(caracter == 'C') return 0; //Si vale C, entonces utilizamos la primera columna de la matriz
	return 1; //En cualquier otro caso (osea que valga V), utilizamos la segunda columna de la matriz
}