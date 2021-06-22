%{
#include <stdio.h>
#define LONGITUD_MAXIMA_DE_VARIABLE 32

/*
    El elemento yyin debe declararse como extern pues el mismo esta declarado inicialmente en el programa YACC y de lo contrario
    obtendríamos un error porque estaríamos redefiniendo el elemento.
*/
extern FILE *yyin;
void yyerror(const char *str);

int validarLongitudID(char* string);
int identificadorValido(char* id);
int longitudCadena(char* string);
int yywrap();
%}

//Estos son los TOKENS que utilizaremos en la gramática
//Identificador 
%union {char* identificador;}
%token <identificador> IDENTIFICADOR
//Palabras Reservadas
%token PR_INICIO PR_FIN PR_LEER PR_ESCRIBIR
//Operadores
%token OP_ASIGNACION OP_SUMA OP_RESTA
//Constantes
%token CONSTANTE

// Esta es la gramática que reconocerá el compilador
%%

programa: PR_INICIO listaSentencias PR_FIN {printf("La compilacion ha sido exitosa!\n");};

listaSentencias: sentencia listaSentencias | sentencia ;

sentencia: IDENTIFICADOR OP_ASIGNACION expresion ';' {if(validarLongitudID($1) == 0) YYABORT;}
| PR_LEER '(' listaIdentificadores ')' ';' 
| PR_ESCRIBIR '(' listaExpresiones ')' ';' ;

listaIdentificadores: IDENTIFICADOR 
| IDENTIFICADOR ',' listaIdentificadores {if(validarLongitudID($1) == 0) YYABORT;};

listaExpresiones: expresion 
| expresion ',' listaExpresiones ;

expresion: expresionPrimaria 
| expresionPrimaria OP_SUMA expresion 
| expresionPrimaria OP_RESTA expresion ;

expresionPrimaria: IDENTIFICADOR {if(validarLongitudID($1) == 0) YYABORT;};
| CONSTANTE
| '(' expresion ')' ;
            
%%

//Código de C
int validarLongitudID(char* identificador){
    int longitudID = longitudCadena(identificador);
    if(longitudID > LONGITUD_MAXIMA_DE_VARIABLE){
        printf("[Error Semantico] La variable supera el máximo de caracteres permitidos (32 caracteres)");
        free(identificador); //Liberamos la memoria almacenada en STRDUP 
        return 0;
    }
    free(identificador); //Liberamos la memoria almacenada en STRDUP
    return 1;
}

int longitudCadena(char* string){
    int longitud = 0;
    while(string[longitud]) longitud++;
    return longitud;
}

void yyerror(const char *error){
        fprintf(stderr,"[Error de Compilacion]: La ejecucion del programa ha sido rechazada (Motivo: %s)\n",error);
}
 
int yywrap(){
        return 1;
} 

int main(int argc, char* argv[]) {
    //Permitimos que se puedan leer archivos completos
    if (argc == 2){
    	FILE *codigo = fopen(argv[1], "r"); //Establecemos solo lectura
    	
    	if (!codigo) {
    		printf("El archivo ingresado es inexistente %s.\n", argv[1]);
    		return -1;
    	}
    	
    	yyin = codigo;
    }
    yyparse();
    return 0;
}