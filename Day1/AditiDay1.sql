
--creating table categories
Create Table categories(
"categoryID" INTEGER PRIMARY KEY,
"categoryName" VARCHAR(50) NOT NULL,
"description" VARCHAR(100) NOT NULL
);
--categoryID PRIMARY KEY-Acts as a primary key.
--NOT NULL -Column should not have null Value.

select * from categories;


--Creating customers table
Create Table customers(
"customerID" VARCHAR(50) PRIMARY KEY,
"companyName" VARCHAR(100) NOT NULL,
"contactName" VARCHAR(100) NOT NULL,
"contactTitle" VARCHAR(100) NOT NULL,
"city" VARCHAR(50) NOT NULL,
"country" VARCHAR(50) NOT NULL
);
select * from customers;
Drop Table customers;
--customerID PRIMARY KEY-Acts as a primary key.


--Creating employees table
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
--SERIAL-Auto-incrementing primary key using a sequence.


--Creating order details table
Create Table order_details(
"orderID" INTEGER NOT NULL,
"productID" INTEGER NOT NULL,
"unitPrice" NUMERIC(5,2) NOT NULL,
"quantity" INTEGER NOT NULL,
"discount" NUMERIC(4,2) NULL
);
select * from order_details;
Drop Table order_details
--Creating orders table
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
--Creating shippers table
Create Table shippers(
"shipperID" SERIAL PRIMARY KEY,
"companyName" VARCHAR(100) NOT NULL
);
select * from shippers;

--Creating products Table
create table products(
"productID" SERIAL primary key,
"productName" TEXT NOT NULL,
"quantityPerUnit" TEXT,
"unitPrice" DECIMAL(10,2),
"discontinued" BOOLEAN,
"categoryID" int references categories("categoryID"))

select * from products;
DROP TABLE products;

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
ALTER TABLE order_details ADD constraint fk_orderID
FOREIGN KEY ("orderID") references orders("orderID");
ALTER TABLE order_details ADD constraint fk_productID 
FOREIGN KEY ("productID") references products("productID");

ALTER TABLE employees ADD constraint fk_reportsto
FOREIGN KEY ("reportsTo") references employees("employeeID");
--FOREIGN KEY(reportsTo)REFERENCES- self-referencing foreign key


