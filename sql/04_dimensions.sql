-- DIMENSION tables creation script

-- dim_customer
-- dim_product
-- dim_date

-- DIMENSION tables

-- Customer dimension
CREATE OR REPLACE TABLE ANALYTICS.dim_customer AS
SELECT
    customer_id,
    first_name,
    last_name,
    email,
    region,
    signup_date
FROM STAGING.stg_customers;

-- Product dimension
CREATE OR REPLACE TABLE ANALYTICS.dim_product AS
SELECT
    product_id,
    product_name,
    category,
    price
FROM STAGING.stg_products;

-- Date dimension
CREATE OR REPLACE TABLE ANALYTICS.dim_date AS
SELECT DISTINCT
    order_date              AS date,
    YEAR(order_date)        AS year,
    MONTH(order_date)       AS month,
    DAY(order_date)         AS day,
    DAYOFWEEK(order_date)   AS day_of_week,
    DAYNAME(order_date)     AS day_name,
    MONTHNAME(order_date)   AS month_name
FROM ANALYTICS.fact_sales;
