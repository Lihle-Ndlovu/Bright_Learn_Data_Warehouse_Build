CREATE OR ALTER PROCEDURE dbo.sp_load_stg_dim_customer
AS
BEGIN

    INSERT INTO brightlearn_etl_db_stg.dbo.stg_dim_customer
(
    customer_first_name,
    customer_last_name,
    customer_email,
    customer_phone,
    customer_province,
    customer_city
)
SELECT DISTINCT
       customer_first_name,
      customer_last_name,
      customer_email,
      customer_phone,
      customer_province,
      customer_city

FROM brightlearn_etl_db_stg.dbo.raw_pos_data;

END;


EXEC dbo.sp_load_stg_dim_customer;


EXEC brightlearn_etl_db_stg.dbo.sp_load_stg_dim_customer;