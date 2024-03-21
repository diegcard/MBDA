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