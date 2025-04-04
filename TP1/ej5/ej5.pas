program ej5;
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
procedure generarCelular(var c:celular);
begin
	c.cod := 1 + Random(1000);
	c.nombre := 'asdfeg';
	c.descripcion := 'tewgtwwe';
	c.marca := 'wetwerwe';
	c.precio := (1 + Random(1000)) / 1.25;
	c.stock_min := 50 + Random(51);
	c.stock_dispone := Random(101);
end;
//Auxiliar
{Consideracion: Al escribir la informacion sobre text
				la informacion string siempre se ubican al final de los datos a escribir
}
procedure generarCelularesText;
var
	f : Text;
	c:celular; i:integer;
begin
	assign(f,'celulares.txt');
	rewrite(f);
	for i:=0 to 20 do begin
		generarCelular(c);
		WriteLn(f,c.cod,' ',c.precio:0:2,' ',c.marca);
		WriteLn(f,c.stock_dispone,' ',c.stock_min,' ',c.descripcion);
		WriteLn(f,c.nombre);
	end;
	close(f);
end;
//1
procedure convertirArchivoText(var f1:ficheroCelulares);
var
	f2 : Text;
	cel : celular;
	nom : String;
begin
	assign(f2,'celulares.txt');
	reset(f2);
	
	readln(nom);
	assign(f1,nom);
	rewrite(f1);
	while(not EOF(f2))do begin
		readln(f2,cel.cod,cel.precio,cel.marca);
		readln(f2,cel.stock_dispone,cel.stock_min,cel.descripcion);
		readln(f2,cel.nombre);
		write(f1,cel);
	end;
	close(f1);
	close(f2);
end;
//2
procedure informarStockMinimo(var f:ficheroCelulares);
var
	cel : celular;
begin
	reset(f);
	while(not EOF(f))do begin
		read(f,cel);
		if(cel.stock_dispone < cel.stock_min)then
			writeln(cel.cod,' ',cel.nombre,' ',cel.descripcion,' ',cel.marca,' ',cel.precio,' ',cel.stock_min,' ',cel.stock_dispone);
	end;
	close(f);
end;
//3
procedure informarCelularDescripcion(var f:ficheroCelulares);
var
	descripcion : String;
	cel : celular;
begin
	reset(f);
	readln(descripcion);
	while(not EOF(f))do begin
		read(f,cel);
		if(cel.descripcion = descripcion)then
			writeln(cel.cod,' ',cel.nombre,' ',cel.descripcion,' ',cel.marca,' ',cel.precio,' ',cel.stock_min,' ',cel.stock_dispone);
	end;
	close(f);
end;
//4
procedure exportarArchivo(var f1:ficheroCelulares);
var
	f2 : Text;
	cel : celular;
begin
	assign(f2,'celulares.txt');
	reset(f1);
	rewrite(f2);
	while(not EOF(f1))do begin
		read(f1,cel);
		WriteLn(f2,cel.cod,' ',cel.precio:0:2,' ',cel.marca);
		WriteLn(f2,cel.stock_dispone,' ',cel.stock_min,' ',cel.descripcion);
		WriteLn(f2,cel.nombre);
	end;
	close(f1);
	close(f2);
end;
//Auxiliar
procedure imprimirTxt;
var
	txt : Text;
	cel : celular;
begin
	assign(txt,'celulares.txt');
	reset(txt);
	while(not EOF(txt))do begin
		readln(txt,cel.cod,cel.precio,cel.marca);
		readln(txt,cel.stock_dispone,cel.stock_min,cel.descripcion);
		readln(txt,cel.nombre);
		writeln(cel.cod,' ',cel.nombre,' ',cel.descripcion,' ',cel.marca,' ',cel.precio,' ',cel.stock_min,' ',cel.stock_dispone);
	end;
end;

VAR
	opcion : integer;
	fich : ficheroCelulares;
BEGIN
	randomize;
	repeat
		writeln('Ingrese una opcion: ');
		readln(opcion);
		case opcion of
			1:  begin
				convertirArchivoText(fich);
				//generarCelularesText();
				//imprimirTxt();
				end;
			2: informarStockMinimo(fich);
			3: informarCelularDescripcion(fich);
			4: exportarArchivo(fich);
		end;
		
	until(opcion = 0);
END.
