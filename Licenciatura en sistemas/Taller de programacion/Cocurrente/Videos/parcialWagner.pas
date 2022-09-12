program parcial2022;
type
	pedido = record
		nRepartidor : integer;
		dirRetiro: string;
		dirEntrega: string;
		monto: real;
	end;
	

	pedidoT= record
		nRepartidor: integer;
		montoTotal: real;
		cant: integer;
	end;
	
	arbolT = ^nodoT;
	
	nodoT= record
		elem: pedidoT;
		hi : arbolT;
		hd: arbolT;
	end;
	
	
procedure leerPedido (var p: pedido);
begin
	writeln ('Ingrese en numero de repartidor');
	readln (p.nRepartidor);
	writeln ('Ingrese la direccion de retiro');
	readln (p.dirRetiro);
	writeln ('Ingrese la direccion de entrega');
	readln (p.dirEntrega);
	writeln ('Ingrese en monto');
	readln (p.monto);
	


end;


procedure crearArbol (var a: arbolT; p:pedido);
begin
	if (a = nil) then
		begin
			new (a);
			a^.elem.nRepartidor := p.nRepartidor;
			a^.elem.montoTotal := p.monto;
			a^.elem.cant := 1;
			a^.hi := nil;
			a^.hd := nil;
		
		
		end
	else
		begin
			if (p.nRepartidor = a^.elem.nRepartidor) then
				begin
					a^.elem.montoTotal := a^.elem.montoTotal + p. monto;
					a^.elem.cant := a^.elem.cant + 1
				
				end
			else if (p.nRepartidor <= a^.elem.nRepartidor) then
				crearArbol (a^.hi, p)
			else	
				crearArbol (a^.hd,p);
		
		
		end;


end;


procedure cargarPedidos (var a: arbolT);
var
	p: pedido;

begin
	leerPedido (p);
	while (p.dirEntrega <> 'ZZZ') do
		begin
			crearArbol (a, p);
			leerPedido(p);
		
		
		end;


end;



function cantEntreMontos(a: arbolT; m1: real; m2: real) : integer;
begin
	if (a = nil) then
		cantEntreMontos := 0
	else
		begin
			cantEntreMontos := cantEntreMontos (a^.hi, m1, m2) + cantEntreMontos (a^.hd, m1, m2);
			if ((a^.elem.montoTotal >= m1) and (a^.elem.montoTotal <= m2)) then	
				cantEntreMontos := cantEntreMontos + 1;
		
		end;



end;


procedure imprimirEntreDosRangos (a: arbolT; r1: integer; r2: integer);
begin
	if (a <> nil) then
		begin
			if ((a^.elem.nRepartidor >= r1) and (a^.elem.nRepartidor <= r2)) then
				begin
					imprimirEntreDosRangos (a^.hi, r1, r2);
					writeln ('El numero de repartidor es : ', a^.elem.nRepartidor, ' montoTotal: ', a^.elem.montoTotal, ' cantVendidas: ', a^.elem.cant);
					imprimirEntreDosRangos (a^.hd, r1, r2);
				
				end
			else
				begin
					if (a^.elem.nRepartidor < r1) then
						imprimirEntreDosRangos (a^.hd, r1, r2)
					else
						imprimirEntreDosRangos (a^.hi, r1, r2);
				
				
				end;
		
		
		
		end;



end;
var



	a: arbolT;
	m1, m2: real;

begin
	a := nil;
	cargarPedidos (a);
	writeln ('Ingrese el primer rango del monto a buscar');
	readln (m1);
	writeln ('Ingrese el segundo rango del monto a buscar');
	readln (m2);
	writeln ('La cantidad de repartidores que reclutaron un monto total entre ', m1, ' y ', m2, ' es de ', cantEntreMontos (a, m1, m2));
	imprimirEntreDosRangos (a, 10, 50);

end.




	

