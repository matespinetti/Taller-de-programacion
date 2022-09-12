program ejercicio3;
type
	alumno = record
		legajo : integer;
		dni : integer;
		anoIngreso: integer;
	end;
	
	arbolA = ^nodoA;
	
	nodoA = record
		elem: alumno;
		hi : arbolA;
		hd: arbolA;
	end;
	
procedure leerAlumno( var a: alumno);
begin
	writeln ('Ingrese el legajo del alumno');
	readln (a.legajo);
	writeln ('Ingrese el dni del alumno');
	readln (a.dni);
	writeln ('Ingrese el ano de ingreso');
	readln (a.anoIngreso);


end;
	
	
procedure cargarArbol (var a: arbolA; alum: alumno);
begin
	if (a = nil) then
		begin
			new (a);
			a^.elem := alum;
			a^.hi := nil;
			a^.hd := nil;
		
		end
	
	else
		begin
			if (alum.legajo > a^.elem.legajo) then
				cargarArbol (a^.hd, alum)
			else
				cargarArbol (a^.hi, alum);
		
		
		
		end;



end;


procedure cargarAlumnos (var a: arbolA);
var
	alum: alumno;

begin
	leerAlumno (alum);
	while (alum.legajo <> 0) do
		begin
			if (alum.anoIngreso > 2010) then
				cargarArbol (a, alum);
			leerAlumno (alum);
		
		
		end;



end;


procedure imprimirLegajosInferiores (a: arbolA; l: integer);

begin
	if (a <> nil) then
		begin
			imprimirLegajosInferiores (a^.hi, l);
			if (a^.elem.legajo < l) then
				begin
					writeln ( ' EL dni ', a^.elem.dni, ' ano de ingreso: ', a^.elem.anoIngreso, ' legajo menor a ', l);
					imprimirLegajosInferiores (a^.hd, l);
				
				end;
		
		
		end;



end;


procedure imprimirRango (a: arbolA; l1: integer; l2: integer);
begin
	if (a<> nil) then
		begin
			if (a^.elem.legajo >= l1) and (a^.elem.legajo <=l2) then
				begin
					imprimirRango (a^.hi, l1, l2);
					writeln ('El numero de legajo entre los valores ', l1, ' y ', l2,' es : ', a^.elem.legajo);
					imprimirRango (a^.hd, l1, l2);
				end;
				
	
	
		end;



end;


function maximo (a, b, c : integer) : integer;
begin
	if (a >= b) and (a>= c) then
		maximo:= a
	else if (b> a) and (b>=c) then
		maximo := b
	else
		maximo := c;

end;
function maxDni (a: arbolA) : integer;
begin
	if (a = nil) then
		maxDni := -1
	else
		maxDni := maximo (a^.elem.dni, maxDni (a^.hi), maxDni (a^.hd));


end;


function cantLegajoImpar (a : arbolA) : integer;
begin
	if (a = nil) then
		cantLegajoImpar := 0
	else	
		if ((a^.elem.legajo mod 2) = 1) then
			cantLegajoImpar := cantLegajoImpar (a^.hi) + cantLegajoImpar (a^.hd) + 1
		else
			cantLegajoImpar := cantLegajoImpar (a^.hi) + cantLegajoImpar (a^.hd);


end;
var

	a: arbolA;
	v: integer;
	
	
begin
	cargarAlumnos (a);
	writeln ('Ingrese un valor a imprimir legajos inferiores');
	readln (v);
	imprimirLegajosInferiores (a, v);
	imprimirRango (a, 10, 20);
	writeln ('El dni maximo es ', maxDni (a));
	writeln ('La cantidad de legajos impares es de', cantLegajoImpar (a));
end.

