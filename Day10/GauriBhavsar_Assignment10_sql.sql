1.        Write  a function to Calculate the total stock value for a given category:
(Stock value=ROUND(SUM(unit_price * units_in_stock)::DECIMAL, 2)
Return data type is DECIMAL(10,2)


CREATE OR REPLACE FUNCTION get_stock_value(s_category_id INT)
RETURNS DECIMAL(10,2)
LANGUAGE plpgsql
AS $$
DECLARE total_stock_value DECIMAL(10,2);
BEGIN
   SELECT ROUND(SUM(unit_price * units_in_stock)::DECIMAL, 2)
   INTO total_stock_value
   FROM products p
   WHERE p.category_id = s_category_id;
   RETURN total_stock_value;
END;
$$;


SELECT get_stock_value(1);






2.        Try writing a   cursor query which I executed in the training.






CREATE OR REPLACE PROCEDURE update_prices_with_cursor()
LANGUAGE plpgsql
As $$
DECLARE
   product_cursor CURSOR FOR
     SELECT product_id,product_name,unit_price,units_in_stock
     FROM products WHERE discontinued = 0;
         
   product_record RECORD;
   v_new_price Decimal(10,2);
BEGIN
   OPEN product_cursor;
   LOOP
     FETCH product_cursor INTO product_record;
     EXIT WHEN NOT FOUND;
         IF product_record.unit_price < 10 THEN
        v_new_price:=product_record.unit_price*1.1;
         ELSE        
             v_new_price:=product_record.unit_price*0.95;
         END IF;         
  UPDATE products 
  SET unit_price = ROUND(v_new_price,2)
  WHERE product_id = product_record.product_id;
RAISE NOTICE 'Updated % price from % to % ',
  product_record.product_name,
  product_record.unit_price,
  v_new_price;
END LOOP;
CLOSE product_cursor;
END;
$$;


CALL update_prices_with_cursor();