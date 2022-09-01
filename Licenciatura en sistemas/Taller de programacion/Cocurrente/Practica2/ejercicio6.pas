program ejercicio6;
procedure decimalABinario (num : integer);
begin
	if (num <> 0) then
		begin
			decimalABinario (num DIV 2);
			write (num MOD 2);
		
		end;



end;

var
	num: integer;

begin
	writeln ('Ingrese un numero');
	readln (num);
	decimalABinario (num);



end.

