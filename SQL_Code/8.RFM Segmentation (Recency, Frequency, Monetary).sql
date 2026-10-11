With customer_rfm AS (
SELECT 
customer_unique_id,
Count(orders.order_id) As frequency,
Sum(order_items.price) As monetary,
Max(DATE(orders.order_purchase_timestamp)) As last_purchase_date
From customers
INNER JOIN orders ON customers.customer_id = orders.customer_id
LEFT JOIN order_items ON orders.order_id = order_items.order_id
GROUP BY customer_unique_id
),

Max_date AS (SELECT
Max(Date(order_purchase_timestamp)) As max_date
From orders),

rfm_calculated AS (
    SELECT 
        customer_unique_id,
        frequency,
        monetary,
        last_purchase_date,
        (max_date - last_purchase_date) AS recency,
        
        -- NTILE scores (5 is always the best: most recent, most frequent, highest spend)
        NTILE(5) OVER (ORDER BY (max_date - last_purchase_date) DESC) AS recency_score,
CASE 
    WHEN frequency = 1 THEN 1
    WHEN frequency BETWEEN 2 AND 3 THEN 2
    WHEN frequency BETWEEN 4 AND 5 THEN 3
    WHEN frequency BETWEEN 6 AND 8 Then 4
    WHEN frequency > 8 THEN 5
    ELSE 1
END AS frequency_score,
        NTILE(5) OVER (ORDER BY monetary ASC) AS monetary_score

    FROM customer_rfm 
    CROSS JOIN Max_date

)
SELECT 
rfm_calculated.customer_unique_id,
rfm_calculated.frequency,  
rfm_calculated.monetary,
rfm_calculated.last_purchase_date,
rfm_calculated.recency,
rfm_calculated.recency_score,
rfm_calculated.frequency_score,
rfm_calculated.monetary_score,
CASE
WHEN recency_score = 5 AND frequency_score = 5 AND monetary_score = 5 THEN 'Champions'
WHEN recency_score >= 4 AND frequency_score >= 4 AND monetary_score >= 4 THEN 'Loyal Customers'
WHEN recency_score >= 3 OR frequency_score >= 3 OR monetary_score >= 3 THEN 'Potential Loyalist'
ELSE 'At Risk'
END AS customer_segment
FROM rfm_calculated
ORDER BY recency_score DESC, frequency_score DESC, monetary_score DESC;


