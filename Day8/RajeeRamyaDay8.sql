--Assignment  8
--1.Create view vw_updatable_products (use same query whatever I used in the training)
--Try updating view with below query and see if the product table also gets updated.
--Update query:UPDATE updatable_products SET unit_price = unit_price * 1.1 WHERE units_in_stock < 10;
--Create the view
CREATE VIEW vw_updatable_products AS
SELECT product_id, product_name, unit_price, units_in_stock
FROM products;
--Update query
UPDATE vw_updatable_products
SET unit_price = unit_price * 1.1
WHERE units_in_stock < 10;
--check if the base table products was updated 
SELECT product_id, product_name, unit_price, units_in_stock
FROM products
WHERE units_in_stock < 10;

--2.Transaction:Update the product price for products by 10% in category id=1.Try COMMIT and ROLLBACK and observe what happens.
--Start the transaction and run the update
BEGIN;
UPDATE products
SET unit_price = unit_price * 1.1
WHERE category_id = 1;
--Preview the changes
SELECT product_id, product_name, unit_price
FROM products
WHERE category_id = 1;
--committing the transaction
COMMIT;
--rollback
ROLLBACK;

--3.Create a regular view which will have below details 
--(Need to do joins):Employee_id,Employee_full_name,Title,Territory_id,territory_description,region_description
CREATE VIEW vw_employee_hierarchy AS 
WITH RECURSIVE employee_hierarchy AS
SELECT e.employee_id,
    e.first_name || ' ' || e.last_name AS employee_full_name,
    e.title,
    t.territory_id,
    t.territory_description,
    r.region_description
FROM   employees e
JOIN employee_territories et ON e.employee_id = et.employee_id
JOIN territories t ON et.territory_id = t.territory_id
JOIN region r ON t.region_id = r.region_id;
--preview
SELECT * FROM vw_employee_territories;


--4.Create a recursive CTE based on Employee Hierarchy
WITH RECURSIVE employee_hierarchy AS (
-- Anchor member: top-level employees (no manager)
    SELECT 
        employee_id,
        first_name || ' ' || last_name AS employee_name,
        reports_to,
        1 AS level
    FROM employees
    WHERE reports_to IS NULL
    UNION ALL
-- Recursive member: employees reporting to others
    SELECT 
        e.employee_id,
        e.first_name || ' ' || e.last_name,
        e.reports_to,
        eh.level + 1
    FROM employees e
    INNER JOIN employee_hierarchy eh ON e.reports_to = eh.employee_id
)
SELECT * FROM employee_hierarchy
ORDER BY level, employee_id;

