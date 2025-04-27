
-- 1.List all customers and the products they ordered with the order date. (Inner join)
-- Tables used: customers, orders, order_details, products
SELECT c.company_name AS customer, o.order_id, p.product_name, od.quantity, o.order_date
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id
INNER JOIN order_details od ON o.order_id = od.order_id
INNER JOIN products p ON od.product_id = p.product_id;

-- 2.Show each order with customer, employee, shipper, and product info — even if some parts are missing. (Left Join)
-- Tables used: orders, customers, employees, shippers, order_details, products
SELECT o.order_id, 
	c.company_name AS customer, 
	e.first_name ||' '|| e.last_name AS employee_name, 
	s.company_name, 
	od.quantity, 
	o.order_date, 
	p.product_name
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id
INNER JOIN order_details od ON o.order_id = od.order_id
INNER JOIN products p ON od.product_id = p.product_id
INNER JOIN employees e ON o.employee_id = e.employee_id
INNER JOIN shippers s ON o.ship_via = s.shipper_id;


-- 3.Show all order details and products (include all products even if they were never ordered). (Right Join)
-- Tables used: order_details, products
SELECT od.order_id, od.product_id, od.quantity, p.product_name
FROM products p
RIGHT JOIN order_details od ON p.product_id = od.product_id; 


-- 4.List all product categories and their products — including categories that have no products, 
-- and products that are not assigned to any category.(Outer Join)
-- Tables used: categories, products
SELECT p.product_id, p.product_name, ca.category_name, ca.category_id 
FROM categories ca
FULL OUTER JOIN products p ON p.category_id = ca.category_id
ORDER BY p.product_id ASC;


-- 5.Show all possible product and category combinations (Cross join).
SELECT p.product_id, p.product_name, ca.category_name
FROM products p
CROSS JOIN categories ca;


-- 6.Show all employees and their manager(Self join(left join))
SELECT e1.first_name||' '||e1.last_name AS employee_name,
	   e2.first_name||' '||e2.last_name AS manager_name
FROM employees e1
LEFT JOIN employees e2 ON e1.reports_to = e2.employee_id
WHERE e2.employee_id IS NOT NULL;


-- 7.List all customers who have not selected a shipping method.
-- Tables used: customers, orders
SELECT c.customer_id, c.company_name AS customer_name, o.ship_via
FROM customers c
LEFT JOIN orders o ON o.customer_id = c.customer_id
WHERE o.ship_via IS NULL;

