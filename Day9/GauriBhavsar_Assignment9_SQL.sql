1.      Create AFTER UPDATE trigger to track product price changes
 
CREATE TABLE product_price_audit (
    audit_id SERIAL PRIMARY KEY,
    product_id INT,
    product_name VARCHAR(40),
    old_price DECIMAL(10,2),
    new_price DECIMAL(10,2),
    change_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    user_name VARCHAR(50) DEFAULT CURRENT_USER
)






-- Create a trigger function with the below logic:


CREATE OR REPLACE FUNCTION LOG_NEW_PRODUCT_PRICE()
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
$$ LANGUAGE PLPGSQL;




--Create a row level trigger for below event:


CREATE TRIGGER AFTER_PRODUCT_PRICE_UPDATE
AFTER UPDATE OF unit_price ON products
FOR EACH ROW
EXECUTE FUNCTION LOG_NEW_PRODUCT_PRICE();


--Test the trigger by updating the product price by 10% to any one product_id.


UPDATE PRODUCTS
SET unit_price = unit_price * 1.10
WHERE PRODUCT_ID = 3;


SELECT * FROM product_price_audit;




2.      Create stored procedure  using IN and INOUT parameters to assign tasks to employees






CREATE TABLE IF NOT EXISTS employee_tasks (
        task_id SERIAL PRIMARY KEY,
        employee_id INT,
        task_name VARCHAR(50),
        assigned_date DATE DEFAULT CURRENT_DATE
    );


SELECT * FROM employee_tasks;




CREATE OR REPLACE PROCEDURE assign_task(
    IN p_employee_id INT,
    IN p_task_name VARCHAR(50),
    INOUT p_task_count INT DEFAULT 0
)
LANGUAGE PLPGSQL
AS
$$  
BEGIN


IF NOT EXISTS (SELECT 1 FROM employees WHERE employee_id = p_employee_id) THEN
RAISE EXCEPTION 'Employee ID % does not exist', p_employee_id;
END IF;
        
 INSERT INTO employee_tasks(employee_id,task_name)
 VALUES(1,'Create Reports Test'),
           (2,'Review Reports'),
           (3,'Submit Work Hours'),
           (4,'Set Weekly Meeting'),
           (5,'Update Vacation Tracker');


-- Count tasks assigned to the specific employee
SELECT COUNT(*) INTO p_task_count FROM employee_tasks
WHERE employee_id = employee_tasks.employee_id;
RAISE NOTICE 'Task assigned to employee %. Total tasks now: %',p_employee_id, p_task_count;
END;
$$;


--Calling the stored procedure
CALL assign_task(2,'Review Reports');


SELECT * FROM employee_tasks;