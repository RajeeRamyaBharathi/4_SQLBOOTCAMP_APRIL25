UPDATE categories
SET categoryName = 'Drinks'
WHERE categoryName = 'Beverages';

INSERT INTO shippers (shipperID, companyName)
VALUES (4, 'QuickShip Ltd.');

DELETE FROM shippers
WHERE shipperID = 4;

ALTER TABLE products
DROP CONSTRAINT IF EXISTS fk_categoryid;


ALTER TABLE products
ADD CONSTRAINT products_categoryID_fkey
FOREIGN KEY (categoryID)
REFERENCES categories(categoryID)
ON UPDATE CASCADE
ON DELETE CASCADE;

UPDATE categories
SET categoryID = 1001
WHERE categoryID = 1;

SELECT * FROM categories;

SELECT * FROM products;

ALTER TABLE order_details
DROP CONSTRAINT fk_productid;


DELETE FROM categories
WHERE categoryID = 3;

SELECT * FROM categories;
SELECT * FROM products;

ALTER TABLE orders
DROP CONSTRAINT fk_customerid;

ALTER TABLE orders
ADD CONSTRAINT fk_customerid
FOREIGN KEY (customerID)
REFERENCES customers(customerID)
ON DELETE SET NULL;

ALTER TABLE orders
ALTER COLUMN customerID DROP NOT NULL;


DELETE FROM customers
WHERE customerID = 'VINET';



INSERT INTO categories (categoryID, categoryName)
VALUES (3, 'Bread');  



INSERT INTO products (productID, productName, quantityPerUnit, unitPrice, discontinued, categoryID)
VALUES 
(100, 'Wheat bread', '1', 13, 0, 3)
ON CONFLICT (productID)
DO UPDATE SET 
    quantityPerUnit = EXCLUDED.quantityPerUnit;


INSERT INTO products (productID, productName, quantityPerUnit, unitPrice, discontinued, categoryID)
VALUES 
(101, 'White bread', '5 boxes', 13, 0, 3)
ON CONFLICT (productID)
DO UPDATE SET 
    quantityPerUnit = EXCLUDED.quantityPerUnit;


INSERT INTO products (productID, productName, quantityPerUnit, unitPrice, discontinued, categoryID)
VALUES 
(100, 'Wheat bread', '10 boxes', 13, 0, 3)
ON CONFLICT (productID)
DO UPDATE SET 
    quantityPerUnit = EXCLUDED.quantityPerUnit;



	CREATE TEMP TABLE updated_products (
    productID INT PRIMARY KEY,
    productName VARCHAR(100),
    quantityPerUnit VARCHAR(100),
    unitPrice NUMERIC(10,2),
    discontinued INT,
    categoryID INT
);

INSERT INTO updated_products VALUES
(100, 'Wheat bread', '10', 20, 1, 3),
(101, 'White bread', '5 boxes', 19.99, 0, 3),
(102, 'Midnight Mango Fizz', '24 - 12 oz bottles', 19, 0, 1),
(103, 'Savory Fire Sauce', '12 - 550 ml bottles', 10, 0, 2);


UPDATE products p
SET unitPrice = up.unitPrice,
    discontinued = up.discontinued
FROM updated_products up
WHERE p.productID = up.productID
  AND up.discontinued = 0;


DELETE FROM products p
USING updated_products up
WHERE p.productID = up.productID
  AND up.discontinued = 1;


INSERT INTO categories (categoryID, categoryName)
SELECT * FROM (VALUES
    (1, 'Default Category 1'),
    (2, 'Default Category 2'),
    (3, 'Default Category 3')
) AS vals(id, name)
WHERE NOT EXISTS (
    SELECT 1 FROM categories c WHERE c.categoryID = vals.id
);

  INSERT INTO products (productID, productName, quantityPerUnit, unitPrice, discontinued, categoryID)
SELECT up.productID, up.productName, up.quantityPerUnit, up.unitPrice, up.discontinued, up.categoryID
FROM updated_products up
LEFT JOIN products p ON p.productID = up.productID
WHERE p.productID IS NULL
  AND up.discontinued = 0;

 select a.*,concat(b.first_name,' ',b.last_name) employee_full_name from 
  orders a inner join employees b on a.employee_id=b.employee_id


