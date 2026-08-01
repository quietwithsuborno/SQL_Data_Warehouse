/*
===============================================================================
CHANGE OVER TIME ANALYSIS
===============================================================================
Purpose: 
    - To analyze sales trends over years and months.
    - To track customer acquisition growth over time.
    - To identify seasonality and patterns in business performance.
*/

-- 1. Monthly Sales Trends
-------------------------------------------------------------------------------
-- Calculate total sales, unique customers, and quantity sold per month
-- Helps in identifying seasonal peaks and valleys
SELECT 
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    SUM(sales_amount) AS total_sales,
    COUNT(DISTINCT customer_key) AS total_customers,
    SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY YEAR(order_date), MONTH(order_date);


-- 2. Visualizing Trends with Date Truncation
-------------------------------------------------------------------------------
-- Monthly aggregation using DATETRUNC for easier plotting/reporting
SELECT 
    DATETRUNC(month, order_date) AS order_date,
    SUM(sales_amount) AS total_sales,
    COUNT(DISTINCT customer_key) AS total_customers,
    SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(month, order_date)
ORDER BY DATETRUNC(month, order_date);


-- 3. Yearly Trends Analysis
-------------------------------------------------------------------------------
-- High-level yearly performance overview
SELECT 
    DATETRUNC(year, order_date) AS order_year,
    SUM(sales_amount) AS total_sales,
    COUNT(DISTINCT customer_key) AS total_customers,
    SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(year, order_date)
ORDER BY DATETRUNC(year, order_date);


-- 4. Formatted Date Reporting
-------------------------------------------------------------------------------
-- Using FORMAT to create readable 'Year-Month' labels for dashboards
SELECT 
    FORMAT(order_date, 'yyyy-MMM') AS order_period,
    SUM(sales_amount) AS total_sales,
    COUNT(DISTINCT customer_key) AS total_customers,
    SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY FORMAT(order_date, 'yyyy-MMM')
ORDER BY MIN(order_date); -- Order by date to keep the timeline correct


-- 5. Customer Acquisition Growth
-------------------------------------------------------------------------------
-- How many new customers were added each year based on their creation date
SELECT
    DATETRUNC(year, create_date) AS acquisition_year,
    COUNT(customer_key) AS total_new_customers
FROM gold.dim_customers
GROUP BY DATETRUNC(year, create_date)
ORDER BY DATETRUNC(year, create_date);
