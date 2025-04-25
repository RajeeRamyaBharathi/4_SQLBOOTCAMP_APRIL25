--1) Update the categoryName From “Beverages” to "Drinks" in the categories table.
SELECT * FROM categories

UPDATE categories
SET categoryName = 'Drinks'
WHERE categoryName = 'Beverages';
 
--2) Insert into shipper new record (give any values) Delete that new record from shippers table.
SELECT * FROM shippers

INSERT INTO shippers 
VALUES ('4','UPS');

DELETE FROM shippers
WHERE shipperID = '4';
 
--3) Update categoryID=1 to categoryID=1001. Make sure related products update their categoryID too.
--Display the both category and products table to show the cascade.

ALTER TABLE products
DROP CONSTRAINT IF EXISTS products_categoryid_fkey;

ALTER TABLE products
ADD CONSTRAINT products_categoryid_fkey
FOREIGN KEY (categoryID) REFERENCES categories (categoryID)
ON UPDATE CASCADE
ON DELETE CASCADE;

UPDATE categories
SET categoryID = 1001
WHERE categoryID = 1;

SELECT * FROM categories;
SELECT * FROM products;

-- Delete the categoryID= “3”  from categories. Verify that the corresponding records are deleted automatically from products.
-- (HINT: Alter the foreign key on products(categoryID) to add ON UPDATE CASCADE, ON DELETE CASCADE)

DELETE FROM categories
WHERE categoryID = 3;

ALTER TABLE order_details
DROP CONSTRAINT IF EXISTS order_details_productid_fkey

ALTER TABLE order_details
ADD CONSTRAINT order_details_productid_fkey
FOREIGN KEY (productID) REFERENCES products (productID)
ON DELETE SET NULL;

SELECT * FROM order_details

--4)Delete the customer = “VINET”  from customers. Corresponding customers in orders table should be set to null (HINT: Alter the foreign key on orders(customerID) to use ON DELETE SET NULL)
ALTER TABLE orders
DROP CONSTRAINT IF EXISTS orders_customerid_fkey;

ALTER TABLE orders
ADD CONSTRAINT orders_customerid_fkey
FOREIGN KEY (customerID) REFERENCES customers (customerID)
ON DELETE SET NULL;

Delete FROM customers
WHERE customerID = 'VINET';

SELECT * FROM customers
 
--5)Insert the following data to Products using UPSERT:
--product_id = 100, product_name = Wheat bread, quantityperunit=1,unitprice = 13, discontinued = 0, categoryID=5
--product_id = 101, product_name = White bread, quantityperunit=5 boxes,unitprice = 13, discontinued = 0, categoryID=5
--product_id = 100, product_name = Wheat bread, quantityperunit=10 boxes,unitprice = 13, discontinued = 0, categoryID=5
--(this should update the quantityperunit for product_id = 100)
SELECT * FROM products WHERE productID IN (100,101,100)

INSERT INTO products (productID, productName, quantityPerUnit, unitPrice, discontined, categoryID)
VALUES (100, 'Wheat bread', '1', 13, 0, 5)
ON CONFLICT (productID) DO UPDATE
SET   
    quantityPerUnit = EXCLUDED.quantityPerUnit
    

INSERT INTO products (productID, productName, quantityPerUnit, unitPrice, discontined, categoryID)
VALUES (101, 'White bread', '5 boxes', 13, 0, 5)
ON CONFLICT (productID) DO UPDATE
SET
    productName = EXCLUDED.productName,
    quantityPerUnit = EXCLUDED.quantityPerUnit,
    unitPrice = EXCLUDED.unitPrice,
    discontined = EXCLUDED.discontined,
    categoryID = EXCLUDED.categoryID;

INSERT INTO products (productID, productName, quantityPerUnit, unitPrice, discontined, categoryID)
VALUES (100, 'Wheat bread', '10 boxes', 13, 0, 5)
ON CONFLICT (productID) DO UPDATE
SET    
    quantityPerUnit = EXCLUDED.quantityPerUnit

SELECT * FROM categories  

--6)Write a MERGE query:
--Create temp table with name:  ‘updated_products’ and insert values as below:
CREATE TEMP TABLE updated_products (productID INT, productName TEXT, quantityPerunit TEXT, unitPrice REAL,discontined INT, categoryId INT) 

INSERT INTO
  updated_products(productID, productName, quantityPerunit, unitPrice, discontined, categoryId)
VALUES
    (100, 'Wheat bread', '10', 20, 1, 5),
    (101, 'White bread', '5 boxes', 19.99, 0, 5),
    (102, 'Midnight Mango Fizz', '24 - 12 oz bottles', 19, 0, 1),
    (103, 'Savory Fire Sauce', '12 - 550 ml bottles', 10, 0, 2);

SELECT * FROM updated_products
SELECT * FROM products

--Update the price and discontinued status for from below table ‘updated_products’ only if there are matching products and updated_products .discontinued =0 
--If there are matching products and updated_products .discontinued =1 then delete 
--Insert any new products from updated_products that don’t exist in products only if updated_products .discontinued =0.

MERGE INTO products p
USING updated_Products u
 ON p.productID = u.productID
WHEN MATCHED AND u.discontined = 0 THEN
 UPDATE SET
        unitPrice = u.unitPrice,
        discontined =u.discontined
WHEN MATCHED AND u.discontined = 1 THEN
 DELETE
WHEN NOT MATCHED AND u.discontined = 0 THEN
    INSERT (productID,productName, quantityPerUnit, unitPrice, discontined, categoryID)
    VALUES (u.productID, u.productName, u.quantityPerUnit, u.unitPrice, u.discontined, u.categoryID);

SELECT * FROM products WHERE productID IN (100,101,102,103);

-------------------------------------------------------------------------------------------------------------------
--USED NEW northwind DB

--7)List all orders with employee full names. (Inner join)

SELECT o.order_id, o.order_date,e.first_name || ' ' || e.last_name AS employeefull_name
FROM orders o
INNER JOIN employees e ON o.employee_id = e.employee_id;





