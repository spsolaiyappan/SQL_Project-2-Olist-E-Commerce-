SELECT 
customer_state,
Sum(order_items.price) As total_revenue,
Sum(order_items.freight_value) As total_freight_cost,
Round(Avg(order_items.price), 2) As avg_product_price,
Round(Avg(order_items.freight_value), 2) As avg_freight_cost,
Concat(Round(Avg(order_items.freight_value) / Avg(order_items.price) * 100, 2), ' %') As freight_to_price_ratio
FROM customers
INNER JOIN orders ON customers.customer_id = orders.customer_id
INNER JOIN order_items ON orders.order_id = order_items.order_id
GROUP BY customer_state
ORDER BY freight_to_price_ratio DESC;