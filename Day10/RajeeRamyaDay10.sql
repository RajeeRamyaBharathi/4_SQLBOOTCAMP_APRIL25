--Assignment 10
--Write a function to calculate the stock_value for a given category:(stock_value=Round(SUM(unit_price * unit_in_stock)::Decimal,2)Return data type is Decimal(10,2).
--creating a function
CREATE OR REPLACE FUNCTION get_stock_value_by_category(p_category_id INT)
RETURNS DECIMAL(10,2) AS $$
DECLARE
    stock_value DECIMAL(10,2);
BEGIN
    SELECT ROUND(SUM(unit_price * units_in_stock)::DECIMAL, 2)
    INTO stock_value
    FROM products
    WHERE category_id = p_category_id;

    RETURN COALESCE(stock_value, 0); -- Return 0 if no rows found
END;
$$ LANGUAGE plpgsql;
--calling the function
-- This will output the stock value for category with ID 3
SELECT get_stock_value_by_category(3);

--2.cursor
CREATE OR REPLACE PROCEDURE update_prices_with_cursor()
LANGUAGE plpgsql
As $$
DECLARE
product_cursor CURSOR FOR
SELECT product_id,product_name,unit_price,units_in_stock FROM products WHERE discontinued = 0;
product_record RECORD;
v_new_price Decimal(10,2);
BEGIN
OPEN product_cursor;
LOOP
 FETCH product_cursor INTO product_record;
 EXIT WHEN NOT FOUND;
v_new_price:=product_record.unit_price*0.95;
UPDATE products 
SET unit_price = ROUND(v_new_price,2)
WHERE product_id = product_record.product_id;
RAISE NOTICE 'Updated % price from % of % ',
product_record.product_name,product_record.unit_price,v_new_price;
END LOOP;
CLOSE product_cursor;
END;
$$;
--Calling the Procedure:
CALL update_prices_with_cursor();



