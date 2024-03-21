
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
                RAISE_APPLICATION_ERROR(-20106, 'No se pudo insertar el pqrs');
    END AD_Pqrs;

    PROCEDURE MO_Pqrs(p_ticked IN VARCHAR2, p_estado IN VARCHAR) IS 
    BEGIN
        UPDATE pqrs SET estado = p_estado WHERE ticked = p_ticked;
        COMMIT;
            EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20107, 'No se pudo Modificar el estado pqrs');
    END MO_Pqrs;

    PROCEDURE DE_Pqrs(p_ticked IN VARCHAR2) IS
        ex_associated_responses EXCEPTION;
        PRAGMA EXCEPTION_INIT(ex_associated_responses, -20013);
    BEGIN 
        DELETE FROM pqrs WHERE TICKED = p_ticked;
        COMMIT;
            EXCEPTION
            WHEN ex_associated_responses THEN
                DBMS_OUTPUT.PUT_LINE('No se pudo eliminar el PQRS porque tiene respuestas asociadas.');
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20108, 'No se pudo eliminar el pqrs');
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
        PRAGMA EXCEPTION_INIT(ex_associated_responses, -20011);
        PRAGMA EXCEPTION_INIT(ex_associated_responses2, -20012);
        PRAGMA EXCEPTION_INIT(ex_unique_key_violation, -00001);
    BEGIN
        INSERT INTO anexos(idAnexo, idTicked, nombre, url)
        VALUES(p_idAnexo, p_idTicked, p_nombre, p_url);
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('El anexo se ingres� correctamente.');
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
                RAISE_APPLICATION_ERROR(-20108, 'No se pudo Modificar el Anexo');
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
                RAISE_APPLICATION_ERROR(-20109, 'No se pudo Agregar la respuesta');
    END AD_PqrsRespuesta;

    PROCEDURE DE_PqrsRespuesta(p_idTicked IN VARCHAR2) IS
    BEGIN
        DELETE FROM pqrsrespuestas WHERE idTicked = p_idTicked;
        COMMIT;
            EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20110, 'No se pudo Eliminar la respuesta');
    END DE_PqrsRespuesta;

    FUNCTION CO_PqrsRespuesta RETURN SYS_REFCURSOR IS
    CO_PR SYS_REFCURSOR;
    BEGIN
    OPEN CO_PR FOR SELECT * FROM pqrsrespuestas;
    RETURN CO_PR;
    END;
    
    FUNCTION CO_Pqrs_Cerrados RETURN SYS_REFCURSOR IS
    CO_PQ_CE SYS_REFCURSOR;
    BEGIN
        OPEN CO_PQ_CE FOR
        SELECT * FROM pqrs
        WHERE estado = 'Cerrado'  
        AND EXTRACT(YEAR FROM radicacion) = EXTRACT(YEAR FROM SYSDATE)
        ORDER BY radicacion DESC;
        RETURN CO_PQ_CE;
    END;

END PC_PQRS;
/
