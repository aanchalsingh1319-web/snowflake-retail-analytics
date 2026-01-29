-- STAGING tables creation script

-- stg_customers
-- stg_products
-- stg_orders
-- stg_order_items
-- stg_payments

-- STAGING tables (cleaned layer)

CREATE OR REPLACE TABLE STAGING.stg_customers AS
SELECT
    customer_id,
    INITCAP(first_name) AS first_name,
    INITCAP(last_name)  AS last_name,
    LOWER(email)        AS email,
    region,
    signup_date
FROM RETAIL_DB.PUBLIC.customers;

CREATE OR REPLACE TABLE STAGING.stg_products AS
SELECT
    product_id,
    product_name,
    category,
    price
FROM RETAIL_DB.PUBLIC.products;

CREATE OR REPLACE TABLE STAGING.stg_orders AS
SELECT
    order_id,
    customer_id,
    order_date,
    order_status
FROM RETAIL_DB.PUBLIC.orders;

CREATE OR REPLACE TABLE STAGING.stg_order_items AS
SELECT
    order_item_id,
    order_id,
    product_id,
    quantity
FROM RETAIL_DB.PUBLIC.order_items;

CREATE OR REPLACE TABLE STAGING.stg_payments AS
SELECT
    payment_id,
    order_id,
    payment_date,
    payment_method,
    payment_status
FROM RETAIL_DB.PUBLIC.payments;
