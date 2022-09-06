program ejercicio1;

type
	socio = record
		numero : integer;
		nombre: string;
		edad: integer;
	end;
	
	arbol = ^nodo;
	nodo = record	
		elem: socio;
		hi: arbol;
		hd: arbol;
	end;
	
	
procedure leerSocio (var s: socio);
begin
	writeln ('Ingrese el numero de socio');
	readln (s.numero);
	writeln ('Ingrese el nombre del socio');
	readln (s.nombre);
	writeln ('Ingrese la edad del socio');
	readln (s.edad);

end;


procedure crearLista (var a: arbol; s: socio);
begin
	if (a = nil) then
		begin
			new (a);
			a^.elem := s;
			a^.hi := nil;
			a^.hd := nil;
		
		end
	else
		begin
			if (s.numero < a^.elem.numero) then
				crearLista (a^.hi, s)
			else
				crearLista (a^.hd, s);
		
		end;



end;


procedure cargarSocios (var a: arbol);
var
	s: socio;
begin
	leerSocio (s);
	while (s. numero <> 0) do
		begin
			crearLista (a, s);
			leerSocio (s);
		
		end;


end;


function maxNumSocio (a: arbol): integer;
begin
	if (a = nil) then
		maxNumSocio := -9999
	else
		if (a^.hd = nil) then
			maxNumSocio := a^.elem.numero
		else
			maxNumSocio := maxNumSocio (a^.hd);



end;


function minSocio (a: arbol) : arbol;
begin
	if (a = nil) then
		minSocio := nil
	else
		
		if (a^.hi = nil) then
			minSocio := a
		else
			minSocio := minSocio (a^.hi);

end;

procedure maxEdad2 (a : arbol; var maxS: integer; var maxE: integer);
begin
	if (a <> nil) then
		begin
			maxEdad2 (a^.hi, maxS, maxE);
			if (a^.elem.edad > maxE) then
				begin
					maxE := a^.elem.edad;
					maxS := a^.elem.numero;
				end;
				
			
			maxEdad2(a^.hd, maxS, maxE);
		
		
		end;

end;



function maximo (a, b: arbol) : arbol;
begin
	if (a^.elem.edad >= b^.elem.edad) then
		maximo := a
	else
		maximo := b;


end;




procedure imprimirSocio (a: arbol);
begin 
	if (a<> nil) then
		begin
			writeln ('El numero de socio es ', a^.elem.numero);
			writeln ('El nombre del socio es ', a^.elem.nombre);
			writeln ('La edad del socio es ', a^.elem.edad);
		end
	else
		writeln ('El arbol esta vacio');
end;


procedure aumentarEdad1 (a: arbol);
begin
	if (a<> nil) then
		begin
			aumentarEdad1 (a^.hi);
			a^.elem.edad := a^.elem.edad + 1;
			aumentarEdad1 (a^.hd);
		
		end;


end;

procedure imprimirArbol (a: arbol);
begin
	if (a <> nil) then
		begin
			imprimirArbol (a^.hi);
			writeln ('edad :', a^.elem.edad, 'nro de socio: ', a^.elem.numero);
			imprimirArbol (a^.hd);
		end;
end;



function buscarValor (a: arbol; nroSocio: integer) : boolean;
begin
	if (a = nil) then
		buscarValor := false
	else if (a^.elem.numero = nroSocio) then
			buscarValor := true
		else
			begin
				if (nroSocio < a^.elem.numero) then
					buscarValor := buscarValor (a^.hi, nroSocio)
				else
					buscarValor := buscarValor (a^.hd, nroSocio);
			
			
			end;


end;


function buscarNombre (a: arbol; nombre: string) : boolean;

begin
	if (a = nil) then
		buscarNombre := false
	else
		if (a^.elem.nombre = nombre ) then
			buscarNombre := true
		else
			begin
				buscarNombre := (a^.elem.nombre = nombre) or (buscarNombre (a^.hi, nombre) or buscarNombre (a^.hd,nombre))
			end;
			


end;


function cantSocios (a: arbol): integer;
begin
	if (a = nil) then
		cantSocios := 0
	else
		cantSocios := cantSocios (a^.hi) + cantSOcios (a^.hd) + 1;


end;

function sumaEdades (a: arbol) : integer;
begin
	if (a = nil) then
		sumaEdades := 0
	else
		sumaEdades := sumaEdades (a^.hi) + sumaEdades (a^.hd) + a^.elem.edad;


end;


function promedioSocios (a: arbol) : real;
begin
	if (cantSocios(a) <>0) then
		promedioSocios := sumaEdades (a) / cantSocios (a)
	else
		promedioSocios := -9999;


end;


procedure buscarEnElMedio (a: arbol; v1, v2: integer; var cant: integer);
begin
	if (a <> nil) then
		begin
			if (a^.elem.numero >= v1) then
				buscarEnElMedio (a^.hi, v1, v2, cant);
		
			if ((a^.elem.numero >= v1) and (a^.elem.numero <=v2))then
				cant := cant +1;
			
			if (a^.elem.numero <= v2) then
				buscarEnElMedio (a^.hd, v1,v2, cant);
				
		end;


end;


procedure imprimirCreciente (a: arbol);
begin
	if (a <> nil) then
		begin
			imprimirCreciente (a^.hi);
			writeln (a^.elem.numero);
			imprimirCreciente (a^.hd);
	
		
		
		end;


end;

procedure imprimirDecreciente (a: arbol);
begin
	if (a <> nil) then
		begin
			imprimirDecreciente (a^.hd);
			writeln (a^.elem.numero);
			imprimirDecreciente (a^.hi);
	
		
		
		end;


end;


var
	a: arbol;
	edad: integer;
	v: integer;
	n: string;
	cant : integer;

begin
	a := nil;
	cargarSocios (a);
	writeln ( 'El numero socio maximo es ', maxNumSocio (a));
	imprimirSocio (minSocio(a));
	aumentarEdad1 (a);
	imprimirArbol (a);
	writeln ('Ingrese un valor a buscar en el arbol');
	readln (v);
	if (buscarValor (a, v)) then
		writeln ('Esta en el vector')
	else
		writeln ('No esta en el arbol');
		
	writeln ('Ingrese un nombre a buscar');
	readln (n);
		
	if (buscarNombre (a, n)) then
		writeln ('El nombre esta en el vector')
	else
		writeln ('El nombre no esta en el vector');
		
	writeln ('La cantidad de socios totales es ', cantSocios (a));
	writeln ('El promedio de edad de todos los socios es ', promedioSocios (a):1:2);
	cant := 0;
	buscarEnElMedio (a, 10, 20, cant);
	writeln (cant);
	imprimirCreciente (a);
	imprimirDecreciente (a);
	
	
end.
