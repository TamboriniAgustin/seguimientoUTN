#include <cstdlib>
#include <iostream>
#include <cstring>
#include <string>

using namespace std;

int main() {

	string Nom, Ape;
	const char* filePath = "d:\\ficheroTexto.txt";

	FILE *f = fopen(filePath, "w");

	if (f == NULL) {
    	printf("Error al abrir el Archivo!\n");
    	return EXIT_FAILURE;
	}

	cout << "Ingrese Nombre (punto para cortar): ";
	cin >> Nom;

	while (Nom != ".") {
  		cout << "Ingrese Apellido: ";
  		cin >> Ape;
  
  		const char *text = (Nom + " " + Ape).c_str();
  		//fprintf(f, "%s", text); OPCION 1
  		//fputs(text, f); OPCION 2
  		fwrite(text , 1 , strlen(text) , f );
  		fwrite("\n", sizeof(char), 1, f);
  
  		cout << "Ingrese Nombre (punto para cortar): ";
  		cin >> Nom;
	}

	fclose(f);

	f = fopen(filePath, "r");

	const int MAX_CHARS = 256;

	char line[MAX_CHARS];

	while (fgets(line, sizeof(line), f)) {
    	//printf("%s", line); OPCION 1
    	//puts(line); OPCION 2
    	cout << line;
	}

	fclose(f);

	system("PAUSE");
	return EXIT_SUCCESS;

}
