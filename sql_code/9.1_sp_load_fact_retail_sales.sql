CREATE OR ALTER PROCEDURE dbo.spload_fact_retail_sales
AS
BEGIN

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

    INNER JOIN brightlearn_etl_db.dbo.dim_customer c
        ON r.customer_email = c.customer_email

    INNER JOIN brightlearn_etl_db.dbo.dim_product p
        ON r.sku = p.sku

    INNER JOIN brightlearn_etl_db.dbo.DimDate d
        ON TRY_CONVERT(date, r.transaction_date) = d.FullDate

    INNER JOIN brightlearn_etl_db.dbo.dim_supplier s
        ON r.supplier = s.supplier

    INNER JOIN brightlearn_etl_db.dbo.dim_employee e
        ON r.cashier_name = e.cashier_name

    INNER JOIN brightlearn_etl_db.dbo.dim_location l
        ON r.store_city = l.store_city
       AND r.store_province = l.store_province

    INNER JOIN brightlearn_etl_db.dbo.dim_payment pay
        ON r.payment_method = pay.payment_method

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

END;
GO

EXEC brightlearn_etl_db.dbo.sp_load_fact_retail_sales


