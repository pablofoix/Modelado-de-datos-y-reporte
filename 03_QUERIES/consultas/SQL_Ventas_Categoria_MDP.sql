-- Ventas promedio por categoría y método de pago:

Use DW_TiendaOnline

SELECT 
    p.categoria AS Categoria,
    m.nombre_metodo AS Metodo_Pago,
    AVG(f.monto_total) AS Venta_Promedio
FROM Hechos_FactVentas f
JOIN Dim_Productos p ON f.id_producto_dw = p.id_producto_dw
JOIN Dim_MetodoPago m ON f.id_metodo_pago_dw = m.id_metodo_pago_dw
GROUP BY p.categoria, m.nombre_metodo
ORDER BY p.categoria, Venta_Promedio DESC;