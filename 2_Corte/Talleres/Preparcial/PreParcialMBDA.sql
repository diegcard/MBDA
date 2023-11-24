
/*
Realizado por 
Jeimmy Yaya
Juan Ortiz 
Diego Cardenas
Paula Paez
*/

/*---------------------------------------------CICLO 1: Tablas---------------------------------------------*/

CREATE TABLE Empresas(
    nit NUMBER(11) NOT NULL,
    correoElectronico VARCHAR2(50) NOT NULL,
    nombre VARCHAR2(50) NOT NULL,
    representanteLegal VARCHAR(50) NOT NULL
);

CREATE TABLE Clientes(
    nitEmpresa NUMBER(11) NOT NULL,
    tipoIdentificacionInterno CHAR(3) NOT NULL,
    numeroIdentificacionInterno VARCHAR2(20) NOT NULL,
    sector VARCHAR2(50) NOT NULL
);

CREATE TABLE Proveedores(
    nitEmpresa NUMBER(11) NOT NULL,
    anioExperiencia NUMBER(11) NULL
);

CREATE TABLE Oportunidades(
    codigo VARCHAR2(11) NOT NULL,
    nitEmpresa NUMBER(11) NOT NULL,
    nombre VARCHAR2(50) NOT NULL, 
    descripcionCorta VARCHAR(100) NOT NULL,
    presupuesto NUMBER(20) NOT NULL,
    responsable VARCHAR2(50) NOT NULL,
    enlaceDocumentacion VARCHAR(50) NULL
);

CREATE TABLE Propuestas(
    version VARCHAR2(50) NOT NULL, 
    oportunidadCodigo VARCHAR2(10) NOT NULL,
    fecha DATE NOT NULL,
    costo FLOAT(20) NOT NULL,
    enlace VARCHAR2(50) NOT NULL,
    estado CHAR(2) NOT NULL,
    revision NUMBER(10)
);

CREATE TABLE PropuestasRevisiones(
    propuestaVersion NUMBER(11) NOT NULL,
    revision VARCHAR2(100) NOT NULL
);

CREATE TABLE Proyectos(
    codigo VARCHAR2(10) NOT NULL,
    versionPropuesta VARCHAR2(20) NOT NULL,
    nombre VARCHAR2(50) NOT NULL,
    fechaInicio DATE NOT NULL,
    fechaFin DATE NOT NULL,
    presupuesto FLOAT(10) NOT NULL,
    margen FLOAT(10) NOT NULL, 
    duracion FLOAT(10) NOT NULL
);

CREATE TABLE sonAsignados(
    tipoIdentificacionProfesional CHAR(3) NOT NULL,
    numeroIdentificacionProfesional VARCHAR2(20) NOT NULL,
    proyectoCodigo VARCHAR2(10) NOT NULL,
    fechaInicio Date NOT NULL,
    fechaFin DATE NOT NULL,
    porcentaje FLOAT(100) NOT NULL 
);

CREATE TABLE Profesionales(
    tipoIdentificacion CHAR(3) NOT NULL,
    numeroIdentificacion VARCHAR2(20) NOT NULL,
    nombre VARCHAR2(50) NOT NULL,
    correoElectronico VARCHAR(50) NOT NULL,
    fechaIngreso DATE NOT NULL
);

CREATE TABLE Internos(
    tipoIdentificacionProfesional CHAR(3) NOT NULL,
    numeroIdentificacionProfesional VARCHAR2(20) NOT NULL,
    esLider CHAR(1) NOT NULL
);

CREATE TABLE Externos(
    nitEmpresa VARCHAR2(20) NOT NULL,
    tipoIdentificacionProfesional CHAR(3) NOT NULL,
    numeroIdentificacionProfesional NUMBER(20) NOT NULL
);

/*---------------------------------------------CICLO 1: XTablas---------------------------------------------*/

DROP TABLE Empresas CASCADE CONSTRAINTS;
DROP TABLE Clientes CASCADE CONSTRAINTS;
DROP TABLE Proveedores CASCADE CONSTRAINTS;
DROP TABLE Oportunidades CASCADE CONSTRAINTS;
DROP TABLE Propuestas CASCADE CONSTRAINTS;
DROP TABLE PropuestasRevisiones CASCADE CONSTRAINTS;
DROP TABLE Proyectos CASCADE CONSTRAINTS;
DROP TABLE esAsignados CASCADE CONSTRAINTS;
DROP TABLE Profesionales CASCADE CONSTRAINTS;
DROP TABLE Internos CASCADE CONSTRAINTS;
DROP TABLE Externos CASCADE CONSTRAINTS;


/*---------------------------------------------CICLO 1: Atributos---------------------------------------------*/
/*------------Restricciones CHECK para la tabla Propuestas------------*/
ALTER TABLE Propuestas ADD CONSTRAINT CK_Propuestas_estado CHECK(estado IN('Pr', 'Ap', 'Rc'));
/*------------Restricciones CHECK para la tabla Oportunidades------------*/
ALTER TABLE Oportunidades ADD CONSTRAINT CK_Oportunidades_TCodigo CHECK(REGEXP_LIKE(codigo, '^TM-\d{7}$'));
/*------------Restricciones CHECK para la tabla Proyectos------------*/
ALTER TABLE Proyectos ADD CONSTRAINT CK_Proyectos_Fecha_Fin_Inicico CHECK(fechaFin > fechaInicio);
/*------------Restricciones CHECK para la tabla Clientes------------*/
ALTER TABLE Empresas ADD CONSTRAINT CK_Clientes_Correo CHECK(REGEXP_LIKE(correoElectronico, '.*@tailormade\.com$'));


/*-----------------------------------------------CICLO 1: Tablas-----------------------------------------------*/
-- Primary Keys
ALTER TABLE Empresas ADD CONSTRAINT Pk_Empresas PRIMARY KEY(nit);
ALTER TABLE Clientes ADD CONSTRAINT Pk_Clientes PRIMARY KEY(nitEmpresa, tipoIdentificacionInterno, numeroIdentificacionInterno);
ALTER TABLE Proveedores ADD CONSTRAINT Pk_Proveedores PRIMARY KEY(nitEmpresa);
ALTER TABLE Oportunidades ADD CONSTRAINT Pk_Oportunidades PRIMARY KEY(codigo);
ALTER TABLE Propuestas ADD CONSTRAINT Pk_Propuestas PRIMARY KEY(version);
ALTER TABLE PropuestasRevisiones ADD CONSTRAINT Pk_PropuestasRevisiones PRIMARY KEY(propuestaVersion, revision);
ALTER TABLE Proyectos ADD CONSTRAINT Pk_Proyectos PRIMARY KEY(codigo);
ALTER TABLE sonAsignados ADD CONSTRAINT Pk_sonAsignados PRIMARY KEY(tipoIdentificacionProfesional, numeroIdentificacionProfesional, proyectoCodigo);
ALTER TABLE Profesionales ADD CONSTRAINT Pk_Profesionales PRIMARY KEY(tipoIdentificacion, numeroIdentificacion);
ALTER TABLE Internos ADD CONSTRAINT Pk_Internos PRIMARY KEY(tipoIdentificacion, numeroIdentificacion);
ALTER TABLE Externos ADD CONSTRAINT Pk_Externos PRIMARY KEY(nitEmpresa, tipoIdentificacion, numeroIdentificacion);

--Unique Keys
ALTER TABLE Profesionales ADD CONSTRAINT UK_Profesionales_correoElectronico UNIQUE(correoElectronico);
ALTER TABLE Empresas ADD CONSTRAINT UK_Empresas_correoElectronico UNIQUE(correoElectronico);

--Foreing Keys
ALTER TABLE Oportunidades ADD CONSTRAINT FK_Oportunidades_Empresas_nit FOREIGN KEY(nitEmpresa) REFERENCES Empresas(nit);
ALTER TABLE Propuestas ADD CONSTRAINT FK_OportunidCodigo_propuesta FOREIGN KEY(oportunidadCodigo) REFERENCES Oportunidades(codigo) ON DELETE OR UPDATE CASCADE;
ALTER TABLE Proyectos ADD CONSTRAINT FK_Proyectos_Propuesta FOREIGN KEY(oportunidadCodigo) REFERENCES Propuestas(version);

ALTER TABLE sonAsignados ADD CONSTRAINT FK_sonAsigandos_proyectoCodigo FOREIGN(proyectoCodigo) REFERENCES Proyetos(codigo);
ALTER TABLE sonAsignados ADD CONSTRAINT FK_sonAsigandos_tipo_numero FOREIGN(tipoIdentificacionProfesional, numeroIdentificacionProfesional) REFERENCES Profesionales(tipoIdentificacion, numeroIdentificacion);

ALTER TABLE Externos ADD CONSTRAINT FK_Externos_Profesionales_Proovedores FOREIGN KEY(nitEmpresa) REFERENCES Proovedores(nitEmpresa);
ALTER TABLE Externos ADD CONSTRAINT FK_Externos_Profesionales_tipoIdentificacionProfesional FOREIGN KEY(tipoIdentificacionProfesional) REFERENCES Profesionales(tipoIdentificacion);
ALTER TABLE Externos ADD CONSTRAINT FK_Externos_Profesionales_numeroIdentificacion FOREIGN KEY(numeroIdentificacionProfesional) REFERENCES Profesionales(numeroIdentificacion);
ALTER TABLE Internos ADD CONSTRAINT FK_Internos_Profesionales_tipoIdentificacionProfesional FOREIGN KEY(tipoIdentificacionProfesional) REFERENCES Profesionales(tipoIdentificacion);
ALTER TABLE Internos ADD CONSTRAINT FK_Internos_Profesionales_numeroIdentificacion FOREIGN KEY(numeroIdentificacionProfesional) REFERENCES Profesionales(numeroIdentificacion)

ALTER TABLE Clientes ADD CONSTRAINT FK_Clientes_empresa FOREIGN KEY(nitEmpresa) REFERENCES Empresa(nit);
ALTER TABLE Clientes ADD CONSTRAINT FK_Clientes_Internos_tipoIdentificacionInterno FOREIGN KEY(tipoIdentificacionInterno) REFERENCES Internos(tipoIdentificacionProfesional);
ALTER TABLE Clientes ADD CONSTRAINT FK_Clientes_Internos_numeroIdentificacionInterno FOREIGN KEY(numeroIdentificacionInterno) REFERENCES Internos(numeroIdentificacionProfesional);
ALTER TABLE Proovedores ADD CONSTRAINT FK_Proovedores_Empresas FOREIGN KEY(nitEmpresa) REFERENCES Empresa(nit);


/*Disparadores*/
/*----Modificar----*/

CREATE OR REPLACE TRIGGER TR_PROYECTO_BI
BEFORE INSERT ON Proyectos
FOR EACH ROW
BEGIN
    -- Verificar que los datos mínimos estén presentes
    IF :NEW.codigo IS NULL OR :NEW.versionPropuesta IS NULL OR :NEW.nombre IS NULL THEN
        RAISE_APPLICATION_ERROR(-20001, 'Se requieren datos mínimos para agregar un proyecto.');
    END IF;
    
    -- Calcular la fecha inicial como la fecha actual más 15 días
    :NEW.fechaInicio := SYSDATE + 15;
END;
/
CREATE OR REPLACE TRIGGER TR_PROPUESTA_BI
BEFORE INSERT ON Proyectos
FOR EACH ROW
BEGIN
    -- Verificar que la propuesta asociada esté aprobada
    IF :NEW.versionPropuesta IS NOT NULL THEN
        SELECT estado INTO :NEW.estadoPropuesta
        FROM Propuestas
        WHERE version = :NEW.versionPropuesta;
        
        IF :NEW.estadoPropuesta <> 'Ap' THEN
            RAISE_APPLICATION_ERROR(-20002, 'La propuesta asociada no está aprobada (\'Ap\').');
        END IF;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER TR_FECHA_INICIAL_BI
BEFORE INSERT ON Proyectos
FOR EACH ROW
BEGIN
    -- Establecer la fecha inicial como la fecha actual más 15 días
    :NEW.fechaInicio := SYSDATE + 15;
END;
/

CREATE OR REPLACE TRIGGER TR_PROFESIONAL_BI
BEFORE INSERT ON sonAsignados
FOR EACH ROW
BEGIN
    -- Verificar si el profesional está asignado como profesional comercial al cliente
    SELECT COUNT(*) INTO :NEW.cuenta
    FROM Clientes C
    WHERE C.nitEmpresa = :NEW.tipoIdentificacionProfesional
    AND EXISTS (
        SELECT 1
        FROM sonAsignados S
        WHERE S.tipoIdentificacionProfesional = :NEW.tipoIdentificacionProfesional
        AND S.numeroIdentificacionProfesional = :NEW.numeroIdentificacionProfesional
    );
    
    IF :NEW.cuenta > 0 THEN
        RAISE_APPLICATION_ERROR(-20003, 'El profesional está asignado como profesional comercial al cliente.');
    END IF;
END;
/
