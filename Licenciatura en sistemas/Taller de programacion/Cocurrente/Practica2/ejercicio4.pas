program ejercicio4;
type
	vectorNumeros = array [1..20] of integer;
	
procedure generarVector (var v: vectorNumeros; var dimL: integer);
var
	num: integer;
begin
	num := random (101);
	if (num <> 0) and (dimL < 20) then
		begin
			dimL := dimL + 1;
			v[dimL] := num;
			generarVector (v, dimL);
		
		end;


end;

procedure imprimirVector (v: vectorNumeros; dimL: integer);
var
	i: integer;

begin
	for i := 1 to dimL do
		begin
			writeln (v[i]);
		
		end;


end;

function maxNum (v: vectorNumeros; dimL: integer): integer;
begin
	if (dimL = 1) then
		maxNum := v[dimL]
	else
		begin
			maxNum := maxNum (v, dimL-1);
			
			if (v[dimL] > maxNum) then
				maxNum := v[dimL];
				
		
		end;


end;

function suma (v: vectorNumeros; dimL : integer) : integer;
begin
	if (dimL = 1) then
		suma := v[dimL]
	else
		begin
			suma := suma (v, dimL-1) + v[dimL];
		
		end;



end;

var
	v: vectorNumeros;
	dimL : integer;

begin
	generarVector (v, dimL);
	imprimirVector (v, dimL);
	writeln ('El valor maximo es ', maxNum (v, dimL));
	writeln ('La suma de los valores es de ', suma (v, dimL));

end.
