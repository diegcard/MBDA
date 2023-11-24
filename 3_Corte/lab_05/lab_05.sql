--LABORATORIO 5 MODELOS Y BASES DE DATOS

/*----------Punto A:----------*/
--1.
SELECT * FROM MBDA.DATA
--2.
INSERT INTO MBDA.DATA VALUES('Diego.cardenas-b@mail.escuelaing.edu.co', '1193116440', '3006816785', 'Diego Cardenas');
--3. 
DELETE FROM mbda.Data WHERE cedula = '1193116440';
--No tenemos los permisos suficientes para borrarnos o modificarnos
--4. 
GRANT UPDATE,DELETE 
ON mbda.Data
TO bd1000093114;
/*Me tienen que otorgar permisos un tercero, no puedo yo mismo darme permisos*/
--5. 
INSERT INTO Personas(id, tipo, numero, nombre, registro, celular, correo)
SELECT TO_NUMBER(SUBSTR(t.cedula, 1, 6) || LPAD(FLOOR(DBMS_RANDOM.VALUE(1, 1000)), 3, '0')) AS Id, 'CC' AS Tipo ,cedula, nombres, SYSDATE, celular, email
FROM (
  SELECT DISTINCT CEDULA, celular, nombres, email
  FROM MBDA.DATA
) t
WHERE celular IS NOT NULL OR email IS NOT NULL or cedula IS NOT NULL OR nombres IS NOT NULL;
--6
--Resuelto en el ASTHA

/*----------Punto C: Modelo físico. Componentes----------*/
--1
/*----------CRUDE----------*/
CREATE OR REPLACE PACKAGE PC_PQRS AS
    PROCEDURE AD_Pqrs(p_codigo IN NUMBER, p_descripcion IN VARCHAR2, p_tipo IN CHAR);
    PROCEDURE MO_Pqrs(p_ticked IN VARCHAR2, p_estado IN VARCHAR);
    PROCEDURE DE_Pqrs(p_ticked IN VARCHAR2);
    FUNCTION CO_Pqrs RETURN SYS_REFCURSOR;
    PROCEDURE AD_Anexo(p_idAnexo IN NUMBER, p_idTicked IN VARCHAR2, p_nombre IN VARCHAR2, p_url IN VARCHAR2);
    PROCEDURE DE_Anexo(p_idAnexo IN NUMBER);
    FUNCTION CO_Anexo RETURN SYS_REFCURSOR;
    FUNCTION CO_Anexos_expecific(p_idTicked IN VARCHAR) RETURN SYS_REFCURSOR;
    PROCEDURE AD_PqrsRespuesta(p_idTicked IN VARCHAR2, p_fecha IN DATE, p_descripcion IN VARCHAR, p_nombre IN VARCHAR, p_correo IN VARCHAR, p_comentario IN VARCHAR, p_evaluacion IN VARCHAR);
    PROCEDURE DE_PqrsRespuesta(p_idTicked IN VARCHAR2);
    FUNCTION CO_PqrsRespuesta RETURN SYS_REFCURSOR;
END PC_PQRS;
/

/*----------CRUDI----------*/
CREATE OR REPLACE PACKAGE BODY PC_PQRS AS
    PROCEDURE AD_Pqrs(p_codigo IN NUMBER, p_descripcion IN VARCHAR2, p_tipo IN CHAR) IS
    BEGIN
        INSERT INTO pqrs(codigosolicitud, descripcion, tipo)
        VALUES (p_codigo, p_descripcion, p_tipo);
        COMMIT;
            EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20006, 'No se pudo insertar el pqrs');
    END AD_Pqrs;

    PROCEDURE MO_Pqrs(p_ticked IN VARCHAR2, p_estado IN VARCHAR) IS 
    BEGIN
        UPDATE pqrs SET estado = p_estado WHERE ticked = p_ticked;
        COMMIT;
            EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20007, 'No se pudo Modificar el estado pqrs');
    END MO_Pqrs;

    PROCEDURE DE_Pqrs(p_ticked IN VARCHAR2) IS
        ex_associated_responses EXCEPTION;
        PRAGMA EXCEPTION_INIT(ex_associated_responses, -20005);
    BEGIN 
        DELETE FROM pqrs WHERE TICKED = p_ticked;
        COMMIT;
            EXCEPTION
            WHEN ex_associated_responses THEN
                DBMS_OUTPUT.PUT_LINE('No se pudo eliminar el PQRS porque tiene respuestas asociadas.');
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20008, 'No se pudo eliminar el pqrs');
    END DE_Pqrs;

    FUNCTION CO_Pqrs RETURN SYS_REFCURSOR IS CO_PS SYS_REFCURSOR;
    BEGIN
    OPEN CO_PS FOR 
        SELECT * 
        FROM pqrs;
    RETURN CO_PS;
    END;

    PROCEDURE AD_Anexo(p_idAnexo IN NUMBER, p_idTicked IN VARCHAR2, p_nombre IN VARCHAR2, p_url IN VARCHAR2) IS 
        ex_associated_responses EXCEPTION;
        ex_associated_responses2 EXCEPTION;
        ex_unique_key_violation EXCEPTION;
        PRAGMA EXCEPTION_INIT(ex_associated_responses, -20003);
        PRAGMA EXCEPTION_INIT(ex_associated_responses2, -20004);
        PRAGMA EXCEPTION_INIT(ex_unique_key_violation, -00001);
    BEGIN
        INSERT INTO anexos(idAnexo, idTicked, nombre, url)
        VALUES(p_idAnexo, p_idTicked, p_nombre, p_url);
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('El anexo se ingresó correctamente.');
    EXCEPTION
        WHEN ex_associated_responses THEN
            DBMS_OUTPUT.PUT_LINE('Solo es posible adicionar anexos a un PQRS si su estado es "Abierto".');
        WHEN ex_associated_responses2 THEN
            DBMS_OUTPUT.PUT_LINE('El PQRS al que intenta adicionar un anexo no existe.');
        WHEN ex_unique_key_violation THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('Ya existe un anexo con el mismo idAnexo.');
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20009, 'No se pudo insertar el anexo');
    END AD_Anexo;


    PROCEDURE DE_Anexo(p_idAnexo IN NUMBER) IS 
    BEGIN
        DELETE FROM anexos WHERE idAnexo = p_idAnexo;
        COMMIT;
            EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20007, 'No se pudo Modificar el Anexo');
    END DE_Anexo;

    FUNCTION CO_Anexo RETURN SYS_REFCURSOR IS CO_Ax SYS_REFCURSOR;
    BEGIN
        OPEN CO_Ax FOR 
            SELECT * 
            FROM anexos;
        RETURN CO_Ax;
    END;

    FUNCTION CO_Anexos_expecific(p_idTicked IN VARCHAR) RETURN SYS_REFCURSOR IS CO_Ax_Ex SYS_REFCURSOR;
    BEGIN
        OPEN CO_Ax_Ex FOR
        SELECT * FROM Anexos WHERE idTicked = p_idTicked;
        RETURN CO_Ax_Ex;
    END;

    PROCEDURE AD_PqrsRespuesta(p_idTicked IN VARCHAR2, p_fecha IN DATE, p_descripcion IN VARCHAR, p_nombre IN VARCHAR, p_correo IN VARCHAR, p_comentario IN VARCHAR, p_evaluacion IN VARCHAR) IS
    BEGIN
        INSERT INTO pqrsrespuestas (idTicked, fecha, descripcion, nombre, correo, comentario, evaluacion)
        VALUES (p_idTicked, p_fecha, p_descripcion, p_nombre, p_correo, p_comentario, p_evaluacion);
        COMMIT;
            EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20008, 'No se pudo Agregar la respuesta');
    END AD_PqrsRespuesta;

    PROCEDURE DE_PqrsRespuesta(p_idTicked IN VARCHAR2) IS
    BEGIN
        DELETE FROM pqrsrespuestas WHERE idTicked = p_idTicked;
        COMMIT;
            EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20009, 'No se pudo Eliminar la respuesta');
    END DE_PqrsRespuesta;

    FUNCTION CO_PqrsRespuesta RETURN SYS_REFCURSOR IS
    CO_PR SYS_REFCURSOR;
    BEGIN
    OPEN CO_PR FOR SELECT * FROM pqrsrespuestas;
    RETURN CO_PR;
    END;

END PC_PQRS;
/

/*----------XCRUD----------*/

DROP PROCEDURE PC_PQRS;

--2 

/*----------CRUDOK----------*/
/*AD_PQRS*/
BEGIN
    PC_PQRS.AD_PQRS(1, 'No llego el vehiculo', 'Q');
END;
/

BEGIN
    PC_PQRS.AD_PQRS(2, 'Precio incorecto', 'R');
END;
/

BEGIN
    PC_PQRS.AD_PQRS(3, 'Conductor inadecuado', 'Q');
END;
/

BEGIN
    PC_PQRS.AD_PQRS(4, 'Verificar precio', 'S');
END;
/

BEGIN
    PC_PQRS.AD_PQRS(5, 'Precio incorecto', 'Q');
END;
/

/*MO_PQRS*/
BEGIN 
    PC_PQRS.MO_PQRS('S202311191714');
END;
/

BEGIN 
    PC_PQRS.AD_PQRS('S202311191715');
END;
/

/*DE_PQRS*/
BEGIN 
    PC_PQRS.MO_PQRS('S202311191714');
END;
/

BEGIN 
    PC_PQRS.AD_PQRS('S202311191715');
END;
/

BEGIN 
    PC_PQRS.AD_PQRS('S202311191716');
END;
/

BEGIN 
    PC_PQRS.AD_PQRS('S202311191717');
END;
/

BEGIN 
    PC_PQRS.AD_PQRS('S202311191718');
END;
/

/*AD_Anexo*/
BEGIN 
    PC_PQRS.ad_anexo(1, 'S202311191714', 'Peticion', 'https://hgfo.pdf');
END;
/

BEGIN 
    PC_PQRS.ad_anexo(2, 'S202311191715', 'Peticion', 'https://hsdoo.pdf');
END;
/

BEGIN 
    PC_PQRS.ad_anexo(3, 'S202311191716', 'Peticion', 'https://fdsfsd.pdf');
END;
/

BEGIN 
    PC_PQRS.ad_anexo(4, 'S202311191718', 'Peticion', 'https://hasoo.pdf');
END;
/

BEGIN 
    PC_PQRS.ad_anexo(5, 'S202311191718', 'Peticion', 'https://hoassao.pdf');
END;
/

/*DEL_Anexo*/
BEGIN 
    PC_PQRS.de_anexo(1);
END;
/

BEGIN 
    PC_PQRS.de_anexo(2);
END;
/

BEGIN 
    PC_PQRS.de_anexo(3);
END;
/

BEGIN 
    PC_PQRS.de_anexo(4);
END;
/

BEGIN 
    PC_PQRS.de_anexo(5);
END;
/

/*----------CRUDNOOK----------*/
BEGIN
    PC_PQRS.AD_PQRS(1,'Bogota', 'No llego el vehiculo', 'Q');
END;
/

BEGIN 
    PC_PQRS.MO_PQRS('S202311191714','48');
END;
/

BEGIN 
    PC_PQRS.DE_PQRS('O1');
END;
BEGIN 
    PC_PQRS.ad_anexo('jy7', '1', 'Oracle', '//hgfo.pdf');
END;
BEGIN 
    PC_PQRS.de_anexo('OLA1');
END;



/*----------ConsultasOK----------*/
DECLARE 
    CO_PQRS SYS_REFCURSOR;
BEGIN 
    CO_PQRS := PC_Pqrs.CO_Pqrs;
    DBMS_SQL.RETURN_RESULT(CO_PQRS);
END;
/

DECLARE 
    CO_ANEX SYS_REFCURSOR;
BEGIN 
    CO_ANEX := PC_Pqrs.CO_Anexo;
    DBMS_SQL.RETURN_RESULT(CO_ANEX);
END;
/

DECLARE 
    RESP SYS_REFCURSOR;
BEGIN 
    RESP := PC_Pqrs.CO_Anexos_expecific(p_idTicked => 'R202311212134');
    DBMS_SQL.RETURN_RESULT(RESP);
END;
/

/*----------Punto D.: Modelo físico. Seguridad----------*/

--1
/*----------ActoresE----------*/
CREATE OR REPLACE PACKAGE PA_CLIENTE AS
    PROCEDURE AD_Pqrs(p_codigo IN NUMBER, p_descripcion IN VARCHAR2, p_tipo IN CHAR);
    PROCEDURE DE_Pqrs(p_ticked IN VARCHAR2);
    FUNCTION CO_Pqrs RETURN SYS_REFCURSOR;
    PROCEDURE AD_Anexo(p_idAnexo IN NUMBER, p_idTicked IN VARCHAR2, p_nombre IN VARCHAR2, p_url IN VARCHAR2);
    PROCEDURE DE_Anexo(p_idAnexo IN NUMBER);
    FUNCTION CO_Anexo RETURN SYS_REFCURSOR;
    FUNCTION CO_PqrsRespuesta RETURN SYS_REFCURSOR;
END PA_CLIENTE;
/

CREATE OR REPLACE PACKAGE PA_ANALISTA_CLIENTES AS
    PROCEDURE AD_PqrsRespuesta(p_idTicked IN VARCHAR2, p_fecha IN DATE, p_descripcion IN VARCHAR, p_nombre IN VARCHAR, p_correo IN VARCHAR, p_comentario IN VARCHAR, p_evaluacion IN VARCHAR);
    PROCEDURE DE_PqrsRespuesta(p_idTicked IN VARCHAR2);
    FUNCTION CO_PqrsRespuesta RETURN SYS_REFCURSOR;
    FUNCTION CO_Pqrs RETURN SYS_REFCURSOR;
    FUNCTION CO_Anexo RETURN SYS_REFCURSOR;
END PA_ANALISTA_CLIENTES;
/

/*----------ActoresI----------*/
CREATE OR REPLACE PACKAGE BODY PA_CLIENTE AS
    PROCEDURE AD_Pqrs(p_codigo IN NUMBER, p_descripcion IN VARCHAR2, p_tipo IN CHAR) IS 
    BEGIN
        PC_PQRS.AD_PQRS(p_codigo, p_descripcion, p_tipo);
    END;

    PROCEDURE DE_Pqrs(p_ticked IN VARCHAR2) IS 
    BEGIN
        PC_PQRS.DE_Pqrs(p_ticked) ;
    END;

    FUNCTION CO_Pqrs RETURN SYS_REFCURSOR IS CO_PQ SYS_REFCURSOR;
    BEGIN
        CO_PQ := PC_Pqrs.CO_Pqrs;
        RETURN CO_PQ;
    END;

    PROCEDURE AD_Anexo(p_idAnexo IN NUMBER, p_idTicked IN VARCHAR2, p_nombre IN VARCHAR2, p_url IN VARCHAR2) AS
    BEGIN
        PC_PQRS.AD_Anexo(p_idAnexo, p_idTicked, p_nombre, p_url); 
    END;

    FUNCTION CO_Anexo RETURN SYS_REFCURSOR IS CO_AX SYS_REFCURSOR;
    BEGIN
        CO_AX := PC_Pqrs.CO_Anexo;
        RETURN CO_AX;
    END;

    PROCEDURE DE_Anexo(p_idAnexo NUMBER) AS
    BEGIN
        PC_PQRS.DE_Anexo(p_idAnexo); 
    END;

    FUNCTION CO_PqrsRespuesta RETURN SYS_REFCURSOR IS CO_PQRESP SYS_REFCURSOR;
    BEGIN
        CO_PQRESP := PC_Pqrs.CO_PqrsRespuesta;
        RETURN CO_PQRESP;
    END;

END PA_CLIENTE;
/

CREATE OR REPLACE PACKAGE BODY PA_ANALISTA_CLIENTES AS
    PROCEDURE AD_PqrsRespuesta(p_idTicked VARCHAR2, p_fecha DATE, p_descripcion VARCHAR, p_nombre VARCHAR, p_correo VARCHAR, p_comentario VARCHAR, p_evaluacion VARCHAR) IS
    BEGIN
        PC_PQRS.AD_PqrsRespuesta(p_idTicked, p_fecha, p_descripcion, p_nombre, p_correo, p_comentario, p_evaluacion);
    END;

    PROCEDURE DE_PqrsRespuesta(p_idTicked VARCHAR2) IS
    BEGIN
        PC_PQRS.DE_PqrsRespuesta(p_idTicked);
    END;

    FUNCTION CO_PqrsRespuesta RETURN SYS_REFCURSOR IS CO_PQRESP SYS_REFCURSOR;
    BEGIN
        CO_PQRESP := PC_Pqrs.CO_PqrsRespuesta;
        RETURN CO_PQRESP;
    END;

    FUNCTION CO_Pqrs RETURN SYS_REFCURSOR IS CO_PQ SYS_REFCURSOR;
    BEGIN
        CO_PQ := PC_Pqrs.CO_Pqrs;
        RETURN CO_PQ;
    END;

    FUNCTION CO_Anexo RETURN SYS_REFCURSOR IS CO_AX SYS_REFCURSOR;
    BEGIN
        CO_AX := PC_Pqrs.CO_Anexo;
        RETURN CO_AX;
    END;
    
END PA_ANALISTA_CLIENTES;
/

/*----------XActores----------*/
DROP PACKAGE PA_CLIENTE;
DROP PACKAGE PA_ANALISTA_CLIENTES;

--2
--Seguridad
CREATE ROLE PA_CLIENTE;
GRANT SELECT, INSERT, UPDATE, DELETE ON pqrs TO PA_CLIENTE;
GRANT SELECT, INSERT, UPDATE, DELETE ON anexos TO PA_CLIENTE;
GRANT SELECT ON pqrsrespuestas TO PA_CLIENTE;

CREATE ROLE PA_ANALISTA_CLIENTES;
GRANT SELECT ON pqrs TO PA_ANALISTA_CLIENTES;
GRANT SELECT ON anexos TO PA_ANALISTA_CLIENTES;
GRANT SELECT, INSERT, UPDATE, DELETE ON pqrsrespuestas TO PA_ANALISTA_CLIENTES;


GRANT ALL ON pqrs TO bd1000093114; 
GRANT ALL ON anexos TO bd1000093114; 
GRANT ALL ON pqrsrespuestas TO bd1000093114; 
--3
--XSeguridad
DROP ROLE PA_CLIENTE;
DROP ROLE PA_ANALISTA_CLIENTES;

--4

EXECUTE DBMS_SESSION.SET_ROLE('PA_CLIENTE');
BEGIN
    PA_CLIENTE.AD_PQRS(1, 'No llego el vehiculo', 'Q');
END;
/
BEGIN 
    PC_PQRS.ad_anexo(1, 'S202311191714', 'Peticion', 'https://hgfo.pdf');
END;
/

EXECUTE DBMS_SESSION.SET_ROLE('PA_ANALISTA_CLIENTES');
BEGIN
    PA_ANALISTA_CLIENTES.AD_PqrsRespuesta('S202311191714', SYSDATE, 'Resuelto con exito', 'Javier', 'JavierFonseca@gexample.com', 'Resuelto Correctamente', 'Bien');
END;
/

--Insercciones:

SELECT * FROM pqrs;

BEGIN
    PA_CLIENTE.AD_PQRS(1, 'No llego el vehiculo', 'Q');
END;
/

BEGIN 
    PC_PQRS.ad_anexo(1, 'Q202311192121', 'Peticion', 'https://hgfo.pdf');
END;
/

BEGIN
    PC_PQRS.AD_PqrsRespuesta('Q202311192121', SYSDATE, 'Resuelto con exito', 'Javier', 'JavierFonseca@gexample.com', 'Resuelto', 'Bien');
END;
/

BEGIN 
    PC_PQRS.ad_anexo(2, 'Q202311192121', 'Peticion', 'https://hsdoo.pdf');
END;
/

/*----------Punto D: Pruebas----------*/

/*
Como Cliente quiero presentar un pqrs debido a que el conductor se desvio de su camino y me cobro mas 
Debido a eso mande la pqrs y adjunte dos imagenes que comprueban lo sucedido y solicito que tomen cartas en el asunto y foto del conductor
*/
BEGIN 
    PA_CLIENTE.AD_PQRS(1, 'Conductor se desvio de su camino', 'Q');
END;
/

BEGIN
    PA_CLIENTE.AD_Anexo(1, '', 'Foto1 pantallazo', 'https://foto1.png');
    PA_CLIENTE.AD_Anexo(2, '', 'Foto2 foto conductor', 'https://foto1conductor.png');
END;
/

/*Otro*/

--1. El cliente inicia sesión en el sistema.
EXECUTE DBMS_SESSION.SET_ROLE('PA_CLIENTE');
--2. El cliente presenta una queja sobre un vehículo que no llegó.
BEGIN
    PA_CLIENTE.AD_PQRS(1, 'No llego el vehiculo', 'Q');
END;
/
--3. El cliente verifica que la queja se ha presentado correctamente.
SELECT * FROM pqrs WHERE codigosolicitud = 1;
--4. El cliente adjunta un anexo a la queja.
BEGIN 
    PA_CLIENTE.AD_Anexo(1, 'Q202311192121', 'Queja', 'https://hgfo.pdf');
END;
/
--5. El cliente verifica que el anexo se ha adjuntado correctamente.
SELECT * FROM anexos WHERE idAnexo = 1;
--6. El analista de clientes inicia sesión en el sistema.
EXECUTE DBMS_SESSION.SET_ROLE('PA_ANALISTA_CLIENTES');
--7. El analista de clientes revisa las quejas pendientes.
SELECT * FROM pqrs WHERE estado = 'Abierto' AND tipo = 'Q';
--8. El analista de clientes responde a la queja del cliente.
BEGIN
    PA_ANALISTA_CLIENTES.AD_PqrsRespuesta('Q202311192121', SYSDATE, 'Resuelto con exito', 'Javier', 'JavierFonseca@gexample.com', 'Resuelto Correctamente', 'Bien');
END;
/
--9. El analista de clientes verifica que la respuesta se ha registrado correctamente.
SELECT * FROM pqrsrespuestas WHERE idTicked = 'Q202311192121';
--10. El cliente verifica que su queja ha sido respondida.
SELECT * FROM pqrs WHERE ticked = 'Q202311192121';
