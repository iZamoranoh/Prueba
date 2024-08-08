WITH MonthlySales AS (
    SELECT
        c.country,
        MONTH(s.date_sale) AS mes,
        p.product_name,
        SUM(s.quantity) AS total_quantity
    FROM
        Sale s
    JOIN
        Country c ON s.id_country = c.id_country
    JOIN
        Product p ON s.id_product = p.id_product
    WHERE
        (s.date_sale >= '2023-01-01' AND s.date_sale <= '2023-12-31')
        OR (s.date_sale >= '2024-01-01' AND s.date_sale <= '2024-12-31')
    GROUP BY
        c.country,
        MONTH(s.date_sale),
        p.product_name
),
RankedSales AS (
    SELECT
        country,
        mes,
        product_name,
        total_quantity,
        ROW_NUMBER() OVER (PARTITION BY country, mes ORDER BY total_quantity DESC) AS rank
    FROM
        MonthlySales
)
SELECT
    country,
    mes,
    product_name,
    total_quantity
FROM
    RankedSales
WHERE
    rank = 1
ORDER BY
    country,
    mes;
