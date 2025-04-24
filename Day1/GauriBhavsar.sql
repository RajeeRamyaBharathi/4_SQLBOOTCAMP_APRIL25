-- Table: public.categories

-- DROP TABLE IF EXISTS public.categories;

CREATE TABLE IF NOT EXISTS public.categories
(
    "catagoryID" integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    "CategoryName" character varying COLLATE pg_catalog."default",
    discription character varying COLLATE pg_catalog."default",
    CONSTRAINT categories_pkey PRIMARY KEY ("catagoryID")
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.categories
    OWNER to postgres;
	
	
	
	-- Table: public.customers

-- DROP TABLE IF EXISTS public.customers;

CREATE TABLE IF NOT EXISTS public.customers
(
    "customerID" character varying COLLATE pg_catalog."default" NOT NULL,
    "companyName" character varying COLLATE pg_catalog."default",
    "contactName" character varying COLLATE pg_catalog."default",
    "contactTitle" character varying COLLATE pg_catalog."default",
    city character varying COLLATE pg_catalog."default",
    country character varying COLLATE pg_catalog."default",
    CONSTRAINT customers_pkey PRIMARY KEY ("customerID")
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.customers
    OWNER to postgres;
	
	-- Table: public.employees

-- DROP TABLE IF EXISTS public.employees;

CREATE TABLE IF NOT EXISTS public.employees
(
    "employeeID" integer NOT NULL,
    "employeeName" character varying COLLATE pg_catalog."default",
    title character varying COLLATE pg_catalog."default",
    city character varying COLLATE pg_catalog."default",
    country character varying COLLATE pg_catalog."default",
    "reportsTo" character varying COLLATE pg_catalog."default",
    CONSTRAINT employees_pkey PRIMARY KEY ("employeeID")
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.employees
    OWNER to postgres;
	
	
	-- Table: public.order_details

-- DROP TABLE IF EXISTS public.order_details;

CREATE TABLE IF NOT EXISTS public.order_details
(
    "orderID" integer NOT NULL,
    "productID" integer NOT NULL,
    "unitPrice" numeric,
    quantity integer,
    discount numeric,
    CONSTRAINT order_details_pkey PRIMARY KEY ("productID", "orderID")
        INCLUDE("orderID", "productID"),
    CONSTRAINT "order_details_orderID_fkey" FOREIGN KEY ("orderID")
        REFERENCES public.orders ("orderID") MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
        NOT VALID,
    CONSTRAINT "order_details_productID_fkey" FOREIGN KEY ("productID")
        REFERENCES public.products ("productId") MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.order_details
    OWNER to postgres;
	
	-- Table: public.orders

-- DROP TABLE IF EXISTS public.orders;

CREATE TABLE IF NOT EXISTS public.orders
(
    "orderID" integer NOT NULL,
    "customerID" character varying COLLATE pg_catalog."default",
    "employeeID" integer,
    "orderDate" date,
    "requiredDate" date,
    "shippedDate" date,
    "shipperID" integer,
    freight numeric,
    CONSTRAINT orders_pkey PRIMARY KEY ("orderID"),
    CONSTRAINT "orders_customerID_fkey" FOREIGN KEY ("customerID")
        REFERENCES public.customers ("customerID") MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
        NOT VALID,
    CONSTRAINT "orders_employeeID_fkey" FOREIGN KEY ("employeeID")
        REFERENCES public.employees ("employeeID") MATCH FULL
        ON UPDATE CASCADE
        ON DELETE CASCADE
        NOT VALID,
    CONSTRAINT "orders_shipperID_fkey" FOREIGN KEY ("shipperID")
        REFERENCES public.shippers ("shipperID") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.orders
    OWNER to postgres;
	
	-- Table: public.products

-- DROP TABLE IF EXISTS public.products;

CREATE TABLE IF NOT EXISTS public.products
(
    "productId" integer NOT NULL,
    "productName" character varying COLLATE pg_catalog."default",
    "quantityPerUnit" character varying(100) COLLATE pg_catalog."default",
    "unitPrice" numeric,
    discontinued integer,
    "categoryID" integer,
    CONSTRAINT products_pkey PRIMARY KEY ("productId"),
    CONSTRAINT "products_categoryID_fkey" FOREIGN KEY ("categoryID")
        REFERENCES public.categories ("catagoryID") MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.products
    OWNER to postgres;
	
	-- Table: public.shippers

-- DROP TABLE IF EXISTS public.shippers;

CREATE TABLE IF NOT EXISTS public.shippers
(
    "shipperID" integer NOT NULL,
    "companyName" character varying COLLATE pg_catalog."default",
    CONSTRAINT shippers_pkey PRIMARY KEY ("shipperID")
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.shippers
    OWNER to postgres;