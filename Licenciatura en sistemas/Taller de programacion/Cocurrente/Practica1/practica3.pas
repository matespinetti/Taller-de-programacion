program ejercicio3;
const
	dimF = 8;
type
	RANGOCODIGOGENERO = 1..dimF;
	
	pelicula = record
		codigo : integer;
		codigoGenero: integer;
		puntaje : real;
	end;
	
	listaPeliculas = ^nodo;
	nodo = record
		elem : pelicula;
		sig : listaPeliculas;
	end;
	
	punteros = record
		pi: listaPeliculas;
		pu: listaPeliculas;
	end;
	
	vectorGeneros = array [RANGOCODIGOGENERO] of punteros;
	vectorPuntajes = array [RANGOCODIGOGENERO] of pelicula;
	

procedure leerPelicula (var p: pelicula);
begin
	writeln ('Ingrese el codigo de la pelicula');
	readln(p.codigo);
	randomize;
	p.codigoGenero := random(8) + 1;
	randomize;
	p.puntaje := random (11);
end;


procedure agregarAtras (var pi: listaPeliculas; var pu: listaPeliculas; p: pelicula);
var
	nuevo : listaPeliculas;
begin
	new (nuevo);
	nuevo^.elem:= p;
	nuevo^.sig := nil;
	
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
		
		
procedure inicializarVector (var v: vectorGeneros);
var
	i: integer;
begin
	for i := 1 to dimF do
		begin
			v[i].pi := nil;
			v[i].pu := nil;
		
		end;


end;

procedure cargarPeliculas (var v: vectorGeneros);
var
	p: pelicula;

begin
	leerPelicula (p);
	while (p.codigo <> -1) do
		begin
			agregarAtras (v[p.codigoGenero].pi, v[p.codigoGenero].pu, p);
			leerPelicula (p);
		
		end;



end;
		
procedure imprimirPeliculas (v : vectorGeneros);
var
	i: integer;
begin
	for i := 1 to dimF do
		begin
			while (v[i].pi <> nil) do
				begin
					writeln ('El codigo de genero es ', v[i].pi^.elem.codigoGenero, ' codigo : ', v[i].pi^.elem.codigo, ' puntaje: ', v[i].pi^.elem.puntaje:1:2);
					v[i].pi := v[i].pi^.sig;
				
				end;
		
		
		end;


end;


procedure mayorPuntajeCritica (v: vectorGeneros; var p: vectorPuntajes);
var
	i: integer;
	max : real;
	maxPel: pelicula;

begin
	for i := 1 to dimF do
		begin
			max := -1;
			while (v[i].pi <> nil) do
				begin
					if (v[i].pi^.elem.puntaje > max) then
						begin
							max := v[i].pi^.elem.puntaje;
							maxPel:= v[i].pi^.elem;
						end;
					v[i].pi := v[i].pi^.sig;
				
				end;
			if (max <> -1) then
						p[i] := maxPel;
		end;


end;


procedure imprimirVectorPuntajes (p: vectorPuntajes);
var
	i: integer;
begin
	for i := 1 to dimF do
		begin
			writeln ('El codigo con mayor puntaje de la categoria, ', i, ' es : ', p[i].codigo, ' con un puntaje de ', p[i].puntaje);
		
		end;

end;

procedure ordernarPuntajes (var p: vectorPuntajes);
var
	actual : pelicula;
	i, j : integer;

begin
	for i := 2 to dimF do
		begin
			actual := p[i];
			j := i-1;
			while ((j >= 1) and (p[j].puntaje > actual.puntaje)) do
				begin
					p [j+1] := p[j];
					j := j-1;
				end;
		p [j+1] := actual;
			
		end;



end;




var
	v: vectorGeneros;
	p: vectorPuntajes;
	
begin
	inicializarVector (v);
	cargarPeliculas (v);
	imprimirPeliculas (v);
	mayorPuntajeCritica (v, p);
	imprimirVectorPuntajes (p);
	ordernarPuntajes (p);
	writeln ('El codigo de pelicula con mayor puntaje es ', p[8].codigo);
	writeln ('El codigo de pelicula con menor puntaje es ', p[1].codigo);
end.
