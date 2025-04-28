set search_path = public

select c.company_name AS customer,o.order_id,o.order_date,
od.product_id,
p.product_name,p.quantity_per_unit
from customers c
Inner Join orders o ON c.customer_id = o.customer_id
inner join order_details od ON o.order_id = od.order_id
inner join products p ON p.product_id = od.product_id

select 
o.order_id,
c.company_name as customer,
e.first_name || ' ' || e.last_name as employee,
s.company_name as shipper,
p.product_name,
od.quantity
from orders o
left join customers c on o.customer_id = c.customer_id
left join employees e on o.employee_id = e.employee_id
left join shippers s on o.ship_via = s.shipper_id
left join order_details od on o.order_id = od.order_id
left join products p on od.product_id = p.product_id

select 
od.order_id,
od.product_id,
p.product_name, p.quantity_per_unit
from order_details od
right join products p ON od.product_id = p.product_id

select p.product_name,c.category_name
from products p
Full Outer Join categories c on p.category_id = c.category_id

select p.product_name,c.category_name
from products p
Cross Join categories c

select e1.first_name ||' '||e1.last_name as manager_name,
e2.first_name ||' '||e2.last_name as employee_name
from employees e1
left Join employees e2 on e2.reports_to = e1.employee_id

select c.customer_id,c.company_name,o.ship_via
from customers c
left join orders o on c.customer_id = o.customer_id
where o.ship_via is null









