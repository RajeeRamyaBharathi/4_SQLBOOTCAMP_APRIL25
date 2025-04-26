SELECT 
    c.company_name AS customer,
    o.order_id,
    p.product_name,
    od.quantity,
    o.order_date
FROM 
    customers c
INNER JOIN 
    orders o ON c.customer_id = o.customer_id
INNER JOIN 
    order_details od ON o.order_id = od.order_id
INNER JOIN 
    products p ON od.product_id = p.product_id;


SELECT 
    o.order_id,
    c.company_name AS customer_name,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    s.company_name AS shipper_name,
    p.product_name AS product_name,
    od.quantity,
    o.order_date
FROM 
    orders o
LEFT JOIN 
    customers c ON o.customer_id = c.customer_id
LEFT JOIN 
    employees e ON o.employee_id = e.employee_id
LEFT JOIN 
    shippers s ON o.ship_via = s.shipper_id
LEFT JOIN 
    order_details od ON o.order_id = od.order_id
LEFT JOIN 
    products p ON od.product_id = p.product_id;


	SELECT 
    od.order_id,
    p.product_id,
    od.quantity,
    p.product_name
FROM 
    order_details od
RIGHT JOIN 
    products p ON od.product_id = p.product_id;



SELECT 
    c.category_id,
    c.category_name,
    p.product_id,
    p.product_name
FROM 
    categories c
FULL OUTER JOIN 
    products p ON c.category_id = p.category_id;


SELECT 
    p.product_id,
    p.product_name,
    c.category_id,
    c.category_name
FROM 
    products p
CROSS JOIN 
    categories c;

SELECT 
    e.employee_id,
    e.first_name || ' ' || e.last_name AS employee_name,
    m.employee_id AS manager_id,
    m.first_name || ' ' || m.last_name AS manager_name
FROM 
    employees e
LEFT JOIN 
    employees m ON e.reports_to = m.employee_id;



SELECT 
    c.customer_id,
    c.company_name
FROM 
    customers c
LEFT JOIN 
    orders o ON c.customer_id = o.customer_id
WHERE 
    o.ship_via IS NULL;

