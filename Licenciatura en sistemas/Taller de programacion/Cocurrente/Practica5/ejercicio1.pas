program ejercicio1;
const
	dimF = 300;
type
	RANGOOFICINAS = 1..300;
	oficina = record
		codigo : integer;
		dni: integer;
		expensas: integer;
	end;
	
	vectorOficinas = array [RANGOOFICINAS] of oficina;
	
procedure leerOficina (var o: oficina);
begin
	writeln ('Ingrese el codigo de oficina');
	readln (o.codigo);
	writeln ('Ingrese el dni del propietario');
	readln (o.dni);
	writeln ('Ingrese el valor de expensa');
	readln (o.expensas);


end;

procedure cargarOficinas (var v: vectorOficinas; var dimL: integer);
var
	o: oficina;

begin
	dimL:= 0;
	leerOficina (o);
	while ((o.codigo <> -1) and (dimL < dimF)) do
		begin
			dimL := dimL + 1;
			v[dimL] := o;
			leerOficina (o);
		
		end;


end;

procedure ordenarVector (var v: vectorOficinas; dimL: integer);
var
	i, j, p : integer;
	item: oficina;

begin
	for i := 1 to dimL-1 do
		begin
			j:= i;
			
			for p := j to dimL do
				begin
					if (v[p].codigo < v[j].codigo ) then
						j := p;
				
				
				end;
		
		
			item := v[i];
			v[i] := v[j];
			v[j] := item;
		end;



end;


procedure ordenarSeleccion (var v: vectorOficinas; dimL: integer);
var
	i,j,k : integer;
	item: oficina;

begin
	for i := 2 to dimL do
		begin
			item := v[i];
			j := i-1;
			while ((j>0)and(item.codigo < v[j].codigo))  do
				begin
					v[j+1] := v[j];
					j := j-1
				end;
				
				v[j+1] := item;
		
		
		end;



end;


procedure busquedaDicotomica (v: vectorOficinas; dimL: integer; c: integer);
var
	pri, med, ult: integer;

begin
	pri := 1;
	ult := dimL;
	med := (pri + ult) div 2;
	
	while ((pri <= ult) and (v[med].codigo <> c )) do
		begin
			if (c < v[med].codigo) then
				ult := med -1
			else
				pri := med + 1;
			
			
			med := (pri + ult) div 2;
		
		end;

	if (pri <= ult) and (v[med].codigo = c) then
		writeln ('El dni del propietario con codigo ', c, ' es ', v[med].dni)
	else
		writeln ('El codigo no se encontro en el vector')
end;

procedure imprimirVector (v: vectorOficinas; dimL: integer);
var
	i: integer;

begin
	for i := 1 to dimL do
		begin
			writeln (v[i].codigo);
		
		end;


end;


function expensasTotales (v: vectorOficinas; dimL: integer): integer;
begin
	if (dimL = 0) then
		expensasTotales := 0
	else
		expensasTotales := expensasTotales (v, dimL-1) + v[dimL].expensas;


end;
var
	v: vectorOficinas;
	dimL: integer;
	cod: integer;

begin
	cargarOficinas (v, dimL);
	ordenarSeleccion(v, dimL);
	imprimirVector (v, dimL);
	writeln ('Ingrese un codigo a buscar en el arreglo');
	readln (cod);
	busquedaDicotomica (v, dimL, cod);
	writeln ('Las expensas totales son ', expensasTotales (v, dimL));
end.
