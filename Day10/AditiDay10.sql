CREATE OR REPLACE FUNCTION get_category_stock_value(p_category_id INT)
RETURNS DECIMAL(10,2)
LANGUAGE plpgsql
AS $$
DECLARE
    v_total_value DECIMAL(10,2);
BEGIN
    SELECT ROUND(SUM(unit_price * units_in_stock)::DECIMAL, 2)
    INTO v_total_value
    FROM products
    WHERE category_id = p_category_id;

    RETURN COALESCE(v_total_value, 0.00);
END;

SELECT  get_category_stock_value(1);