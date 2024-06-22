//Un salon de eventos necesita administrar la informacion de las reservas de marzo de 2024.
//Se dispone de una lista con la informacion de las reservas. De cada reserva se conoce:
//numero de reserva, DNI del cliente, dia del evento (1..31), hora de inicio, hora de fin
//y categoria de servicio (1..18). Ademas, se dispone de un vector con el precio por hora
//de reserva de acuerdo a cada categoria de servicio. Se pide recorrer la lista una sola vez
//para: 
// a)Generar una nueva lista con numero y precio total de cada reserva. Esta estructura debe 
//generarse ordenada por el precio total de cada reserva.
// b)Informar los dos dias del mes con menor cantidad de reservas de clientes con DNI impar.
// c)Informar el porcentaje de reservas de eventos que inciden despues de las 12 hs y se produzcan
// en la segunda quincena.
//NOTA: La hora de fin no excede las 23 hs. Hacer el programa principal. Modularizar.

program segundafecha;

uses GenericLinkedList;

const
    dimCat = 18;

type
    eventos = record
        numReserva: integer;
        dniCliente: integer;
        diaEvento: integer;
        horaInicio: integer;
        horaFin: integer;
        catServicio: integer;
    end;

    precios = array [1..dimCat] of real;

    listaEvento = specialize LinkedList<eventos>;

    resumenReserva = record
        numReserva: integer;
        precioTotal: real;
    end;

    listaResumen = specialize LinkedList<resumenReserva>;

var
    listaEventos: listaEvento;
    preciosPorHora: precios; // Se dispone de este vector
    listaResumenes: listaResumen;
    
//Este procedimiento recorre la lista de eventos.
//Para cada evento, calcula el precio total de la reserva (número de horas multiplicado por el precio por hora de la categoría de servicio).   
procedure generarListaResumen(var eventos: listaEvento; var precios: precios; var resumenes: listaResumen);
var
    eventoActual: eventos;
    resumen: resumenReserva;
    precioHora: real;
begin
    eventos.reset();
    while not eventos.eol() do
    begin
        eventoActual := eventos.current();
        precioHora := precios[eventoActual.catServicio];
        resumen.numReserva := eventoActual.numReserva;
        resumen.precioTotal := (eventoActual.horaFin - eventoActual.horaInicio) * precioHora;

        resumenes.addFirst(resumen);
        eventos.next();
    end;
end;


procedure diasMenorCantidadReservasDNIImpar(var eventos: listaEvento);
var
    contadorDias: array[1..31] of integer;
    i, diaMin1, diaMin2, min1, min2: integer;
begin
    for i := 1 to 31 do
        contadorDias[i] := 0;

    eventos.reset();
    while not eventos.eol() do
    begin
        if eventos.current().dniCliente mod 2 <> 0 then
            contadorDias[eventos.current().diaEvento] := contadorDias[eventos.current().diaEvento] + 1;
        eventos.next();
    end;

    min1 := MaxInt;
    min2 := MaxInt;

    for i := 1 to 31 do
    begin
        if contadorDias[i] < min1 then
        begin
            min2 := min1;
            diaMin2 := diaMin1;
            min1 := contadorDias[i];
            diaMin1 := i;
        end
        else if contadorDias[i] < min2 then
        begin
            min2 := contadorDias[i];
            diaMin2 := i;
        end;
    end;

    writeln('Los dos días con menor cantidad de reservas de clientes con DNI impar son: ', diaMin1, ' y ', diaMin2);
end;

//Este procedimiento recorre la lista de eventos y cuenta el total de reservas y las reservas que ocurren después de las 12 hs en la segunda quincena.
//Calcula el porcentaje de reservas que cumplen las condiciones y lo informa.
procedure porcentajeReservasSegundaQuincena(var eventos: listaEvento);
var
    totalReservas, reservasSegundaQuincena: integer;
begin
    totalReservas := 0;
    reservasSegundaQuincena := 0;

    eventos.reset();
    while not eventos.eol() do
    begin
        if (eventos.current().diaEvento > 15) and (eventos.current().horaInicio >= 12) then
            reservasSegundaQuincena := reservasSegundaQuincena + 1;
        totalReservas := totalReservas + 1;
        eventos.next();
    end;

    if totalReservas > 0 then
        writeln('El porcentaje de reservas después de las 12 hs en la segunda quincena es: ', (reservasSegundaQuincena / totalReservas) * 100:0:2, '%')
    else
        writeln('No hay reservas registradas.');
end;

//programa principal
begin
    // Se dispone la lista de eventos y el vector de precios por hora ya cargados
    listaEventos := listaEvento.create();
    listaResumenes := listaResumen.create();
    
    // Generar lista de resumen ordenada por precio total
    generarListaResumen(listaEventos, preciosPorHora, listaResumenes);

 
end.

	
	 
		
