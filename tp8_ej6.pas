program SepararJubilados;

type
    TJubilado = record
        documento: integer;
        apellido: string;
        nombre: string;
        monto: real;
        ultimoDigito: integer;
        siguiente: ^TJubilado;
    end;

    ListaJubiladosPtr = ^TJubilado;
    ListaSeparada = array [0..9] of ListaJubiladosPtr;

procedure inicializarListasSeparadas(var listas: ListaSeparada);
var
    i: integer;
begin
    for i := 0 to 9 do
        listas[i] := nil;
end;

procedure agregarJubilado(var lista: ListaJubiladosPtr; jubilado: TJubilado);
var
    nuevoJubilado, actual: ListaJubiladosPtr;
begin
    new(nuevoJubilado);
    nuevoJubilado^ := jubilado;
    nuevoJubilado^.siguiente := nil;

    if lista = nil then
        lista := nuevoJubilado
    else
    begin
        actual := lista;
        while actual^.siguiente <> nil do
            actual := actual^.siguiente;
        actual^.siguiente := nuevoJubilado;
    end;
end;

procedure separarJubilados(listaJubilados: ListaJubiladosPtr; var listasSeparadas: ListaSeparada);
var
    actual, siguiente: ListaJubiladosPtr;
begin
    while listaJubilados <> nil do
    begin
        actual := listaJubilados;
        listaJubilados := listaJubilados^.siguiente;
        
        siguiente := listasSeparadas[actual^.ultimoDigito];
        agregarJubilado(siguiente, actual^);
        listasSeparadas[actual^.ultimoDigito] := siguiente;
    end;
end;

procedure imprimirListaJubilados(lista: ListaJubiladosPtr);
begin
    while lista <> nil do
    begin
        writeln('Documento:', lista^.documento, ' Apellido:', lista^.apellido, ' Nombre:', lista^.nombre, ' Monto:', lista^.monto:0:2, ' Ultimo dígito:', lista^.ultimoDigito);
        lista := lista^.siguiente;
    end;
end;

procedure imprimirListasSeparadas(listas: ListaSeparada);
var
    i: integer;
begin
    for i := 0 to 9 do
    begin
        writeln('Lista para el último dígito ', i);
        imprimirListaJubilados(listas[i]);
        writeln;
    end;
end;

var
    listaJubilados: ListaJubiladosPtr;
    listasSeparadas: ListaSeparada;
    jubilado: TJubilado;

begin
    inicializarListasSeparadas(listasSeparadas);

    writeln('Ingrese los datos de los jubilados (documento, apellido, nombre, monto, último dígito):');
    writeln('(Ingrese 0 para terminar la entrada de datos)');

    repeat
        readln(jubilado.documento);
        if jubilado.documento <> 0 then
        begin
            readln(jubilado.apellido);
            readln(jubilado.nombre);
            readln(jubilado.monto);
            jubilado.ultimoDigito := jubilado.documento mod 10;
            agregarJubilado(listaJubilados, jubilado);
        end;
    until jubilado.documento = 0;

    separarJubilados(listaJubilados, listasSeparadas);

    writeln;
    writeln('Listas de jubilados separadas por último dígito del documento:');
    imprimirListasSeparadas(listasSeparadas);
end.
