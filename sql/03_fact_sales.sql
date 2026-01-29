-- FACT table creation script

-- fact_sales table
-- joins orders, order_items, products, payments
-- calculates revenue = quantity * price


-- FACT table: fact_sales
-- Grain: one row per product per order (order item)

CREATE OR REPLACE TABLE ANALYTICS.fact_sales AS
SELECT
    oi.order_id,
    o.order_date,
    o.customer_id,
    oi.product_id,
    oi.quantity,
    p.price,
    (oi.quantity * p.price) AS revenue,
    pay.payment_status
FROM STAGING.stg_order_items oi
JOIN STAGING.stg_orders o
    ON oi.order_id = o.order_id
JOIN STAGING.stg_products p
    ON oi.product_id = p.product_id
LEFT JOIN STAGING.stg_payments pay
    ON oi.order_id = pay.order_id
WHERE o.order_status = 'DELIVERED';
