-- Consulta para calcular el promedio de cantidad de productos comprados por cliente
WITH CustomerTotalPurchases AS (
    SELECT
        s.id_customer,
        SUM(s.quantity) AS total_quantity
    FROM
        Sale s
    GROUP BY
        s.id_customer
       
),
AverageQuantityPerCustomer AS (
    SELECT
        AVG(total_quantity) AS average_quantity
    FROM
        CustomerTotalPurchases
)
SELECT
    average_quantity
FROM
    AverageQuantityPerCustomer;
