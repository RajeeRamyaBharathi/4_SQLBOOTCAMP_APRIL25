1.     Rank employees by their total sales
(Total sales = Total no of orders handled, JOIN employees and orders table)
select e.employee_id,
           COUNT(o.order_id) AS total_sales,
Rank() OVER(ORDER BY COUNT(o.order_id) DESC) AS sales_rank
from employees e
LEFT JOIN orders o ON e.employee_id = o.employee_id
GROUP BY e.employee_id
ORDER BY sales_rank;


2.      Compare current order's freight with previous and next order for each customer.
(Display order_id,  customer_id,  order_date,  freight,
Use lead(freight) and lag(freight).


--using lag(freight)
select order_id, customer_id, order_date, freight, 
lag(freight) over(partition by customer_id order by order_date) as previous_freight
from orders;
----using lead(freight)
select order_id, customer_id, order_date, freight, 
lead(freight) over(partition by customer_id order by order_date) as next_freight
from orders;
3.     Show products and their price categories, product count in each category, avg price:
                (HINT:
·          Create a CTE which should have price_category definition:
                WHEN unit_price < 20 THEN 'Low Price'
            WHEN unit_price < 50 THEN 'Medium Price'
            ELSE 'High Price'
·          In the main query display: price_category,  product_count in each price_category,  ROUND(AVG(unit_price)::numeric, 2) as avg_price)


WITH price_categories AS (
    select product_id, product_name, unit_price,
        CASE
            WHEN unit_price < 20 THEN 'Low Price'
            WHEN unit_price < 50 THEN 'Medium Price'
            ELSE 'High Price'
        END AS price_category
    from products
)
select price_category, 
       COUNT(*) AS product_count, 
       ROUND(AVG(unit_price)::numeric, 2) AS avg_price
from price_categories
GROUP BY price_category
ORDER BY price_category;