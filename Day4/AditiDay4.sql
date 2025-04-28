--Day 4 Assignement

--1)List all customers and the products they ordered with the order date. (Inner join)
--Tables used: customers, orders, order_details, products
--Output should have below columns:companyname AS customer,orderid,productname,quantity,orderdate
	 SELECT 
	    cp.company_name AS customers,
	    oe.order_id,
	    pr.product_name,
	    od.quantity,
	    oe.order_date
	FROM 
	    customers cp
	INNER JOIN 
	    orders oe ON cp.customer_id = oe.customer_id
	INNER JOIN 
	    order_details od ON oe.order_id = od.order_id
INNER JOIN 
    products pr ON od.product_id = pr.product_id;
--ORDER BY 
  --  cp.company_name, oe.order_date;
--2)Show each order with customer, employee, shipper, and product info — even if some parts are missing. (Left Join)
--Tables used: orders, customers, employees, shippers, order_details, products
 SELECT 
    oe.order_id,
    cp.company_name AS customers,
    (em.first_name || ' ' || em.last_name) AS employees,
    sh.company_name AS shippers,
    pr.product_name,
    od.quantity,
    oe.order_date
FROM 
    orders oe
LEFT JOIN 
    customers cp ON oe.customer_id = cp.customer_id
LEFT JOIN 
    employees em ON oe.employee_id = em.employee_id
LEFT JOIN 
    shippers sh ON oe.ship_via = sh.shipper_id
LEFT JOIN 
    order_details od ON oe.order_id = od.order_id
LEFT JOIN 
    products pr ON od.product_id = pr.product_id;
ORDER BY 
    oe.order_id;
 
--3)Show all order details and products (include all products even if they were never ordered). (Right Join)
--Tables used: order_details, products Output should have below columns:orderid,productid,quantity,productname

 
SELECT 
    op.order_id,
    pr.product_id,
    op.quantity,
    pr.product_name
FROM 
    order_details op
RIGHT JOIN 
    products pr ON op.product_id = pr.product_id
ORDER BY 
    pr.product_id;
--4)List all product categories and their products — including categories that have no products, and products that are not assigned to any category.(Outer Join)
--Tables used: categories, products
 SELECT 
    cn.category_name,
    pr.product_id,
    pr.product_name
FROM 
    categories cn
FULL OUTER JOIN 
    products pr ON cn.category_id = pr.category_id
ORDER BY 
    cn.category_name, pr.product_name;
--5)Show all possible product and category combinations (Cross join).
 SELECT 
    pr.product_id,
    pr.product_name,
    cn.category_id,
    cn.category_name
FROM 
    products pr
CROSS JOIN 
    categories cn
ORDER BY 
    pr.product_id, cn.category_id;
--6)Show all employees and their manager(Self join(left join))
 SELECT 
    e1.employee_id AS employee_id,
    (e1.first_name || ' ' || e1.last_name) AS employee_name,
    e2.employee_id AS manager_id,
    (e2.first_name || ' ' || e2.last_name) AS manager_name
FROM 
    employees e1
LEFT JOIN 
    employees e2 ON e1.reports_to = e2.employee_id
ORDER BY 
    e1.employee_id;
--7)List all customers who have not selected a shipping method.
--Tables used: customers, orders(Left Join, WHERE o.shipvia IS NULL)
SELECT 
    cn.customer_id,
    cn.company_name
FROM 
    customers cn
LEFT JOIN 
    orders oe ON cn.customer_id = oe.customer_id
WHERE 
    oe.ship_via IS NULL
ORDER BY 
    cn.company_name;

 
 
 
 
 
              
