/*---------------------------------------------Tablas---------------------------------------------*/
CREATE TABLE staff(
    id varchar(20) NOT NULL,
    name varchar(50) NOT NULL
);

CREATE TABLE modle(
    id varchar(20) NOT NULL,
    name varchar(50) NOT NULL
);

CREATE TABLE event(
    id VARCHAR2(20) NOT NULL,
    modle VARCHAR2(50) NOT NULL,
    kind char(1) NOT NULL,
    dow VARCHAR2(15) NOT NULL,
    tod CHAR(5) NOT NULL,
    duration NUMBER(1) NOT NULL,
    room VARCHAR2(20) NULL
);

CREATE TABLE teaches(
    staff varchar(20) NOT NULL,
    event varchar(20) NOT NULL
);

/*---------------------------------------------Adicionando restricciones declarativas---------------------------------------------*/

-- Checks

ALTER TABLE event ADD CONSTRAINT check_kind CHECK (kind='L' OR kind='T');
ALTER TABLE event ADD CONSTRAINT check_dow_days CHECK (dow='Monday' OR dow='Tuesday' OR dow='Wednesday' OR dow='Thursday' OR dow='Friday');
ALTER TABLE event ADD CONSTRAINT check_duration CHECK (duration = 1 OR duration = 2);
ALTER TABLE event ADD CONSTRAINT check_tod_range CHECK (SUBSTR(tod, 1, 2) BETWEEN '08' AND '20' AND SUBSTR(tod, 4, 2) BETWEEN '00' AND '59');


-- Casos para AtributosOK

-- Insertar una fila v�lida con tipo 'L', d�a de la semana 'Wednesday', hora entre 08:00 y 20:59, y duraci�n 1.
INSERT INTO event VALUES('co12004.L01','co12004','L','Wednesday','11:00',1,'cr.SMH');

-- Insertar una fila v�lida con tipo 'L', d�a de la semana 'Wednesday', hora entre 08:00 y 20:59, y duraci�n 1.
INSERT INTO event VALUES('co12004.L02','co12004','L','Monday','17:00',1,'cr.B13');

-- Casos para AtributosNoOK

-- Intentar insertar una fila con tipo 'X' (no v�lido), lo cual deber�a generar un error.
INSERT INTO event VALUES ('3', 'Modelo3', 'X', 'Saturday', '12:00', 1, 'Sala C');

-- Intentar insertar una fila con d�a de la semana 'Saturday' (no v�lido), lo cual deber�a generar un error.
INSERT INTO event VALUES ('4', 'Modelo4', 'L', 'Saturday', '09:30', 1, 'Sala D');

-- Casos para TuplasOK

-- Insertar varias filas v�lidas que cumplan con todas las restricciones.
INSERT INTO event VALUES ('co12004.L03','co12004','L','Wednesday','11:00',1,'cr.SMH');
INSERT INTO event VALUES ('co12004.L04','co12004','L','Wednesday','11:00',1,'cr.SMH');
-- Casos para TuplasNoOK

-- Intentar insertar una fila con tipo 'T' y hora '21:00' (fuera del rango v�lido para la hora), lo cual deber�a generar un error.
INSERT INTO event  VALUES ('7', 'Modelo7', 'T', 'Viernes', '21:00', 2, 'Sala G');

-- Intentar insertar una fila con d�a de la semana 'Domingo' y duraci�n '3' (valores no v�lidos), lo cual deber�a generar un error.
INSERT INTO event VALUES ('8', 'Modelo8', 'L', 'Domingo', '11:30', 3, 'Sala H');


/*---------------------------------------------Adicionando acciones de referencia---------------------------------------------*/
/*---------------------------------------------PRIMARY KEY---------------------------------------------*/
ALTER TABLE staff ADD CONSTRAINT PK_STAFF PRIMARY KEY(id);
ALTER TABLE modle ADD CONSTRAINT PK_MODLE PRIMARY KEY(id);
ALTER TABLE event ADD CONSTRAINT PK_EVENT PRIMARY KEY (id);
ALTER TABLE teaches ADD CONSTRAINT PK_TEACHES PRIMARY KEY(staff, event);
/*---------------------------------------------Foraneas---------------------------------------------*/
-- ACCIONES 
-- Esto asegura que cada evento est� asociado a un modelo v�lido. Evita la posibilidad de que se hagan referencias a modelos inexistentes o inv�lidos.
ALTER TABLE event ADD CONSTRAINT FK_EVENT_MODLE FOREIGN KEY(modle) REFERENCES modle(id);
-- Esto asegura que cada registro en la tabla teaches est� asociado a un miembro del personal v�lido. Evita la posibilidad de que se hagan referencias a miembros del personal que no existen en la base de datos.
ALTER TABLE teaches ADD CONSTRAINT FK_TEACHES_STAFF FOREIGN KEY(staff) REFERENCES staff(id);
-- Esto asegura que cada registro en la tabla teaches est� asociado a un evento v�lido. Evita la posibilidad de que se hagan referencias a eventos que no existen en la base de datos.
ALTER TABLE teaches ADD CONSTRAINT FK_TEACHES_EVENT FOREIGN KEY(event) REFERENCES event(id);

-- AccionesOK
INSERT INTO modle VALUES('co12004','Applications Workshop');
INSERT INTO event VALUES('co12004.L10','co12004','L','Wednesday','11:00',1,'cr.SMH');

/*---------------------------------------------Disparadores---------------------------------------------*/
CREATE SEQUENCE event_id_seq
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 99;
    

CREATE OR REPLACE TRIGGER TR_EVENT_BI
BEFORE INSERT ON event
FOR EACH ROW
DECLARE
    v_duration NUMBER(1);
BEGIN
    :NEW.id := :NEW.modle || '.' || :NEW.kind || LPAD(event_id_seq.NEXTVAL, 2, '0');
    IF SUBSTR(:NEW.tod, 1, 5) = '20:00' THEN
        v_duration := 1;
    ELSE
        v_duration := :NEW.duration;
    END IF;
    :NEW.duration := v_duration;
END;
/


CREATE OR REPLACE TRIGGER TR_EVENT_BU
BEFORE UPDATE ON event
FOR EACH ROW
BEGIN
    IF :OLD.room IS NOT NULL AND :NEW.room IS NOT NULL AND (
        :OLD.modle <> :NEW.modle OR
        :OLD.kind <> :NEW.kind OR
        :OLD.dow <> :NEW.dow OR
        :OLD.tod <> :NEW.tod OR
        :OLD.duration <> :NEW.duration
    ) THEN
        RAISE_APPLICATION_ERROR(-20001, 'Solo se permite modificar la columna "room".');
    END IF;
END;
/

/*---------------------------------------------XDisparadores---------------------------------------------*/

DROP TRIGGER TR_EVENT_BI;
DROP TRIGGER TR_EVENT_BU;

/*---------------------------------------------DisparadoresOk---------------------------------------------*/

-- Actualizaci�n v�lida de la columna
UPDATE event SET room = 'c1' WHERE id = 'co12004.L04';

-- Intento de actualizaci�n de otras columnas 
UPDATE event SET modle = 'NuevoModelo' WHERE id = 'co12004.L04';

-- Intento de actualizaci�n de otras columnas 
UPDATE event SET kind = 'T' WHERE id = 'co12004.L04';

/*---------------------------------------------DisparadoresNoOk---------------------------------------------*/
-- Intento de actualizar la columna "room" y otras columnas
UPDATE event SET room = 'c1', modle = 'NuevoModelo' WHERE id = 'co12004.L04';

-- Intento de actualizar la columna "room" y otras columnas
UPDATE event SET room = 'c1', kind = 'T' WHERE id = 'co12004.L04';

-- Intento de actualizar otras columnas
UPDATE event SET modle = 'NuevoModelo', kind = 'T' WHERE id = 'co12004.L04';


--XPoblar

TRUNCATE TABLE modle;
TRUNCATE TABLE staff;
TRUNCATE TABLE teaches;
TRUNCATE TABLE event;


SELECT * FROM event;
SELECT * FROM modle;

--XTablas

DROP TABLE staff;
DROP TABLE modle;
DROP TABLE event;
DROP TABLE teaches;

