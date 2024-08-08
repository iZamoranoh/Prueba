-- Consulta para encontrar el producto más vendido durante el último trimestre de 2023 y 2024
WITH QuarterlySales AS (
    SELECT
        p.product_name,
        SUM(s.quantity) AS total_quantity
    FROM
        Sale s
    JOIN
        Product p ON s.id_product = p.id_product
    WHERE
        (s.date_sale >= '2023-10-01' AND s.date_sale <= '2023-12-31')
        OR (s.date_sale >= '2024-10-01' AND s.date_sale <= '2024-12-31')
    GROUP BY
        p.product_name
),
RankedProducts AS (
    SELECT
        product_name,
        total_quantity,
        ROW_NUMBER() OVER (ORDER BY total_quantity DESC) AS rank
    FROM
        QuarterlySales
)
SELECT
    product_name,
    total_quantity
FROM
    RankedProducts
WHERE
    rank = 1
ORDER BY
    product_name;
