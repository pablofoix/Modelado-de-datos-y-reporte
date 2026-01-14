-- Evolución mensual de las ventas
-- Objetivo: analizar cómo evolucionaron las ventas mes a mes.

Use DW_TiendaOnline

SELECT 
    t.anio AS Año,
    t.mes AS Mes,
    SUM(f.monto_total) AS Total_Ventas
FROM Hechos_FactVentas f
JOIN Dim_Tiempo t ON f.id_tiempo = t.id_tiempo
GROUP BY t.anio, t.mes
ORDER BY t.anio, t.mes;