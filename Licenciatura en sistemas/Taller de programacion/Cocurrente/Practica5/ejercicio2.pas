program ejercicio2P5;
type
	RANGOANO = 2010..2018;
	auto = record
		patente: integer;
		ano: RANGOANO;
		marca: string;
		modelo: string;
	end;
	
	arbolA = ^nodoA;
	
	nodoA = record
		elem: auto;
		hi: arbolA;
		hd: arbolA;
	end;
	
	listaA = ^nodo;
	
	nodo = record
		elem: auto;
		sig: listaA;
	end;
	
	vectorA = array [RANGOANO] of listaA;
	
	
	
procedure leerAuto (var a: auto);
begin
	writeln ('Ingrese la patente del auto');
	readln (a.patente);
	writeln ('Ingrese el ano del auto (2010, 2018)');
	readln (a.ano);
	writeln ('Ingrese la marca del auto');
	readln (a.marca);
	writeln ('Ingrese el modelo del auto');
	readln (a.modelo);



end;


procedure crearArbol (var a: arbolA; aut: auto);
begin
	if (a = nil) then
		begin
			new (a);
			a^.elem:= aut;
			a^.hi:= nil;
			a^.hd := nil;
		
		
		end
	else
		begin
			if (aut.patente <= a^.elem.patente) then
				crearArbol (a^.hi, aut)
			else
				crearArbol (a^.hd, aut);
		
		
		end;


end;




function cantMarca (a: arbolA; m: string) : integer;
begin
	if (a = nil) then
		cantMarca := 0
	else
		begin
			cantMarca := cantMarca (a^.hi, m) + cantMarca (a^.hd, m);
			if (a^.elem.marca = m) then
				cantMarca := cantMarca + 1;
		end;


end;


procedure cargarAutos (var a: arbolA);
var
	aut: auto;
	
begin
	a := nil;
	leerAuto (aut);
	while (aut.patente <> 0) do
		begin
			crearArbol (a, aut);
			leerAuto (aut);
		
		
		end;



end;


procedure agregarAdelante (var pi: listaA; a: auto);
var
	nuevo : listaA;
begin
	new (nuevo);
	nuevo^.elem := a;
	nuevo^.sig := nil;
	
	if (pi = nil) then
		pi := nuevo
	else
		begin
			nuevo^.sig := pi;
			pi := nuevo;
		end;

end;


procedure inicializarVector (var v: vectorA);
var
	i: integer;

begin
	for i := 2010 to 2018 do
		begin
			v[i] := nil;
			
		
		end;


end;
procedure generarVector (a: arbolA; var v: vectorA);
begin
	if (a<> nil) then
		begin
			generarVector (a^.hi, v);
			agregarAdelante (v[a^.elem.ano], a^.elem);
			generarVector (a^.hd, v);
		
		
		end;



end;



function buscarAnoPatente (a: arbolA; p: integer): integer;
begin
	if (a = nil) then
		buscarAnoPatente := -1
	else 
		begin
			if (a^.elem.patente = p) then
				buscarAnoPatente := a^.elem.ano
			else
				if (p <= a^.elem.patente) then
					buscarAnoPatente := buscarAnoPatente (a^.hi,p)
				else
					buscarAnoPatente := buscarAnoPatente (a^.hd, p);
		
		
		end;



end;

procedure imprimirVector (v: vectorA);
var
	i:integer;

begin
	for i:= 2010 to 2018 do
		begin
			while (v[i] <> nil) do
				begin
					writeln('PATENTE: ', v[i]^.elem.patente);
					v[i]:= v[i]^.sig;
				end;
		end;
end;


var
	
	a: arbolA;
	m: string;
	v: vectorA;
	p: integer;

begin

	cargarAutos (a);
	writeln ('Ingrese un marca');
	readln (m);
	writeln ('La cantidad de autos de la marca ', m, ' es de: ', cantMarca (a, m));
	inicializarVector (v);
	generarVector (a, v);
	writeln ('Inserte patente a buscar');
	readln (p);
	writeln ('El ano de fabricacion de la patente ', p, ' es ', buscarAnoPatente(a, p));
	imprimirVector(v);


end.

