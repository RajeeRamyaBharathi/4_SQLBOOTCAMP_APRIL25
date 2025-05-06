set search_path = public

CREATE FUNCTION get_total_stock_value(category_id_param SMALLINT)
RETURNS DECIMAL(10,2)
LANGUAGE plpgsql
AS $$
DECLARE total_stock_value DECIMAL(10,2);
BEGIN
SELECT ROUND(SUM(unit_price * units_in_stock)::DECIMAL(10,2), 2)
INTO total_stock_value
from products p
WHERE 
p.category_id = category_id_param;

RETURN total_stock_value;
END;
$$;


SELECT get_total_stock_value(1::SMALLINT) AS total_stock_value


