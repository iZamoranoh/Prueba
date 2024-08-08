-- Productos sin ventas en el último trimestre de 2023 y 2024
SELECT 
p.id_product, 
p.product_name, 
p.category
FROM Product p
LEFT JOIN Sale s
    ON p.id_product = s.id_product
    --AND s.date_sale BETWEEN '2023-10-01' AND '2024-03-31'
	and ((s.date_sale BETWEEN '2023-10-01' AND '2023-12-31') OR -- Q4-2023
     (s.date_sale BETWEEN '2024-10-01' AND '2024-12-31')   -- Q4-2024
        )
WHERE s.id_product IS NULL;

-- Clientes sin ventas en el último trimestre de 2023 y 2024
SELECT DISTINCT c.id_customer
FROM Customer c
LEFT JOIN Sale s
    ON c.id_customer = s.id_customer
    --AND s.date_sale BETWEEN '2023-10-01' AND '2024-03-31'
	and ((s.date_sale BETWEEN '2023-10-01' AND '2023-12-31') OR -- Q4-2023
     (s.date_sale BETWEEN '2024-10-01' AND '2024-12-31')   -- Q4-2024
        )
WHERE s.id_customer IS NULL;

-- Contar el número de productos sin ventas en el último trimestre de 2023 y el primer trimestre de 2024
SELECT COUNT(p.id_product) AS CantidadProductosSinVentas
FROM Product p
LEFT JOIN Sale s
    ON p.id_product = s.id_product
    --AND s.date_sale BETWEEN '2023-10-01' AND '2024-03-31'
	and ((s.date_sale BETWEEN '2023-10-01' AND '2023-12-31') OR -- Q4-2023
     (s.date_sale BETWEEN '2024-10-01' AND '2024-12-31')   -- Q4-2024
        )
WHERE s.id_product IS NULL;

-- Contar el número de clientes sin ventas en el último trimestre de 2023 y el primer trimestre de 2024
SELECT COUNT(DISTINCT c.id_customer) AS CantidadClientesSinVentas
FROM Customer c
LEFT JOIN Sale s
    ON c.id_customer = s.id_customer
    --AND s.date_sale BETWEEN '2023-10-01' AND '2024-03-31'
	and ((s.date_sale BETWEEN '2023-10-01' AND '2023-12-31') OR -- Q4-2023
     (s.date_sale BETWEEN '2024-10-01' AND '2024-12-31')   -- Q4-2024
        )
WHERE s.id_customer IS NULL;
