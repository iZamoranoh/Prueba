-- Total de ventas
DECLARE @TotalVentas INT;
-- Ventas devueltas o canceladas
DECLARE @VentasAfectadas INT;

-- Obtener el total de ventas
SELECT @TotalVentas = COUNT(*)
FROM Sale;

-- Obtener el total de ventas afectadas (devueltas o canceladas)
SELECT @VentasAfectadas = COUNT(*)
FROM Sale
WHERE id_status IN ('1004', '1005'); -- Cambia estos valores según cómo esté representado el estado en tu base de datos

-- Calcular el porcentaje de ventas afectadas
SELECT 
    @VentasAfectadas * 100.0 / @TotalVentas AS PorcentajeVentasAfectadas;

