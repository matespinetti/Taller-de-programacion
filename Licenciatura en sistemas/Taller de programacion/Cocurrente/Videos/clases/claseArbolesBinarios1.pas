program claseArbolesBinarios;
type
	arbol = ^nodo;         // declaracion del arbol binario
	nodo = record
		dato: integer;
		HI: arbol;   // hijo izquierdo
		HD: arbol;   // hijo derecho  
	end;
	
	

procedure crearArbol (var a : arbol; num : integer);
begin
	if (a = nil) then  
		begin
			new (a);
			a^.dato := num;
			a^.hi := nil;
			a^.hd := nil
		
		end
	else
		begin
			if (num < a^.dato) then
				crearArbol (a^.hi) // recursivo
			else
				crearArbol (a^.hd);
		
		end;


end;


procedure imprimirEnOrden (a: arbol);
begin
	if (a <> nil) then
		begin
			imprimirEnOrden (a^.hi);
			writeln (a^.dato);
			imprimirEnOrden (a^.hd);
		
		end;


end;


function buscar (a: arbol; x: elemento) : arbol;
begin
	if (a = nil) then
		buscar := nil
	else if (a^.dato = x) then
			buscar := a
		else
			begin
				if (x < a^.dato) then
					buscar := buscar (a^.hi, x)
				else
					buscar := buscar (a^.hd, x);

			end;
end;
var
	abb : arbol; x : integer;

begin
	abb := nil;
	read (x);
	while (x <> 0) do
		begin
			crearArbol (abb, x);
			read (x);
		
		end;

end.
