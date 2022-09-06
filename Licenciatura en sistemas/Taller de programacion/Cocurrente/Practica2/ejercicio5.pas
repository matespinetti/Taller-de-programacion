program ejercicio5;
type
	vector = array [1..1] of integer;

procedure busquedaDicotomica (v: vector; pri, ult: integer; dato: integer; var pos: integer);
var
	med : integer;

begin
	med := (pri + ult) div 2;
	if (pri > ult) then
		pos := -1	
		
	else if (v[med] = dato) then
			pos  := med
	else
		begin
			if (dato > v[med]) then
				pri := med + 1
			else
				ult := med -1;
		
			busquedaDicotomica (v,pri, ult, dato, pos )
		end;



end;


var
	v: vector;
	pri, ult, dato, pos, i: integer;
	
begin
	pri := 1;
	ult := 1;
	
	for i := pri to ult do
		begin
			writeln ('Ingrese un numero');
			readln (v[i]);
		
		
		end;
		
	writeln ('Ingrese un valor a buscar');
	readln (dato);
	busquedaDicotomica (v, pri, ult, dato, pos);
	if (pos <> -1) then
		writeln ('El dato esta en la posicion ', pos)
	else
		writeln ('El dato no esta en el vector');

end.

