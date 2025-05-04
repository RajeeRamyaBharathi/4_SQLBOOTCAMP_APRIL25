--Assignment  9
--1.Triggers
--Create product_price_audit table
CREATE TABLE product_price_audit (
    audit_id SERIAL PRIMARY KEY,
    product_id INT,
    product_name VARCHAR(40),
    old_price DECIMAL(10,2),
    new_price DECIMAL(10,2),
    change_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    user_name VARCHAR(50) DEFAULT CURRENT_USER
);
--Create the trigger function
CREATE OR REPLACE FUNCTION log_product_price_change()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO product_price_audit (
        product_id,
        product_name,
        old_price,
        new_price
    )
    VALUES (
        OLD.product_id,
        OLD.product_name,
        OLD.unit_price,
        NEW.unit_price
    );

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
--Create the trigger
CREATE TRIGGER trg_product_price_change
AFTER UPDATE OF unit_price ON products
FOR EACH ROW
WHEN (OLD.unit_price IS DISTINCT FROM NEW.unit_price)
EXECUTE FUNCTION log_product_price_change();
--Test the trigger by updating product price
SELECT product_id, product_name, unit_price FROM products;
SELECT product_id, product_name, unit_price FROM products LIMIT 5;
--update one product’s price by 10% (replace 7 with actual ID)
UPDATE products
SET unit_price = unit_price * 1.10
WHERE product_id = 7;
--Check the audit log
SELECT * FROM product_price_audit ORDER BY change_date DESC;


--2.stored procedure  using IN and INOUT parameters
--Create the table
CREATE TABLE IF NOT EXISTS employee_tasks (
    task_id SERIAL PRIMARY KEY,
    employee_id INT,
    task_name VARCHAR(50),
    assigned_date DATE DEFAULT CURRENT_DATE
);
--Create the stored procedure
CREATE OR REPLACE PROCEDURE assign_task(
    IN p_employee_id INT,
    IN p_task_name VARCHAR(50),
    INOUT p_task_count INT DEFAULT 0
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Insert the task
    INSERT INTO employee_tasks (employee_id, task_name)
    VALUES (p_employee_id, p_task_name);

    -- Count total tasks for the employee
    SELECT COUNT(*) INTO p_task_count
    FROM employee_tasks
    WHERE employee_id = p_employee_id;

    -- Output message
    RAISE NOTICE 'Task "%" assigned to employee %. Total tasks: %',
        p_task_name, p_employee_id, p_task_count;
END;
$$;
--Call the procedure to assign a task
CALL assign_task(1, 'Review Reports');
--see the returned task count
DO $$
DECLARE
    task_total INT := 0;
BEGIN
    CALL assign_task(1, 'Review Reports', task_total);
    RAISE NOTICE 'Returned task count: %', task_total;
END;
$$;
--Check the data
SELECT * FROM employee_tasks WHERE employee_id = 1 ORDER BY assigned_date DESC;













