program ejercicio1;
const
	dimF = 20;
type
	venta = record
		codigo : integer;
		cantVendida : 0..99;
	end;

	vectorVentas = array [1..dimF] of venta;
	
	
	listaPares = ^nodoVenta;
	
	nodoVenta = record
		elem : venta;
		sig : listaPares;
	end;
	
	
	


procedure leerVenta (var v: venta);
begin
	randomize;
	v.codigo := random(16);
	writeln ('Ingrese la cantidad vendidas del producto ', v.codigo );
	readln (v.cantVendida);


end;

procedure cargarVentas (var vec: vectorVentas; var dimL: integer);
var
	v : venta;
begin
	dimL := 0;
	leerVenta (v);
	while ((dimL < dimF) and (v.codigo <> 0)) do
		begin
			dimL := dimL + 1;
			vec[dimL] := v;
			leerVenta(v);
			
		end;
		

end;


procedure imprimirVector (vec : vectorVentas; dimL : integer);
var
	i : integer;
	
begin
	for i := 1 to dimL do
		begin
			writeln ('El codigo de compra de la venta es ', vec[i].codigo, ' cantidad : ', vec[i].cantVendida);
		
		
		end;


end;


procedure ordenarVector (var v: vectorVentas; dimL: integer);
var
	item : venta; 
	i,j,k : integer;

begin
	for i := 1 to dimL-1 do 
		begin
			k := i;
			for j := i+1 to dimL do
				begin
					if (v[k].codigo > v[j].codigo) then
						k := j;
				
				end;
			
			item := v[k];
			v[k] := v[i];
			v[i] := item;
		
		end;



end;

procedure buscarPosiciones (v : vectorVentas; dimL: integer; v1: integer; v2: integer; var pos1: integer; var pos2: integer );
var
	i, j: integer;
	encontreV1 : boolean;
begin
	
	pos1 := -1;
	pos2 := -1;
	i:= 1;
	while ((i<= dimL) and (v[i].codigo < v1)) do
		begin
			i := i +1;
		
		end;
	if (pos1 <= dimL) then
		pos1 := i;
		
	j:= dimL;
	while ((j >= 1) and (v[j].codigo > v2 )) do
		begin
			j:= j-1;
		
		end;
	
	if ((j >= 1)) then
		pos2 := j;



end;

procedure eliminarVector (var v: vectorVentas; var dimL : integer; v1: integer; v2: integer; var pudeEliminar: boolean);
var
	pos1, pos2, cantEliminar,  i: integer;
begin
	buscarPosiciones (v, dimL, v1, v2, pos1, pos2);
	if ((pos1 <> -1) and (pos2 <> -1)) then
		begin
			cantEliminar := pos2 - pos1 + 1;
			for i := pos2+1 to dimL do
				begin
					v[i-cantEliminar] := v[i];
				
				
				end;
			dimL := dimL - cantEliminar;
			pudeEliminar := true;
		
		
		end
	else
		pudeEliminar := false;


end;


procedure insertarOrdenado (var pi: listaPares; v: venta);
var
	nuevo, act, ant : listaPares;
begin
	new (nuevo);
	nuevo^.elem := v;
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



procedure generarListaPares (v: vectorVentas; dimL: integer; var pi: listaPares);
var
	i: integer;
begin
	for i := 1 to dimL do
		begin
			if ((v[i].codigo mod 2) = 0) then
				insertarOrdenado (pi, v[i]);
		
		
		end;



end;

procedure imprimirLista (pi : listaPares);
begin
	while (pi <> nil) do
		begin
			writeln ('El codigo de venta es ', pi^.elem.codigo, ' y la cantidad vendidos es ', pi^.elem.cantVendida);
			pi := pi^.sig;
		end;


end;
var
	v : vectorVentas;
	dimL, v1, v2 : integer;
	pudeEliminar : boolean;
	pi : listaPares;

	
begin
	pi := nil;
	cargarVentas (v, dimL);
	ordenarVector (v, dimL);
	imprimirVector (v, dimL);
	
	writeln ('Ingrese el primer valor del rango a eliminar');
	readln (v1);
	writeln ('Ingrese el segundo valor del rango a eliminar');
	readln (v2);
	eliminarVector (v, dimL,v1, v2, pudeEliminar );
	imprimirVector (v, dimL);
	generarListaPares (v, dimL, pi);
	imprimirLista (pi);

end.
