--categories table
Create Table categories(
"categoryID" INTEGER PRIMARY KEY,
"categoryName" VARCHAR(50) NOT NULL,
"description" VARCHAR(100) NOT NULL
);
select * from categories;
--Drop Table categories CASCADE;


--customers table
Create Table customers(
"customerID" VARCHAR(50) PRIMARY KEY,
"companyName" VARCHAR(100) NOT NULL,
"contactName" VARCHAR(100) NOT NULL,
"contactTitle" VARCHAR(100) NOT NULL,
"city" VARCHAR(50) NOT NULL,
"country" VARCHAR(50) NOT NULL
);
select * from customers;
Drop Table customers


--employees table
Create Table employees(
"employeeID" SERIAL PRIMARY KEY,
"employeeName" VARCHAR(100) NOT NULL,
"title" VARCHAR(100) NOT NULL,
"city" VARCHAR(100) NOT NULL,
"country" VARCHAR(50) NOT NULL,
"reportsTo" INTEGER NULL
);
select * from employees;
Drop Table employees


--order details table
Create Table order_details(
"orderID" INTEGER NOT NULL,
"productID" INTEGER NOT NULL,
"unitPrice" NUMERIC(5,2) NOT NULL,
"quantity" INTEGER NOT NULL,
"discount" NUMERIC(4,2) NULL
);
select * from order_details;
Drop Table order_details


--orders table
Create Table orders(
"orderID" INTEGER PRIMARY KEY,
"customerID" VARCHAR(50) NOT NULL,
"employeeID" INTEGER NOT NULL,
"orderDate" DATE NOT NULL,
"requiredDate" DATE NOT NULL,
"shippedDate" DATE  NULL,
"shipperID" INTEGER NOT NULL,
"freight" NUMERIC(10,2) NULL
);
select * from orders;
Drop Table orders


--products
Create Table products(
"productID" SERIAL PRIMARY KEY,
"productName" VARCHAR(100) NOT NULL,
"quantityPerUnit" VARCHAR(100) NOT NULL,
"unitPrice" NUMERIC(10,2) NOT NULL,
"discontinued" INTEGER NOT NULL,
"categoryID" INTEGER NOT NULL
);
select * from products;


--shippers table
Create Table shippers(
"shipperID" SERIAL PRIMARY KEY,
"companyName" VARCHAR(100) NOT NULL
);
select * from shippers;


--constraints
ALTER TABLE PRODUCTS ADD constraint fk_categoryID 
FOREIGN KEY ("categoryID") references categories("categoryID");


ALTER TABLE order_details ADD CONSTRAINT pk_order_details
PRIMARY KEY ("orderID", "productID");


ALTER TABLE order_details ADD CONSTRAINT fk_orders
FOREIGN KEY ("orderID") REFERENCES orders("orderID");


ALTER TABLE order_details ADD CONSTRAINT fk_products
FOREIGN KEY ("productID") REFERENCES products("productID");


ALTER TABLE orders ADD constraint fk_customerID 
FOREIGN KEY ("customerID") references customers("customerID");


ALTER TABLE orders ADD constraint fk_employeeID 
FOREIGN KEY ("employeeID") references employees("employeeID");


ALTER TABLE orders ADD constraint fk_shipperID 
FOREIGN KEY ("shipperID") references shippers("shipperID");



