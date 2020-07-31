#include <iostream>
using namespace std;

int ConversorHora(int hrs)
{
	int hora;
	hora = hrs;
	return hora;
}

int ConversorMinuto(int min)
{
	int minuto;
	minuto = min;
	return minuto;
}

int ConversorSegundo(int seg)
{
	int segundo;
	segundo = seg;
	return seg;
}

int ConversorUniversal(int hrs, int min, int seg)
{
	int hora, minuto, segundo;
	hora = hrs*10000;
	minuto = min*100;
	segundo = seg;
	return hora+minuto+segundo;
}

int main()
{
	int hora[3], tiempo[3];
	cout << "Ingrese la hora del dia que desee: ";
	cin >> hora[0];
	if(hora[0]<00 || hora[0]>23)
	{
		for(int i=1;i<10;)
		{
			cout << "ERROR! EL DIA POSEE UN TOTAL DE 24HRS (FORMATO: 00HRS)\n";
			cin >> hora[0];
			if(hora[0]>=0 && hora[0]<=23) i=10;
		}
	}
	cout << "Ingrese los minutos en el dia que desee: ";
	cin >> hora[1];
	if(hora[1]<00 || hora[1]>60)
	{
		for(int i=1;i<10;)
		{
			cout << "ERROR! LA CANTIDAD DE MINUTOS NO PUEDE SUPERAR A 60\n";
			cin >> hora[1];
			if(hora[1]>=0 && hora[1]<=60) i=10;
		}
	}
	if(hora[1]==60)
	{
		if(hora[1]==23)
		{
			hora[0] = 0;
			hora[1] = 0;
		}
		else
		{
			hora[0] = hora[0]+1;
			hora[1] = 00;
		}
	}
	cout << "Ingrese los segundos del dia que desee: ";
	cin >> hora[2];
	if(hora[2]<00 || hora[2]>60)
	{
		for(int i=1;i<10;)
		{
			cout << "ERROR! LA CANTIDAD DE SEGUNDOS NO PUEDE SUPERAR A 60\n";
			cin >> hora[2];
			if(hora[2]>=0 && hora[2]<=60) i=10;
		}
	}
	if(hora[2]==60)
	{
		if(hora[0]==23)
		{
			if(hora[1]==59)
			{
				hora[0] = 00;
				hora[1] = 00;
				hora[2] = 00;
			}
		}
		else if(hora[1]==59)
		{
			hora[0] = hora[0]+1;
			hora[1] = 00;
			hora[2] = 00;
		}
		if(hora[1]!=23)
		{
			hora[1] = hora[1]+1;
			hora[2] = 00;
		}
	}
	int formatohora = ConversorHora(hora[0]);
	int formatominuto = ConversorMinuto(hora[1]);
	int formatosegundo = ConversorSegundo(hora[2]);
	cout << "----------\nHora en formato HHMMSS = " << formatohora << formatominuto << formatosegundo << "\n----------\n\n\n";
	//TIEMPO AÑADIDO
	cout << "Ingrese las horas de tiempo que tardo en realizar su tarea: ";
	cin >> tiempo[0];
	cout << "Ingrese los minutos de tiempo que tardo en realizar su tarea: ";
	cin >> tiempo[1];
	if(tiempo[1]<00 || tiempo[1]>60)
	{
		for(int i=1;i<10;)
		{
			cout << "ERROR! LA CANTIDAD DE MINUTOS NO PUEDE SUPERAR A 60\n";
			cin >> tiempo[1];
			if(tiempo[1]>=0 && tiempo[1]<=60) i=10;
		}
	}
	if(tiempo[1]==60)
	{
		tiempo[0] = tiempo[0]+1;
		tiempo[1] = 00;
	}
	cout << "Ingrese los segundos del dia que desee: ";
	cin >> tiempo[2];
	if(tiempo[2]<00 || tiempo[2]>60)
	{
		for(int i=1;i<10;)
		{
			cout << "ERROR! LA CANTIDAD DE SEGUNDOS NO PUEDE SUPERAR A 60\n";
			cin >> tiempo[2];
			if(tiempo[2]>=0 && tiempo[2]<=60) i=10;
		}
	}
	if(tiempo[2]==60)
	{
		if(tiempo[1]==59)
		{
			tiempo[0] = tiempo[0]+1;
			tiempo[1] = 00;
			tiempo[2] = 00;
		}
		else
		{
			tiempo[1] = tiempo[1]+1;
			tiempo[2] = 00;
		}
	}
	int formatoThora = ConversorHora(tiempo[0]);
	int formatoTminuto = ConversorMinuto(tiempo[1]);
	int formatoTsegundo = ConversorSegundo(tiempo[2]);
	cout << "----------\nHora en formato HHMMSS = " << formatoThora << formatoTminuto << formatoTsegundo << "\n----------\n\n\n";
	//SUMA DE HORAS, MINUTOS Y SEGUNDOS
	int operacion[4];
	operacion[1] = formatohora+formatoThora;
	operacion[2] = formatominuto+formatoTminuto;
	if(operacion[2]>=60)
	{
		if(operacion[2]==60)
		{
			operacion[1] = operacion[1]+1;
			operacion[2] = 0;
		}
		else
		{
			int division = operacion[2]/60;
			int resto = operacion[2]-(60*division);
			operacion[1] = operacion[1]+division;
			operacion[2] = resto;
		}
	}
	operacion[3] = formatosegundo+formatoTsegundo;
	if(operacion[3]>=60)
	{
		if(operacion[3]==60)
		{
			operacion[2] = operacion[2]+1;
			operacion[3] = 0;
		}
		else
		{
			int division = operacion[3]/60;
			int resto = operacion[3]-(60*division);
			operacion[2] = operacion[2]+division;
			operacion[3] = resto;
		}
	}
	cout << "El horario final es: " << operacion[1] << operacion[2] << operacion[3] << "\n";
	//CAMBIO DE DIA
	int convuniversal = ConversorUniversal(operacion[1],operacion[2],operacion[3]);
	if(convuniversal/24000>=1) cout << "Han pasado " << convuniversal/240000 << " dias\n";
	if(convuniversal/24000<1) cout << "No has pasado ni un dia realizando la tarea pendiente\n";
	return 0;
}
