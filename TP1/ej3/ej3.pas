program ej3;
const	
	fin = 'fin';
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
procedure informarEmpleado(e:empleado);
begin
	writeln(e.apellido);
	writeln(e.nombre);
	writeln(e.num);
	writeln(e.edad);
	writeln(e.dni);
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
procedure informarEmpleadosDatos(var fich:fichero_emple; nom,ape:string);
var
	emple:empleado;
begin
	reset(fich);
	while((not EOF(fich)))do begin
		read(fich,emple);
		if((emple.nombre=nom)or(emple.apellido=ape))then
			informarEmpleado(emple);
			writeln;
	end;
	close(fich);
end;
procedure informarEmpleadosFich(var fich:fichero_emple);
var
	emple:empleado;
begin
	reset(fich);
	while((not EOF(fich)))do begin
		read(fich,emple);
		informarEmpleado(emple);
		writeln;
	end;
	close(fich);
end;
procedure informarEmpleadosMayoresA(var fich:fichero_emple; edad:integer);
var
	emple:empleado;
begin
	reset(fich);
	while((not EOF(fich)))do begin
		read(fich,emple);
		if(emple.edad > edad)then
			informarEmpleado(emple);
		writeln;
	end;
	close(fich);
end;
VAR
	nombre_fich:string;
	fich : fichero_emple;
BEGIN
	write('Ingresar nombre:');
	readln(nombre_fich);
	assign(fich,nombre_fich);
	cargarEmpleados(fich);
	informarEmpleadosDatos(fich,'Ezequiel','Ramos');
END.
