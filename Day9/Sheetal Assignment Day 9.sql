set search_path = public

----Validate if the table exists
CREATE TABLE IF NOT EXISTS employee_tasks(
task_id SERIAL PRIMARY KEY,
employee_id INT,
task_name VARCHAR(50),
assigned_date DATE DEFAULT CURRENT_DATE
);

-----Create Stored Procedure
CREATE OR REPLACE PROCEDURE assign_tasks(
-----Input parameters
IN p_employee_id INT,
IN p_task_name VARCHAR(50),

----Output parameters
INOUT p_task_count INT Default 0)
LANGUAGE plpgsql

AS $$
BEGIN

insert into employee_tasks(employee_id,task_name)
values(p_employee_id,p_task_name);

----calculate total tasks for each employee
SELECT
COUNT(*)::INT
INTO p_task_count
FROM employee_tasks
where employee_id = p_employee_id 
AND
task_name = p_task_name;
 
---Raise Notice

RAISE NOTICE 'Task "%" assigned to employee %. Total tasks: %',
   p_task_name, p_employee_id, p_task_count;

END
$$;

----Testing the created procedure
CALL assign_tasks(1, 'Review Reports')

SELECT * FROM employee_tasks WHERE employee_id = 1

-----create product_price_audit table 
create table if not exists product_price_audit(
audit_id SERIAL PRIMARY KEY,
product_id INT,
product_name VARCHAR(40),
old_price DECIMAL(10,2),
new_price DECIMAL(10,2),
change_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
user_name VARCHAR(50) DEFAULT CURRENT_USER
);

-----Defining the function
CREATE FUNCTION log_price_changes()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO product_price_audit (
        product_id,
        product_name,
        old_price,
        new_price
    ) VALUES (
        OLD.product_id,
        OLD.product_name,
        OLD.unit_price,
        NEW.unit_price
    );

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-------create Trigger

CREATE OR REPLACE TRIGGER track_price_changes
AFTER UPDATE OF unit_price ON products
FOR EACH ROW 
WHEN(OLD.unit_price <> NEW.unit_price)
EXECUTE FUNCTION log_price_changes()

select * from products

update products
set unit_price = unit_price *1.10
where product_id = 3

SELECT * FROM product_price_audit ORDER BY change_date DESC;





