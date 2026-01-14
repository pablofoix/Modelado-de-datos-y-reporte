USE DW_TiendaOnline;
GO

-- Peso Argentino
IF NOT EXISTS (
    SELECT 1 FROM Dim_Moneda
    WHERE codigo_moneda = 'ARS'
      AND fecha_inicio = '2022-01-01'
)
BEGIN
    INSERT INTO Dim_Moneda (codigo_moneda, descripcion, tasa_conversion, fecha_inicio, fecha_fin, activo)
    VALUES ('ARS', 'Peso Argentino', 1.0000, '2022-01-01', NULL, 1);
END;
GO

-- Dólar Estadounidense
IF NOT EXISTS (
    SELECT 1 FROM Dim_Moneda
    WHERE codigo_moneda = 'USD'
      AND fecha_inicio = '2022-01-01'
)
BEGIN
    INSERT INTO Dim_Moneda (codigo_moneda, descripcion, tasa_conversion, fecha_inicio, fecha_fin, activo)
    VALUES
    ('USD', 'Dólar Estadounidense', 900.00, '2022-01-01', '2023-02-28', 0),
    ('USD', 'Dólar Estadounidense', 1000.00, '2023-03-01', '2024-04-30', 0),
    ('USD', 'Dólar Estadounidense', 1100.00, '2024-05-01', '2024-12-31', 0),
    ('USD', 'Dólar Estadounidense', 1200.00, '2025-01-01', NULL, 1);
END;
GO

-- Euro
IF NOT EXISTS (
    SELECT 1 FROM Dim_Moneda
    WHERE codigo_moneda = 'EUR'
      AND fecha_inicio = '2022-01-01'
)
BEGIN
    INSERT INTO Dim_Moneda (codigo_moneda, descripcion, tasa_conversion, fecha_inicio, fecha_fin, activo)
    VALUES
    ('EUR', 'Euro', 1350.00, '2022-01-01', NULL, 1);
END;
GO
