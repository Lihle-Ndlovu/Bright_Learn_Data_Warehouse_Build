
CREATE OR ALTER PROCEDURE dbo.Load_DimDate
AS
BEGIN
    SET NOCOUNT ON;

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
END;
GO
EXEC brightlearn_etl_db.dbo.Load_DimDate