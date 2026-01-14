-- Evolución mensual de las ventas
-- Objetivo: analizar cómo evolucionaron las ventas mes a mes.

Use DW_TiendaOnline

SELECT 
    t.anio AS Año,
    t.mes AS Mes,
    SUM(f.monto_total) AS Total_Ventas,
	ROUND(SUM(f.monto_total / m.tasa_conversion), 2) as Total_USD
FROM Hechos_FactVentas f
JOIN Dim_Tiempo t 
	ON f.id_tiempo = t.id_tiempo
JOIN Dim_Moneda m
ON m.codigo_moneda = 'USD'
   AND t.id_fecha BETWEEN m.fecha_inicio AND ISNULL(m.fecha_fin, GETDATE())
GROUP BY t.anio, t.mes
ORDER BY t.anio, t.mes;