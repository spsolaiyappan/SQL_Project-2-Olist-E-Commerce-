With delay_days AS(
SELECT 
orders.customer_id,
orders.order_id,
CAST((Date(order_estimated_delivery_date) - Date(order_delivered_customer_date)) AS INT) AS delivery_delay
FROM orders
WHERE order_delivered_customer_date IS NOT NULL
)

SELECT 
CASE 
WHEN delivery_delay >=10 THEN 'Much Earlier'
WHEN delivery_delay <= 9 AND delivery_delay >= 0 THEN 'Early / On Time'
WHEN delivery_delay <= -1 AND delivery_delay >= -15 THEN 'Late by 1-15 days'
WHEN delivery_delay <= -16 AND delivery_delay >= -30 THEN 'Late by approx a month'
WHEN delivery_delay <= -31  THEN 'Late by 1+ months'
ELSE 'N/A'
END AS categories,
Count(delay_days.order_id) AS total_orders,
Round(AVG(review_score),2) AS average_rating
FROM delay_days
Left JOIN order_reviews ON order_reviews.order_id = delay_days.order_id
GROUP BY categories
ORDER BY average_rating


