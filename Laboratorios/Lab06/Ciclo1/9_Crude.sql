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
    FUNCTION CO_Pqrs_Cerrados RETURN SYS_REFCURSOR;
END PC_PQRS;
/