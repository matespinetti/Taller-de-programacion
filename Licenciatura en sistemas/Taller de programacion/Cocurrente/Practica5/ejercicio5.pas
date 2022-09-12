program ejercicio3P5;
const
	dimFR= 10;
type
	RANGORUBRO = 1..10;
	producto = record
		codigo : integer;
		rubro : RANGORUBRO;
		stock: integer;
		precio: real;
	end;
	
	arbolP = ^nodoP;
	
	nodoP = record
		elem: producto;
		hi: arbolP;
		hd: arbolP;
	end;
	
	vectorP = array [RANGORUBRO] of arbolP;
	
	max = record
		codigo: integer;
		stock: integer;
	end;
	
	vectorMax = array [RANGORUBRO] of max;
	
	vectorRangos = array [RANGORUBRO] of integer;
	
procedure leerProducto (var p: producto);
begin
	writeln ('Ingrese el codigo de producto');
	readln (p.codigo);
	writeln ('Ingrese el rubro de producto');
	readln (p.rubro);
	writeln ('Ingrese el stock de producto');
	readln (p.stock);
	writeln ('Ingrese el precio de producto');
	readln (p.precio);



end;


procedure crearArbol (var a: arbolP; p: producto);
begin
	if (a = nil) then
		begin
			new (a);
			a^.elem := p;
			a^.hi := nil;
			a^.hd := nil;
		
		
		end
	
	else
		if (p.codigo <= a^.elem.codigo) then
			crearArbol (a^.hi, p)
		else
			crearArbol (a^.hd, p);


end;


procedure inicializarVector (var v: vectorP);
var
	i: integer;

begin
	for i := 1 to dimFR do
		begin
			v[i] := nil;
		
		end;


end;
procedure cargarProductos (var v: vectorP);
var
	p: producto;

begin
	leerProducto (p);
	while (p.codigo <> -1 ) do
		begin
			crearArbol (v[p.rubro], p);
			leerProducto (p);
			
		
		end;


end;


function buscarCodigoArbol (a: arbolP; c: integer) : boolean;
begin
	if (a = nil) then
		buscarCodigoArbol := false
	else
		begin
			if (a^.elem.codigo = c) then
				buscarCodigoArbol := true
			else
				if (c <= a^.elem.codigo) then
					buscarCodigoArbol := buscarCodigoArbol (a^.hi,  c)
				else
					buscarCodigoArbol := buscarCodigoArbol (a^.hd, c);
		
		
		end;


end;
function buscarCodigoVector (v: vectorP; r: integer; c: integer): boolean;
begin
	buscarCodigoVector := buscarCodigoArbol (v[r], c);

end;



procedure inicializarMaximos (var m: vectorMax);
var
	i: integer;

begin
	for i := 1 to dimFR do
		begin
			m[i].codigo := -1;
			m[i].stock := -1;
		
		end;


end;
procedure maxArbol (a: arbolP; var m: max);
begin
	if (a<> nil) then
		begin
			m.codigo := a^.elem.codigo;
			m.stock:= a^.elem.stock;
			maxArbol (a^.hd, m);
		
		
		end;
		


end;
procedure maxCodigo (v: vectorP; var m: vectorMax);
var
	i: integer;
begin
	inicializarMaximos (m);
	for i:= 1 to dimFR do
		begin
			maxArbol (v[i], m[i]);
		

		end;


end;


procedure imprimirMaximos (m : vectorMax);
var
	i: integer;
begin
	for i := 1 to dimFR do
		begin
			writeln ('RUBRO: ', i, ', CODIGO MAXIMO: ', m[i].codigo, ' STOCK: ', m[i].stock);
		
		end;


end;



function cantEntreCodigos (a: arbolP; c1: integer; c2: integer): integer;
begin
	if (a = nil) then
		cantEntreCodigos := 0
	else
		begin
			if (a^.elem.codigo >= c1) and (a^.elem.codigo <= c2) then
				begin
					cantEntreCodigos := cantEntreCodigos (a^.hi, c1, c2) + cantEntreCodigos (a^.hd, c1, c2) + 1
				
				end
			
			else if (a^.elem.codigo < c1) then
				cantEntreCodigos := cantEntreCodigos (a^.hi, c1, c2)
			
			else
				cantEntreCodigos := cantEntreCodigos (a^.hd, c1, c2);
		
		end;
		
		
		
		
		
		
end;

procedure cantVectorRangos (v: vectorP; c1: integer; c2: integer; vr: vectorRangos);
var
	i: integer;
begin
	for i := 1 to dimFR do
		begin
			vr[i] := cantEntreCodigos (v[i], c1, c2);
		
		end;



end;

var
	v: vectorP;
	r: integer;
	c: integer;
	m: vectorMax;

begin
	cargarProductos (v);
	writeln ('INgrese un rubro a buscar el codigo');
	readln (r);
	writeln ('Ingrese el codigo a buscar en el rubro ', r);
	readln (c);
	if (buscarCodigoVector (v, r, c)) then
		writeln ('El codigo esta en el vector')
	else
		writeln ('El codigo no esta en vector');

	maxCodigo (v, m);
	imprimirMaximos (m);
	
	
	
end.
