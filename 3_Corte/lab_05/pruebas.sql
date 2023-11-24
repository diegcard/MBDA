

CREATE TABLE pqrs(
    ticked VARCHAR2(13) NOT NULL,
    codigoSolicitud NUMBER(9) NOT NULL,
    radicacion DATE NOT NULL,
    cierre DATE NULL,
    descripcion VARCHAR2(50) NULL,
    tipo CHAR(1)NOT NULL,
    estado VARCHAR2(10) NOT NULL
);

CREATE TABLE anexos(
    idAnexo NUMBER(11) NOT NULL,
    idTicked VARCHAR2(13) NOT NULL,
    nombre VARCHAR2(20) NOT NULL,
    url VARCHAR2(50) NOT NULL
);

CREATE TABLE pqrsrespuestas(
	idTicked VARCHAR2(13) NOT NULL,
	fecha DATE NOT NULL,
	descripcion VARCHAR2(50) NOT NULL,
	nombre VARCHAR2(20) NOT NULL,
	correo VARCHAR2(50) NOT NULL,
	comentario VARCHAR2(20) NULL,
	evaluacion VARCHAR2(20) NULL
);

/*------------Restriccion CHECK para la tabla anexos------------*/
ALTER TABLE anexos ADD CONSTRAINT chk_anexos_url CHECK (SUBSTR(url, 1, 8) = 'https://');
ALTER TABLE anexos ADD CONSTRAINT chk__anexos_nombre CHECK (REGEXP_LIKE(nombre, 'Peticion|Queja|Reclamo|Sugerencia'));

/*------------Restricciones CHECK para la tabla pqrs------------*/
ALTER TABLE pqrs ADD CONSTRAINT chk_pqrs_ticked CHECK (REGEXP_LIKE(ticked, '^[PQRS][0-9]{12}$'));
ALTER TABLE pqrs ADD CONSTRAINT chk_pqrs_tipo CHECK (tipo IN ('P', 'Q', 'R', 'S'));
ALTER TABLE pqrs ADD CONSTRAINT chk_pqrs_estado CHECK (estado IN ('Abierto', 'Cerrado', 'Rechazado'));

/*---------------------------------------------CICLO 1: Primarias--------------------------------------------*/
ALTER TABLE anexos ADD CONSTRAINT pk_anexos_idAnexo PRIMARY KEY(idAnexo);
ALTER TABLE pqrsrespuestas ADD CONSTRAINT pk_pqrsrespuestas_idTicked PRIMARY KEY(idTicked);
ALTER TABLE pqrs ADD CONSTRAINT pk_pqrs_ticked PRIMARY KEY(ticked);

/*---------------------------------------------CICLO 1: Unicas--------------------------------------------*/
ALTER TABLE anexos ADD CONSTRAINT uk_anexos_url UNIQUE (url);

/*---------------------------------------------CICLO 1: Foraneas---------------------------------------------*/
ALTER TABLE anexos ADD CONSTRAINT fk_anexos_idTicked FOREIGN KEY(idTicked) REFERENCES pqrs(ticked);
ALTER TABLE pqrsrespuestas ADD CONSTRAINT fk_pqrsrespuestas FOREIGN KEY (idTicked) REFERENCES pqrs(ticked);

/*otorga*/
ALTER TABLE anexos DROP CONSTRAINT fk_anexos_idTicked;
ALTER TABLE anexos ADD CONSTRAINT fk_anexos_idTicked FOREIGN KEY(idTicked) REFERENCES pqrs(ticked) ON DELETE CASCADE;


/*----------------------------*/
CREATE OR REPLACE TRIGGER TR_PQRS_INSERT_BF
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

/*----------------------------*/
CREATE OR REPLACE TRIGGER TR_PQRS_TICKED_BF_JU
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
CREATE OR REPLACE TRIGGER TR_PQRS_M_ESTADO_BF
BEFORE UPDATE ON pqrs
FOR EACH ROW
BEGIN
    IF :OLD.estado <> :NEW.estado THEN
        NULL;
    ELSE
        RAISE_APPLICATION_ERROR(-20001, 'Solo se puede modificar el estado del PQRS.');
    END IF;
END;
/

-- 2. Al cerrar o rechazar la PQRS se debe asignar la fecha actual en el campo fecha de cierre.
CREATE OR REPLACE TRIGGER TR_PQRS_ESTADO_M_FECHA_BF
BEFORE UPDATE ON pqrs
FOR EACH ROW
BEGIN
    IF :OLD.estado <> :NEW.estado AND (:NEW.estado = 'Cerrado' OR :NEW.estado = 'Rechazado') THEN
        :NEW.cierre := SYSDATE;
    END IF;
END;
/

-- 3. La fecha de cierre debe ser posterior a la fecha de radicacion.
CREATE OR REPLACE TRIGGER TR_PQRS_FECHA_M_PRADICACION_BF
BEFORE UPDATE ON pqrs
FOR EACH ROW
BEGIN
    IF :OLD.cierre IS NOT NULL AND :NEW.cierre IS NOT NULL THEN
        IF :NEW.cierre <= :OLD.radicacion THEN
            RAISE_APPLICATION_ERROR(-20002, 'La fecha de cierre debe ser posterior a la fecha de radicacion.');
        END IF;
    END IF;
END;
/

-- 4. Solo es posible adicionar anexos al PQRS si su estado es Abierto.
CREATE OR REPLACE TRIGGER TR_ANEXOS_IN_BF
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
            RAISE_APPLICATION_ERROR(-20003, 'Solo es posible adicionar anexos a un PQRS si su estado es "Abierto".');
        END IF;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20004, 'El PQRS al que intenta adicionar un anexo no existe.');
    END;
END;
/

/*-----ELIMINAR-----*/

-- 1. Los PQRS solo se pueden eliminar si no tienen respuestas asociadas.
CREATE OR REPLACE TRIGGER TR_PQRS_ELIMINAR_BF
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
        RAISE_APPLICATION_ERROR(-20005, 'No se puede eliminar el PQRS porque tiene respuestas asociadas.');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER TR_PQRSRESPUESAS_IN_BE
BEFORE INSERT ON pqrsrespuestas
FOR EACH ROW
BEGIN
    :NEW.fecha := SYSDATE;
    UPDATE pqrs SET estado = 'Cerrado' WHERE ticked = :NEW.idTicked;
END;
/





