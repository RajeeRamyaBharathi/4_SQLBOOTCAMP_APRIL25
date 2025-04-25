1)      Update the categoryName From “Beverages” to "Drinks" in the categories table.


Update public.categories set "category_name"='Drinks' 
        where  "category_name"='Beverages'        


2)      Insert into shipper new record (give any values) Delete that new record from shippers table.
insert into public.shippers (shipper_id, company_name, phone) 
values (7,'USPS','1-800-224-2345') 
delete from shippers where shipper_id=7


3)      Update categoryID=1 to categoryID=1001. Make sure related products update their categoryID too. Display the both category and products table to show the cascade.
 Delete the categoryID= “3”  from categories. Verify that the corresponding records are deleted automatically from products.
 (HINT: Alter the foreign key on products(categoryID) to add ON UPDATE CASCADE, ON DELETE CASCADE)
        Alter table products 
        drop constraint fk_products_categories


    Alter table products 
        add constraint fk_products_categories 
        foreign key (category_id) 
        references  categories(category_id) 
        on update cascade 
        on delete cascade ;


         UPDATE public.categories
        SET category_id=1001
        WHERE category_id=1;
       SELECT * FROM public.products 
   where category_id=1001;
        select * from public.categories where category_id=1001;
Alter table order_details
        drop constraint fk_order_details_products


        Alter table order_details
        add constraint fk_order_details_products
        foreign key (product_id)
        references products(product_id)
        on update cascade
        on delete cascade 


    delete from categories
        WHERE category_id=3
 select * from categories where  category_id=3
        select * From Products where category_id=3
        select * from order_details where product_id=16


4)      Delete the customer = “VINET”  from customers. Corresponding customers in orders table should be set to null (HINT: Alter the foreign key on orders(customerID) to use ON DELETE SET NULL)
Alter table orders 
        drop constraint fk_orders_customers


        Alter table orders 
        add constraint fk_orders_customers
        foreign key (customer_id) 
        references customers(customer_id)
        on delete set null


SELECT * FROM orders
WHERE order_id IN (10248,10274,10295,10737,10739);


        delete from customers where "customer_id"='VINET'
        select * from customers where "customer_id"='VINET'
        select * from orders where "customer_id"='VINET'
5)      Insert the following data to Products using UPSERT:
product_id = 100, product_name = Wheat bread, quantityperunit=1,unitprice = 13, discontinued = 0, categoryID=5
product_id = 101, product_name = White bread, quantityperunit=5 boxes,unitprice = 13, discontinued = 0, categoryID=5
product_id = 100, product_name = Wheat bread, quantityperunit=10 boxes,unitprice = 13, discontinued = 0, categoryID=5
(this should update the quantityperunit for product_id = 100)
INSERT INTO products (product_id, product_name, quantity_per_unit, unit_price, discontinued, category_id)
VALUES (100, 'Wheat bread', 1, 13, 0, 5)
ON CONFLICT (product_id)
DO UPDATE SET 
    product_name = EXCLUDED.product_name,
    quantity_per_unit = EXCLUDED.quantity_per_unit,
    unit_price = EXCLUDED.unit_price,
    discontinued = EXCLUDED.discontinued,
    category_id = EXCLUDED.category_id;


        INSERT INTO products (product_id, product_name, quantity_per_unit, unit_price, discontinued, category_id)
VALUES (101, 'Wheat bread', 5, 13, 0, 5)
ON CONFLICT (product_id)
DO UPDATE SET 
    product_name = EXCLUDED.product_name,
    quantity_per_unit = EXCLUDED.quantity_per_unit,
    unit_price = EXCLUDED.unit_price,
    discontinued = EXCLUDED.discontinued,
    category_id = EXCLUDED.category_id;


        INSERT INTO products (product_id, product_name, quantity_per_unit, unit_price, discontinued, category_id)
VALUES (100, 'Wheat bread', 10, 13, 0, 5)
ON CONFLICT (product_id)
DO UPDATE SET 
    product_name = EXCLUDED.product_name,
    quantity_per_unit = EXCLUDED.quantity_per_unit,
    unit_price = EXCLUDED.unit_price,
    discontinued = EXCLUDED.discontinued,
    category_id = EXCLUDED.category_id;
select * from products;
6)      Write a MERGE query:
Create temp table with name:  ‘updated_products’ and insert values as below:
 
productID
	productName
	quantityPerUnit
	unitPrice
	discontinued
	categoryID
	                             100
	Wheat bread
	10
	20
	1
	5
	101
	White bread
	5 boxes
	19.99
	0
	5
	102
	Midnight Mango Fizz
	24 - 12 oz bottles
	19
	0
	1
	103
	Savory Fire Sauce
	12 - 550 ml bottles
	10
	0
	2
	 
*  Update the price and discontinued status for from below table ‘updated_products’ only if there are matching products and updated_products .discontinued =0 


* If there are matching products and updated_products .discontinued =1 then delete 
 
*  Insert any new products from updated_products that don’t exist in products only if updated_products .discontinued =0.


        CREATE TEMP TABLE updated_products (
    productID INT PRIMARY KEY,
    productName TEXT,
    quantityPerUnit TEXT,
    unitPrice NUMERIC(10, 2),
    discontinued INT,
    categoryID INT);




        INSERT INTO updated_products (productID, 
        productName, quantityPerUnit, unitPrice, discontinued, categoryID)
VALUES
    (100, 'Wheat bread', '10', 20,1,5),
    (101, 'White bread', '5 boxes', 19.99, 0, 5),
    (102, 'Midnight Mango Fizz', '24 - 12 oz bottles', 19, 0, 1),
    (103, 'Savory Fire Sauce', '12 - 550 ml bottles', 10, 0, 2)




        UPDATE public.products
        SET unit_price=updated_products.unitprice, discontinued= updated_products.discontinued
        from updated_products WHERE updated_products.discontinued=0;




  DELETE FROM products
USING updated_products
WHERE products.product_id = updated_products.productid
  AND updated_products.discontinued = 1;




insert into products (unit_price,discontinued) 
 select unitprice,discontinued 
 from updated_products 
 where discontinued=0
 AND NOT EXISTS ( Select 1
 from products
 where products.product_id=updated_products.productid)


 7) List all orders with employee full names. (Inner join)


SELECT e.first_name || ' ' || e.last_name AS full_name
FROM public.employees e
INNER JOIN orders o
ON e.employee_id = o.employee_id;