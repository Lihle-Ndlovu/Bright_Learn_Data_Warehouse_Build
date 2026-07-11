IF OBJECT_ID('brightlearn_etl_db_stg.dbo.stg_dim_location', 'U') IS NULL
BEGIN
    CREATE TABLE brightlearn_etl_db_stg.dbo.stg_dim_location 
    (
        location_key INT IDENTITY(1,1) PRIMARY KEY,
        store_name VARCHAR(100),
        store_region VARCHAR(100),
        store_province VARCHAR(100),
        store_city VARCHAR(100)
    );
END;

INSERT INTO brightlearn_etl_db_stg.dbo.stg_dim_location (
    store_name,
    store_region,
    store_province,
    store_city
)
SELECT DISTINCT
    store_name,
    store_region,
    store_province,
    store_city
FROM brightlearn_etl_db_stg.dbo.raw_pos_data;