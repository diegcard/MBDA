
SELECT * FROM pqrs;
SELECT * FROM anexos;

BEGIN
    PA_CLIENTE.AD_PQRS(1, 'No llego el vehiculo', 'Q');
END;


BEGIN 
    PC_PQRS.ad_anexo(1, 'Q202311192121', 'Peticion', 'https://hgfo.pdf');
END;



BEGIN
    PA_ANALISTA_CLIENTES.AD_PqrsRespuesta('Q202311192224', SYSDATE, 'Resuelto con exito', 'Javier', 'JavierFonseca@gexample.com', 'Resuelto', 'Bien');
END;



BEGIN 
    PC_PQRS.ad_anexo(2, 'Q202311192225', 'Peticion', 'https://hsdssdoo.pdf');
END;