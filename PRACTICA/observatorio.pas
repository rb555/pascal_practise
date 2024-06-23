program asteroides;

uses
  GenericLinkedList, SysUtils;

const
  dimCat = 7;

type
  objetos = record
    codigo: integer;
    categoria: integer;
    nombre: string;
    distancia: integer;
    descubridor: string;
    fecha: integer; // guarda el año de descubrimiento
  end;

  listaObjetos = specialize LinkedList<objetos>;

procedure leerObjeto(var lo: listaObjetos);
var
  cuerpoCeleste: objetos;
begin
  lo := listaObjetos.create(); // creo una lista vacia
  readln(cuerpoCeleste.codigo); // leo el primer objeto
  while (cuerpoCeleste.codigo <> -1) do
  begin
    readln(cuerpoCeleste.categoria);
    readln(cuerpoCeleste.nombre);
    readln(cuerpoCeleste.distancia);
    readln(cuerpoCeleste.descubridor);
    readln(cuerpoCeleste.fecha);
    lo.add(cuerpoCeleste);
    readln(cuerpoCeleste.codigo); // leo el siguiente objeto
  end;
end;

procedure encontrarObjetosMasLejanos(lo: listaObjetos; var max1Codigo, max2Codigo: integer);
var
  obj: objetos;
  max1, max2: integer;
begin
  max1 := -1;
  max2 := -1;
  max1Codigo := -1;
  max2Codigo := -1;

  // Inicializar lectura
  lo.reset();

  // Recorrer la lista de objetos
  while not lo.eol() do
  begin
    obj := lo.current();

    // Buscar los dos objetos más lejanos
    if obj.distancia > max1 then
    begin
      max2 := max1;
      max2Codigo := max1Codigo;
      max1 := obj.distancia;
      max1Codigo := obj.codigo;
    end
    else if obj.distancia > max2 then
    begin
      max2 := obj.distancia;
      max2Codigo := obj.codigo;
    end;

    // Avanzar al siguiente objeto
    lo.next();
  end;
end;

function contarPlanetasGalileo(lo: listaObjetos): integer;
var
  obj: objetos;
  count: integer;
begin
  count := 0;

  // Inicializar lectura
  lo.reset();

  // Recorrer la lista de objetos
  while not lo.eol() do
  begin
    obj := lo.current();

    // Contar planetas descubiertos por Galileo antes de 1600
    if (obj.categoria = 2) and (obj.descubridor = 'Galileo Galilei') and (obj.fecha < 1600) then
      count := count + 1;

    // Avanzar al siguiente objeto
    lo.next();
  end;

  contarPlanetasGalileo := count;
end;

procedure contarObjetosPorCategoria(lo: listaObjetos; var categoriaCount: array of integer);
var
  obj: objetos;
  i: integer;
begin
  // Inicializar el vector contador de categorías
  for i := 1 to dimCat do
    categoriaCount[i] := 0;

  // Inicializar lectura
  lo.reset();

  // Recorrer la lista de objetos
  while not lo.eol() do
  begin
    obj := lo.current();

    // Contar objetos por categoría
    categoriaCount[obj.categoria] := categoriaCount[obj.categoria] + 1;

    // Avanzar al siguiente objeto
    lo.next();
  end;
end;

function calcularPorcentajeAsteroides(lo: listaObjetos): real;
var
  totalAsteroides, totalObjetos: integer;
  obj: objetos;
begin
  totalAsteroides := 0;
  totalObjetos := 0;

  // Inicializar lectura
  lo.reset();

  // Recorrer la lista de objetos
  while not lo.eol() do
  begin
    obj := lo.current();

    // Contar asteroides
    if obj.categoria = 5 then
      totalAsteroides := totalAsteroides + 1;

    // Contar total de objetos
    totalObjetos := totalObjetos + 1;

    // Avanzar al siguiente objeto
    lo.next();
  end;

  // Calcular el porcentaje de asteroides
  if totalObjetos > 0 then
    calcularPorcentajeAsteroides := (totalAsteroides / totalObjetos) * 100
  else
    calcularPorcentajeAsteroides := 0;
end;

function calcularPromedioDistanciaNebulosas(lo: listaObjetos): real;
var
  totalNebulosas, sumaDistanciaNebulosas: integer;
  obj: objetos;
begin
  totalNebulosas := 0;
  sumaDistanciaNebulosas := 0;

  // Inicializar lectura
  lo.reset();

  // Recorrer la lista de objetos
  while not lo.eol() do
  begin
    obj := lo.current();

    // Calcular suma y cantidad de nebulosas
    if obj.categoria = 7 then
    begin
      totalNebulosas := totalNebulosas + 1;
      sumaDistanciaNebulosas := sumaDistanciaNebulosas + obj.distancia;
    end;

    // Avanzar al siguiente objeto
    lo.next();
  end;

  // Calcular promedio de distancia de nebulosas
  if totalNebulosas > 0 then
    calcularPromedioDistanciaNebulosas := sumaDistanciaNebulosas / totalNebulosas
  else
    calcularPromedioDistanciaNebulosas := 0;
end;

procedure eliminarMultiploDe3(var lo: listaObjetos);
var
  obj: objetos;
begin
  // Inicializar lectura
  lo.reset();

  while not lo.eol() do
  begin
    // Obtener el objeto actual
    obj := lo.current();

    // Verificar si el año de descubrimiento es múltiplo de 3 y eliminar
    if obj.fecha mod 3 = 0 then
      lo.removeCurrent()
    else
      lo.next(); // avanzar solo si no se elimina
  end;
end;

procedure generarReporte(lo: listaObjetos);
var
  max1Codigo, max2Codigo: integer;
  categoriaCount: array[1..dimCat] of integer;
  promedioNebulosas: real;
  galileoCount: integer;
  porcentajeAsteroides: real;
  i: integer;
begin
  // Obtener los dos objetos más lejanos
  encontrarObjetosMasLejanos(lo, max1Codigo, max2Codigo);

  // Contar planetas descubiertos por Galileo antes de 1600
  galileoCount := contarPlanetasGalileo(lo);

  // Contar objetos por categoría
  contarObjetosPorCategoria(lo, categoriaCount);

  // Calcular porcentaje de asteroides
  porcentajeAsteroides := calcularPorcentajeAsteroides(lo);

  // Calcular promedio de distancia de nebulosas
  promedioNebulosas := calcularPromedioDistanciaNebulosas(lo);

  // Imprimir el reporte
  writeln('1. Los códigos de los dos objetos más lejanos de la Tierra: ', max1Codigo, ', ', max2Codigo);
  writeln('2. La cantidad de planetas descubiertos por "Galileo Galilei" antes del año 1600: ', galileoCount);
  writeln('3. La cantidad de objetos observados por cada categoría:');
  for i := 1 to dimCat do
    writeln('  Categoría ', i, ': ', categoriaCount[i]);
  writeln('4. El porcentaje de objetos de la categoría asteroides: ', porcentajeAsteroides:0:2, '%');
  writeln('5. El promedio de distancia a la Tierra de los objetos de la categoría nebulosa: ', promedioNebulosas:0:2);
end;

// Programa principal
var
  lo: listaObjetos;
begin
  leerObjeto(lo);
  generarReporte(lo);
  eliminarMultiploDe3(lo);
end.
