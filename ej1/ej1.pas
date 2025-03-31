{
Realizar un algoritmo que cree un archivo de números enteros no ordenados y permita
incorporar datos al archivo. Los números son ingresados desde teclado. La carga finaliza
cuando se ingresa el número 30000, que no debe incorporarse al archivo. El nombre del
archivo debe ser proporcionado por el usuario desde teclado.
}
program ej1; 
type
	archivo_Int = file of integer;
procedure leerNumerosNuevo(var num:integer;var fich:archivo_Int);
begin
	//Creacion o reescritura del archivo ingresado
	rewrite(fich);
	
	//Lectura de numeros
	readln(num);
	while(num <> 30000)do begin
		write(fich,num);	//Escritura en el archivo
		readln(num);
	end;
	
	close(fich);
end;
procedure imprimirNumeros(var fich:archivo_Int);
var
	num:integer;
begin
	reset(fich);
	while(not(EOF(fich)))do begin
		read(fich,num);
		writeln(num);
	end;
end;
var 
    fichero_L : archivo_Int;
    nombre : String;
	num : integer;
begin 
	//Lectura de nombre para el archivo
	readln(nombre);
	//Asignacion del archivo fisico
	assign(fichero_L,nombre);
	leerNumerosNuevo(num,fichero_L);
	imprimirNumeros(fichero_L);
end.
