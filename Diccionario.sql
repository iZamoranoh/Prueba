-- Consulta única para obtener información detallada sobre las columnas de las tablas especificadas
WITH ColumnDetails AS (
    SELECT 
        c.TABLE_NAME AS [Table Name],
        c.ORDINAL_POSITION AS [Column Number],
        c.COLUMN_NAME AS [Column Name],
        c.DATA_TYPE AS [Data Type],
        c.CHARACTER_MAXIMUM_LENGTH AS [Max Length],
        c.IS_NULLABLE AS [Nullable],
        ISNULL(
            CASE 
                WHEN pk.COLUMN_NAME IS NOT NULL THEN 'PRIMARY KEY'
                WHEN fk.COLUMN_NAME IS NOT NULL THEN 'FOREIGN KEY'
                ELSE 'NONE'
            END, 'NONE') AS [Key Type],
        c.COLUMN_DEFAULT AS [Default Value],
        ep.value AS [Description]
    FROM 
        INFORMATION_SCHEMA.COLUMNS c
        LEFT JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE pk 
            ON c.TABLE_NAME = pk.TABLE_NAME 
            AND c.COLUMN_NAME = pk.COLUMN_NAME
            AND pk.CONSTRAINT_NAME LIKE '%PK%'
        LEFT JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE fk 
            ON c.TABLE_NAME = fk.TABLE_NAME 
            AND c.COLUMN_NAME = fk.COLUMN_NAME
            AND fk.CONSTRAINT_NAME LIKE '%FK%'
        LEFT JOIN sys.extended_properties ep 
            ON OBJECT_ID(c.TABLE_SCHEMA + '.' + c.TABLE_NAME) = ep.major_id
            AND ep.minor_id = c.ORDINAL_POSITION
            AND ep.name = 'MS_Description'
    WHERE 
        c.TABLE_NAME IN ('Country', 'Customer', 'Product', 'Region', 'Sale', 'Sales_v2', 'Status')
)
SELECT 
    [Table Name],
    [Column Number],
    [Column Name],
    [Data Type],
    [Key Type],
    [Description]
FROM 
    ColumnDetails
ORDER BY 
    [Table Name], [Column Number];


