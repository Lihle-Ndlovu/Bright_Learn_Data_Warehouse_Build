IF OBJECT_ID('brightlearn_etl_db_stg.dbo.stg_dim_customer', 'U') IS NULL


BEGIN
    CREATE TABLE brightlearn_etl_db_stg.dbo.stg_dim_customer2
    (
        CustomerKey INT IDENTITY(1,1) PRIMARY KEY,
        customer_first_name VARCHAR(50),
        customer_last_name VARCHAR(50),
        customer_email VARCHAR(50),
        customer_phone VARCHAR(50),
        customer_province VARCHAR(50),
        customer_city VARCHAR(50),
        CreatedDate DATETIME DEFAULT GETDATE()
    );
END;

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


select * from brightlearn_etl_db_stg.dbo.stg_dim_customer;