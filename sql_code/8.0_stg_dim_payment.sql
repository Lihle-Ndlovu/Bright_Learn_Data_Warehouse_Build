


TRUNCATE TABLE brightlearn_etl_db_stg.dbo.stg_dim_payment

IF OBJECT_ID('brightlearn_etl_db_stg.dbo.stg_dim_payment', 'U') IS NULL
BEGIN
    CREATE TABLE brightlearn_etl_db_stg.dbo.stg_dim_payment
    (
        payment_key INT IDENTITY(1,1) PRIMARY KEY,
        payment_method VARCHAR(50)
    );
END;

INSERT INTO brightlearn_etl_db_stg.dbo.stg_dim_payment
(
    payment_method
)
SELECT DISTINCT
    payment_method
FROM brightlearn_etl_db_stg.dbo.raw_pos_data 


--SELECT * FROM brightlearn_etl_db_stg.dbo.stg_dim_payment