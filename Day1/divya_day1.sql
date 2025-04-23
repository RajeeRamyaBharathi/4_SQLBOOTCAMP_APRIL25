CREATE TABLE IF NOT EXISTS categories (
    categoryID INT PRIMARY KEY,         
    categoryName TEXT NOT NULL,         
    description TEXT                    
);


CREATE TABLE IF NOT EXISTS customers (
    customerID VARCHAR(5) PRIMARY KEY,
    companyName VARCHAR(255) UNIQUE, 
    contactName VARCHAR(255),
    contactTitle VARCHAR(255),
    city VARCHAR(255),
    country VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS shippers (
    shipperID INT PRIMARY KEY,
    companyName VARCHAR(255) NOT NULL
);
ALTER TABLE shippers
ADD CONSTRAINT unique_company_name UNIQUE (companyName);

CREATE TABLE IF NOT EXISTS data_dictionary (
    tableName VARCHAR(50) NOT NULL,
    fieldName VARCHAR(50) NOT NULL,
    description TEXT
);

SELECT * FROM data_dictionary;

CREATE TABLE IF NOT EXISTS employees (
    employeeID INT PRIMARY KEY,
    employeeName VARCHAR(100) NOT NULL,
    title VARCHAR(100) NOT NULL,
    city VARCHAR(100),
    country VARCHAR(100),
    reportsTo INT
);

drop table order_details;
CREATE TABLE IF NOT EXISTS order_details (
    orderID INT NOT NULL,
    productID INT NOT NULL,
    unitPrice Decimal NOT NULL,
    quantity INT NOT NULL,
    discount Decimal NOT NULL
);

Alter Table order_details
ADD constraint fk_orderid
      FOREIGN KEY(orderID)
        REFERENCES orders(orderID);

Alter Table order_details
ADD constraint fk_productid
      FOREIGN KEY(productID)
        REFERENCES products(productID);		

CREATE TABLE IF NOT EXISTS orders (
    orderID SERIAL PRIMARY KEY,
    customerID Varchar(8) NOT NULL,
    employeeID INT NOT NULL,
    orderDate DATE NOT NULL,
    requiredDate DATE NOT NULL,
	shippedDate DATE,
	shipperID INT NOT NULL,
	freight DECIMAL NOT NULL
);

Alter Table orders
ADD constraint fk_customerID
      FOREIGN KEY(customerID)
        REFERENCES customers(customerID);

Alter Table orders
ADD constraint fk_employeeID
      FOREIGN KEY(employeeID)
        REFERENCES employees(employeeID);

Alter Table orders
ADD constraint fk_shipperID
      FOREIGN KEY(shipperID)
        REFERENCES shippers(shipperID);

DROP TABLE products;
CREATE TABLE IF NOT EXISTS products (
    productID SERIAL PRIMARY KEY,
    productName Varchar(64) NOT NULL,
    quantityPerUnit TEXT NOT NULL,
    unitPrice DECIMAL NOT NULL,
    discontinued INT NOT NULL,
	categoryID INT NOT NULL
);

Alter Table products
ADD constraint fk_categoryID
      FOREIGN KEY(categoryID)
        REFERENCES categories(categoryID);



SELECT * FROM products;
