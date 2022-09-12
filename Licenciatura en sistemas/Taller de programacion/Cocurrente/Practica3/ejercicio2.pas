program ejercicio2;
type
	f = record
		dia: integer;
		mes: integer;
		ano: integer;
	end;
	
	
	venta = record
		codigo : integer;
		fecha : f;
		cantVendidas : integer;
	end;
	
	
	arbolVentas = ^nodo;
	
	nodo = record
		elem: venta;
		hi: arbolVentas;
		hd: arbolVentas;
	end;
	
	
	producto = record
		codigo : integer;
		cant : integer;
	end;
	
	
	arbolP = ^nodoP;
	
	nodoP = record
		elem : producto;
		hi: arbolP;
		hd : arbolP;
	end;
	
	
	
	

procedure leerFecha (var fecha: f);
begin
	writeln ('Ingrese el dia');
	readln (fecha.dia);
	writeln ('Ingrese el mes');
	readln (fecha.mes);
	writeln ('Ingrese el año');
	readln (fecha.ano);



end;


procedure leerVenta (var v: venta);
begin
	writeln ('Ingrese el codigo de la venta');
	readln (v.codigo);
	leerFecha (v.fecha);
	writeln ('Ingrese la cantidad vendidas');
	readln (v.cantVendidas);
	
	

end;
procedure crearArbol (var a: arbolVentas; v: venta);
begin
	if (a = nil) then
		begin
			new (a);
			a^.elem := v;
			a^.hi := nil;
			a^.hd := nil
		
		
		end
	else
		begin
			if (v.codigo > a^.elem.codigo) then
				crearArbol (a^.hd, v)
			else
				crearArbol (a^.hi, v);
		
		
		end;



end;

procedure crearArbolP (var a: arbolP; v: venta);
begin
	if (a = nil) then
		begin
			new (a);
			a^.elem.codigo := v.codigo;
			a^.elem.cant := v.cantVendidas;
			a^.hi := nil;
			a^.hd := nil;
		
		end
	else
		begin
			if (v.codigo = a^.elem.codigo) then
				a^.elem.cant := a^.elem.cant + v.cantVendidas
			else if (v.codigo > a^.elem.codigo) then
				crearArbolP (a^.hd, v)
			else
				crearArbolP (a^.hi, v);
		
		
		end;



end;

procedure cargarVentas (var AP: arbolP; var AV: arbolVentas);
var
	v: venta;

begin
	leerVenta (v);
	while (v.codigo <> 0) do
		begin
			crearArbol (AV, v);
			crearArbolP (AP, v);
			leerVenta(v);
		
		
		end;




end;

procedure imprimirProducto (p : producto);
begin
	writeln ('El codigo de producto es ', p.codigo, ' y la cantidad total vendidas es ', p.cant);

end;
procedure imprimirArbolP (AP: arbolP);
begin
	if (AP <> nil) then
		begin
			imprimirArbolP (AP^.hi);
			imprimirProducto (AP^.elem);
			imprimirArbolP (AP^.hd);
		
		
		end;


end;



function vendidasCodigo(AV : arbolVentas; codigo: integer) : integer;
begin
	if (AV = nil) then
		vendidasCodigo := 0
	else
		begin
			if (AV^.elem.codigo = codigo) then
				vendidasCodigo := AV^.elem.cantVendidas + vendidasCodigo (AV^.hi, codigo)
			else
				if (codigo > AV^.elem.codigo) then
					vendidasCodigo := vendidasCodigo (AV^.hd, codigo)
				else
					vendidasCodigo := vendidasCodigo (AV^.hi, codigo);
				
				
				
		
		
		end;



end;

function vendidasCodigo2(AP : arbolP; codigo: integer) : integer;
begin
	if (AP = nil) then
		vendidasCodigo2 := 0
	else
		begin
			if (AP^.elem.codigo = codigo) then
				vendidasCodigo2 := AP^.elem.cant
			else
				if (codigo > AP^.elem.codigo) then
					vendidasCodigo2 := vendidasCodigo2 (AP^.hd, codigo)
				else
					vendidasCodigo2 := vendidasCodigo2 (AP^.hi, codigo);
				
				
				
		
		
		end;



end;

var
	AP: arbolP;
	AV: arbolVentas;
	cod : integer;
	
begin
	AP := nil;
	AV := nil;
	cargarVentas (AP, AV);
	imprimirArbolP (AP);
	writeln ('Ingrese un codigo a buscar en el arreglo');
	readln (cod);
	writeln ('La cantidad vendidas del producto con codigo ', cod, ' es ', vendidasCodigo (AV, cod));
	writeln ('La cantidad vendidas del producto con codigo ' ,cod, ' es', vendidasCodigo2 (AP, cod));

end.




