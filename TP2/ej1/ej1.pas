{
	Una empresa posee un archivo con información de los ingresos percibidos por diferentes
	empleados en concepto de comisión, de cada uno de ellos se conoce: código de empleado,
	nombre y monto de la comisión. La información del archivo se encuentra ordenada por
	código de empleado y cada empleado puede aparecer más de una vez en el archivo de
	comisiones.
	Realice un procedimiento que reciba el archivo anteriormente descrito y lo compacte. En
	consecuencia, deberá generar un nuevo archivo en el cual, cada empleado aparezca una
	única vez con el valor total de sus comisiones.
	
	NOTA: No se conoce a priori la cantidad de empleados. Además, el archivo debe ser
	recorrido una única vez.
}
program ej;
type
	cad30 = String[30];
	empleado = record
		codigo : integer;
		nombre : cad30;
		montoComision : real;
	end;
	
	archivoEmpleados = file of empleado;
	
	//Estructura auxiliar
	lista =^ nodo;
	nodo = record
		dat : empleado;
		sig : lista;
	end;
	

{
*	Modulos auxiliares 
}
procedure generarEmpleado(var e:empleado);
	function RandomString(largo: Integer): String;
	var
		s : string; i:integer;
	begin
		setlength(s,largo);
		for i := 1 to largo do
			s[i] := chr(random (127-32)+32);
		RandomString := s;
	end;
begin
	e.codigo := 1 + Random(101);
	e.montoComision := (Random(7001) + 1000) / 2;
	e.nombre := RandomString(5);
end;
procedure generarLista(var l:lista);
	procedure insertarOrdenado(Var pI: lista; e:empleado);
	Var
		actual,ant,nuevo:lista;
	Begin
		new(nuevo); nuevo^.dat:=e; nuevo^.sig:=nil;
		
		if (pI = nil) then pI:= nuevo
		else begin
			actual:= pI; ant:=pI;
			while (actual <> nil) and (actual^.dat.codigo > nuevo^.dat.codigo) do
			begin
				ant:=actual;
				actual:= actual^.sig;
			end;
			
			if (actual = pI) then begin
				nuevo^.sig:= pI; pI:= nuevo;
			end else begin
				ant^.sig:= nuevo; nuevo^.sig:= actual;
			end;
			
		end;
	End;
var
	emp:empleado; i,max:integer;
begin
	Randomize;
	max := 50 + Random(31);
	for i:= 1 to max do begin
		generarEmpleado(emp);
		insertarOrdenado(l,emp);
	end;
end;

procedure imprimirLista(l:lista);
begin
	while(l <> nil)do begin
		writeln(l^.dat.codigo);
		l := l^.sig;
	end;
end;
procedure generarArchivoOrdenado(var arc:archivoEmpleados;l:lista);
begin
	rewrite(arc);
	while(l <> nil)do begin
		write(arc,l^.dat);
		l := l^.sig;
	end;
	close(arc);
end;

procedure imprimirArchivo(var arc:archivoEmpleados);
var
	emp:empleado;
begin
	reset(arc);
	while(not EOF(arc))do begin
		read(arc,emp);
		writeln(emp.codigo);
		writeln(emp.nombre);
		writeln(emp.montoComision);
		writeln;
	end;
	close(arc);
end;

{
*	Modulos para la resolucion
}
procedure procesarArchivo(var arcDispone:archivoEmpleados; var arcNuevo:archivoEmpleados);
var
	e : empleado;
	eNuevo : empleado; 
begin
	reset(arcDispone);
	rewrite(arcNuevo);
	
	while(not EOF(arcDispone))do begin
		read(arcDispone,e);
		eNuevo := e; eNuevo.montoComision := 0;
		while((not EOF(arcDispone))and(eNuevo.codigo = e.codigo)and(eNuevo.nombre = e.nombre))do begin
			eNuevo.montoComision := eNuevo.montoComision + e.montoComision;
			read(arcDispone,e);
		end;
		write(arcNuevo,eNuevo);
	end;
	
	close(arcDispone);
	close(arcNuevo);
end;

VAR
	l:lista;
	arc_Dispone : archivoEmpleados;
	arc_Nuevo : archivoEmpleados;
BEGIN
	//l:=nil;
	//generarLista(l);
	assign(arc_Dispone,'empleados');
	//generarArchivoOrdenado(arc_Dispone,l);
	//imprimirArchivo(arc_Dispone);
	assign(arc_Nuevo,'comisionTotalEmpleados');
	procesarArchivo(arc_Dispone,arc_Nuevo);
	imprimirArchivo(arc_Nuevo);
END.
