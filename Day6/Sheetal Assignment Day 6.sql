set search_path = public

select product_name,
	Case
	  When units_in_stock = 0 Then 'Out of Stock'
	  When units_in_stock < 20 Then 'Low Stock'
	  Else 'In Stock'
	End as stock_status
from products


select product_name,unit_price
from products
Where category_id = (select category_id from categories where category_name = 'Beverages')

select * from orders

select employee_id,order_id, order_date, freight
from orders
where employee_id = (
    select employee_id 
    FROM orders
    GROUP BY employee_id
    ORDER BY COUNT(employee_id) DESC 
    LIMIT 1
)

select order_id, order_date,freight,ship_country 
from orders 
where ship_country != 'USA'
and 
freight > Any(select freight from orders where ship_country = 'USA')

select order_id, order_date,freight,ship_country 
from orders 
where ship_country != 'USA'
and 
freight > All(select freight from orders where ship_country = 'USA')


