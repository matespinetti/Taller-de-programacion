program parcialFiguritas;
type
	figurita = record
		codigo: integer;
		jugador: integer;
		pais: integer;
	end;
	
	arbolFiguritas = ^nodo;
	
	nodo = record
		elem: figurita;
		hi: arbolFiguritas;
		hd: arbolFiguritas;
	end;
	

procedure leerFigurita (var f: figurita);
begin
	writeln ('Ingrese el codigo de figurita');
	readln (f.codigo);
	writeln ('Ingrese el codigo de jugador de la figurita');
	readln (f.jugador);
	writeln ('Ingrese el codigo de pais de la figurita');
	readln (f.pais);
	

end;
	
procedure crearArbol (var a: arbolFiguritas; f: figurita);
begin
	if (a = nil) then
		begin
			new(a);
			a^.elem := f;
			a^.hi := nil;
			a^.hd := nil;
		
		
		end
	else
		begin
			if (f.codigo <= a^.elem.codigo) then
				crearArbol (a^.hi, f)
			else
				crearArbol (a^.hd, f);
		
		
		end;



end;

procedure cargarFiguritas (var a: arbolFiguritas);
var
	f: figurita;

begin
	leerFigurita (f);
	while (f.codigo <> 0) do
		begin
			crearArbol (a, f);
			leerFigurita (f);
		
		
		end;



end;


procedure calcularVecesRepedita (a: arbolFiguritas; c: integer; var  cant: integer);
begin
	if (a <> nil) and (cant < 4) then
		begin
			writeln ('INGRESE A ', a^.elem.codigo);
			if (c <= a^.elem.codigo) then
				begin
					if (a^.elem.codigo = c) then
						cant := cant + 1;
					
					calcularVecesRepedita (a^.hi, c, cant)
				
				end
			else
				calcularVecesRepedita (a^.hd, c, cant);
		
		
		end;


end;


function calcularVecesRepetida (a: arbolFiguritas; c: integer): integer;
begin
	if (a = nil) then
		calcularVecesRepetida := 0
	else
		begin
			if (a^.elem.codigo = c) then
				calcularVecesRepetida := calcularVecesRepetida (a^.hi, c) + 1
			else if (c < a^.elem.codigo) then
					calcularVecesRepetida := calcularVecesRepetida (a^.hi, c)
			else
				calcularVecesRepetida := calcularVecesRepetida (a^.hd, c)
		
		
		
		
		
		end;



end;


function estaEnElArbol (a: arbolFiguritas; c: integer) : boolean;
begin
	if (a = nil) then
		estaEnElArbol := false
	else
		begin
			if (a^.elem.codigo = c) then
				estaEnElArbol := true
			else if (c <= a^.elem.codigo) then
				estaEnElArbol := estaEnElArbol (a^.hi, c)
			else
				estaEnElArbol := estaEnElArbol (a^.hd, c);
		
		
		
		end;



end;

function masDe4 (a: arbolFiguritas; c: integer): boolean;
var
	cant : integer;

begin
	cant := 0;
	calcularVecesRepedita (a, c, cant);
	masDe4 := (cant >= 4);
	


end;
	



var
	a: arbolFiguritas;
	cod : integer;

begin
	a := nil;
	cargarFiguritas (a);
	writeln ('Ingrese un codigo a comprobar si se repite 4 o mas veces');
	readln (cod);
	if (masDe4 (a, cod)) then
		writeln ('Esta repetida mas de 4 veces')
	else
		writeln ('No esta repetida mas de 4 veces');


if (estaEnElArbol (a, 10)) then
		writeln ('El codigo 10 esta en el arbol')
	else
		writeln ('El codigo 10 no esta en el arbol');

end.
	
	
