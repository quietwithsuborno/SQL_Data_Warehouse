/*
===============================================================================
DATE RANGE EXPLORATION
===============================================================================
Purpose: 
    - To determine the temporal boundaries of the dataset.
    - To understand the distribution of customer ages.
    - To identify the first and last transaction dates for business analysis.
*/

-- 1. Sales Timeline Discovery
-------------------------------------------------------------------------------
-- Find the date range of business operations (First and Last order)
-- DATEDIFF helps us understand the total years of history available in the fact table
SELECT 
    MIN(order_date) AS first_order_date,
    MAX(order_date) AS last_order_date,
    DATEDIFF(year, MIN(order_date), MAX(order_date)) AS order_range_years
FROM gold.fact_sales;


-- 2. Customer Demographics Range (Age Exploration)
-------------------------------------------------------------------------------
-- Explore the age profile of the customers based on their birthdates
-- GETDATE() is used to calculate the current age in years
SELECT
    MIN(birthdate) AS oldest_birthdate,
    DATEDIFF(year, MIN(birthdate), GETDATE()) AS oldest_age,
    MAX(birthdate) AS youngest_birthdate,
    DATEDIFF(year, MAX(birthdate), GETDATE()) AS youngest_age
FROM gold.dim_customers;


-- 3. Data Quality Check for Dates
-------------------------------------------------------------------------------
-- Identify if there are any records with missing order dates (NULL values)
SELECT 
    COUNT(*) AS records_with_null_dates 
FROM gold.fact_sales 
WHERE order_date IS NULL;
