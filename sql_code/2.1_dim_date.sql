USE brightlearn_etl_db;
GO

IF OBJECT_ID('dbo.DimDate', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.DimDate
    (
        DateKey INT PRIMARY KEY,
        FullDate DATE NOT NULL,
        DayofMonth INT NOT NULL,
        DayOfWeek VARCHAR(10) NOT NULL,
        MonthOfYear INT NOT NULL,
        MonthName VARCHAR(10) NOT NULL,
        QuarterOfYear INT NOT NULL,
        [Year] INT NOT NULL,
        IsWeekend BIT NOT NULL
    );
END;

INSERT INTO dbo.DimDate
(
    DateKey,
    FullDate,
    DayofMonth,
    DayOfWeek,
    MonthOfYear,
    MonthName,
    QuarterOfYear,
    [Year],
    IsWeekend
)
SELECT
    s.DateKey,
    s.FullDate,
    s.DayofMonth,
    s.DayOfWeek,
    s.MonthOfYear,
    s.MonthName,
    s.QuarterOfYear,
    s.[Year],
    s.IsWeekend
FROM brightlearn_etl_db_stg.dbo.DimDate s
WHERE NOT EXISTS (
    SELECT 1
    FROM dbo.DimDate d
    WHERE d.DateKey = s.DateKey
);
GO




INSERT INTO brightlearn_etl_db.dbo.DimDate
SELECT *
FROM brightlearn_etl_db_stg.dbo.DimDate;

select * from brightlearn_etl_db.dbo.DimDate
