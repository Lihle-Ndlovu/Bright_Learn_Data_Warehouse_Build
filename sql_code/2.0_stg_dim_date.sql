-- 1. CREATE TABLE (only if it doesn't exist)

IF OBJECT_ID('DimDate', 'U') IS NULL

BEGIN

    CREATE TABLE DimDate (

        DateKey INT PRIMARY KEY,

        FullDate DATE NOT NULL,

        DayofMonth INT NOT NULL,

        DayOfWeek VARCHAR(10) NOT NULL,

        MonthOfYear INT NOT NULL,

        MonthName VARCHAR(10) NOT NULL,

        QuarterOfYear INT NOT NULL,

        Year INT NOT NULL,

        IsWeekend BIT NOT NULL

    );

END;

GO


-- 2. DECLARE DATE RANGE

DECLARE @StartDate DATE = '2024-01-01';

DECLARE @EndDate DATE = '2024-12-31';


-- 3. LOOP TO POPULATE TABLE

WHILE @StartDate <= @EndDate

BEGIN

----INSERT EACH DATE

    INSERT INTO DimDate

    (

        DateKey,

        FullDate,

        DayOfMonth,

        DayOfWeek,

        MonthOfYear,

        MonthName,

        QuarterOfYear,

        Year,

        IsWeekend

    )

    VALUES

    (

      CONVERT(INT, FORMAT(@StartDate, 'yyyyMMdd')),

        @StartDate,

        DAY(@StartDate),

        DATENAME(WEEKDAY, @StartDate),

        MONTH(@StartDate),

        DATENAME(MONTH, @StartDate),

        DATEPART(QUARTER, @StartDate),

        YEAR(@StartDate),

        CASE

            WHEN DATENAME(WEEKDAY, @StartDate) IN ('Saturday', 'Sunday') THEN 1

            ELSE 0

        END

    );
    -- MOVE TO NEXT DAY

    SET @StartDate = DATEADD(DAY, 1, @StartDate);

 

END;

GO