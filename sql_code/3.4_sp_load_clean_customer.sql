CREATE OR ALTER PROCEDURE dbo.sp_load_clean_dim_customer
AS
BEGIN
    SET NOCOUNT ON;

    IF OBJECT_ID('brightlearn_etl_db_stg.dbo.clean_dim_customer', 'U') IS NULL
    BEGIN
        CREATE TABLE brightlearn_etl_db_stg.dbo.clean_dim_customer
        (
            CustomerKey INT IDENTITY(1,1) PRIMARY KEY,
            customer_first_name VARCHAR(50),
            customer_last_name  VARCHAR(50),
            customer_email      VARCHAR(50),
            customer_phone      VARCHAR(50),
            customer_province   VARCHAR(50),
            customer_city       VARCHAR(50),
            CreatedDate         DATETIME DEFAULT GETDATE()
        );
    END;

    ;WITH new_customer_CTE AS
    (
        SELECT
            TRIM(customer_first_name) AS customer_first_name,
            TRIM(customer_last_name) AS customer_last_name,
            LOWER(TRIM(customer_email)) AS customer_email,
            TRIM(customer_phone) AS customer_phone,
            TRIM(customer_province) AS customer_province,
            TRIM(customer_city) AS customer_city,

            ROW_NUMBER() OVER
            (
                PARTITION BY LOWER(TRIM(customer_email))
                ORDER BY TRIM(customer_first_name),
                         TRIM(customer_last_name)
            ) AS rn

        FROM brightlearn_etl_db_stg.dbo.stg_dim_customer

        WHERE customer_first_name IS NOT NULL
          AND customer_last_name IS NOT NULL
          AND customer_email IS NOT NULL
          AND customer_phone IS NOT NULL
          AND customer_province IS NOT NULL
          AND customer_city IS NOT NULL
          AND TRIM(customer_first_name) <> ''
          AND TRIM(customer_last_name) <> ''
          AND TRIM(customer_email) <> ''
          AND TRIM(customer_phone) <> ''
          AND TRIM(customer_province) <> ''
          AND TRIM(customer_city) <> ''
    )

    INSERT INTO brightlearn_etl_db_stg.dbo.clean_dim_customer
    (
        customer_first_name,
        customer_last_name,
        customer_email,
        customer_phone,
        customer_province,
        customer_city
    )
    SELECT
        customer_first_name,
        customer_last_name,
        customer_email,
        customer_phone,
        customer_province,
        customer_city
    FROM new_customer_CTE c
    WHERE rn = 1
      AND NOT EXISTS
      (
          SELECT 1
          FROM brightlearn_etl_db_stg.dbo.clean_dim_customer d
          WHERE d.customer_email = c.customer_email
            AND d.customer_first_name = c.customer_first_name
            AND d.customer_last_name = c.customer_last_name
      );

END;
GO

EXEC brightlearn_etl_db_stg.dbo.sp_load_clean_dim_customer;