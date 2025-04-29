SELECT 
    EXTRACT(YEAR FROM order_date) AS order_year,
    EXTRACT(QUARTER FROM order_date) AS quarter,
    COUNT(*) AS order_count,
    AVG(freight) AS avg_freight_cost
FROM 
    orders
WHERE 
    freight > 100
GROUP BY 
    order_year, quarter
ORDER BY 
    order_year, quarter;


	SELECT 
    ship_region,
    COUNT(*) AS number_of_orders,
    MIN(freight) AS min_freight,
    MAX(freight) AS max_freight
FROM 
    orders
GROUP BY 
    ship_region
HAVING 
    COUNT(*) >= 5
ORDER BY 
    number_of_orders DESC;

	SELECT title
FROM employees

UNION

SELECT contact_title
FROM customers;


SELECT title
FROM employees

UNION ALL

SELECT contact_title
FROM customers;




SELECT category_id
FROM products
WHERE discontinued = 1

INTERSECT


SELECT category_id
FROM products
WHERE units_in_stock > 0;


SELECT DISTINCT order_id
FROM order_details

EXCEPT


SELECT DISTINCT order_id
FROM order_details
WHERE discount > 0;





