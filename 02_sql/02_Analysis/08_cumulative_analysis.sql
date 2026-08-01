/*
===============================================================================
CUMULATIVE ANALYSIS
===============================================================================
Purpose: 
    - To calculate running totals of sales over time.
    - To analyze moving averages for price trends.
    - To understand the progression of business metrics across the timeline.
*/

-- 1. Running Total & Moving Average Analysis
-------------------------------------------------------------------------------
-- Calculate the total sales per year 
-- Along with the running total of sales and moving average of price over time
SELECT
    order_date,
    total_sales,
    -- Running Total: Cumulative sum of sales from the start to current row
    SUM(total_sales) OVER (ORDER BY order_date) AS running_total_sales,
    -- Moving Average: Average price trend over the years
    AVG(avg_price) OVER (ORDER BY order_date) AS moving_average_price
FROM
(
    -- Subquery: Aggregating data at the yearly level for a cleaner trend
    SELECT
        DATETRUNC(year, order_date) AS order_date,
        SUM(sales_amount) AS total_sales,
        AVG(price) AS avg_price
    FROM gold.fact_sales
    WHERE order_date IS NOT NULL
    GROUP BY DATETRUNC(year, order_date)
) t
ORDER BY order_date;


-- 2. Monthly Cumulative Sales (Optional Extension)
-------------------------------------------------------------------------------
-- This helps identify how fast the business reaches its annual targets
SELECT
    order_date,
    total_sales,
    SUM(total_sales) OVER (PARTITION BY YEAR(order_date) ORDER BY order_date) AS yearly_running_total
FROM
(
    SELECT
        DATETRUNC(month, order_date) AS order_date,
        SUM(sales_amount) AS total_sales
    FROM gold.fact_sales
    WHERE order_date IS NOT NULL
    GROUP BY DATETRUNC(month, order_date)
) t;
