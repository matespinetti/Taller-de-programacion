program recursion;
function potencia (num : integer; n: integer): integer;
begin
	if (n = 0) then
		potencia := 1
	else
		begin
			potencia := num * potencia (num, n-1);
		
		end;


end;

var
	x1, x2 : integer;

begin
	writeln ('Ingrese un numero');
	readln (x1);
	writeln ('Ingrese la potencia a elevar');
	readln (x2);
	writeln (potencia (x1, x2));


end.
