USE DW_TiendaOnline;
GO

ALTER TABLE dbo.Dim_Clientes
ADD 
    fecha_inicio DATETIME2 NULL,
    fecha_fin    DATETIME2 NULL,
    activo       BIT NULL
GO
UPDATE dbo.Dim_Clientes
SET 
    fecha_inicio = '2022-01-01', 
    fecha_fin = NULL, 
    activo = 1
WHERE fecha_inicio IS NULL;
GO