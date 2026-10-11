With monthly_revenue AS (
SELECT 
 EXTRACT(YEAR FROM order_purchase_timestamp) AS year,
 EXTRACT(MONTH FROM order_purchase_timestamp) AS month,
 To_Char(order_purchase_timestamp,'Month YYYY') AS month_year,
 Sum(price) AS total_revenue,
 Count(DISTINCT order_items.order_id) AS total_unique_orders,
 Count(order_items.order_id) AS total_items_sold
FROM orders
Inner JOIN order_items ON orders.order_id = order_items.order_id
Where order_status NOT IN ('canceled', 'unavailable')
GROUP BY year, month, month_year
),

revenue_growth AS (
SELECT
month_year,
Round(LAG(total_revenue) OVER (ORDER BY year, month), 2) AS previous_month_revenue,
Round(total_revenue - LAG(total_revenue) OVER (ORDER BY year, month), 2) AS revenue_growth,
Round(((total_revenue - LAG(total_revenue) OVER (ORDER BY year, month)) /NullIF(LAG(total_revenue) OVER (ORDER BY year, month), 0)) * 100, 2) AS revenue_growth_percentage
From monthly_revenue
Group BY year, month, month_year, total_revenue
)

Select 
 monthly_revenue.month_year,
 total_revenue,
 total_unique_orders,
 total_items_sold,
 previous_month_revenue,
 revenue_growth,
 Case
 When revenue_growth_percentage > 0 AND revenue_growth_percentage <= 100 THEN CAST(revenue_growth_percentage AS VARCHAR(50))
 WHEN revenue_growth_percentage > 100 THEN 'Over 100%'
 ELSE CAST(revenue_growth_percentage AS VARCHAR(50))
 END AS revenue_growth_percentage
From monthly_revenue
Inner Join revenue_growth ON monthly_revenue.month_year = revenue_growth.month_year
GROUP BY year, month, monthly_revenue.month_year, total_revenue, total_unique_orders, total_items_sold, previous_month_revenue, revenue_growth, revenue_growth_percentage
Order By year, month