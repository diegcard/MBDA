-- Diego Cardenas
-- Jeimmy Yaya

INSERT INTO staff VALUES('co.ACg','Cumming Andrew');

CREATE OR REPLACE PACKAGE PC_EVENT AS
  PROCEDURE ad(modle IN VARCHAR2, kind IN CHAR, dow IN VARCHAR2, tod IN VARCHAR2, duration IN NUMBER, room IN VARCHAR2);
  PROCEDURE up(idew IN VARCHAR2, roomew IN VARCHAR2);
  PROCEDURE adStaff(event IN VARCHAR2, staff IN VARCHAR2);
  PROCEDURE del(event IN VARCHAR2);
  FUNCTION co(event IN VARCHAR2) RETURN SYS_REFCURSOR;
END PC_EVENT;
/

CREATE OR REPLACE PACKAGE BODY PC_EVENT AS
    PROCEDURE ad(modle IN VARCHAR2, kind IN CHAR, dow IN VARCHAR2, tod IN VARCHAR2, duration IN NUMBER, room IN VARCHAR2) IS
    v_id VARCHAR2(20);
    v_duration NUMBER(1);
  BEGIN
    v_id := modle || '.' || kind || LPAD(event_id_seq.CURRVAL, 2, '0');
    IF SUBSTR(tod, 1, 5) = '20:00' THEN
      v_duration := 1;
    ELSE
      v_duration := duration;
    END IF;
    INSERT INTO event VALUES (v_id, modle, kind, dow, tod, v_duration, room);
  END ad;

  PROCEDURE up(idew IN VARCHAR2, roomew IN VARCHAR2) IS
  BEGIN
    UPDATE event SET room = roomew WHERE id = idew;
  END up;

  PROCEDURE adStaff(event IN VARCHAR2, staff IN VARCHAR2) IS
  BEGIN
    INSERT INTO teaches VALUES (staff, event);
  END adStaff;

  PROCEDURE del(event IN VARCHAR2) IS
  BEGIN
    DELETE FROM teaches WHERE event = event;
    DELETE FROM event WHERE id = event;
  END del;

  FUNCTION co(event IN VARCHAR2) RETURN SYS_REFCURSOR IS
    v_cursor SYS_REFCURSOR;
  BEGIN
    OPEN v_cursor FOR
      SELECT * FROM event WHERE id = event;
    RETURN v_cursor;
  END co;

END PC_EVENT;
/

/*-----------------Crud OK---------------*/

-- ad
DECLARE
  v_event_id VARCHAR2(20);
BEGIN
  PC_EVENT.ad('co12001', 'L', 'Monday', '14:00', 2, 'Room123');
  SELECT id INTO v_event_id FROM event WHERE modle = 'co12001' AND kind = 'L' AND dow = 'Monday' AND tod = '14:00' AND duration = 2 AND room = 'Room123' AND ROWNUM = 1;
END;
/

-- up
DECLARE
  v_event_id VARCHAR2(20);
BEGIN
  v_event_id := 'co12001.L01';
  PC_EVENT.up(v_event_id, 'NewRoom456');
END;
/

-- adStaff
DECLARE
  v_event_id VARCHAR2(20);
  v_staff_id VARCHAR2(20);
BEGIN
  v_event_id := 'co12001.L01';
  v_staff_id := 'Staff123';
  PC_EVENT.adStaff(v_event_id, v_staff_id);
END;
/

-- del
DECLARE
  v_event_id VARCHAR2(20);
BEGIN
  v_event_id := 'co12001.L01';
  PC_EVENT.del(v_event_id);
END;
/

-- co
DECLARE
  v_event_id VARCHAR2(20);
  v_event_cursor SYS_REFCURSOR;
BEGIN
  v_event_id := 'co12001.L09';
  v_event_cursor := PC_EVENT.co(v_event_id);
END;
/

-- coTeams 

DECLARE
  v_teams_cursor SYS_REFCURSOR;
BEGIN
  OPEN v_teams_cursor FOR PC_EVENT.coTeams;
  DBMS_OUTPUT.PUT_LINE('Consulta de equipos de enseñanza realizada exitosamente.');
END;
/

-- coEvents 

DECLARE
  v_staff_id VARCHAR2(20);
  v_events_cursor SYS_REFCURSOR;
BEGIN
  v_staff_id := 'Staff123';
  OPEN v_events_cursor FOR PC_EVENT.coEvents(v_staff_id);
  DBMS_OUTPUT.PUT_LINE('Consulta de eventos enseñados realizada exitosamente.');
END;
/

/*----------CrudNoOk----------*/
-- Casos que podrían causar fallos para ad (Agregar Evento)

EXEC PC_EVENT.ad('co12004', 'L', 'Wednesday', '11:00', 1, 'cr.SMH');
EXEC PC_EVENT.ad('co12005', 'L', 'Friday', '20:00', 2, 'cr.ABC');
EXEC PC_EVENT.ad('co12006', 'L', 'Sunday', '14:00', 1, 'cr.XYZ');

-- Casos que podrían causar fallos para up (Actualizar Evento)

EXEC PC_EVENT.up('co99999.L01', 'NewRoom123');
EXEC PC_EVENT.up('co12004.L01', 'NewRoom456', 'InvalidColumnChange');
EXEC PC_EVENT.up('co12004.L01', NULL);

-- Casos que podrían causar fallos para adStaff (Agregar Profesor a Evento)

EXEC PC_EVENT.adStaff('co99999.L01', 'Staff123');
EXEC PC_EVENT.adStaff('co12004.L01', 'NonExistentStaff');
EXEC PC_EVENT.adStaff('co12004.L01', 'Staff123');
EXEC PC_EVENT.adStaff('co12004.L01', 'Staff123');


/*----------XPackage----------*/
DROP PACKAGE PC_EVENT;
