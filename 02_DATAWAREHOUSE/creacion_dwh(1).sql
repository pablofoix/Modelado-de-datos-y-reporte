IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'DW_TiendaOnline')
BEGIN
CREATE DATABASE DW_TiendaOnline;
END
GO
USE DW_TiendaOnline;
GO
IF OBJECT_ID('Dim_Clientes', 'U') IS NULL
BEGIN
CREATE TABLE Dim_Clientes (
	id_cliente_dw int primary key identity(1,1),
    id_cliente_origen INT ,
    nombre_cliente VARCHAR(50),
    apellido VARCHAR(50),
    email VARCHAR(100),
    pais VARCHAR(50)
);
END

IF OBJECT_ID('Dim_Productos', 'U') IS NULL
BEGIN
CREATE TABLE Dim_Productos (
	id_producto_dw int primary key identity(1,1),
    id_producto_origen INT,
    nombre_producto VARCHAR(100),
    categoria VARCHAR(50),
    marca VARCHAR(50),
    precio DECIMAL(10,2)
);
END

IF OBJECT_ID('Dim_Pedidos', 'U') IS NULL
BEGIN
CREATE TABLE Dim_Pedidos (
	id_pedido_dw int primary key identity(1,1),
    id_pedido_origen INT,
    estado VARCHAR(20),
    direccion VARCHAR(150)
);
END

IF OBJECT_ID('Dim_MetodoPago', 'U') IS NULL
BEGIN
CREATE TABLE Dim_MetodoPago (
	id_metodo_pago_dw int primary key identity(1,1),
    id_metodo_pago_origen INT,
    nombre_metodo VARCHAR(50)
);
END

IF OBJECT_ID('Dim_Tiempo', 'U') IS NULL
BEGIN
CREATE TABLE Dim_Tiempo (
    id_tiempo INT PRIMARY KEY IDENTITY(1,1),
    id_fecha DATE UNIQUE,
    dia INT,
    mes INT,
    trimestre INT,
    semestre INT,
    anio INT
);
END
IF OBJECT_ID('Hechos_FactVentas', 'U') IS NULL
BEGIN
CREATE TABLE Hechos_FactVentas (
    id_hecho INT PRIMARY KEY IDENTITY(1,1),
    id_cliente_dw INT,
    id_producto_dw INT,
    id_pedido_dw  INT,
    id_metodo_pago_dw  INT,
    id_tiempo INT,
    monto_total DECIMAL(12,2),
    cantidad INT,

    FOREIGN KEY (id_cliente_dw ) REFERENCES Dim_Clientes(id_cliente_dw ),
    FOREIGN KEY (id_producto_dw ) REFERENCES Dim_Productos(id_producto_dw),
    FOREIGN KEY (id_pedido_dw ) REFERENCES Dim_Pedidos(id_pedido_dw),
    FOREIGN KEY (id_metodo_pago_dw ) REFERENCES Dim_MetodoPago(id_metodo_pago_dw),
    FOREIGN KEY (id_tiempo) REFERENCES Dim_Tiempo(id_tiempo)
);
END