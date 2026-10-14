USE Ventas_Tech_DB;
GO

SELECT TOP 5 *
FROM ventas;

SELECT
    MONTH(fecha_venta) AS mes,
    SUM(cantidad * precio_unitario) AS total_facturado,
    COUNT(*) AS cantidad_pedidos,
    AVG(cantidad * precio_unitario) AS ticket_promedio
FROM ventas
GROUP BY MONTH(fecha_venta);



SELECT TOP 5 
 id_producto,
 SUM(cantidad) AS Unidadesvendidas,
 SUM(cantidad * precio_unitario) AS Total_Facturado 
 FROM dbo.ventas
GROUP BY id_producto
ORDER BY Total_Facturado DESC


SELECT
    id_cliente,
    COUNT(*) AS cantidad_pedidos,
    SUM(cantidad * precio_unitario) AS Total_Gastado 
FROM dbo.ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1;



SELECT
    MONTH(fecha_venta) AS mes,
    SUM(cantidad * precio_unitario) AS total_facturado,
    CASE
        WHEN SUM(cantidad * precio_unitario) > (
            SELECT AVG(total_facturado)
            FROM (
                SELECT
                    MONTH(fecha_venta) AS mes,
                    SUM(cantidad * precio_unitario) AS total_facturado
                FROM dbo.ventas
                GROUP BY MONTH(fecha_venta)
            ) AS resumen_mensual
        ) THEN 'Por encima'
        WHEN SUM(cantidad * precio_unitario) < (
            SELECT AVG(total_facturado)
            FROM (
                SELECT
                    MONTH(fecha_venta) AS mes,
                    SUM(cantidad * precio_unitario) AS total_facturado
                FROM dbo.ventas
                GROUP BY MONTH(fecha_venta)
            ) AS resumen_mensual
        ) THEN 'Por debajo'
        ELSE 'Igual al promedio'
    END AS comparacion
FROM dbo.ventas
GROUP BY MONTH(fecha_venta)
ORDER BY mes;

