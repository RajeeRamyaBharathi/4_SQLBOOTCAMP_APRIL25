1.      GROUP BY with WHERE - Orders by Year and Quarter
Display, order year, quarter, order count, avg freight cost only for those orders where freight cost > 100


select DATE_PART('year',order_date) as order_year, 
ceil(DATE_PART('quarter',order_date)) as quarter,
count(*) as order_count,
ROUND(avg(freight)::numeric,2) AS avg_freight_cost
from orders
where freight >100 
group by DATE_PART('year',order_date),
ceil(DATE_PART('quarter',order_date))
order by order_year,quarter

2.      GROUP BY with HAVING - High Volume Ship Regions
Display, ship region, no of orders in each region, min and max freight cost
Filter regions where no of orders >= 5

select
    ship_region,
    count(*) AS number_of_orders,
    min(freight) AS min_freight_cost,
    max(freight) AS max_freight_cost
from orders
Group By ship_region
HAVING count(*) >= 5
ORDER BY number_of_orders DESC;

3.      Get all title designations across employees and customers ( Try UNION & UNION ALL)

–UNION
select title
from employees
UNION
select contact_title
from customers;

–union all
select title
from employees
UNION ALL
select contact_title
from customers;

4.  Find categories that have both discontinued and in-stock products
(Display category_id, instock means units_in_stock > 0, Intersect)

SELECT DISTINCT category_id,units_in_stock, product_name
FROM products
WHERE units_in_stock > 0
INTERSECT
SELECT DISTINCT category_id,units_in_stock, product_name
FROM products
WHERE discontinued = 1;

5. Find orders that have no discounted items (Display the  order_id, EXCEPT)

SELECT DISTINCT order_id
FROM orders
EXCEPT
SELECT DISTINCT order_id
FROM order_details
WHERE discount > 0;