-- Consulta para encontrar el cliente con más compras durante el último trimestre de 2023 y 2024
WITH CustomerPurchases AS (
    SELECT
        s.id_customer,
        COUNT(s.id_sale) AS total_purchases
    FROM
        Sale s
    WHERE
        (s.date_sale >= '2023-10-01' AND s.date_sale <= '2023-12-31')
        OR (s.date_sale >= '2024-10-01' AND s.date_sale <= '2024-12-31')
    GROUP BY
        s.id_customer
),
RankedCustomers AS (
    SELECT
        id_customer,
        total_purchases,
        ROW_NUMBER() OVER (ORDER BY total_purchases DESC) AS rank
    FROM
        CustomerPurchases
)
SELECT
    id_customer,
    total_purchases
FROM
    RankedCustomers
WHERE
    rank = 1
ORDER BY
    id_customer;
