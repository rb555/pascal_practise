program viajesBahiaBlanca;
uses GenericLinkedList;
type
	viaje=record
		codigo:integer;
		colectivo:integer;
		mes:integer;
		pasajes:integer;
		dniChofer:integer;
		end;
		vector= array[1..80] of integer;
		ListaViajes = specialize LinkedList<viaje>;

var
	prom: real;
	vcapacidades, vtotales:vector;
	lv,lmes5:ListaViajes;
//declaro el procedimiento que va a inicializar los contadores
procedure inicializarTotales(var vc:vector);
var
	i:integer;
begin
	for i:=1 to 80 do
	vc[i]:=0;
end;
//declaro la funcion que va a calcular cual es el colectivo con mas viajes
function colectivoMasViajes(v:vector):integer;
var
	i,posMax:integer;
	max:integer;
begin
	max:=-1;
	for i:=1 to 80 do begin
		if(v[i]>max)then
		begin
			max:= v[i];
			posMax:=i;
		end;
	end;
	colectivoMasViajes:= posMax;
end;
//declaro el procedimiento que va a recorrer la lista de viajes
procedure recorrerLista(lv: ListaViajes; vcoches:vector; var listaM5: ListaViajes; var vtotal:vector; var promedio:real);
var
	cantpasajes, cantviajes: integer; //declaracion de variables
begin
	listM5:= ListaViajes.create();
	cantPasajes:=0;
	cantPasajes:=0;
	lv.reset();
	
	while (not lv.eol())do begin
	vtotal[lv.current().colectivo]:=vtotal[lv.current().colectivo]+1;
	cantviajes:=cantviajes +1;
	cantpasajes:=cantpasajes + lv.current().pasajes;
	if(lv.current().mes=5) and (lv.current.pasajes<vcoches[lv.current().colectivo]) then
		listaM5.add(lv.current());
	lv.next();
	end;
	promedio:= cantpasajes/cantviajes;
end;
	
begin
	cargarListaViajes(lv);
	cargarcapacidades(vcapacidades);
	inicializarTotales(vtotales);
	recorrerLista(lv,vcapacidades,lmes5,vtotales,prom);
	writeln('El colectivo con mas viajes es:',colectivoMasViajes(vtotales));
	writeln('El promedio de pasajeros es:',prom);
end.
		
