/*
===============================================================================
PERFORMANCE ANALYSIS
===============================================================================
Purpose: 
    - To analyze the yearly performance of products.
    - To compare current sales against the historical average (Above/Below Avg).
    - To calculate Year-over-Year (YoY) growth using the LAG() function.
*/

-- 1. Yearly Product Performance Analysis
-------------------------------------------------------------------------------
-- This query compares each product's yearly sales to its overall average 
-- and to its previous year's performance.

WITH yearly_product_sales AS (
    SELECT 
        YEAR(f.order_date) AS order_year,
        p.product_name,
        SUM(f.sales_amount) AS current_sales
    FROM gold.fact_sales f
    LEFT JOIN gold.dim_products p
        ON f.product_key = p.product_key
    WHERE f.order_date IS NOT NULL
    GROUP BY 
        YEAR(f.order_date),
        p.product_name
)

SELECT
    order_year,
    product_name,
    current_sales,
    -- Calculate the average sales for each product across all years
    AVG(current_sales) OVER (PARTITION BY product_name) AS avg_sales,
    -- Difference from average
    current_sales - AVG(current_sales) OVER (PARTITION BY product_name) AS diff_avg,
    -- Categorize performance against average
    CASE 
        WHEN current_sales - AVG(current_sales) OVER (PARTITION BY product_name) > 0 THEN 'Above Avg'
        WHEN current_sales - AVG(current_sales) OVER (PARTITION BY product_name) < 0 THEN 'Below Avg'
        ELSE 'Avg'
    END AS avg_performance_status,
    
    -- Year-over-Year (YoY) Analysis
    -- Get sales of the same product from the previous year
    LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) AS py_sales,
    -- Difference between current and previous year
    current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) AS diff_py,
    -- Categorize growth status
    CASE 
        WHEN current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) > 0 THEN 'Increase'
        WHEN current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) < 0 THEN 'Decrease'
        ELSE 'No Change'
    END AS py_growth_status
FROM yearly_product_sales
ORDER BY product_name, order_year;
