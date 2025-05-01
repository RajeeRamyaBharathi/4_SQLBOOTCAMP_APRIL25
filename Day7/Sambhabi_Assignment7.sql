--1.Rank employees by their total sales

--with JOIN: Rank of employees by total_sales
SELECT o.employee_id, e.first_name||' '||e.last_name AS employee_name, 
	COUNT(order_id) AS total_sales,
	RANK() OVER(ORDER BY COUNT(order_id) DESC
	) 	AS sales_rank
FROM orders o
LEFT JOIN employees e ON o.employee_id = e.employee_id
GROUP BY o.employee_id, employee_name
ORDER BY total_sales DESC;

--without JOIN: Rank of employee_id by total_sales 
SELECT employee_id, 
       RANK() OVER(ORDER BY total_sales DESC) AS sales_rank 
FROM (SELECT employee_id, COUNT(order_id) AS total_sales 
      FROM orders 
      GROUP BY employee_id) AS sales_summary;


 
/* 2.Compare current order's freight with previous and next order for each customer.
(Display order_id,  customer_id,  order_date,  freight,
Use lead(freight) and lag(freight)*/

--LAG
SELECT 
    customer_id, 
    order_id, 
    order_date, 
    freight,
    LAG(freight) OVER(PARTITION BY customer_id ORDER BY freight) AS previous_freight,
    ROUND((freight - LAG(freight) OVER(PARTITION BY customer_id ORDER BY freight))::numeric, 2) AS freight_difference
FROM orders;

--LEAD
SELECT 
    customer_id, 
    order_id, 
    order_date, 
    freight,
    LEAD(freight) OVER(PARTITION BY customer_id ORDER BY freight) AS next_freight,
    ROUND((LEAD(freight) OVER(PARTITION BY customer_id ORDER BY freight)-freight)::numeric, 2) AS freight_difference
FROM orders;


--3.Show products and their price categories, product count in each category, avg price

WITH PRICE_CATEGORY AS
(SELECT 
	category_id,
	product_name, 
	unit_price,
	CASE
		WHEN unit_price < 20 THEN 'Low Price'
		WHEN unit_price < 50 THEN 'Medium Price'
		ELSE 'High Price'
	END AS price_category
FROM products
--GROUP BY category_id, product_name, units_in_stock
ORDER BY category_id, product_name 
)
SELECT 
	price_category,
	COUNT(*) AS product_count,
	ROUND(AVG(unit_price)::numeric,2) as avg_price
FROM PRICE_CATEGORY 
GROUP BY price_category
ORDER BY avg_price;
	
	