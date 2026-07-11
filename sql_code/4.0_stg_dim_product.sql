IF OBJECT_ID('brightlearn_etl_db_stg.dbo.stg_dim_product', 'U') IS NULL

BEGIN
    CREATE TABLE brightlearn_etl_db_stg.dbo.stg_dim_product
    (
        product_key INT IDENTITY(1,1) PRIMARY KEY,
        sku VARCHAR(50),
        product_name VARCHAR(100),
        category VARCHAR(50),
        sub_category VARCHAR(50)
    );
END;

INSERT INTO brightlearn_etl_db_stg.dbo.stg_dim_product
(
    sku,
    product_name,
    category,
    sub_category
)
SELECT DISTINCT
    sku,
    product_name,
    category,
    sub_category
FROM brightlearn_etl_db_stg.dbo.raw_pos_data;