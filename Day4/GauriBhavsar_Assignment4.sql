1.     List all customers and the products they ordered with the order date. (Inner join)
Tables used: customers, orders, order_details, products
Output should have below columns:
    companyname AS customer,
    orderid,
    productname,
    quantity,
    orderdate
        
select 
c.company_name AS customer,
o.order_id, 
p.product_name, 
od.quantity, 
o.order_date
from customers c
inner join orders o on c.customer_id = o.customer_id
inner join order_details od on o.order_id = od.order_id
inner join products p on od.product_id = p.product_id;


2.     Show each order with customer, employee, shipper, and product info — even if some parts are missing. (Left Join)
Tables used: orders, customers, employees, shippers, order_details, products
select 
o order_id,
c.company_name AS customer,
e.first_name || '' || e.last_name AS employee,
s.company_name AS shipper,
p.product_name, 
od.quantity 
from orders o
LEFT JOIN customers c ON o.customer_id = o.customer_id
LEFT JOIN employees e ON o.employee_id = e.employee_id
LEFT JOIN shippers s ON o.ship_via = s.shipper_id
LEFT JOIN order_details od ON o.order_id = od.order_id
LEFT JOIN products p on od.product_id = p.product_id;


3.     Show all order details and products (include all products even if they were never ordered). (Right Join)
Tables used: order_details, products
Output should have below columns:
    orderid,
    productid,
    quantity,
    productname


select 
p.product_name,
od.quantity,
od.order_id
from order_details od
RIGHT JOIN products p ON od.product_id = p.product_id;
4.         List all product categories and their products — including categories that have no products, and products that are not assigned to any category.(Outer Join)
Tables used: categories, products
SELECT 
c.category_id, 
c.category_name, 
p.product_id, 
p.product_name
FROM categories c
FULL OUTER JOIN products p ON c.category_id = p.category_id;


5.         Show all possible product and category combinations (Cross join).
select
c.category_id, 
c.category_name, 
p.product_id, 
p.product_name
FROM categories c
CROSS JOIN products p


6.         Show all employees and their manager(Self join(left join))
select
e1.first_name ||''|| e1.last_name AS employee_name,
e2.first_name ||''|| e2.last_name AS manager_name
FROM employees e1
LEFT JOIN employees e2 ON e1.reports_to = e2.employee_id;


7.         List all customers who have not selected a shipping method.
Tables used: customers, orders
(Left Join, WHERE o.shipvia IS NULL)


SELECT 
c.customer_id,
c.company_name AS customer_name,
o.order_id
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.ship_via IS NULL;