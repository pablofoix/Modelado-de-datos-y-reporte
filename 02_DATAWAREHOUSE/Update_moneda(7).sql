use DW_TiendaOnline;
-- Actualizar la tasa del dólar en Dim_Moneda (Tipo 2)
BEGIN TRANSACTION;

-- Paso 1: Cerrar el registro anterior
UPDATE Dim_Moneda
SET activo = 0,
    fecha_fin = GETDATE()
WHERE codigo_moneda = 'USD' AND activo = 1;

-- Paso 2: Insertar el nuevo registro con la nueva tasa
INSERT INTO Dim_Moneda (codigo_moneda, descripcion, tasa_conversion, fecha_inicio, activo)
VALUES ('USD', 'Dólar estadounidense', 1050.00, GETDATE(), 1);

COMMIT TRANSACTION;
