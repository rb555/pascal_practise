program SupermercadoLinkedList;

uses GenericLinkedList;

type
  Producto = record
    codigo: integer;
    descripcion: string;
    stockActual: integer;
    stockMinimo: integer;
    precio: real;
  end;

  ListaProductos = specialize LinkedList<Producto>;

var
  productos: ListaProductos;
  porcentajeProductosDebajoMinimo: real;
  codigo1, codigo2: integer;
  nuevoProducto: Producto;
  
//inicializacion de la lista
procedure inicializarLista(var lista: ListaProductos);
begin
  lista := ListaProductos.create();
end;

//agregar producto a la lista
procedure agregarProducto(var lista: ListaProductos; nuevoProducto: Producto);
begin
  lista.reset();
  while not lista.eol() and (lista.current().codigo < nuevoProducto.codigo) do
    lista.next();
  lista.insertCurrent(nuevoProducto);
end;

//leer producto
procedure leerProducto(var p: Producto);
begin
  writeln('Ingrese el codigo del producto (0 para terminar):');
  readln(p.codigo);
  if p.codigo <> 0 then
  begin
    writeln('Ingrese la descripcion del producto:');
    readln(p.descripcion);
    writeln('Ingrese el stock actual del producto:');
    readln(p.stockActual);
    writeln('Ingrese el stock minimo del producto:');
    readln(p.stockMinimo);
    writeln('Ingrese el precio del producto:');
    readln(p.precio);
  end;
end;

//calcular porcentaje de productos con stock por debajo del minimo
procedure calcularPorcentajeStockMinimo(var lista: ListaProductos; var porcentaje: real);
var
  productosDebajoMinimo, totalProductos: integer;
begin
  productosDebajoMinimo := 0;
  totalProductos := 0;
  lista.reset();

  while not lista.eol() do
  begin
    totalProductos := totalProductos + 1;
    if lista.current().stockActual < lista.current().stockMinimo then
      productosDebajoMinimo := productosDebajoMinimo + 1;
    lista.next();
  end;

  if totalProductos > 0 then
    porcentaje := (productosDebajoMinimo / totalProductos) * 100
  else
    porcentaje := 0;
end;

//imprimir descripcion de productos con codigo par
procedure imprimirDescripcionProductosPar(var lista: ListaProductos);
begin
  writeln('Descripcion de los productos con codigo par:');
  lista.reset();
  while not lista.eol() do
  begin
    if lista.current().codigo mod 2 = 0 then
      writeln(lista.current().descripcion);
    lista.next();
  end;
end;

//obtener productos mas economicos
procedure obtenerProductosMasEconomicos(var lista: ListaProductos; var codigo1, codigo2: integer);
var
  precio1, precio2: real;
begin
  codigo1 := -1;
  codigo2 := -1;
  precio1 := MaxInt;
  precio2 := MaxInt;

  lista.reset();
  while not lista.eol() do
  begin
    if lista.current().precio < precio1 then
    begin
      precio2 := precio1;
      codigo2 := codigo1;
      precio1 := lista.current().precio;
      codigo1 := lista.current().codigo;
    end
    else if lista.current().precio < precio2 then
    begin
      precio2 := lista.current().precio;
      codigo2 := lista.current().codigo;
    end;
    lista.next();
  end;
end;

//imprimir lista de productos
procedure imprimirLista(var lista: ListaProductos);
begin
  writeln('Listado de productos:');
  lista.reset();
  while not lista.eol() do
  begin
    writeln('Codigo: ', lista.current().codigo);
    writeln('Descripcion: ', lista.current().descripcion);
    writeln('Stock Actual: ', lista.current().stockActual);
    writeln('Stock Minimo: ', lista.current().stockMinimo);
    writeln('Precio: ', lista.current().precio);
    writeln;
    lista.next();
  end;
end;

//programa principal
begin
  inicializarLista(productos);

  repeat
    leerProducto(nuevoProducto);
    if nuevoProducto.codigo <> 0 then
      agregarProducto(productos, nuevoProducto);
  until nuevoProducto.codigo = 0;

  calcularPorcentajeStockMinimo(productos, porcentajeProductosDebajoMinimo);
  writeln('Porcentaje de productos con stock actual por debajo de su stock minimo: ', porcentajeProductosDebajoMinimo:0:2, '%');

  imprimirDescripcionProductosPar(productos);

  obtenerProductosMasEconomicos(productos, codigo1, codigo2);
  writeln('Codigo de los dos productos mas economicos: ', codigo1, ' y ', codigo2);

  imprimirLista(productos);
end.
