use DW_TiendaOnline;
IF OBJECT_ID('Dim_Moneda', 'U') IS NULL
BEGIN
CREATE TABLE Dim_Moneda (
    id_moneda INT PRIMARY KEY IDENTITY(1,1),
    codigo_moneda VARCHAR(10),
    descripcion VARCHAR(50),
    tasa_conversion DECIMAL(10,2),
    fecha_inicio DATE,
    fecha_fin DATE,
    activo BIT
);
END
