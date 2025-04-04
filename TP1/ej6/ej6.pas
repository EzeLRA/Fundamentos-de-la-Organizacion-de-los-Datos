program ej6;
type
	celular = record
		cod : integer;
		nombre : String;
		descripcion : String;
		marca : String;
		precio : real;
		stock_min : integer;
		stock_dispone : integer;
	end;
	ficheroCelulares = file of celular;
procedure leerCelular(var cel:celular);
begin
	readln(cel.cod);
	if(cel.cod <> -1)then begin
		readln(cel.nombre);
		readln(cel.descripcion);
		readln(cel.marca);
		readln(cel.precio);
		readln(cel.stock_min);
		readln(cel.stock_dispone);
	end;
end;
//1
procedure agregarCelulares(var f:ficheroCelulares);
var
	cel : celular;
begin
	reset(f);
	
	writeln('Ingresar codigo (-1) para terminar la insercion de datos:');
	leerCelular(cel);
	while(cel.cod <> -1)do begin
		seek(f,fileSize(f));
		write(f,cel);
		leerCelular(cel);
	end;
	
	close(f);
end;
//2
procedure modificarCelularNom(var f:ficheroCelulares);
var
	cel : celular;
	stockNuevo : integer;
	nom : String;
	cumple : boolean;
begin
	cumple := false;
	reset(f);
	readln(nom);
	readln(stockNuevo);
	while(not EOF(f)and(not cumple))do begin
		read(f,cel);
		if(nom = cel.nombre)then cumple := true;
	end;
	if(not EOF(f))then begin
		seek(f,filePos(f)-1);
		cel.stock_dispone := stockNuevo;
		write(f,cel);
	end;
	close(f);
end;
//3
procedure exportarCelularesSinStock(var f:ficheroCelulares);
var
	cel : celular;
	txt : Text;
begin
	reset(f);
	assign(txt,'SinStock.txt');
	rewrite(txt);
	while(not EOF(f))do begin
		read(f,cel);
		if(cel.stock_dispone = 0)then
			writeln(txt,cel.cod,' ',cel.precio,' ',cel.stock_min,' ',cel.stock_dispone,' ',cel.nombre,' ',cel.descripcion,' ',cel.marca);
	end;
	close(f);
	close(txt);
end;
//Auxiliar
procedure imprimirArchivo(var f:ficheroCelulares);
var
	cel : celular;
begin
	reset(f);
	while(not EOF(f))do begin
		read(f,cel);
		writeln(cel.cod);
	end;
	close(f);
end;
VAR
	f:ficheroCelulares;
	opc: integer;
BEGIN
	assign(f,'celulares');
	repeat
		write('Ingrese una opcion: ');
		readln(opc);
		case opc of
			1:agregarCelulares(f);
			2:modificarCelularNom(f);
			3:exportarCelularesSinStock(f);
		end;
	until(opc = 0);
END.
	
