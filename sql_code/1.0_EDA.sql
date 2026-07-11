-----EDA
--Understand the data (quality checks)
--Analyze the business (patterns and insights)

1.---View the data
SELECT * FROM brightlearn_etl_db_stg.dbo.raw_pos_data;


2.---Count the number of records
SELECT COUNT(*) AS TotalRows
FROM brightlearn_etl_db_stg.dbo.raw_pos_data

-- checking important colums
3.----transaction_date
 ----used to Identify daily, weekly, monthly, and yearly sales trends. Detect seasonality and peak shopping periods.

SELECT COUNT(*) AS null_dates
FROM brightlearn_etl_db_stg.dbo.raw_pos_data
WHERE transaction_date IS NULL;

---inspecting patterns like yyyy-MM-dd or dd/MM/yyyy
SELECT TOP 50 transaction_date
FROM brightlearn_etl_db_stg.dbo.raw_pos_data
ORDER BY transaction_date;


4.--transaction_amount 
 -----Calculate total revenue,Detect unusually high or low transactions. 
SELECT TOP 50 transaction_amount
FROM brightlearn_etl_db_stg.dbo.raw_pos_data;

SELECT COUNT(*) AS null_transaction_amount
FROM brightlearn_etl_db_stg.dbo.raw_pos_data
WHERE transaction_amount IS NULL;

5.---transaction_discount
---Measure average discount, frequency of discounts, and their impact on revenue.

---Check NULLs
SELECT COUNT(*) AS null_discounts
FROM brightlearn_etl_db_stg.dbo.raw_pos_data
WHERE transaction_discount IS NULL;

5.--product_name          | 
---Identify best-selling and least-selling products 

--Check NULLs
SELECT COUNT(*) AS null_products
FROM brightlearn_etl_db_stg.dbo.raw_pos_data
WHERE product_name IS NULL;

---Distinct Categories
SELECT COUNT(DISTINCT product_name) AS unique_products
FROM brightlearn_etl_db_stg.dbo.raw_pos_data;

---Most Sold Products
SELECT product_name,
COUNT(*) AS sales
FROM brightlearn_etl_db_stg.dbo.raw_pos_data
GROUP BY product_name
ORDER BY sales DESC;
 

6.--category            
--Compare sales across product categories.
-----Check NULLs
SELECT COUNT(*) AS null_categories
FROM [brightlearn_etl_db_stg].[dbo].[raw_pos_data]
WHERE category IS NULL;

---Distinct Categories
SELECT COUNT(DISTINCT category) AS unique_categories
FROM brightlearn_etl_db_stg.dbo.raw_pos_data;


 
7.---qty  
---Analyze quantity sold per transaction and identify fast-moving products. 
----Check NULLs
SELECT COUNT(*) AS null_qty
FROM brightlearn_etl_db_stg.dbo.raw_pos_data
WHERE qty IS NULL;


8.--unit_price        
---Examine price distribution and identify premium versus budget products.

--Check NULLs
SELECT COUNT(*) AS null_unit_price
FROM brightlearn_etl_db_stg.dbo.raw_pos_data
WHERE unit_price IS NULL;
 

9.--cost_price            
--Compare costs across products and categories. 

--Check NULLs
SELECT COUNT(*) AS null_cost_price
FROM brightlearn_etl_db_stg.dbo.raw_pos_data
WHERE cost_price IS NULL;

                                                                                         
10.---store_name
--Compare revenue, transaction volume, and average sales across stores.  

--Check NULLs
SELECT COUNT(*) AS null_store
FROM brightlearn_etl_db_stg.dbo.raw_pos_data
WHERE store_name IS NULL;

--Number of Stores
SELECT COUNT(DISTINCT store_name) AS total_stores
FROM brightlearn_etl_db_stg.dbo.raw_pos_data

--Transactions by Store
SELECT store_name,
COUNT(*) transactions
FROM brightlearn_etl_db_stg.dbo.raw_pos_data
GROUP BY store_name
ORDER BY transactions DESC;


11.--store_region`         
--Analyze regional sales differences and customer demand.                                                                 

--Check NULLs
SELECT COUNT(*) AS null_region
FROM brightlearn_etl_db_stg.dbo.raw_pos_data
WHERE store_region IS NULL;

--Regions
SELECT DISTINCT store_region
FROM brightlearn_etl_db_stg.dbo.raw_pos_data

--Transactions per Region
SELECT 
    store_region,
    COUNT(*) AS total_transactions
FROM brightlearn_etl_db_stg.dbo.raw_pos_data
GROUP BY store_region
ORDER BY total_transactions DESC;


