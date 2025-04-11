program ej;
type
	codigos = 1..100;
	cad30 = String[30];
	producto = record
		codigo : codigos;
		nombreComercial : cad30;
		precioVenta : real;
		stockActual : integer;
		stockMinimo : integer;
	end;
	venta = record
		codigo : codigos;
		cantVendido : integer;
	end;
	
	Maestro = file of producto;
	Detalle = file of venta;
	
	//Estructuras auxiliares
	vector = array[1..10]of producto;
	
	lista =^ nodo;
	nodo = record
		dat : venta;
		sig : lista;
	end;
	
	
//Modulos auxiliares

procedure generarProductos(var v:vector);
var
	i:codigos;
begin
	randomize;
	for i:= 1 to 10 do begin
		v[i].codigo := i;
		readln(v[i].nombreComercial);
		v[i].precioVenta := (Random(101) + 100) / 2;
		v[i].stockActual := Random(1001) + 800 ;
		v[i].stockMinimo := 500 + Random(201);
	end;
end;
procedure leerProductos(var v:vector; var P:Maestro);
var
	i:integer; pr:producto;
begin
	reset(P);
	for i:= 1 to 10 do begin
		read(P,pr);
		v[i] := pr;
	end;
	close(P);
end;
procedure generarDetalle(var d:Detalle);
	procedure insertarOrdenado(var l:lista;v:venta);
	var
		nuevo,ant,act : lista;
	begin
		new(nuevo); nuevo^.dat := v; nuevo^.sig := nil;
		if(l=nil)then
			l:=nuevo
		else begin 
			act := l ; ant:= act;
			while((act <> nil)and(act^.dat.codigo < v.codigo))do begin
				ant := act;
				act := act^.sig;
			end;
			if(act = l)then begin
				l:=nuevo;
			end else begin
				ant^.sig := nuevo;
			end;
			nuevo^.sig := act;
		end;
	end;
var
	i:integer;
	v : venta;
	l: lista;
begin
	randomize;
	l := nil;
	for i:=1 to 50 do begin
		v.codigo := 1 + Random(10);
		v.cantVendido := 1 + Random(10);
		insertarOrdenado(l,v);
	end;
	rewrite(d);
	while(l <> nil)do begin
		write(d,l^.dat);
		l:=l^.sig;
	end;
	close(d);
end;

{
*	Modulo para la resolucion 
}
procedure procesarProductos(var P:Maestro;var d:Detalle);
var
	v:venta; p:producto; cod:codigos;
	cant : integer;
begin
	rewrite(P);
	reset(d);
	
	//Revisar vinculacion de fichero y este algoritmo
	while(not EOF(d))and(not EOF(P))do begin
		read(P,p);
		read(d,v); cant := 0;
		while((v.codigo = p.codigo)and(not EOF(d)))do begin
			cant := v.cantVendido + cant;
			read(d,v);
		end;
		p.stockActual := p.stockActual - cant;
		seek(P,filePos(P)-1);
		write(P,p);
	end;
	
	close(d);
	close(P);
end;

VAR
	productos : Maestro;
	detalleDia1 : Detalle;
	v:venta;
BEGIN
	assign(productos,'Productos2');
	assign(detalleDia1,'VentasDia1');
	
END.
