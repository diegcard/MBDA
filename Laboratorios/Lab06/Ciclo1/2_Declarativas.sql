
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
