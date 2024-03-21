ALTER TABLE solicitudes DROP CONSTRAINT fk_solicitudes_idCliente;
ALTER TABLE solicitudes ADD CONSTRAINT fk_solicitudes_idCliente FOREIGN KEY (idCliente) REFERENCES clientes(idCliente) ON DELETE CASCADE;
/*---XRestricciones---*/
ALTER TABLE pqrs DROP CONSTRAINT fk_pqrs_codigoSolicitud;
ALTER TABLE anexos DROP CONSTRAINT fk_anexos_idTicked;
/*---Acciones---*/
ALTER TABLE pqrs ADD CONSTRAINT fk_pqrs_codigoSolicitud FOREIGN KEY (codigoSolicitud) REFERENCES solicitudes(codigo) ON DELETE CASCADE;
ALTER TABLE anexos ADD CONSTRAINT fk_anexos_idTicked FOREIGN KEY(idTicked) REFERENCES pqrs(ticked) ON DELETE CASCADE;
