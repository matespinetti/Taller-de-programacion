program ejercicio2;
const
	dimF = 300;

type
	oficina = record
		codigo : integer;
		dni: Longint;
		expensas : integer;
	end;
	
	oficinas = array [1 .. dimF] of oficina;


procedure leerOficina (var o: oficina);
begin
	writeln ('Ingrese el codigo de oficina');
	readln(o.codigo);
	randomize;
	o.dni := random (2000);
	randomize;
	o.expensas := random (300);
	//writeln ('Ingrese  el dni del dueño');
	//readln (o.dni);
	//writeln ('Ingrese  las expensas de la  oficina');
	//readln (o.expensas);
	
end;


procedure cargarOficinas (var vec: oficinas; var dimL: integer);
var
	o: oficina;

begin
	leerOficina (o);
	dimL := 0;
	while ((o.codigo <> -1) and (dimL <= dimF)) do
		begin
			dimL := dimL +1;
			vec[dimL] := o;
			leerOficina (o);
		
		end;


end;


procedure ordernarInsercion (var vec: oficinas; var dimL: integer);
var
	actual: oficina;
	i, j: integer;

begin
	for i := 2 to dimL do
		begin
			actual := vec[i];
			j := i-1;
			while ((j >=1) and (actual.codigo < vec[j].codigo)) do
				begin
					vec[j+1] := vec[j];
					j:= j-1;
				
				end;
			
			vec[j+1] := actual;
		
		end;



end;


procedure ordenarSeleccion (var v: oficinas; dimL: integer);
var
	item : oficina;
	p, i, j: integer;

begin
	for i := 1 to dimL-1 do 
		begin
			p := i;
			for j := i+1 to dimL do
				begin
					if (v[j].codigo < v[p].codigo)then
						p := j;
				
				end;

			item := v[i];
			v[i] := v[p];
			v[p] := item;
		
		end;


end;

procedure imprimirVector (var o: oficinas ; var dimL: integer);
var
	i: integer;
begin
	for i := 1 to dimL do
		begin
			writeln ('El codigo de oficina es ', o[i].codigo);
		
		end;


end;
var
	o: oficinas;
	dimL: integer;
begin
	cargarOficinas (o, dimL);
	imprimirVector(o, dimL);
	//ordernarInsercion (o, dimL);
	ordenarSeleccion(o, dimL);
	writeln ('DESDE ACA ORDENADOS');
	imprimirVector(o, dimL);



end.
