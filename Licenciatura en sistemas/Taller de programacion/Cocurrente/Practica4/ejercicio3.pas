program ejercicio4p4;
type
	RANGOSUCURSAL = 1..4;
	f = record
		dia: integer;
		mes: integer;
		ano: integer;
	end;
	
	venta = record
		fecha: f;
		codigoP: integer;
		sucursal: integer;
		cant: integer;
	end;
	
	listaV= ^nodoV;
	
	nodoV= record
		elem: venta;
		sig: listaV;
	end;
	
	vectorSucursales = array [RANGOSUCURSAL] of listaV;


	ventaT= record
		codigo: integer;
		cantTotal : integer;
	end;
	
	
	listaT = ^nodoT;
	
	nodoT = record
		elem: ventaT;
		sig: listaT;
	end;
	

procedure leerFecha (var fec: f);
begin
	writeln ('Ingrese el dia');
	readln (fec.dia);
	writeln ('Ingrese el mes');
	readln (fec.mes);
	writeln ('Ingrese el ano');
	readln (fec.ano);
end;

procedure leerVenta (var v: venta);
begin
	leerFecha (v.fecha);
	writeln ('Ingrese el codigo de producto');
	readln (v.codigoP);
	writeln ('Ingrese la sucursal');
	readln (v.sucursal);
	writeln ('Ingrese la cantidad vendida');
	readln (v.cant);
	


end;

procedure insertarOrdenado (var pi: listaV; v: venta);
var
	act, ant, nuevo: listaV;
begin
	new (nuevo);
	nuevo^.elem := v;
	nuevo^.sig := nil;
	
	if (pi = nil) then
		pi := nuevo
	else
		begin
			act := pi;
			ant := pi;
			while ((act <> nil) and (nuevo^.elem.codigoP > act^.elem.codigoP)) do
				begin
					ant := act;
					act := act^.sig;
				
				
				end;
			
			if (act = pi) then
				begin
					nuevo^.sig := pi;
					pi := nuevo
				
				end
			else
				begin
					ant^.sig := nuevo;
					nuevo^.sig := act;
				
				
				end;
		
		
		end;



end;


procedure inicializarVector(var v: vectorSucursales);
var
	i: integer;

begin
	for i := 1 to 4 do
		begin
			v[i] := nil;
		
		end;


end;
procedure cargarVentas (var v: vectorSucursales);
var
	ven : venta;

begin
	leerVenta (ven);
	while (ven.sucursal <> 0) do
		begin
			insertarOrdenado (v[ven.sucursal], ven);
			leerVenta (ven);
		
		
		end;



end;


procedure minimo (var vec: vectorSucursales;var minCod: integer; var cant: integer );
var
	indiceMin, i: integer;
	
begin
	minCod := 32000;
	for i := 1 to 4 do
		begin
			if (vec[i] <> nil) then
				if (vec[i]^.elem.codigoP <= minCod) then
					begin
						indiceMin := i;
						minCod := vec[i]^.elem.codigoP;
						cant := vec[i]^.elem.cant;
						
						
					
					
					end;
		
		
		end;


	if (minCod <> 32000) then
		vec[indiceMin] := vec[indiceMin]^.sig;






end;

procedure agregarAtras (var pi: listaT; var pu: listaT; v: ventaT);
var
	nuevo: listaT;
begin
	new(nuevo);
	nuevo^.elem := v;
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


procedure mergeListas (vec: vectorSucursales; var pi: listaT; var pu: listaT);
var
	minCod, cant : integer;
	v: ventaT;

begin
	pi := nil;
	minimo (vec, minCod, cant);
	while (minCod <> 32000) do
		begin
			v.cantTotal := 0;
			v.codigo := minCod;
			
			while ((minCod <> 32000) and (v.codigo = minCod)) do
				begin
					v.cantTotal := v.cantTotal + cant;
					minimo (vec, minCod, cant)
				
				end;
				
			agregarAtras (pi, pu, v);
		
		
		end;



end;


procedure imprimirLista (pi: listaT);
begin
	while (pi <> nil) do
		begin
			writeln ('El codigo de producto es ', pi^.elem.codigo, ' y la cantidad total vendida es ', pi^.elem.cantTotal);
			pi := pi^.sig;
		
		end;


end;
var
	v: vectorSucursales;
	pi, pu: listaT;

begin
	inicializarVector (v);
	cargarVentas (v);
	mergeListas (v, pi, pu);
	imprimirLista (pi);

end.


	
		

