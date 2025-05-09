
CREATE TABLE IF NOT EXISTS "My Schema".customers
(
    "customerID" character varying COLLATE pg_catalog."default" NOT NULL,
    "CompanyName" character varying(100) COLLATE pg_catalog."default",
    "ContactTitle" character varying(100) COLLATE pg_catalog."default",
    "ContactName" character varying(100) COLLATE pg_catalog."default",
    "City" character varying(50) COLLATE pg_catalog."default",
    "Country" character varying(100) COLLATE pg_catalog."default",
    CONSTRAINT "Customers_pkey" PRIMARY KEY ("customerID")
)
CREATE TABLE IF NOT EXISTS "My Schema".categories
(
    "categoriesID" integer NOT NULL,
    "categoryName" text COLLATE pg_catalog."default",
    description text COLLATE pg_catalog."default",
    CONSTRAINT categories_pkey PRIMARY KEY ("categoriesID")
)
CREATE TABLE IF NOT EXISTS "My Schema".employees
(
    "employeeID" integer NOT NULL,
    "employeeName" character varying(100) COLLATE pg_catalog."default" NOT NULL,
    title character varying(100) COLLATE pg_catalog."default",
    city character varying(50) COLLATE pg_catalog."default",
    country character(10) COLLATE pg_catalog."default",
    "reportsTo" integer,
    CONSTRAINT employees_pkey PRIMARY KEY ("employeeID")
)
CREATE TABLE IF NOT EXISTS "My Schema".order_details
(
    "orderID" integer NOT NULL,
    "productID" numeric NOT NULL,
    "unitPrice" numeric(10,2),
    quantity numeric,
    discount numeric(5,2),
    CONSTRAINT "orderID" FOREIGN KEY ("orderID")
        REFERENCES "My Schema".orders ("orderID") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "productID" FOREIGN KEY ("productID")
        REFERENCES "My Schema".products ("productID") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)
CREATE TABLE IF NOT EXISTS "My Schema".orders
(
    "orderID" integer NOT NULL,
    "customerID" character varying(5) COLLATE pg_catalog."default" NOT NULL,
    "employeeID" integer NOT NULL,
    "orderDate" date NOT NULL,
    "requiredDate" date NOT NULL,
    "shippedDate" date,
    "shipperID" integer NOT NULL,
    freight numeric(6,2),
    CONSTRAINT orders_pkey PRIMARY KEY ("orderID"),
    CONSTRAINT "customerID" FOREIGN KEY ("customerID")
        REFERENCES "My Schema".customers ("customerID") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "employeeID" FOREIGN KEY ("employeeID")
        REFERENCES "My Schema".employees ("employeeID") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT "shipperID" FOREIGN KEY ("shipperID")
        REFERENCES "My Schema".shippers ("shipperID") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)
CREATE TABLE IF NOT EXISTS "My Schema".products
(
    "productID" numeric NOT NULL,
    "productName" character varying COLLATE pg_catalog."default",
    "quantityPerUnit" character varying COLLATE pg_catalog."default",
    "unitPrice" numeric(10,2),
    discontinued boolean,
    "categoryID" integer,
    CONSTRAINT products_pkey PRIMARY KEY ("productID"),
    CONSTRAINT "categoryID" FOREIGN KEY ("categoryID")
        REFERENCES "My Schema".categories ("categoriesID") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)
CREATE TABLE IF NOT EXISTS "My Schema".shippers
(
    "shipperID" integer NOT NULL,
    "companyName" character varying(50) COLLATE pg_catalog."default",
    CONSTRAINT "shipperID" PRIMARY KEY ("shipperID")
)
