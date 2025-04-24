1)      Alter Table:
*  Add a new column linkedin_profile to employees table to store LinkedIn URLs as varchar.
* Change the linkedin_profile column data type from VARCHAR to TEXT.
*  Add unique, not null constraint to linkedin_profile
* Drop column linkedin_profile


ALTER TABLE employees
ADD COLUMN "linkedin_profile" VARCHAR;


ALTER TABLE employees
ALTER COLUMN "linkedin_profile" TYPE TEXT;


SELECT * FROM employees;


UPDATE employees SET "linkedin_profile" = 'linkedin.COM/'||"employeeID"
ALTER TABLE employees
ALTER COLUMN "linkedin_profile" SET NOT NULL;


SELECT * FROM employees;


ALTER TABLE employees
ADD CONSTRAINT unique_linkedin_profile UNIQUE (linkedin_profile);


SELECT * FROM employees; 


ALTER TABLE employees
DROP COLUMN linkedin_profile;


2)      Querying (Select)
*  Retrieve the employee name and title of all employees
*  Find all unique unit prices of products
*  List all customers sorted by company name in ascending order
*  Display product name and unit price, but rename the unit_price column as price_in_usd


SELECT  "employeeName", "title"
        FROM public.employees;


        SELECT DISTINCT "unitPrice"
FROM public.products;


SELECT *
FROM customers
ORDER BY "companyName" ASC;




SELECT "productName", "unitPrice" AS price_in_usd
FROM products;


3)      Filtering
* Get all customers from Germany.
* Find all customers from France or Spain
* Retrieve all orders placed in 2014(based on order_date), and either have freight greater than 50 or the shipped date available (i.e., non-NULL)  (Hint: EXTRACT(YEAR FROM order_date))


SELECT *
FROM customers
WHERE "country" = 'Germany';


SELECT *
FROM customers
WHERE "country" IN ('France', 'Spain');


SELECT *
FROM orders
WHERE EXTRACT(YEAR FROM "orderDate") = 2014
  AND ("freight" > 50 OR "shippedDate" IS NOT NULL);


4)      Filtering
*  Retrieve the product_id, product_name, and unit_price of products where the unit_price is greater than 15.
* List all employees who are located in the USA and have the title "Sales Representative".
* Retrieve all products that are not discontinued and priced greater than 30.


SELECT "productId", "productName", "unitPrice"
FROM products
WHERE "unitPrice" > 15;


SELECT *
FROM employees
WHERE "country" = 'USA' AND "title" = 'Sales Representative'


SELECT *
FROM products
WHERE "discontinued" = 0 AND "unitPrice" > 30;


5)      LIMIT/FETCH
*  Retrieve the first 10 orders from the orders table.
*  Retrieve orders starting from the 11th order, fetching 10 rows (i.e., fetch rows 11-20).
 
SELECT *
FROM orders
LIMIT 10;


SELECT *
FROM orders
OFFSET 10
LIMIT 10;

6)      Filtering (IN, BETWEEN)
* List all customers who are either Sales Representative, Owner
* Retrieve orders placed between January 1, 2013, and December 31, 2013.
SELECT *
FROM employees
WHERE "title" IN ('Sales Representative', 'Owner');


SELECT *
FROM orders
WHERE "orderDate" BETWEEN '2013-01-01' AND '2013-12-31';


7)      Filtering
* List all products whose category_id is not 1, 2, or 3.
* Find customers whose company name starts with "A".

SELECT *
FROM public.products
WHERE "categoryID" NOT IN (1, 2, 3);

SELECT *
FROM customers
WHERE "companyName" LIKE 'A%';

8)       INSERT into orders table:

 Task: Add a new order to the orders table with the following details:
Order ID: 11078
Customer ID: ALFKI
Employee ID: 5
Order Date: 2025-04-23
Required Date: 2025-04-30
Shipped Date: 2025-04-25
shipperID:2
Freight: 45.50


INSERT INTO orders ("orderID", "customerID", "employeeID", "orderDate", "requiredDate", "shippedDate", "shipperID", "freight")
VALUES (11078, 'ALFKI', 5, '2025-04-23', '2025-04-30', '2025-04-25', 2, 45.50);


SELECT * FROM orders;

9)      Increase(Update)  the unit price of all products in category_id =2 by 10%.
(HINT: unit_price =unit_price * 1.10)


UPDATE products
SET "unitPrice" = "unitPrice" * 1.10
WHERE "categoryID" = 2;


SELECT * 
FROM products
WHERE "categoryID" = 2;