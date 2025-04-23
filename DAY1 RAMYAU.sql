--DAY1
CREATE TABLE customers (
 customerID VARCHAR(20) PRIMARY KEY,
 companyName VARCHAR(40) NOT NULL,
 contactName VARCHAR(40),
 contactTitle VARCHAR(40),
 city VARCHAR(25),
 country VARCHAR(25)
);

-- Explanation:
-- customerID: This is the unique identifier for each customer and is set as the PRIMARY KEY.
-- companyName: The name of the customer's company, marked as NOT NULL as it's essential information.
-- Other columns store contact details and location.

SELECT * FROM customers
-----------------------------------------------------------------------------------------------------

CREATE TABLE employees (
 employeeID INT PRIMARY KEY,
 employeeName VARCHAR(40) NOT NULL,
 title VARCHAR(40),
 city VARCHAR(25),
 country VARCHAR(25),
 reportsTo INT,
 FOREIGN KEY (reportsTo) REFERENCES employees(employeeID)
);

-- employeeID: Unique identifier for each employee, set as the PRIMARY KEY.
-- employeeName: The name of the employee, marked as NOT NULL.
-- reportsTo: Foreign Key referencing the employeeID of the employee's manager, establishing a hierarchical relationship.

SELECT * FROM employees
---------------------------------------------------------------------------------------------------------------------------

CREATE TABLE shippers (
 shipperID INT PRIMARY KEY,
 companyName VARCHAR (50) NOT NULL
 );

-- shipperID: Unique identifier for each shipper, the PRIMARY KEY.
-- companyName: The name of the shipping company, marked as NOT NULL.

SELECT * FROM shippers
----------------------------------------------------------------------------------------------------------------------------

CREATE TABLE orders (
 orderID INT PRIMARY KEY,
 customerID VARCHAR(20),
 employeeID INT,
 orderDate DATE,
 requiredDate DATE,
 shipperDate DATE,
 shipperID INT,
 frieght REAL,
 FOREIGN KEY (customerID) REFERENCES customers(customerID),
 FOREIGN KEY (employeeID) REFERENCES employees(employeeID),
 FOREIGN KEY (shipperID) REFERENCES shippers(shipperID)
);
-- orderID: Unique identifier for each order, the PRIMARY KEY.
-- customerID: Foreign Key referencing the Customers table, linking each order to a specific customer.
-- employeeID: Foreign Key referencing the Employees table, indicating which employee handled the order.
-- shipperID: Foreign Key referencing the Shippers table, specifying the shipping company.
-- Other columns store important dates and freight cost.
 
SELECT * FROM orders
-----------------------------------------------------------------------------------------------------------

CREATE TABLE categories (
 categoryid INT PRIMARY KEY,
 categoryName VARCHAR(30) NOT NULL,
 description TEXT
);
-- categoryID: Unique identifier for each product category, the PRIMARY KEY.
-- categoryName: The name of the product category, marked as NOT NULL.
-- description: A description of the product category.
 
SELECT * FROM categories
-------------------------------------------------------------------------------------------------------------

CREATE TABLE products (
 productID INT PRIMARY KEY,
 productName VARCHAR(40) NOT NULL,
 quantityPerUnit VARCHAR(80),
 unitPrice REAL,
 discontined INT,
 categoryID INT,
 FOREIGN KEY (categoryid) REFERENCES categories(categoryid) 
);
-- productID: Unique identifier for each product, the PRIMARY KEY.
-- productName: The name of the product, marked as NOT NULL.
-- categoryID: Foreign Key referencing the Categories table, linking each product to a specific category.
-- discontinued: Indicates if the product is discontinued (e.g., 0 for not discontinued, 1 for discontinued).

SELECT * FROM products
----------------------------------------------------------------------------------------------------------------

CREATE TABLE order_details (
 orderID INT,
 productID INT,
 unitPrice REAL,
 quantity INT,
 discount REAL,
 PRIMARY KEY (orderID, productID),
 FOREIGN KEY (orderID) REFERENCES orders(orderID),
 FOREIGN KEY (productID) REFERENCES products(productID)
);
-- orderID and productID: Together, these form a COMPOSITE PRIMARY KEY, uniquely identifying each item within an order.
-- orderID: Foreign Key referencing the Orders table.
-- productID: Foreign Key referencing the Products table.
-- Other columns store details about the specific product in that order.

SELECT * FROM order_details
