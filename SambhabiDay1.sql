--CATEGORIES table
CREATE TABLE categories (
"categoryID" INTEGER Primary Key,
"categoryName" VARCHAR(255) NOT NULL,
"description" VARCHAR(255) NOT NULL
);

select * from categories;

--CUSTOMERS table
CREATE TABLE customers (
"customerID" VARCHAR(50) Primary Key,
"companyName" VARCHAR(50) NOT NULL,
"contactName" VARCHAR(50) NOT NULL,
"contactTitle" VARCHAR(50) NOT NULL,
"city" VARCHAR(50) NOT NULL,
"country" VARCHAR(50) NOT NULL
);

select * from customers;

--EMPLOYEES table
CREATE TABLE employees (
"employeeID" INTEGER PRIMARY KEY,
"employeeName" VARCHAR(50) NOT NULL,
"title" VARCHAR(50) NOT NULL,"city" VARCHAR(50) NOT NULL,
"country" VARCHAR(50) NOT NULL,
"reportsTo" VARCHAR(50) NOT NULL
);

--ORDERS table
CREATE TABLE orders(
"orderID" INTEGER PRIMARY KEY,
"customerID" VARCHAR(50) NOT NULL,
"employeeID" INTEGER NOT NULL,
"orderDate" VARCHAR(50) NOT NULL,
"requiredDate" VARCHAR(50) NOT NULL,
"shippedDate" VARCHAR(50) NOT NULL,
"shipperID" INTEGER ,
"freight" Decimal(10,2) NOT NULL
);
select * from orders;

--ORDER_DETAILS table
CREATE TABLE order_details(
"orderID" INTEGER NOT NULL,
"productID" INTEGER NOT NULL,
"unitPrice" Decimal(10,2) NOT NULL,
"quantity" INTEGER NOT NULL,
"discount" Decimal(10,2) NOT NULL,
CONSTRAINT pk_order_details PRIMARY KEY ("orderID","productID")
);
select * from order_details;

--PRODUCTS table
CREATE TABLE products(
"productID" INTEGER PRIMARY KEY,
"productName" VARCHAR(255) NOT NULL,
"quantityPerUnit" VARCHAR(255) NOT NULL,
"unitPrice" Decimal(10,2) NOT NULL,
"discontinued" BOOLEAN NOT NULL,
"categoryID" INTEGER NOT NULL
);
select * from products;

--SHIPPERS table
CREATE TABLE shippers(
"shipperID" INTEGER PRIMARY KEY,
"companyName" VARCHAR(50) NOT NULL
);
select * from shippers;

--constraints
ALTER TABLE products ADD CONSTRAINT fk_products
FOREIGN KEY ("categoryID") references categories("categoryID");

ALTER TABLE order_details ADD CONSTRAINT fk_order_details
FOREIGN KEY ("orderID") references orders("orderID");

ALTER TABLE orders ADD CONSTRAINT fk_orders
FOREIGN KEY ("customerID") references customers("customerID");

ALTER TABLE orders ADD CONSTRAINT fk_employee_id
FOREIGN KEY ("employeeID") references employees("employeeID");

ALTER TABLE orders ADD CONSTRAINT fk_shipper_id
FOREIGN KEY ("shipperID") references shippers("shipperID");
