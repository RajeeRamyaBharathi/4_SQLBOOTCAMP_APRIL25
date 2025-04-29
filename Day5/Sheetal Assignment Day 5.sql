set search_path = public

select 
	Extract(Year from order_date) as Order_year,
	Extract(Quarter from Order_date) as Order_quarter,
	count(order_id) as order_count,
	round(avg(freight)::numeric,2) as Average_freight_cost
from orders
where freight > 100
group by order_year,order_quarter
order by order_year,order_quarter

select * from orders

select ship_region as ship_region,
	count(ship_region) as Order_count,
	Min(freight) as Minimum_Freight_cost,
	Max(freight) as Maximum_Freight_cost
from orders 
Group by ship_region
having count(ship_region)>=5
order by order_count Desc

select contact_title as designation from customers 
Union all
select title from employees

select category_id from products
where discontinued = 1
intersect
select category_id
from products
where units_in_stock > 0

select order_id from order_details
except
select order_id from order_details
where discount = 0



