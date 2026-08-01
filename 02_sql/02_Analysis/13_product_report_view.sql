/*
===============================================================================
PRODUCT REPORT VIEW
===============================================================================
Purpose: 
    - This report consolidates key product metrics and behaviors.
    - Provides insights into high-performing and underperforming products.

Highlights:
    1. Gathers essential product metadata (Name, Category, Cost).
    2. Segments products by revenue (High-Performer, Mid-Range, Low-Performer).
    3. Aggregates product-level metrics (Sales, Quantity, Customers, Lifespan).
    4. Calculates critical KPIs (Recency, AOR, Monthly Revenue).
===============================================================================
*/

CREATE OR ALTER VIEW gold.report_products AS

WITH base_query AS (
/*------------------------------------------------------------------------------
1) Base Query: Joins Fact and Product Dimension
------------------------------------------------------------------------------*/
    SELECT 
        f.order_number,
        f.order_date,
        f.customer_key,
        f.sales_amount,
        f.quantity,
        p.product_key,
        p.product_name,
        p.category,
        p.subcategory,
        p.cost
    FROM gold.fact_sales f
    LEFT JOIN gold.dim_products p
        ON f.product_key = p.product_key
    WHERE f.order_date IS NOT NULL
),

product_aggregation AS (
/*------------------------------------------------------------------------------
2) Product Aggregations: Summarizes metrics at the product level
------------------------------------------------------------------------------*/
    SELECT 
        product_key,
        product_name,
        category,
        subcategory,
        cost,
        DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) AS lifespan,
        MAX(order_date) AS last_sale_date,
        COUNT(DISTINCT order_number) AS total_orders,
        COUNT(DISTINCT customer_key) AS total_customers,
        SUM(sales_amount) AS total_sales,
        SUM(quantity) AS total_quantity,
        -- Calculate Avg Selling Price handling division by zero
        ROUND(AVG(CAST(sales_amount AS FLOAT) / NULLIF(quantity, 0)), 1) AS avg_selling_price
    FROM base_query
    GROUP BY
        product_key,
        product_name,
        category,
        subcategory,
        cost    
)

/*------------------------------------------------------------------------------
3) Final Selection: Metrics and KPI Calculations
------------------------------------------------------------------------------*/
SELECT
    product_key,
    product_name,
    category,
    subcategory,
    cost,
    last_sale_date,
    DATEDIFF(MONTH, last_sale_date, '2014-01-28') AS recency_in_months,
    
    -- Product Segmentation based on Revenue
    CASE 
        WHEN total_sales > 50000 THEN 'High-Performer'
        WHEN total_sales >= 10000 THEN 'Mid-Range'
        ELSE 'Low-Performer'
    END AS product_segment,

    lifespan,
    total_orders,
    total_sales,
    total_quantity,
    total_customers,
    avg_selling_price,

    -- Average Order Revenue (AOR)
    CASE 
        WHEN total_orders = 0 THEN 0
        ELSE CAST(total_sales AS DECIMAL(18,2)) / total_orders
    END AS avg_order_revenue,

    -- Average Monthly Revenue
    CASE 
        WHEN lifespan = 0 THEN total_sales
        ELSE CAST(total_sales AS DECIMAL(18,2)) / lifespan
    END AS avg_monthly_revenue

FROM product_aggregation;
