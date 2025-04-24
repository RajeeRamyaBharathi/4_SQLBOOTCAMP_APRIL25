
-- 1.ALTER TABLE
-- Add a new column linkedin_profile to employees table
ALTER TABLE employees 
ADD COLUMN linkedin_profile VARCHAR(255) UNIQUE;

ALTER TABLE employees
DROP COLUMN linkedin_profile;

ALTER TABLE employees
ADD COLUMN linkedin_profile
GENERATED ALWAYS AS ('https://www.linkedin.com/'|| "employeeName") STORED;

--Change the linkedin_profile column data type from VARCHAR to TEXT
ALTER TABLE employees
ALTER COLUMN linkedin_profile
SET DATA TYPE TEXT;

--Add unique constraint to linkedin_profile
ALTER TABLE employees
ADD CONSTRAINT not_null UNIQUE(linkedin_profile);

--Add not null constraint to linkedin_profile
ALTER TABLE employees
ALTER COLUMN linkedin_profile SET NOT NULL;

select * from employees;

--Drop column linkedin_profile
ALTER TABLE employees
DROP COLUMN linkedin_profile;


-- 2. Querying (Select)
SELECT "employeeName",title FROM employees;

SELECT DISTINCT "unitPrice" FROM products;

SELECT "contactName","companyName" FROM customers
ORDER BY "companyName" ASC;

SELECT "productName","unitPrice" AS price_in_usd
FROM products;


-- 3. Filtering

select * FROM customers 
WHERE country='Germany';

select * FROM customers 
WHERE country='France' OR country='Spain';

SELECT * FROM orders
WHERE EXTRACT(YEAR FROM CAST("orderDate" AS date)) = 2014 AND 
("freight">50 OR "shippedDate" IS NOT NULL); 


-- 4. Filtering
SELECT "productID","productName","unitPrice" FROM products
WHERE "unitPrice" > 15;

SELECT * FROM employees
WHERE "title" = 'Sales Representative' AND "country" = 'USA';

SELECT * FROM products;

SELECT * FROM products
WHERE "discontinued" = 'false' AND "unitPrice" > 30;


-- 5. LIMIT/FETCH
SELECT * FROM orders
LIMIT 10;

SELECT * FROM orders LIMIT 10 OFFSET 10; 


-- 6. Filtering (IN, BETWEEN)
SELECT "contactName","contactTitle" FROM customers
WHERE "contactTitle" = 'Sales Representative' OR  "contactTitle" = 'Owner'
ORDER BY "contactName" ASC;

SELECT * FROM orders
WHERE "orderDate" BETWEEN '2013-01-01' AND '2013-12-31';


-- 7. Filtering
SELECT * FROM products
WHERE "categoryID" NOT IN ('1','2','3')
ORDER BY "categoryID" ASC;

SELECT * FROM customers
WHERE "companyName" LIKE 'A%';


-- 8.   INSERT into orders table:
INSERT INTO orders("orderID","customerID","employeeID","orderDate","requiredDate","shippedDate","shipperID","freight")
VALUES (11078,'ALFKI',5,'2025-04-23','2025-04-30','2025-04-25',2,45.50);

SELECT * FROM orders;


-- 9. Increase(Update)  the unit price of all products in category_id =2 by 10%
UPDATE products
SET "unitPrice" = "unitPrice" * 1.10
WHERE "categoryID" = 2; 

SELECT * FROM products;