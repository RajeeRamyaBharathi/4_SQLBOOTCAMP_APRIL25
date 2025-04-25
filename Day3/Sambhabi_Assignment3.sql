SELECT * FROM categories;

-- 1. Update the categoryName From “Beverages” to "Drinks" in the categories table.
UPDATE categories
SET "category_name" = 'Drinks'
WHERE "category_name" = 'Beverages';

SELECT * FROM categories;

-- 2.  Insert into shipper new record (give any values) Delete that new record from shippers table.

SELECT * FROM shippers;

INSERT INTO shippers(shipper_id,company_name,phone)
VALUES (7,'USPS','(803)777-2040');

DELETE FROM shippers
WHERE shipper_id = 7;


-- 3.  Update categoryID=1 to categoryID=1001. Make sure related products update their categoryID too. 
--Display the both category and products table to show the cascade.

SELECT * FROM products
WHERE category_id = 3;

ALTER TABLE products
DROP CONSTRAINT IF EXISTS fk_products_categories;

ALTER TABLE products
ADD CONSTRAINT fk_products_categories
FOREIGN KEY (category_id)
REFERENCES categories(category_id)
ON UPDATE CASCADE
ON DELETE CASCADE;

UPDATE categories
SET category_id = 1001
WHERE category_id = 1;

--  Delete the categoryID= “3”  from categories. Verify that the corresponding records are deleted automatically from products.

ALTER TABLE order_details
DROP CONSTRAINT IF EXISTS fk_order_details_products;

ALTER TABLE order_details
ADD CONSTRAINT fk_order_details_products
FOREIGN KEY (product_id)
REFERENCES products(product_id)
ON UPDATE CASCADE
ON DELETE CASCADE;

DELETE FROM categories
WHERE category_id = 3;

SELECT * FROM products
WHERE category_id = 3;

SELECT * FROM categories
WHERE category_id = 3;


--4. Delete the customer = “VINET”  from customers. Corresponding customers in orders table should be set to null.

SELECT * FROM customers
WHERE customer_id = 'VINET';

DELETE FROM customers
WHERE customer_id = 'VINET';

ALTER TABLE orders
DROP CONSTRAINT IF EXISTS fk_orders_customers;

ALTER TABLE orders
ADD CONSTRAINT fk_orders_customers
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id)
ON DELETE SET NULL;

SELECT * FROM orders
WHERE order_id IN (10248,10274,10295,10737,10739);


-- 5. Inserting data to Products using UPSERT:

INSERT INTO products(product_id,product_name,quantity_per_unit,unit_price,discontinued,category_id)
VALUES 
(100,'Wheat Bread',1,13,0,5),
(101,'White Bread',5,13,0,5);

SELECT * FROM products;

INSERT INTO products(product_id,product_name,quantity_per_unit,unit_price,discontinued,category_id)
VALUES 
(100,'Wheat Bread',10,13,0,5)
ON CONFLICT (product_id)
DO UPDATE
SET quantity_per_unit = 10;

SELECT * FROM products;

INSERT INTO products(product_id,product_name,quantity_per_unit,unit_price,discontinued,category_id)
VALUES 
(100,'Wheat Bread',15,13,0,5)
ON CONFLICT (product_id)
DO UPDATE
SET quantity_per_unit = EXCLUDED.quantity_per_unit;

-- 6. MERGE query to update/insert/delete values
CREATE TEMP TABLE updated_products(
"productID" INTEGER PRIMARY KEY NOT NULL,
"productName" VARCHAR(100) NOT NULL,
"quantityPerUnit" VARCHAR(100) NOT NULL,
"unitPrice" DECIMAL(10,2) NOT NULL,
"discontinued" INT NOT NULL,
"categoryID" INT NOT NULL
);
SELECT * FROM updated_products;
DROP TABLE updated_products;

INSERT INTO updated_products("productID","productName","quantityPerUnit","unitPrice","discontinued","categoryID")
VALUES
		(100,'Wheat Bread',10,20,1,5),
		(101,'White Bread','5 boxes',19.99,0,5),
		(102,'Midnight Mango Fizz','24-12 oz bottles',19,0,1),
		(103,'Savory Fire Sauce','12-550ml bottles',10,0,2);


UPDATE categories
SET category_id = 1
WHERE category_id = 1001;

SELECT * FROM categories;

-- MERGE updated_products into products
MERGE INTO products p
USING updated_products up
ON p."product_id" = up."productID"
WHEN MATCHED AND up.discontinued = 0 THEN 
	UPDATE SET
		"unit_price" = up."unitPrice",
		"discontinued" = up."discontinued"
WHEN MATCHED AND up."discontinued" = 1 THEN 
	DELETE
WHEN NOT MATCHED AND up."discontinued" = 0 THEN
	INSERT("product_id","product_name","quantity_per_unit","unit_price","discontinued","category_id")
	VALUES(up."productID",up."productName",up."quantityPerUnit",up."unitPrice",up."discontinued",up."categoryID");

SELECT * FROM products WHERE "product_id" IN (100,101,102,103);

-- 7.  List all orders with employee full names. (Inner join)
SELECT * FROM employees;
SELECT * FROM orders;

SELECT order_id, 
	   order_date,
	   first_name || ' ' || last_name AS "Full_Name"
FROM orders
INNER JOIN employees
ON orders.employee_id = employees.employee_id;
