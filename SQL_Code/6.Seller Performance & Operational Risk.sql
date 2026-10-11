With order_details AS (
SELECT
    seller_id,  
    COUNT(orders.order_id) AS total_orders,
    SUM(price) AS total_revenue,
    Round(AVG(review_score), 2) AS average_rating
FROM order_reviews
INNER JOIN order_items ON order_reviews.order_id = order_items.order_id
INNER JOIN orders ON order_items.order_id = orders.order_id
GROUP BY seller_id
ORDER BY total_revenue DESC
),
count_cancelled_orders AS (
SELECT
    seller_id,
    COUNT(orders.order_id) AS cancelled_orders
FROM orders
Inner JOIN order_items ON orders.order_id = order_items.order_id
WHERE order_status IN ('canceled', 'unavailable')
    GROUP BY seller_id
)

SELECT
    order_details.seller_id,
    total_orders,
    total_revenue,
    average_rating,
    COALESCE(cancelled_orders, 0) AS cancelled_orders,
    CASE
        WHEN total_orders > 0 THEN ROUND((COALESCE(cancelled_orders, 0) * 100.0 / total_orders), 2)
        ELSE 0
    END AS cancellation_rate_percentage
    From order_details
    Left Join count_cancelled_orders ON order_details.seller_id = count_cancelled_orders.seller_id
    GROUP BY order_details.seller_id, total_orders, total_revenue, average_rating, cancelled_orders
    ORDER BY total_revenue DESC, cancellation_rate_percentage DESC