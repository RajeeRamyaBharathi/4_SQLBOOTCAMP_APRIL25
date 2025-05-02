set search_path = public
-----View

CREATE VIEW vw_updatable_products AS
SELECT product_id, product_name, unit_price, units_in_stock
FROM products;

select * from vw_updatable_products

UPDATE vw_updatable_products SET unit_price = unit_price * 1.1 WHERE units_in_stock < 10;

SELECT product_id, product_name, unit_price, units_in_stock 
FROM products
where units_in_stock < 10


------TRANSACTION
BEGIN transaction;
update products
set unit_price = unit_price*1.10
where 
category_id = 1;
COMMIT;

RoLLBACK;

select * from products where category_id = 1

create View employee_territory_details AS
select 
e.employee_id, e.first_name||' '||e.last_name as employee_full_name, 
e.title,
et.territory_id,
t.territory_description,
r.region_description
from employees e
JOIN employee_territories et on e.employee_id = et.employee_id
JOIN territories t on et.territory_id = t.territory_id
JOIN region r ON t.region_id = r.region_id;

select * from employee_territory_details






-----RECURSIVE
WITH RECURSIVE cte_employee_hierarchy AS(
----Manager at the Highest Level
select 
	employee_id, 
	first_name, 
	last_name, 
	reports_to,
	0 As level
from employees e
where reports_to is NULL

Union ALL
----Recuresive query for employees reporting to higher managers
select 
	e.employee_id, 
	e.first_name, 
	e.last_name, 
	e.reports_to,
	c.level + 1 as level
from employees e
Join cte_employee_hierarchy c on e.reports_to = c.employee_id
)

select 
employee_id,
first_name||' '||last_name as employee_name,
reports_to,
level
from cte_employee_hierarchy 
order by level,employee_id
