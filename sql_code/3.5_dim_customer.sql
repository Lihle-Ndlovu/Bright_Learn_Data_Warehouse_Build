
IF OBJECT_ID('brightlearn_etl_db.dbo.dim_customer', 'U') IS NULL
BEGIN
    CREATE TABLE brightlearn_etl_db.dbo.dim_customer
    (
        CustomerKey INT IDENTITY(1,1) PRIMARY KEY,
        customer_first_name VARCHAR(50),
        customer_last_name  VARCHAR(50),
        customer_email      VARCHAR(50),
        customer_phone      VARCHAR(50),
        CreatedDate         DATETIME DEFAULT GETDATE()
    );
END;

;WITH new_customer_CTE AS
(
    SELECT
        TRIM(customer_first_name) AS customer_first_name,
        TRIM(customer_last_name)  AS customer_last_name,
        LOWER(TRIM(customer_email)) AS customer_email,
        TRIM(customer_phone) AS customer_phone,

        ROW_NUMBER() OVER
        (
            PARTITION BY LOWER(TRIM(customer_email))
            ORDER BY TRIM(customer_first_name), TRIM(customer_last_name)
        ) AS rn

    FROM brightlearn_etl_db_stg.dbo.clean_dim_customer

    WHERE customer_first_name IS NOT NULL
      AND customer_last_name  IS NOT NULL
      AND customer_email      IS NOT NULL
      AND customer_phone      IS NOT NULL
      AND TRIM(customer_first_name) <> ''
      AND TRIM(customer_last_name)  <> ''
      AND TRIM(customer_email)      <> ''
      AND TRIM(customer_phone)      <> ''
)

INSERT INTO brightlearn_etl_db.dbo.dim_customer
(
    customer_first_name,
    customer_last_name,
    customer_email,
    customer_phone
)
SELECT
    customer_first_name,
    customer_last_name,
    customer_email,
    customer_phone
FROM new_customer_CTE
WHERE rn = 1
AND NOT EXISTS
(
    SELECT 1
    FROM brightlearn_etl_db.dbo.dim_customer d
    WHERE d.customer_email = new_customer_CTE.customer_email
      AND d.customer_first_name = new_customer_CTE.customer_first_name
      AND d.customer_last_name = new_customer_CTE.customer_last_name
);

