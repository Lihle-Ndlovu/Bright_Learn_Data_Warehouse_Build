CREATE OR ALTER PROCEDURE dbo.sp_load_clean_dim_location
AS
BEGIN

IF OBJECT_ID('brightlearn_etl_db_stg.dbo.clean_dim_location', 'U') IS NULL
BEGIN
    CREATE TABLE brightlearn_etl_db_stg.dbo.clean_dim_location (
        location_key INT IDENTITY(1,1) PRIMARY KEY,
        store_name VARCHAR(100),
        store_region VARCHAR(100),
        store_province VARCHAR(100),
        store_city VARCHAR(100)
    );
END;

INSERT INTO brightlearn_etl_db_stg.dbo.clean_dim_location (
    store_name,
    store_region,
    store_province,
    store_city
)
SELECT DISTINCT
    s.store_name,
    s.store_region,
    s.store_province,
    s.store_city
FROM brightlearn_etl_db_stg.dbo.stg_dim_location s
WHERE NOT EXISTS (
    SELECT 1
    FROM brightlearn_etl_db_stg.dbo.clean_dim_location d
    WHERE d.store_name = s.store_name
      AND d.store_region = s.store_region
      AND d.store_province = s.store_province
      AND d.store_city = s.store_city
);

End;

EXEC brightlearn_etl_db_stg.dbo.sp_load_clean_dim_location;