S-- CREATE DATABASE uber;
-- USE uber;

/*---------------------------------------------CICLO 1: XTablas---------------------------------------------*/
DROP TABLE vehiculos CASCADE CONSTRAINTS;
DROP TABLE conductores CASCADE CONSTRAINTS;
DROP TABLE tarjetasClientes CASCADE CONSTRAINTS;
DROP TABLE tarjetas CASCADE CONSTRAINTS;
DROP TABLE anexos CASCADE CONSTRAINTS;
DROP TABLE pqrsrespuestas CASCADE CONSTRAINTS;
DROP TABLE pqrs CASCADE CONSTRAINTS;
DROP TABLE requerimientos CASCADE CONSTRAINTS;
DROP TABLE solicitudes CASCADE CONSTRAINTS;
DROP TABLE posiciones CASCADE CONSTRAINTS;
DROP TABLE clientes CASCADE CONSTRAINTS;
DROP TABLE personas CASCADE CONSTRAINTS;



-- CREATE TABLES
/*---------------------------------------------CICLO 1: Tablas---------------------------------------------*/
CREATE TABLE personas(
    id NUMBER(9) NOT NULL,
    tipo VARCHAR2(10) NOT NULL,
    numero NUMBER(11)NOT NULL,
    nombre VARCHAR2(50)NOT NULL,
    registro DATE NOT NULL,
    celular NUMBER(10)NOT NULL,
    correo VARCHAR2(80) NOT NULL
);

CREATE TABLE conductores(
    idConductor NUMBER(9) NOT NULL,
    licencia VARCHAR2(10) NOT NULL,
    fechaNacimiento DATE NOT NULL,
    estrellas NUMBER(1) NOT NULL,
    estado VARCHAR2(10) NOT NULL
);

CREATE TABLE clientes(
    idCliente NUMBER(9) NOT NULL,
    idioma VARCHAR2(10) NOT NULL
);

CREATE TABLE vehiculos(
    idConductor NUMBER(9) NOT NULL,
    placa VARCHAR2(30) NOT NULL,
    a_o VARCHAR2(10)NOT NULL,
    tipo CHAR(1) NOT NULL,
    estado VARCHAR2(10) NOT NULL,
    puertas NUMBER(1) NULL,
    pasajeros NUMBER(1) NULL,
    carga NUMBER(5) NULL
);

CREATE TABLE tarjetasClientes(
    idCliente NUMBER(9) NOT NULL,
    numeroT NUMBER(15) NOT NULL
);

CREATE TABLE tarjetas(
    numero NUMBER(15) NOT NULL,
    entidad VARCHAR2(10)NOT NULL,
    vencimiento DATE NOT NULL
);

CREATE TABLE solicitudes(
    idCliente NUMBER(9) NOT NULL,
    codigo NUMBER(9) NOT NULL,
    fechaCreacion DATE NOT NULL,
    fechaViaje DATE NULL,
    plataforma CHAR(1) NOT NULL,
    precio FLOAT NULL,
    estado VARCHAR2(10) NOT NULL,
    ubicacionInicial NUMBER(11) NOT NULL,
    ubicacionFinal NUMBER(11) NOT NULL
);

CREATE TABLE requerimientos(
    info VARCHAR2(50) NULL,
    idSolicitud NUMBER(9) NOT NULL
);

CREATE TABLE posiciones(
    ubicacion NUMBER(11) NOT NULL,
    latitud FLOAT NOT NULL,
    longitud FLOAT NOT NULL
);

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
	correo VARCHAR2(80) NOT NULL,
	comentario VARCHAR2(20) NULL,
	evaluacion VARCHAR2(20) NULL
);
/*---------------------------------------------CICLO 1: XTablas---------------------------------------------*/

DROP TABLE vehiculos CASCADE CONSTRAINTS;
DROP TABLE conductores CASCADE CONSTRAINTS;
DROP TABLE tarjetasClientes CASCADE CONSTRAINTS;
DROP TABLE tarjetas CASCADE CONSTRAINTS;
DROP TABLE anexos CASCADE CONSTRAINTS;
DROP TABLE pqrsrespuestas CASCADE CONSTRAINTS;
DROP TABLE pqrs CASCADE CONSTRAINTS;
DROP TABLE requerimientos CASCADE CONSTRAINTS;
DROP TABLE solicitudes CASCADE CONSTRAINTS;
DROP TABLE posiciones CASCADE CONSTRAINTS;
DROP TABLE clientes CASCADE CONSTRAINTS;
DROP TABLE personas CASCADE CONSTRAINTS;

/*---------------------------------------------CICLO 1: PoblarOk (1)--------------------------------------------*/

/*-----------personas-----------*/
INSERT INTO personas VALUES (1, 'CC', 12345, 'Juan Perez', TO_DATE('2023-10-20', 'YYYY-MM-DD'), 5555555555, 'juan@example.com');
INSERT INTO personas VALUES (2, 'CC', 54321, 'Maria Rodriguez', TO_DATE('2023-10-20', 'YYYY-MM-DD'), 6666666666, 'maria@example.com');
INSERT INTO personas VALUES (3, 'TI', 67890, 'Ana Lopez', TO_DATE('2023-10-20', 'YYYY-MM-DD'), 7777777777, 'ana@example.com');
INSERT INTO personas VALUES (4, 'CC', 123456789, 'Juan Perez', TO_DATE('2023-10-23', 'YYYY-MM-DD'), 3212345678, 'juanperez@email.com');
INSERT INTO personas VALUES (5, 'CE', 987654321, 'Maria Lopez', TO_DATE('2023-10-23', 'YYYY-MM-DD'), 3009876543, 'marialopez@email.com');

/*-----------conductores-----------*/
INSERT INTO conductores VALUES (1, '1886816', TO_DATE('1990-01-15', 'YYYY-MM-DD'), 4, 'Activo');
INSERT INTO conductores VALUES (2, '111314', TO_DATE('1985-05-20', 'YYYY-MM-DD'), 5, 'Activo');
INSERT INTO conductores VALUES (3, '113831181', TO_DATE('1988-08-10', 'YYYY-MM-DD'), 3, 'Inactivo');
INSERT INTO conductores VALUES (4, '113553', TO_DATE('1990-05-15', 'YYYY-MM-DD'), 4, 'Activo');
INSERT INTO conductores VALUES (5, '1313135', TO_DATE('1985-11-10', 'YYYY-MM-DD'), 5, 'Activo');

/*-----------clientes-----------*/
INSERT INTO clientes VALUES (1, 'Espaniol');
INSERT INTO clientes VALUES (2, 'Ingles');
INSERT INTO clientes VALUES (3, 'Frances');
INSERT INTO clientes VALUES (4, 'Espaniol');
INSERT INTO clientes VALUES (5, 'Ingles');

/*-----------vehiculos-----------*/
INSERT INTO vehiculos VALUES (1, 'ABC123', '2020', 'S', 'Activo', 4, 4, 0);
INSERT INTO vehiculos VALUES (2, 'XYZ789', '2018', 'S', 'Activo', 4, 4, 0);
INSERT INTO vehiculos VALUES (3, 'DEF456', '2019', 'M', 'Activo', 4, 4, 1);
INSERT INTO vehiculos VALUES (4, 'ABC123', '2022', 'M', 'Activo', 4, 5, NULL);
INSERT INTO vehiculos VALUES (5, 'XYZ789', '2020', 'C', 'Pendiente', 2, 2, 500);

/*-----------tarjetasClientes-----------*/
INSERT INTO tarjetasClientes VALUES (1, 123456789012345);
INSERT INTO tarjetasClientes VALUES (2, 987654321098765);
INSERT INTO tarjetasClientes VALUES (3, 567890123456789);
INSERT INTO tarjetasClientes VALUES (4, 1234567890);
INSERT INTO tarjetasClientes VALUES (5, 9876543210);

/*-----------tarjetas-----------*/
INSERT INTO tarjetas VALUES(123456789012345, 'Visa', TO_DATE('2024-12-31', 'YYYY-MM-DD'));
INSERT INTO tarjetas VALUES(987654321098765, 'MasterCard', TO_DATE('2025-06-30', 'YYYY-MM-DD'));
INSERT INTO tarjetas VALUES(567890123456789, 'BBVA', TO_DATE('2023-09-30', 'YYYY-MM-DD'));
INSERT INTO tarjetas VALUES (1234567890123456, 'Visa', TO_DATE('2024-12-31', 'YYYY-MM-DD'));
INSERT INTO tarjetas VALUES (9876543210987654, 'Mastercard', TO_DATE('2025-06-30', 'YYYY-MM-DD'));

/*-----------solicitudes-----------*/
INSERT INTO solicitudes VALUES(1, 1001, TO_DATE('2023-10-20', 'YYYY-MM-DD'), TO_DATE('2023-10-21', 'YYYY-MM-DD'), 'W', 25.99, 'Pendiente', 1, 2);
INSERT INTO solicitudes VALUES(2, 1002, TO_DATE('2023-10-20', 'YYYY-MM-DD'), TO_DATE('2023-10-22', 'YYYY-MM-DD'), 'M', 30.50, 'Aceptada', 2, 3);
INSERT INTO solicitudes VALUES(3, 1003, TO_DATE('2023-10-20', 'YYYY-MM-DD'), TO_DATE('2023-10-23', 'YYYY-MM-DD'), 'W', 18.75, 'Cancelada',3, 1);
INSERT INTO solicitudes VALUES (4, 12345, TO_DATE('2023-10-23', 'YYYY-MM-DD'), TO_DATE('2023-10-24', 'YYYY-MM-DD'), 'W', NULL, 'Pendiente', 1, 2);
INSERT INTO solicitudes VALUES (5, 54321, TO_DATE('2023-10-24', 'YYYY-MM-DD'), NULL, 'A', NULL, 'Pendiente', 3, 4);

/*-----------requerimientos-----------*/
INSERT INTO requerimientos VALUES ('R1001', 1001);
INSERT INTO requerimientos VALUES ('R1002', 1002);
INSERT INTO requerimientos VALUES ('R1003', 1003);
INSERT INTO requerimientos VALUES ('R1004', 1004);
INSERT INTO requerimientos VALUES ('R1005', 1005);

/*-----------posiciones-----------*/
INSERT INTO posiciones VALUES (4, 38.8951100, -77.0363700);
INSERT INTO posiciones VALUES (5, 51.509865, -0.118092);
INSERT INTO posiciones VALUES (6, 40.7128, -74.0060);
INSERT INTO posiciones VALUES (7, 40.7478, -74.5860);
INSERT INTO posiciones VALUES (8, 48.7128, -47.12560);

/*-----------pqrs-----------*/
INSERT INTO pqrs VALUES ('T1004', 1004, TO_DATE('2023-10-26', 'YYYY-MM-DD'), TO_DATE('2023-10-27', 'YYYY-MM-DD'), 'Problema de seguridad', 'Q', 'En Proceso');
INSERT INTO pqrs VALUES ('T1005', 1005, TO_DATE('2023-10-27', 'YYYY-MM-DD'), TO_DATE('2023-10-28', 'YYYY-MM-DD'), 'Demora en el servicio', 'R', 'Abierto');
INSERT INTO pqrs VALUES ('T1006', 1006, TO_DATE('2023-10-28', 'YYYY-MM-DD'), TO_DATE('2023-02-21', 'YYYY-MM-DD'), 'Felicitaciones al conductores', 'E', 'Cerrado');
INSERT INTO pqrs VALUES ('T1007', 1007, TO_DATE('2023-10-23', 'YYYY-MM-DD'), NULL, 'Demora en el servicio', 'R', 'Consulta');
INSERT INTO pqrs VALUES ('T1008', 1008, TO_DATE('2023-10-24', 'YYYY-MM-DD'), NULL, 'Demora en el servicio', 'R', 'Reclamo');

/*-----------anexos-----------*/
INSERT INTO anexos VALUES(4, 'T1004', 'Foto3.jpg', 'https://example.com/foto3.jpg');
INSERT INTO anexos VALUES(5, 'T1005', 'Audio.mp3', 'https://example.com/audio.mp3');
INSERT INTO anexos VALUES(6, 'T1006', 'Documento.pdf', 'https://example.com/documento.pdf');
INSERT INTO anexos VALUES(7, 'T1007', 'Documento.pdf', 'https://example.com/documento12.pdf');
INSERT INTO anexos VALUES(7, 'T1008', 'Documento.pdf', 'https://example.com/documento454.pdf');

/*-----------pqrsrespuestas-----------*/
INSERT INTO pqrsrespuestas VALUES('T1004', TO_DATE('2023-10-27', 'YYYY-MM-DD'), 'Estamos investigando su reporte', 'Soporte', 'soporte@example.com', 'Gracias ', 'Pendiente');
INSERT INTO pqrsrespuestas VALUES('T1005', TO_DATE('2023-10-28', 'YYYY-MM-DD'), 'Hemos tomado medidas para mejorar', 'Soporte', 'soporte@example.com', 'Lamentamos la demora', 'Aceptable');
INSERT INTO pqrsrespuestas VALUES('T1006', TO_DATE('2023-10-29', 'YYYY-MM-DD'), 'Agradecemos su elogio al conductores', 'Soporte', 'soporte@example.com', 'Que disfrute', 'Excelente');
INSERT INTO pqrsrespuestas VALUES('T1007', TO_DATE('2023-10-30', 'YYYY-MM-DD'), 'Hemos tomado medidas para mejorar', 'Soporte', 'soporte@example.com', 'Que disfrute', 'Excelente');
INSERT INTO pqrsrespuestas VALUES('T1008', TO_DATE('2023-10-31', 'YYYY-MM-DD'), 'Hemos tomado medidas para mejorar', 'Soporte', 'soporte@example.com', 'Que disfrute', 'Excelente');

/*---------------------------------------------CICLO 1: PoblarNoOk (2)---------------------------------------------*/

/*-----------personas-----------*/
-- Intento de insercion sin proporcionar un valor para la columna NOT NULL "nombre".
INSERT INTO personas VALUES(6, 'C.C', 5432109876, TO_DATE('2023-10-25', 'YYYY-MM-DD'), 5432109876, 'conductores2@example.com');
-- Intento de insercion con un valor demasiado largo para la columna "tipo".
INSERT INTO personas VALUES(7, 'EsteEsUnTipoDemasiadoLargo', 1234567890, 'Persona 7', TO_DATE('2023-10-26', 'YYYY-MM-DD'), 1234567890, 'persona7@example.com');
-- Intento de insercion con un numero de celular que excede el limite definido.
INSERT INTO personas VALUES(8, 'C.C', 9876543210, 'Cliente 8', TO_DATE('2023-10-27', 'YYYY-MM-DD'), 12345678901, 'cliente8@example.com');
-- Intento de insercion con un formato de fecha incorrecto para la columna "registro".
INSERT INTO personas VALUES(9, 'C.C', 6543210987, 'conductores 9', '2023/10/28', 6543210987, 'conductores9@example.com');
-- Intento de insercion nulo en el id de la persona
INSERT INTO personas VALUES(NULL, 'C.C', 2345678901, 'Cliente 10', TO_DATE('2023-10-29', 'YYYY-MM-DD'), 2345678901, 'correo456456@example.com');

/*-----------conductores-----------*/
--Intento de insercion con un numero de licencia demasiado largo.
INSERT INTO conductores VALUES(6, 'ABC1234567890', TO_DATE('1990-01-01', 'YYYY-MM-DD'), 5, 'Activo');
--Intento de insercion con una fecha de nacimiento en un formato incorrecto.
INSERT INTO conductores VALUES(7, 'XYZ456', '1985/02/15', 4, 'Inactivo');
--Intento de insercion con un numero mayor que pla precision especificada
INSERT INTO conductores VALUES(8, 'DEF789', TO_DATE('1995-05-10', 'YYYY-MM-DD'), 10, 'Activo');
--Intento de insercion con un estado nulo
INSERT INTO conductores VALUES(9, 'GHI123', TO_DATE('1980-11-30', 'YYYY-MM-DD'), 4, NULL);
--Intento de insercion sin valor en el ID
INSERT INTO conductores VALUES('JKL456', TO_DATE('1978-09-20', 'YYYY-MM-DD'), 5, 'Activo');

/*-----------clientes-----------*/
--Intento de insercion de un clientes sin proporcionar un valor para "idioma".
INSERT INTO clientes VALUES(6, NULL);
--Intento de insercion con un valor de "idioma" que excede el limite de caracteres.
INSERT INTO clientes VALUES(7, 'EsteIdiomaEsDemasiadoLargo');
--Intento de insercion sin el ID de clientes
INSERT INTO clientes VALUES('Ingles');

/*-----------vehiculos-----------*/
--Intento de insercion sin proporcionar un valor para la columna NOT NULL "estado".
INSERT INTO vehiculos VALUES(6, 'ABCXYZ', '2020', 'C', 4, 4, 1);
--Intento de insercion con un tipo de vehiculo no valido.
INSERT INTO vehiculos VALUES(7, 'XYZ123', '2020', 'XR', 'En Reparacion', 2, 2, 0);
--Intento de insercion con un valor muy alto para la columna "puertas".
INSERT INTO vehiculos VALUES(8, 'DEF456', '2022', 'C', 'Disponible', 10, 4, 1);
--Intento de insercion con un valor que excede el limite en la columna "placa".
INSERT INTO vehiculos VALUES(9, 'GHI123456', '2021', 'M', 'En Mantenimiento', 2, 2, 0);
--Intento de insercion sin un valor nulo en la placa
INSERT INTO vehiculos VALUES(10, NULL, '2018', 'C', 'Disponible', 4, 4, 1);

/*-----------tarjetasClientes-----------*/
-- Intento de insercion de una tarjetas sin proporcionar un valor para la columna NOT NULL "numero".
INSERT INTO tarjetasClientes VALUES(4);
-- Intento de insercion de una tarjetas con numero no valido.
INSERT INTO tarjetasClientes VALUES(5, 1234567890123457);
-- Intento de insercion de una tarjeta sin el ID del cliente
INSERT INTO tarjetasClientes VALUES(987654321098765);
-- Intento de insercion de una tarjetas con un numero nulo (violacion de restriccion NOT NULL).
INSERT INTO tarjetasClientes VALUES(6, NULL);

/*-----------tarjetas-----------*/
--Intento de insercion de una tarjetas de credito con un numero no valido.
INSERT INTO tarjetas VALUES(1234567890123457, 'Banco ABC', TO_DATE('2025-12-31', 'YYYY-MM-DD'));
--Intento de insercion sin proporcionar un valor para la columna NOT NULL "entidad".
INSERT INTO tarjetas VALUES(98765432109875, TO_DATE('2024-11-30', 'YYYY-MM-DD'));
--Intento de insercion con una fecha de vencimiento no valida.
INSERT INTO tarjetas VALUES(567890123456789, 'Banco DEF', '2021/05/10');
--Intento de insercion con un valor nulo en el numero de la tarjeta
INSERT INTO tarjetas VALUES(NULL, 'Banco GHI', TO_DATE('2025-06-30', 'YYYY-MM-DD'));
--Intento de insercion con una entidad nula
INSERT INTO tarjetas VALUES(123456789012346, NULL, TO_DATE('2025-12-31', 'YYYY-MM-DD'));

/*-----------solicitudes-----------*/
-- Intento de insercion con una fecha de viaje no valida
INSERT INTO solicitudes VALUES(6, 54321, TO_DATE('2023-10-20', 'YYYY-MM-DD'), '2023-10-19', 'A', 20.0, 'Pendiente', 12, 67);
-- Intento de insercion con una plataforma no valida 
INSERT INTO solicitudes VALUES(7, 54322, TO_DATE('2023-10-21', 'YYYY-MM-DD'), TO_DATE('2023-10-22', 'YYYY-MM-DD'), 'XI', 25.0, 'Pendiente', 1, 2);
-- Intento de insercion con un precio nulo.
INSERT INTO solicitudes VALUES(8, 54323, TO_DATE('2023-10-22', 'YYYY-MM-DD'), TO_DATE('2023-10-23', 'YYYY-MM-DD'), 'A', NULL, 'Pendiente', 1, 2);
-- Intento de insercion con un estado que supere el numero de caracteres
INSERT INTO solicitudes VALUES(9, 54324, TO_DATE('2023-10-23', 'YYYY-MM-DD'), TO_DATE('2023-10-24', 'YYYY-MM-DD'), 'A', 30.0, 'Invalido123456', 1, 2);
-- Intento de insercion sin ubicaciones iniciales y finales
INSERT INTO solicitudes VALUES(10, 54325, TO_DATE('2023-10-24', 'YYYY-MM-DD'), TO_DATE('2023-10-25', 'YYYY-MM-DD'), 'I', 40.0, 'Pendiente');

/*-----------requerimientos-----------*/
-- Intento de insercion sin proporcionar un valor para la columna NOT NULL "info".
INSERT INTO requerimientos VALUES(11);
-- Intento Intento de insercion con una "info" demasiado larga.
INSERT INTO requerimientos VALUES('EsteEsUnIdRedDemasiadoLargo12345648789412315456789745612315648978', 2);
-- Intento de insercion con un "idSolicitud" demasiado largo
INSERT INTO requerimientos VALUES('DEF456', 1005236974);
-- Intento de insercion con valores nulos.
INSERT INTO requerimientos VALUES(NULL, NULL);
-- Intento de insercion con una "idSolicitud" nula (violacion de restriccion NOT NULL).
INSERT INTO requerimientos VALUES('ABC123', NULL);

/*-----------posiciones-----------*/
-- Intento de insercion con una latitud como string.
INSERT INTO posiciones VALUES(21, '-40.7128', 74.0060);
-- Intento de insercion de una posicion con latitud nula.
INSERT INTO posiciones VALUES(22, -74.0060);
-- Intento de insercion sin proporcionar un valor para la columna NOT NULL "id".
INSERT INTO posiciones VALUES(40.7128, -74.0060);
-- Intento de insercion de una posicion sin lalitud y longitud
INSERT INTO posiciones VALUES(23);
-- Intento de insercion con valores no numericos en las columnas "latitud" y "longitud".
INSERT INTO posiciones VALUES(24, 'Cuarenta', 'Setenta y cuatro');

/*-----------pqrs-----------*/
--Intento de insercion de una PQRS sin proporcionar un valor para la columna NOT NULL "descripcion".
INSERT INTO pqrs VALUES('PQRS-006', 6, TO_DATE('2023-10-30', 'YYYY-MM-DD'), TO_DATE('2023-11-01', 'YYYY-MM-DD'), 'Abierto', 'Ninguno');
--: Intento de insercion con un "tipo" que no es valido.
INSERT INTO pqrs VALUES('PQRS-007', 7, TO_DATE('2023-11-02', 'YYYY-MM-DD'), TO_DATE('2023-11-04', 'YYYY-MM-DD'), 'Descripcion1', 'TipoInvalidoMuyLargo', 'Abierto');
--: Intento de insercion con un "estado" demasiado largo.
INSERT INTO pqrs VALUES('PQRS-008', 8, TO_DATE('2023-11-05', 'YYYY-MM-DD'), TO_DATE('2023-11-07', 'YYYY-MM-DD'), 'Descripcion2','Reclamo', 'EsteEstadoEsDemasiadoLargo');
--: Intento de insercion con un "ticked" nulo
INSERT INTO pqrs VALUES(NULL, 9, TO_DATE('2023-11-08', 'YYYY-MM-DD'), TO_DATE('2023-11-10', 'YYYY-MM-DD'), 'Descripcion3','Queja', 'Abierto');
--: Intento de insercion con una fecha de radicacion no valida".
INSERT INTO pqrs VALUES('PQRS-009', 100, '2023-11-11', TO_DATE('2023-11-13', 'YYYY-MM-DD'), 'Descripcion4', 'Sugerencia', 'Abierto');

/*-----------anexos-----------*/
--Intento de insercion sin proporcionar un valor para la columna NOT NULL "url".
INSERT INTO anexos VALUES(25, 'PQRS-006', 'Anexo 1');
--Intento de insercion con una URL que excede el limite de caracteres.
INSERT INTO anexos VALUES(26, 'PQRS-007', 'Anexo 2', 'https://www.estaesunaurlmuylarga.com/queexcedeellimitedelacolumna/url');
--Intento de insercion con un "ticked" nulo.
INSERT INTO anexos VALUES(15, NULL, 'Anexo 3', 'https://www.ejemplo.com/anexo3.pdf');
--Intento de insercion de un anexos con un nombre muy largo.
INSERT INTO anexos VALUES(28, 'PQRS-009', 'Este nombre es muy largo', 'https://www.ejemplo.com/anexo4.pdf');
--Intento de insercion con un "id" nulo (violacion de restriccion NOT NULL).
INSERT INTO anexos VALUES('PQRS-006', 'Anexo 5', 'https://www.ejemplo.com/anexo5.pdf');


/*---------------------------------------------CICLO 1: PoblarNoOk (3)---------------------------------------------*/

/*-----------solicitudes-----------*/
--Insercion de dos personas con el mismo ID, la protege pk_personas_id
INSERT INTO personas VALUES(1, 'Cliente', '1234567890', 'Cliente 1', TO_DATE('2023-10-23', 'YYYY-MM-DD'), 1234567890, 'cliente1@example.com');
INSERT INTO personas VALUES(1, 'Conductor', '0987654321', 'Conductor 1', TO_DATE('1990-01-01', 'YYYY-MM-DD'), 9876543210, 'conductor1@example.com');

/*-----------conductores-----------*/
--Insercion de dos conductores con la misma licencia, la protege pk_conductores_idConductor
INSERT INTO conductores VALUES(1, 'A123456789', TO_DATE('1990-01-01', 'YYYY-MM-DD'), 5, 'Activo');
INSERT INTO conductores VALUES(2, 'A123456789', TO_DATE('1985-06-15', 'YYYY-MM-DD'), 4, 'Inactivo');

/*-----------clientes-----------*/
--Insercion de dos clientes con el mismo ID, la protege pk_clientes_idCliente
INSERT INTO clientes VALUES(1, 'Espaniol');
INSERT INTO clientes VALUES(1, 'Ingles');

/*-----------vehiculos-----------*/
--Insercion de dos vehiculos con la misma placa la protege pk_vehiculos_placa
INSERT INTO vehiculos VALUES(1, 'ABC123', '2020', 'A', 'Disponible', 4, 4, 0);
INSERT INTO vehiculos VALUES(2, 'ABC123', '2019', 'B', 'Reparando', 2, 2, 1);

/*-----------tarjetasClientes-----------*/
--Insercion de dos registros con el mismo numero de tarjeta para el mismo cliente,la protege pk_tarjetasClientes_idCliente_numeroT
INSERT INTO tarjetasClientes VALUES(1, 123456789012345);
INSERT INTO tarjetasClientes VALUES(1, 123456789012345);

/*-----------tarjetas-----------*/
--Insercion de una tarjeta con un numero ya existente, la protege pk_tarjetas_numero
INSERT INTO tarjetas VALUES(123456789012345, 'Banco A', TO_DATE('2024-12-31', 'YYYY-MM-DD'));


/*-----------solicitudes-----------*/
--Insercion de una solicitud con el mismo codigo para el mismo cliente, la protege pk_solicitud_codigo
INSERT INTO solicitudes VALUES(1, 1001, TO_DATE('2023-10-23', 'YYYY-MM-DD'), TO_DATE('2023-10-24', 'YYYY-MM-DD'), 'A', 30.0, 'Pendiente', 12345678901, 98765432109);
INSERT INTO solicitudes VALUES(1, 1001, TO_DATE('2023-10-25', 'YYYY-MM-DD'), TO_DATE('2023-10-26', 'YYYY-MM-DD'), 'B', 35.0, 'Aprobada', 12345678902, 98765432108);

/*-----------requerimientos-----------*/
--Insercion de un requerimiento que no esta asociado a una solicitud, la protege fk_requerimientos_idSolicitud
INSERT INTO requerimientos VALUES('Informacion', 58);

/*-----------posiciones-----------*/
--Insercion de dos registrios con la misma ubicacion, la protege pk_posiciones_ubicacion
INSERT INTO posiciones VALUES(12345678901, 34.0522, -118.2437);
INSERT INTO posiciones VALUES(12345678901, 34.0522, -118.2437);

/*-----------anexos-----------*/
--Insercion de dos anexos con el mismo ID de anexo, la protege pk_anexos_idAnexo
INSERT INTO anexos VALUES(1, 'TICKET1', 'Anexo1', 'http://example.com/anexo1.pdf');
INSERT INTO anexos VALUES(1, 'TICKET2', 'Anexo2', 'http://example.com/anexo2.pdf');

/*-----------pqrsrespuestas-----------*/
--Insercion de una respuesta sin un ticket asociado, la protege fk_pqrsrespuestas_codigoSolicitud
INSERT INTO pqrsrespuestas VALUES('TICKET1', TO_DATE('2023-10-25', 'YYYY-MM-DD'), 'Respuesta al problema', 'Nombre Usuario', 'usuario@example.com', 'Comentario', 'Buena');

/*---------------------------------------------CICLO 1: XPoblar---------------------------------------------*/
TRUNCATE TABLE personas;
TRUNCATE TABLE conductores;
TRUNCATE TABLE clientes;
TRUNCATE TABLE vehiculos;
TRUNCATE TABLE tarjetasClientes;
TRUNCATE TABLE tarjetas;
TRUNCATE TABLE solicitudes;
TRUNCATE TABLE requerimientos;
TRUNCATE TABLE posiciones;
TRUNCATE TABLE pqrs;
TRUNCATE TABLE anexos;
TRUNCATE TABLE pqrsrespuestas;

/*---------------------------------------------CICLO 1: Atributos---------------------------------------------*/

/*------------Restricciones CHECK para la tabla personas------------*/
/* Verifica que el atributo 'correo' cumple con un patron especifico de direccion de correo electronico */
ALTER TABLE personas ADD CONSTRAINT chk_personas_correo CHECK (REGEXP_LIKE(correo, '.*@.*'));
/* Verifica que el atributo 'tipo' contenga uno de los tipos de documentos especificados */
ALTER TABLE personas ADD CONSTRAINT chk_personas_tipo_documento CHECK (tipo IN ('CC', 'TI', 'RC', 'CE', 'CI', 'DNI'));


/*------------Restricciones CHECK para la tabla vehiculos------------*/
/* Verifica que el atributo 'a_o' sea un anio de 4 digitos entre 1900 y 2100 */
ALTER TABLE vehiculos ADD CONSTRAINT chk_vehiculos_a_o CHECK (LENGTH(a_o) = 4 AND TO_NUMBER(a_o) BETWEEN 1900 AND 2100);
/* Verifica que el atributo 'tipo' contenga uno de los tipos de vehiculos especificados ('M'(Moto), 'C'(Camioneta), 'c'(Carro)) */
ALTER TABLE vehiculos ADD CONSTRAINT chk_vehiculos_tipo CHECK (tipo IN ('M', 'C', 'c'));
/* Verifica que el atributo 'estado' contenga uno de los estados especificados ('Activo', 'Pendiente') */
ALTER TABLE vehiculos ADD CONSTRAINT chk_vehiculos_estado CHECK (estado IN ('Activo', 'Pendiente'));
/* Verifica que el atributo 'puertas' este en el rango de 0 a 4 */
ALTER TABLE vehiculos ADD CONSTRAINT chk_vehiculos_puertas CHECK (puertas >= 0 AND puertas <= 4); 
/* Verifica que el atributo 'pasajeros' sea igual o mayor que 0 */
ALTER TABLE vehiculos ADD CONSTRAINT chk_vehiculos_pasajeros CHECK (pasajeros >= 0);
/* Verifica que el atributo 'carga' cumpla con reglas especificas dependiendo del tipo de vehiculo:
   - Si el tipo no es 'c', entonces 'carga' debe ser NULL.
   - Si el tipo es 'C', entonces 'carga' no debe ser NULL y debe ser igual o mayor que 0. */
ALTER TABLE vehiculos ADD CONSTRAINT chk_vehiculos_carga CHECK ((tipo != 'c' AND carga IS NULL) OR (tipo = 'C' AND carga IS NOT NULL AND carga >= 0));


/*------------Restriccion CHECK para la tabla conductores------------*/
/* Verifica que el atributo 'estrellas' este en el rango de 1 a 5, lo que indica la calificacion de estrellas para los conductores. */
ALTER TABLE conductores ADD CONSTRAINT chk_conductores_estrellas CHECK (estrellas >= 1 AND estrellas <= 5);
/*Verifica que el estado del conductor sea Activo, Inactivo, Retirado u Ocupado */
ALTER TABLE conductores ADD CONSTRAINT chk_conductores_estado CHECK (estado IN ('Activo', 'Inactivo', 'Retirado', 'Ocupado'));


/*------------Restriccion CHECK para la tabla anexos------------*/
ALTER TABLE anexos ADD CONSTRAINT chk_anexos_url CHECK (SUBSTR(url, 1, 8) = 'https://');
ALTER TABLE anexos ADD CONSTRAINT chk__anexos_nombre CHECK (REGEXP_LIKE(nombre, 'Peticion|Queja|Reclamo|Sugerencia'));


/*------------Restriccion CHECK para la tabla pqrsrespuestas------------*/
/* Verifica que el atributo evaluacion se encuentre entre 1 y 5 */
ALTER TABLE pqrsrespuestas ADD CONSTRAINT chk_pqrsrespuestas_evaluacion CHECK (evaluacion BETWEEN 1 AND 5);
/* Verifica que el atributo 'correo' cumple con un patron especifico de direccion de correo electronico */
ALTER TABLE personas ADD CONSTRAINT chk_pqrsrespuestas_correo CHECK (REGEXP_LIKE(correo, '.*@.*'));


/*------------Restricciones CHECK para la tabla solicitudes------------*/
/* Verifica que el atributo 'plataforma' contenga uno de los valores permitidos ('W' o 'A'), que probablemente representen diferentes plataformas de origen. */
ALTER TABLE solicitudes ADD CONSTRAINT chk_solicitudes_plataforma CHECK (plataforma IN ('W', 'A'));
/* Verifica que el atributo 'estado' contenga uno de los valores permitidos ('Pendiente' o 'Asignada', 'Cancelada'), que indican el estado de la solicitud. */
ALTER TABLE solicitudes ADD CONSTRAINT chk_solicitudes_estado CHECK (estado IN ('Pendiente', 'Asignada', 'Cancelada'));


/*------------Restricciones CHECK para la tabla clientes------------*/
/* Verifica que el atributo 'idioma' contenga uno de los idiomas permitidos ('Espaniol', 'Ingles', 'Frances', 'Aleman', 'Italiano', 'Portugues', 'Chino', 'Japones', 'Ruso', 'Arabe', 'Otros'). Esto asegura que el idioma registrado este dentro de la lista de opciones validas. */
ALTER TABLE clientes ADD CONSTRAINT chk_clientes_idioma CHECK (idioma IN ('Espaniol', 'Ingles', 'Frances', 'Aleman', 'Italiano', 'Portugues', 'Chino', 'Japones', 'Ruso', 'Arabe', 'Otros'));


/*------------Restricciones CHECK para la tabla pqrs------------*/
/*   */
//descripcion 
/* Verifica que el atributo 'ticked' siga un patron especifico que empiece con 'PQRS' seguido de 12 digitos. Esto suele ser un numero de seguimiento o identificador unico. */
ALTER TABLE pqrs ADD CONSTRAINT chk_pqrs_ticked CHECK (REGEXP_LIKE(ticked, '^[PQRS][0-9]{12}$'));
/* Verifica que el atributo 'tipo' contenga uno de los valores permitidos ('P', 'Q', 'R', 'S'), que representan el tipo de PQRS (Peticiones, Quejas, Reclamos o Sugerencias). */
ALTER TABLE pqrs ADD CONSTRAINT chk_pqrs_tipo CHECK (tipo IN ('P', 'Q', 'R', 'S'));
/* Verifica que el atributo 'estado' contenga uno de los valores permitidos ('Abierto', 'Cerrado', 'Rechazado'), que reflejan el estado actual del PQRS. */
ALTER TABLE pqrs ADD CONSTRAINT chk_pqrs_estado CHECK (estado IN ('Abierto', 'Cerrado', 'Rechazado'));


/*------------Restriccion CHECK para la tabla tarjetas------------*/
/* Verifica que el atributo 'entidad' contenga una de las entidades permitidas ('Visa', 'Mastercard', 'American'). Esto asegura que la tarjeta este asociada a una de las principales redes de tarjetas de credito. */
ALTER TABLE tarjetas ADD CONSTRAINT chk_tarjetas_entidad CHECK (entidad IN ('Visa', 'Mastercard', 'American'));

/*------------Restriccion CHECK para la tabla tarjetas------------*/
/* Verifica que el atributo 'nombre' contenga la palabra Peticion, Queja, Reclamo o Sugerencia*/
ALTER TABLE anexos ADD CONSTRAINT chk__anexos_nombre CHECK (REGEXP_LIKE(nombre, 'Peticion|Queja|Reclamo|Sugerencia'));

/*---------------------------------------------CICLO 1: Primarias--------------------------------------------*/
ALTER TABLE personas ADD CONSTRAINT pk_personas_id PRIMARY KEY (id);
ALTER TABLE vehiculos ADD CONSTRAINT pk_vehiculos_placa PRIMARY KEY(placa);
ALTER TABLE conductores ADD CONSTRAINT pk_conductores_idConductor PRIMARY KEY(idConductor);
ALTER TABLE tarjetas ADD CONSTRAINT pk_tarjetas_numero PRIMARY KEY(numero);
ALTER TABLE tarjetasClientes ADD CONSTRAINT pk_tarjetasClientes_idCliente_numeroT PRIMARY KEY(idCliente, numeroT);
ALTER TABLE posiciones ADD CONSTRAINT pk_posiciones_ubicacion PRIMARY KEY(ubicacion);
ALTER TABLE anexos ADD CONSTRAINT pk_anexos_idAnexo PRIMARY KEY(idAnexo);
ALTER TABLE pqrsrespuestas ADD CONSTRAINT pk_pqrsrespuestas_idTicked PRIMARY KEY(idTicked);
ALTER TABLE pqrs ADD CONSTRAINT pk_pqrs_ticked PRIMARY KEY(ticked);
ALTER TABLE requerimientos ADD CONSTRAINT pk_requerimientos_idSolicitud PRIMARY KEY(idSolicitud);
ALTER TABLE solicitudes ADD CONSTRAINT pk_solicitudes_codigo PRIMARY KEY(codigo);
ALTER TABLE clientes ADD CONSTRAINT pk_clientes_idCliente PRIMARY KEY(idCliente);

/*---------------------------------------------CICLO 1: Unicas--------------------------------------------*/
ALTER TABLE personas ADD CONSTRAINT uk_personas_tipo_numero UNIQUE (tipo, numero);
ALTER TABLE personas DROP CONSTRAINT uk_personas_tipo_numero;
ALTER TABLE anexos ADD CONSTRAINT uk_anexos_url UNIQUE (url);

/*---------------------------------------------CICLO 1: Foraneas---------------------------------------------*/
ALTER TABLE vehiculos ADD CONSTRAINT fk_vehiculos_idConductor FOREIGN KEY(idConductor) REFERENCES conductores(idConductor);
ALTER TABLE conductores ADD CONSTRAINT fk_conductores_idConduct FOREIGN KEY(idConductor) REFERENCES personas(id);
ALTER TABLE tarjetasClientes ADD CONSTRAINT fk_tarjetasClientes_idCliente FOREIGN KEY(idCliente) REFERENCES clientes(idCliente);
ALTER TABLE tarjetasClientes ADD CONSTRAINT fk_tarjetasClientes_numeroT FOREIGN KEY(numeroT) REFERENCES tarjetas(numero);
ALTER TABLE anexos ADD CONSTRAINT fk_anexos_idTicked FOREIGN KEY(idTicked) REFERENCES pqrs(ticked);
ALTER TABLE pqrsrespuestas ADD CONSTRAINT fk_pqrsrespuestas FOREIGN KEY (idTicked) REFERENCES pqrs(ticked);
ALTER TABLE pqrs ADD CONSTRAINT fk_pqrs_codigoSolicitud FOREIGN KEY (codigoSolicitud) REFERENCES solicitudes(codigo);
ALTER TABLE requerimientos ADD CONSTRAINT fk_requerimientos_idSolicitud FOREIGN KEY (idSolicitud) REFERENCES solicitudes(codigo);
ALTER TABLE solicitudes ADD CONSTRAINT fk_solicitudes_idCliente FOREIGN KEY (idCliente) REFERENCES clientes(idCliente);
ALTER TABLE solicitudes ADD CONSTRAINT fk_solicitudes_ubicacionInicial FOREIGN KEY (ubicacionInicial) REFERENCES posiciones(ubicacion);
ALTER TABLE solicitudes ADD CONSTRAINT fk_solicitudes_ubicacionFinal FOREIGN KEY (ubicacionFinal) REFERENCES posiciones(ubicacion);
ALTER TABLE clientes ADD CONSTRAINT fk_clientes_idCliente FOREIGN KEY(idCliente) REFERENCES personas(id);

/*---------------------------------------------CICLO 1: PoblarNoOk (2)---------------------------------------------*/
/*-----------clientes-----------*/
-- Intentar insertar un valor de idioma que no esta en la lista de idiomas conocidos
INSERT INTO clientes VALUES (1, 'Sueco');

/*-----------tarjetas-----------*/
-- Intentar insertar una tarjeta con una entidad que no esta en la lista permitida
INSERT INTO tarjetas VALUES (1234567890123456, 'Discover', TO_DATE('2023-12-31', 'YYYY-MM-DD'));

/*---------------------------------------------CICLO 1: PoblarNoOk (4)---------------------------------------------*/
/*-----------personas-----------*/
-- La restriccion CHECK 'chk_personas_correo' protege esta insercio n
INSERT INTO personas VALUES (1, 'Cliente', '123456789', 'Juan Perez', '2023-10-23', 'juan.perez@example.com');

/*-----------conductores-----------*/
-- La restriccion CHECK 'chk_conductores_estrellas' protege esta insercion
INSERT INTO conductores VALUES (1, 'ABC123', '1990-01-01', 6, 'Activo');

/*-----------vehiculos-----------*/
-- La restriccion CHECK 'chk_vehiculos_a_o' protege esta insercion
INSERT INTO vehiculos VALUES (1, 'XYZ123', '99', 'M', 'Activo', 4, 5, NULL);

/*-----------solicitudes-----------*/
-- La restriccion CHECK 'chk_solicitudes_plataforma' protege esta insercion
INSERT INTO solicitudes VALUES (1, 101, '2023-10-23', NULL, 'X', 20.5, 'Pendiente', 1, 2);

/*-----------tarjetas-----------*/
-- La restriccion CHECK 'chk_tarjetas_entidad' protege esta insercion
INSERT INTO tarjetas VALUES (1234567890123456, 'Discover', '2024-12-31');

/*---------------------------------------------CICLO 1 <Consultar viajes con requerimientos de musica>---------------------------------------------*/
/* 
Seleccionamos la tablas solicitudes con los atributos codigo, requerimientos con atributos idSolicitud 
la tabla clientes con el atributo idCliente
la tabla personas con el atributo id
para despeus hacer una seleccion de join y depeus ordenarlo por la fecha de creacion
*/
SELECT s.codigo AS codigo_solicitud, p.nombre AS nombre_cliente, s.fechaCreacion AS fecha_solicitud
FROM solicitudes s
JOIN requerimientos r ON s.codigo = r.idSolicitud
JOIN clientes c ON s.idCliente = c.idCliente
JOIN personas p ON c.idCliente = p.id
WHERE r.info LIKE '%musica%'
ORDER BY s.fechaCreacion;

/*---------------------------------------------CICLO 1 <Consultar clientes con mayores montos acumulados en solicitudes>---------------------------------------------*/
SELECT c.idCliente, p.nombre AS nombre_cliente, SUM(s.precio) AS monto_acumulado
FROM clientes c
JOIN solicitudes s ON c.idCliente = s.idCliente
JOIN personas p ON c.idCliente = p.id
GROUP BY c.idCliente, p.nombre
ORDER BY monto_acumulado DESC;

/*---------------------------------------------CICLO 1 <Consultar conductores con mas de 4 estrellas>---------------------------------------------*/

SELECT personas.nombre, conductores.licencia, conductores.fechaNacimiento, conductores.estrellas, conductores.estado
FROM conductores
JOIN personas ON personas.id = conductores.idConductor
WHERE conductores.estrellas >= 4;

/*---------------------------------------------CICLO 1: PoblarOk---------------------------------------------*/
INSERT INTO personas VALUES(1, 'CC',1234567897 , 'Juan Perez', TO_DATE('2023-05-10', 'YYYY-MM-DD'), 1234567890, 'juan@gmail.com');
INSERT INTO personas VALUES(2, 'CC', 9875412345, 'Maria Rodriguez', TO_DATE('2023-06-15', 'YYYY-MM-DD'), 9876543210, 'maria@hotmail.com');
INSERT INTO personas VALUES(3, 'DNI', 5823456987, 'Carlos Sanchez', TO_DATE('1990-03-20', 'YYYY-MM-DD'), 5555555555, 'carlos@gmail.com');
INSERT INTO personas VALUES(4, 'CE', 1000536987, 'Luisa Martinez', TO_DATE('1985-11-28', 'YYYY-MM-DD'), 6666666666, 'luisa@hotmail.com');
INSERT INTO personas VALUES(5, 'TI', 52983610, 'Pedro Lopez', TO_DATE('2023-07-20', 'YYYY-MM-DD'), 7777777777, 'pedro@gmail.com');

INSERT INTO conductores VALUES(1, 'L12345', TO_DATE('1990-03-20', 'YYYY-MM-DD'), 4, 'Activo');
INSERT INTO conductores VALUES(2, 'L54321', TO_DATE('1985-11-28', 'YYYY-MM-DD'), 5, 'Activo');
INSERT INTO conductores VALUES(3, 'L98765', TO_DATE('1995-08-15', 'YYYY-MM-DD'), 3, 'Activo');
INSERT INTO conductores VALUES(4, 'L56789', TO_DATE('1988-06-02', 'YYYY-MM-DD'), 4, 'Ocupado');
INSERT INTO conductores VALUES(5, 'L23456', TO_DATE('1992-12-10', 'YYYY-MM-DD'), 3, 'Activo');

INSERT INTO vehiculos VALUES(1, 'ABC123', '2020', 'M', 'Activo', 0, 1, NULL);
INSERT INTO vehiculos VALUES(2, 'XYZ987', '2018', 'C', 'Activo', 2, 2, 300);
INSERT INTO vehiculos VALUES(3, 'DEF456', '2019', 'M', 'Pendiente', 4, 4, NULL);
INSERT INTO vehiculos VALUES(4, 'GHI789', '2021', 'M', 'Activo', 0, 1, NULL);
INSERT INTO vehiculos VALUES(5, 'JKL321', '2017', 'C', 'Activo', 4, 4, 400);

INSERT INTO clientes VALUES(1, 'Espaniol');
INSERT INTO clientes VALUES(2, 'Ingles');
INSERT INTO clientes VALUES(3, 'Frances');
INSERT INTO clientes VALUES(4, 'Aleman');
INSERT INTO clientes VALUES(5, 'Italiano');

INSERT INTO tarjetas VALUES(123456789012345, 'Visa', TO_DATE('2025-12-31', 'YYYY-MM-DD'));
INSERT INTO tarjetas VALUES(987654321098765, 'Mastercard', TO_DATE('2024-09-30', 'YYYY-MM-DD'));
INSERT INTO tarjetas VALUES(111122223333444, 'American', TO_DATE('2023-11-30', 'YYYY-MM-DD'));
INSERT INTO tarjetas VALUES(555566667777888, 'Visa', TO_DATE('2024-08-31', 'YYYY-MM-DD'));
INSERT INTO tarjetas VALUES(999988887777666, 'Mastercard', TO_DATE('2025-10-31', 'YYYY-MM-DD'));

INSERT INTO tarjetasClientes VALUES(1, 123456789012345);
INSERT INTO tarjetasClientes VALUES(2, 987654321098765);
INSERT INTO tarjetasClientes VALUES(3, 111122223333444);
INSERT INTO tarjetasClientes VALUES(4, 555566667777888);
INSERT INTO tarjetasClientes VALUES(5, 999988887777666);

INSERT INTO posiciones VALUES(1, 40.7128, -74.0060);
INSERT INTO posiciones VALUES(2, 34.0522, -118.2437);
INSERT INTO posiciones VALUES(3, 51.5074, -0.1278);
INSERT INTO posiciones VALUES(4, 52.5200, 13.4050);
INSERT INTO posiciones VALUES(5, 41.8919, 12.5113);

INSERT INTO solicitudes VALUES(1, 1001, TO_DATE('2023-08-01', 'YYYY-MM-DD'), TO_DATE('2023-08-10', 'YYYY-MM-DD'), 'W', 50.00, 'Aceptado', 1, 2);
INSERT INTO solicitudes VALUES(2, 1002, TO_DATE('2023-08-02', 'YYYY-MM-DD'), TO_DATE('2023-08-12', 'YYYY-MM-DD'), 'A', 40.00, 'Pendiente', 2, 3);
INSERT INTO solicitudes VALUES(3, 1003, TO_DATE('2023-08-03', 'YYYY-MM-DD'), NULL, 'W', 35.00, 'Pendiente', 3, 4);
INSERT INTO solicitudes VALUES(4, 1004, TO_DATE('2023-08-04', 'YYYY-MM-DD'), TO_DATE('2023-08-15', 'YYYY-MM-DD'), 'A', 60.00, 'Aceptado', 4, 5);
INSERT INTO solicitudes VALUES(5, 1005, TO_DATE('2023-08-05', 'YYYY-MM-DD'), TO_DATE('2023-08-14', 'YYYY-MM-DD'), 'W', 45.00, 'Aceptado', 5, 1);

INSERT INTO requerimientos VALUES('Musica con ritmo latino', 1001);
INSERT INTO requerimientos VALUES('Asientos comodos', 1002);
INSERT INTO requerimientos VALUES('Musica rock', 1003);
INSERT INTO requerimientos VALUES('Climatizacion', 1004);
INSERT INTO requerimientos VALUES('Conductor amigable', 1005);

INSERT INTO pqrs VALUES('P202310000001', 1001, TO_DATE('2023-10-01', 'YYYY-MM-DD'), TO_DATE('2023-10-10', 'YYYY-MM-DD'), 'Problema de pago', 'P', 'Cerrado');
INSERT INTO pqrs VALUES('P202310000002', 1002, TO_DATE('2023-10-02', 'YYYY-MM-DD'), NULL, 'Conductor poco amigable', 'P', 'Abierto');
INSERT INTO pqrs VALUES('Q202310000003', 1003, TO_DATE('2023-10-03', 'YYYY-MM-DD'), NULL, 'M sica muy alta', 'Q', 'Abierto');
INSERT INTO pqrs VALUES('P202310000004', 1004, TO_DATE('2023-10-04', 'YYYY-MM-DD'), NULL, 'Conductor grosero', 'P', 'Abierto');
INSERT INTO pqrs VALUES('Q202310000005', 1005, TO_DATE('2023-10-05', 'YYYY-MM-DD'), TO_DATE('2023-10-15', 'YYYY-MM-DD'), 'Demora en la recogida', 'Q', 'Cerrado');

INSERT INTO anexos VALUES(1001, 'P202310000001', 'Captura de pantalla', 'https://example.com/captura.png');
INSERT INTO anexos VALUES(1002, 'P202310000002', 'Audio grabado', 'https://example.com/audio.mp3');
INSERT INTO anexos VALUES(1003, 'Q202310000003', 'Fotos del vehiculo', 'https://example.com/fotos.zip');
INSERT INTO anexos VALUES(1004, 'P202310000004', 'Conversacion chat', 'https://example.com/chat.pdf');
INSERT INTO anexos VALUES(1005, 'Q202310000005', 'Video de incidente', 'https://example.com/video.mp4');

INSERT INTO pqrsrespuestas VALUES('P202310000001', TO_DATE('2023-10-05', 'YYYY-MM-DD'), 'Problema resuelto', 'Soporte', 'soporte@gmail.com', NULL, 5);
INSERT INTO pqrsrespuestas VALUES('P202310000002', TO_DATE('2023-10-07', 'YYYY-MM-DD'), 'Gracias por su feedback', 'Atencion al cliente', 'atencion@outlook.com', 'Estamos trabajando', 4);
INSERT INTO pqrsrespuestas VALUES('Q202310000003', TO_DATE('2023-10-06', 'YYYY-MM-DD'), 'Investigando el incidente', 'Soporte', 'soporte@gmail.com', NULL, NULL);
INSERT INTO pqrsrespuestas VALUES('P202310000004', TO_DATE('2023-10-06', 'YYYY-MM-DD'), 'Entendemos su preocupacion', 'Soporte', 'soporte@gmail.com', 'Estamos trabajando', 3);
INSERT INTO pqrsrespuestas VALUES('Q202310000005', TO_DATE('2023-10-08', 'YYYY-MM-DD'), 'Resoluci n completa', 'Soporte', 'soporte@gmail.com', NULL, 5);


/*----------CICLO 1: CRUD: solicitudes----------*/

/*---Atributos---*/
/*---Tuplas---*/
/*---TuplasOk---*/
/*---Acciones---*/

--Eliminar Las relaciones de la tabla Solicitudes

ALTER TABLE solicitudes DROP CONSTRAINT fk_solicitudes_idCliente;
ALTER TABLE solicitudes ADD CONSTRAINT fk_solicitudes_idCliente FOREIGN KEY (idCliente) REFERENCES clientes(idCliente) ON DELETE CASCADE;


/*---AccionesOk---*/
INSERT INTO personas VALUES(1, 'CC',1234567897 , 'Juan Perez', TO_DATE('2023-05-10', 'YYYY-MM-DD'), 1234567890, 'juan@gmail.com');
INSERT INTO personas VALUES(2, 'CC', 9875412345, 'Maria Rodriguez', TO_DATE('2023-06-15', 'YYYY-MM-DD'), 9876543210, 'maria@hotmail.com');
INSERT INTO personas VALUES(3, 'DNI', 5823456987, 'Carlos Sanchez', TO_DATE('1990-03-20', 'YYYY-MM-DD'), 5555555555, 'carlos@gmail.com');

INSERT INTO clientes VALUES(1, 'Espaniol');
INSERT INTO clientes VALUES(2, 'Ingles');
INSERT INTO clientes VALUES(3, 'Frances');

INSERT INTO posiciones VALUES(1, 40.7128, -74.0060);
INSERT INTO posiciones VALUES(2, 34.0522, -118.2437);
INSERT INTO posiciones VALUES(3, 51.5074, -0.1278);

INSERT INTO solicitudes VALUES(1, 1001, TO_DATE('2023-08-01', 'YYYY-MM-DD'), TO_DATE('2023-08-10', 'YYYY-MM-DD'), 'W', 50.00, 'Asignada', 1, 2);
INSERT INTO solicitudes VALUES(2, 1002, TO_DATE('2023-08-02', 'YYYY-MM-DD'), TO_DATE('2023-08-12', 'YYYY-MM-DD'), 'A', 40.00, 'Pendiente', 2, 3);
INSERT INTO solicitudes VALUES(3, 1003, TO_DATE('2023-08-03', 'YYYY-MM-DD'), NULL, 'W', 35.00, 'Pendiente', 3, 1);


DELETE FROM clientes WHERE idCliente = 1;

SELECT * FROM solicitudes;
SELECT * FROM clientes;


TRUNCATE TABLE solicitudes;
TRUNCATE TABLE clientes;
TRUNCATE TABLE posiciones;
TRUNCATE TABLE personas;

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

/*---DisparadoresOk---*/

INSERT INTO personas VALUES(1, 'CC',1234567897 , 'Juan Perez', TO_DATE('2023-05-10', 'YYYY-MM-DD'), 1234567890, 'juan@gmail.com');
INSERT INTO personas VALUES(2, 'CC', 9875412345, 'Maria Rodriguez', TO_DATE('2023-06-15', 'YYYY-MM-DD'), 9876543210, 'maria@hotmail.com');
INSERT INTO personas VALUES(3, 'DNI', 5823456987, 'Carlos Sanchez', TO_DATE('1990-03-20', 'YYYY-MM-DD'), 5555555555, 'carlos@gmail.com');
INSERT INTO personas VALUES(4, 'CE', 1000536987, 'Luisa Martinez', TO_DATE('1985-11-28', 'YYYY-MM-DD'), 6666666666, 'luisa@hotmail.com');
INSERT INTO personas VALUES(5, 'TI', 52983610, 'Pedro Lopez', TO_DATE('2023-07-20', 'YYYY-MM-DD'), 7777777777, 'pedro@gmail.com');
INSERT INTO personas VALUES(6, 'TI',1234567897 , 'Juan Perez', TO_DATE('2023-05-10', 'YYYY-MM-DD'), 1234567890, 'juan@gmail.com');
INSERT INTO personas VALUES(7, 'DNI', 9875412345, 'Maria Rodriguez', TO_DATE('2023-06-15', 'YYYY-MM-DD'), 9876543210, 'maria@hotmail.com');
INSERT INTO personas VALUES(8, 'CC', 5823456987, 'Carlos Sanchez', TO_DATE('1990-03-20', 'YYYY-MM-DD'), 5555555555, 'carlos@gmail.com');
INSERT INTO personas VALUES(9, 'TI', 1000536987, 'Luisa Martinez', TO_DATE('1985-11-28', 'YYYY-MM-DD'), 6666666666, 'luisa@hotmail.com');
INSERT INTO personas VALUES(10, 'CE', 52983610, 'Pedro Lopez', TO_DATE('2023-07-20', 'YYYY-MM-DD'), 7777777777, 'pedro@gmail.com');

INSERT INTO clientes VALUES(1, 'Espaniol');
INSERT INTO clientes VALUES(2, 'Ingles');
INSERT INTO clientes VALUES(3, 'Frances');
INSERT INTO clientes VALUES(4, 'Aleman');
INSERT INTO clientes VALUES(5, 'Italiano');
INSERT INTO clientes VALUES(6, 'Espaniol');
INSERT INTO clientes VALUES(7, 'Ingles');
INSERT INTO clientes VALUES(8, 'Frances');
INSERT INTO clientes VALUES(9, 'Aleman');
INSERT INTO clientes VALUES(10, 'Italiano');

INSERT INTO posiciones VALUES(1, 40.7128, -74.0060);
INSERT INTO posiciones VALUES(2, 34.0522, -118.2437);
INSERT INTO posiciones VALUES(3, 51.5074, -0.1278);
INSERT INTO posiciones VALUES(4, 52.5200, 13.4050);
INSERT INTO posiciones VALUES(5, 41.8919, 12.5113);

/*Adicionar*/
-- Disparador: TR_SOLICITUDES_CODIGO_BI
INSERT INTO solicitudes (idCliente, fechaCreacion, plataforma, estado, ubicacionInicial, ubicacionFinal) VALUES (1, TO_DATE('2023-10-29', 'YYYY-MM-DD'), 'W', 'Pendiente', 1, 2);

-- Disparador: TR_SOLICITUDES_FECHA_CREACION_BI
INSERT INTO solicitudes (idCliente, plataforma, estado, ubicacionInicial, ubicacionFinal) VALUES (2, 'W', 'Pendiente', 2, 3);

-- Disparador: TR_FECHA_VIAJE_BI
INSERT INTO solicitudes (idCliente, fechaViaje, plataforma, estado, ubicacionInicial, ubicacionFinal) VALUES (3, TO_DATE('2023-11-15', 'YYYY-MM-DD'), 'W', 'Pendiente', 1, 3); 

-- Disparador: TR_ESTADO_PENDIENTE_BI
INSERT INTO solicitudes (idCliente, fechaCreacion, fechaViaje, plataforma, estado, ubicacionInicial, ubicacionFinal) VALUES (4, TO_DATE('2023-10-26', 'YYYY-MM-DD'), NULL, 'W', 'Asignada', 3, 2);

-- Disparador: TR_SOLICITUDES_POSICIONES_BI
INSERT INTO solicitudes (idCliente, fechaCreacion, fechaViaje, plataforma, estado, ubicacionInicial, ubicacionFinal) VALUES (5, TO_DATE('2023-10-26', 'YYYY-MM-DD'), NULL, 'W', 'Pendiente', 4, 5);

-- Disparador: TR_SOLICITUDES_ACTIVAS_BI
INSERT INTO solicitudes (idCliente, fechaCreacion, fechaViaje, plataforma, estado, ubicacionInicial, ubicacionFinal) VALUES (6, TO_DATE('2023-10-26', 'YYYY-MM-DD'), NULL, 'W', 'Pendiente', 5, 1);

-- Disparador: TR_VIAJE_PRECIO_NULL_BI
INSERT INTO solicitudes (idCliente, fechaCreacion, fechaViaje, plataforma, estado, ubicacionInicial, ubicacionFinal) VALUES (7, TO_DATE('2023-10-26', 'YYYY-MM-DD'), NULL, 'W', 'Pendiente', 2, 4);


/*Modificar*/

select * from solicitudes;
-- Disparador: TR_SOLICITUDES_ACTUALIZACION_VERIFICAR_BU
UPDATE solicitudes SET fechaViaje = TO_DATE('2023-11-10', 'YYYY-MM-DD'), precio = 12.0 WHERE codigo = 1;

-- Disparador: TR_SOLICITUDES_MODIFICACION_FECHA_PRECIO_BU
UPDATE solicitudes SET fechaViaje = TO_DATE('2023-11-10', 'YYYY-MM-DD'), precio = 150.0 WHERE codigo = 2;

-- Disparador: TR_SOLICITUDES_MODIFICACION_VIAJE_BU
UPDATE solicitudes SET fechaViaje = TO_DATE('2023-12-10', 'YYYY-MM-DD') WHERE codigo = 3;

-- Disparador: TR_ESTADO_MODIFICACION_NO_CANCELADA_BU
UPDATE solicitudes SET estado = 'Asignada' WHERE codigo = 4;


/*Eliminar*/
-- Disparador: TR_SOLICITUDES_ELIMINAR_BF
DELETE FROM solicitudes WHERE codigo = 121;

SELECT * FROM solicitudes;
/*---DisparadoresNoOk---*/
 /*Adicionar*/
INSERT INTO solicitudes (fechaCreacion, plataforma, estado, ubicacionInicial, ubicacionFinal) VALUES (TO_DATE('2023-10-29', 'YYYY-MM-DD'), 'A', 'Pendiente', 1, 2);
-- Comentario: Esta insercion no incluye un valor para el campo 'idCliente', lo que generaria un error en el disparador ya que no se puede generar el codigo de solicitud sin un cliente asociado.
INSERT INTO solicitudes (idCliente, fechaCreacion, plataforma, estado, ubicacionInicial, ubicacionFinal) VALUES (2, TO_DATE('2023-10-27', 'YYYY-MM-DD'), 'W', 'Pendiente', 1, 1);
-- Comentario: La posicion inicial y final son iguales (ubicacion 98765), lo que viola la restriccion del disparador.
INSERT INTO solicitudes (idCliente, fechaCreacion, plataforma, estado, ubicacionInicial, ubicacionFinal) VALUES (2, TO_DATE('2023-10-28', 'YYYY-MM-DD'), 'W', 'Pendiente', 5, 1);
-- Comentario: El cliente 2 ya tiene dos solicitudes en estado 'Pendiente', lo que viola la restriccion del disparador.

/*Modificar*/
UPDATE solicitudes SET fechaViaje = TO_DATE('2023-10-25', 'YYYY-MM-DD') WHERE codigo = 1;
-- Comentario: La fecha de viaje (2023-09-15) no es superior a la fecha de creacion (2023-10-27), lo que viola la restriccion del disparador
UPDATE solicitudes SET ubicacionInicial = 3 WHERE codigo = 2;
-- Comentario: El disparador no permite la actualizacion de la ubicacion inicial.
UPDATE solicitudes SET fechaCreacion = TO_DATE('2023-10-25', 'YYYY-MM-DD') WHERE codigo = 5;
-- Comentario: El disparador no permite la actualizacion de la fecha de creacion.
UPDATE solicitudes SET ubicacionFinal = 5 WHERE codigo = 2;
-- Comentario: El disparador no permite la actualizacion de la ubicacion final.
UPDATE solicitudes SET fechaViaje = TO_DATE('2023-11-10', 'YYYY-MM-DD') WHERE codigo = 4;
-- Comentario: El disparador no permite la modificacion de la fecha de viaje en estado diferente de 'Pendiente'.
UPDATE solicitudes SET precio = 150.0 WHERE codigo = 4;
-- Comentario: El disparador no permite la modificacion del precio en estado diferente de 'Pendiente'.
UPDATE solicitudes SET fechaViaje = TO_DATE('2023-9-27', 'YYYY-MM-DD') WHERE codigo = 7;
-- Comentario: El disparador no permite la actualizacion de la fecha de viaje igual o anterior a la fecha actual.
UPDATE solicitudes SET estado = 'Cancelada' WHERE codigo = 6;
-- Comentario: El disparador no permite la actualizacion del estado a 'Cancelada'.


/*Eliminar*/
DELETE FROM solicitudes WHERE codigo = 105;
-- Comentario: El disparador no permite la eliminacion de solicitudes.

/*-----------XDisparadores-----------------*/
/*-----Adicion-----*/
DROP TRIGGER TR_SOLICITUDES_FECHA_CREACION_BI;
DROP TRIGGER TR_FECHA_VIAJE_BI;
DROP TRIGGER TR_ESTADO_PENDIENTE_BI;
DROP TRIGGER TR_SOLICITUDES_POSICIONES_BI;
DROP TRIGGER TR_SOLICITUDES_ACTIVAS_BI;
DROP TRIGGER TR_VIAJE_PRECIO_NULL_BI;

/*-----Modificacion-----*/
DROP TRIGGER TR_SOLICITUDES_ACTUALIZACION_VERIFICAR_BU;
DROP TRIGGER TR_SOLICITUDES_MODIFICACION_FECHA_PRECIO_BU;
DROP TRIGGER TR_SOLICITUDES_MODIFICACION_VIAJE_BU;
DROP TRIGGER TR_ESTADO_MODIFICACION_NO_CANCELADA_BU;

/*-----Eliminacion-----*/
DROP TRIGGER TR_SOLICITUDES_ELIMINAR_BF;


/*----------CICLO 2: CRUD: pqrs----------*/
/*---Tuplas---*/
/*---TuplasOk---*/
/*---TuplasNoOk---*/
/*------Acciones-----*/
/*---XRestricciones---*/
ALTER TABLE pqrs DROP CONSTRAINT fk_pqrs_codigoSolicitud;
ALTER TABLE anexos DROP CONSTRAINT fk_anexos_idTicked;
/*---Acciones---*/
ALTER TABLE pqrs ADD CONSTRAINT fk_pqrs_codigoSolicitud FOREIGN KEY (codigoSolicitud) REFERENCES solicitudes(codigo) ON DELETE CASCADE;
ALTER TABLE anexos ADD CONSTRAINT fk_anexos_idTicked FOREIGN KEY(idTicked) REFERENCES pqrs(ticked) ON DELETE CASCADE;

/*---AccionesOk---*/
-- Inserta personas
INSERT INTO personas (id, tipo, numero, nombre, registro, celular, correo)
VALUES (1, 'CC', 123456789, 'Juan Perez', TO_DATE('2023-10-26', 'YYYY-MM-DD'), 1234567890, 'juan@example.com');

INSERT INTO personas (id, tipo, numero, nombre, registro, celular, correo)
VALUES (2, 'TI', 987654321, 'Maria Gomez', TO_DATE('2023-10-27', 'YYYY-MM-DD'), 9876543210, 'maria@example.com');

INSERT INTO personas (id, tipo, numero, nombre, registro, celular, correo)
VALUES (3, 'CC', 567890123, 'Pedro Rodriguez', TO_DATE('2023-10-28', 'YYYY-MM-DD'), 5678901234, 'pedro@example.com');

INSERT INTO personas (id, tipo, numero, nombre, registro, celular, correo)
VALUES (4, 'TI', 345678901, 'Ana Lopez', TO_DATE('2023-10-29', 'YYYY-MM-DD'), 3456789012, 'ana@example.com');

INSERT INTO personas (id, tipo, numero, nombre, registro, celular, correo)
VALUES (5, 'CC', 234567890, 'Carlos Sanchez', TO_DATE('2023-10-30', 'YYYY-MM-DD'), 2345678901, 'carlos@example.com');

-- Inserta clientes
INSERT INTO clientes (idCliente, idioma)
VALUES (1, 'Espaniol');

INSERT INTO clientes (idCliente, idioma)
VALUES (2, 'Ingles');

INSERT INTO clientes (idCliente, idioma)
VALUES (3, 'Frances');

INSERT INTO clientes (idCliente, idioma)
VALUES (4, 'Aleman');

INSERT INTO clientes (idCliente, idioma)
VALUES (5, 'Italiano');

-- Inserta posiciones
INSERT INTO posiciones (ubicacion, latitud, longitud)
VALUES (1, 40.7128, -74.0060);

INSERT INTO posiciones (ubicacion, latitud, longitud)
VALUES (2, 34.0522, -118.2437);

INSERT INTO posiciones (ubicacion, latitud, longitud)
VALUES (3, 51.5074, -0.1278);

INSERT INTO posiciones (ubicacion, latitud, longitud)
VALUES (4, 48.8566, 2.3522);

INSERT INTO posiciones (ubicacion, latitud, longitud)
VALUES (5, 41.3851, 5.44);

INSERT INTO posiciones (ubicacion, latitud, longitud)
VALUES (6, 12.546546, 2.65);

INSERT INTO posiciones (ubicacion, latitud, longitud)
VALUES (7, 12.45, 2.1734);

INSERT INTO posiciones (ubicacion, latitud, longitud)
VALUES (8, 32.65, 5.1734);

INSERT INTO posiciones (ubicacion, latitud, longitud)
VALUES (9, 45.654, 5.1734);

INSERT INTO posiciones (ubicacion, latitud, longitud)
VALUES (10, 54.3851, 312.45);

-- Inserta solicitudes
INSERT INTO solicitudes (idCliente, codigo, fechaCreacion, fechaViaje, plataforma, precio, estado, ubicacionInicial, ubicacionFinal)
VALUES (1, 123, TO_DATE('2023-10-26', 'YYYY-MM-DD'), TO_DATE('2023-10-27', 'YYYY-MM-DD'), 'W', NULL, 'Pendiente', 1, 2);

INSERT INTO solicitudes (idCliente, codigo, fechaCreacion, fechaViaje, plataforma, precio, estado, ubicacionInicial, ubicacionFinal)
VALUES (2, 124, TO_DATE('2023-10-28', 'YYYY-MM-DD'), TO_DATE('2023-10-29', 'YYYY-MM-DD'), 'A', NULL, 'Pendiente', 3, 4);

INSERT INTO solicitudes (idCliente, codigo, fechaCreacion, fechaViaje, plataforma, precio, estado, ubicacionInicial, ubicacionFinal)
VALUES (3, 125, TO_DATE('2023-10-30', 'YYYY-MM-DD'), TO_DATE('2023-11-01', 'YYYY-MM-DD'), 'W', NULL, 'Pendiente', 5, 6);

INSERT INTO solicitudes (idCliente, codigo, fechaCreacion, fechaViaje, plataforma, precio, estado, ubicacionInicial, ubicacionFinal)
VALUES (4, 126, TO_DATE('2023-11-02', 'YYYY-MM-DD'), TO_DATE('2023-11-03', 'YYYY-MM-DD'), 'A', NULL, 'Pendiente', 7, 8);

INSERT INTO solicitudes (idCliente, codigo, fechaCreacion, fechaViaje, plataforma, precio, estado, ubicacionInicial, ubicacionFinal)
VALUES (5, 127, TO_DATE('2023-11-04', 'YYYY-MM-DD'), TO_DATE('2023-11-05', 'YYYY-MM-DD'), 'W', NULL, 'Pendiente', 9, 10);

-- Inserta PQRS
INSERT INTO pqrs (ticked, codigoSolicitud, radicacion, cierre, descripcion, tipo, estado)
VALUES ('PQRS1234567890', 123, TO_DATE('2023-10-26', 'YYYY-MM-DD'), NULL, 'Descripcion del PQRS 1', 'P', 'Abierto');

INSERT INTO pqrs (ticked, codigoSolicitud, radicacion, cierre, descripcion, tipo, estado)
VALUES ('PQRS2345678901', 124, TO_DATE('2023-10-28', 'YYYY-MM-DD'), NULL, 'Descripcion del PQRS 2', 'Q', 'Abierto');

INSERT INTO pqrs (ticked, codigoSolicitud, radicacion, cierre, descripcion, tipo, estado)
VALUES ('PQRS3456789012', 125, TO_DATE('2023-10-30', 'YYYY-MM-DD'), NULL, 'Descripcion del PQRS 3', 'R', 'Abierto');

INSERT INTO pqrs (ticked, codigoSolicitud, radicacion, cierre, descripcion, tipo, estado)
VALUES ('PQRS4567890123', 126, TO_DATE('2023-11-02', 'YYYY-MM-DD'), NULL, 'Descripcion del PQRS 4', 'S', 'Abierto');

INSERT INTO pqrs (ticked, codigoSolicitud, radicacion, cierre, descripcion, tipo, estado)
VALUES ('PQRS5678901234', 127, TO_DATE('2023-11-04', 'YYYY-MM-DD'), NULL, 'Descripcion del PQRS 5', 'P', 'Abierto');

-- Inserta anexos
INSERT INTO anexos (idAnexo, idTicked, nombre, url)
VALUES (1, 'PQRS1234567890', 'Anexo 1', 'https://example.com/anexo1.pdf');

INSERT INTO anexos (idAnexo, idTicked, nombre, url)
VALUES (2, 'PQRS1234567890', 'Anexo 2', 'https://example.com/anexo2.pdf');

INSERT INTO anexos (idAnexo, idTicked, nombre, url)
VALUES (3, 'PQRS2345678901', 'Anexo 3', 'https://example.com/anexo3.pdf');

INSERT INTO anexos (idAnexo, idTicked, nombre, url)
VALUES (4, 'PQRS3456789012', 'Anexo 4', 'https://example.com/anexo4.pdf');

INSERT INTO anexos (idAnexo, idTicked, nombre, url)
VALUES (5, 'PQRS4567890123', 'Anexo 5', 'https://example.com/anexo5.pdf');

-- Inserta respuestas de PQRS
INSERT INTO pqrsrespuestas (idTicked, fecha, descripcion, nombre, correo, comentario, evaluacion)
VALUES ('PQRS1234567890', TO_DATE('2023-10-27', 'YYYY-MM-DD'), 'Respuesta 1', 'Usuario 1', 'usuario1@example.com', NULL, 4);

INSERT INTO pqrsrespuestas (idTicked, fecha, descripcion, nombre, correo, comentario, evaluacion)
VALUES ('PQRS2345678901', TO_DATE('2023-10-29', 'YYYY-MM-DD'), 'Respuesta 2', 'Usuario 2', 'usuario2@example.com', 'Comentario 2', 5);

INSERT INTO pqrsrespuestas (idTicked, fecha, descripcion, nombre, correo, comentario, evaluacion)
VALUES ('PQRS3456789012', TO_DATE('2023-11-01', 'YYYY-MM-DD'), 'Respuesta 3', 'Usuario 3', 'usuario3@example.com', 'Comentario 3', 3);

INSERT INTO pqrsrespuestas (idTicked, fecha, descripcion, nombre, correo, comentario, evaluacion)
VALUES ('PQRS4567890123', TO_DATE('2023-11-03', 'YYYY-MM-DD'), 'Respuesta 4', 'Usuario 4', 'usuario4@example.com', NULL, 4);

INSERT INTO pqrsrespuestas (idTicked, fecha, descripcion, nombre, correo, comentario, evaluacion)
VALUES ('PQRS5678901234', TO_DATE('2023-11-05', 'YYYY-MM-DD'), 'Respuesta 5', 'Usuario 5', 'usuario5@example.com', 'Comentario 5', 5);

/*-------Disparadores-------*/

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


/*---DisparadoresOk---*/
/*Adicionar*/

-- Disparador TR_PQRS_TICKED_BF
INSERT INTO pqrs (tipo, codigoSolicitud, radicacion, descripcion, estado) 
VALUES ('R', 1, TO_DATE('2023-02-15', 'YYYY-MM-DD'), 'Reclamo por demora', 'Abierto');
-- Comentario: El disparador TR_PQRS_TICKED_BF crea automaticamente el ticket

-- Disparador TR_PQRS_TICKED_TIPO_BF 
INSERT INTO pqrs (codigoSolicitud, radicacion, descripcion, estado)  
VALUES (2, TO_DATE('2023-02-16', 'YYYY-MM-DD'), 'Sugerencia de mejora', 'Abierto');
-- Comentario: El disparador TR_PQRS_TICKED_TIPO_BF si no se recibe el tipo, este automaticamente lo asigana con "s"

-- Disparador TR_PQRS_RADICACION_BF
INSERT INTO pqrs (tipo, codigoSolicitud, descripcion, estado) 
VALUES ('P', 3, 'Peticion de cambio de conductor', 'Abierto');
-- Comentario: El disparador TR_PQRS_RADICACION_BF genera automaticamente la fecha de la radicacion

-- Disparador TR_PQRS_ESTADO_BF
INSERT INTO pqrs (tipo, codigoSolicitud, radicacion, descripcion)
VALUES ('Q', 4, TO_DATE('2023-02-17', 'YYYY-MM-DD'), 'Queja por estado del vehiculo');
-- Comentario: El disparador TR_PQRS_RADICACION_BF genera automaticamente que el estado inicia sea Abierto

/*Modificar*/

-- Disparador TR_M_PQRS_ESTADO_BF
UPDATE pqrs
SET estado = 'Cerrado'
WHERE ticked = 'R202310270020';
-- Comentario: El disparador TR_M_PQRS_ESTADO_BF hace que el unico campo que se pueda modificar sea estado

-- Disparador TR_M_PQRS_ESTADO_FECHA_BF  
UPDATE pqrs
SET estado = 'Rechazado'
WHERE ticked = 'S202310270021';
-- Comentario: El disparador TR_M_PQRS_ESTADO_FECHA_BF hace que cuando se actualize el estado a rechazado cambie la fecha por la actual


-- Disparador TR_M_PQRS_FECHA_RADICACION_BF
UPDATE pqrs
SET estado = 'Cerrado',
    cierre = TO_DATE('2023-02-20', 'YYYY-MM-DD') -- fecha anterior a radicacion
WHERE ticked = 'P202310270025';
-- Comentario: El disparador TR_M_PQRS_FECHA_RADICACION_BF que la fecha de radicaion y cierre sea una mnor que la otra 


-- Disparador TR_M_PQRS_ANEXOS_BF
-- Debido a que se cambia el estado no e puede insertar e caso contrario si, el primeor si inserta, el otro no debido a que se cambio el estado
INSERT INTO anexos VALUES (1, 'Q202310270026', 'Peticion', 'https://ejemplo.com/anexos/anexo1.pdf');
UPDATE pqrs
SET estado = 'Cerrado'
WHERE ticked = 'Q202310270026'; 
INSERT INTO anexos VALUES (2, 'Q202310270026', 'Peticion', 'https://ejemplo.com/anexos/anexo1.pdf');
-- Comentario: El disparador TR_M_PQRS_ANEXOS_BF verifica que si en el pqrs se ecnuetra en Abierto pueda agregar anexos de caso contrarrio no  


/*Eliminar*/

-- Disparador TR_PQRS_ELIMINAR_BF
-- Intentar eliminar el PQRS recien creado 
DELETE FROM pqrs
WHERE ticked = 'P202301000005';
-- Comentario: El disparador TR_PQRS_ELIMINAR_BF intenta eliminar n pqrs sieste mismo no tene un pqrsrespuesta si no no se puede

-- Disparador TR_PQRS_ELIMINAR_BF
-- Intentar nuevamente eliminar el PQRS (ahora con respuesta)
DELETE FROM pqrs
WHERE ticked = 'P202301000005';
-- Comentario: El disparador TR_PQRS_ELIMINAR_BF al eliminar un pqrs, tambien elimina los anexos que tenga sociados


/*-----------XDisparadores-----------------*/
/*-----Adicion-----*/
DROP TRIGGER TR_PQRS_TICKED_BF;
DROP TRIGGER TR_PQRS_TICKED_BF_JU;
DROP TRIGGER TR_PQRS_RADICACION_BF;
DROP TRIGGER TR_PQRS_ESTADO_BF;

/*-----Modificacion-----*/
DROP TRIGGER TR_M_PQRS_ESTADO_BF;
DROP TRIGGER TR_M_PQRS_ESTADO_FECHA_BF;
DROP TRIGGER TR_M_PQRS_FECHA_RADICACION_BF;
DROP TRIGGER TR_M_PQRS_ANEXOS_BF;


/*-----Eliminacion-----*/
DROP TRIGGER TR_PQRS_ELIMINAR_BF;
DROP TRIGGER TR_PQRS_ELIMINAR_ANEXOS_BF;



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

/*----------Punto C: Modelo f�sico. Componentes----------*/
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
    FUNCTION CO_Pqrs_Cerrados RETURN SYS_REFCURSOR;
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
    PC_PQRS.MO_PQRS('S202311252338');
END;
/

BEGIN 
    PC_PQRS.AD_PQRS('S202311191715');
END;
/

/*DE_PQRS*/
BEGIN 
    PC_PQRS.DE_PQRS('S202311252338');
END;
/

BEGIN 
    PC_PQRS.DE_PQRS('S202311191715');
END;
/

BEGIN 
    PC_PQRS.DE_PQRS('S202311191716');
END;
/

BEGIN 
    PC_PQRS.DE_PQRS('S202311191717');
END;
/

BEGIN 
    PC_PQRS.DE_PQRS('S202311191718');
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

/*----------Punto D.: Modelo f�sico. Seguridad----------*/

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
CREATE ROLE PA_CLIENTE_UBER1;
GRANT SELECT, INSERT, UPDATE, DELETE ON pqrs TO PA_CLIENTE_UBER1;
GRANT SELECT, INSERT, UPDATE, DELETE ON anexos TO PA_CLIENTE_UBER1;
GRANT SELECT ON pqrsrespuestas TO PA_CLIENTE_UBER1;

CREATE ROLE PA_ANALISTA_CLIENTES_UBER1;
GRANT SELECT ON pqrs TO PA_ANALISTA_CLIENTES_UBER1;
GRANT SELECT ON anexos TO PA_ANALISTA_CLIENTES_UBER1;
GRANT SELECT, INSERT, UPDATE, DELETE ON pqrsrespuestas TO PA_ANALISTA_CLIENTES_UBER1;


GRANT ALL ON pqrs TO bd1000093114; 
GRANT ALL ON anexos TO bd1000093114; 
GRANT ALL ON pqrsrespuestas TO bd1000093114; 

GRANT ALL ON pqrs TO bd1000093739; 
GRANT ALL ON anexos TO bd1000093739; 
GRANT ALL ON pqrsrespuestas TO bd1000093739; 
--3
--XSeguridad
DROP ROLE PA_CLIENTE;
DROP ROLE PA_ANALISTA_CLIENTES;

--4
SELECT * FROM SESSION_ROLES;
SELECT * FROM SESSION_PRIVS;
EXECUTE DBMS_SESSION.SET_ROLE('PA_CLIENTE_UBER1');
BEGIN
    PA_CLIENTE.AD_PQRS(1, 'No llego el vehiculo', 'Q');
END;
/
BEGIN 
    PC_PQRS.ad_anexo(1, 'S202311191714', 'Peticion', 'https://hgfo.pdf');
END;
/

EXECUTE DBMS_SESSION.SET_ROLE('PA_ANALISTA_CLIENTES_UBER1');
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

--1. El cliente inicia sesi�n en el sistema.
EXECUTE DBMS_SESSION.SET_ROLE('PA_CLIENTE');
--2. El cliente presenta una queja sobre un veh�culo que no lleg�.
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
--6. El analista de clientes inicia sesi�n en el sistema.
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
