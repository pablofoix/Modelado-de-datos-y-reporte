-- Productos más vendidos por categoría
-- Objetivo: identificar los productos con mayor cantidad vendida dentro de cada categoría.
Use DW_TiendaOnline

SELECT 
    p.categoria AS Categoria,
    p.nombre_producto AS Producto,
    SUM(f.cantidad) AS Total_Unidades_Vendidas
FROM Hechos_FactVentas f
JOIN Dim_Productos p ON f.id_producto_dw = p.id_producto_dw
GROUP BY p.categoria, p.nombre_producto
ORDER BY p.categoria, Total_Unidades_Vendidas DESC;