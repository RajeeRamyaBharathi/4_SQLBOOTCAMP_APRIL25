1.      Categorize products by stock status
(Display product_name, a new column stock_status whose values are based on below condition
 units_in_stock = 0  is 'Out of Stock'
       units_in_stock < 20  is 'Low Stock')
select product_name, units_in_stock,
case
    when units_in_stock = 0 then 'Out Of Stock'
        when units_in_stock < 20 then 'Low Stock'
        else 'In Stock'
end as stock_status
from products;


2.      Find All Products in Beverages Category
(Subquery, Display product_name,unitprice)
select product_name, unit_price
from products
where category_id = 
 (select category_id
  from categories 
  where category_name = 'Drinks');


3.      Find Orders by Employee with Most Sales
(Display order_id,   order_date,  freight, employee_id.
Employee with Most Sales=Get the total no.of of orders for each employee then order by DESC and limit 1. Use Subquery)
select order_id, order_date, freight, employee_id
from orders
WHERE employee_id = (
    select employee_id
    from (
          select employee_id, 
          COUNT(order_id) AS total_orders
          from orders
          GROUP BY employee_id
          ORDER BY total_orders DESC
          LIMIT 1
         )
    );


4.      Find orders  where for country!= ‘USA’ with freight costs higher than any order from USA. (Subquery, Try with ANY, ALL operators)
--using ANY operator
select order_id, order_date, freight, ship_country
from orders
WHERE ship_country != 'USA' AND freight > ANY (
      select freight 
      from orders 
      WHERE ship_country = 'USA'
    );
--using ALL operator
select order_id, order_date, freight, ship_country
from orders
WHERE ship_country != 'USA' AND freight > ALL (
      select freight 
      from orders 
      WHERE ship_country = 'USA'
    );
