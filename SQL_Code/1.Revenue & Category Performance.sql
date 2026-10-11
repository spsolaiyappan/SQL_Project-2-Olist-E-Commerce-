-- SQL Query to get the top 20 product categories by revenue and their contribution to total revenue
WITH Revenue_Products AS (
    SELECT 
    product_categories.product_category_name,
    product_categories.product_category_name_english,
    Sum(order_items.price) AS Revenue_Products
    FROM order_items
    INNER JOIN products ON order_items.product_id = products.product_id
    INNER JOIN product_categories ON products.product_category_name = product_categories.product_category_name   
    GROUP BY product_categories.product_category_name, product_categories.product_category_name_english
    ORDER BY Revenue_Products DESC
),

Count_Products AS (
    SELECT 
    product_categories.product_category_name,
    product_categories.product_category_name_english,
    Count(order_items.product_id) AS total_products
    FROM order_items
    INNER JOIN products ON order_items.product_id = products.product_id
    INNER JOIN product_categories ON products.product_category_name = product_categories.product_category_name   
    GROUP BY product_categories.product_category_name, product_categories.product_category_name_english
    ORDER BY total_products DESC

),

Total_Platform_Revenue AS (
    SELECT 
    Sum(order_items.price) AS Gross_revenue
    FROM order_items
    INNER JOIN products ON order_items.product_id = products.product_id
    WHERE products.product_category_name IS NOT NULL
)


SELECT 
Rank() OVER (ORDER BY Sum(Revenue_Products.Revenue_Products) DESC) AS Rank,
Revenue_Products.product_category_name,
Revenue_Products.product_category_name_english,
Sum(Revenue_Products.Revenue_Products)AS Total_revenue,
Count_Products.Total_products,
Round((Sum(Revenue_Products.Revenue_Products) / (SELECT Gross_revenue FROM Total_Platform_Revenue)) * 100, 2) AS Percent_of_total_revenue
FROM Revenue_Products
INNER JOIN Count_Products ON Revenue_Products.product_category_name = Count_Products.product_category_name
GROUP BY Revenue_Products.product_category_name, Revenue_Products.product_category_name_english, Count_Products.total_products
ORDER BY total_revenue DESC
Limit 20;