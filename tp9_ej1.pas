program RemiseriaSimple;

uses
  GenericLinkedList;

const
  MAX_VIAJES = 550;

type
  Viaje = record
    numero: Integer;
    codigoAuto: Integer;
    categoria: Integer;
    kilometros: Integer;
  end;

  ListaViajes = specialize LinkedList<Viaje>;

var
  Viajes: ListaViajes;
  totalKilometrosPorAuto: array[1..MAX_VIAJES] of Integer;
  totalKilometrosPorCategoria: array[1..5] of Integer;

procedure ProcesarViajes();
var
  i: Integer;
  viaje: Viaje;
begin
  for i := 0 to Viajes.Count - 1 do
  begin
    viaje := Viajes[i];
    totalKilometrosPorAuto[viaje.codigoAuto] := totalKilometrosPorAuto[viaje.codigoAuto] + viaje.kilometros;
    totalKilometrosPorCategoria[viaje.categoria] := totalKilometrosPorCategoria[viaje.categoria] + viaje.kilometros;
  end;
end;

function ObtenerMaximosKilometrosPorAuto(): string;
var
  i, max1, max2: Integer;
begin
  max1 := 1;
  max2 := 2;

  for i := 3 to MAX_VIAJES do
  begin
    if totalKilometrosPorAuto[i] > totalKilometrosPorAuto[max1] then
    begin
      max2 := max1;
      max1 := i;
    end
    else if totalKilometrosPorAuto[i] > totalKilometrosPorAuto[max2] then
      max2 := i;
  end;

  ObtenerMaximosKilometrosPorAuto := 'Los dos códigos de auto que más kilómetros recorrieron son: ' + IntToStr(max1) + ' y ' + IntToStr(max2);
end;

function ObtenerMinimosKilometrosPorCategoria(): string;
var
  i, min1, min2: Integer;
begin
  min1 := 1;
  min2 := 2;

  for i := 3 to 5 do
  begin
    if totalKilometrosPorCategoria[i] < totalKilometrosPorCategoria[min1] then
    begin
      min2 := min1;
      min1 := i;
    end
    else if totalKilometrosPorCategoria[i] < totalKilometrosPorCategoria[min2] then
      min2 := i;
  end;

  ObtenerMinimosKilometrosPorCategoria := 'Las dos categorías de viaje que menos kilómetros recorrieron son: ' + IntToStr(min1) + ' y ' + IntToStr(min2);
end;

procedure MostrarResultados();
begin
  WriteLn(ObtenerMaximosKilometrosPorAuto());
  WriteLn(ObtenerMinimosKilometrosPorCategoria());
end;

procedure CargarViajes();
var
  i: Integer;
  nuevoViaje: Viaje;
begin
  for i := 1 to MAX_VIAJES do
  begin
    nuevoViaje.numero := i;
    nuevoViaje.codigoAuto := Random(10) + 1; // Simplemente un número aleatorio entre 1 y 10
    nuevoViaje.categoria := Random(5) + 1; // Simplemente un número aleatorio entre 1 y 5
    nuevoViaje.kilometros := Random(100); // Simplemente un número aleatorio entre 0 y 99
    Viajes.Add(nuevoViaje);
  end;
end;

begin
  Viajes := ListaViajes.Create;

  CargarViajes();

  ProcesarViajes();

  MostrarResultados();
end.
