-- Consulta para analizar las ventas en función del día de la semana usando números
WITH SalesByDayOfWeek AS (
    SELECT
        DATEPART(WEEKDAY, s.date_sale) AS day_of_week,
        SUM(s.quantity) AS total_sales
    FROM
        Sale s
    GROUP BY
        DATEPART(WEEKDAY, s.date_sale)
)
SELECT
    CASE 
        WHEN day_of_week = 1 THEN 'Sunday'
        WHEN day_of_week = 2 THEN 'Monday'
        WHEN day_of_week = 3 THEN 'Tuesday'
        WHEN day_of_week = 4 THEN 'Wednesday'
        WHEN day_of_week = 5 THEN 'Thursday'
        WHEN day_of_week = 6 THEN 'Friday'
        WHEN day_of_week = 7 THEN 'Saturday'
    END AS day_name,
    total_sales
FROM
    SalesByDayOfWeek
ORDER BY
    day_of_week;
