/*1.Write a function to Calculate the total stock value for a given category:
(Stock value=ROUND(SUM(unit_price * units_in_stock)::DECIMAL, 2)
Return data type is DECIMAL(10,2)*/
select * from products
where category_id = 5;

CREATE OR REPLACE FUNCTION total_stock_value(s_category INT)
RETURNS DECIMAL(10,2)
LANGUAGE PLPGSQL
AS
$$
DECLARE stock_value DECIMAL(10,2);
BEGIN
	SELECT ROUND(SUM(unit_price * units_in_stock)::DECIMAL,2)
	INTO stock_value
	FROM products p
	WHERE p.category_id = s_category;

	RETURN stock_value;
END;
$$;

SELECT * FROM total_stock_value(5);



--2. Try writing a cursor query which I executed in the training.
--2. Try writing a cursor query which I executed in the training.

CREATE OR REPLACE PROCEDURE update_price_with_cursor()
LANGUAGE PLPGSQL
AS $$
DECLARE 
	--Declare the cursor
		product_cursor CURSOR FOR
		SELECT product_id,product_name,unit_price,units_in_stock 
		FROM products
		WHERE discontinued = 0;
		
		product_record RECORD;
		n_new_price DECIMAL(10,2);
BEGIN
	--Open the cursor
	OPEN product_cursor;
	LOOP
		--Fetch the next row
		FETCH product_cursor INTO product_record;

		--Exit when no more rows to fetch
		EXIT WHEN NOT FOUND;

		--Calculate new price
		IF product_record.units_in_stock < 10 THEN
			n_new_price := product_record.unit_price*1.1;		--increase by 10%
		ELSE n_new_price := product_record.unit_price*0.95;	--decrease by 5%
		END IF;

		--Processing the fetched row: Here updating the products table with new_price
		UPDATE products
		SET unit_price = ROUND(n_new_price,2)
		WHERE product_id = product_record.product_id;

		--Log the change
		RAISE NOTICE 'Updated % price from % to %',
			product_record.product_name,
			product_record.unit_price,
			n_new_price;
	END LOOP;

	--Close the CURSOR
	CLOSE product_cursor;
END;
$$;

--Call the cursor
CALL update_price_with_cursor();