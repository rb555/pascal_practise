program EstadisticasAlumnos;

type
    Alumno = record
        nroInscripcion: integer;
        DNI: integer;
        apellido: string;
        nombre: string;
        anioNacimiento: integer;
    end;

const
    MAX_ALUMNOS = 560;

var
    alumnos: array[1..MAX_ALUMNOS] of Alumno;
    i, contadorPares, idxMayorEdad1, idxMayorEdad2, totalAlumnos: integer;
    porcentajePares: real;
    dniIngresado: integer;

procedure LeerAlumno(var a: Alumno);
begin
    writeln('Ingrese el numero de inscripcion:');
    readln(a.nroInscripcion);
    writeln('Ingrese el DNI:');
    readln(a.DNI);
    if a.DNI <> -1 then
    begin
        writeln('Ingrese el apellido:');
        readln(a.apellido);
        writeln('Ingrese el nombre:');
        readln(a.nombre);
        writeln('Ingrese el año de nacimiento:');
        readln(a.anioNacimiento);
    end;
end;

begin
    contadorPares := 0;
    idxMayorEdad1 := 0;
    idxMayorEdad2 := 0;
    totalAlumnos := 0;

    // Lectura de datos
    i := 1;
    writeln('Ingresando datos de los alumnos...');
    while (i <= MAX_ALUMNOS) do
    begin
        writeln('Ingresando datos del alumno ', i);
        LeerAlumno(alumnos[i]);
        dniIngresado := alumnos[i].DNI;
        if dniIngresado = -1 then
            break;
        i := i + 1;
    end;
    totalAlumnos := i - 1;

    // Cálculo del porcentaje de alumnos con DNI pares
    for i := 1 to totalAlumnos do
    begin
        if alumnos[i].DNI mod 2 = 0 then
            contadorPares := contadorPares + 1;
    end;
    if totalAlumnos > 0 then
        porcentajePares := (contadorPares / totalAlumnos) * 100
    else
        porcentajePares := 0;

    // Cálculo de los dos alumnos de mayor edad
    if totalAlumnos > 0 then
    begin
        idxMayorEdad1 := 1;
        if totalAlumnos > 1 then
            idxMayorEdad2 := 2
        else
            idxMayorEdad2 := 1;

        for i := 2 to totalAlumnos do
        begin
            if alumnos[i].anioNacimiento < alumnos[idxMayorEdad1].anioNacimiento then
            begin
                idxMayorEdad2 := idxMayorEdad1;
                idxMayorEdad1 := i;
            end
            else if (alumnos[i].anioNacimiento < alumnos[idxMayorEdad2].anioNacimiento) or (idxMayorEdad1 = idxMayorEdad2) then
                idxMayorEdad2 := i;
        end;
    end;

    // Informar resultados
    writeln('Porcentaje de alumnos con DNI pares: ', porcentajePares:0:2, '%');
    writeln('Los dos alumnos de mayor edad son:');
    if idxMayorEdad1 > 0 then
        writeln('1. ', alumnos[idxMayorEdad1].apellido, ', ', alumnos[idxMayorEdad1].nombre);
    if (idxMayorEdad2 > 0) and (idxMayorEdad1 <> idxMayorEdad2) then
        writeln('2. ', alumnos[idxMayorEdad2].apellido, ', ', alumnos[idxMayorEdad2].nombre);
end.

