program ejercicio4p5;
const
	dimF = 7;
type
	RANGODIA = 1..dimF;
	entrada = record
		dia: RANGODIA;
		codigo: integer;
		asiento: integer;
		monto: real;
	end;
	

	listaE = ^nodoE;
	nodoE= record
		elem: entrada;
		sig: listaE;
	end;
	
	
	entradaT = record
		codigo: integer;
		montoTotal: real;
		cant: integer;
	end;
	
	
	listaT = ^nodoT;
	
	nodoT = record
		elem: entradaT;
		sig : listaT;
	end;
	
	
	vectorDias = array [RANGODIA] of listaE;
	


procedure leerEntrada (var e: entrada);
begin
	writeln ('Ingrese el dia de la entrada');
	readln (e.dia);
	writeln ('Ingrese el codigo de la entrada');
	readln (e.codigo);
	writeln ('Ingrese el asiento de la entrada');
	readln (e.asiento);
	writeln ('Ingrese el monto de la entrada');
	readln (e.monto);


end;


procedure insertarOrdenado (var pi: listaE; e: entrada);
var
	nuevo, act, ant: listaE;

begin
	new (nuevo);
	nuevo^.elem := e;
	nuevo^.sig := nil;
	if (pi = nil) then
		pi := nuevo
	else
		begin
			act := pi;
			ant := pi;
			while ((act <> nil) and (nuevo^.elem.codigo > act^.elem.codigo)) do	
				begin
					ant := act;
					act := act^.sig;
				
				
				end;
			
			if (act = pi) then
				begin
					nuevo^.sig := pi;
					nuevo:= pi;
				end
			else
				begin
					ant^.sig := nuevo;
					nuevo^.sig := act;
				
				
				end;
		
		
		end;



end;
		
	
procedure inicializarVectorDias (var v: vectorDias);
var
	i: integer;

begin
	for i := 1 to dimF do
		begin
			v[i] := nil;
		
		end;



end;
procedure cargarEntradas (var v: vectorDias);
var	
	e: entrada;

begin
	leerEntrada (e);
	while (e.codigo <> 0) do
		begin
			insertarOrdenado (v[e.dia], e);
			leerEntrada (e);
		
		end;


end;


procedure minimo (var v: vectorDias; var e: entradaT);
var
	minIndice, i: integer;

begin
	e.codigo := 32000;
	for i := 1 to dimF do
		begin
			if (v[i] <> nil) then
				if (v[i]^.elem.codigo < e.codigo) then
					begin
						minIndice := i;
						e.codigo := v[i]^.elem.codigo;
						e.montoTotal := v[i]^.elem.monto;
					
					end;
		
		
		end;
		
	
	if (e.codigo <> 32000) then
		v[minIndice] := v[minIndice]^.sig;





end;


procedure agregarAtras (var pi: listaT; var pu: listaT; cod: integer; m: real; cant: integer );
var
	nuevo: listaT;
begin
	new (nuevo);
	nuevo^.elem.codigo := cod;
	nuevo^.elem.montoTotal := m;
	nuevo^.elem.cant := cant;
	
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

procedure merge (v: vectorDias; var pi: listaT; var pu: listaT);
var
	codigoActual : integer;
	montoT : real;
	e: entradaT;
begin
	pi := nil;
	minimo (v, e);
	while (e.codigo <> 32000) do
		begin
			e.cant := 0;
			codigoActual := e.codigo;
			montoT := 0;
			while ((e.codigo <> 32000) and (codigoActual = e.codigo)) do
				begin
					e.cant := e.cant + 1;
					montoT := montoT + e.montoTotal;
					minimo (v, e);
				
				end;
				
			agregarAtras (pi, pu, codigoActual, montoT, e.cant);
		
		end;






end;


procedure imprimirRecursivo (pi: listaT);
begin
	if (pi <> nil) then
		begin
			writeln ('CODIGO: ', pi^.elem.codigo, ' CANTVENDIDAS: ', pi^.elem.cant, ' MONTO TOTAL: ', pi^.elem.montoTotal);
			imprimirRecursivo (pi^.sig);
		
		end;


end;

var
	v: vectorDias;
	pi, pu: listaT;

begin
	inicializarVectorDias (v);
	cargarEntradas(v);
	merge (v, pi, pu);
	imprimirRecursivo (pi);

end.
