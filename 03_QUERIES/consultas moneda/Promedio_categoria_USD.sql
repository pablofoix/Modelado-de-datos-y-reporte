-- Ventas promedio por categoría y método de pago:

Use DW_TiendaOnline

SELECT 
    p.categoria AS Categoria,
    m.nombre_metodo AS Metodo_Pago,
    AVG(f.monto_total) AS Venta_Promedio,
	AVG(f.monto_total / mo.tasa_conversion) as Promedio_USD
FROM Hechos_FactVentas f
JOIN Dim_Productos p ON f.id_producto_dw = p.id_producto_dw
JOIN Dim_MetodoPago m ON f.id_metodo_pago_dw = m.id_metodo_pago_dw
JOIN Dim_Tiempo t 
    ON f.id_tiempo = t.id_tiempo
JOIN Dim_Moneda mo
    ON mo.codigo_moneda = 'USD'
   AND t.id_fecha BETWEEN mo.fecha_inicio AND ISNULL(mo.fecha_fin, GETDATE())
GROUP BY p.categoria, m.nombre_metodo
ORDER BY p.categoria, Venta_Promedio DESC;