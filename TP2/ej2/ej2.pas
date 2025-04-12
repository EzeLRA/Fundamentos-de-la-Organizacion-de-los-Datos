program ej;
const valorAlto = 101;
type
	codigos = 1..101;
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
procedure imprimirProducto(pr:producto);
begin
	writeln(pr.codigo);
	writeln(pr.nombreComercial);
	writeln(pr.precioVenta);
	writeln(pr.stockActual);
	writeln(pr.stockMinimo);
	writeln;
end;

procedure generarMaestro(var M:Maestro);
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
var
	v:vector; i:codigos;
begin
	generarProductos(v);
	rewrite(M);
	for i:= 1 to 10 do begin
		write(M,v[i]);
	end;
	close(M);
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
procedure imprimirArchivo(var P:Maestro);
var
	pr:producto;
begin
	reset(P);
	while(not EOF(P))do begin
		read(P,pr);
		imprimirProducto(pr);
	end;
	close(P);
end;
procedure imprimirArchivo2(var d:Detalle);
var
	v:venta;
begin
	reset(d);
	while(not EOF(d))do begin
		read(d,v);
		writeln(v.codigo);
		writeln(v.cantVendido);
		writeln;
	end;
	close(d);
end;
{
*	Modulo para la resolucion 
}
procedure procesarProductos(var P:Maestro;var d:Detalle);
	procedure leer (var archivo:Detalle; var dato:venta);
	begin
		if (not eof(archivo))then read (archivo,dato)
		else begin dato.codigo := valorAlto; dato.cantVendido := -1;
		end;
	end;
var
	ve:venta; pr:producto;
begin
	reset(P);
	reset(d);
	
	leer(d,ve); {se procesan todos los registros del archivo detalle}
	while (ve.codigo <> valorAlto) do begin
		read(P,pr);
		{ Busca codigos iguales }
		while (pr.codigo <> ve.codigo) do
			read (P,pr);
		{ se procesan códigos iguales }
		while (pr.codigo = ve.codigo) do begin
			pr.stockActual := pr.stockActual - ve.cantVendido;
			leer(d,ve);
		end;
		{reubica el puntero}
		seek(P, filepos(P)-1);
		write(P,pr);
	end;
	
	close(d);
	close(P);
end;

VAR
	productos : Maestro;
	detalleDia1 : Detalle;
BEGIN
	{ Generacion de archivos desde cero
	
	assign(productos,'Productos');
	assign(detalleDia1,'VentasDia1');
	generarMaestro(productos);			//Va pedir nombres de hasta 10 marcas
	generarDetalle(detalleDia1);
	}
	{ Modifica un respaldo de 'Productos' con los cambios de 'detalleDia1'
	
	assign(productos,'Productos2');
	assign(detalleDia1,'VentasDia1');
	procesarProductos(productos,detalleDia1);
	imprimirArchivo(productos);
	}	
END.
