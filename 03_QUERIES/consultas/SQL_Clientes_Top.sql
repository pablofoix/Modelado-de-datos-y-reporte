-- Top 5 clientes con mayor monto de compras
-- Objetivo: identificar los clientes más valiosos.
use DW_TiendaOnline
SELECT TOP 5
    c.nombre_cliente + ' ' + c.apellido AS Cliente,
    c.pais AS Pais,
    SUM(f.monto_total) AS Total_Comprado
FROM Hechos_FactVentas f
JOIN Dim_Clientes c ON f.id_cliente_dw = c.id_cliente_dw
GROUP BY c.nombre_cliente, c.apellido, c.pais
ORDER BY Total_Comprado DESC;