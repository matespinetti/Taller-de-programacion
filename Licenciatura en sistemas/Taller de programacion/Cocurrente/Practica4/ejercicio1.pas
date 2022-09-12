program ejercicio1P4;
const
	dimFMes = 12;
type
	RANGOMES = 1..dimFMes;
	prestamo = record
		isbn : integer;
		nSocio : integer;
		dia : integer;
		mes : integer;
		diasPrestado: integer;
	end;
	
	listaP = ^nodoP;
	nodoP = record
		elem: prestamo;
		sig : listaP;
	end;
	
	vectorMeses = array [RANGOMES] of listaP;
	
	prestamoT = record
		isbn: integer;
		cant: integer;
	end;
	
	
	listaT = ^nodoT;
	
	nodoT = record
		elem: prestamoT;
		sig : listaT;
	end;
	
	

procedure leerPrestamo (var p: prestamo);
begin
	writeln ('Ingrese el isbn del prestamo');
	readln (p.isbn);
	writeln ('Ingrese el numero de socio');
	readln (p.nSocio);
	writeln ('Ingrese el dia del prestamo');
	readln (p.dia);
	writeln ('Ingrese el mes del prestamo');
	readln (p.mes);
	writeln ('Ingrese la cantidad de dias prestado');
	readln (p.diasPrestado);


end;
	
	
procedure inicializarVectorMeses (var v: vectorMeses);
var
	i: integer;
begin
	for i := 1 to dimFMes do
		begin
			v[i] := nil;
		
		
		end;



end;


procedure insertarOrdenado (var pi: listaP; var p : prestamo);
var
	nuevo, act, ant : listaP;

begin
	new (nuevo);
	nuevo^.elem := p;
	nuevo^.sig := nil;
	
	if (pi = nil) then
		pi:= nuevo
	else
		begin
			act := pi;
			ant := pi;
			while ((act <> nil) and (p.isbn > act^.elem.isbn)) do
				begin
					ant := act;
					act := act^.sig;
				
				
				end;
				
			if (act = pi) then
				begin
					nuevo^.sig := pi;
					pi := nuevo;
				
				end
			else
				begin
					ant^.sig := nuevo;
					nuevo^.sig := act;
				
				
				end;
		
		
		
		end;


end;






procedure cargarPrestamos (var v: vectorMeses);
var
	p: prestamo;

begin
	leerPrestamo (p);
	while (p.isbn <> -1) do
		begin
			insertarOrdenado (v[p.mes], p);
			leerPrestamo (p);
		
		end;



end;


procedure imprimirRecursivo (pi: listaP);
begin
	if (pi <> nil) then
		begin
			writeln ('ISBN: ', pi^.elem.isbn, ' numero de socio : ', pi^.elem.nSocio);
			imprimirRecursivo (pi^.sig);
		
		end;


end;
procedure imprimir (v: vectorMeses);
var
	i : integer;
begin
	for i := 1 to dimFMes do
		begin
			imprimirRecursivo (v[i]);
		
		end;



end;



procedure minimo (var v: vectorMeses; var minP : prestamo);
var
	indiceMin, i: integer;

begin
	minP.isbn := 32000;
	for i := 1 to dimFMes do
		begin
			if (v[i] <> nil) then
				begin
					if (v[i]^.elem.isbn <= minP.isbn) then
						begin
							indiceMin := i;
							minP:= v[i]^.elem;
						
						
						end;
				end;
		end;	
			
	if (minP.isbn <> 32000 ) then
		begin
			v[indiceMin] := v[indiceMin]^.sig;
				
		end;
		
		
	



end;

procedure agregarAtras (var pi: listaP; var pu: listaP; p: prestamo);
var
	nuevo: listaP;
begin
	new (nuevo);
	nuevo^.sig := nil;
	nuevo^.elem := p;
	
	if (pi = nil) then
		begin
			pi := nuevo;
			pu := nuevo;
		
		end
	else
		begin
			pu^.sig := nuevo;
			pu := nuevo;
		
		end;



end;


procedure mergeEjercicioC (v: vectorMeses; var piNueva: listaP; var puNueva: listaP);
var
	minP: prestamo;
begin
	piNueva := nil;
	minimo (v, minP);
	while (minP.isbn <> 32000) do
		begin
			agregarAtras (piNueva, puNueva, minP );
			minimo (v, minP);
		
		end;




end;



procedure minimoT (var v: vectorMeses; var p: prestamoT );
var
	minIndice, i: integer;
begin
	p.isbn := 32000;
	for i := 1 to dimFMes do
		begin
			if (v[i] <> nil) then
				begin
					if (v[i]^.elem.isbn <= p.isbn) then
						begin
							minIndice := i;
							p.isbn := v[i]^.elem.isbn;
						
						end;
				
				end;
		
		
		end;
		
	
	if (p.isbn <> 32000) then
		v[minIndice] := v[minIndice]^.sig;



end;

procedure agregarAtrasT (var pi: listaT; var pu: listaT; actual, cant: integer );
var
	nuevo: listaT;

begin
	new (nuevo);
	nuevo^.elem.isbn := actual;
	nuevo^.elem.cant := cant;
	nuevo^.sig := nil;
	
	if (pi = nil) then
		begin
			pi:= nuevo;
			pu:= nuevo;
		
		end
	else
		begin
			pu^.sig := nuevo;
			pu := nuevo;
		
		
		end;


end;
procedure mergeEjercicioE (v: vectorMeses; var pi: listaT; var pu: listaT);
var
	p: prestamoT;
	isbnActual: integer;
begin
	pi:= nil;
	minimoT (v, p);
	while (p.isbn <> 32000) do
		begin
			isbnActual := p.isbn;
			p.cant := 0;
			while ((p.isbn <> 32000) and (isbnActual = p.isbn)) do
				begin
					p.cant := p.cant + 1;
					minimoT (v, p);
				end;
		
			agregarAtrasT (pi, pu, isbnActual, p.cant);
		end;


end;

procedure imprimirListaT (pi: listaT);
begin
	if (pi <> nil) then
		begin
			writeln (' ISBN: ', pi^.elem.isbn, ' cantPrestado: ', pi^.elem.cant);
			imprimirListaT (pi^.sig);
		
		
		end;


end;


var
	v: vectorMeses;
	piNueva, puNueva : listaP;
	piT, puT: listaT;

begin
	inicializarVectorMeses (v);
	cargarPrestamos (v);
	imprimir (v);
	mergeEjercicioC (v, piNueva, puNueva);
	writeln ('Lista Nueva: ');
	imprimirRecursivo (piNueva);
	mergeEjercicioE (v,piT, puT);
	imprimirListaT (piT);	
	
end.
	
