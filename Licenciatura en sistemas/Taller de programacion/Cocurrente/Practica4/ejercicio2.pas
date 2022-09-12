program ejercicio2P4;
const
	dimFGenero = 8;
type
	RANGOCODIGOGENERO = 1..dimFGenero;
	pelicula = record
		codigo: integer;
		genero: RANGOCODIGOGENERO;
		puntaje: real;
	end;
	
	listaP = ^nodoP;
	
	nodoP = record
		elem: pelicula;
		sig: listaP;
	end;
	
	vectorGeneros = array [RANGOCODIGOGENERO] of listaP;
	

procedure leerPelicula (var p: pelicula);
begin
	writeln ('Ingrese el codigo de la pelicula');
	readln (p.codigo);
	writeln ('Ingrese el genero de la pelicula');
	readln (p.genero);
	writeln ('Ingrese el puntaje de la pelicula');
	readln (p.puntaje);
	


end;

procedure insertarOrdenado (var pi: listaP; p: pelicula);
var
	nuevo, act, ant: listaP;

begin
	new(nuevo);
	nuevo^.elem := p;
	nuevo^.sig := nil;
	
	if (pi = nil) then
		pi := nuevo
	else
		begin
			ant := pi;
			act := pi;
			
			while ((act <> nil) and (nuevo^.elem.codigo > act^.elem.codigo)) do 
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

procedure inicializarVectorG (var v: vectorGeneros);
var
	i: integer;

begin
	for i := 1 to dimFGenero do
		v[i] := nil;
	

end;
procedure cargarPeliculas (var v: vectorGeneros);
var
	p: pelicula;

begin
	leerPelicula (p);
	while (p.codigo <> -1) do
		begin
			insertarOrdenado (v[p.genero], p);
			leerPelicula (p);
		
		
		end;


end;


procedure minimo (var v: vectorGeneros; var min: pelicula);
var
	minIndice, i: integer;
begin
	min.codigo := 32000;
	for i := 1 to dimFGenero do
		begin
			if (v[i] <> nil) then
				begin
					if (v[i]^.elem.codigo <= min.codigo) then
						begin
							minIndice := i;
							min := v[i]^.elem;
						
						end;
				
				
				end;
		
		
		end;

	if (min.codigo <> 32000) then
		v[minIndice] := v[minIndice]^.sig;



end;
		
procedure agregarAtras (var pi: listaP; var pu: listaP; p: pelicula);
var
	nuevo : listaP;
begin
	new(nuevo);
	nuevo^.elem := p;
	nuevo^.sig := nil;
	
	if (pi = nil) then
		begin
			pi:= nuevo;
			pu := nuevo;
		
		end
	else
		begin
			pu^.sig := nuevo;
			pu := nuevo;
		
		
		end;


end;
procedure mergeListas (v: vectorGeneros; var pi: listaP; var pu: listaP);
var
	minP : pelicula;
begin
	pi:= nil;
	minimo (v, minP);
	while (minP.codigo <> 32000) do
		begin
			agregarAtras (pi, pu, minP);
			minimo (v, minP);
			
		
		end;


end;

procedure imprimirLista (pi: listaP);
begin
	while (pi <> nil) do
		begin
			writeln ('CODIGO: ', pi^.elem.codigo, ' PUNTAJE: ', pi^.elem.puntaje);
			pi := pi^.sig;
		
		end;


end;
var
	v: vectorGeneros;
	piNueva, puNueva : listaP;

begin
	inicializarVectorG (v);
	cargarPeliculas (v);
	mergeListas (v, piNueva, puNueva);
	imprimirLista (piNueva);


end.
