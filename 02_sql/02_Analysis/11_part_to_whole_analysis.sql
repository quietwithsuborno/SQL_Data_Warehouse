/*
===============================================================================
PART-TO-WHOLE ANALYSIS
===============================================================================
Purpose: 
    - To analyze the contribution of each category to the overall sales.
    - To calculate the percentage of total revenue for each product category.
    - To identify which categories are the primary drivers of business value.
*/

-- 1. Category Contribution to Total Sales
-------------------------------------------------------------------------------
-- This query calculates the total sales per category and its percentage share 
-- relative to the entire business revenue.

WITH category_sales AS (
    SELECT 
        p.category,
        SUM(f.sales_amount) AS total_sales
    FROM gold.fact_sales f
    LEFT JOIN gold.dim_products p
        ON p.product_key = f.product_key
    GROUP BY p.category
)

SELECT 
    category,
    total_sales,
    -- Calculate overall sales across all categories using a window function
    SUM(total_sales) OVER () AS overall_sales,
    -- Calculate the percentage share of each category
    CONCAT(
        ROUND((CAST(total_sales AS FLOAT) / SUM(total_sales) OVER()) * 100, 2), 
        '%'
    ) AS percentage_of_total
FROM category_sales
ORDER BY total_sales DESC;
