--Day 9 Assignment
--Triggers
  -- Create AFTER UPDATE trigger to track product price changes
  --Create product_price_audit table
  --  Create a trigger function
 -- Step 1
  --Create the product_price_audit table
  CREATE TABLE product_price_audit (
    audit_id SERIAL PRIMARY KEY,
    product_id INT,
    product_name VARCHAR(40),
    old_price DECIMAL(10,2),
    new_price DECIMAL(10,2),
    change_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    user_name VARCHAR(50) DEFAULT CURRENT_USER
);
  --Step 2
  CREATE OR REPLACE FUNCTION log_price_changes()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO product_price_audit (
        product_id,
        product_name,
        old_price,
        new_price
    )
    VALUES (
        OLD.producti_d,
        OLD.product_name,
        OLD.unit_price,
        NEW.unit_price
    );
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
--Step 3 Create AFTER UPDATE trigger on products
CREATE TRIGGER trg_log_price_update
AFTER UPDATE OF unit_price ON products
FOR EACH ROW
WHEN (OLD.unit_price IS DISTINCT FROM NEW.unit_price)
EXECUTE FUNCTION log_price_changes();
--Test the trigger by updating product price
SELECT product_id, product_name, unit_price FROM products;
SELECT product_id, product_name, unit_price FROM products LIMIT 5;
--Step 4 Test the trigger
UPDATE products
SET unit_price = unit_price * 1.10
WHERE product_id = 9;  --
Replace with a valid product ID
SELECT * FROM product_price_audit;
--2.Step 1 CREATE TABLE IF NOT EXISTS employee_tasks (
    task_id SERIAL PRIMARY KEY,
    employee_id INT,
    task_name VARCHAR(50),
    assigned_date DATE DEFAULT CURRENT_DATE
);

CREATE TABLE IF NOT EXISTS employee_tasks (
    task_id SERIAL PRIMARY KEY,
    employee_id INT,
    task_name VARCHAR(50),
    assigned_date DATE DEFAULT CURRENT_DATE
);

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

    -- Count the number of tasks assigned to this employee
    SELECT COUNT(*) INTO p_task_count
    FROM employee_tasks
    WHERE employee_id = p_employee_id;

    -- Show a notice
    RAISE NOTICE 'Task "%" assigned to employee %. Total tasks: %',
        p_task_name, p_employee_id, p_task_count;
END;
$$;
--
CALL assign_task(1, 'Review Reports');

DO $$
DECLARE
    v_count INT := 0;
BEGIN
    CALL assign_task(1, 'Complete Budget Review', v_count);
    RAISE NOTICE 'Updated task count: %', v_count;
END;
$$;
