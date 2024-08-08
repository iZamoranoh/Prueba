-- Promedio de ventas por región durante el último trimestre de 2023 y 2024
WITH QuarterlySales AS (
    SELECT
    r.continent,
    c.country,
    (YEAR(s.date_sale)) AS sale_year,
	    SUM(s.quantity) AS total_sales
FROM
    Sale s
JOIN
    Country c ON s.id_country = c.id_country
JOIN
    Region r ON s.id_region = r.id_region
WHERE
    (s.date_sale >= '2023-10-01' AND s.date_sale <= '2023-12-31')
    OR (s.date_sale >= '2024-10-01' AND s.date_sale <= '2024-12-31')
GROUP BY
    r.continent,
    c.country,
    (YEAR(s.date_sale))
),
AverageSalesPerRegion AS (
    SELECT
        continent,
        AVG(total_sales) AS average_sales
    FROM
        QuarterlySales
    GROUP BY
        continent
)
SELECT
    continent,
    average_sales
FROM
    AverageSalesPerRegion
ORDER BY
    continent;


	

-- Promedio de ventas por país durante el último trimestre de 2023 y 2024
WITH QuarterlySales AS (
    SELECT
    r.continent,
    c.country,
    (YEAR(s.date_sale)) AS sale_year,
	    SUM(s.quantity) AS total_sales
FROM
    Sale s
JOIN
    Country c ON s.id_country = c.id_country
JOIN
    Region r ON s.id_region = r.id_region
WHERE
    (s.date_sale >= '2023-10-01' AND s.date_sale <= '2023-12-31')
    OR (s.date_sale >= '2024-10-01' AND s.date_sale <= '2024-12-31')
GROUP BY
    r.continent,
    c.country,
    (YEAR(s.date_sale))
),
AverageSalesPerRegion AS (
    SELECT
        country,
        AVG(total_sales) AS average_sales
    FROM
        QuarterlySales
    GROUP BY
        country
)
SELECT
    country,
    average_sales
FROM
    AverageSalesPerRegion
ORDER BY
    country;