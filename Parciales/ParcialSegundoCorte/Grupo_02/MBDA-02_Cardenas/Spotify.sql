/*Parcial MBDA Grupo-2 2023-2*/
--Relizado por Diego Cardenas
--1000093114
/*------------------Tablas------------------*/
-- Verde
CREATE TABLE Canciones(
    nombre VARCHAR2(50) NOT NULL,
    duracion NUMBER(10) NOT NULL,
    fechaCreacion DATE NULL,
    idBiblioteca NUMBER(11) NOT NULL
);

CREATE TABLE Bibliotecas(
    id NUMBER(11) NOT NULL,
    nombre VARCHAR2(50) NOT NULL,
    numDoc NUMBER(15) NOT NULL,
    tipoDoc VARCHAR2(10) NOT NULL
);

CREATE TABLE Episodios(
    titulo VARCHAR2(50) NOT NULL,
    descripcion VARCHAR2(100) NULL,
    idBiblioteca NUMBER(11) NOT NULL
);

-- Amarillo
CREATE TABLE Clientes(
    numDoc NUMBER(15) NOT NULL,
    tipoDoc VARCHAR2(10) NOT NULL,
    nombreApellido VARCHAR2(200) NOT NULL,
    correoElectronico VARCHAR2(50) NOT NULL
);

CREATE TABLE OyentesPagos(
    numDoc NUMBER(15) NOT NULL,
    tipoDoc VARCHAR2(10) NOT NULL,
    direccion VARCHAR(100) NOT NULL,
    celular VARCHAR2(10) NOT NULL,
    numMesesNoNotif NUMBER(10) NOT NULL
);

CREATE TABLE TajetasOyentesPagos(
    numDoc NUMBER(15) NOT NULL,
    tipoDoc VARCHAR2(10) NOT NULL,
    numeroTarjeta VARCHAR2(20) NOT NULL
);

CREATE TABLE OyentesGratuitos(
    numDoc NUMBER(15) NOT NULL,
    tipoDoc VARCHAR2(10) NOT NULL,
    academia VARCHAR(200) NOT NULL
);

-- Rosado 
CREATE TABLE Facturas(
    idFactura NUMBER(11) NOT NULL,
    numDoc NUMBER(15) NOT NULL,
    tipoDoc VARCHAR2(10) NOT NULL,
    fecha DATE NOT NULL,
    montoSuscripcion NUMBER(5,2) NOT NULL,
    montoPagar NUMBER(5,2) NOT NULL,
    url VARCHAR(50) NOT NULL,
    estado CHAR(1) NOT NULL
);

CREATE TABLE BonosPromocionales(
    iniciativa VARCHAR2(3) NOT NULL,
    porcentaje NUMBER(2,2) NOT NULL,
    mensaje VARCHAR(100) NULL, 
    nunDoc NUMBER(15) NOT NULL,
    tipoDoc VARCHAR2(10) NOT NULL
); 

CREATE TABLE NotificacionesIncumplimientos(
    id NUMBER(11) NOT NULL,
    fechaTransaccion DATE NOT NULL,
    tarjetaCredito VARCHAR2(20) NOT NULL,
    monto NUMBER(5,2) NOT NULL,
    descripcion VARCHAR2(100) NOT NULL,
    idFactura NUMBER(11) NOT NULL,

);


/*------------------XTablas------------------*/
DROP TABLE Canciones;
DROP TABLE Bibliotecas;
DROP TABLE Episodios;
DROP TABLE Clientes;
DROP TABLE OyentesPagos;
DROP TABLE TajetasOyentesPagos;
DROP TABLE OyentesGratuitos;
DROP TABLE Facturas;
DROP TABLE BonosPromocionales;
DROP TABLE NotificacionesIncumplimientos;

/*------------------Atributos------------------*/
/*Mantener Cobros*/

--Primary Keys
ALTER TABLE Facturas ADD CONSTRAINT PK_Facturas PRIMARY KEY(idFactura);
ALTER TABLE BonosPromocionales ADD CONSTRAINT PK_BonosPromocionales PRIMARY KEY(iniciativa);
ALTER TABLE NotificacionesIncumplimientos ADD CONSTRAINT PK_NotificacionesIncumplimientos PRIMARY KEY(id);

ALTER TABLE Clientes ADD CONSTRAINT PK_Clientes PRIMARY KEY(numDoc, tipoDoc);
ALTER TABLE OyentesPagos ADD CONSTRAINT PK_OyentesPagos PRIMARY KEY(numDoc, tipoDoc);
ALTER TABLE OyentesGratuitos ADD CONSTRAINT PK_OyentesGratuitos PRIMARY KEY(numDoc, tipoDoc);


--Unique Keys 

ALTER TABLE Clientes ADD CONSTRAINT UQ_Clientes_correoElectronico UNIQUE(correoElectronico);
ALTER TABLE Facturas ADD CONSTRAINT UQ_Facuras_url UNIQUE(url);


--Checks

ALTER TABLE Factura ADD CONSTRAINT CK_Factura_estado CHECK(estado IN('A', 'R', 'P'));

--Foreign Keys
ALTER TABLE NotificacionesIncumplimientos ADD CONSTRAINT FK_NotificacionesIncumplimientos_Facturas FOREIGN KEY(idFactura) REFERENCES Facturas(idFactura);
ALTER TABLE Facturas ADD CONSTRAINT FK_Facturas_OyentesPagos FOREIGN KEY(numDoc, tipoDoc) REFERENCES OyentesPagos(numDoc, tipoDoc);

ALTER TABLE OyentesPagos ADD CONSTRAINT FK_OyentesPagos_Clientes FOREIGN KEY(numDoc, tipoDoc) REFERENCES Clientes(numDoc, tipoDoc);
ALTER TABLE OyentesGratuitos ADD CONSTRAINT FK_OyentesGratuitos_Clientes FOREIGN KEY(numDoc, tipoDoc) REFERENCES Clientes(numDoc, tipoDoc);



/*------------------xAtributos------------------*/
ALTER TABLE Facturas DROP CONSTRAINT PK_Facturas;
ALTER TABLE Facturas DROP CONSTRAINT PK_BonosPromocionales;
ALTER TABLE Facturas DROP CONSTRAINT PK_NotificacionesIncumplimientos;


/*-------Disparadores--------*/


CREATE OR REPLACE TRIGGER PK_NotificacionesIncumplimientos_MO_BE
BEFORE UPDATE ON NotificacionesIncumplimientos
FOR EACH ROW
BEGIN
    IF :OLD.descripcion IS NOT NULL AND :NEW.descripcion IS NOT NULL AND (
        :OLD.id <> :NEW.id OR
        :OLD.fechaTransaccion <> :NEW.kind OR
        :OLD.tarjetaCredito <> :NEW.tarjetaCredito OR
        :OLD.monto <> :NEW.monto OR
        :OLD.idFactura <> :NEW.idFactura
    ) THEN
        RAISE_APPLICATION_ERROR(-20001, 'Solo se permite modificar la columna "descripcion".');
    END IF;
END;
/


CREATE OR REPLACE TRIGGER PK_BonosPromocionales_MO_BE
BEFORE UPDATE ON NotificacionesIncumplimientos
FOR EACH ROW
BEGIN
    IF :OLD.mensaje IS NOT NULL AND :NEW.mensaje IS NOT NULL AND (
        :OLD.iniciativa <> :NEW.iniciativa OR
        :OLD.porcentaje <> :NEW.porcentaje OR
        :OLD.nunDoc <> :NEW.nunDoc OR
        :OLD.tipoDoc <> :NEW.tipoDoc
    ) THEN
        RAISE_APPLICATION_ERROR(-20002, 'Solo se permite modificar la columna "descripcion".');
    END IF;
END;
/

/*-------XDisparadores--------*/

DROP TRIGGER PK_NotificacionesIncumplimientos_MO_BE;
DROP TRIGGER PK_BonosPromocionales_MO_BE;
