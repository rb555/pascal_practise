program tp4_ej8;

type
  auto = record
    marca: string;
    modelo: string;
    precio: real;
  end;

procedure leerAuto(var a: auto);
begin
  writeln('Ingrese marca');
  readln(a.marca);
  if (a.marca <> 'ZZZ') then 
  begin
    writeln('Ingrese modelo');
    readln(a.modelo);
    writeln('Ingrese precio');
    readln(a.precio);
  end;
end;

function calcPromedio(precioTotal: real; cantAuto: integer): real;
begin
  if cantAuto > 0 then
    calcPromedio := precioTotal / cantAuto
  else
    calcPromedio := 0;
end;

procedure buscarMaximo(au: auto; var max: real; var unaMarcaMax, unModeloMax: string);
begin
  if (au.precio > max) then 
  begin
    max := au.precio;
    unaMarcaMax := au.marca;
    unModeloMax := au.modelo;
  end;
end;

procedure cuentas;
var 
  au: auto;
  auxMarca, modeloMax, marcaMax: string;
  sumaPrecios, max: real;
  cantAutos: integer;
begin
  cantAutos := 0; // inicializo contadores y acumuladores
  sumaPrecios := 0;
  max := -1;
  leerAuto(au);
  auxMarca := au.marca;
  
  while (au.marca <> 'ZZZ') do 
  begin
    buscarMaximo(au, max, marcaMax, modeloMax);
    if (au.marca = auxMarca) then 
    begin
      cantAutos := cantAutos + 1;
      sumaPrecios := sumaPrecios + au.precio;
    end
    else 
    begin
      writeln('El precio promedio de la marca ', auxMarca, ' es: ', calcPromedio(sumaPrecios, cantAutos):2:2);
      auxMarca := au.marca;
      cantAutos := 1;
      sumaPrecios := au.precio;
    end;
    leerAuto(au);
  end;
  if cantAutos > 0 then
    writeln('El precio promedio de la marca ', auxMarca, ' es: ', calcPromedio(sumaPrecios, cantAutos):2:2);
  writeln('La marca del auto más caro es: ', marcaMax);
  writeln('El modelo del auto más caro es: ', modeloMax);
end;

// programa principal
begin
  cuentas;
end.
