program ejercicio2;


procedure descomponerNumero (num: integer);
var
	dig: integer;

begin
	if (num <> 0) then
		begin
			dig := num mod 10;
			descomponerNumero (num div 10);
			writeln (dig);
		
		end;


end;
procedure procesar ();
var
	num : integer;
begin
	writeln ('Ingrese un numero');
	readln (num);
	while (num <> 0) do
		begin
			descomponerNumero (num);
			writeln ('Ingrese un numero');
			readln (num);
		
		end;


end;

begin
	procesar (); 
	
	



end.
