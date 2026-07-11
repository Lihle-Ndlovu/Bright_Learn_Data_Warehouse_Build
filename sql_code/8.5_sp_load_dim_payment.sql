CREATE OR ALTER PROCEDURE dbo.sp_load_dim_payment
AS
BEGIN

IF OBJECT_ID('brightlearn_etl_db.dbo.dim_payment', 'U') IS NULL
BEGIN
    CREATE TABLE brightlearn_etl_db.dbo.dim_payment
    (
        payment_key INT IDENTITY(1,1) PRIMARY KEY,
        payment_method VARCHAR(50)
    );
END;

INSERT INTO brightlearn_etl_db.dbo.dim_payment
(
    payment_method
)
SELECT
    r.payment_method
FROM brightlearn_etl_db_stg.dbo.clean_dim_payment r
WHERE NOT EXISTS
(
    SELECT 1
    FROM brightlearn_etl_db.dbo.dim_payment d
    WHERE d.payment_method = r.payment_method
);

END;

EXEC  brightlearn_etl_db.dbo.sp_load_dim_payment;