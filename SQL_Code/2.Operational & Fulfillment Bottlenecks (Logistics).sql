WITH delivery_delay AS (
SELECT 
orders.customer_id,
customers.customer_state,
order_estimated_delivery_date,
order_delivered_customer_date,
order_estimated_delivery_date - order_delivered_customer_date AS exact_delivery_delay_days,
order_estimated_delivery_date::date - order_delivered_customer_date::date AS delivery_delay_days
FROM orders
INNER JOIN customers ON orders.customer_id = customers.customer_id
WHERE order_delivered_customer_date IS NOT NULL AND order_estimated_delivery_date IS NOT NULL
ORDER BY exact_delivery_delay_days ASC
),

Count_Delay AS (
    SELECT  
    customers.customer_state,
    Count(*) AS total_orders_delayed
    From delivery_delay
    INNER JOIN customers ON delivery_delay.customer_id = customers.customer_id  
    WHERE delivery_delay_days < 0
    GROUP BY customers.customer_state
),

average_delivery_delay_days AS (
    SELECT 
    delivery_delay.customer_state,
    AVG(delivery_delay_days) AS average_delivery_delay_days
    FROM delivery_delay
    WHERE delivery_delay_days < 0
    GROUP BY delivery_delay.customer_state
),

Count_total_orders AS (
    SELECT  
    customers.customer_state,
    Count(*) AS total_orders
    From delivery_delay
    INNER JOIN customers ON delivery_delay.customer_id = customers.customer_id  
    GROUP BY customers.customer_state
)

SELECT 
Rank() OVER (ORDER BY average_delivery_delay_days.average_delivery_delay_days ASC) AS rank,
average_delivery_delay_days.customer_state,
Round(average_delivery_delay_days.average_delivery_delay_days * -1, 2) AS average_delivery_delay_days,
Count_Delay.total_orders_delayed,
Count_total_orders.total_orders
FROM average_delivery_delay_days
INNER JOIN Count_Delay ON average_delivery_delay_days.customer_state = Count_Delay.customer_state
Inner JOIN Count_total_orders ON average_delivery_delay_days.customer_state = Count_total_orders.customer_state
GROUP BY average_delivery_delay_days.customer_state,average_delivery_delay_days.average_delivery_delay_days, Count_Delay.total_orders_delayed, Count_total_orders.total_orders
Order BY average_delivery_delay_days DESC