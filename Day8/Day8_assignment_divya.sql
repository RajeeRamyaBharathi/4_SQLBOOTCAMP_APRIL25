CREATE OR REPLACE VIEW vw_updatable_products AS
SELECT 
    product_id,
    product_name,
    unit_price,
    units_in_stock,
    discontinued
FROM 
    products;
	UPDATE vw_updatable_products
SET unit_price = unit_price * 1.1
WHERE units_in_stock < 10;

SELECT 
    product_id, 
    product_name, 
    unit_price, 
    units_in_stock
FROM 
    products
WHERE 
    units_in_stock < 10;


	BEGIN;

UPDATE products
SET unit_price = unit_price * 1.1
WHERE category_id = 1;

-- View changes before committing
SELECT product_id, product_name, unit_price
FROM products
WHERE category_id = 1;

COMMIT;

ROLLBACK;


CREATE VIEW vw_employee_territories AS
SELECT
    e.employee_id,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_full_name,
    e.title,
    t.territory_id,
    t.territory_description,
    r.region_description
FROM employees e
JOIN employee_territories et ON e.employee_id = et.employee_id
JOIN territories t ON et.territory_id = t.territory_id
JOIN region r ON t.region_id = r.region_id;


SELECT * FROM vw_employee_territories;

WITH RECURSIVE employee_hierarchy AS (
    -- Anchor member: Top-level employees (no manager)
    SELECT 
        employee_id,
        first_name,
        last_name,
        reports_to AS manager_id,
        1 AS level
    FROM employees
    WHERE reports_to IS NULL

    UNION ALL

    -- Recursive member: Employees reporting to someone in the hierarchy
    SELECT 
        e.employee_id,
        e.first_name,
        e.last_name,
        e.reports_to AS manager_id,
        eh.level + 1
    FROM employees e
    JOIN employee_hierarchy eh ON e.reports_to = eh.employee_id
)


SELECT * 
FROM employee_hierarchy
ORDER BY level, manager_id, employee_id;


