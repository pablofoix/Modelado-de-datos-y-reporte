-- Total de ventas por país y año
 --Objetivo: conocer cuánto se vendió por país y por año (visión geográfica + temporal).
use DW_TiendaOnline

SELECT 
    c.pais AS Pais,
    t.anio AS Año,
    SUM(f.monto_total) AS Total_Ventas,
	SUM(f.monto_total / m.tasa_conversion) as Total_USD
FROM Hechos_FactVentas f
JOIN Dim_Clientes c ON f.id_cliente_dw = c.id_cliente_dw
JOIN Dim_Tiempo t 
    ON f.id_tiempo = t.id_tiempo
JOIN Dim_Moneda m
    ON m.codigo_moneda = 'USD'
   AND t.id_fecha BETWEEN m.fecha_inicio AND ISNULL(m.fecha_fin, GETDATE())
GROUP BY c.pais, t.anio
ORDER BY t.anio, Total_Ventas DESC;