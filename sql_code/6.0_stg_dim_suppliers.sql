IF OBJECT_ID('brightlearn_etl_db_stg.dbo.stg_dim_supplier', 'U') IS NULL
BEGIN
    CREATE TABLE brightlearn_etl_db_stg.dbo.stg_dim_supplier
    (
        supplier_key INT IDENTITY(1,1) PRIMARY KEY,
        supplier VARCHAR(100)
    );
END;

INSERT INTO brightlearn_etl_db_stg.dbo.stg_dim_supplier
(
    supplier
)
SELECT DISTINCT
    supplier
FROM brightlearn_etl_db_stg.dbo.raw_pos_data;

select * FROM brightlearn_etl_db_stg.dbo.stg_dim_supplier