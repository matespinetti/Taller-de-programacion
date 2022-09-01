program ejercicio3;
type
	lista = ^nodo;
	nodo = record
		elem : integer;
		sig : lista;
	end;


procedure agregarAdelante (var pi : lista; x: integer);
var
	nuevo : lista;

begin
	new (nuevo);
	nuevo^.elem := x;
	nuevo^.sig := nil;
	
	if (pi = nil) then
		pi := nuevo
	else
		begin
			nuevo^.sig := pi;
			pi := nuevo;
		
		end;


end;
procedure generarLista (var pi : lista);
var
	num : integer;
begin
	writeln ('Ingrese un numero');
	readln (num);
	if (num <> 0) then
		begin
			agregarAdelante (pi, num);
			generarLista (pi);
		
		end;


end;

procedure imprimirLista (pi : lista);
begin
	while (pi <> nil) do
		begin
			writeln (pi^.elem);
			pi := pi^.sig;
		
		end;

end;

procedure encontrarMinimo (pi : lista; var min: integer);
begin
	if (pi <> nil) then
		begin
			if (pi^.elem < min) then
				min := pi^.elem;
			
			encontrarMinimo (pi^.sig, min);
		
		end;


end;

function minNum (pi: lista): integer;
begin
	if (pi^.sig = nil) then
		minNum := pi^.elem
	else
		begin
			minNum:= minNum (pi^.sig);
			
			if (pi^.elem < minNum) then
				minNum := pi^.elem
				
		
		end;


end;



function maxNum (pi: lista): integer;
begin
	if (pi^.sig = nil) then
		maxNum := pi^.elem
	else
		begin
			maxNum := maxNum (pi^.sig);
			
			if (pi^.elem > maxNum) then
				maxNum := pi^.elem
				
		
		end;


end;

function estaEnLaLista (pi : lista; valor: integer) : boolean;
var
	esta : boolean;
begin
	if (pi = nil) then
		estaEnLaLista := false
	else
		begin
			esta := estaEnLaLista (pi^.sig, valor);
			if ((esta = false) and (pi^.elem = valor)) then
				begin
					estaEnLaLista := true;
				
				end
			else
				estaEnLaLista := esta;
				
			
		end;
		


end;


function encontrarValor (pi : lista; valor:integer): boolean;
var
	esta : boolean;

begin
	writeln ('Entre');
	if (pi = nil) then
		encontrarValor := false
	else
		if (pi^.elem = valor) then
			encontrarValor := true
	
		else
			encontrarValor := encontrarValor (pi^.sig, valor);
		



end;



var
	pi : lista;
	min : integer;
	valor : integer;
begin
	min :=32000;
	pi := nil;
	generarLista (pi);
	imprimirLista (pi);
	encontrarMinimo (pi, min);
	writeln (minNum(pi));
	writeln (maxNum (pi));
	
	
	writeln ('Ingrese un valor a buscar ');
	readln (valor);
	
	
	if (encontrarValor (pi, valor)) then
		writeln (valor, ' esta en la lista')
	else
		writeln (valor, 'no esta en la lista');
end.

