/*1.Create AFTER UPDATE trigger to track product price changes
Test the trigger by updating the product price by 10% to any one product_id.*/

CREATE TABLE product_price_audit (
	audit_id SERIAL PRIMARY KEY,
    product_id INT,
    product_name VARCHAR(40),
    old_price DECIMAL(10,2),
    new_price DECIMAL(10,2),
    change_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    user_name VARCHAR(50) DEFAULT CURRENT_USER
);


CREATE OR REPLACE FUNCTION trigger_update_price()
  RETURNS TRIGGER
  LANGUAGE PLPGSQL
  AS
$$
BEGIN
	IF NEW.unit_price <> OLD.unit_price THEN
		 INSERT INTO product_price_audit(product_id,product_name,old_price, new_price)
		 VALUES(OLD.product_id,OLD.product_name,OLD.unit_price,NEW.unit_price);
	END IF;
	RETURN NEW;
END;
$$


CREATE TRIGGER price_update
  AFTER UPDATE OF unit_price 
  ON products
  FOR EACH ROW
  EXECUTE PROCEDURE trigger_update_price();

SELECT * FROM products WHERE product_id = 3;


UPDATE products
SET unit_price = unit_price * 1.1
WHERE product_id = 3;

SELECT * FROM products WHERE product_id = 3;

SELECT * FROM product_price_audit WHERE product_id = 3;


/*2.Create stored procedure using IN and INOUT parameters to assign tasks to employees.
Parameters:
IN p_employee_id INT,
IN p_task_name VARCHAR(50),
INOUT p_task_count INT DEFAULT 0 */

CREATE TABLE IF NOT EXISTS employee_tasks(
        task_id SERIAL PRIMARY KEY,
        employee_id INT,
        task_name VARCHAR(50),
        assigned_date DATE DEFAULT CURRENT_DATE
);
SELECT * FROM employee_tasks;

--Create a stored procedure that counts total tasks for employees put the total count into p_task_count
CREATE OR REPLACE PROCEDURE assign_task(
    IN p_employee_id INT,	
	IN p_task_name VARCHAR(50),				-- Input parameter
    INOUT p_task_count INT	DEFAULT 0		-- Input/Output parameter
)
LANGUAGE PLPGSQL
AS
$$  
BEGIN
    -- Ensure the employee exists
    IF NOT EXISTS (SELECT 1 FROM employees WHERE employee_id = p_employee_id) THEN
        RAISE EXCEPTION 'Employee ID % does not exist', p_employee_id;
    END IF;
-- INSERT INTO employee_tasks (employee_id, task_name) VALUES (employee_id, 'Task_Name'); 
         INSERT INTO employee_tasks(employee_id,task_name)
		 VALUES(1,'Sales'),
		 	(2,'CustomerSuccess'),
		 	(3,'Manager'),
		 	(4,'Softwatre Development'),
		 	(5,'HR'),
			(6,'Software Testing'),
			(7,'Tech Lead'),
			(8,'CustomerSuccess'),
			(9,'Admin');

-- Count tasks assigned to the specific employee
    SELECT COUNT(*) INTO p_task_count FROM employee_tasks WHERE employee_id = employee_tasks.employee_id;
-- Raise NOTICE message:
    RAISE NOTICE 'Task assigned to employee %. Total tasks now: %', 
	p_employee_id, p_task_count;
END;
$$;

--Calling the stored procedure
CALL assign_task(3,'Software Development');

SELECT * FROM employee_tasks;




