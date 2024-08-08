-- Crear la base de datos
 CREATE DATABASE Ventas;

-- Actualizar 
UPDATE Sales_V2
SET continent = CASE
    WHEN country IN ('United Kingdom', 'Germany') THEN 'Europe'
    WHEN country IN ('New Zealand', 'Australia') THEN 'Australia'
    WHEN country IN ('Japan', 'South Korea') THEN 'Asia'
    WHEN country IN ('Mexico', 'Brasil') THEN 'America'
    WHEN country IN ('Egypt') THEN 'Africa'
    ELSE continent -- Para mantener el continente original si no se cumple ninguna condición
END;

UPDATE Sales_V2
SET id_region = CASE
    WHEN continent IN ('Europe') THEN '2'
    WHEN continent IN ('Australia') THEN '5'
    WHEN continent IN ('Asia') THEN '3'
    WHEN continent IN ('America') THEN '1'
    WHEN continent IN ('Africa') THEN '4'
    ELSE id_region -- Para mantener el continente original si no se cumple ninguna condición
END;

USE Ventas;

-- Tabla de Dimensión: Cliente
CREATE TABLE Customer (
    id_customer INT PRIMARY KEY,
);


-- Inserta datos únicos en la tabla de clientes
INSERT INTO customer (id_customer)
SELECT DISTINCT id_customer FROM Sales_V2;


-- Tabla de Dimensión: Región
CREATE TABLE Region (
    id_region INT PRIMARY KEY,
	continent VARCHAR(255) NOT NULL,
);

-- Inserta datos únicos en la tabla de regiones
INSERT INTO region (id_region, continent)
SELECT DISTINCT id_region, continent FROM Sales_V2; 


-- Tabla de Dimensión: País
CREATE TABLE Country (
    id_country INT PRIMARY KEY,
    country VARCHAR(255) NOT NULL,
);

-- Inserta datos únicos en la tabla de status
INSERT INTO country(id_country, country)
SELECT DISTINCT id_country, country FROM Sales_V2; 


-- Tabla de Dimensión: Producto
CREATE TABLE Product (
    id_product INT PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    category VARCHAR(255) NOT NULL
);

-- Inserta datos únicos en la tabla de productos
INSERT INTO product (id_product, product_name, category)
SELECT DISTINCT id_product, product_name, category FROM Sales_V2;

-- Tabla de Dimensión: Estado
CREATE TABLE Status (
    id_status INT PRIMARY KEY,
);

-- Inserta datos únicos en la tabla de status
INSERT INTO status (id_status)
SELECT DISTINCT id_status FROM Sales_V2;

-- Tabla de Hechos: Venta
CREATE TABLE Sale (
    id_sale INT PRIMARY KEY,
    date_sale DATE NOT NULL,
    id_customer INT,
    id_country INT,
    id_region INT,
    id_product INT,
    quantity INT NOT NULL,
    description TEXT,
    id_status INT,
    FOREIGN KEY (id_customer) REFERENCES Customer(id_customer),
    FOREIGN KEY (id_country) REFERENCES Country(id_country),
    FOREIGN KEY (id_region) REFERENCES Region (id_region),
    FOREIGN KEY (id_product) REFERENCES Product(id_product),
    FOREIGN KEY (id_status) REFERENCES Status(id_status)
);

-- Inserta datos en la tabla de ventas
INSERT INTO sale (id_sale, date_sale, id_customer, id_country, id_region, id_product, quantity, description, id_status)
SELECT id_sale, date_sale, id_customer, id_country, id_region, id_product, quantity, description, id_status FROM Sales_V2;

