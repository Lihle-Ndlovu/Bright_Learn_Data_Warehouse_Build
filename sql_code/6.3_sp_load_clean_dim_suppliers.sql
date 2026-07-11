CREATE OR ALTER PROCEDURE dbo.sp_load_clean_dim_supplier
AS
BEGIN

IF OBJECT_ID('brightlearn_etl_db_stg.dbo.clean_dim_supplier', 'U') IS NULL
BEGIN
    CREATE TABLE brightlearn_etl_db_stg.dbo.clean_dim_supplier
    (
        supplier_key INT IDENTITY(1,1) PRIMARY KEY,
        supplier VARCHAR(100)
    );
END;

INSERT INTO brightlearn_etl_db_stg.dbo.clean_dim_supplier
(
    supplier
)
SELECT DISTINCT
    r.supplier
FROM brightlearn_etl_db_stg.dbo.stg_dim_supplier r
WHERE NOT EXISTS
(
    SELECT 1
    FROM brightlearn_etl_db_stg.dbo.clean_dim_supplier d
    WHERE d.supplier = r.supplier
);

END;

EXEC brightlearn_etl_db_stg.dbo.sp_load_clean_dim_supplier;