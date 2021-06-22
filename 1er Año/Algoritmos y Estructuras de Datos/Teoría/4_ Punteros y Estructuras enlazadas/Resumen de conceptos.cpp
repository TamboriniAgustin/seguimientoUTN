/* PUNTEROS */
*Para definir un puntero que referencie a una variable:
	int a = 10; 	//Variable a con valor 10.
	int *p;			//Un puntero de referencia a los enteros.
	
*Valores que puede tomar *p:
	p = &a;			//Toma la direccion de memoria de la variable a. Para imprimir el valor que hay en la misma debe utilizarse *p.
	p = null;		//Toma un valor nulo, no apunta a ninguna otra variable.
	p = new int;	//Crea un nuevo espacio de memoria en tiempo de ejecucion. *p es el acceso a la informacion en esa posicion de memoria.
	
	*Utilizacion con registros:
		struct nombrereg{
			campo1
			campo2
			......
		};	

		nombrereg *p; 		//Se crea un puntero del tipo registro
		p = &variable; 		//Se asigna al puntero p la direccion de una variable donde se almacene un dato de registro.
		p = new nombrereg;	//Crea un nuevo espacio de memoria en tiempo de ejecucion. *p es el acceso a la informacion en esa posicion de memoria.
		*pr.campo1			//Muestra el valor de campo1 del registro almacenado en el puntero.
		pr->campo1			//Muestra el valor de campo1 del registro almacenado en el puntero (otra forma).
	
	*Utilizacion entre 2 punteros:
		int *p;
		int *q;
		p = q;				//Asigna a direccion de p, la direccion de q
		*p = *q;			//Asigna al valor de p, el valor de q
		

*Para borrar un new tipodato; creado anteriormente:
	delete tipodato;
	puntero = null; //Es recomendado tras borrar la direccion de memoria setearlo en null, ya que el valor que tiene no se borra, solo la direccion.
	
*Matrices Dinamicas: 
	-Debera usarse un puntero "**ptr" (puntero-puntero).
	-Para reservar memoria para las filas de la matriz se realizara: 
			ptr = new tipo*[valorF];
			for(int i=0;i<valorF;i++){
				ptr[i] = new tipo*[valorC];
			}
	-Para insertar elementos realizamos el for y realizamos la siguiente sintaxis en el cin: *(*(ptr+i)+j); = ptr[i][j];
	-Para liberar memoria se realiza:
			for(int i=0;i<valorF;i++){
				delete [] ptr[i];
			}
			delete [] ptr; 		
	
	
	
	
/* NODOS */
*Un nodo posee dos tipos de datos: la informacion y otro para la direccion del siguiente elemento (del mismo tipo que la informacion actual).

*Definicion de un NODO:
	struct Nodo{
		tipodedato info; //Definimos el tipo de variable que va a tomar como informacion el nodo (int,char,float,double,long,etc).
		Nodo *siguiente; //Definimos un puntero para la siguiente posicion de memoria del mismo tipo de registro.		
	};
	
*Para crear una estructura el primer valor al que apunte el puntero debe tener valor nulo.


/* PILAS */
*Funciona como Last In First Out (el ultimo elemento en entrar es el primero en salir).

*Operaciones de Apilar (insertar un elemento de la pila) y Desapilar (quitar un elemento de la pila).

*Operacion de Insertar (cuando declaro la variable pila hay que igualarla a NULL):
	1_ Crear espacio en memoria para almacenar un nodo.
		Nodo *nuevonodo;
		nuevonodo = new Nodo();
	2_ Cargar un valor en el dato del nodo.
		nuevonodo->info = X;
	3_ Cargar un puntero pila dentro del nodo que apunte al siguiente.
		nuevonodo->siguiente = pila;
	4_ Asignar un nuevo nodo a pila.
		pila = nuevonodo;

*Operacion de Desapilar:
	1_ Crear una variable *auxiliar de tipo Nodo e igualarla a pila.
		Nodo *aux = pila;
	2_ Igualamos el dato a extraer a auxiliar->dato.
		X = aux->info;
	3_ Pasamos pila al siguiente nodo.
		pila = aux->siguiente;
	4_ Eliminar la variable auxiliar.
		delete aux;	

*Para eliminar se debe aplicar while (pila!=NULL) ...


/* COLAS */					
*Funciona como First In First Out (el primero en entrar es el primero en salir).

*Operaciones de Insertar y Extraer.

*Operacion de Insertar (cuando declaro la variable frentecola y la variable fincola hay que igualarlas a NULL):
	1_ Crear espacio en memoria para almacenar un nodo.
		Nodo *nuevonodo = new Nodo();
	2_ Asignar al nuevo nodo el dato que queremos insertar.
		nuevonodo->info = X;
	3_ Asignar punteros de principio y fin hacia el nuevo nodo.
		Si la cola esta vacia: frentecola = nuevonodo;
		Si ya  hay otro elemento en la cola: fincola->sig = nuevonodo; 
		Siempre: fincola = nuevonodo;
		
*Operacion de Eliminar:
	1_ Obtener el valor del nodo que queremos eliminar.
		X = frentecola->info;
	2_ Crear un nodo auxiliar y apuntarlo a frentecola.
		Nodo *aux = frentecola;
	3_ Eliminar el nodo de frentecola.
		Si solo hay un nodo en la cola: frentecola=NULL; fincola=NULL;
		Si hay mas nodos en la cola: frente=frente->sig;
		Siempre: delete aux;
		
*Para eliminar se debe aplicar while (frentecola!=NULL) ...	


/* LISTAS */
*Funciona como First In First Out (primero en entrar es el primero en salir).

*Operaciones de Insertar,Eliminar uno,Eliminar todos,Lectura.

*Operacion de Insertar Elementos (debemos declarar una variable lista de tipo nodo e inicializarla en NULL):
	1_ Crear espacio en memoria para almacenar un nuevo nodo.
		Nodo *nuevonodo = new Nodo();
	2_ Asignar a este nuevo nodo el dato que deseamos añadir.
		nuevonodo->info = X;
	3_ Crear 2 nodos auxiliares, al primero igualarlo a lista.
		Nodo *aux1 = lista;
		Nodo *aux2;
	4_ Insertar el elemento a la lista.
		Si la lista esta vacia: lista = nuevonodo;
		Si la lista tiene algun elemento: aux2->sig = nuevonodo;
		Para mantener la lista ordenada (encima de los IFS):
			while((aux1!=NULL) && (aux1->info)<X){
				aux2 = aux1;
				aux1 = aux1->sig;
			}
		Siempre: nuevonodo->sig = aux1;
		
*Operacion de Mostrar Elementos:
	1_ Crear espacio en memoria para almacenar un nuevo nodo.
		Nodo *nuevonodo = new Nodo();
	2_ Igualar el nodo a lista.
		nuevonodo = lista;
	3_ Recorrer la lista de inicio a fin.
		while(nuevonodo!=NULL){
			cout << nuevonodo->info;
			nuevonodo = nuevonodo->sig;
		}
		
*Operacion de Buscar un Elemento:
	1_ Crear espacio en memoria para almacenar un nuevo nodo.
		Nodo *nuevonodo = new Nodo();
	2_ Igualar el nuevo nodo a lista.
		nuevonodo = lista;
	3_ Recorrer la lista.
		while((nuevonodo!=NULL) && (nuevonodo->info < dato)){
			nuevonodo = nuevonodo->sig;
		}
	4_ Determinar si existe o no el elemento.
		Dentro del while...{
			if(nuevonodo->info==dato) ...
		}

*Operacion de Eliminar un Elemento:
	1_ Verificar que la lista no este vacia.
		if(lista!=NULL){
			...
		}
	2_ Crear 2 nodos auxiliares e igualar a NULL 1 de ellos.
		Nodo *auxBorrar;
		Nodo *auxAnterior = NULL;
	3_ Igualar al otro nodo auxiliar al inicio de la lista.
		auxBorrar = lista;
	4_ Recorrer la lista.
		while((auxBorrar!=NULL) && (auxBorrar->info!=dato)){
			auxAnterior = auxBorrar;
			auxBorrar = auxBorrar->sig;
		}
	5_ Si encuentra el elemento, eliminar el elemento.
		Si el elemento no esta en la lista:
			if(auxBorrar==NULL){
				cout << ... ;
			}
		Si el elemento a eliminar es el primero en la lista:
			if(auxAnterior==NULL){
				lista = lista->sig;
				delete auxBorrar;
			}
		Si no es el primer elemento de la lista:
			else{
				auxAnterior->sig = auxBorrar->sig;
				delete auxBorrar;
			}

*Operacion para eliminar todos los elementos de la lista:
	1_ Crear un nuevo nodo auxiliar e igualarlo al inicio de lista.
		Nodo *aux = lista;
	2_ Almacenar el nuevo nodo en el dato a eliminar.
		X = aux->info;
	3_ Pasar lista a siguiente nodo.
		lista = aux->sig;
	4_ Eliminar auxiliar.
		delete aux;
					 
		
					
	
	
	
	
