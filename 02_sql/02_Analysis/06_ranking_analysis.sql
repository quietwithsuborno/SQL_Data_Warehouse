/*
===============================================================================
RANKING ANALYSIS
===============================================================================
Purpose: 
    - To identify the top and bottom performing entities (products/customers).
    - To rank entities based on business metrics like revenue and order volume.
    - To provide insights into business winners and underperformers.
*/

-- 1. Product Performance Ranking (Top 5)
-------------------------------------------------------------------------------
-- Which 5 products generate the highest revenue?
SELECT TOP 5
    p.product_name,
    SUM(f.sales_amount) AS total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
    ON p.product_key = f.product_key
GROUP BY p.product_name
ORDER BY total_revenue DESC;


-- 2. Product Performance Ranking (Bottom 5)
-------------------------------------------------------------------------------
-- Which are the 5 worst-performing products in terms of sales?
-- This helps identify products that may need marketing or replacement.
SELECT TOP 5
    p.product_name,
    SUM(f.sales_amount) AS total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
    ON p.product_key = f.product_key
GROUP BY p.product_name
ORDER BY total_revenue ASC; -- Bottom performance (lowest revenue first)


-- 3. Top Customer Ranking (Revenue)
-------------------------------------------------------------------------------
-- Find the top 10 customers who have generated the highest revenue
SELECT TOP 10
    c.customer_key,
    c.first_name,
    c.last_name,
    SUM(f.sales_amount) AS total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
    ON c.customer_key = f.customer_key
GROUP BY
    c.customer_key,
    c.first_name,
    c.last_name
ORDER BY total_revenue DESC;


-- 4. Customer Engagement Ranking (Order Count)
-------------------------------------------------------------------------------
-- The 3 customers with the fewest orders placed
-- Useful for identifying churn risk or low-engagement accounts
SELECT TOP 3
    c.customer_key,
    c.first_name,
    c.last_name,
    COUNT(DISTINCT f.order_number) AS total_orders
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
    ON c.customer_key = f.customer_key
GROUP BY
    c.customer_key,
    c.first_name,
    c.last_name
ORDER BY total_orders ASC;
