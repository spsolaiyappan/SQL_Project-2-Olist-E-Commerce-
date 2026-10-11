With payment_amount AS (
SELECT 
payments.payment_type,
SUM(payments.payment_value) AS total_amount
FROM payments
WHERE payments.payment_type != 'not_defined'
GROUP BY payments.payment_type
),
total_amount AS (
SELECT    
Sum(payment_amount.total_amount) AS overall_total
FROM payment_amount
)

SELECT 
payment_amount.payment_type,
payment_amount.total_amount,
ROUND((payment_amount.total_amount / total_amount.overall_total) * 100, 2) AS percentage_of_total
FROM payment_amount, total_amount
ORDER BY total_amount DESC;


