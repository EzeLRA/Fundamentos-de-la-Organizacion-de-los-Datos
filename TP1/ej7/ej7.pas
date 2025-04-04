program ej7;
type
	novela = record
		cod : integer;
		nom : string;
		genero : string;
		precio : real;
	end;
	archivo = file of novela;
//Auxiliar
procedure generarNovela(var n:novela);
begin
	n.cod := 1 + Random(101);
	n.nom := 'aytjty';
	n.genero := 'syjytjty';
	n.precio := 1.25 * (1+Random(100));
end;

procedure generarTxt;
var
	txt : Text;
	n : novela;
	i : integer;
begin
	assign(txt,'novelas.txt');
	rewrite(txt);
	
	for i:= 1 to 5 do begin
		n.cod := 1 + Random(101);
		n.nom := 'asdfg';
		n.genero := 'sdfg';
		n.precio := 1.25 * (1+Random(100));
		
		writeln(txt,n.cod,' ',n.precio:0:2,' ',n.genero);
		writeln(txt,n.nom);
	end;
	
	close(txt);
end;
//1
procedure generarBinario(var f:archivo);
var
	txt : Text;
	n : novela;
begin
	rewrite(f);
	assign(txt,'novelas.txt');
	reset(txt);
	
	while(not EOF(txt))do begin
		readln(txt,n.cod,n.precio,n.genero);
		readln(txt,n.nom);
		write(f,n);
	end;
	
	close(txt);
	close(f);
end;
//2
procedure modificarBinario(var f:archivo; novelaN:novela);
var
	n:novela;
	cumple : boolean;
begin
	reset(f);
	
	cumple := false;
	
	while(not EOF(f) and (not cumple))do begin
		read(f,n);
		if(n.cod = novelaN.cod)then cumple := true;
	end;
	if(EOF(f))then
		write(f,novelaN)
	else begin
		seek(f,filePos(f)-1);
		write(f,novelaN);
	end;
	
	close(f);
end;
VAR
	f:archivo;
	n:novela;
	nom:string;
BEGIN
	readln(nom);
	assign(f,nom);
	//generarTxt;
	generarBinario(f);
	generarNovela(n);
	modificarBinario(f,n);
END.

