program ej4;
const
	FIN = 'fin';
type
	empleado = record
		num : integer;
		nombre : string;
		apellido : string;
		edad : integer;
		dni : integer;
	end;
	
	fichero_emple = file of empleado;

procedure leerEmpleado(var e:empleado);
begin
	readln(e.apellido);
	if(e.apellido <> fin)then begin
		readln(e.nombre);
		readln(e.num);
		readln(e.edad);
		readln(e.dni);
	end;
end;
procedure cargarEmpleados(var fich:fichero_emple);
var
	emp:empleado;
begin
	rewrite(fich);
	leerEmpleado(emp);
	while(emp.apellido <> fin)do begin
		write(fich,emp);
		leerEmpleado(emp);
	end;
	close(fich);
end;
//1
procedure insertarEmpleado(var fich:fichero_emple; e:empleado);
var
	emp:empleado;
	cumple:boolean;
begin
	reset(fich);
	cumple:=true;
	while((not EOF(fich))and(cumple))do begin
		read(fich,emp);
		cumple := (e.num <> emp.num) ;
	end;
	if(EOF(fich))then
		write(fich,e);
	close(fich);
end;
//2
procedure modificarEmpleadoEdad(var fich:fichero_emple; dni,edad:integer);
var
	emple:empleado;
begin
	reset(fich);
	//CORREGIR
	while((not EOF(fich))and(emple.dni <> dni))do
		read(fich,emple);
	
	if(not EOF(fich))then begin
		emple.edad := edad;
		seek(fich,filePos(fich)-1);
		write(fich,emple);
	end;
	close(fich);
end;
//3
procedure exportarArchivo(var fich:fichero_emple);
var
	emp : empleado;
	nuevoArch : Text;
begin
	assign(nuevoArch,'todos_empleados.txt');
	rewrite(nuevoArch);
	reset(fich);
	while(not EOF(fich))do begin
		read(fich,emp);
		WriteLn(nuevoArch,emp.nombre,' ',emp.apellido,' ',emp.num,' ',emp.edad,' ',emp.dni);
	end;
	close(fich);
	close(nuevoArch);
end;
//4
procedure reportarDNIFaltantes(var fich:fichero_emple);
var
	emp : empleado;
	nuevo : Text;
begin
	assign(nuevo,'faltaDNIEmpleado.txt');
	rewrite(nuevo);
	reset(fich);
	while(not EOF(fich))do begin
		read(fich,emp);
		if(emp.dni = 0)then begin
			WriteLn(nuevo,emp.nombre,' ',emp.apellido,' ',emp.num,' ',emp.edad,' ',emp.dni);
		end;
	end;
	close(fich);
	close(nuevo);
end;

VAR
	fich : fichero_emple;
	opcion:integer;
	dni,edad:integer;
BEGIN
	opcion :=0;
	
	//PROBAR EL CODIGO
	
	while(opcion = 0)do begin
		readln(opcion);
		case opcion of
			1:begin
				assign(fich,'emple');
				cargarEmpleados(fich);
			end;
			2:begin
				readln(dni,edad);
				modificarEmpleadoEdad(fich,dni,edad);
			end;
			3:exportarArchivo(fich);
			4:reportarDNIFaltantes(fich);
		end;
	end;
END.
