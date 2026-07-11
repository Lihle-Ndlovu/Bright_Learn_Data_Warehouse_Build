IF DB_ID('brightlearn_etl_db_stg') IS NULL
BEGIN
    CREATE DATABASE brightlearn_etl_db_stg;
END;
GO


IF DB_ID('brightlearn_etl_db') IS NULL
BEGIN
    CREATE DATABASE brightlearn_etl_db;
END;
GO