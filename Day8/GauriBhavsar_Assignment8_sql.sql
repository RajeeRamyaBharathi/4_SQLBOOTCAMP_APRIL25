--1.     Create view vw_updatable_products (use same query whatever I used in the training)
--Try updating view with below query and see if the product table also gets updated.
--Update query:
--UPDATE updatable_products SET unit_price = unit_price * 1.1 WHERE units_in_stock < 10;


CREATE VIEW vw_updatable_products AS
SELECT product_id, product_name,unit_price,units_in_stock,discontinued
FROM products
WHERE discontinued = 0


select * from products where discontinued = 0 AND units_in_stock < 10;


UPDATE vw_updatable_products SET unit_price = unit_price * 1.1 WHERE units_in_stock < 10;


select * from vw_updatable_products where discontinued = 0 AND units_in_stock < 10;


2.     Transaction:
Update the product price for products by 10% in category id=1
Try COMMIT and ROLLBACK and observe what happens


BEGIN;
UPDATE products
SET unit_price = unit_price * 1.10
WHERE category_id = 1;
--check if any product price exceeds $50, if yes- rollback, if no- commit
DO $$
BEGIN
    IF EXISTS (
        SELECT 1
                FROM products
                WHERE category_id = 1
        )  
        THEN
    END IF;
END $$;
--commit the transaction (only if not already rolled back)
COMMIT;


ROLLBACK;


SELECT * FROM products WHERE category_id = 1;


3.     Create a regular view which will have below details (Need to do joins):
Employee_id,
Employee_full_name,
Title,
Territory_id,
territory_description,
region_description
CREATE VIEW employee_view AS
SELECT
e.employee_id,
concat(e.first_name,'',e.last_name) AS employee_full_name,
e.title,
t.territory_id,
t.territory_description,
r.region_description
FROM employees e
JOIN employee_territories et ON e.employee_id = et.employee_id
JOIN territories t ON et.territory_id = t.territory_id
JOIN region r ON t.region_id = r.region_id;


SELECT * FROM employee_view;


4.     Create a recursive CTE based on Employee Hierarchy
WITH RECURSIVE cte_employeehierarchy AS (
    -- Base case: employee with no manager(top level)
SELECT 
   employee_id, 
   first_name,
   last_name,
   reports_to,
   0 as level
FROM
   employees e
WHERE
    reports_to IS NULL
UNION ALL
-- Recursive case: employees reporting to managers 
SELECT 
    e.employee_id, 
    e.first_name,
        e.last_name, 
    e.reports_to, 
    eh.level+1
FROM employees e
JOIN cte_employeehierarchy eh ON eh.employee_id = e.reports_to
)


SELECT 
    level,
        employee_id,
        first_name || '' || last_name as employee_name
FROM cte_employeehierarchy ORDER BY level, employee_id;