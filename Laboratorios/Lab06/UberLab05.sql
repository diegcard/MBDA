

--LABORATORIO 5 MODELOS Y BASES DE DATOS

/*----------Punto A:----------*/
--1.
SELECT * FROM MBDA.DATA;
--2.
INSERT INTO MBDA.DATA VALUES('Diego.cardenas-b@mail.escuelaing.edu.co', '1193116440', '3006816785', 'Diego Cardenas');
INSERT INTO MBDA.DATA VALUES('jeimy.yaya-m@mail.escuelaing.edu.co', '1000520431', '3204779336', 'Jeimy Yaya');
--3. 
DELETE FROM mbda.Data WHERE cedula = '1193116440';
DELETE FROM mbda.Data WHERE cedula = '1000520431';
--No tenemos los permisos suficientes para borrarnos o modificarnos
--4. 
GRANT UPDATE,DELETE 
ON mbda.Data
TO bd1000093114;

GRANT UPDATE,DELETE 
ON mbda.Data
TO bd1000093739;
/*Me tienen que otorgar permisos un tercero, no puedo yo mismo darme permisos*/
--5. 

INSERT INTO Personas(id, tipo, numero, nombre, registro, celular, correo)
SELECT TO_NUMBER(SUBSTR(t.cedula, 1, 6) || LPAD(FLOOR(DBMS_RANDOM.VALUE(1, 1000)), 3, '0')) AS Id, 'CC' AS Tipo ,cedula, nombres, SYSDATE, celular, email
FROM (
  SELECT DISTINCT CEDULA, celular, nombres, email
  FROM MBDA.DATA
) t
WHERE celular IS NOT NULL OR email IS NOT NULL or cedula IS NOT NULL OR nombres IS NOT NULL;

INSERT INTO clientes (idCliente, idioma)
SELECT id, 'Espaniol' AS idioma
FROM personas;
--6
--Resuelto en el ASTAH