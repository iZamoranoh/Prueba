WITH SalesData AS (
    SELECT 
        s.date_sale,
        s.quantity,
        p.product_name,
        p.category,
        r.continent
    FROM 
        Sale s
    JOIN 
        Product p ON s.id_product = p.id_product
    JOIN 
       Region r ON s.id_region = r.id_region
    WHERE 
        p.product_name LIKE '%Nike%' AND 
        (
            (s.date_sale >= '2023-07-01' AND s.date_sale <= '2023-09-30') OR -- Q3-2023
            (s.date_sale >= '2024-01-01' AND s.date_sale <= '2024-03-31')   -- Q1-2024
        )
)

SELECT 
    continent,
    SUM(quantity) AS total_quantity
FROM 
    SalesData
GROUP BY 
    continent
ORDER BY 
    continent, total_quantity DESC;
