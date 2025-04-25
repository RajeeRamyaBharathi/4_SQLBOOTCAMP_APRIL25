--7) List all orders with employee full names. (Inner join)

SELECT
  o.order_id,
  o.customer_id,
  o.order_date,
  CONCAT(e.first_name, ' ', e.last_name) AS employee_full_name
FROM orders o
INNER JOIN employees e ON o.employee_id = e.employee_id;