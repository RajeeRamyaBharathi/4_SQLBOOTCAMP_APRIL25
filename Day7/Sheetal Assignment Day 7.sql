set search_path = public

SELECT 
    e.employee_id,
    e.first_name || ' ' || e.last_name AS employee_name,
    COUNT(o.order_id) AS total_sales,
    RANK() OVER (ORDER BY COUNT(o.order_id) DESC) AS sales_rank
FROM employees e
LEFT JOIN orders o ON e.employee_id = o.employee_id
GROUP BY e.employee_id, e.first_name, e.last_name
order by sales_rank ASC


select customer_id,
      order_id,
      order_date,
      freight,
      LAG(freight)over(partition by customer_id order by order_date) as previous_freight,
      LEAD(freight)over(partition by customer_id order by order_date) as next_freight
      from orders
	  

WITH price_category AS (
    SELECT 
        product_id,
        product_name,
        unit_price,
        CASE 
            WHEN unit_price < 20 THEN 'Low Price'
            WHEN unit_price < 50 THEN 'Medium Price'
            ELSE 'High Price'
        END AS unit_price_categories
    FROM products
)

SELECT 
	unit_price_categories,
    COUNT(product_id) AS product_count,
    ROUND(AVG(unit_price)::numeric, 2) AS avg_price
FROM price_category
GROUP BY unit_price_categories
ORDER BY avg_price;



