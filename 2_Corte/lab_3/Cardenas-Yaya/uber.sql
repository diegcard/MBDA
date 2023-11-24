CREATE DATABASE uber;
USE uber;

-- CREATE TABLES
/*---------------------------------------------CICLO 1: Tablas---------------------------------------------*/
CREATE TABLE personas(
    id NUMBER(9) NOT NULL,
    tipo VARCHAR2(10) NOT NULL,
    numero NUMBER(10)NOT NULL,
    nombre VARCHAR2(50)NOT NULL,
    registro DATE NOT NULL,
    celular NUMBER(10),
    correo VARCHAR2(50)
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
    a_o VARCHAR2(10)NULL,
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
	correo VARCHAR2(50) NOT NULL,
	comentario VARCHAR2(20) NULL,
	evaluacion VARCHAR2(20) NULL
);
/*---------------------------------------------CICLO 1: XTablas---------------------------------------------*/
DROP TABLE vehiculos;
DROP TABLE conductores;
DROP TABLE tarjetasClientes;
DROP TABLE tarjetas;
DROP TABLE anexos;
DROP TABLE pqrsrespuestas;
DROP TABLE pqrs;
DROP TABLE requerimientos;
DROP TABLE solicitudes;
DROP TABLE posiciones;
DROP TABLE clientes;
DROP TABLE personas;

/*---------------------------------------------CICLO 1: PoblarOk (1)--------------------------------------------*/
INSERT INTO personas VALUES(1, 'CC', 12345, 'Juan Perez', TO_DATE('2023-10-20', 'YYYY-MM-DD'), 5555555555, 'juan@example.com');
INSERT INTO personas VALUES(2, 'CC', 54321, 'Maria Rodriguez', TO_DATE('2023-10-20', 'YYYY-MM-DD'), 6666666666, 'maria@example.com');
INSERT INTO personas VALUES(3, 'TI', 67890, 'Ana Lopez', TO_DATE('2023-10-20', 'YYYY-MM-DD'), 7777777777, 'ana@example.com');

INSERT INTO conductores VALUES(1, 'ABC123', TO_DATE('1990-01-15', 'YYYY-MM-DD'), 4, 'Activo');
INSERT INTO conductores VALUES(2, 'XYZ789', TO_DATE('1985-05-20', 'YYYY-MM-DD'), 5, 'Activo');
INSERT INTO conductores VALUES(3, 'DEF456', TO_DATE('1988-08-10', 'YYYY-MM-DD'), 3, 'Inactivo');

INSERT INTO clientes VALUES(1, 'Espa�ol');
INSERT INTO clientes VALUES(2, 'Ingles');
INSERT INTO clientes VALUES(3, 'Frances');

INSERT INTO vehiculos VALUES(1, 'ABC123', '2020', 'S', 'Activo', 4, 4, 0);
INSERT INTO vehiculos VALUES(2, 'XYZ789', '2018', 'S', 'Activo', 4, 4, 0);
INSERT INTO vehiculos VALUES(3, 'DEF456', '2019', 'M', 'Activo', 4, 4, 1);

INSERT INTO tarjetasClientes VALUES (1, 123456789012345);
INSERT INTO tarjetasClientes VALUES (2, 987654321098765);
INSERT INTO tarjetasClientes VALUES (3, 567890123456789);

INSERT INTO tarjetas VALUES(123456789012345, 'Visa', TO_DATE('2024-12-31', 'YYYY-MM-DD'));
INSERT INTO tarjetas VALUES(987654321098765, 'MasterCard', TO_DATE('2025-06-30', 'YYYY-MM-DD'));
INSERT INTO tarjetas VALUES(567890123456789, 'BBVA', TO_DATE('2023-09-30', 'YYYY-MM-DD'));

INSERT INTO solicitudes VALUES(1, 1001, TO_DATE('2023-10-20', 'YYYY-MM-DD'), TO_DATE('2023-10-21', 'YYYY-MM-DD'), 'W', 25.99, 'Pendiente', 1, 2);
INSERT INTO solicitudes VALUES(2, 1002, TO_DATE('2023-10-20', 'YYYY-MM-DD'), TO_DATE('2023-10-22', 'YYYY-MM-DD'), 'M', 30.50, 'Aceptada', 2, 3);
INSERT INTO solicitudes VALUES(3, 1003, TO_DATE('2023-10-20', 'YYYY-MM-DD'), TO_DATE('2023-10-23', 'YYYY-MM-DD'), 'W', 18.75, 'Cancelada',3, 1);

INSERT INTO requerimientos VALUES('R1001', 1001);
INSERT INTO requerimientos VALUES('R1002', 1002);
INSERT INTO requerimientos VALUES('R1003', 1003);

INSERT INTO posiciones VALUES(4, 38.8951100, -77.0363700);
INSERT INTO posiciones VALUES(5, 51.509865, -0.118092);
INSERT INTO posiciones VALUES(6, 40.7128, -74.0060);

INSERT INTO pqrs VALUES ('T1004', 1004, TO_DATE('2023-10-26', 'YYYY-MM-DD'), TO_DATE('2023-10-27', 'YYYY-MM-DD'), 'Problema de seguridad', 'Queja', 'En Proceso');
INSERT INTO pqrs VALUES ('T1005', 1005, TO_DATE('2023-10-27', 'YYYY-MM-DD'), TO_DATE('2023-10-28', 'YYYY-MM-DD'), 'Demora en el servicio', 'Reclamo', 'Abierto');
INSERT INTO pqrs VALUES ('T1006', 1006, TO_DATE('2023-10-28', 'YYYY-MM-DD'), TO_DATE('2023-10-29', 'YYYY-MM-DD'), 'Felicitaciones al conductores', 'Elogio', 'Cerrado');

INSERT INTO anexos VALUES(4, 'T1004', 'Foto3.jpg', 'https://example.com/foto3.jpg');
INSERT INTO anexos VALUES(5, 'T1005', 'Audio.mp3', 'https://example.com/audio.mp3');
INSERT INTO anexos VALUES(6, 'T1006', 'Documento.pdf', 'https://example.com/documento.pdf');

INSERT INTO pqrsrespuestas VALUES('T1004', TO_DATE('2023-10-27', 'YYYY-MM-DD'), 'Estamos investigando su reporte', 'Soporte', 'soporte@example.com', 'Gracias ', 'Pendiente');
INSERT INTO pqrsrespuestas VALUES('T1005', TO_DATE('2023-10-28', 'YYYY-MM-DD'), 'Hemos tomado medidas para mejorar', 'Soporte', 'soporte@example.com', 'Lamentamos la demora', 'Aceptable');
INSERT INTO pqrsrespuestas VALUES('T1006', TO_DATE('2023-10-29', 'YYYY-MM-DD'), 'Agradecemos su elogio al conductores', 'Soporte', 'soporte@example.com', 'Que disfrute', 'Excelente');

/*---------------------------------------------CICLO 1: PoblarNoOk (2)---------------------------------------------*/
-- Intento de insercion sin proporcionar un valor para la columna NOT NULL "nombre".
INSERT INTO personas VALUES(6, 'C.C', 5432109876, TO_DATE('2023-10-25', 'YYYY-MM-DD'), 5432109876, 'conductores2@example.com');
-- Intento de insercion con un valor demasiado largo para la columna "tipo".
INSERT INTO personas VALUES(7, 'EsteEsUnTipoDemasiadoLargo', 1234567890, 'Persona 7', TO_DATE('2023-10-26', 'YYYY-MM-DD'), 1234567890, 'persona7@example.com');
-- Intento de insercion con un número de celular que excede el límite definido.
INSERT INTO personas VALUES(8, 'C.C', 9876543210, 'Cliente 8', TO_DATE('2023-10-27', 'YYYY-MM-DD'), 12345678901, 'cliente8@example.com');
-- Intento de insercion con un formato de fecha incorrecto para la columna "registro".
INSERT INTO personas VALUES(9, 'C.C', 6543210987, 'conductores 9', '2023/10/28', 6543210987, 'conductores9@example.com');
-- Intento de insercion nulo en el id de la persona
INSERT INTO personas VALUES(NULL, 'C.C', 2345678901, 'Cliente 10', TO_DATE('2023-10-29', 'YYYY-MM-DD'), 2345678901, 'correo456456@example.com');


--Intento de insercion con un número de licencia demasiado largo.
INSERT INTO conductores VALUES(6, 'ABC1234567890', TO_DATE('1990-01-01', 'YYYY-MM-DD'), 5, 'Activo');
--Intento de insercion con una fecha de nacimiento en un formato incorrecto.
INSERT INTO conductores VALUES(7, 'XYZ456', '1985/02/15', 4, 'Inactivo');
--Intento de insercion con un número mayor que pla precision especificada
INSERT INTO conductores VALUES(8, 'DEF789', TO_DATE('1995-05-10', 'YYYY-MM-DD'), 10, 'Activo');
--Intento de insercion con un estado nulo
INSERT INTO conductores VALUES(9, 'GHI123', TO_DATE('1980-11-30', 'YYYY-MM-DD'), 4, NULL);
--Intento de insercion sin valor en el ID
INSERT INTO conductores VALUES('JKL456', TO_DATE('1978-09-20', 'YYYY-MM-DD'), 5, 'Activo');


--Intento de insercion de un clientes sin proporcionar un valor para "idioma".
INSERT INTO clientes VALUES(6, NULL);
--Intento de insercion con un valor de "idioma" que excede el límite de caracteres.
INSERT INTO clientes VALUES(7, 'EsteIdiomaEsDemasiadoLargo');
--Intento de insercion sin el ID de clientes
INSERT INTO clientes VALUES('Inglés');


--Intento de insercion sin proporcionar un valor para la columna NOT NULL "estado".
INSERT INTO vehiculos VALUES(6, 'ABCXYZ', '2020', 'C', 4, 4, 1);
--Intento de insercion con un tipo de vehículo no válido.
INSERT INTO vehiculos VALUES(7, 'XYZ123', '2020', 'XR', 'En Reparacion', 2, 2, 0);
--Intento de insercion con un valor muy alto para la columna "puertas".
INSERT INTO vehiculos VALUES(8, 'DEF456', '2022', 'C', 'Disponible', 10, 4, 1);
--Intento de insercion con un valor que excede el límite en la columna "placa".
INSERT INTO vehiculos VALUES(9, 'GHI123456', '2021', 'M', 'En Mantenimiento', 2, 2, 0);
--Intento de insercion sin un valor nulo en la placa
INSERT INTO vehiculos VALUES(10, NULL, '2018', 'C', 'Disponible', 4, 4, 1);


-- Intento de insercion de una tarjetas sin proporcionar un valor para la columna NOT NULL "numero".
INSERT INTO tarjetasClientes VALUES(4);
-- Intento de insercion de una tarjetas con número no válido.
INSERT INTO tarjetasClientes VALUES(5, 1234567890123457);
-- Intento de insercion de una tarjeta sin el ID del cliente
INSERT INTO tarjetasClientes VALUES(987654321098765);
-- Intento de insercion de una tarjetas con un número nulo (violacion de restriccion NOT NULL).
INSERT INTO tarjetasClientes VALUES(6, NULL);


--Intento de insercion de una tarjetas de crédito con un número no válido.
INSERT INTO tarjetas VALUES(1234567890123457, 'Banco ABC', TO_DATE('2025-12-31', 'YYYY-MM-DD'));
--Intento de insercion sin proporcionar un valor para la columna NOT NULL "entidad".
INSERT INTO tarjetas VALUES(98765432109875, TO_DATE('2024-11-30', 'YYYY-MM-DD'));
--Intento de insercion con una fecha de vencimiento no valida.
INSERT INTO tarjetas VALUES(567890123456789, 'Banco DEF', '2021/05/10');
--Intento de insercion con un valor nulo en el numero de la tarjeta
INSERT INTO tarjetas VALUES(NULL, 'Banco GHI', TO_DATE('2025-06-30', 'YYYY-MM-DD'));
--Intento de insercion con una entidad nula
INSERT INTO tarjetas VALUES(123456789012346, NULL, TO_DATE('2025-12-31', 'YYYY-MM-DD'));


-- Intento de insercion con una fecha de viaje no valida
INSERT INTO solicitudes VALUES(6, 54321, TO_DATE('2023-10-20', 'YYYY-MM-DD'), '2023-10-19', 'A', 20.0, 'Pendiente', 12, 67);
-- Intento de insercion con una plataforma no válida 
INSERT INTO solicitudes VALUES(7, 54322, TO_DATE('2023-10-21', 'YYYY-MM-DD'), TO_DATE('2023-10-22', 'YYYY-MM-DD'), 'XI', 25.0, 'Pendiente', 1, 2);
-- Intento de insercion con un precio nulo.
INSERT INTO solicitudes VALUES(8, 54323, TO_DATE('2023-10-22', 'YYYY-MM-DD'), TO_DATE('2023-10-23', 'YYYY-MM-DD'), 'A', NULL, 'Pendiente', 1, 2);
-- Intento de insercion con un estado que supere el numero de caracteres
INSERT INTO solicitudes VALUES(9, 54324, TO_DATE('2023-10-23', 'YYYY-MM-DD'), TO_DATE('2023-10-24', 'YYYY-MM-DD'), 'A', 30.0, 'Invalido123456', 1, 2);
-- Intento de insercion sin ubicaciones iniciales y finales
INSERT INTO solicitudes VALUES(10, 54325, TO_DATE('2023-10-24', 'YYYY-MM-DD'), TO_DATE('2023-10-25', 'YYYY-MM-DD'), 'I', 40.0, 'Pendiente');


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


-- Intento de insercion con una latitud como string.
INSERT INTO posiciones VALUES(21, '-40.7128', 74.0060);
-- Intento de insercion de una posicion con latitud nula.
INSERT INTO posiciones VALUES(22, -74.0060);
-- Intento de insercion sin proporcionar un valor para la columna NOT NULL "id".
INSERT INTO posiciones VALUES(40.7128, -74.0060);
-- Intento de insercion de una posicion sin lalitud y longitud
INSERT INTO posiciones VALUES(23);
-- Intento de insercion con valores no numéricos en las columnas "latitud" y "longitud".
INSERT INTO posiciones VALUES(24, 'Cuarenta', 'Setenta y cuatro');



--Intento de insercion de una PQRS sin proporcionar un valor para la columna NOT NULL "descripcion".
INSERT INTO pqrs VALUES('PQRS-006', 6, TO_DATE('2023-10-30', 'YYYY-MM-DD'), TO_DATE('2023-11-01', 'YYYY-MM-DD'), 'Abierto', 'Ninguno');
--: Intento de insercion con un "tipo" que no es válido.
INSERT INTO pqrs VALUES('PQRS-007', 7, TO_DATE('2023-11-02', 'YYYY-MM-DD'), TO_DATE('2023-11-04', 'YYYY-MM-DD'), 'Descripcion1', 'TipoInvalidoMuyLargo', 'Abierto');
--: Intento de insercion con un "estado" demasiado largo.
INSERT INTO pqrs VALUES('PQRS-008', 8, TO_DATE('2023-11-05', 'YYYY-MM-DD'), TO_DATE('2023-11-07', 'YYYY-MM-DD'), 'Descripcion2','Reclamo', 'EsteEstadoEsDemasiadoLargo');
--: Intento de insercion con un "ticked" nulo
INSERT INTO pqrs VALUES(NULL, 9, TO_DATE('2023-11-08', 'YYYY-MM-DD'), TO_DATE('2023-11-10', 'YYYY-MM-DD'), 'Descripcion3','Queja', 'Abierto');
--: Intento de insercion con una fecha de radicacion no valida".
INSERT INTO pqrs VALUES('PQRS-009', 100, '2023-11-11', TO_DATE('2023-11-13', 'YYYY-MM-DD'), 'Descripcion4', 'Sugerencia', 'Abierto');


--Intento de insercion sin proporcionar un valor para la columna NOT NULL "url".
INSERT INTO anexos VALUES(25, 'PQRS-006', 'Anexo 1');
--Intento de insercion con una URL que excede el límite de caracteres.
INSERT INTO anexos VALUES(26, 'PQRS-007', 'Anexo 2', 'https://www.estaesunaurlmuylarga.com/queexcedeellimitedelacolumna/url');
--Intento de insercion con un "ticked" nulo.
INSERT INTO anexos VALUES(15, NULL, 'Anexo 3', 'https://www.ejemplo.com/anexo3.pdf');
--Intento de insercion de un anexos con un nombre muy largo.
INSERT INTO anexos VALUES(28, 'PQRS-009', 'Este nombre es muy largo', 'https://www.ejemplo.com/anexo4.pdf');
--Intento de insercion con un "id" nulo (violacion de restriccion NOT NULL).
INSERT INTO anexos VALUES('PQRS-006', 'Anexo 5', 'https://www.ejemplo.com/anexo5.pdf');


/*---------------------------------------------CICLO 1: PoblarNoOk (3)---------------------------------------------*/
--Insercion de dos personas con el mismo ID, la protege pk_personas_id
INSERT INTO personas VALUES(1, 'Cliente', '1234567890', 'Cliente 1', TO_DATE('2023-10-23', 'YYYY-MM-DD'), 1234567890, 'cliente1@example.com');
INSERT INTO personas VALUES(1, 'Conductor', '0987654321', 'Conductor 1', TO_DATE('1990-01-01', 'YYYY-MM-DD'), 9876543210, 'conductor1@example.com');

--Insercion de dos conductores con la misma licencia, la protege pk_conductores_idConductor
INSERT INTO conductores VALUES(1, 'A123456789', TO_DATE('1990-01-01', 'YYYY-MM-DD'), 5, 'Activo');
INSERT INTO conductores VALUES(2, 'A123456789', TO_DATE('1985-06-15', 'YYYY-MM-DD'), 4, 'Inactivo');

--Insercion de dos clientes con el mismo ID, la protege pk_clientes_idCliente
INSERT INTO clientes VALUES(1, 'Español');
INSERT INTO clientes VALUES(1, 'Inglés');

--Insercion de dos vehiculos con la misma placa la protege pk_vehiculos_placa
INSERT INTO vehiculos VALUES(1, 'ABC123', '2020', 'A', 'Disponible', 4, 4, 0);
INSERT INTO vehiculos VALUES(2, 'ABC123', '2019', 'B', 'Reparando', 2, 2, 1);

--Inserción de dos registros con el mismo número de tarjeta para el mismo cliente,la protege pk_tarjetasClientes_idCliente_numeroT
INSERT INTO tarjetasClientes VALUES(1, 123456789012345);
INSERT INTO tarjetasClientes VALUES(1, 123456789012345);

--Insercion de una tarjeta con un numero ya existente, la protege pk_tarjetas_numero
INSERT INTO tarjetas VALUES(123456789012345, 'Banco A', TO_DATE('2024-12-31', 'YYYY-MM-DD'));

--Insercion de una solicitud con el mismo codigo para el mismo cliente, la protege pk_solicitud_codigo
INSERT INTO solicitudes VALUES(1, 1001, TO_DATE('2023-10-23', 'YYYY-MM-DD'), TO_DATE('2023-10-24', 'YYYY-MM-DD'), 'A', 30.0, 'Pendiente', 12345678901, 98765432109);
INSERT INTO solicitudes VALUES(1, 1001, TO_DATE('2023-10-25', 'YYYY-MM-DD'), TO_DATE('2023-10-26', 'YYYY-MM-DD'), 'B', 35.0, 'Aprobada', 12345678902, 98765432108);

--Insercion de un requerimiento que no esta asociado a una solicitud, la protege fk_requerimientos_idSolicitud
INSERT INTO requerimientos VALUES('Informacion', 58);

--Insercion de dos registrios con la misma ubicacion, la protege pk_posiciones_ubicacion
INSERT INTO posiciones VALUES(12345678901, 34.0522, -118.2437);
INSERT INTO posiciones VALUES(12345678901, 34.0522, -118.2437);

--Insercion de dos anexos con el mismo ID de anexo, la protege pk_anexos_idAnexo
INSERT INTO anexos VALUES(1, 'TICKET1', 'Anexo1', 'http://example.com/anexo1.pdf');
INSERT INTO anexos VALUES(1, 'TICKET2', 'Anexo2', 'http://example.com/anexo2.pdf');

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
ALTER TABLE personas ADD CONSTRAINT chk_personas_correo CHECK (REGEXP_LIKE(correo, '.*@(gmail\.com|hotmail\.com|outlook\.com)$'));
ALTER TABLE personas ADD CONSTRAINT chk_personas_tipo_documento CHECK (tipo IN ('CC', 'TI', 'RC', 'CE', 'CI', 'DNI'));
ALTER TABLE vehiculos ADD CONSTRAINT chk_vehiculos_a_o CHECK (LENGTH(a_o) = 4 AND TO_NUMBER(a_o) BETWEEN 1900 AND 2100);
ALTER TABLE vehiculos ADD CONSTRAINT chk_vehiculos_tipo CHECK (tipo IN ('M', 'C', 'c'));
ALTER TABLE vehiculos ADD CONSTRAINT chk_vehiculos_estado CHECK (estado IN ('Activo', 'Pendiente'));
ALTER TABLE vehiculos ADD CONSTRAINT chk_vehiculos_puertas CHECK (puertas >= 0 AND puertas <= 4); 
ALTER TABLE vehiculos ADD CONSTRAINT chk_vehiculos_pasajeros CHECK (pasajeros >= 0);
ALTER TABLE vehiculos ADD CONSTRAINT chk_vehiculos_carga CHECK ((tipo != 'c' AND carga IS NULL) OR (tipo = 'C' AND carga IS NOT NULL AND carga >= 0));
ALTER TABLE conductores ADD CONSTRAINT chk_conductores_estrellas CHECK (estrellas >= 1 AND estrellas <= 5);
ALTER TABLE anexos ADD CONSTRAINT chk_anexos_url CHECK (SUBSTR(url, 1, 8) = 'https://');
ALTER TABLE pqrsrespuestas ADD CONSTRAINT chk_pqrsrespuestas_evaluacion CHECK (evaluacion BETWEEN 1 AND 5);
ALTER TABLE solicitudes ADD CONSTRAINT chk_solicitudes_plataforma CHECK (plataforma IN ('W', 'A'));
ALTER TABLE pqrs ADD CONSTRAINT chk_pqrs_ticked CHECK (REGEXP_LIKE(ticked, '^[PQRS][0-9]{12}$'));
ALTER TABLE pqrs ADD CONSTRAINT chk_pqrs_tipo CHECK (tipo IN ('P', 'Q', 'R', 'S'));
ALTER TABLE pqrs ADD CONSTRAINT chk_pqrs_estado CHECK (estado IN ('Abierto', 'Cerrado', 'Rechazado'));
ALTER TABLE solicitudes ADD CONSTRAINT chk_solicitudes_estado CHECK (estado IN ('Pendiente', 'Aceptado'));

-- Restriccion CHECK para el atributo 'idioma' en la tabla 'clientes'
ALTER TABLE clientes ADD CONSTRAINT chk_clientes_idioma CHECK (idioma IN ('Espa�ol', 'Ingles', 'Frances', 'Aleman', 'Italiano', 'Portugues', 'Chino', 'Japones', 'Ruso', 'Arabe', 'Otros'));

-- Restriccion CHECK para el atributo 'entidad' en la tabla 'tarjetas'
ALTER TABLE tarjetas ADD CONSTRAINT chk_tarjetas_entidad CHECK (entidad IN ('Visa', 'Mastercard', 'American'));

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
-- Intentar insertar un valor de idioma que no está en la lista de idiomas conocidos
INSERT INTO clientes VALUES (1, 'Sueco');
-- Intentar insertar una tarjeta con una entidad que no está en la lista permitida
INSERT INTO tarjetas VALUES (1234567890123456, 'Discover', TO_DATE('2023-12-31', 'YYYY-MM-DD'));

/*---------------------------------------------CICLO 1: PoblarNoOk (4)---------------------------------------------*/
INSERT INTO personas VALUES (1, 'Cliente', '123456789', 'Juan Pérez', '2023-10-23', 'juan.perez@example.com');
-- La restricción CHECK 'chk_personas_correo' protege esta insercio�n

INSERT INTO conductores VALUES (1, 'ABC123', '1990-01-01', 6, 'Activo');
-- La restricción CHECK 'chk_conductores_estrellas' protege esta inserción

INSERT INTO vehiculos VALUES (1, 'XYZ123', '99', 'M', 'Activo', 4, 5, NULL);
-- La restricción CHECK 'chk_vehiculos_a_o' protege esta inserción

INSERT INTO solicitudes VALUES (1, 101, '2023-10-23', NULL, 'X', 20.5, 'Pendiente', 1, 2);
-- La restricción CHECK 'chk_solicitudes_plataforma' protege esta inserción

INSERT INTO tarjetas VALUES (1234567890123456, 'Discover', '2024-12-31');
-- La restricción CHECK 'chk_tarjetas_entidad' protege esta inserción

/*---------------------------------------------CICLO 1 <Consultar viajes con requerimientos de musica>---------------------------------------------*/
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
INSERT INTO conductores VALUES(4, 'L56789', TO_DATE('1988-06-02', 'YYYY-MM-DD'), 4, 'Pendiente');
INSERT INTO conductores VALUES(5, 'L23456', TO_DATE('1992-12-10', 'YYYY-MM-DD'), 3, 'Activo');

INSERT INTO vehiculos VALUES(1, 'ABC123', '2020', 'M', 'Activo', 4, 4, NULL);
INSERT INTO vehiculos VALUES(2, 'XYZ987', '2018', 'C', 'Activo', 2, 2, 300);
INSERT INTO vehiculos VALUES(3, 'DEF456', '2019', 'M', 'Pendiente', 4, 4, NULL);
INSERT INTO vehiculos VALUES(4, 'GHI789', '2021', 'M', 'Activo', 4, 4, NULL);
INSERT INTO vehiculos VALUES(5, 'JKL321', '2017', 'C', 'Activo', 4, 4, 400);

INSERT INTO clientes VALUES(1, 'Espa�ol');
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

INSERT INTO requerimientos VALUES('M�sica con ritmo latino', 1001);
INSERT INTO requerimientos VALUES('Asientos c�modos', 1002);
INSERT INTO requerimientos VALUES('M�sica rock', 1003);
INSERT INTO requerimientos VALUES('Climatizaci�n', 1004);
INSERT INTO requerimientos VALUES('Conductor amigable', 1005);

INSERT INTO pqrs VALUES('P202310000001', 1001, TO_DATE('2023-10-01', 'YYYY-MM-DD'), TO_DATE('2023-10-10', 'YYYY-MM-DD'), 'Problema de pago', 'P', 'Cerrado');
INSERT INTO pqrs VALUES('P202310000002', 1002, TO_DATE('2023-10-02', 'YYYY-MM-DD'), NULL, 'Conductor poco amigable', 'P', 'Abierto');
INSERT INTO pqrs VALUES('Q202310000003', 1003, TO_DATE('2023-10-03', 'YYYY-MM-DD'), NULL, 'M�sica muy alta', 'Q', 'Abierto');
INSERT INTO pqrs VALUES('P202310000004', 1004, TO_DATE('2023-10-04', 'YYYY-MM-DD'), NULL, 'Conductor grosero', 'P', 'Abierto');
INSERT INTO pqrs VALUES('Q202310000005', 1005, TO_DATE('2023-10-05', 'YYYY-MM-DD'), TO_DATE('2023-10-15', 'YYYY-MM-DD'), 'Demora en la recogida', 'Q', 'Cerrado');

INSERT INTO anexos VALUES(1001, 'P202310000001', 'Captura de pantalla', 'https://example.com/captura.png');
INSERT INTO anexos VALUES(1002, 'P202310000002', 'Audio grabado', 'https://example.com/audio.mp3');
INSERT INTO anexos VALUES(1003, 'Q202310000003', 'Fotos del veh�culo', 'https://example.com/fotos.zip');
INSERT INTO anexos VALUES(1004, 'P202310000004', 'Conversaci�n chat', 'https://example.com/chat.pdf');
INSERT INTO anexos VALUES(1005, 'Q202310000005', 'Video de incidente', 'https://example.com/video.mp4');

INSERT INTO pqrsrespuestas VALUES('P202310000001', TO_DATE('2023-10-05', 'YYYY-MM-DD'), 'Problema resuelto', 'Soporte', 'soporte@example.com', NULL, 5);
INSERT INTO pqrsrespuestas VALUES('P202310000002', TO_DATE('2023-10-07', 'YYYY-MM-DD'), 'Gracias por su feedback', 'Atenci�n al cliente', 'atencion@example.com', 'Estamos trabajando', 4);
INSERT INTO pqrsrespuestas VALUES('Q202310000003', TO_DATE('2023-10-06', 'YYYY-MM-DD'), 'Investigando el incidente', 'Soporte', 'soporte@example.com', NULL, NULL);
INSERT INTO pqrsrespuestas VALUES('P202310000004', TO_DATE('2023-10-06', 'YYYY-MM-DD'), 'Entendemos su preocupaci�n', 'Soporte', 'soporte@example.com', 'Estamos trabajando', 3);
INSERT INTO pqrsrespuestas VALUES('Q202310000005', TO_DATE('2023-10-08', 'YYYY-MM-DD'), 'Resoluci�n completa', 'Soporte', 'soporte@example.com', NULL, 5);









