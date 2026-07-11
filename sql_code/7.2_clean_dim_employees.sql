
TRUNCATE TABLE brightlearn_etl_db_stg.dbo.clean_dim_employee;
IF OBJECT_ID('brightlearn_etl_db_stg.dbo.clean_dim_employee', 'U') IS NULL
BEGIN
    CREATE TABLE brightlearn_etl_db_stg.dbo.clean_dim_employee
    (
        employee_key INT IDENTITY(1,1) PRIMARY KEY,
        store_manager VARCHAR(100),
        cashier_name  VARCHAR(100)
    );
END;

INSERT INTO brightlearn_etl_db_stg.dbo.clean_dim_employee
(
    store_manager,
    cashier_name
)
SELECT
    r.store_manager,
    r.cashier_name
FROM brightlearn_etl_db_stg.dbo.stg_dim_employee r
WHERE NOT EXISTS
(
    SELECT 1
    FROM brightlearn_etl_db_stg.dbo.clean_dim_employee d
    WHERE d.store_manager = r.store_manager
      AND d.cashier_name  = r.cashier_name
);

select * from brightlearn_etl_db_stg.dbo.clean_dim_employee