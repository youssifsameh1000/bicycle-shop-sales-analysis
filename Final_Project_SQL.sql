create database Final_Project;
use Final_Project;
select * 
from customers limit 10;

ALTER TABLE products
CHANGE `ï»¿product_id` product_id BIGINT;

ALTER TABLE brands
CHANGE `ï»¿brand_id` brand_id BIGINT;

ALTER TABLE categories
CHANGE `ï»¿category_id` category_id BIGINT;

ALTER TABLE customers
CHANGE `ï»¿customer_id` customer_id BIGINT;

ALTER TABLE order_items
CHANGE `ï»¿order_id` order_id BIGINT;

ALTER TABLE orders
CHANGE `ï»¿order_id` order_id BIGINT;

ALTER TABLE staffs
CHANGE `ï»¿staff_id` staff_id BIGINT;

ALTER TABLE stocks
CHANGE `ï»¿store_id` store_id BIGINT;

ALTER TABLE stores
CHANGE `ï»¿store_id` store_id BIGINT;


-- (1) What is the total sales revenue for each store?
SELECT 
    s.store_name,
    round( sum(oi.quantity * oi.list_price * (1 - oi.discount)),3) AS total_sales
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN stores s ON o.store_id = s.store_id
WHERE o.order_status = 4
GROUP BY s.store_name
ORDER BY total_sales DESC;


-- (2) Top-selling products by total sales revenue
SELECT
    p.product_name,
    round( sum(oi.quantity * oi.list_price * (1 - oi.discount)),3) AS total_sales
FROM order_items oi
JOIN products p ON oi.order_id = p.product_id  
GROUP BY p.product_name
ORDER BY total_sales DESC;


-- (3) Total sales by product category
SELECT 
    c.category_name,
    round( sum(oi.quantity * oi.list_price * (1 - oi.discount)),3) AS total_sales
FROM products p
JOIN order_items oi ON p.product_id = oi.order_id
JOIN categories c ON p.category_id = c.category_id
GROUP BY c.category_name
ORDER BY total_sales DESC;


-- (4) Customers with the highest number of orders
SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, customer_name
ORDER BY total_orders DESC
LIMIT 10;


-- (5) Monthly trend of completed orders
SELECT 
    DATE_FORMAT(o.order_date, '%Y-%m') AS month,
    COUNT(o.order_id) AS completed_orders
FROM orders o
WHERE o.order_status = 4
GROUP BY month
ORDER BY month;

-- (6) Store with the highest number of completed orders
SELECT 
    s.store_name,
    COUNT(o.order_id) AS completed_orders
FROM orders o
JOIN stores s ON o.store_id = s.store_id
WHERE o.order_status = 4
GROUP BY s.store_name
ORDER BY completed_orders DESC
LIMIT 1;


-- (7) Average order value for each store
SELECT 
    s.store_name,
    round( AVG(order_total),3) AS avg_order_value
FROM (
    SELECT 
        o.order_id,
        o.store_id,
         sum(oi.quantity * oi.list_price * (1 - oi.discount)) AS order_total
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE o.order_status = 4
    GROUP BY o.order_id, o.store_id
) t
JOIN stores s ON t.store_id = s.store_id
GROUP BY s.store_name
ORDER BY avg_order_value DESC;


-- (8) Products with low stock levels
SELECT 
    s.store_name,
    p.product_name,
    st.quantity
FROM stocks st
JOIN products p ON st.product_id = p.product_id
JOIN stores s ON st.store_id = s.store_id
WHERE st.quantity < 10
ORDER BY st.quantity ASC;


-- (9) Staff members with the highest sales volume
SELECT
    CONCAT(sf.first_name, ' ', sf.last_name) AS staff_name,
    round(SUM(oi.quantity * oi.list_price * (1 - oi.discount)),3) AS total_sales
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN staffs sf ON o.staff_id = sf.staff_id
WHERE o.order_status = 4
GROUP BY staff_name
ORDER BY total_sales DESC;


-- (10) Distribution of order statuses
SELECT 
    CASE o.order_status
        WHEN 1 THEN 'Pending'
        WHEN 2 THEN 'Processing'
        WHEN 3 THEN 'Rejected'
        WHEN 4 THEN 'Completed'
    END AS order_status,
    COUNT(*) AS total_orders
FROM orders o
GROUP BY o.order_status;
