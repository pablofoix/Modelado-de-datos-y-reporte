-- Top 5 clientes con mayor monto de compras
-- Objetivo: identificar los clientes más valiosos.
use DW_TiendaOnline
SELECT TOP 5
    c.nombre_cliente + ' ' + c.apellido AS Cliente,
    c.pais AS Pais,
    SUM(f.monto_total) AS Total_Comprado,
    SUM(f.monto_total / m.tasa_conversion) AS Monto_USD
FROM Hechos_FactVentas f
JOIN Dim_Clientes c
	ON f.id_cliente_dw = c.id_cliente_dw
JOIN Dim_Tiempo t
    ON f.id_tiempo = t.id_tiempo
JOIN Dim_Moneda m
    ON m.codigo_moneda = 'USD'
   AND t.id_fecha BETWEEN m.fecha_inicio AND ISNULL(m.fecha_fin, GETDATE())
GROUP BY c.nombre_cliente, c.apellido, c.pais
ORDER BY Monto_USD DESC;