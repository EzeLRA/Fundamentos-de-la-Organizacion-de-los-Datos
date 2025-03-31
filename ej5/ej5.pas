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
procedure cargarCelulares(var f:Text);
var
	c:celular; i:integer;
begin
	rewrite(f);
	for i:=0 to 10 do begin
		generarCelular(c);
		WriteLn(f,c.cod,' ',c.nombre,' ',c.descripcion,' ',c.marca,' ',c.precio,' ',c.stock_min,' ',c.stock_dispone);
	end;
	close(f);
end;
VAR
	opcion : integer;
	fich : ficheroCelulares;
	carga : Text;
BEGIN
	randomize;
	repeat
		writeln('Ingrese una opcion: ');
		readln(opcion);
		case opcion of
			1:  begin
				assign(carga,'celulares.txt');
				cargarCelulares(carga);
				end;
			//Continuar
		end;
		
	until(opcion = 0);
END.
