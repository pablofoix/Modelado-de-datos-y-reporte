USE DW_TiendaOnline;
GO

UPDATE d
SET 
    d.activo = 0,
    d.fecha_fin = GETDATE()
FROM DW_TiendaOnline.dbo.Dim_Clientes d
INNER JOIN TiendaOnline.dbo.Clientes o
    ON d.id_cliente_origen = o.id_cliente
WHERE 
    d.activo = 1
    AND (
        ISNULL(d.pais, '') <> ISNULL(o.pais, '')
    );

-- Paso 2: Insertar los nuevos registros (versiones actualizadas)
INSERT INTO Dim_Clientes (id_cliente_origen, nombre_cliente, apellido, email, pais, fecha_inicio, fecha_fin, activo)
SELECT 
    o.id_cliente,
    o.nombre,
	o.apellido,
	o.email,
    o.pais,
    GETDATE() AS fecha_inicio,
    NULL AS fecha_fin,
    1 AS activo
FROM TiendaOnline.dbo.Clientes o
LEFT JOIN DW_TiendaOnline.dbo.Dim_Clientes d
    ON o.id_cliente = d.id_cliente_origen
   AND d.activo = 1
WHERE 
    -- Insertar solo si no existe una versión activa
    d.id_cliente_origen IS NULL
    OR ISNULL(d.pais, '') <> ISNULL(o.pais, '');