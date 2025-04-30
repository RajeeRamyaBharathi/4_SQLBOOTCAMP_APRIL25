/* 1.Categorize products by stock status
(Display product_name, a new column stock_status whose values are based on below condition
 units_in_stock = 0  is 'Out of Stock'
       units_in_stock < 20  is 'Low Stock')
*/
SELECT product_name,
CASE 
	WHEN units_in_stock = 0 THEN 'Out of Stock'
	WHEN units_in_stock < 20 THEN 'Low Stock'
ELSE 'In Stock'
END AS stock_status
FROM products;


/*2.Find All Products in Beverages Category
(Subquery, Display product_name,unitprice)
*/
SELECT product_name, unit_price FROM products
INNER JOIN categories USING(category_id)
	WHERE category_name = (	SELECT category_name FROM categories WHERE category_name = 'Beverages');
	

/*3.Find Orders by Employee with Most Sales
(Display order_id,   order_date,  freight, employee_id.
Employee with Most Sales=Get the total no.of of orders for each employee then order by DESC and limit 1. Use Subquery)
*/
SELECT order_id, order_date, freight, o.employee_id FROM orders o, 
	(SELECT employee_id, COUNT(order_id) as total_orders FROM orders
		GROUP BY employee_id
		ORDER BY total_orders DESC
		LIMIT 1
	) AS most_sales
WHERE o.employee_id = most_sales.employee_id
ORDER BY order_date;



/*4.Find orders  where for country!= ‘USA’ with freight costs higher than any order from USA. 
(Subquery, Try with ANY, ALL operators)
*/
SELECT order_id, freight, ship_country FROM orders 
WHERE ship_country != 'USA' AND
freight > ALL (SELECT freight FROM orders WHERE ship_country = 'USA');

SELECT order_id, freight, ship_country FROM orders 
WHERE ship_country != 'USA' AND
freight > ANY (SELECT freight FROM orders WHERE ship_country = 'USA');