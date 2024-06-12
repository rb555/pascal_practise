program LugaresTuristicos;

type
  LugarTuristico = record
    nombre: string;
    pais: string;
    siguiente: ^LugarTuristico;
  end;

  ListaLugares = ^LugarTuristico;

procedure inicializarLista(var lista: ListaLugares);
begin
  lista := nil;
end;

procedure agregarLugar(var lista: ListaLugares; nombre, pais: string);
var
  nuevoLugar: ListaLugares;
begin
  new(nuevoLugar);
  nuevoLugar^.nombre := nombre;
  nuevoLugar^.pais := pais;
  nuevoLugar^.siguiente := lista;
  lista := nuevoLugar;
end;

function longitudLista(lista: ListaLugares): integer;
var
  contador: integer;
begin
  contador := 0;
  while lista <> nil do
  begin
    contador := contador + 1;
    lista := lista^.siguiente;
  end;
  longitudLista := contador;
end;

function contarPais(lista: ListaLugares; paisBuscado: string): integer;
var
  contador: integer;
begin
  contador := 0;
  while lista <> nil do
  begin
    if lista^.pais = paisBuscado then
      contador := contador + 1;
    lista := lista^.siguiente;
  end;
  contarPais := contador;
end;

procedure eliminarLugar(var lista: ListaLugares; nombre: string);
var
  actual, anterior: ListaLugares;
begin
  actual := lista;
  anterior := nil;

  while (actual <> nil) and (actual^.nombre <> nombre) do
  begin
    anterior := actual;
    actual := actual^.siguiente;
  end;

  if actual <> nil then
  begin
    if anterior = nil then
      lista := actual^.siguiente
    else
      anterior^.siguiente := actual^.siguiente;
    dispose(actual);
  end;
end;

procedure eliminarPais(var lista: ListaLugares; pais: string);
var
  actual, anterior, temp: ListaLugares;
begin
  actual := lista;
  anterior := nil;

  while actual <> nil do
  begin
    if actual^.pais = pais then
    begin
      if anterior = nil then
      begin
        temp := actual;
        actual := actual^.siguiente;
        lista := actual;
        dispose(temp);
      end
      else
      begin
        temp := actual;
        anterior^.siguiente := actual^.siguiente;
        actual := actual^.siguiente;
        dispose(temp);
      end;
    end
    else
    begin
      anterior := actual;
      actual := actual^.siguiente;
    end;
  end;
end;

function generarListaPorPais(lista: ListaLugares; pais: string): ListaLugares;
var
  nuevaLista, actual: ListaLugares;
begin
  nuevaLista := nil;
  actual := lista;

  while actual <> nil do
  begin
    if actual^.pais = pais then
      agregarLugar(nuevaLista, actual^.nombre, actual^.pais);
    actual := actual^.siguiente;
  end;

  generarListaPorPais := nuevaLista;
end;

procedure agregarAlPrincipio(var lista: ListaLugares; nombre, pais: string);
begin
  agregarLugar(lista, nombre, pais);
end;

procedure imprimirLista(lista: ListaLugares);
begin
  writeln('Listado de lugares turisticos:');
  while lista <> nil do
  begin
    writeln('Nombre: ', lista^.nombre, ', Pais: ', lista^.pais);
    lista := lista^.siguiente;
  end;
end;

var
  miListaLugares: ListaLugares;
  longitud: integer;
  paisBuscado: string;
  contadorPais: integer;
  nombreLugarEliminar, paisEliminar: string;
  listaPorPais: ListaLugares;

begin
  inicializarLista(miListaLugares);

  agregarLugar(miListaLugares, 'Machu Picchu', 'Peru');
  agregarLugar(miListaLugares, 'Torre Eiffel', 'Francia');
  agregarLugar(miListaLugares, 'Gran Muralla China', 'China');
  agregarLugar(miListaLugares, 'Machu Picchu', 'Peru');
  agregarLugar(miListaLugares, 'Gran Muralla China', 'China');
  agregarLugar(miListaLugares, 'Cataratas del Iguazu', 'Argentina');

  longitud := longitudLista(miListaLugares);
  writeln('Longitud de la lista: ', longitud);

  paisBuscado := 'Peru';
  contadorPais := contarPais(miListaLugares, paisBuscado);
  writeln('Cantidad de lugares turisticos en ', paisBuscado, ': ', contadorPais);

  nombreLugarEliminar := 'Torre Eiffel';
  eliminarLugar(miListaLugares, nombreLugarEliminar);
  writeln('Lugar turistico ', nombreLugarEliminar, ' eliminado.');

  paisEliminar := 'China';
  eliminarPais(miListaLugares, paisEliminar);
  writeln('Se han eliminado todos los lugares turisticos de ', paisEliminar, '.');

  writeln('Lista de lugares turisticos actualizada:');
  imprimirLista(miListaLugares);

  writeln;

  paisBuscado := 'Peru';
  listaPorPais := generarListaPorPais(miListaLugares, paisBuscado);
  writeln('Lista de lugares turisticos en ', paisBuscado, ':');
  imprimirLista(listaPorPais);

  writeln;

  writeln('Agregando un nuevo lugar turistico al principio:');
  agregarAlPrincipio(miListaLugares, 'Coliseo Romano', 'Italia');
  imprimirLista(miListaLugares);
end.
