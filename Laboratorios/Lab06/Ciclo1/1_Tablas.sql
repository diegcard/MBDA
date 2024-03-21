
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
