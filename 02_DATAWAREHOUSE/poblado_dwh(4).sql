USE DW_TiendaOnline;

INSERT INTO Dim_Clientes (id_cliente_origen, nombre_cliente, apellido, email, pais)
SELECT 
    c.id_cliente,
    c.nombre,
    c.apellido,
    c.email,
    c.pais
FROM TiendaOnline.dbo.Clientes c
LEFT JOIN DW_TiendaOnline.dbo.Dim_Clientes d
    ON c.id_cliente = d.id_cliente_origen
WHERE d.id_cliente_origen IS NULL;

INSERT INTO Dim_Productos (id_producto_origen, nombre_producto, categoria, marca, precio)
SELECT 
    p.id_producto,
    p.nombre,
    p.categoria,
    p.marca,
    p.precio
FROM TiendaOnline.dbo.Productos p
LEFT JOIN DW_TiendaOnline.dbo.Dim_Productos d
    ON p.id_producto = d.id_producto_origen
WHERE d.id_producto_origen IS NULL; 

INSERT INTO Dim_Pedidos (id_pedido_origen, estado, direccion)
SELECT 
    p.id_pedido,
    p.estado,
    d.direccion_linea
FROM TiendaOnline.dbo.Pedidos p
LEFT JOIN TiendaOnline.dbo.Direcciones d
    ON p.id_direccion = d.id_direccion
LEFT JOIN DW_TiendaOnline.dbo.Dim_Pedidos dp
    ON p.id_pedido = dp.id_pedido_origen
WHERE dp.id_pedido_origen IS NULL; 

INSERT INTO Dim_MetodoPago (id_metodo_pago_origen, nombre_metodo)
SELECT 
    mp.id_metodo_pago,
    mp.nombre_metodo
FROM TiendaOnline.dbo.Metodo_Pago mp
LEFT JOIN DW_TiendaOnline.dbo.Dim_MetodoPago d
    ON mp.id_metodo_pago = d.id_metodo_pago_origen
WHERE d.id_metodo_pago_origen IS NULL; 

INSERT INTO Dim_Tiempo (id_fecha, dia, mes, trimestre, semestre, anio)
SELECT DISTINCT 
    p.fecha_pedido,
    DAY(p.fecha_pedido),
    MONTH(p.fecha_pedido),
    DATEPART(QUARTER, p.fecha_pedido),
    CASE WHEN MONTH(p.fecha_pedido) <= 6 THEN 1 ELSE 2 END,
    YEAR(p.fecha_pedido)
FROM TiendaOnline.dbo.Pedidos p
LEFT JOIN DW_TiendaOnline.dbo.Dim_Tiempo t
    ON p.fecha_pedido = t.id_fecha
WHERE t.id_fecha IS NULL;

INSERT INTO Hechos_FactVentas
    (id_cliente_dw, id_producto_dw, id_pedido_dw, id_metodo_pago_dw, id_tiempo, monto_total, cantidad)
SELECT
    c_dw.id_cliente_dw,
    pr_dw.id_producto_dw,
    ped_dw.id_pedido_dw,
    mp_dw.id_metodo_pago_dw,
    t.id_tiempo,
    dp.cantidad * pr_dw.precio AS monto_total,
    dp.cantidad
FROM TiendaOnline.dbo.Detalle_Pedidos dp
JOIN TiendaOnline.dbo.Pedidos p
    ON dp.id_pedido = p.id_pedido
JOIN TiendaOnline.dbo.Clientes c
    ON p.id_cliente = c.id_cliente
JOIN TiendaOnline.dbo.Pagos pa
    ON pa.id_pedido = p.id_pedido
JOIN TiendaOnline.dbo.Productos pr
    ON dp.id_producto = pr.id_producto
JOIN DW_TiendaOnline.dbo.Dim_Clientes c_dw
    ON c.id_cliente = c_dw.id_cliente_origen
JOIN DW_TiendaOnline.dbo.Dim_Productos pr_dw
    ON pr.id_producto = pr_dw.id_producto_origen
JOIN DW_TiendaOnline.dbo.Dim_Pedidos ped_dw
    ON p.id_pedido = ped_dw.id_pedido_origen
JOIN DW_TiendaOnline.dbo.Dim_MetodoPago mp_dw
    ON pa.id_metodo_pago = mp_dw.id_metodo_pago_origen
JOIN DW_TiendaOnline.dbo.Dim_Tiempo t
    ON p.fecha_pedido = t.id_fecha
LEFT JOIN DW_TiendaOnline.dbo.Hechos_FactVentas hv
    ON hv.id_pedido_dw = ped_dw.id_pedido_dw
WHERE hv.id_pedido_dw IS NULL;