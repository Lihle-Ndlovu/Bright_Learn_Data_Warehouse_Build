
IF OBJECT_ID('brightlearn_etl_db.dbo.dim_product', 'U') IS NULL
BEGIN
    CREATE TABLE brightlearn_etl_db.dbo.dim_product
    (
        product_key INT IDENTITY(1,1) PRIMARY KEY,
        sku VARCHAR(50),
        product_name VARCHAR(100),
        category VARCHAR(50),
        sub_category VARCHAR(50)
    );
END;

;WITH new_product_CTE AS
(
    SELECT
        sku,
        product_name,
        category,
        sub_category,

        ROW_NUMBER() OVER(PARTITION BY sku ORDER BY product_name ) AS rn

    FROM brightlearn_etl_db_stg.dbo.clean_dim_product

  WHERE sku IS NOT NULL
  AND product_name IS NOT NULL
  AND category IS NOT NULL
  AND sub_category IS NOT NULL
  AND category <> ''
)

INSERT INTO brightlearn_etl_db.dbo.dim_product
(
    sku,
    product_name,
    category,
    sub_category
)
SELECT
    sku,
    product_name,
    category,
    sub_category
FROM new_product_CTE
WHERE rn = 1


AND NOT EXISTS
(
    SELECT 1
    FROM brightlearn_etl_db.dbo.dim_product d
    WHERE d.sku = new_product_CTE.sku
);


