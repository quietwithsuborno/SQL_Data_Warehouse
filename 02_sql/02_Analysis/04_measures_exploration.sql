/*
===============================================================================
MEASURES EXPLORATION
===============================================================================
Purpose: 
    - To calculate high-level business metrics (KPIs).
    - To verify the total volume of sales, orders, and customer activity.
    - To generate a consolidated report of all key business measures.
*/

-- 1. Sales & Quantity Metrics
-------------------------------------------------------------------------------
-- Find the total revenue and total items sold
SELECT 
    SUM(sales_amount) AS total_sales,
    SUM(quantity) AS total_quantity,
    AVG(price) AS avg_price
FROM gold.fact_sales;


-- 2. Order & Product Volume
-------------------------------------------------------------------------------
-- Find the total number of orders (including unique order counts)
SELECT 
    COUNT(order_number) AS total_orders_count,
    COUNT(DISTINCT order_number) AS total_unique_orders 
FROM gold.fact_sales;

-- Find the total number of products in the catalog
SELECT 
    COUNT(product_key) AS total_products 
FROM gold.dim_products;


-- 3. Customer Activity
-------------------------------------------------------------------------------
-- Find the total number of customers vs. customers who actually placed an order
SELECT 
    (SELECT COUNT(customer_key) FROM gold.dim_customers) AS total_customers,
    COUNT(DISTINCT customer_key) AS active_customers
FROM gold.fact_sales;


-- 4. Consolidated Key Metrics Report
-------------------------------------------------------------------------------
-- Generate a single report showing all key business metrics using UNION ALL
SELECT 'Total Sales' AS measure_name, SUM(sales_amount) AS measure_value FROM gold.fact_sales
UNION ALL
SELECT 'Total Quantity', SUM(quantity) FROM gold.fact_sales
UNION ALL
SELECT 'Average Price', AVG(price) FROM gold.fact_sales
UNION ALL
SELECT 'Total Nr. Orders', COUNT(DISTINCT order_number) FROM gold.fact_sales
UNION ALL
SELECT 'Total Nr. Products', COUNT(product_name) FROM gold.dim_products
UNION ALL
SELECT 'Total Nr. Customers', COUNT(customer_key) FROM gold.dim_customers;
