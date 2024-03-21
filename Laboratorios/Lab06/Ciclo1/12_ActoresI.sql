
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
