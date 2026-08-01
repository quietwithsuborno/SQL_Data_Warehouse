/*
===============================================================================
DATABASE EXPLORATION & METADATA DISCOVERY
===============================================================================
Purpose: 
    - To discover all existing objects (tables/views) within the database.
    - To understand the schema structure and column definitions of key tables.
    - To verify the availability of the Gold layer tables.
*/

-- 1. Object Exploration
-------------------------------------------------------------------------------
-- List all tables and views in the current database
-- This helps in confirming that the gold layer tables are properly deployed
SELECT 
    table_catalog, 
    table_schema, 
    table_name, 
    table_type
FROM INFORMATION_SCHEMA.TABLES;


-- 2. Column Discovery
-------------------------------------------------------------------------------
-- Explore the structure of the 'dim_customers' table
-- Useful for identifying primary keys, foreign keys, and data types
SELECT 
    column_name, 
    data_type, 
    is_nullable, 
    character_maximum_length
FROM INFORMATION_SCHEMA.COLUMNS
WHERE table_name = 'dim_customers' 
  AND table_schema = 'gold';


-- 3. Schema Verification
-------------------------------------------------------------------------------
-- Quick check for the availability of the three main tables in the gold layer
-- (dim_customers, dim_products, fact_sales)
SELECT 
    table_name 
FROM INFORMATION_SCHEMA.TABLES 
WHERE table_schema = 'gold' 
  AND table_name IN ('dim_customers', 'dim_products', 'fact_sales');
