IF OBJECT_ID('brightlearn_etl_db.dbo.fact_retail_sales', 'U') IS NULL
CREATE TABLE brightlearn_etl_db.dbo.fact_retail_sales
(
    SalesKey INT IDENTITY(1,1) PRIMARY KEY,
    CustomerKey INT NOT NULL,
    ProductKey INT NOT NULL,
    DateKey INT NOT NULL,
    SupplierKey INT NOT NULL,
    EmployeeKey INT NOT NULL,
    LocationKey INT NOT NULL,
    PaymentKey INT NOT NULL,
    UnitPrice DECIMAL(18,2),
    CostPrice DECIMAL(18,2),
    Qty INT,
    LineAmount DECIMAL(18,2),
    StockOnHand INT,
    TransactionAmount DECIMAL(18,2),
    TransactionDiscount DECIMAL(18,2),
    ReorderThreshold INT,
    CreatedDate DATETIME DEFAULT GETDATE(),
    

CONSTRAINT FK_fact_retail_sales_Customer FOREIGN KEY (CustomerKey) REFERENCES dbo.dim_customer(Customerkey),
CONSTRAINT FK_fact_retail_sales_Product FOREIGN KEY (ProductKey) REFERENCES dbo.dim_product(product_key),
CONSTRAINT FK_fact_retail_sales_Date FOREIGN KEY (DateKey) REFERENCES dbo.DimDate(DateKey),
CONSTRAINT FK_fact_retail_sales_Supplier FOREIGN KEY (SupplierKey) REFERENCES dbo.dim_supplier(supplier_key),
CONSTRAINT FK_fact_retail_sales_Employee FOREIGN KEY (EmployeeKey) REFERENCES dbo.dim_employee(employee_key),
CONSTRAINT FK_fact_retail_sales_Location FOREIGN KEY (LocationKey) REFERENCES dbo.dim_location(location_key),
CONSTRAINT FK_fact_retail_sales_Payment FOREIGN KEY (PaymentKey) REFERENCES dbo.dim_payment(payment_key)
 );

INSERT INTO brightlearn_etl_db.dbo.fact_retail_sales
(
    CustomerKey,
    ProductKey,
    DateKey,
    SupplierKey,
    EmployeeKey,
    LocationKey,
    PaymentKey,
    UnitPrice,
    CostPrice,
    Qty,
    LineAmount,
    StockOnHand,
    TransactionAmount,
    TransactionDiscount,
    ReorderThreshold
)
SELECT
    c.CustomerKey,
    p.product_key,
    d.DateKey,
    s.supplier_key,
    e.employee_key,
    l.location_key,
    pay.payment_key,
    r.unit_price,
    r.cost_price,
    r.qty,
    r.line_amount,
    r.stock_on_hand,
    r.transaction_amount,
    r.transaction_discount,
    r.reorder_threshold

FROM brightlearn_etl_db_stg.dbo.raw_pos_data r

INNER JOIN brightlearn_etl_db.dbo.dim_customer c ON r.customer_email = c.customer_email

INNER JOIN brightlearn_etl_db.dbo.dim_product p ON r.sku = p.sku

INNER JOIN brightlearn_etl_db.dbo.DimDate d ON TRY_CONVERT(date, r.transaction_date) = d.FullDate

INNER JOIN brightlearn_etl_db.dbo.dim_supplier s ON r.supplier = s.supplier

INNER JOIN brightlearn_etl_db.dbo.dim_employee e ON r.cashier_name = e.cashier_name

INNER JOIN brightlearn_etl_db.dbo.dim_location l ON r.store_city = l.store_city
   AND r.store_province = l.store_province

INNER JOIN brightlearn_etl_db.dbo.dim_payment pay ON r.payment_method = pay.payment_method

WHERE NOT EXISTS
    (
    SELECT 1
    FROM brightlearn_etl_db.dbo.fact_retail_sales f
    WHERE f.CustomerKey = c.CustomerKey
      AND f.ProductKey = p.product_key
      AND f.DateKey = d.DateKey
      AND f.SupplierKey = s.supplier_key
      AND f.EmployeeKey = e.employee_key
      AND f.LocationKey = l.location_key
     AND f.PaymentKey = pay.payment_key
);

---SELECT * FROM brightlearn_etl_db.dbo.fact_retail_sales

----TRUNCATE TABLE brightlearn_etl_db.dbo.fact_retail_sales

