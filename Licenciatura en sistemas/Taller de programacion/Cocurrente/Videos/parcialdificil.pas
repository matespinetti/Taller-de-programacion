program parcialDificil;
type

	listaProyectos = ^nodoProyecto;
	
	nodoProyecto = record
		elem: string;
		sig: listaProyectos;

	end;
	
	voto = record
		alumno: string;
		proyectos: listaProyectos
	end;
	
	
	votoLectura = record
		alumno: string;
		proyecto: string;
	end;
	
	
	arbolVotos = ^nodoVotos;
	
	nodoVotos = record
		elem: voto;
		hi: arbolVotos;
		hd: arbolVotos;
	end;
	
	
	maxP = record
		alumno: string;
		topico: string;
		cantVotos: integer;
	end;
	
	
	

procedure leerVoto (var v: votoLectura);
begin
	writeln ('Ingrese el nombre del alumno');
	readln (v.alumno);
	writeln ('Ingrese el nombre del proyecto');
	readln (v.proyecto);
end;


procedure insertarOrdenado (var pi: listaProyectos; proyecto: string);
var
	nuevo, act, ant : listaProyectos;

begin
	new (nuevo);
	nuevo^.elem := proyecto;
	nuevo^.sig := nil;
	
	if (pi = nil) then
		pi := nuevo
	else
		begin
			act := pi;
			ant := pi;
			while ((act <> nil) and (nuevo^.elem > act^.elem)) do
				begin
					ant := act;
					act := act^.sig;
				
				end;
				
			if (act = pi) then
				begin
					nuevo^.sig := pi;
					pi := nuevo;
				
				end
			else
				begin
					ant^.sig := nuevo;
					nuevo^.sig := act;
				
				end;
		
		
		end;




end;

procedure crearArbol (var a: arbolVotos; v: votoLectura);
begin
	if (a = nil) then
		begin
			new (a);
			a^.elem.alumno := v.alumno;
			a^.elem.proyectos := nil;
			insertarOrdenado (a^.elem.proyectos, v.proyecto);
			a^.hi := nil;
			a^.hd := nil;
			
		
		
		end
	else
		begin
			if (a^.elem.alumno = v.alumno) then
				begin
					insertarOrdenado (a^.elem.proyectos, v.proyecto)
				
				end
			else if (v.alumno < a^.elem.alumno) then
					crearArbol (a^.hi, v)
				else
					crearArbol (a^.hd, v); 
		
		
		end;




end;
procedure cargarVotos (var a: arbolVotos);
var
	v: votoLectura;

begin
	leerVoto (v);
	while (v.alumno <> 'ZZZ') do
		begin
			crearArbol (a, v);
			leerVoto (v);
		
		
		end;




end;




procedure maximo (act : maxP; var  max: maxP);
begin
	if (act.cantVotos > max.cantVotos) then
		begin
			max := act;
		end;


end;



procedure procesarLista (pi: listaProyectos; var m: maxP; alumno: string; var votosTotales: integer);
var
	act : maxP;
begin
	while (pi <> nil) do
		begin
			act.alumno := alumno;
			act.topico := pi^.elem;
			act.cantVotos := 0;
			while ((pi <> nil) and (act.topico = pi^.elem)) do
				begin
					votosTotales := votosTotales + 1;
					act.cantVotos := act.cantVotos + 1;
					pi := pi^.sig;
				
				
				end;
				
			maximo (act, m);
			
		
		end;




end;

procedure procesarArbol (a: arbolVotos; var m : maxP; var votosTotales: integer);

begin
	if (a <> nil) then
		begin
			procesarArbol (a^.hi, m, votosTotales);
			procesarLista (a^.elem.proyectos, m, a^.elem.alumno, votosTotales);
			procesarArbol (a^.hd, m, votosTotales);
	
		
		end;



end;
	
	
procedure informarMaximo (m: maxP);
begin
	writeln ('El proyecto maximo, ALUMNO: ', m.alumno, ' TOPICO: ', m.topico, ' CANTIDAD DE VOTOS: ', m.cantVotos);


end;
var
	m: maxP;
	a: arbolVotos;
	votosTotales: integer;
	
begin
	votosTotales := 0;
	m.cantVotos := -9999;
	cargarVotos (a);
	procesarArbol (a, m, votosTotales);
	informarMaximo (m);
	writeln ('La cantidad de votos totales es  de', votosTotales);




end.
	

	
	
	
