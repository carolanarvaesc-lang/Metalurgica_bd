-- 1. Crear la base de datos
CREATE DATABASE IF NOT EXISTS Metalurgica_BD;
USE Metalurgica_BD;

-- 2. Tabla Clientes: sirve para identificar quien realiza los pedidos
CREATE TABLE IF NOT EXISTS Clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    tipo_documento VARCHAR(20) NOT NULL,
    n_documento VARCHAR(20) UNIQUE NOT NULL
);

-- 3. Tabla Pedidos: contiene los datos generales de cada pedido, es la entidad que organiza las ventas
CREATE TABLE IF NOT EXISTS Pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    fecha DATE NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente)
);

-- 4. Tabla Marcas: identifica las lineas de negocio de la empresa
CREATE TABLE IF NOT EXISTS Marcas (
    id_marca INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE
);

-- 5. Tabla Productos: contiene el catalogo de los productos, permite controlar inventarios y costos de produccion
CREATE TABLE IF NOT EXISTS Productos (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    categoria VARCHAR(50) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    id_marca INT,
    FOREIGN KEY (id_marca) REFERENCES Marcas(id_marca)
);

-- 6. Tabla Detalle_Pedidos: tabla intermedia que vincula los pedidos con los productos y la cantidad de unidades, permite manejar pedidos con varios productos
CREATE TABLE IF NOT EXISTS Detalle_Pedidos (
    id_detalle INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES Pedidos(id_pedido),
    FOREIGN KEY (id_producto) REFERENCES Productos(id_producto)
);

-- 7. Tabla Insumos: registra los materiales necesarios para la produccion de los productos finales, permite controlar inventarios y costos de produccion
CREATE TABLE IF NOT EXISTS Insumos (
    id_insumo INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    costo_unitario DECIMAL(10,2) NOT NULL
);

-- 8. Tabla Produccion: relaciona productos con insumos, indicando cuantos materiales se usan para fabricar cada producto, es clave para la trazabilidad de la produccion
CREATE TABLE IF NOT EXISTS Produccion (
    id_produccion INT AUTO_INCREMENT PRIMARY KEY,
    id_producto INT NOT NULL,
    id_insumo INT NOT NULL,
    cantidad INT NOT NULL,
    FOREIGN KEY (id_producto) REFERENCES Productos(id_producto),
    FOREIGN KEY (id_insumo) REFERENCES Insumos(id_insumo)
);

-- 9. Tabla Proveedores: almacena informacion de las empresas que subministran insumos, facilita la gestion de compras y relaciones comerciales
CREATE TABLE IF NOT EXISTS Proveedores (
    id_proveedor INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    contacto VARCHAR(150),
    id_producto INT NOT NULL,
    FOREIGN KEY (id_producto) REFERENCES Productos(id_producto)
);

-- 10. Tabla Costos: calcula el costo total de cada producto, es fundamental para el analisis financiero
CREATE TABLE IF NOT EXISTS Costos (
    id_costo INT AUTO_INCREMENT PRIMARY KEY,
    id_producto INT NOT NULL,
    costo_total DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_producto) REFERENCES Productos(id_producto)
);