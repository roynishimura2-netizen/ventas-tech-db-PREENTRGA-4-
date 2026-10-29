USE Ventas_Tech_DB;
GO
SELECT
    v.fecha_venta,
    c.id_cliente,
    c.nombre AS nombre_cliente,
    c.ciudad,
    p.nombre_producto,
    cat.nombre_categoria,
    v.cantidad,
    v.precio_unitario,
    v.cantidad * v.precio_unitario AS total_venta
FROM dbo.ventas AS v
INNER JOIN dbo.clientes AS c
    ON v.id_cliente = c.id_cliente
INNER JOIN dbo.productos AS p
    ON v.id_producto = p.id_producto
INNER JOIN dbo.categorias AS cat
    ON p.id_categoria = cat.id_categoria
ORDER BY v.fecha_venta;




-- Consulta 2: Clientes sin ventas
-- Propósito: encontrar clientes registrados que nunca compraron.


USE RetailPro;
GO
SELECT
    c.CustomerID,
    c.Nombre,
    c.Email
FROM dbo.Clientes AS c
LEFT JOIN dbo.Ventas AS v
    ON c.CustomerID = v.CustomerID
WHERE v.CustomerID IS NULL;


-- Consulta 3: Productos sin ventas
-- Propósito: detectar productos del catálogo que nunca se vendieron.


USE RetailPro;
GO

SELECT
    p.ProductID,
    p.Nombre_Producto,
    p.PrecioUnitario
FROM dbo.Producto AS p
LEFT JOIN dbo.Ventas AS v
    ON p.ProductID = v.ProductID
WHERE v.ProductID IS NULL;



-- Consulta 4: Consolidado por canal
-- Propósito: comparar el total de ventas de dos períodos.


USE RetailPro;
GO
SELECT
    canal,
    SUM(total) AS total_canal
FROM (
    SELECT
        MontoTotal AS total,
        'Primer semestre' AS canal
    FROM dbo.Ventas
    WHERE MONTH(FechaCompra) <= 6

    UNION ALL

    SELECT
        MontoTotal AS total,
        'Segundo semestre' AS canal
    FROM dbo.Ventas
    WHERE MONTH(FechaCompra) > 6
) AS consolidado
GROUP BY canal;

