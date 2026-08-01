/*
===============================================================================
DIMENSIONS EXPLORATION
===============================================================================
Purpose: 
    - To explore the descriptive attributes of the Gold layer dimensions.
    - To understand the product hierarchy (Categories and Subcategories).
    - To identify unique categorical values like countries and gender.
*/

-- 1. Customer Dimension Exploration
-------------------------------------------------------------------------------
-- Explore all unique countries our customers come from
-- Helps in understanding the geographical scope of the business
SELECT DISTINCT 
    country 
FROM gold.dim_customers;

-- Explore the gender distribution of our customer base
SELECT DISTINCT 
    gender 
FROM gold.dim_customers;


-- 2. Product Dimension Exploration
-------------------------------------------------------------------------------
-- Explore the product hierarchy: Categories, Subcategories, and Product Names
-- Ordered to show the organization of the product catalog
SELECT DISTINCT 
    category, 
    subcategory, 
    product_name 
FROM gold.dim_products
ORDER BY 1, 2, 3;

-- Explore unique categories available in the product dimension
SELECT DISTINCT 
    category 
FROM gold.dim_products;
