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
    i, contadorPares, mayorEdad1, mayorEdad2, totalAlumnos: integer;
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
    mayorEdad1 := 1;
    mayorEdad2 := 1;
    dniIngresado := 0;
    totalAlumnos := 0;

    // Lectura de datos
    i := 1;
    writeln('Ingresando datos de los alumnos...');
    while (i <= MAX_ALUMNOS) and (dniIngresado <> -1) do
    begin
        writeln('Ingresando datos del alumno ', i);
        LeerAlumno(alumnos[i]);
        dniIngresado := alumnos[i].DNI;
        i := i + 1;
    end;
    totalAlumnos := i - 1;

    // Cálculo del porcentaje de alumnos con DNI pares
    i := 1;
    while i <= totalAlumnos do
    begin
        if alumnos[i].DNI mod 2 = 0 then
            contadorPares := contadorPares + 1;
        i := i + 1;
    end;
    porcentajePares := (contadorPares / totalAlumnos) * 100;

    // Cálculo de los dos alumnos de mayor edad
    i := 2;
    while i <= totalAlumnos do
    begin
        if alumnos[i].anioNacimiento < alumnos[mayorEdad1].anioNacimiento then
        begin
            mayorEdad2 := mayorEdad1;
            mayorEdad1 := i;
        end
        else if alumnos[i].anioNacimiento < alumnos[mayorEdad2].anioNacimiento then
            mayorEdad2 := i;
        i := i + 1;
    end;

    // Informar resultados
    writeln('Porcentaje de alumnos con DNI pares: ', porcentajePares:0:2, '%');
    writeln('Los dos alumnos de mayor edad son:');
    writeln('1. ', alumnos[mayorEdad1].apellido, ', ', alumnos[mayorEdad1].nombre);
    writeln('2. ', alumnos[mayorEdad2].apellido, ', ', alumnos[mayorEdad2].nombre);
end.
