
/*-------Disparadores-------*/
/*-----Adicion-----*/
/* El codigo y la fecha de creacion son autogenerados*/
DROP SEQUENCE solicitud_codigo_seq;
CREATE SEQUENCE solicitud_codigo_seq START WITH 1 INCREMENT BY 1;
CREATE OR REPLACE TRIGGER TR_SOLICITUDES_CODIGO_BI
BEFORE INSERT ON solicitudes
FOR EACH ROW
BEGIN
    SELECT solicitud_codigo_seq.NEXTVAL
    INTO :NEW.codigo
    FROM dual;
END;
/

CREATE OR REPLACE TRIGGER TR_SOLICITUDES_FECHA_CREACION_BI
BEFORE INSERT ON solicitudes
FOR EACH ROW
BEGIN
    :NEW.fechaCreacion := SYSDATE;
END;
/

/*La fecha de viaje debe ser superior a la fecha actual.*/
CREATE OR REPLACE TRIGGER TR_FECHA_VIAJE_BI
BEFORE INSERT ON solicitudes
FOR EACH ROW
BEGIN
  IF :NEW.fechaViaje <= :NEW.fechaCreacion OR :NEW.fechaViaje <= SYSDATE THEN
    RAISE_APPLICATION_ERROR(-20001, 'La fecha de viaje debe ser superior a la fecha de creacion y a la fecha actual.');
  END IF;
END;
/

/*El estado inicial de la solicitud es Pendiente.*/
CREATE OR REPLACE TRIGGER TR_ESTADO_PENDIENTE_BI
BEFORE INSERT ON solicitudes
FOR EACH ROW
BEGIN
  :NEW.estado := 'Pendiente';
END;
/

/*No puede tener la misma posicion inicial y final*/
CREATE OR REPLACE TRIGGER TR_SOLICITUDES_POSICIONES_BI
BEFORE INSERT ON solicitudes
FOR EACH ROW
DECLARE
    v_ubicacionInicial NUMBER;
    v_ubicacionFinal NUMBER;
BEGIN
    SELECT latitud INTO v_ubicacionInicial
    FROM posiciones
    WHERE ubicacion = :NEW.ubicacionInicial;

    SELECT latitud INTO v_ubicacionFinal
    FROM posiciones
    WHERE ubicacion = :NEW.ubicacionFinal;

    IF v_ubicacionInicial = v_ubicacionFinal THEN
        RAISE_APPLICATION_ERROR(-20002, 'La posicion inicial y final no pueden ser iguales.');
    END IF;
END;
/

/*Un cliente no puede tener dos solicitudes activas*/
CREATE OR REPLACE TRIGGER TR_SOLICITUDES_ACTIVAS_BI
BEFORE INSERT ON solicitudes
FOR EACH ROW
DECLARE
    v_solicitudes_activas NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_solicitudes_activas
    FROM solicitudes
    WHERE idCliente = :NEW.idCliente
    AND estado IN ('Pendiente', 'Asignada');
    IF v_solicitudes_activas >= 1 THEN
        RAISE_APPLICATION_ERROR(-20003, 'Un cliente no puede tener dos solicitudes activas.');
    END IF;
END;
/

/*La fecha de viaje y precio deben iniciar desconocidas (nulo)*/
CREATE OR REPLACE TRIGGER TR_VIAJE_PRECIO_NULL_BI
BEFORE INSERT ON solicitudes
FOR EACH ROW
BEGIN
    :NEW.fechaViaje := NULL;  
    :NEW.precio := NULL;      
END;
/


/*-----Modificacion-----*/

/*Solo se pueden actualizar los campos: fecha de viaje, precio y estado.*/
CREATE OR REPLACE TRIGGER TR_SOLICITUDES_ACTUALIZACION_VERIFICAR_BU
BEFORE UPDATE ON solicitudes
FOR EACH ROW
BEGIN
    IF :NEW.fechaCreacion != :OLD.fechaCreacion OR
       :NEW.codigo != :OLD.codigo OR
       :NEW.idCliente != :OLD.idCliente OR
       :NEW.plataforma != :OLD.plataforma OR
       :NEW.precio != :OLD.precio OR
       :NEW.ubicacionInicial != :OLD.ubicacionInicial OR
       :NEW.ubicacionFinal != :OLD.ubicacionFinal THEN
        RAISE_APPLICATION_ERROR(-20001, 'No se pueden modificar atributos no permitidos en la tabla solicitudes.');
    END IF;
END;
/

/*Se puede modificar la fecha de viaje y el precio si el estado de la solicitud es Pendiente.*/
CREATE OR REPLACE TRIGGER TR_SOLICITUDES_MODIFICACION_FECHA_PRECIO_BU
BEFORE UPDATE ON solicitudes
FOR EACH ROW
BEGIN
  IF :OLD.estado = 'Pendiente' THEN
    NULL;
  ELSE
    RAISE_APPLICATION_ERROR(-20005, 'No se permite cambiar la fecha de viaje o el precio si el estado no es Pendiente.');
  END IF;
END;
/

/*La fecha de viaje debe ser superior a la fecha de creacion y a la fecha actual.*/
CREATE OR REPLACE TRIGGER TR_SOLICITUDES_MODIFICACION_VIAJE_BU
BEFORE UPDATE ON solicitudes
FOR EACH ROW
BEGIN
    IF :new.fechaViaje IS NOT NULL AND :new.fechaCreacion IS NOT NULL AND :new.fechaViaje <= :new.fechaCreacion THEN
        RAISE_APPLICATION_ERROR(-20006, 'La fecha de viaje debe ser posterior a la fecha de creacion.');
    END IF;

    IF :new.fechaViaje IS NOT NULL AND :new.fechaViaje <= SYSDATE THEN
        RAISE_APPLICATION_ERROR(-20007, 'La fecha de viaje debe ser posterior a la fecha actual.');
    END IF;
END;
/

/*El estado se puede cambiar siempre y cuando no sea Cancelada*/
CREATE OR REPLACE TRIGGER TR_ESTADO_MODIFICACION_NO_CANCELADA_BU
BEFORE UPDATE ON solicitudes
FOR EACH ROW
BEGIN
    IF :new.estado = 'Cancelada' THEN
        IF :old.estado <> 'Cancelada' THEN
            RAISE_APPLICATION_ERROR(-20008, 'No se permite cambiar el estado a "Cancelada".');
        END IF;
    END IF;
END;
/

/*-----Eliminacion-----*/

-- Crea el disparador
/*No se pueden eliminar solicitudes*/
CREATE OR REPLACE TRIGGER TR_SOLICITUDES_ELIMINAR_BF
BEFORE DELETE ON solicitudes
BEGIN
    RAISE_APPLICATION_ERROR(-20009, 'No se pueden eliminar solicitudes.');
END;
/




/*-------Disparadores pqrs-------*/
/*-----Adicion-----*/
--1. El ticket  PQRS se crea a partir de la concatenacion del tipo (P, Q, R o S)  y el momento de radicacion en formato YYYYMMDDHHMM
--3. La fecha de radicacion corresponde a la fecha del momento en el cual se registra: Dato automatico.
--4. El estado inicial de un PQRS es Abierto.
CREATE OR REPLACE TRIGGER TR_PQRS_INSERT_BI
BEFORE INSERT ON pqrs
FOR EACH ROW
DECLARE
    ticket VARCHAR2(13) := :NEW.tipo || TO_CHAR(SYSDATE, 'YYYYMMDDHH24MI');
BEGIN
    :NEW.ticked := ticket;
    :NEW.radicacion := SYSDATE;
    :NEW.estado := 'Abierto';
END;
/

--2. Si el tipo no es definido, la orden se registra con tipo S.
CREATE OR REPLACE TRIGGER TR_PQRS_TICKED_BI
BEFORE INSERT ON pqrs
FOR EACH ROW
BEGIN
    IF :NEW.tipo IS NULL OR LENGTH(TRIM(:NEW.tipo)) = 0 THEN
        :NEW.tipo := 'S';
    END IF;
END;
/

/*-----Modificacion-----*/
-- 1. El unico dato  que se puede modificar es el estado del PQRS.
CREATE OR REPLACE TRIGGER TR_PQRS_ESTADO_BU
BEFORE UPDATE ON pqrs
FOR EACH ROW
BEGIN
    -- Verifica si se esta modificando el estado
    IF :OLD.estado <> :NEW.estado THEN
        -- El estado es lo unico que se puede modificar
        NULL;
    ELSE
        -- Genera un error si se intenta modificar otro campo
        RAISE_APPLICATION_ERROR(-20009, 'Solo se puede modificar el estado del PQRS.');
    END IF;
END;
/

-- 2. Al cerrar o rechazar la PQRS se debe asignar la fecha actual en el campo fecha de cierre.
CREATE OR REPLACE TRIGGER TR_PQRS_ESTADO_FECHA_BU
BEFORE UPDATE ON pqrs
FOR EACH ROW
BEGIN
    IF :OLD.estado <> :NEW.estado AND (:NEW.estado = 'Cerrado' OR :NEW.estado = 'Rechazado') THEN
        :NEW.cierre := SYSDATE;
    END IF;
END;
/

-- 3. La fecha de cierre debe ser posterior a la fecha de radicacion.
CREATE OR REPLACE TRIGGER TR_PQRS_FECHA_RADICACION_BU
BEFORE UPDATE ON pqrs
FOR EACH ROW
BEGIN
    IF :OLD.cierre IS NOT NULL AND :NEW.cierre IS NOT NULL THEN
        IF :NEW.cierre <= :OLD.radicacion THEN
            RAISE_APPLICATION_ERROR(-20010, 'La fecha de cierre debe ser posterior a la fecha de radicacion.');
        END IF;
    END IF;
END;
/

-- 4. Solo es posible adicionar anexos al PQRS si su estado es Abierto.
CREATE OR REPLACE TRIGGER TR_ANEXOS_BI
BEFORE INSERT ON anexos
FOR EACH ROW
BEGIN
    DECLARE
        v_estado_pqrs VARCHAR2(10);
    BEGIN
        SELECT estado
        INTO v_estado_pqrs
        FROM pqrs
        WHERE ticked = :NEW.idTicked;
        IF v_estado_pqrs <> 'Abierto' THEN
            RAISE_APPLICATION_ERROR(-20011, 'Solo es posible adicionar anexos a un PQRS si su estado es "Abierto".');
        END IF;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20012, 'El PQRS al que intenta adicionar un anexo no existe.');
    END;
END;
/

/*-----ELIMINAR-----*/

-- 1. Los PQRS solo se pueden eliminar si no tienen respuestas asociadas.
CREATE OR REPLACE TRIGGER TR_PQRS_ELIMINAR_BD
BEFORE DELETE ON pqrs
FOR EACH ROW
DECLARE
    v_respuestas_asociadas NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_respuestas_asociadas
    FROM pqrsrespuestas
    WHERE idTicked = :OLD.ticked;
    IF v_respuestas_asociadas > 0 THEN
        RAISE_APPLICATION_ERROR(-20013, 'No se puede eliminar el PQRS porque tiene respuestas asociadas.');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER TR_PQRSRESPUESTAS_BI
BEFORE INSERT ON pqrsrespuestas
FOR EACH ROW
BEGIN
    :NEW.fecha := SYSDATE;
    UPDATE pqrs SET estado = 'Cerrado' WHERE ticked = :NEW.idTicked;
END;
/

-- 2. Al eliminar un PQRS se deben borrar los documentos anexos asociados.
--Es un CHECK