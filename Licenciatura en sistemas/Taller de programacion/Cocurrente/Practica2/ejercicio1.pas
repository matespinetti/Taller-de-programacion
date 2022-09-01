program ejercicio1P2;
type
	vector = array [1 .. 10] of char;
	listaCaracteres = ^nodo;
	nodo = record
		elem : char;
		sig: listaCaracteres;
	end;
	
	

procedure ejercicioA (var v: vector; var dimL: integer);
var
	c: char;
begin
	writeln ('Ingrese un caracter');
	readln (c);
	if (c <> '.') and (dimL <=10) then
		begin
			dimL := dimL +1;
			v [dimL] := c;
			ejercicioA(v, dimL);
		
		end;


end;

procedure ejercicioB (v: vector; dimL : integer);
var
	i: integer;
begin
	for i := 1 to dimL do
		begin
			writeln (v[i]);
		
		end;

end;

procedure ejercicioC (v: vector; dimL: integer);
begin
	if (dimL>= 1) then
		begin
			
			ejercicioC (v, dimL-1);
			writeln (v[dimL]);
		
		end;


end;

function ejercicioD : integer;
var
	c: char;
begin
	writeln ('Ingrese un caracter');
	readln (c);
	if (c = '.') then
		begin
			ejercicioD:= 0;	
		end
	else
		ejercicioD := ejercicioD () + 1;


end;

procedure ejercicioD2 (var cant : integer);
var
	c: char;
begin
	writeln ('Ingrese un caracter');
	readln (c);
	if (c <> '.') then
		begin
			cant := cant + 1;
			ejercicioD2 (cant);
		
		end

	
end;

function factorial (n: integer): integer;
begin
	if (n = 0) then
		factorial := 1
	else
		factorial := n * factorial (n-1);


end;

procedure agregarAtras (var pi: listaCaracteres; var pu: listaCaracteres ; c: char);
var
	nuevo : listaCaracteres;
begin
	new (nuevo);
	nuevo ^.elem := c;
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
procedure ejercicioE (var pi: listaCaracteres; var pu: listaCaracteres);
var
	c: char;
begin
	writeln ('Ingrese un caracter');
	readln (c);
	
	if (c <> '.') then
		begin
			agregarAtras (pi, pu, c);
			ejercicioE (pi, pu);
		
		end;

end;	

procedure imprimirListaIZQDER (pi : listaCaracteres);
begin
	if (pi <> nil) then
		begin
			writeln (pi^.elem);
			imprimirListaIZQDER (pi^.sig);
		
		end;


end;

procedure imprimirListaDer (pi : listaCaracteres);
begin
	if (pi <> nil) then
		begin
			imprimirListaDer (pi^.sig);
			writeln (pi^.elem);
		
		end;
end;
var
	v: vector;
	i : integer;
	dimL, num : integer;
	cant : integer;
	pi, pu : listaCaracteres;
begin
	dimL := 0;
	cant := 0;
	pi := nil;
	ejercicioA (v, dimL);
	ejercicioC (v, dimL);
	//writeln (ejercicioD);
	//writeln ('La cantidad de caracteres es ', cant);
	//writeln ('Ingrese un numero a realizar factorial');
	//readln (num);
	//writeln (factorial (num));
	ejercicioE (pi, pu);
	imprimirListaDer(pi);
end.
