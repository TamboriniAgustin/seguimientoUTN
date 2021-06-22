%{

#include <string.h>
#include "micro.tab.h"

%}

LETRA [a-zA-Z]
DIGITO  [0-9]

CONSTANTE {DIGITO}({DIGITO})*
PALABRA_RESERVADA (inicio|fin|leer|escribir)

OPERADOR_ASIGNACION  :=

%%

[(),;] return yytext[0];

inicio return PR_INICIO;
fin return PR_FIN;
leer return PR_LEER;
escribir return PR_ESCRIBIR;

{LETRA}({LETRA}|{DIGITO})* {
    yylval.identificador = strdup(yytext);
    return IDENTIFICADOR;
}

{CONSTANTE} return CONSTANTE;

"+" return OP_SUMA;
"-" return OP_RESTA;
{OPERADOR_ASIGNACION} return OP_ASIGNACION;
[ \t\n]+ /* Ignoramos los espacios en blanco y los saltos de linea */;

%%