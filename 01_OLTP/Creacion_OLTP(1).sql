IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'TiendaOnline')
BEGIN
CREATE DATABASE TiendaOnline;
END
GO
USE TiendaOnline;
GO
IF OBJECT_ID('Clientes', 'U') IS NULL
BEGIN
CREATE TABLE Clientes (
    id_cliente INT PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    pais VARCHAR(50)
);
END

IF OBJECT_ID('Direcciones', 'U') IS NULL
BEGIN
CREATE TABLE Direcciones (
    id_direccion INT PRIMARY KEY IDENTITY(1,1),
    id_cliente INT NOT NULL,
    direccion_linea VARCHAR(150),
    ciudad VARCHAR(100),
    pais VARCHAR(50),
    tipo_direccion VARCHAR(20) CHECK (tipo_direccion IN ('envio','facturacion')),

    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente)
);
END

IF OBJECT_ID('Productos', 'U') IS NULL
BEGIN
CREATE TABLE Productos (
    id_producto INT PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(100) NOT NULL,
    categoria VARCHAR(50),
    marca VARCHAR(50),
    precio DECIMAL(10,2) NOT NULL
);
END

IF OBJECT_ID('Pedidos', 'U') IS NULL
BEGIN
CREATE TABLE Pedidos (
    id_pedido INT PRIMARY KEY IDENTITY(1,1),
    id_cliente INT NOT NULL,
    id_direccion INT,
    fecha_pedido DATE NOT NULL,
    monto_total DECIMAL(12,2),
    estado VARCHAR(20) CHECK (estado IN ('Pendiente','Enviado','Completado','Cancelado')),

    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente),
    FOREIGN KEY (id_direccion) REFERENCES Direcciones(id_direccion)
);
END

IF OBJECT_ID('Detalle_Pedidos', 'U') IS NULL
BEGIN
CREATE TABLE Detalle_Pedidos (
    id_detalle INT PRIMARY KEY IDENTITY(1,1),
    id_pedido INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL CHECK (cantidad > 0),
    precio_unitario DECIMAL(10,2) NOT NULL,

    FOREIGN KEY (id_pedido) REFERENCES Pedidos(id_pedido),
    FOREIGN KEY (id_producto) REFERENCES Productos(id_producto)
);
END

IF OBJECT_ID('Metodo_Pago', 'U') IS NULL
BEGIN
CREATE TABLE Metodo_Pago (
    id_metodo_pago INT PRIMARY KEY IDENTITY(1,1),
    nombre_metodo VARCHAR(50) NOT NULL -- Ej: Tarjeta de Crédito, Transferencia, PayPal
);
END

IF OBJECT_ID('Pagos', 'U') IS NULL
BEGIN
CREATE TABLE Pagos (
    id_pago INT PRIMARY KEY IDENTITY(1,1),
    id_pedido INT NOT NULL,
    id_metodo_pago INT NOT NULL,
    fecha_pago DATE NOT NULL,
    monto DECIMAL(12,2) NOT NULL,

    FOREIGN KEY (id_pedido) REFERENCES Pedidos(id_pedido),
    FOREIGN KEY (id_metodo_pago) REFERENCES Metodo_Pago(id_metodo_pago)
);
END