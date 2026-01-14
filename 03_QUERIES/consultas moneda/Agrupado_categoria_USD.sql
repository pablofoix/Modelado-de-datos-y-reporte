USE DW_TiendaOnline;

SELECT 
    p.categoria AS Categoria,
    p.nombre_producto AS Producto,
    SUM(f.cantidad) AS Total_Unidades_Vendidas,
    SUM(f.monto_total) AS Total_Pesos,
    SUM(f.monto_total / m.tasa_conversion) AS Total_Dolares
FROM Hechos_FactVentas f
JOIN Dim_Productos p 
    ON f.id_producto_dw = p.id_producto_dw
JOIN Dim_Tiempo t 
    ON f.id_tiempo = t.id_tiempo
JOIN Dim_Moneda m
    ON m.codigo_moneda = 'USD'
   AND t.id_fecha BETWEEN m.fecha_inicio AND ISNULL(m.fecha_fin, GETDATE())
GROUP BY p.categoria, p.nombre_producto
ORDER BY p.categoria, Total_Unidades_Vendidas DESC;