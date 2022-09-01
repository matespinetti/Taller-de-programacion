program ejercicio4;
const
	dimFRubro = 8;
	dimFRubro3 = 30;
type
	RANGORUBRO = 1..dimFRubro;
	producto = record
		codigo : integer;
		rubro : RANGORUBRO;
		precio : real;
	end;
	
	listaProductos = ^nodo;
	
	nodo = record
		elem: producto;
		sig: listaProductos;
	end;
	
	vectorRubros = array [RANGORUBRO] of listaProductos;
	
	vectorRubro3 = array [1 .. dimFRUbro3] of producto;
	

procedure leerProducto (var p: producto);
begin
	randomize;
	p.codigo := random(300);
	writeln ('El codigo del producto es ', p.codigo);
	randomize;
	p.rubro := random (8) + 1;
	writeln ('El rubro del producto es ', p.rubro);
	writeln ('Ingrese el precio del producto');
	readln (p.precio);

end;
procedure crearListas (var v: vectorRubros);
var
	i: integer;

begin
	for i:= 1 to dimFRubro do
		v[i] := nil;


end;
procedure insertarOrdenado (var pi: listaProductos; p: producto);
var
	nuevo, act, ant : listaProductos;

begin
	new (nuevo);
	nuevo^.elem := p;
	nuevo^.sig := nil;
	
	if (pi = nil) then
		pi := nuevo
	else
		begin
			ant := pi;
			act := pi;
			while ((act <> nil) and (p.codigo > act^.elem.codigo)) do
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


procedure cargarProductos (var v: vectorRubros);
var
	p: producto;

begin
	leerProducto (p);
	while (p.precio <> 0) do
		begin
			insertarOrdenado (v[p.rubro], p);
			leerProducto (p);
		
		
		end;


end;


procedure imprimirCodigos (v: vectorRubros);
var
	i: integer;

begin
	for i := 1 to dimFRubro do
		begin
			while (v[i] <> nil) do
				begin
					writeln ('codigo : ', v[i]^.elem.codigo, ', rubro: ', v[i]^.elem.rubro, ' precio : ', v[i]^.elem.precio);
					v[i] := v[i]^.sig;
				end;
		
		
		end;



end;


procedure generarRubro3 (pi : listaProductos; var r: vectorRubro3; var dimL: integer)
begin
	dimL := 0;
	while (pi <> nil) do
		begin
			if (dimL <= dimFRubro3) then
				begin
					dimL := dimL + 1;
					r [dimL] := pi^.elem
				end;
		end;


end;
var
	v: vectorRubros;
	r : vectorRubro3;
	dimLRubro3: integer;

begin
	cargarProductos (v);
	imprimirCodigos (v);
	generarRubro3 (v[3], r, dimLRubro3 );
	


end.
