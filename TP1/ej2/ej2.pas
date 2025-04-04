program ej;
const
	FIN = 2000;
type
	archivo_int = file of integer;
procedure cargarAleatorioNuevo(var fich:archivo_int);
var
	num:integer;
begin
	rewrite(fich);
	num := Random(FIN+1);
	while(num <> FIN)do begin
		write(fich,num);
		num := Random(FIN+1);
	end;
	close(fich);
end;
function numerosMenoresA(var fich:archivo_int;x:integer):integer;
var
	num,cant:integer; 
begin
	cant :=0; 
	reset(fich);
	while(not EOF(fich))do begin
		read(fich,num);
		if(num < x)then
			cant := cant + 1;
	end;
	close(fich);
	numerosMenoresA:= cant;
end;
function cantTotal(var fich:archivo_int):integer;
var
	res : integer;
begin
	reset(fich);
	res := fileSize(fich);
	close(fich);
	cantTotal := res;
end;
VAR
	fich : archivo_int;
	numMenores : integer;
	prom : real;
BEGIN
	numMenores := 0;
	prom := 0;
	randomize;
	assign(fich,'numeros');	//Se asume que recibe el archivo anterior de ej1
	cargarAleatorioNuevo(fich);	//Se asume que tiene sus datos propios para poder probar el algoritmo del programa
	numMenores := numerosMenoresA(fich,1500);
	prom := cantTotal(fich);
	prom := numMenores / prom;
	writeln(numMenores);
	writeln(prom);
END.
