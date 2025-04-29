--Assignment 5
--1.Group by with where-orders by year and quarter.Display order year,quarter,order count,avg frieght for those orders where freight cost>100 
SELECT
    EXTRACT(year FROM order_date) AS order_year,
    EXTRACT(quarter FROM order_date) AS quarter,
    COUNT(*) AS order_count,
    AVG(freight) AS avg_freight
FROM
    orders
WHERE
    freight > 100
GROUP BY
    order_year,
    quarter
ORDER BY
    order_year,
    quarter;


--2.Group by with Having -High Volume Ship Regions.Display ship region,no of order in each regions,min and max freight cost.Filter regions where no of orders>=5
SELECT
    ship_region,
    COUNT(*) AS order_count,
    MIN(freight) AS min_freight,
    MAX(freight) AS max_freight
FROM
    orders
WHERE
    ship_region IS NOT NULL
GROUP BY
    ship_region
HAVING
    COUNT(*) >= 5
ORDER BY
    order_count DESC;


--3.Get all title designations across employees and customers(Try UNION & UNION ALL)
--UNION
SELECT title AS designation
FROM employees
UNION
SELECT contact_title AS designation
FROM customers;
--UNION ALL
SELECT title AS designation
FROM employees
UNION ALL
SELECT contact_title AS designation
FROM customers;


--4.Find categories that have both discontinued and in-stock products.Display category_id,instock means unit_in_stock>0,Intersect.
-- Categories with discontinued products
SELECT category_id
FROM products
WHERE discontinued=1
INTERSECT
-- Categories with in-stock products
SELECT category_id
FROM products
WHERE units_in_stock> 0;

--5.Find orders that have no discounted items.Display order_id,EXCEPT.
-- Orders that have any discounted items
SELECT order_id
FROM order_details
WHERE discount > 0

EXCEPT

-- Orders that have only non-discounted items
SELECT order_id
FROM order_details
WHERE discount = 0;

