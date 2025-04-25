set search_path = "My Schema"

select * from categories order by "categoriesID" ASC

update categories set "categoryName" = 'Drinks' where "categoryName" = 'Beverages'

select * from shippers

insert into shippers("shipperID","companyName")
values (4,'USPS')

delete from shippers where "shipperID" = 4

select * from categories order by "categoriesID" ASC

select * from products order by "categoryID" DESC

ALTER TABLE products 
Drop constraint categoryID,
add constraint categoryID_fk FOREIGN KEY ("categoryID") 
REFERENCES categories ("categoriesID") 
ON UPDATE CASCADE 
ON DELETE CASCADE

ALTER TABLE order_details
DROP Constraint "productID_fk",
add constraint productID_fk FOREIGN KEY ("productID") 
REFERENCES products ("productID") 
ON UPDATE CASCADE 
ON DELETE CASCADE

update categories
set "categoriesID" =1001
where "categoriesID" = 1

delete from categories
where "categoriesID" = 3

select * from orders

ALTER TABLE orders
DROP Constraint customerID_fk,
add constraint customerID_fk FOREIGN KEY ("customerID") 
REFERENCES customers ("customerID") 
ON UPDATE CASCADE 
ON DELETE set null

delete from customers where "customerID" = 'VINET'

select * from customers where "customerID" = 'VINET'

select * from products

INSERT INTO products ("productID", "productName", "quantityPerUnit", "price_in_usd", "discontinued", "categoryID") 
VALUES 
    (100, 'Wheat bread', '1 box', 13, False, 5),
    (101, 'White bread', '5 boxes', 13,False, 5)
    	ON CONFLICT ("productID") 
DO UPDATE SET 
       "quantityPerUnit" = EXCLUDED."quantityPerUnit"

select * from products where "productID" IN ('100','101')


INSERT INTO products ("productID", "productName", "quantityPerUnit", "price_in_usd", "discontinued", "categoryID") 
VALUES (100, 'Wheat bread', '10 boxes', 13, False, 5)
	ON CONFLICT ("productID") 
DO UPDATE SET 
       "quantityPerUnit" = EXCLUDED."quantityPerUnit",
	   "productName" = EXCLUDED."productName",
    "price_in_usd" = EXCLUDED."price_in_usd",
   "discontinued" = EXCLUDED."discontinued",
    "categoryID"= EXCLUDED."categoryID"

select * from products where "productID" IN ('100','101')
    
 
CREATE TEMP TABLE updated_products (
    productID INT PRIMARY KEY,
    productName VARCHAR(255),
    quantityPerUnit VARCHAR(255),
    unitPrice NUMERIC(10,2),
    discontinued BOOLEAN,
    categoryID INT)

INSERT INTO updated_products (productID, productName, quantityPerUnit, unitPrice, discontinued, categoryID) VALUES
(100, 'Wheat bread', '1',13, TRUE, 5),
(101, 'White bread', '5 boxes', 13, FALSE, 5),
(102, 'Midnight Mango Fizz', '24 - 12 oz bottles', 19, False, 1),
(103, 'Savory Fire Sauce', '12 - 550 ml bottles', 10, False, 2)

select * from updated_products



---Update Matching Rows Where discontinued = FALSE

UPDATE products p
SET 
    price_in_usd = u.unitprice,
    discontinued = u.discontinued
FROM updated_products u
WHERE p."productID" = u.productid AND u.discontinued = FALSE

----Delete Matching Rows Where discontinued = TRUE
DELETE FROM products p
USING updated_products u
WHERE p."productID" = u.productid AND u.discontinued = TRUE









MERGE INTO products p
USING updated_products u
ON p."productID" = u.productid
-- If matching and discontinued = False → UPDATE
WHEN MATCHED AND u.discontinued = False THEN
    UPDATE SET
     price_in_usd = u.unitprice,
    discontinued = u.discontinued
-- If matching and discontinued = True → DELETE
WHEN MATCHED AND u.discontinued = True THEN
    DELETE
-- If not matched and discontinued = 0 → INSERT
WHEN NOT MATCHED AND u.discontinued = False THEN
    INSERT ("productID","productName", "quantityPerUnit", "price_in_usd", "discontinued", "categoryID")
    VALUES (u.productid, u.productname, u.quantityperunit, u.unitprice, u.discontinued, u.categoryid)

SELECT * FROM products WHERE "productID" IN (100,101,102,103)








