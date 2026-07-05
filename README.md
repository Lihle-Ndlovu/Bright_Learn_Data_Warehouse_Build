### Bright_Learn_Data_Warehouse_Build
Data warehouse implementation for BrightLearn using SQL Server and SSIS, featuring ETL pipelines, star schema design, dimension and fact tables, and business reporting.

### Project Overview
This project builds a data engineering pipeline for BrightLearn’s retail data. The goal is to extract transaction data from multiple store POS systems, transform and clean the data, and load it into a structured data warehouse for reporting and analytics. The data warehouse uses a star schema with fact and dimension tables to support businessinsights such as sales trends, product performance, customer loyalty analysis, and storeperformance. Tools such as CSV files, SQL Sever, and SSIS are used to perform ETL (Extract,Transform, Load) processes.


### Business Problem
BrightLearn’s transactional data is currently stored in a single flat file exported from the POS systems, with sales, customer, product, and store data mixed. This has created data quality and formatting issues, making it difficult for the Business Intelligence team to generate meaningful reports. As a result, BrightLearn lacks a functional data warehouse, limiting data- driven decision-making on inventory, customer retention, and store performance.

### Solution
To solve this problem, a data engineering pipeline will be implemented to extract sales data from POS systems, clean and transform the raw data, and load it into a structured datawarehouse using a star schema. The warehouse will consist of fact and dimension tables to improve data quality, support efficient querying, and enable business intelligence reporting for better decision-making.

### Data Model
The project follows a **Star Schema Design**:
- **Fact Table: Stores transactional sales business data and links to dimension tables for reporting and analysis.**
   
- **Dimension Tables: Store descriptive data**
#### Dim tables
- **dim_product
- **dim_store
- **dim_customer
- **dim_date
- **dim_supplier
- **dim_employee

### Enabling reporting / analytics
These will allow BI team to build dashboards and they will not limited to one tool Microsoft Power BI but other tools like: Tableau, Microsoft Excel. This answer leadership questions like

- **What were the top 5 best-selling products by total revenue between January and June 2024**
- **What was the total revenue per store, broken down by month, for the January–June 2024 period?**
- **What is the month-over-month revenue growth rate across all stores combined?**
- **Who are the top 10 loyalty customers ranked by total spend over the reporting period?**
- **Which registered loyalty customers have not made a purchase since 28 April 2024? These customers must be flagged for a targeted win-back campaign.**
- **What is the average transaction value broken down by customer loyalty tier (Bronze, Silver, Gold)?**
- **What is the total quantity sold per product category, per store, for the reporting period?**
- **Which store-product combinations**

### ETL Process
-**Extract** data from source files/database  
-**Transform** data using SSIS packages  
-**Load** data into SQL Server data warehouse  

### Tools & Technologies:

- **SQL Server** – Used for database creation and query execution  
- **SSIS (SQL Server Integration Services)** – Used for ETL process (Extract, Transform, Load)  
- **draw.io** – Used for designing the star schema diagram  
- **VS Code** – Used for code editing and project management  


### Project Diagram

###### Output Preview
![Project Diagram])(images/star_schema.png)








