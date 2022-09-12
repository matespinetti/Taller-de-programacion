program parcialRedictado2020;
const
	dimF = 4;
type
	RANGONIVEL = 1..dimF;
	infectado = record
		dni: integer;
		nombre: string;
		nivel: RANGONIVEL;
		ciudad: integer;
	end;
	
	arbolI = ^nodoI;
	
	nodoI= record
		elem: infectado;
		hi: arbolI;
		hd: arbolI;
	end;
	
	
	listaI = ^nodo;
	nodo = record
		elem: infectado;
		sig: listaI;
	end;
	
	
procedure leerInfectado (var i: infectado);
begin
	writeln ('Ingrese el dni del infectado');
	readln (i.dni);
	writeln ('Ingrese el nombre del infectado');
	readln (i.nombre);
	writeln ('Ingrese el nivel de sintomatologia');
	readln (i.nivel);
	writeln ('Ingrese el codigo de ciudad');
	readln (i.ciudad);
	


end;


procedure crearArbol (var a: arbolI; i: infectado);
begin
	if (a = nil) then
		begin
			new(a);
			a^.elem := i;
			a^.hi := nil;
			a^.hd:= nil;
		
		
		end
	else
		begin
			if (i.dni <= a^.elem.dni) then
				crearArbol (a^.hi, i)
			else
				crearArbol (a^.hd, i);
		
		
		
		end;



end;

procedure cargarInfectados (var a: arbolI);
var
	i: infectado;

begin
	a := nil;
	leerInfectado (i);
	while (i.dni <> 0) do
		begin
			crearArbol (a, i);
			leerInfectado (i);
		
		
		end;


end;



function buscarInfectadoMasAdulto (a: arbolI) : arbolI;
begin
	if (a = nil) then
		buscarInfectadoMasAdulto := nil
	else
		if (a^.hi = nil) then
			buscarInfectadoMasAdulto := a
		else
			buscarInfectadoMasAdulto := buscarInfectadoMasAdulto (a^.hi);



end;

procedure imprimirInfectadoAdulto (a: arbolI);
begin
	writeln ('El dni del infectado mas adulto es ', a^.elem.dni, ' nombre: ', a^.elem.nombre, ' nivelSintomas: ', a^.elem.nivel, ' ciudad: ', a^.elem.ciudad);


end;

procedure agregarAdelante (var pi: listaI; i: infectado);
var
	nuevo: listaI;
begin
	new (nuevo);
	nuevo^.elem := i;
	nuevo^.sig := nil;
	
	if (pi = nil) then
		pi:= nuevo
	else
		begin
			nuevo^.sig := pi;
			pi := nuevo;
		end;


end;

procedure generarListaCiudad (a: arbolI; ciudad: integer; var pi: listaI);
begin
	if (a <> nil) then
		begin
			generarListaCiudad (a^.hi, ciudad, pi);
			if (a^.elem.ciudad = ciudad ) then
				agregarAdelante (pi, a^.elem);
			
			generarListaCiudad (a^.hd, ciudad, pi);
		
		
		end;



end;


procedure imprimirLista (pi :listai);
begin
	while (pi <> nil) do
		begin
			writeln ('El dni es ', pi^.elem.dni, ' nombre: ', pi^.elem.nombre, ' nivelSintomas: ', pi^.elem.nivel, ' ciudad: ', pi^.elem.ciudad);
			pi := pi^.sig;
		
		
		end;


end;

var
	a: arbolI;
	c: integer;
	pi: listaI;


begin
	cargarInfectados (a);
	imprimirInfectadoAdulto (buscarInfectadoMasAdulto(a));
	writeln ('Ingrese el nombre de una ciudad a buscar');
	readln (c);
	generarListaCiudad (a, c, pi);
	imprimirLista (pi);



end.
