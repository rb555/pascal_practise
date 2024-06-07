program FacturacionTelefonica;

type
  LineaTelefono = record
    codigoCliente: integer;
    numero: string;
    minutosConsumidos: integer;
    MBConsumidos: integer;
  end;

procedure LeerLineaTelefono(var linea: LineaTelefono);
begin
  writeln('Ingrese el código de cliente:');
  readln(linea.codigoCliente);
  
  if linea.codigoCliente <> 0 then
  begin
    writeln('Ingrese el número de teléfono:');
    readln(linea.numero);
    writeln('Ingrese la cantidad de minutos consumidos:');
    readln(linea.minutosConsumidos);
    writeln('Ingrese la cantidad de MB consumidos:');
    readln(linea.MBConsumidos);
  end;
end;

function CalcularMontoTotalFacturacion(linea: LineaTelefono): real;
begin
  CalcularMontoTotalFacturacion := linea.minutosConsumidos * 9.80 + linea.MBConsumidos * 2.35;
end;

function CalcularPromedioMBConsumidos(linea: LineaTelefono): real;
begin
  CalcularPromedioMBConsumidos := linea.MBConsumidos;
end;

var
  cliente: LineaTelefono; 
  montoTotalFacturacion, promedioMB: real;

begin
  montoTotalFacturacion := 0;
  promedioMB := 0;
  
  writeln('Ingrese los datos del cliente (o 0 para salir):');
  LeerLineaTelefono(cliente);
  
  while cliente.codigoCliente <> 0 do
  begin
    montoTotalFacturacion := CalcularMontoTotalFacturacion(cliente);
    promedioMB := CalcularPromedioMBConsumidos(cliente);
    
    writeln('El monto total a facturar para el cliente ', cliente.codigoCliente, ' es: ', montoTotalFacturacion:0:2);
    writeln('El promedio de MB consumidos para el cliente ', cliente.codigoCliente, ' es: ', promedioMB:0:2);
    
    writeln();
    writeln('Ingrese los datos del cliente (o 0 para salir):');
    LeerLineaTelefono(cliente);
  end;
end.
