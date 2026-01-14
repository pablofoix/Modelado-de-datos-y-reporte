-- Métodos de pago más utilizados
-- Objetivo: entender cómo prefieren pagar los clientes.

Use DW_TiendaOnline

SELECT 
    m.nombre_metodo AS Metodo_Pago,
    COUNT(f.id_hecho) AS Cantidad_Transacciones,
    SUM(f.monto_total) AS Total_Ventas
FROM Hechos_FactVentas f
JOIN Dim_MetodoPago m ON f.id_metodo_pago_dw = m.id_metodo_pago_dw
GROUP BY m.nombre_metodo
ORDER BY Total_Ventas DESC;