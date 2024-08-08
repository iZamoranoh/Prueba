WITH MonthlySales AS (
    SELECT
        c.country,
        MONTH(s.date_sale) AS mes,
        p.id_customer,
        SUM(s.quantity) AS total_quantity
    FROM
        Sale s
    JOIN
        Country c ON s.id_country = c.id_country
    JOIN
        Customer p ON s.id_customer = p.id_customer
    WHERE
        (s.date_sale >= '2023-01-01' AND s.date_sale <= '2023-12-31')
        OR (s.date_sale >= '2024-01-01' AND s.date_sale <= '2024-12-31')
    GROUP BY
        c.country,
        MONTH(s.date_sale),
        p.id_customer
),
RankedSales AS (
    SELECT
        country,
        mes,
        id_customer,
        total_quantity,
        ROW_NUMBER() OVER (PARTITION BY country, mes ORDER BY total_quantity DESC) AS rank
    FROM
        MonthlySales
)
SELECT
    country,
    mes,
    id_customer,
    total_quantity
FROM
    RankedSales
WHERE
    rank = 1
ORDER BY
    country,
    mes;
