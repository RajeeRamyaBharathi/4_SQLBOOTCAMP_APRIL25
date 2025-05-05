-- 1. Create AFTER UPDATE trigger to track product price changes
--Create product_price_audit table
CREATE TABLE product_price_audit (
    audit_id SERIAL PRIMARY KEY,
    product_id INT,
    product_name VARCHAR(40),
    old_price DECIMAL(10, 2),
    new_price DECIMAL(10, 2),
    change_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    user_name VARCHAR(50) DEFAULT CURRENT_USER);

--Create a trigger function
CREATE OR REPLACE FUNCTION track_product_price_change()
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

--Create a row-level trigger
CREATE TRIGGER product_price_update
AFTER UPDATE OF unit_price ON products
FOR EACH ROW
EXECUTE FUNCTION track_product_price_change();

--Test the trigger by updating the price of a product by 10%
UPDATE products SET unit_price = unit_price * 1.1 WHERE product_id = 1;

SELECT * FROM product_price_audit;
--------------------------------------------------------------------------------------------
-- 2. Create stored procedure using IN and INOUT parameters to assign tasks to employees
-- Create table employee_tasks if it doesn't exist
CREATE TABLE IF NOT EXISTS employee_tasks (
      task_id SERIAL PRIMARY KEY,
      employee_id INT,
      task_name VARCHAR(50),
      assigned_date DATE DEFAULT CURRENT_DATE);

-- Create the stored procedure
CREATE OR REPLACE PROCEDURE assign_task(
    IN p_employee_id INT,
    IN p_task_name VARCHAR(50),
    INOUT p_task_count INT DEFAULT 0)
LANGUAGE plpgsql
AS $$
BEGIN
-- Insert employee_id and task_name into employee_tasks
INSERT INTO employee_tasks (employee_id, task_name) VALUES (p_employee_id, p_task_name);
-- Count total tasks for employee
SELECT COUNT(*) INTO p_task_count FROM employee_tasks WHERE employee_id = p_employee_id;

-- Raise NOTICE message
RAISE NOTICE 'Task "%" assigned to employee %. Total tasks: %',
p_task_name, p_employee_id, p_task_count;
END;
$$;

-- Call the stored procedure
CALL assign_task(1, 'Review Reports');

-- Verify table
SELECT * FROM employee_tasks;