--Day 3 Assignment
USE Northwind from Kaggle:
-- 1)   Update the categoryName From “Beverages” to "Drinks" in the categories table.
UPDATE "categories"
SET "categoryName" = 'Drinks'
WHERE "categoryName" = 'Beverages';
SELECT * FROM "categories";
--2)      Insert into shipper new record (give any values) Delete that new record from shippers table.
   --Insert into shipper new record 
   INSERT INTO "shippers" ("shipperID", "companyName")
VALUES (959, 'Speedy Express');
SELECT *FROM "shippers";
--Delete that new record from shippers
DELETE FROM "shippers"
WHERE "shipperID" = 959;
--3) Update categoryID=1 to categoryID=1001. Make sure related products update their categoryID too. Display the both category and products table to show the cascade.
 --Delete the categoryID= “3”  from categories. Verify that the corresponding records are deleted automatically from products.
-- (HINT: Alter the foreign key on products(categoryID) to add ON UPDATE CASCADE, ON DELETE CASCADE)
 ---- Drop the existing foreign key (replace the constraint name with the actual one)
ALTER TABLE "products"
DROP CONSTRAINT IF EXISTS fk_categoryID;

-- Add the new foreign key with cascade behavior
ALTER TABLE "products"
ADD CONSTRAINT fk_categoryID
FOREIGN KEY ("categoryID")
REFERENCES categories("categoryID")
ON UPDATE CASCADE
ON DELETE CASCADE;

--Update categoryID = 1 to 1001
UPDATE "categories"
SET "categoryID" = 1001
WHERE "categoryID" = 1;

--Display updated tables
SELECT * FROM categories;
SELECT * FROM "products" WHERE "categoryID" = 1001;
-- Delete categoryID = 3 (and cascade delete its products)
DELETE FROM categories
WHERE categoryID = 3;
--Verify Delete
SELECT * FROM products WHERE categoryID = 3;


--4)Delete the customer = “VINET”  from customers. Corresponding customers in orders table should be set to null (HINT: Alter the foreign key on orders(customerID) to use ON DELETE SET NULL)
 ALTER TABLE "orders"
ALTER COLUMN customerID DROP NOT NULL ;
--Add new FK with ON DELETE SET NULL
ALTER TABLE "orders"
ADD CONSTRAINT "fk_customerID"
FOREIGN KEY ("customerID")
REFERENCES "customers"("customerID")
ON DELETE SET NULL;
-- Delete the customer VINET
DELETE FROM "customers"
WHERE "customerID" = 'VINET';
-- Verify NULL in ordersSELECT * FROM orders
SELECT * FROM "orders" WHERE "customerID" IS NULL;
SELECT * FROM orders
WHERE "orderID" IN (10248,10274,10295,10737,10739);

--5) Insert the following data to Products using UPSERT:
product_id = 100, product_name = Wheat bread, quantityperunit=1,unitprice = 13, discontinued = 0, categoryID=3
product_id = 101, product_name = White bread, quantityperunit=5 boxes,unitprice = 13, discontinued = 0, categoryID=3
product_id = 100, product_name = Wheat bread, quantityperunit=10 boxes,unitprice = 13, discontinued = 0, categoryID=3
(this should update the quantityperunit for product_id = 100)

INSERT INTO "products" ("productID","productName","quantityPerUnit","unitPrice","discontinued","categoryID")
VALUES(100, 'Wheat bread', '1', 13, 0, 5),(101, 'White bread', '5 boxes', 13, 0, 5)
ON CONFLICT ("productID")
DO UPDATE SET
    "quantityPerUnit" = EXCLUDED."quantityPerUnit",
    "productName" = EXCLUDED."productName",
    "unitPrice" = EXCLUDED."unitPrice",
   "discontinued" = EXCLUDED."discontinued",
    "categoryID"= EXCLUDED."categoryID";

select * from products where "productID" IN ('100','101');
--After UPSERT
INSERT INTO products ("productID","productName","quantityPerUnit","unitPrice","discontinued","categoryID")
VALUES(100, 'Wheat bread', '10', 13, 0, 5)
ON CONFLICT ("productID")
DO UPDATE SET
    "quantityPerUnit" = EXCLUDED."quantityPerUnit",
    "productName" = EXCLUDED."productName",
    "unitPrice" = EXCLUDED."unitPrice",
   "discontinued" = EXCLUDED."discontinued",
    "categoryID"= EXCLUDED."categoryID";

--  6) Create the temporary table
INSERT INTO categories ("categoryID", "categoryName","description")
VALUES (9, 'Snacks','GoldFish');  

SELECT * FROM categories;
DROP TABLE IF Exists updated_products;
DROP TABLE IF Exists updated_products1;
CREATE TEMP TABLE updated_products(
    "productID" SERIAL PRIMARY KEY,
    "productName" VARCHAR(100) NOT NULL,
    "quantityPerUnit" VARCHAR(100) NOT NULL,
    "unitPrice" NUMERIC(10,2) NOT NULL,
    "discontinued" INT NOT NULL,
    "categoryID" INT NOT NULL
);
INSERT INTO updated_products ("productID", "productName", "quantityPerUnit", "unitPrice", "discontinued", "categoryID")
VALUES
    (100, 'Wheat bread', '10', 20, 1, 5),
    (101, 'White bread', '5 boxes', 19.99, 0, 5),
    (102, 'Midnight Mango Fizz', '24 - 12 oz bottles', 19, 0, 1),
    (103, 'Savory Fire Sauce', '12 - 550 ml bottles', 10, 0, 2);
--Use MERGE (PostgreSQL 15+)
--Merge updated_products into products
MERGE INTO "products" p
USING "updated_products" u
ON p."productID" = u."productID"
-- If matching and discontinued = 0 → UPDATE
WHEN MATCHED AND u."discontinued" = 0 THEN
    UPDATE SET
        "unitPrice" = u."unitPrice",
        "discontinued" =u."discontinued"
-- If matching and discontinued = 1 → DELETE
WHEN MATCHED AND u."discontinued" = 1 THEN
    DELETE
-- If not matched and discontinued = 0 → INSERT
WHEN NOT MATCHED AND u."discontinued" = 0 THEN
    INSERT ("productID","productName", "quantityPerUnit", "unitPrice", "discontinued", "categoryID")
    VALUES (u."productID", u."productName", u."quantityPerUnit", u."unitPrice", u."discontinued", u."categoryID");

SELECT * FROM products WHERE "productID" IN (100,101,102,103);
    
