-- Business analytics queries

-- Daily revenue trend
-- Monthly revenue trend
-- Top products by revenue
-- Revenue by region
-- Repeat vs new customers
-- Average order value (AOV)

-- Business analytics queries on star schema

-- 1. Daily revenue trend
SELECT
    d.date,
    SUM(f.revenue) AS daily_revenue
FROM ANALYTICS.fact_sales f
JOIN ANALYTICS.dim_date d
    ON f.order_date = d.date
GROUP BY d.date
ORDER BY d.date;

-- 2. Monthly revenue trend
SELECT
    d.year,
    d.month,
    SUM(f.revenue) AS monthly_revenue
FROM ANALYTICS.fact_sales f
JOIN ANALYTICS.dim_date d
    ON f.order_date = d.date
GROUP BY d.year, d.month
ORDER BY d.year, d.month;

-- 3. Top products by revenue
SELECT
    p.product_name,
    SUM(f.revenue) AS total_revenue
FROM ANALYTICS.fact_sales f
JOIN ANALYTICS.dim_product p
    ON f.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_revenue DESC;

-- 4. Revenue by region
SELECT
    c.region,
    SUM(f.revenue) AS total_revenue
FROM ANALYTICS.fact_sales f
JOIN ANALYTICS.dim_customer c
    ON f.customer_id = c.customer_id
GROUP BY c.region
ORDER BY total_revenue DESC;

-- 5. Repeat vs new customers
SELECT
    CASE 
        WHEN order_count = 1 THEN 'New'
        ELSE 'Repeat'
    END AS customer_type,
    COUNT(*) AS customers
FROM (
    SELECT
        customer_id,
        COUNT(DISTINCT order_id) AS order_count
    FROM ANALYTICS.fact_sales
    GROUP BY customer_id
)
GROUP BY customer_type;

-- 6. Average order value (AOV)
SELECT
    SUM(revenue) / COUNT(DISTINCT order_id) AS average_order_value
FROM ANALYTICS.fact_sales;
