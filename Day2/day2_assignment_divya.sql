ALTER TABLE employees
ADD linkedin_profile VARCHAR(64) NULL;

ALTER TABLE employees
ALTER COLUMN linkedin_profile TYPE TEXT;

ALTER TABLE employees
ALTER COLUMN linkedin_profile SET NOT NULL;

ALTER TABLE employees
ADD CONSTRAINT unique_linkedin_profile UNIQUE (linkedin_profile);

ALTER TABLE employees
DROP COLUMN linkedin_profile;

SELECT employeeName, title
FROM employees;

SELECT DISTINCT unitPrice
FROM products;

SELECT *
FROM customers
ORDER BY companyName ASC;

SELECT productName, unitPrice AS price_in_usd
FROM products;

SELECT *
FROM customers
WHERE country = 'Germany';

SELECT *
FROM customers
WHERE country IN ('France', 'Spain');

SELECT *
FROM orders
WHERE EXTRACT(YEAR FROM orderDate) = 2014
  AND (freight > 50 OR shippedDate IS NOT NULL);

  SELECT productID, productName, unitPrice
FROM products
WHERE unitPrice > 15;


SELECT *
FROM employees
WHERE country = 'USA'
  AND title = 'Sales Representative';

  SELECT *
FROM products
WHERE discontinued = 0
  AND unitPrice > 30;

SELECT *
FROM orders
ORDER BY orderID
LIMIT 10;


SELECT *
FROM orders
ORDER BY orderID
OFFSET 10
LIMIT 10;

SELECT * 
FROM customers
WHERE contactTitle IN ('Sales Representative', 'Owner');

SELECT * 
FROM orders
WHERE orderDate BETWEEN '2013-01-01' AND '2013-12-31';

SELECT * 
FROM products
WHERE categoryID NOT IN (1, 2, 3);

SELECT * 
FROM customers
WHERE companyName LIKE 'A%';

INSERT INTO orders (
    orderID,
    customerID,
    employeeID,
    orderDate,
    requiredDate,
    shippedDate,
    shipperID,
    freight
)
VALUES (
    11078,
    'ALFKI',
    5,
    '2025-04-23',
    '2025-04-30',
    '2025-04-25',
    2,
    45.50
);

UPDATE products
SET unitPrice = unitPrice * 1.10
WHERE categoryID = 2;

















