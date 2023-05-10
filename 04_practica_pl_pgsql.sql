-- EJERCICIOS
/*

1 - Escriba un bloque de codigo PL/pgSQL que reciba una nota como parametro
    y notifique en la consola de mensaje las letras A,B,C,D,E o F segun el valor de la nota

*/
DO $$

    DECLARE nota INTEGER := 80;
    BEGIN
        IF nota >= 90 THEN
            RAISE NOTICE 'A';
        ELSIF nota >= 80 THEN
            RAISE NOTICE 'B';
        ELSIF nota >= 70 THEN
            RAISE NOTICE 'C';
        ELSIF nota >= 60 THEN
            RAISE NOTICE 'D';
        ELSIF nota >= 50 THEN
            RAISE NOTICE 'E';
        ELSE
            RAISE NOTICE 'F';
        END IF;
    END $$ LANGUAGE 'plpgsql';

    DO $$ 
    DECLARE nota INTEGER := 80;
    BEGIN
    CASE 
        WHEN nota >= 90 THEN
            RAISE NOTICE 'A';
        WHEN nota >= 80 THEN
            RAISE NOTICE 'B';
        WHEN nota >= 70 THEN
            RAISE NOTICE 'C';
        WHEN nota >= 60 THEN
            RAISE NOTICE 'D';
        WHEN nota >= 50 THEN
            RAISE NOTICE 'E';
        ELSE
            RAISE NOTICE 'F';
    END CASE;
    END $$ LANGUAGE 'plpgsql';


/*
2 - Escriba un bloque de codigo PL/pgSQL que reciba un numero como parametro
    y muestre la tabla de multiplicar de ese numero.
*/
DO $$
DECLARE
    numero INTEGER := 5;
    i INTEGER := 1;
    BEGIN
        FOR i IN 1..10 LOOP
            RAISE NOTICE '% x % = %', numero, i, numero * i;
        END LOOP;
    END $$ LANGUAGE 'plpgsql';

/*
3 - Escriba una funcion PL/pgSQL que convierta de dolares a moneda nacional.
    La funcion debe recibir dos parametros, cantidad de dolares y tasa de cambio.
    Al final debe retornar el monto convertido a moneda nacional.
*/
CREATE OR REPLACE FUNCTION dolares_a_moneda_nacional(dolares NUMERIC, tasa NUMERIC)
RETURNS NUMERIC AS $$
DECLARE
BEGIN
    RETURN dolares * tasa;
END $$ LANGUAGE 'plpgsql';

SELECT dolares_a_moneda_nacional(100, 3.5);


DO $$
DECLARE
    dolares NUMERIC := 100;
    tasa NUMERIC := 3.5;
BEGIN
    RAISE NOTICE '%', dolares * tasa;
END $$ LANGUAGE 'plpgsql';


/*

4 - Escriba una funcion PL/pgSQL que reciba como parametro el monto de un prestamo,
    su duracion en meses y la tasa de interes, retornando el monto de la cuota a pagar.
    Aplicar el metodo de amortizacion frances.

*/
CREATE OR REPLACE FUNCTION cuota_prestamo(monto NUMERIC, duracion INTEGER, tasa NUMERIC)
RETURNS NUMERIC AS $$
DECLARE
    cuota NUMERIC;
    interes NUMERIC;
BEGIN
    interes := tasa / 100 / 12;
    cuota := monto * interes / (1 - (1 + interes) ^ (-duracion));
    RETURN cuota;
END $$ LANGUAGE 'plpgsql';

SELECT cuota_prestamo(100000, 12, 10);

DO $$
DECLARE
    monto NUMERIC := 100000;
    duracion INTEGER := 12;
    tasa NUMERIC := 10;
    cuota NUMERIC;
    interes NUMERIC; 
BEGIN
    interes := tasa / 100 / 12;
    cuota := monto * interes / (1 - (1 + interes) ^ (-duracion));
    RAISE NOTICE '%', cuota;
END $$ LANGUAGE 'plpgsql';