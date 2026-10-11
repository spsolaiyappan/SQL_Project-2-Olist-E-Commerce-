With customers_orders AS (
SELECT
customers.customer_unique_id,
Count(orders.order_id) AS total_orders,
Case 
    WHEN Count(orders.order_id) = 1 THEN 'One-Time Buyer'
    ELSE 'Repeat Buyer'
END AS customer_value_segment,
Sum(order_items.price) AS total_revenue
FROM customers
Inner JOIN orders ON customers.customer_id = orders.customer_id
INNER JOIN order_items ON orders.order_id = order_items.order_id
WHERE orders.order_status ='delivered'
GROUP BY customers.customer_unique_id
ORDER BY total_orders DESC
)

SELECT
customers_orders.customer_value_segment,
Count(customers_orders.customer_unique_id) AS total_customers,
Sum(customers_orders.total_orders) AS total_orders,
Sum(customers_orders.total_revenue) AS total_revenue,
Round(AVG(customers_orders.total_revenue), 2) AS average_revenue_per_customer
From customers_orders
GROUP BY customers_orders.customer_value_segment
